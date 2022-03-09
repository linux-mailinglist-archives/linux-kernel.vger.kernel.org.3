Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E13B4D26D8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiCIBY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiCIBYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:24:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB12B88B12
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 17:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646788912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nV4GRpStkpO5VfL46as7OZwqVIQe7oioYpcS1Mj59Gs=;
        b=dx7ljMZAljENXRGqst6LBtSKBn5UxVMTJPqeCeHwxMebUUj6sJTqECWpKoCRuj1ugqdlfW
        gvh8ywnK63voos7KRuOZtA5S9SGC2W3tmMX5hmn4gnKYJefoAQXMBfxYa8tFEXmqBQqzVH
        Dmb0NliqEfPt8cGHllqYVQQ4wQe5EGk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-348-h5UvBlBROUqBUVPHHfKu2w-1; Tue, 08 Mar 2022 20:18:39 -0500
X-MC-Unique: h5UvBlBROUqBUVPHHfKu2w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7224D1091DA1;
        Wed,  9 Mar 2022 01:18:38 +0000 (UTC)
Received: from llong.com (unknown [10.22.11.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 930495D98D;
        Wed,  9 Mar 2022 01:18:34 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-mm v2] mm/list_lru: Optimize memcg_reparent_list_lru_node()
Date:   Tue,  8 Mar 2022 20:18:24 -0500
Message-Id: <20220309011824.1454619-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
memcg_reparent_list_lru_node(), there is nothing to be done if nr_items
is 0.  We don't even need to take the nlru->lock as no new lru entry
could be added by a racing list_lru_add() to the draining src_idx memcg
at this point.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/list_lru.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index ba76428ceece..c669d87001a6 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -394,6 +394,12 @@ static void memcg_reparent_list_lru_node(struct list_lru *lru, int nid,
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

