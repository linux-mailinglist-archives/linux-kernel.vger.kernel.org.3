Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636454C1B08
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 19:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243989AbiBWSiV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 23 Feb 2022 13:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243981AbiBWSiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 13:38:18 -0500
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4123F49243
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 10:37:48 -0800 (PST)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-601-Nc0wuXH1MGGCkCOMhI_V5w-1; Wed, 23 Feb 2022 13:37:42 -0500
X-MC-Unique: Nc0wuXH1MGGCkCOMhI_V5w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31D14100C609;
        Wed, 23 Feb 2022 18:37:41 +0000 (UTC)
Received: from x1.com (unknown [10.22.8.106])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF6F83480F;
        Wed, 23 Feb 2022 18:37:39 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [PATCH] rtla: Set /dev/cpu_dma_latency to avoid exit from idle latencies
Date:   Wed, 23 Feb 2022 19:37:35 +0100
Message-Id: <c74be7f76941cd79404d4dcddd1b8ea2183de38d.1645641162.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bristot@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set /dev/cpu_dma_latency to 0 to avoid having exit from idle
states latencies influencing in the analysis.

Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/tracing/rtla/src/timerlat_hist.c | 10 ++++++++
 tools/tracing/rtla/src/timerlat_top.c  | 10 ++++++++
 tools/tracing/rtla/src/utils.c         | 33 ++++++++++++++++++++++++++
 tools/tracing/rtla/src/utils.h         |  1 +
 4 files changed, 54 insertions(+)

diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 237e1735afa7..3c0108ff63ab 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -732,6 +732,7 @@ int timerlat_hist_main(int argc, char *argv[])
 	struct osnoise_tool *record = NULL;
 	struct osnoise_tool *tool = NULL;
 	struct trace_instance *trace;
+	int dma_latency_fd = -1;
 	int return_value = 1;
 	int retval;
 
@@ -767,6 +768,13 @@ int timerlat_hist_main(int argc, char *argv[])
 		}
 	}
 
+	/*
+	 * Avoid going into deep idle states.
+	 */
+	dma_latency_fd = set_cpu_dma_latency(0);
+	if (dma_latency_fd < 0)
+		err_msg("Could not set /dev/cpu_dma_latency to 0. Long IRQ latencies expected\n");
+
 	trace_instance_start(trace);
 
 	if (params->trace_output) {
@@ -812,6 +820,8 @@ int timerlat_hist_main(int argc, char *argv[])
 	}
 
 out_hist:
+	if (dma_latency_fd >= 0)
+		close(dma_latency_fd);
 	timerlat_free_histogram(tool->data);
 	osnoise_destroy_tool(record);
 	osnoise_destroy_tool(tool);
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index d4187f6534ed..f4bca0ad5de3 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -524,6 +524,7 @@ int timerlat_top_main(int argc, char *argv[])
 	struct osnoise_tool *record = NULL;
 	struct osnoise_tool *top = NULL;
 	struct trace_instance *trace;
+	int dma_latency_fd = -1;
 	int return_value = 1;
 	int retval;
 
@@ -559,6 +560,13 @@ int timerlat_top_main(int argc, char *argv[])
 		}
 	}
 
+	/*
+	 * Avoid going into deep idle states.
+	 */
+	dma_latency_fd = set_cpu_dma_latency(0);
+	if (dma_latency_fd < 0)
+		err_msg("Could not set /dev/cpu_dma_latency. Long IRQ latencies expected.\n");
+
 	trace_instance_start(trace);
 
 	if (params->trace_output) {
@@ -608,6 +616,8 @@ int timerlat_top_main(int argc, char *argv[])
 	}
 
 out_top:
+	if (dma_latency_fd >= 0)
+		close(dma_latency_fd);
 	timerlat_free_top(top->data);
 	osnoise_destroy_tool(record);
 	osnoise_destroy_tool(top);
diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index ffaf8ec84001..da2b590edaed 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -10,6 +10,7 @@
 #include <unistd.h>
 #include <ctype.h>
 #include <errno.h>
+#include <fcntl.h>
 #include <sched.h>
 #include <stdio.h>
 
@@ -431,3 +432,35 @@ int parse_prio(char *arg, struct sched_attr *sched_param)
 	}
 	return 0;
 }
+
+/*
+ * set_cpu_dma_latency - set the /dev/cpu_dma_latecy
+ *
+ * This is used to reduce the exit from idle latency. The value
+ * will be reset once the file descriptor of /dev/cpu_dma_latecy
+ * is closed.
+ *
+ * Return: the /dev/cpu_dma_latecy file descriptor
+ */
+int set_cpu_dma_latency(int32_t latency)
+{
+	int retval;
+	int fd;
+
+	fd = open("/dev/cpu_dma_latency", O_RDWR);
+	if (fd < 0) {
+		err_msg("Error opening /dev/cpu_dma_latency\n");
+		return -1;
+	}
+
+	retval = write(fd, &latency, 4);
+	if (retval < 1) {
+		err_msg("Error setting /dev/cpu_dma_latency\n");
+		close(fd);
+		return -1;
+	}
+
+	debug_msg("Set /dev/cpu_dma_latency to %d\n", latency);
+
+	return fd;
+}
diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
index 9aa962319ca2..fa08e374870a 100644
--- a/tools/tracing/rtla/src/utils.h
+++ b/tools/tracing/rtla/src/utils.h
@@ -54,3 +54,4 @@ struct sched_attr {
 
 int parse_prio(char *arg, struct sched_attr *sched_param);
 int set_comm_sched_attr(const char *comm, struct sched_attr *attr);
+int set_cpu_dma_latency(int32_t latency);
-- 
2.34.1

