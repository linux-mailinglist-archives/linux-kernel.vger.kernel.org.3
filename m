Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31944CAA82
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243150AbiCBQix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242974AbiCBQij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:38:39 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1792C66B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 08:37:56 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646239074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4cKKYZ6rFTNdllIAOfnpLukoRzeAYo94WNiwHmUVtvE=;
        b=HVbToheIxR10VUP8ZlBKwBpe96+cP7ZagHwjrCt0/PJTSNJAVAmgv4JjI3toxGepTU/P+x
        kxBUHAO6r9T8Ca7DmIdW5ZyIoqecbSNt8eWrMkNdaBe81yZJigAWXY2dR1/2QfOthDk1I+
        EZlcs8NWhHuUPzVWc6JhOYmxDyHVn4U=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm 10/22] kasan: move disable_trace_on_warning to start_report
Date:   Wed,  2 Mar 2022 17:36:30 +0100
Message-Id: <7c066c5de26234ad2cebdd931adfe437f8a95d58.1646237226.git.andreyknvl@google.com>
In-Reply-To: <cover.1646237226.git.andreyknvl@google.com>
References: <cover.1646237226.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Move the disable_trace_on_warning() call, which enables the
/proc/sys/kernel/traceoff_on_warning interface for KASAN bugs,
to start_report(), so that it functions for all types of KASAN reports.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/report.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 0b6c8a14f0ea..9286ff6ae1a7 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -129,6 +129,8 @@ static DEFINE_SPINLOCK(report_lock);
 
 static void start_report(unsigned long *flags, bool sync)
 {
+	/* Respect the /proc/sys/kernel/traceoff_on_warning interface. */
+	disable_trace_on_warning();
 	/* Update status of the currently running KASAN test. */
 	update_kunit_status(sync);
 	/* Make sure we don't end up in loop. */
@@ -421,7 +423,6 @@ static void __kasan_report(unsigned long addr, size_t size, bool is_write,
 	void *untagged_addr;
 	unsigned long flags;
 
-	disable_trace_on_warning();
 	start_report(&flags, true);
 
 	tagged_addr = (void *)addr;
-- 
2.25.1

