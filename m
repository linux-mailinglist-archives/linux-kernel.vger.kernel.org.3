Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B34F58F00F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbiHJQF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbiHJQFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:05:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1901357228
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:05:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA42061181
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 16:05:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12022C433D7;
        Wed, 10 Aug 2022 16:05:36 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oLoDF-000UyT-0n;
        Wed, 10 Aug 2022 12:05:41 -0400
Message-ID: <20220810160541.076474430@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 10 Aug 2022 12:04:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Alexandre Vicenzi <alexandre.vicenzi@suse.com>
Subject: [for-linus][PATCH 1/4] rtla: Fix tracer name
References: <20220810160455.872730397@goodmis.org>
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

From: Alexandre Vicenzi <alexandre.vicenzi@suse.com>

The correct tracer name is timerlat and not timelat.

Link: https://lore.kernel.org/linux-trace-devel/20220808180343.22262-1-alexandre.vicenzi@suse.com

Signed-off-by: Alexandre Vicenzi <alexandre.vicenzi@suse.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/tools/rtla/rtla-timerlat-hist.rst | 2 +-
 tools/tracing/rtla/src/timerlat_hist.c          | 2 +-
 tools/tracing/rtla/src/timerlat_top.c           | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/tools/rtla/rtla-timerlat-hist.rst b/Documentation/tools/rtla/rtla-timerlat-hist.rst
index e12eae1f3301..6bf7f0ca4556 100644
--- a/Documentation/tools/rtla/rtla-timerlat-hist.rst
+++ b/Documentation/tools/rtla/rtla-timerlat-hist.rst
@@ -33,7 +33,7 @@ EXAMPLE
 =======
 In the example below, **rtla timerlat hist** is set to run for *10* minutes,
 in the cpus *0-4*, *skipping zero* only lines. Moreover, **rtla timerlat
-hist** will change the priority of the *timelat* threads to run under
+hist** will change the priority of the *timerlat* threads to run under
 *SCHED_DEADLINE* priority, with a *10us* runtime every *1ms* period. The
 *1ms* period is also passed to the *timerlat* tracer::
 
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index f3ec628f5e51..4b48af8a8309 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -892,7 +892,7 @@ int timerlat_hist_main(int argc, char *argv[])
 	return_value = 0;
 
 	if (trace_is_off(&tool->trace, &record->trace)) {
-		printf("rtla timelat hit stop tracing\n");
+		printf("rtla timerlat hit stop tracing\n");
 		if (params->trace_output) {
 			printf("  Saving trace to %s\n", params->trace_output);
 			save_trace_to_file(record->trace.inst, params->trace_output);
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 35452a1d45e9..334271935222 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -687,7 +687,7 @@ int timerlat_top_main(int argc, char *argv[])
 	return_value = 0;
 
 	if (trace_is_off(&top->trace, &record->trace)) {
-		printf("rtla timelat hit stop tracing\n");
+		printf("rtla timerlat hit stop tracing\n");
 		if (params->trace_output) {
 			printf("  Saving trace to %s\n", params->trace_output);
 			save_trace_to_file(record->trace.inst, params->trace_output);
-- 
2.35.1
