Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BDB54BD43
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 00:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358384AbiFNWEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 18:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355537AbiFNWEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 18:04:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1E283EF0B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 15:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655244260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A77y1Lb+c0CpuBJ2A6h47CxYcHUb1O0vwhwXfFK1d3U=;
        b=FatyXsOIZ9jB2N7UoL2Vo3y+P0+F5w5GNHuETrEspcYKJfvcu5R+1pV7nlj3h1qU8iHe1S
        gu8my+6XUlkeZPKmbnKVjFtsbR+WxofCYcRt171LcIvaoljBnbIeCzrpeBPqyqzC49V0iR
        yTMB9eAjVDoFbUbr3OO0U7gC6ENREQc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-7YOsaToPPyuNnrqUVU661A-1; Tue, 14 Jun 2022 18:04:14 -0400
X-MC-Unique: 7YOsaToPPyuNnrqUVU661A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A1933C021A9;
        Tue, 14 Jun 2022 22:04:14 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 185B5492CA2;
        Tue, 14 Jun 2022 22:04:14 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 1/3] mm/kmemleak: Use _irq lock/unlock variants in kmemleak_scan/_clear()
Date:   Tue, 14 Jun 2022 18:03:57 -0400
Message-Id: <20220614220359.59282-2-longman@redhat.com>
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

The kmemleak_scan() function is called only from the kmemleak scan
thread or from write to the kmemleak debugfs file. Both are in task
context and so we can directly use the simpler _irq() lock/unlock calls
instead of the more complex _irqsave/_irqrestore variants.

Similarly, kmemleak_clear() is called only from write to the kmemleak
debugfs file. The same change can be applied.

Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 mm/kmemleak.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index a182f5ddaf68..dad9219c972c 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1413,7 +1413,6 @@ static void scan_gray_list(void)
  */
 static void kmemleak_scan(void)
 {
-	unsigned long flags;
 	struct kmemleak_object *object;
 	struct zone *zone;
 	int __maybe_unused i;
@@ -1424,7 +1423,7 @@ static void kmemleak_scan(void)
 	/* prepare the kmemleak_object's */
 	rcu_read_lock();
 	list_for_each_entry_rcu(object, &object_list, object_list) {
-		raw_spin_lock_irqsave(&object->lock, flags);
+		raw_spin_lock_irq(&object->lock);
 #ifdef DEBUG
 		/*
 		 * With a few exceptions there should be a maximum of
@@ -1441,7 +1440,7 @@ static void kmemleak_scan(void)
 		if (color_gray(object) && get_object(object))
 			list_add_tail(&object->gray_list, &gray_list);
 
-		raw_spin_unlock_irqrestore(&object->lock, flags);
+		raw_spin_unlock_irq(&object->lock);
 	}
 	rcu_read_unlock();
 
@@ -1509,14 +1508,14 @@ static void kmemleak_scan(void)
 	 */
 	rcu_read_lock();
 	list_for_each_entry_rcu(object, &object_list, object_list) {
-		raw_spin_lock_irqsave(&object->lock, flags);
+		raw_spin_lock_irq(&object->lock);
 		if (color_white(object) && (object->flags & OBJECT_ALLOCATED)
 		    && update_checksum(object) && get_object(object)) {
 			/* color it gray temporarily */
 			object->count = object->min_count;
 			list_add_tail(&object->gray_list, &gray_list);
 		}
-		raw_spin_unlock_irqrestore(&object->lock, flags);
+		raw_spin_unlock_irq(&object->lock);
 	}
 	rcu_read_unlock();
 
@@ -1536,7 +1535,7 @@ static void kmemleak_scan(void)
 	 */
 	rcu_read_lock();
 	list_for_each_entry_rcu(object, &object_list, object_list) {
-		raw_spin_lock_irqsave(&object->lock, flags);
+		raw_spin_lock_irq(&object->lock);
 		if (unreferenced_object(object) &&
 		    !(object->flags & OBJECT_REPORTED)) {
 			object->flags |= OBJECT_REPORTED;
@@ -1546,7 +1545,7 @@ static void kmemleak_scan(void)
 
 			new_leaks++;
 		}
-		raw_spin_unlock_irqrestore(&object->lock, flags);
+		raw_spin_unlock_irq(&object->lock);
 	}
 	rcu_read_unlock();
 
@@ -1748,15 +1747,14 @@ static int dump_str_object_info(const char *str)
 static void kmemleak_clear(void)
 {
 	struct kmemleak_object *object;
-	unsigned long flags;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(object, &object_list, object_list) {
-		raw_spin_lock_irqsave(&object->lock, flags);
+		raw_spin_lock_irq(&object->lock);
 		if ((object->flags & OBJECT_REPORTED) &&
 		    unreferenced_object(object))
 			__paint_it(object, KMEMLEAK_GREY);
-		raw_spin_unlock_irqrestore(&object->lock, flags);
+		raw_spin_unlock_irq(&object->lock);
 	}
 	rcu_read_unlock();
 
-- 
2.31.1

