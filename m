Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A469507A59
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 21:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354642AbiDSThu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 15:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354562AbiDSThc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 15:37:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7042BE47;
        Tue, 19 Apr 2022 12:34:48 -0700 (PDT)
Date:   Tue, 19 Apr 2022 19:34:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650396886;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4By39Zx+Sp4N6rN9AxawR4v/Be2Kj3yLRJ69iBAZCYg=;
        b=OB6acdsfvUcuBKKsuojRPfuofwc3eMOqCsbvhEnc/ba1UqGFRMhsS7DNKtXHoY5n2ys8Si
        GbOw0Jf1KujAtwntxI7pZ99AhungFHcbRcsr5uBNQTCtmGbt82qwW71C/vtG4nagDCFtjk
        +ifJc29Ti74VbsaZ1VoecSAJv8LTK+pnInfemzx0cr/+frMG2rVv5y6GH7Xsnu82rYxoW0
        Rb1feqnYF8nL1lbTmIHIgCwHQ+ybutGg5MxvGzQgVXdsRjsrq4SMX6kSyeYyvCjN0nLlD4
        Z8gAJrZ+LX0U+XYnyqT6dTZ8hG6yAvPg04oJbBH8EWpsGSRhkPOrDkx1TJSMLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650396886;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4By39Zx+Sp4N6rN9AxawR4v/Be2Kj3yLRJ69iBAZCYg=;
        b=oI+zT5pCDBRYf9vsmz9NPEXcA01wTSwl3FPZdkpmJAATPu8pGFV+bPzoDseyaBu8raUkMV
        aBDV/pPbrkJUsNAg==
From:   "tip-bot2 for Zhipeng Xie" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: Fix perf_mmap fail when
 CONFIG_PERF_USE_VMALLOC enabled
Cc:     Zhipeng Xie <xiezhipeng1@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220209145417.6495-1-xiezhipeng1@huawei.com>
References: <20220209145417.6495-1-xiezhipeng1@huawei.com>
MIME-Version: 1.0
Message-ID: <165039688484.4207.14509998247013429471.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     60490e7966659b26d74bf1fa4aa8693d9a94ca88
Gitweb:        https://git.kernel.org/tip/60490e7966659b26d74bf1fa4aa8693d9a94ca88
Author:        Zhipeng Xie <xiezhipeng1@huawei.com>
AuthorDate:    Wed, 09 Feb 2022 09:54:17 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 19 Apr 2022 21:15:42 +02:00

perf/core: Fix perf_mmap fail when CONFIG_PERF_USE_VMALLOC enabled

This problem can be reproduced with CONFIG_PERF_USE_VMALLOC enabled on
both x86_64 and aarch64 arch when using sysdig -B(using ebpf)[1].
sysdig -B works fine after rebuilding the kernel with
CONFIG_PERF_USE_VMALLOC disabled.

I tracked it down to the if condition event->rb->nr_pages != nr_pages
in perf_mmap is true when CONFIG_PERF_USE_VMALLOC is enabled where
event->rb->nr_pages = 1 and nr_pages = 2048 resulting perf_mmap to
return -EINVAL. This is because when CONFIG_PERF_USE_VMALLOC is
enabled, rb->nr_pages is always equal to 1.

Arch with CONFIG_PERF_USE_VMALLOC enabled by default:
	arc/arm/csky/mips/sh/sparc/xtensa

Arch with CONFIG_PERF_USE_VMALLOC disabled by default:
	x86_64/aarch64/...

Fix this problem by using data_page_nr()

[1] https://github.com/draios/sysdig

Fixes: 906010b2134e ("perf_event: Provide vmalloc() based mmap() backing")
Signed-off-by: Zhipeng Xie <xiezhipeng1@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220209145417.6495-1-xiezhipeng1@huawei.com
---
 kernel/events/core.c        | 2 +-
 kernel/events/internal.h    | 5 +++++
 kernel/events/ring_buffer.c | 5 -----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 23bb197..7858baf 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6247,7 +6247,7 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 again:
 	mutex_lock(&event->mmap_mutex);
 	if (event->rb) {
-		if (event->rb->nr_pages != nr_pages) {
+		if (data_page_nr(event->rb) != nr_pages) {
 			ret = -EINVAL;
 			goto unlock;
 		}
diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index 0828327..5150d5f 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -116,6 +116,11 @@ static inline int page_order(struct perf_buffer *rb)
 }
 #endif
 
+static inline int data_page_nr(struct perf_buffer *rb)
+{
+	return rb->nr_pages << page_order(rb);
+}
+
 static inline unsigned long perf_data_size(struct perf_buffer *rb)
 {
 	return rb->nr_pages << (PAGE_SHIFT + page_order(rb));
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 5286871..fb35b92 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -859,11 +859,6 @@ void rb_free(struct perf_buffer *rb)
 }
 
 #else
-static int data_page_nr(struct perf_buffer *rb)
-{
-	return rb->nr_pages << page_order(rb);
-}
-
 static struct page *
 __perf_mmap_to_page(struct perf_buffer *rb, unsigned long pgoff)
 {
