Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B834ECA9E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 19:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349274AbiC3R2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 13:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245162AbiC3R2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 13:28:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF810201A4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648661220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=J0Zkf1FnfxfcI2nPQ4sDNYlJ/HJW/82S+akVEvMwcw0=;
        b=AkzOVe1hC0UxuJ4tpcYQS1AD3dHDWoVQNUuVdhYkM31jx/TZtlKTYSkOmGOeQI2oIqAAVG
        2YYuoINF37s4RFv+lU8ZEJ1QAhIW95kODKMnbu0IXuCT9456w6ZzJGqU4pMcFnBHevixas
        p0fcBUk3m6gRpV97R2WPD72Ta4x5JDE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-384-0ohhkZM3PR-RGzimURPoBQ-1; Wed, 30 Mar 2022 13:26:54 -0400
X-MC-Unique: 0ohhkZM3PR-RGzimURPoBQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7F835803CB8;
        Wed, 30 Mar 2022 17:26:54 +0000 (UTC)
Received: from llong.com (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 463BD401E3A;
        Wed, 30 Mar 2022 17:26:54 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2] mm/list_lru: Fix possible race in memcg_reparent_list_lru_node()
Date:   Wed, 30 Mar 2022 13:26:46 -0400
Message-Id: <20220330172646.2687555-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Muchun Song found out there could be a race between list_lru_add()
and memcg_reparent_list_lru_node() causing the later function to miss
reparenting of a lru entry as shown below:

CPU0:                           CPU1:
list_lru_add()
    spin_lock(&nlru->lock)
    l = list_lru_from_kmem(memcg)
                                memcg_reparent_objcgs(memcg)
                                memcg_reparent_list_lrus(memcg)
                                    memcg_reparent_list_lru()
                                        memcg_reparent_list_lru_node()
                                            if (!READ_ONCE(nlru->nr_items))
                                                // Miss reparenting
                                                return
    // Assume 0->1
    l->nr_items++
    // Assume 0->1
    nlru->nr_items++

Though it is not likely that a list_lru_node that has 0 item suddenly
has a newly added lru entry at the end of its life. The race is still
theoretically possible.

With the lock/unlock pair used within the percpu_ref_kill() which is
the last function call of memcg_reparent_objcgs(), any read issued
in memcg_reparent_list_lru_node() will not be reordered before the
reparenting of objcgs.

Adding a !spin_is_locked()/smp_rmb()/!READ_ONCE(nlru->nr_items) check
to ensure that either the reading of nr_items is valid or the racing
list_lru_add() will see the reparented objcg.

Fixes: 405cc51fc104 ("mm/list_lru: optimize memcg_reparent_list_lru_node()")
Reported-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/list_lru.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index c669d87001a6..08ff54ffabd6 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -395,10 +395,33 @@ static void memcg_reparent_list_lru_node(struct list_lru *lru, int nid,
 	struct list_lru_one *src, *dst;
 
 	/*
-	 * If there is no lru entry in this nlru, we can skip it immediately.
+	 * With the lock/unlock pair used within the percpu_ref_kill()
+	 * which is the last function call of memcg_reparent_objcgs(), any
+	 * read issued here will not be reordered before the reparenting
+	 * of objcgs.
+	 *
+	 * Assuming a racing list_lru_add():
+	 * list_lru_add()
+	 *				<- memcg_reparent_list_lru_node()
+	 *   spin_lock(&nlru->lock)
+	 *   l = list_lru_from_kmem(memcg)
+	 *   nlru->nr_items++
+	 *   spin_unlock(&nlru->lock)
+	 *				<- memcg_reparent_list_lru_node()
+	 *
+	 * The !spin_is_locked(&nlru->lock) check is true means it is
+	 * either before the spin_lock() or after the spin_unlock(). In the
+	 * former case, list_lru_add() will see the reparented objcg and so
+	 * won't touch the lru to be reparented. In the later case, it will
+	 * see the updated nr_items. So we can use the optimization that if
+	 * there is no lru entry in this nlru, skip it immediately.
 	 */
-	if (!READ_ONCE(nlru->nr_items))
-		return;
+	if (!spin_is_locked(&nlru->lock)) {
+		/* nr_items read must be ordered after nlru->lock */
+		smp_rmb();
+		if (!READ_ONCE(nlru->nr_items))
+			return;
+	}
 
 	/*
 	 * Since list_lru_{add,del} may be called under an IRQ-safe lock,
@@ -407,7 +430,7 @@ static void memcg_reparent_list_lru_node(struct list_lru *lru, int nid,
 	spin_lock_irq(&nlru->lock);
 
 	src = list_lru_from_memcg_idx(lru, nid, src_idx);
-	if (!src)
+	if (!src || !src->nr_items)
 		goto out;
 	dst = list_lru_from_memcg_idx(lru, nid, dst_idx);
 
-- 
2.27.0

