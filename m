Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56AE4DA2F1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351368AbiCOTFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351263AbiCOTEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:04:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8BB5A164
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 12:02:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A648A616FD
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 19:02:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F3EC36AE3;
        Tue, 15 Mar 2022 19:02:46 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nUCRR-003jnv-Ka;
        Tue, 15 Mar 2022 15:02:45 -0400
Message-ID: <20220315190245.457233873@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 15 Mar 2022 15:02:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [for-next][PATCH 15/15] rtla: Tools main loop cleanup
References: <20220315190214.613102181@goodmis.org>
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

I probably started using "do {} while();", but changed all but osnoise_top
to "while(){};" leaving the ; behind.

Cleanup the main loop code, making all tools use "while() {}"

Changcheng Deng reported this problem, as reported by coccicheck:

Fix the following coccicheck review:
./tools/tracing/rtla/src/timerlat_hist.c: 800: 2-3: Unneeded semicolon
./tools/tracing/rtla/src/osnoise_hist.c:  776: 2-3: Unneeded semicolon
./tools/tracing/rtla/src/timerlat_top.c:  596: 2-3: Unneeded semicolon

Link: https://lkml.kernel.org/r/3c1642110aa87c396f5da4a037dabc72dbb9c601.1646247211.git.bristot@kernel.org

Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Clark Williams <williams@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Reported-by: Changcheng Deng <deng.changcheng@zte.com.cn>
Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/src/osnoise_hist.c  | 2 +-
 tools/tracing/rtla/src/osnoise_top.c   | 4 ++--
 tools/tracing/rtla/src/timerlat_hist.c | 2 +-
 tools/tracing/rtla/src/timerlat_top.c  | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index c47780fedbaf..b4380d45cacd 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -850,7 +850,7 @@ int osnoise_hist_main(int argc, char *argv[])
 
 		if (trace_is_off(&tool->trace, &record->trace))
 			break;
-	};
+	}
 
 	osnoise_read_trace_hist(tool);
 
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index fd29a4049322..72c2fd6ce005 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -612,7 +612,7 @@ int osnoise_top_main(int argc, char **argv)
 	tool->start_time = time(NULL);
 	osnoise_top_set_signals(params);
 
-	do {
+	while (!stop_tracing) {
 		sleep(params->sleep_time);
 
 		retval = tracefs_iterate_raw_events(trace->tep,
@@ -632,7 +632,7 @@ int osnoise_top_main(int argc, char **argv)
 		if (trace_is_off(&tool->trace, &record->trace))
 			break;
 
-	} while (!stop_tracing);
+	}
 
 	osnoise_print_stats(params, tool);
 
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 0f6ce80a198a..dc908126c610 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -885,7 +885,7 @@ int timerlat_hist_main(int argc, char *argv[])
 
 		if (trace_is_off(&tool->trace, &record->trace))
 			break;
-	};
+	}
 
 	timerlat_print_stats(params, tool);
 
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 53f4cdfd395e..1f754c3df53f 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -680,7 +680,7 @@ int timerlat_top_main(int argc, char *argv[])
 		if (trace_is_off(&top->trace, &record->trace))
 			break;
 
-	};
+	}
 
 	timerlat_print_stats(params, top);
 
-- 
2.35.1
