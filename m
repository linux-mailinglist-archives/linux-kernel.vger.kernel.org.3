Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC7C536F46
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 06:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiE2ECF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 00:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiE2ECB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 00:02:01 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9D86CF43;
        Sat, 28 May 2022 21:02:00 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d22so7513665plr.9;
        Sat, 28 May 2022 21:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y5OMjkdRzs/CGT1kO2TrDbN9xYtVWPVC57jAXxj10Ls=;
        b=D8P4g633DpMmM5UKEu1F7ep+ri2CM3tVdmcZbjcRyBY+9S02YICt/23TbFXsGCi51L
         in1mSRSfjRnzWyVe6zfzuXyGZf0vYwcsYLeBmmtkwWzcw1xDmeyJ7dUFa2qveCe9NbfZ
         zybQGh0DJAdDYD/K2e0llJ1x9BBRbKqENVjetpgZl82QKDjZAJfDvddYUjWAajsW7Sma
         Lhi6w3XB+CN69F3e6UjGZI9gz1nASkk1O3GH6P9MqtSZz74PTKd4WyUVlAhCsycKYseF
         lAXg4X57xX/VhZby2SVtXnxN45tIk+k7xjKqfwM/tisKvrTIvUNG7z6vetCS1AGndWJp
         5Fyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y5OMjkdRzs/CGT1kO2TrDbN9xYtVWPVC57jAXxj10Ls=;
        b=uCyzO8rwTVkmIziRwf7VEYMyyF9j3ZpXUVqfjfgE0w0XKPI+Fr8YNNCn8iDthBgeu1
         OdvEzaQP+hyn3FYfbgvnzkuszS412Gd5FErn1mP9JGTRRgcMcvKVhZ2MsvhVSWT4uquV
         tvi7aT7gqhtqJOGggCM34NVuJLKH0zutzSBaPnbkZCiVHRbsL9AgQoJmE4roNjLu6/0w
         0afWqQpA6JvB00WKC/gwTAQAzo7HBK/SoT+/gtlYc+P+hLU+0ZcngpJI8XGfSF7aXA/w
         JrQhNPuBXbljuohxsZPVvPSsZxfWsluWOyEen0HKovhWi12Gbqi0VlOK/sSzIO3lhdJ2
         qmZQ==
X-Gm-Message-State: AOAM531+ZT84R/a88S9VvHTm3fKyfXavZ7yLqbtJT2ydvYmcl+tkXGXs
        ITCMm1pDjadd65ay5O9v71M+uvMVF7I=
X-Google-Smtp-Source: ABdhPJzWuMrkahZjdXcuXAn1RvpEUQf3En5T2SGg/AusWIaH2l3/s53NVUOMRnnO4UfCjYvNVajKhQ==
X-Received: by 2002:a17:902:ec8a:b0:161:7ca5:eced with SMTP id x10-20020a170902ec8a00b001617ca5ecedmr50577514plg.17.1653796919724;
        Sat, 28 May 2022 21:01:59 -0700 (PDT)
Received: from localhost.localdomain ([115.99.139.145])
        by smtp.gmail.com with ESMTPSA id z7-20020a634c07000000b003fbfe88be17sm377581pga.24.2022.05.28.21.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 21:01:59 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC 1/2] iio: Add new event type gesture and use direction for single and double tap
Date:   Sun, 29 May 2022 09:31:52 +0530
Message-Id: <20220529040153.4878-2-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220529040153.4878-1-jagathjog1996@gmail.com>
References: <20220529040153.4878-1-jagathjog1996@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new event type for tap called gesture and the direction can be used
to differentiate single and double tap. This may be used by accelerometer
sensors to express single and double tap events. For directional tap,
modifiers like IIO_MOD_(X/Y/Z) can be used along with singletap and
doubletap direction.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 19 +++++++++++++++++++
 drivers/iio/industrialio-event.c        |  5 ++++-
 include/uapi/linux/iio/types.h          |  3 +++
 tools/iio/iio_event_monitor.c           |  8 +++++++-
 4 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 3e00d7f7ee22..2d4866203ccf 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2035,3 +2035,22 @@ Description:
 		Available range for the forced calibration value, expressed as:
 
 		- a range specified as "[min step max]"
+
+What:		/sys/.../events/in_accel_gesture_singletap_en
+What:		/sys/.../events/in_accel_gesture_doubletap_en
+KernelVersion:	5.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Accelerometer device detects single or double taps and generate
+		events when threshold for minimum tap amplitide passes.
+		E.g. a single tap event is generated when acceleration value
+		crosses the minimum tap amplitude value set. Where tap threshold
+		value is set by using in_accel_gesture_singletap_value.
+
+What:		/sys/.../events/in_accel_gesture_singletap_value
+What:		/sys/.../events/in_accel_gesture_doubletap_value
+KernelVersion:	5.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Specifies the threshold value that the device is comparing
+		against to generate the tap gesture event.
diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index b5e059e15b0a..22d59eb0a8a2 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -231,12 +231,15 @@ static const char * const iio_ev_type_text[] = {
 	[IIO_EV_TYPE_MAG_ADAPTIVE] = "mag_adaptive",
 	[IIO_EV_TYPE_CHANGE] = "change",
 	[IIO_EV_TYPE_MAG_REFERENCED] = "mag_referenced",
+	[IIO_EV_TYPE_GESTURE] = "gesture",
 };
 
 static const char * const iio_ev_dir_text[] = {
 	[IIO_EV_DIR_EITHER] = "either",
 	[IIO_EV_DIR_RISING] = "rising",
-	[IIO_EV_DIR_FALLING] = "falling"
+	[IIO_EV_DIR_FALLING] = "falling",
+	[IIO_EV_DIR_SINGLETAP] = "singletap",
+	[IIO_EV_DIR_DOUBLETAP] = "doubletap",
 };
 
 static const char * const iio_ev_info_text[] = {
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 472cead10d8d..913864221ac4 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -105,6 +105,7 @@ enum iio_event_type {
 	IIO_EV_TYPE_MAG_ADAPTIVE,
 	IIO_EV_TYPE_CHANGE,
 	IIO_EV_TYPE_MAG_REFERENCED,
+	IIO_EV_TYPE_GESTURE,
 };
 
 enum iio_event_direction {
@@ -112,6 +113,8 @@ enum iio_event_direction {
 	IIO_EV_DIR_RISING,
 	IIO_EV_DIR_FALLING,
 	IIO_EV_DIR_NONE,
+	IIO_EV_DIR_SINGLETAP,
+	IIO_EV_DIR_DOUBLETAP,
 };
 
 #endif /* _UAPI_IIO_TYPES_H_ */
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index 2f4581658859..b3b3ea399f67 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -69,12 +69,15 @@ static const char * const iio_ev_type_text[] = {
 	[IIO_EV_TYPE_MAG_ADAPTIVE] = "mag_adaptive",
 	[IIO_EV_TYPE_CHANGE] = "change",
 	[IIO_EV_TYPE_MAG_REFERENCED] = "mag_referenced",
+	[IIO_EV_TYPE_GESTURE] = "gesture",
 };
 
 static const char * const iio_ev_dir_text[] = {
 	[IIO_EV_DIR_EITHER] = "either",
 	[IIO_EV_DIR_RISING] = "rising",
-	[IIO_EV_DIR_FALLING] = "falling"
+	[IIO_EV_DIR_FALLING] = "falling",
+	[IIO_EV_DIR_SINGLETAP] = "singletap",
+	[IIO_EV_DIR_DOUBLETAP] = "doubletap",
 };
 
 static const char * const iio_modifier_names[] = {
@@ -227,6 +230,7 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_EV_TYPE_THRESH_ADAPTIVE:
 	case IIO_EV_TYPE_MAG_ADAPTIVE:
 	case IIO_EV_TYPE_CHANGE:
+	case IIO_EV_TYPE_GESTURE:
 		break;
 	default:
 		return false;
@@ -236,6 +240,8 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_EV_DIR_EITHER:
 	case IIO_EV_DIR_RISING:
 	case IIO_EV_DIR_FALLING:
+	case IIO_EV_DIR_SINGLETAP:
+	case IIO_EV_DIR_DOUBLETAP:
 	case IIO_EV_DIR_NONE:
 		break;
 	default:
-- 
2.17.1

