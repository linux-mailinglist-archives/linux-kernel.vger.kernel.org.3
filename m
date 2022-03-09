Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF314D3126
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 15:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbiCIOlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 09:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbiCIOlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 09:41:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9418E17DBA4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 06:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646836845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=iKrxniM/I2fRAZ4xvjCSNRsrqJfTXUyCI1qAfWRyj+Q=;
        b=BjL7tEVO6Bn9DbQybj9+kX6BmyAqeODi+Ub2osloNZ52DySnD2xibyF3PtrtVgQU0z3Fww
        jdsyKBO/SP5893qIoDIrxz/fi2JBpEXF5S0TmCaK1ZWV4v3++XOx7FZFnC3e5fts7QEZuL
        hnZmBZkAIMA05WeF/OBRopmT8zpe6f0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-107-oYK2rERPO8ydtrlNHqDzJA-1; Wed, 09 Mar 2022 09:40:42 -0500
X-MC-Unique: oYK2rERPO8ydtrlNHqDzJA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 188B91006AB1;
        Wed,  9 Mar 2022 14:40:41 +0000 (UTC)
Received: from llong.com (unknown [10.22.18.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9247923762;
        Wed,  9 Mar 2022 14:40:26 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-mm v3] mm/list_lru: Optimize memcg_reparent_list_lru_node()
Date:   Wed,  9 Mar 2022 09:40:00 -0500
Message-Id: <20220309144000.1470138-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

On systems that serve a lot of containers, it is possible that there can
be thousands of list_lru's present due to the fact that each container
may mount its own container specific filesystems. As a typical container
uses only a few cpus, it is likely that only the list_lru_node that
contains those cpus will be utilized while the rests may be empty. In
other words, there can be a lot of list_lru_node with 0 nr_items. By
skipping a lock/unlock operation and loading a cacheline from memcg_lrus,
a sizeable number of cpu cycles can be saved. That can be substantial
if we are talking about thousands of list_lru_node's with 0 nr_items.

Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
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

