Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42341495A4B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 08:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378825AbiAUHIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 02:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbiAUHIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 02:08:15 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80797C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 23:08:15 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id x37so4108793pfh.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 23:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7OqjNHFmmUatC4IPR4ZV3yhib46yOP7+7dnbURGm9Co=;
        b=WwqphOiEPcKb56nK1MAxaadLwC2jpEYX/CPkWC1b0GjHse9Y1RKPcoDOqaz/XBwzNQ
         TALd/82mNdZO0MlhGIXFEDNhAzZdRXwEYhlPVZ0Xdr5dqYTlqnF3jHVUlLaNFCKHMDc+
         IGW5piptkBD0u+Nc4Di9UJke1f3IfQ2x41UAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7OqjNHFmmUatC4IPR4ZV3yhib46yOP7+7dnbURGm9Co=;
        b=2Eotf3D9vE+XxchClgVSHoVqzjp+x854ZuoqgEDNEx0EZ4/4Oo8dcc6ak2GNhVAsaT
         JnaZgnHuLBPaFjvNvrhU52iWAvV8M7ToRKYFlVzj9Dn1HVxKUCe/jS9Z9DdCZKZ7xMmb
         e7cb9kMdCel6w88DgdBkqZ9A52+greUseg5GAWiSTHL0z+SxjCm/JEHBUGeq6ZI521+Z
         Gz9rHOqx49QjRzZsiK0Ms420S0Sqey+gH4jBUQf6oWxGVZV4GgPEwBTp4ZLNoHaFoIRq
         kias1bOjiSIk76m+VaHNs8bPhw6xz/GrZsFuXkuZHv4196decsVw8jZxZfJ8/Qmvvr/O
         PN1w==
X-Gm-Message-State: AOAM531/t49YhcKVw8WYcnb6T+9ceq0J9OwPFWJjw3UxcBHODeTzFEDv
        ifiVPg8Ga+ns083ksqNBI1Noyg==
X-Google-Smtp-Source: ABdhPJytU9o1GtoR+wPJm/HxrNN3kNFyTq8F9JoFHSZxAgMXR/saBAiIZV9qvGjzqXpLPC8fvT4Fag==
X-Received: by 2002:a62:3003:0:b0:4c1:6983:f1c3 with SMTP id w3-20020a623003000000b004c16983f1c3mr2477988pfw.20.1642748894914;
        Thu, 20 Jan 2022 23:08:14 -0800 (PST)
Received: from localhost ([2620:15c:202:201:1eb9:8fdf:5fb0:bab0])
        by smtp.gmail.com with UTF8SMTPSA id z21sm5566116pfe.108.2022.01.20.23.08.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 23:08:14 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     groeck@chromium.org, bleung@chromium.org
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] platform: chrome: Split trace include file
Date:   Thu, 20 Jan 2022 23:08:12 -0800
Message-Id: <20220121070812.418788-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cros_ec_trace.h defined 5 tracing events, 2 for cros_ec_proto and
3 for cros_ec_sensorhub_ring.
These 2 files are in different kernel modules, the traces are defined
twice in the kernel which leads to problem enabling only some traces.

Move sensorhub traces from cros_ec_trace.h to cros_ec_sensorhub_trace.h
and enable them only in cros_ec_sensorhub kernel module.

Check we can now enable a single trace.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/platform/chrome/Makefile              |   3 +-
 .../platform/chrome/cros_ec_sensorhub_ring.c  |   3 +-
 .../platform/chrome/cros_ec_sensorhub_trace.h | 123 ++++++++++++++++++
 drivers/platform/chrome/cros_ec_trace.h       |  95 --------------
 4 files changed, 127 insertions(+), 97 deletions(-)
 create mode 100644 drivers/platform/chrome/cros_ec_sensorhub_trace.h

diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index f901d2e43166c3..88cbc434c06b22 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -2,6 +2,7 @@
 
 # tell define_trace.h where to find the cros ec trace header
 CFLAGS_cros_ec_trace.o:=		-I$(src)
+CFLAGS_cros_ec_sensorhub_ring.o:=	-I$(src)
 
 obj-$(CONFIG_CHROMEOS_LAPTOP)		+= chromeos_laptop.o
 obj-$(CONFIG_CHROMEOS_PSTORE)		+= chromeos_pstore.o
@@ -20,7 +21,7 @@ obj-$(CONFIG_CROS_EC_CHARDEV)		+= cros_ec_chardev.o
 obj-$(CONFIG_CROS_EC_LIGHTBAR)		+= cros_ec_lightbar.o
 obj-$(CONFIG_CROS_EC_VBC)		+= cros_ec_vbc.o
 obj-$(CONFIG_CROS_EC_DEBUGFS)		+= cros_ec_debugfs.o
-cros-ec-sensorhub-objs			:= cros_ec_sensorhub.o cros_ec_sensorhub_ring.o cros_ec_trace.o
+cros-ec-sensorhub-objs			:= cros_ec_sensorhub.o cros_ec_sensorhub_ring.o
 obj-$(CONFIG_CROS_EC_SENSORHUB)		+= cros-ec-sensorhub.o
 obj-$(CONFIG_CROS_EC_SYSFS)		+= cros_ec_sysfs.o
 obj-$(CONFIG_CROS_USBPD_LOGGER)		+= cros_usbpd_logger.o
diff --git a/drivers/platform/chrome/cros_ec_sensorhub_ring.c b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
index 98e37080f76091..71948dade0e2ae 100644
--- a/drivers/platform/chrome/cros_ec_sensorhub_ring.c
+++ b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
@@ -17,7 +17,8 @@
 #include <linux/sort.h>
 #include <linux/slab.h>
 
-#include "cros_ec_trace.h"
+#define CREATE_TRACE_POINTS
+#include "cros_ec_sensorhub_trace.h"
 
 /* Precision of fixed point for the m values from the filter */
 #define M_PRECISION BIT(23)
diff --git a/drivers/platform/chrome/cros_ec_sensorhub_trace.h b/drivers/platform/chrome/cros_ec_sensorhub_trace.h
new file mode 100644
index 00000000000000..57d9b478596927
--- /dev/null
+++ b/drivers/platform/chrome/cros_ec_sensorhub_trace.h
@@ -0,0 +1,123 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Trace events for the ChromeOS Sensorhub kernel module
+ *
+ * Copyright 2021 Google LLC.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM cros_ec
+
+#if !defined(_CROS_EC_SENSORHUB_TRACE_H_) || defined(TRACE_HEADER_MULTI_READ)
+#define _CROS_EC_SENSORHUB_TRACE_H_
+
+#include <linux/types.h>
+#include <linux/platform_data/cros_ec_sensorhub.h>
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(cros_ec_sensorhub_timestamp,
+	    TP_PROTO(u32 ec_sample_timestamp, u32 ec_fifo_timestamp, s64 fifo_timestamp,
+		     s64 current_timestamp, s64 current_time),
+	TP_ARGS(ec_sample_timestamp, ec_fifo_timestamp, fifo_timestamp, current_timestamp,
+		current_time),
+	TP_STRUCT__entry(
+		__field(u32, ec_sample_timestamp)
+		__field(u32, ec_fifo_timestamp)
+		__field(s64, fifo_timestamp)
+		__field(s64, current_timestamp)
+		__field(s64, current_time)
+		__field(s64, delta)
+	),
+	TP_fast_assign(
+		__entry->ec_sample_timestamp = ec_sample_timestamp;
+		__entry->ec_fifo_timestamp = ec_fifo_timestamp;
+		__entry->fifo_timestamp = fifo_timestamp;
+		__entry->current_timestamp = current_timestamp;
+		__entry->current_time = current_time;
+		__entry->delta = current_timestamp - current_time;
+	),
+	TP_printk("ec_ts: %9u, ec_fifo_ts: %9u, fifo_ts: %12lld, curr_ts: %12lld, curr_time: %12lld, delta %12lld",
+		  __entry->ec_sample_timestamp,
+		__entry->ec_fifo_timestamp,
+		__entry->fifo_timestamp,
+		__entry->current_timestamp,
+		__entry->current_time,
+		__entry->delta
+	)
+);
+
+TRACE_EVENT(cros_ec_sensorhub_data,
+	    TP_PROTO(u32 ec_sensor_num, u32 ec_fifo_timestamp, s64 fifo_timestamp,
+		     s64 current_timestamp, s64 current_time),
+	TP_ARGS(ec_sensor_num, ec_fifo_timestamp, fifo_timestamp, current_timestamp, current_time),
+	TP_STRUCT__entry(
+		__field(u32, ec_sensor_num)
+		__field(u32, ec_fifo_timestamp)
+		__field(s64, fifo_timestamp)
+		__field(s64, current_timestamp)
+		__field(s64, current_time)
+		__field(s64, delta)
+	),
+	TP_fast_assign(
+		__entry->ec_sensor_num = ec_sensor_num;
+		__entry->ec_fifo_timestamp = ec_fifo_timestamp;
+		__entry->fifo_timestamp = fifo_timestamp;
+		__entry->current_timestamp = current_timestamp;
+		__entry->current_time = current_time;
+		__entry->delta = current_timestamp - current_time;
+	),
+	TP_printk("ec_num: %4u, ec_fifo_ts: %9u, fifo_ts: %12lld, curr_ts: %12lld, curr_time: %12lld, delta %12lld",
+		  __entry->ec_sensor_num,
+		__entry->ec_fifo_timestamp,
+		__entry->fifo_timestamp,
+		__entry->current_timestamp,
+		__entry->current_time,
+		__entry->delta
+	)
+);
+
+TRACE_EVENT(cros_ec_sensorhub_filter,
+	    TP_PROTO(struct cros_ec_sensors_ts_filter_state *state, s64 dx, s64 dy),
+	TP_ARGS(state, dx, dy),
+	TP_STRUCT__entry(
+		__field(s64, dx)
+		__field(s64, dy)
+		__field(s64, median_m)
+		__field(s64, median_error)
+		__field(s64, history_len)
+		__field(s64, x)
+		__field(s64, y)
+	),
+	TP_fast_assign(
+		__entry->dx = dx;
+		__entry->dy = dy;
+		__entry->median_m = state->median_m;
+		__entry->median_error = state->median_error;
+		__entry->history_len = state->history_len;
+		__entry->x = state->x_offset;
+		__entry->y = state->y_offset;
+	),
+	TP_printk("dx: %12lld. dy: %12lld median_m: %12lld median_error: %12lld len: %lld x: %12lld y: %12lld",
+		  __entry->dx,
+		__entry->dy,
+		__entry->median_m,
+		__entry->median_error,
+		__entry->history_len,
+		__entry->x,
+		__entry->y
+	)
+);
+
+
+#endif /* _CROS_EC_SENSORHUB_TRACE_H_ */
+
+/* this part must be outside header guard */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE cros_ec_sensorhub_trace
+
+#include <trace/define_trace.h>
diff --git a/drivers/platform/chrome/cros_ec_trace.h b/drivers/platform/chrome/cros_ec_trace.h
index 7e7cfc98657a4a..9bb5cd2c98b8b4 100644
--- a/drivers/platform/chrome/cros_ec_trace.h
+++ b/drivers/platform/chrome/cros_ec_trace.h
@@ -15,7 +15,6 @@
 #include <linux/types.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
-#include <linux/platform_data/cros_ec_sensorhub.h>
 
 #include <linux/tracepoint.h>
 
@@ -71,100 +70,6 @@ TRACE_EVENT(cros_ec_request_done,
 		  __entry->retval)
 );
 
-TRACE_EVENT(cros_ec_sensorhub_timestamp,
-	    TP_PROTO(u32 ec_sample_timestamp, u32 ec_fifo_timestamp, s64 fifo_timestamp,
-		     s64 current_timestamp, s64 current_time),
-	TP_ARGS(ec_sample_timestamp, ec_fifo_timestamp, fifo_timestamp, current_timestamp,
-		current_time),
-	TP_STRUCT__entry(
-		__field(u32, ec_sample_timestamp)
-		__field(u32, ec_fifo_timestamp)
-		__field(s64, fifo_timestamp)
-		__field(s64, current_timestamp)
-		__field(s64, current_time)
-		__field(s64, delta)
-	),
-	TP_fast_assign(
-		__entry->ec_sample_timestamp = ec_sample_timestamp;
-		__entry->ec_fifo_timestamp = ec_fifo_timestamp;
-		__entry->fifo_timestamp = fifo_timestamp;
-		__entry->current_timestamp = current_timestamp;
-		__entry->current_time = current_time;
-		__entry->delta = current_timestamp - current_time;
-	),
-	TP_printk("ec_ts: %9u, ec_fifo_ts: %9u, fifo_ts: %12lld, curr_ts: %12lld, curr_time: %12lld, delta %12lld",
-		  __entry->ec_sample_timestamp,
-		__entry->ec_fifo_timestamp,
-		__entry->fifo_timestamp,
-		__entry->current_timestamp,
-		__entry->current_time,
-		__entry->delta
-	)
-);
-
-TRACE_EVENT(cros_ec_sensorhub_data,
-	    TP_PROTO(u32 ec_sensor_num, u32 ec_fifo_timestamp, s64 fifo_timestamp,
-		     s64 current_timestamp, s64 current_time),
-	TP_ARGS(ec_sensor_num, ec_fifo_timestamp, fifo_timestamp, current_timestamp, current_time),
-	TP_STRUCT__entry(
-		__field(u32, ec_sensor_num)
-		__field(u32, ec_fifo_timestamp)
-		__field(s64, fifo_timestamp)
-		__field(s64, current_timestamp)
-		__field(s64, current_time)
-		__field(s64, delta)
-	),
-	TP_fast_assign(
-		__entry->ec_sensor_num = ec_sensor_num;
-		__entry->ec_fifo_timestamp = ec_fifo_timestamp;
-		__entry->fifo_timestamp = fifo_timestamp;
-		__entry->current_timestamp = current_timestamp;
-		__entry->current_time = current_time;
-		__entry->delta = current_timestamp - current_time;
-	),
-	TP_printk("ec_num: %4u, ec_fifo_ts: %9u, fifo_ts: %12lld, curr_ts: %12lld, curr_time: %12lld, delta %12lld",
-		  __entry->ec_sensor_num,
-		__entry->ec_fifo_timestamp,
-		__entry->fifo_timestamp,
-		__entry->current_timestamp,
-		__entry->current_time,
-		__entry->delta
-	)
-);
-
-TRACE_EVENT(cros_ec_sensorhub_filter,
-	    TP_PROTO(struct cros_ec_sensors_ts_filter_state *state, s64 dx, s64 dy),
-	TP_ARGS(state, dx, dy),
-	TP_STRUCT__entry(
-		__field(s64, dx)
-		__field(s64, dy)
-		__field(s64, median_m)
-		__field(s64, median_error)
-		__field(s64, history_len)
-		__field(s64, x)
-		__field(s64, y)
-	),
-	TP_fast_assign(
-		__entry->dx = dx;
-		__entry->dy = dy;
-		__entry->median_m = state->median_m;
-		__entry->median_error = state->median_error;
-		__entry->history_len = state->history_len;
-		__entry->x = state->x_offset;
-		__entry->y = state->y_offset;
-	),
-	TP_printk("dx: %12lld. dy: %12lld median_m: %12lld median_error: %12lld len: %lld x: %12lld y: %12lld",
-		  __entry->dx,
-		__entry->dy,
-		__entry->median_m,
-		__entry->median_error,
-		__entry->history_len,
-		__entry->x,
-		__entry->y
-	)
-);
-
-
 #endif /* _CROS_EC_TRACE_H_ */
 
 /* this part must be outside header guard */
-- 
2.35.0.rc0.227.g00780c9af4-goog

