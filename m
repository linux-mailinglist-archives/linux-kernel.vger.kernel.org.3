Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2411652114E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 11:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239158AbiEJJti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 05:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239132AbiEJJtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 05:49:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A424B24F2B;
        Tue, 10 May 2022 02:45:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4592C615F6;
        Tue, 10 May 2022 09:45:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5FCC385C9;
        Tue, 10 May 2022 09:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652175938;
        bh=9H7ysJz1vVhOl+TV+4Tl6mkvRpk278sDTvbAtJBV2PU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aHeL4smZjkVsPmMX5DELT9/H1TKlCLGOU2VioqwmG65chqG0QmjODQKoVcSvejKi3
         K9o6p7Hco/5r85DpZx60cia+QCaOYaclimYC96A7onLGzEOg6FJhSp00bJ83B0hl7Y
         wr30xVBToZdNNKz2UNfV9faYzQluC3nb8Am3H1p/q7SD9GqhpmD4NpaytY05m2lDeO
         8lgz4XxFtBsnNVxBFZW+ddJW4SAqPswrt4+W1MB6nDta0DQqtkQW+wtjfV2uRyLARX
         IPTjbpil7xjwbvxf1ofPdId3vCfw7QTKNqJOLCAgXg7A3wacY1M0bt8J+1WX6iFQIh
         gVxIghiwxHrxw==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: [PATCH 2/3] tracing/timerlat: Print stacktrace in the IRQ handler if needed
Date:   Tue, 10 May 2022 11:45:24 +0200
Message-Id: <fd04530ce98ae9270e41bb124ee5bf67b05ecfed.1652175637.git.bristot@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <2c2d9a56c0886c8402ba320de32856cbbb10c2bb.1652175637.git.bristot@kernel.org>
References: <2c2d9a56c0886c8402ba320de32856cbbb10c2bb.1652175637.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If print_stack and stop_tracing_us are set, and stop_tracing_us is hit
with latency higher than or equal to print_stack, print the
stack at the IRQ handler as it is useful to define the root cause for
the IRQ latency.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
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
2.32.0

