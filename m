Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30164D0E52
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 04:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243538AbiCHDbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 22:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbiCHDbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 22:31:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C9D92D1F2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 19:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646710246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LNwVCeJy2W4936L8AHDamoyiB9luRsDhmFKbaQe32xM=;
        b=L2aPnzBICgN2OLSCrYL4liETyue3K1fuz5bwIj/u9+lhc3os4wlVRe/v6HmTlUcbC5Z38k
        JSfOou/f09uL1/iTLR2ki0hP5gacKzBKspV+0pIJfsfjzcRdxsqXiMYhOdLp/oPa5neGJx
        WmyNENk+FPY02M06nSF/U95qLYsWU64=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-179-2VisahEoNqykJaONccaTrQ-1; Mon, 07 Mar 2022 22:30:45 -0500
X-MC-Unique: 2VisahEoNqykJaONccaTrQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB7C01006AA8;
        Tue,  8 Mar 2022 03:30:43 +0000 (UTC)
Received: from llong.com (unknown [10.22.10.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BCCA06AB87;
        Tue,  8 Mar 2022 03:30:27 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] mm/list_lru: Optimize memcg_drain_list_lru_node()
Date:   Mon,  7 Mar 2022 22:30:09 -0500
Message-Id: <20220308033009.1400464-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 2c80cd57c743 ("mm/list_lru.c: fix list_lru_count_node()
to be race free"), we are tracking the total number of lru
entries in a list_lru_node in its nr_items field.  In the case of
memcg_drain_list_lru_node(), there is nothing to be done if nr_items
is 0.  We don't even need to take the nlru->lock as no new lru entry
could be added by a racing list_lru_add() to the draining src_idx memcg
at this point.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/list_lru.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 0cd5e89ca063..100ca453e885 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -518,6 +518,12 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 	int dst_idx = dst_memcg->kmemcg_id;
 	struct list_lru_one *src, *dst;
 
+	/*
+	 * If there is no lru entry in this nlru, we can skip it immediately.
+	 */
+	if (!READ_ONCE(nlru->nr_items))
+		return;
+
 	/*
 	 * Since list_lru_{add,del} may be called under an IRQ-safe lock,
 	 * we have to use IRQ-safe primitives here to avoid deadlock.
-- 
2.27.0

