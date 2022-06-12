Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57FC547B78
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 20:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbiFLSds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 14:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbiFLSdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 14:33:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7A92DAF
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 11:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655058792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XR7KB+0VWMpvWvXRkdA4FDcU+xomfv79CCDTuY4yKdw=;
        b=CJbD2Zg1VsdjtH6iIZRnG+/Yu6+MzU8ZqF1HmjJUM4fcUjgT7TjwEUPQJhlWZAdS5WdmQg
        8cwAdEwo7B0/ZQ/F6xfSZDZisLgFKzGv1q56S5JrYNX/8wbHUjRQAFC8916qjhyKatQMEo
        sjPUrslsqY3HnheAkmxF6aLB1KDgYaY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-373-XB4a8fA1NSuW2fTRQfxo-Q-1; Sun, 12 Jun 2022 14:33:09 -0400
X-MC-Unique: XB4a8fA1NSuW2fTRQfxo-Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B9133C02B7F;
        Sun, 12 Jun 2022 18:33:09 +0000 (UTC)
Received: from llong.com (unknown [10.22.8.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E76E440C1247;
        Sun, 12 Jun 2022 18:33:08 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 2/3] mm/kmemleak: Skip unlikely objects in kmemleak_scan() without taking lock
Date:   Sun, 12 Jun 2022 14:33:00 -0400
Message-Id: <20220612183301.981616-3-longman@redhat.com>
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

There are 3 RCU-based object iteration loops in kmemleak_scan(). Because
of the need to take RCU read lock, we can't insert cond_resched() into
the loop like other parts of the function. As there can be millions of
objects to be scanned, it takes a while to iterate all of them. The
kmemleak functionality is usually enabled in a debug kernel which is
much slower than a non-debug kernel. With sufficient number of kmemleak
objects, the time to iterate them all may exceed 22s causing soft lockup.

  watchdog: BUG: soft lockup - CPU#3 stuck for 22s! [kmemleak:625]

In this particular bug report, the soft lockup happen in the 2nd
iteration loop.

In the 2nd and 3rd loops, most of the objects are checked and then
skipped under the object lock. Only a selected fews are modified. Those
objects certainly need lock protection. However, the lock/unlock
operation is slow especially with interrupt disabling and enabling
included.

We can actually do some basic check like color_white() without taking
the lock and skip the object accordingly. Of course, this kind of check
is racy and may miss objects that are being modified concurrently. The
cost of missed objects, however, is just that they will be discovered in
the next scan instead. The advantage of doing so is that iteration can
be done much faster especially with LOCKDEP enabled in a debug kernel.

With a debug kernel running on a 2-socket 96-thread x86-64 system
(HZ=1000), the 2nd and 3rd iteration loops speedup with this patch on
the first kmemleak_scan() call after bootup is shown in the table below.

                   Before patch                    After patch
  Loop #    # of objects  Elapsed time     # of objects  Elapsed time
  ------    ------------  ------------     ------------  ------------
    2        2,599,850      2.392s          2,596,364       0.266s
    3        2,600,176      2.171s          2,597,061       0.260s

This patch reduces loop iteration times by about 88%. This will greatly
reduce the chance of a soft lockup happening in the 2nd or 3rd iteration
loops.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/kmemleak.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index dad9219c972c..7dd64139a7c7 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1508,6 +1508,13 @@ static void kmemleak_scan(void)
 	 */
 	rcu_read_lock();
 	list_for_each_entry_rcu(object, &object_list, object_list) {
+		/*
+		 * This is racy but we can save the overhead of lock/unlock
+		 * calls. The missed objects, if any, should be caught in
+		 * the next scan.
+		 */
+		if (!color_white(object))
+			continue;
 		raw_spin_lock_irq(&object->lock);
 		if (color_white(object) && (object->flags & OBJECT_ALLOCATED)
 		    && update_checksum(object) && get_object(object)) {
@@ -1535,6 +1542,13 @@ static void kmemleak_scan(void)
 	 */
 	rcu_read_lock();
 	list_for_each_entry_rcu(object, &object_list, object_list) {
+		/*
+		 * This is racy but we can save the overhead of lock/unlock
+		 * calls. The missed objects, if any, should be caught in
+		 * the next scan.
+		 */
+		if (!color_white(object))
+			continue;
 		raw_spin_lock_irq(&object->lock);
 		if (unreferenced_object(object) &&
 		    !(object->flags & OBJECT_REPORTED)) {
-- 
2.31.1

