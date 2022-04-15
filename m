Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EF5502EC1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 20:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346810AbiDOSha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 14:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243945AbiDOSh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 14:37:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB451EC7E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 11:34:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C0C0612CA
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 18:34:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24888C385A5;
        Fri, 15 Apr 2022 18:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1650047698;
        bh=CHJOi0QikcLS+zbx9WMqbgiw520KeIq70nFT8T9pZvE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mTIddQFCF2meMRyoQtshjWg/omYfycmOtZ+d1O4m0LVYZT8iK3E6TV9LZHq73j+DZ
         tW9FiaW1sIg7hKrR+kQ4i1erxbPToQx6eEIxcmrx6jJbCToDVgFtZjIJcgRg5+WHbR
         dKIsU5lv6SgRqo5LgW7W5BIci6aNhf0SzY/8MEuM=
Date:   Fri, 15 Apr 2022 11:34:56 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] kasan: Fix sleeping function called from invalid
 context on RT kernel
Message-Id: <20220415113456.2f24660a610e4f35fd72970a@linux-foundation.org>
In-Reply-To: <20220401134649.2222485-1-qiang1.zhang@intel.com>
References: <20220401134649.2222485-1-qiang1.zhang@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 Apr 2022 21:46:49 +0800 Zqiang <qiang1.zhang@intel.com> wrote:

> When the kmem_cache_shrink() be called, the IPI was triggered, the
> ___cache_free() is called in IPI interrupt context, the local-lock
> or spin-lock will be acquired. on PREEMPT_RT kernel, these lock is
> replaced with sleepbale rt-spinlock, so the above problem is triggered.
> fix it by move the qlist_free_allfrom() the IPI interrupt context
> to the task context when PREEMPT_RT is enabled.

This patch is rather ifdeffy so I propose the below cleanup.  Please
review and test?

Note that it incorporates the changes from your
https://lkml.kernel.org/r/20220414025925.2423818-1-qiang1.zhang@intel.com

btw, how are we supposed to test PREEMPT_RT builds?  I had to patch
arch/Kconfig.

--- a/mm/kasan/quarantine.c~kasan-fix-sleeping-function-called-from-invalid-context-on-rt-kernel-fix
+++ a/mm/kasan/quarantine.c
@@ -319,28 +319,37 @@ static void qlist_move_cache(struct qlis
 	}
 }
 
-static void per_cpu_remove_cache(void *arg)
+#ifndef CONFIG_PREEMPT_RT
+static void __per_cpu_remove_cache(struct qlist_head *q, void *arg)
 {
 	struct kmem_cache *cache = arg;
-	struct qlist_head *q;
-#ifndef CONFIG_PREEMPT_RT
 	struct qlist_head to_free = QLIST_INIT;
-#else
-	unsigned long flags;
-	struct cpu_shrink_qlist *sq;
-#endif
-	q = this_cpu_ptr(&cpu_quarantine);
-#ifndef CONFIG_PREEMPT_RT
-	if (READ_ONCE(q->offline))
-		return;
+
 	qlist_move_cache(q, &to_free, cache);
 	qlist_free_all(&to_free, cache);
+}
 #else
+static void __per_cpu_remove_cache(struct qlist_head *q, void *arg)
+{
+	struct kmem_cache *cache = arg;
+	unsigned long flags;
+	struct cpu_shrink_qlist *sq;
+
 	sq = this_cpu_ptr(&shrink_qlist);
 	raw_spin_lock_irqsave(&sq->lock, flags);
 	qlist_move_cache(q, &sq->qlist, cache);
 	raw_spin_unlock_irqrestore(&sq->lock, flags);
+}
 #endif
+
+static void per_cpu_remove_cache(void *arg)
+{
+	struct qlist_head *q;
+
+	q = this_cpu_ptr(&cpu_quarantine);
+	if (READ_ONCE(q->offline))
+		return;
+	__per_cpu_remove_cache(q, arg);
 }
 
 /* Free all quarantined objects belonging to cache. */
@@ -348,10 +357,6 @@ void kasan_quarantine_remove_cache(struc
 {
 	unsigned long flags, i;
 	struct qlist_head to_free = QLIST_INIT;
-#ifdef CONFIG_PREEMPT_RT
-	int cpu;
-	struct cpu_shrink_qlist *sq;
-#endif
 
 	/*
 	 * Must be careful to not miss any objects that are being moved from
@@ -363,13 +368,18 @@ void kasan_quarantine_remove_cache(struc
 	on_each_cpu(per_cpu_remove_cache, cache, 1);
 
 #ifdef CONFIG_PREEMPT_RT
-	for_each_online_cpu(cpu) {
-		sq = per_cpu_ptr(&shrink_qlist, cpu);
-		raw_spin_lock_irqsave(&sq->lock, flags);
-		qlist_move_cache(&sq->qlist, &to_free, cache);
-		raw_spin_unlock_irqrestore(&sq->lock, flags);
+	{
+		int cpu;
+		struct cpu_shrink_qlist *sq;
+
+		for_each_online_cpu(cpu) {
+			sq = per_cpu_ptr(&shrink_qlist, cpu);
+			raw_spin_lock_irqsave(&sq->lock, flags);
+			qlist_move_cache(&sq->qlist, &to_free, cache);
+			raw_spin_unlock_irqrestore(&sq->lock, flags);
+		}
+		qlist_free_all(&to_free, cache);
 	}
-	qlist_free_all(&to_free, cache);
 #endif
 
 	raw_spin_lock_irqsave(&quarantine_lock, flags);
_

