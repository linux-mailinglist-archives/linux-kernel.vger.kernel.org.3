Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0694EBB87
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 09:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243708AbiC3HPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 03:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243706AbiC3HO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 03:14:58 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7F8160FE7;
        Wed, 30 Mar 2022 00:13:09 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 30 Mar
 2022 15:13:08 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Wed, 30 Mar
 2022 15:13:07 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     Haowen Bai <baihaowen@meizu.com>,
        <linux-trace-devel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] rtla/osnoise_hist: avoid NULL pointer dereference on out
Date:   Wed, 30 Mar 2022 15:13:05 +0800
Message-ID: <1648624385-10091-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-124.meizu.com (172.16.1.124) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

record is NULL and go out but dereference record->trace.

report by coccicheck:
tools/tracing/rtla/src/osnoise_hist.c:870:31-36: ERROR:
record is NULL but dereferenced.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 tools/tracing/rtla/src/osnoise_hist.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index b4380d4..b7862b4 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -819,13 +819,13 @@ int osnoise_hist_main(int argc, char *argv[])
 		record = osnoise_init_trace_tool("osnoise");
 		if (!record) {
 			err_msg("Failed to enable the trace instance\n");
-			goto out_hist;
+			goto out_top;
 		}
 
 		if (params->events) {
 			retval = trace_events_enable(&record->trace, params->events);
 			if (retval)
-				goto out_hist;
+				goto out_top;
 		}
 
 		trace_instance_start(&record->trace);
@@ -845,7 +845,7 @@ int osnoise_hist_main(int argc, char *argv[])
 						    trace);
 		if (retval < 0) {
 			err_msg("Error iterating on events\n");
-			goto out_hist;
+			goto out_top;
 		}
 
 		if (trace_is_off(&tool->trace, &record->trace))
@@ -865,9 +865,9 @@ int osnoise_hist_main(int argc, char *argv[])
 			save_trace_to_file(record->trace.inst, params->trace_output);
 		}
 	}
-
-out_hist:
+out_top:
 	trace_events_destroy(&record->trace, params->events);
+out_hist:
 	params->events = NULL;
 	osnoise_free_histogram(tool->data);
 out_destroy:
-- 
2.7.4

