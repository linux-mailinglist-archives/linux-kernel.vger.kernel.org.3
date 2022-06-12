Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55D3547B76
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 20:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbiFLSdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 14:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbiFLSdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 14:33:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43300DB2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 11:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655058793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FdK93Bs6pIhqQZAR3Lfyy5PxJORXQ5zTxPlLV5rbOn4=;
        b=XU9oOaZwE3AKKFTKsJyWui+WVDumFP1UNZzcWplI6uKAoh40lj3/wAnpcwgiSwdUcDUfV0
        PpOhPqdxHapl39ssqrrqtx4NQZ0Kq/fAVrqslSq0hTepBTYPnkcTKLekYVEC3Mn1IddH7D
        iqX5IzksyQRwsZ/Rn18QehFG0496cws=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-262-S9FGuFeAOLaowJXG-QadEg-1; Sun, 12 Jun 2022 14:33:09 -0400
X-MC-Unique: S9FGuFeAOLaowJXG-QadEg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D5B7101A54E;
        Sun, 12 Jun 2022 18:33:09 +0000 (UTC)
Received: from llong.com (unknown [10.22.8.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3729A40D282F;
        Sun, 12 Jun 2022 18:33:09 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 3/3] mm/kmemleak: Prevent soft lockup in first object iteration loop of kmemleak_scan()
Date:   Sun, 12 Jun 2022 14:33:01 -0400
Message-Id: <20220612183301.981616-4-longman@redhat.com>
In-Reply-To: <20220612183301.981616-1-longman@redhat.com>
References: <20220612183301.981616-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first RCU-based object iteration loop has to put almost all the
objects into the gray list and so cannot skip taking the object lock.

One way to avoid soft lockup is to insert occasional cond_resched()
into the loop. This cannot be done while holding the RCU read lock
which is to protect objects from removal. However, putting an object
into the gray list means getting a reference to the object. That will
prevent the object from removal as well without the need to hold the
RCU read lock. So insert a cond_resched() call after every 64k objects
are put into the gray list.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/kmemleak.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 7dd64139a7c7..a7c42e134fa1 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1417,12 +1417,15 @@ static void kmemleak_scan(void)
 	struct zone *zone;
 	int __maybe_unused i;
 	int new_leaks = 0;
+	int gray_list_cnt = 0;
 
 	jiffies_last_scan = jiffies;
 
 	/* prepare the kmemleak_object's */
 	rcu_read_lock();
 	list_for_each_entry_rcu(object, &object_list, object_list) {
+		bool object_pinned = false;
+
 		raw_spin_lock_irq(&object->lock);
 #ifdef DEBUG
 		/*
@@ -1437,10 +1440,25 @@ static void kmemleak_scan(void)
 #endif
 		/* reset the reference count (whiten the object) */
 		object->count = 0;
-		if (color_gray(object) && get_object(object))
+		if (color_gray(object) && get_object(object)) {
 			list_add_tail(&object->gray_list, &gray_list);
+			gray_list_cnt++;
+			object_pinned = true;
+		}
 
 		raw_spin_unlock_irq(&object->lock);
+
+		/*
+		 * With object pinned by a positive reference count, it
+		 * won't go away and we can safely release the RCU read
+		 * lock and do a cond_resched() to avoid soft lockup every
+		 * 64k objects.
+		 */
+		if (object_pinned && !(gray_list_cnt & 0xffff)) {
+			rcu_read_unlock();
+			cond_resched();
+			rcu_read_lock();
+		}
 	}
 	rcu_read_unlock();
 
-- 
2.31.1

