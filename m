Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C68536A51
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 04:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355641AbiE1CxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 22:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353107AbiE1Cwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 22:52:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFF5880C6
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 19:52:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18F0561D44
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 02:52:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848DAC385A9;
        Sat, 28 May 2022 02:52:51 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1numZO-000LPR-LG;
        Fri, 27 May 2022 22:52:50 -0400
Message-ID: <20220528025250.483799146@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 27 May 2022 22:50:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [for-next][PATCH 10/23] tracing/timerlat: Print stacktrace in the IRQ handler if needed
References: <20220528025028.850906216@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Bristot de Oliveira <bristot@kernel.org>

If print_stack and stop_tracing_us are set, and stop_tracing_us is hit
with latency higher than or equal to print_stack, print the
stack at the IRQ handler as it is useful to define the root cause for
the IRQ latency.

Link: https://lkml.kernel.org/r/fd04530ce98ae9270e41bb124ee5bf67b05ecfed.1652175637.git.bristot@kernel.org

Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/trace/timerlat-tracer.rst |  5 +++--
 kernel/trace/trace_osnoise.c            | 13 +++++++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/trace/timerlat-tracer.rst b/Documentation/trace/timerlat-tracer.rst
index 64d1fe6e9b93..d643c95c01eb 100644
--- a/Documentation/trace/timerlat-tracer.rst
+++ b/Documentation/trace/timerlat-tracer.rst
@@ -74,8 +74,9 @@ directory. The timerlat configs are:
  - stop_tracing_total_us: stop the system tracing if a
    timer latency at the *thread* context is higher than the configured
    value happens. Writing 0 disables this option.
- - print_stack: save the stack of the IRQ occurrence, and print
-   it after the *thread context* event".
+ - print_stack: save the stack of the IRQ occurrence. The stack is printed
+   after the *thread context* event, or at the IRQ handler if *stop_tracing_us*
+   is hit.
 
 timerlat and osnoise
 ----------------------------
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 6494ca27ea6f..9b204ee3c6f5 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1580,6 +1580,19 @@ static enum hrtimer_restart timerlat_irq(struct hrtimer *timer)
 
 	if (osnoise_data.stop_tracing) {
 		if (time_to_us(diff) >= osnoise_data.stop_tracing) {
+
+			/*
+			 * At this point, if stop_tracing is set and <= print_stack,
+			 * print_stack is set and would be printed in the thread handler.
+			 *
+			 * Thus, print the stack trace as it is helpful to define the
+			 * root cause of an IRQ latency.
+			 */
+			if (osnoise_data.stop_tracing <= osnoise_data.print_stack) {
+				timerlat_save_stack(0);
+				timerlat_dump_stack(time_to_us(diff));
+			}
+
 			osnoise_stop_tracing();
 			notify_new_max_latency(diff);
 		}
-- 
2.35.1
