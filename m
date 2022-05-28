Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9035C536A59
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 04:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355702AbiE1Cxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 22:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354554AbiE1Cw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 22:52:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3626A12E301
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 19:52:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9939BB82692
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 02:52:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57354C3411A;
        Sat, 28 May 2022 02:52:51 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1numZO-000LOs-F6;
        Fri, 27 May 2022 22:52:50 -0400
Message-ID: <20220528025250.304607790@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 27 May 2022 22:50:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [for-next][PATCH 09/23] tracing/timerlat: Notify IRQ new max latency only if stop tracing is
 set
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

Currently, the notification of a new max latency is sent from
timerlat's IRQ handler anytime a new max latency is found.

While this behavior is not wrong, the send IPI overhead itself
will increase the thread latency and that is not the desired
effect (tracing overhead).

Moreover, the thread will notify a new max latency again because
the thread latency as it is always higher than the IRQ latency
that woke it up.

The only case in which it is helpful to notify a new max latency
from IRQ is when stop tracing (for the IRQ) is set, as in this
case, the thread will not be dispatched.

Notify a new max latency from the IRQ handler only if stop tracing is
set for the IRQ handler.

Link: https://lkml.kernel.org/r/2c2d9a56c0886c8402ba320de32856cbbb10c2bb.1652175637.git.bristot@kernel.org

Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Reported-by: Clark Williams <williams@redhat.com>
Fixes: a955d7eac177 ("trace: Add timerlat tracer")
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_osnoise.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index e9ae1f33a7f0..6494ca27ea6f 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1578,11 +1578,12 @@ static enum hrtimer_restart timerlat_irq(struct hrtimer *timer)
 
 	trace_timerlat_sample(&s);
 
-	notify_new_max_latency(diff);
-
-	if (osnoise_data.stop_tracing)
-		if (time_to_us(diff) >= osnoise_data.stop_tracing)
+	if (osnoise_data.stop_tracing) {
+		if (time_to_us(diff) >= osnoise_data.stop_tracing) {
 			osnoise_stop_tracing();
+			notify_new_max_latency(diff);
+		}
+	}
 
 	wake_up_process(tlat->kthread);
 
-- 
2.35.1
