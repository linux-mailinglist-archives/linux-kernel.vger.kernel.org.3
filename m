Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6474CAE31
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 20:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244912AbiCBTF3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 2 Mar 2022 14:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244879AbiCBTFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 14:05:21 -0500
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 527F7C0845
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:04:36 -0800 (PST)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-aG4RKoFBPGemeqfLWlHP9w-1; Wed, 02 Mar 2022 14:04:32 -0500
X-MC-Unique: aG4RKoFBPGemeqfLWlHP9w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 853BD501E3;
        Wed,  2 Mar 2022 19:04:30 +0000 (UTC)
Received: from x1.com (unknown [10.22.32.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 941C719724;
        Wed,  2 Mar 2022 19:04:27 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH V3 15/15] rtla: Tools main loop cleanup
Date:   Wed,  2 Mar 2022 20:01:40 +0100
Message-Id: <3c1642110aa87c396f5da4a037dabc72dbb9c601.1646247211.git.bristot@kernel.org>
In-Reply-To: <cover.1646247211.git.bristot@kernel.org>
References: <cover.1646247211.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bristot@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I probably started using "do {} while();", but changed all but osnoise_top
to "while(){};" leaving the ; behind.

Cleanup the main loop code, making all tools use "while() {}"

Changcheng Deng reported this problem, as reported by coccicheck:

Fix the following coccicheck review:
./tools/tracing/rtla/src/timerlat_hist.c: 800: 2-3: Unneeded semicolon
./tools/tracing/rtla/src/osnoise_hist.c:  776: 2-3: Unneeded semicolon
./tools/tracing/rtla/src/timerlat_top.c:  596: 2-3: Unneeded semicolon

Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Reported-by: Changcheng Deng <deng.changcheng@zte.com.cn>
Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
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
2.34.1

