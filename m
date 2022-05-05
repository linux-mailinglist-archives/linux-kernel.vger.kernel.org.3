Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94E851C0E1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379739AbiEENfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379689AbiEENeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:34:37 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB97057106;
        Thu,  5 May 2022 06:30:48 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id fv2so4212885pjb.4;
        Thu, 05 May 2022 06:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I+Ws+ESDCKCSc0iPBoRNljcueto4IcsRpZfCHksopWI=;
        b=KKXZl6QekOe6xPhmZhMXiPBUGHXK8VbLR/FDyLOh5Gtykp7SquBQOi/n0VsvY+vksg
         O9nnZ16D//6Hkhi74OJTbA69yp7Q9HkuVBcQBbB0r8IdLQLHLwG/wFK72SANTU7BbfMR
         jPd0H4Cx1RKKHYSrLUaXRmqFSZGKuqTQ/dxzckloGNbqksafkqcvom0DBOtMpu7tDBRu
         2DjUJBH/pWLW7Q08aOfxEURwiB3pd+UkQfqiKAwJjshISynHpXruyTjdMMG3r38eu4B1
         gfY8mcPxiOADgiCmJjNswsSSYIbX0Cm9nJiqw2grdb2MIRuj20KAq24jvhHqb2moYOqO
         uSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I+Ws+ESDCKCSc0iPBoRNljcueto4IcsRpZfCHksopWI=;
        b=zR2iRoQEUitRjZxKHukrf6SwvVliRi0iSTUL6xeJsaeNJEJa9MzfDr6WfhYJj+Y20C
         +1bZZC0RaGnWko/8vktZ86Bnx6NyVRFvAIQ0LMeGBLjKhIajeKv4FWUZbZIqvZoRVETR
         xMe0nK+VYfHACuoeawmWy7ubAkJTKovskR/tSY3JsyXFWriKhZv5Uyn8tIEQaF8BjvAj
         +f/CYWYJHZ8s6sSG6PidP4EwJ0znPcHN8AVmwyOZdaujhwN+4kDP0HVlVpeuNCFxiuUp
         z/LLcT96jx+lutXPwaxFpVfDSwD1vb1n7xv+TSjOgLu57dwtjmh6ZxnvA7UEoaeTVpb7
         HkBg==
X-Gm-Message-State: AOAM530jO+vwxiyT1X5j013nw3xfsQJF3BqkXAZ6qu38jCGo11k4D/s9
        urEQiKpN2/noAqjgJfAmR7SSr6VKRE4=
X-Google-Smtp-Source: ABdhPJzxZA7xB146a0crnbNkUITSiJMAyi8PcuuD5sXnsfMdGvB3WFqxfg3i5IDUDgHSq37Uq33+Yg==
X-Received: by 2002:a17:902:f28b:b0:15c:5c21:dc15 with SMTP id k11-20020a170902f28b00b0015c5c21dc15mr27752285plc.16.1651757448350;
        Thu, 05 May 2022 06:30:48 -0700 (PDT)
Received: from localhost.localdomain ([115.99.184.228])
        by smtp.gmail.com with ESMTPSA id c64-20020a624e43000000b0050dc7628135sm1420120pfb.15.2022.05.05.06.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 06:30:47 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     dan@dlrobertson.com, jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 09/10] iio: Add channel for tap and new modifiers for single and double tap
Date:   Thu,  5 May 2022 19:00:20 +0530
Message-Id: <20220505133021.22362-10-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220505133021.22362-1-jagathjog1996@gmail.com>
References: <20220505133021.22362-1-jagathjog1996@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new channel type for tap and also add new modifiers for single and
double tap. This channel and modifiers may be used by accelerometer
sensors to express single and double tap events. For directional tap,
modifiers like IIO_MOD_(X/Y/Z) can be used along with rising and
falling direction.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 11 +++++++++++
 drivers/iio/industrialio-core.c         |  3 +++
 include/uapi/linux/iio/types.h          |  3 +++
 tools/iio/iio_event_monitor.c           |  6 ++++++
 4 files changed, 23 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index d4ccc68fdcf0..bf2d10d6ad9b 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2030,3 +2030,14 @@ Description:
 		Available range for the forced calibration value, expressed as:
 
 		- a range specified as "[min step max]"
+
+What:		/sys/.../events/in_tap_single_change_en
+What:		/sys/.../events/in_tap_double_change_en
+KernelVersion:	5.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Accelerometer device detects single or double taps and generate
+		events when threshold for minimum tap amplitide passes.
+		E.g. a single tap event is generated when acceleration value
+		crosses the minimum tap amplitude value set. Where tap threshold
+		value is set by using in_tap_change_value.
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index e1ed44dec2ab..9b0d7bbd07fc 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -87,6 +87,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_POSITIONRELATIVE]  = "positionrelative",
 	[IIO_PHASE] = "phase",
 	[IIO_MASSCONCENTRATION] = "massconcentration",
+	[IIO_TAP] = "tap"
 };
 
 static const char * const iio_modifier_names[] = {
@@ -134,6 +135,8 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_ETHANOL] = "ethanol",
 	[IIO_MOD_H2] = "h2",
 	[IIO_MOD_O2] = "o2",
+	[IIO_MOD_TAP_SINGLE] = "single",
+	[IIO_MOD_TAP_DOUBLE] = "double",
 };
 
 /* relies on pairs of these shared then separate */
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 472cead10d8d..d1e61c84e0d5 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -47,6 +47,7 @@ enum iio_chan_type {
 	IIO_POSITIONRELATIVE,
 	IIO_PHASE,
 	IIO_MASSCONCENTRATION,
+	IIO_TAP,
 };
 
 enum iio_modifier {
@@ -95,6 +96,8 @@ enum iio_modifier {
 	IIO_MOD_ETHANOL,
 	IIO_MOD_H2,
 	IIO_MOD_O2,
+	IIO_MOD_TAP_SINGLE,
+	IIO_MOD_TAP_DOUBLE,
 };
 
 enum iio_event_type {
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index 2f4581658859..7fa7d4285f40 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -59,6 +59,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_POSITIONRELATIVE] = "positionrelative",
 	[IIO_PHASE] = "phase",
 	[IIO_MASSCONCENTRATION] = "massconcentration",
+	[IIO_TAP] = "tap",
 };
 
 static const char * const iio_ev_type_text[] = {
@@ -122,6 +123,8 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_PM4] = "pm4",
 	[IIO_MOD_PM10] = "pm10",
 	[IIO_MOD_O2] = "o2",
+	[IIO_MOD_TAP_SINGLE] = "single",
+	[IIO_MOD_TAP_DOUBLE] = "double",
 };
 
 static bool event_is_known(struct iio_event_data *event)
@@ -164,6 +167,7 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_POSITIONRELATIVE:
 	case IIO_PHASE:
 	case IIO_MASSCONCENTRATION:
+	case IIO_TAP:
 		break;
 	default:
 		return false;
@@ -215,6 +219,8 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_MOD_PM4:
 	case IIO_MOD_PM10:
 	case IIO_MOD_O2:
+	case IIO_MOD_TAP_SINGLE:
+	case IIO_MOD_TAP_DOUBLE:
 		break;
 	default:
 		return false;
-- 
2.17.1

