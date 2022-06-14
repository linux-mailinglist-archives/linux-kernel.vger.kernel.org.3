Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E1854BD45
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 00:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357803AbiFNWE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 18:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234419AbiFNWES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 18:04:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F56D3EF0B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 15:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655244256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x10p2RYJ/7U/x7uwqRvY5a/J+6w+5v/qLg41hZfOPsk=;
        b=Juu50PNFOLgKGUxby69CaIkgXG4lKJH9nd9Nef+SsdgUIkdib/WosXFCw48ZxIYeZI5+xH
        DydXfRAV3D6yb/yblJBQdAn5iqHs79ZvmLlSPha9XctzkujbVdvkkOldpWRD43Z1kRlIUa
        UtHS0cNxO5l4o7U6n1WHhYnvVMho3I0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-dTAbzv03O6COUgz8sHXMEw-1; Tue, 14 Jun 2022 18:04:15 -0400
X-MC-Unique: dTAbzv03O6COUgz8sHXMEw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 046693C021AA;
        Tue, 14 Jun 2022 22:04:15 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B55A9492CA2;
        Tue, 14 Jun 2022 22:04:14 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 3/3] mm/kmemleak: Prevent soft lockup in first object iteration loop of kmemleak_scan()
Date:   Tue, 14 Jun 2022 18:03:59 -0400
Message-Id: <20220614220359.59282-4-longman@redhat.com>
In-Reply-To: <20220614220359.59282-1-longman@redhat.com>
References: <20220614220359.59282-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first RCU-based object iteration loop has to modify the object
count. So we cannot skip taking the object lock.

One way to avoid soft lockup is to insert occasional cond_resched()
call into the loop. This cannot be done while holding the RCU read
lock which is to protect objects from being freed. However, taking a
reference to the object will prevent it from being freed. We can then
do a cond_resched() call after every 64k objects safely.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/kmemleak.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 7dd64139a7c7..abba063ae5ee 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1417,12 +1417,16 @@ static void kmemleak_scan(void)
 	struct zone *zone;
 	int __maybe_unused i;
 	int new_leaks = 0;
+	int loop1_cnt = 0;
 
 	jiffies_last_scan = jiffies;
 
 	/* prepare the kmemleak_object's */
 	rcu_read_lock();
 	list_for_each_entry_rcu(object, &object_list, object_list) {
+		bool obj_pinned = false;
+
+		loop1_cnt++;
 		raw_spin_lock_irq(&object->lock);
 #ifdef DEBUG
 		/*
@@ -1437,10 +1441,32 @@ static void kmemleak_scan(void)
 #endif
 		/* reset the reference count (whiten the object) */
 		object->count = 0;
-		if (color_gray(object) && get_object(object))
+		if (color_gray(object) && get_object(object)) {
 			list_add_tail(&object->gray_list, &gray_list);
+			obj_pinned = true;
+		}
 
 		raw_spin_unlock_irq(&object->lock);
+
+		/*
+		 * Do a cond_resched() to avoid soft lockup every 64k objects.
+		 * Make sure a reference has been taken so that the object
+		 * won't go away without RCU read lock.
+		 */
+		if (!(loop1_cnt & 0xffff)) {
+			if (!obj_pinned && !get_object(object)) {
+				/* Try the next object instead */
+				loop1_cnt--;
+				continue;
+			}
+
+			rcu_read_unlock();
+			cond_resched();
+			rcu_read_lock();
+
+			if (!obj_pinned)
+				put_object(object);
+		}
 	}
 	rcu_read_unlock();
 
-- 
2.31.1

