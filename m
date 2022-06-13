Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CDD549F1A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbiFMUaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351430AbiFMU3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:29:01 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291B231DCC;
        Mon, 13 Jun 2022 12:17:15 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id i1so5887149plg.7;
        Mon, 13 Jun 2022 12:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OsndtfIFvjAN0vmGEALhpWubnfNM0blfjuiVYh8Ul98=;
        b=L0t7SSNZHKugW2OgO+nOAw8CBA0oPLniKexBiNpyFfCJqyJA6gqkq7Dtp58+9Rl9A8
         MnMui4YTFkD/iXr1H/EZuQbZBz9xj/8c22FK2QLmvL8bEsatGvHNiR0QRgBzvfiWANJk
         B3KNDhQb2EMpoQWscxLGJTBmyixcfHbGhfNhkxgjCwy6j8LEzzFNz2tEoI7gbHg1wZvQ
         F6ss+sltXZLVtE9moHwbNwe/MDW41ejAMdFd4Ox9Mbhef5aG4dKleS1oLwanNJyh23Fu
         Mim6aF5BnuMipz/1VBWs/cMKjKmndMkd56GF2pqe5+8WDL9O9/MRjZXOwfkLXsN1efL9
         YJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OsndtfIFvjAN0vmGEALhpWubnfNM0blfjuiVYh8Ul98=;
        b=Z9zsjvAFv2gQpXu8cIpJ0erRS0bUNSE3eppIWsgURsP8yXex2y1aXb3F56XsWvP7H4
         CpBCqwkvnh+VSqRAy8diU4/qhg5IXzgMqOZB4U33hpE832ZsrcF88OM9qDVOt9PWVthj
         K9RGu9FzWNed3uHNVyGyvMTtoFehDXsGP4g18beX2TJUDPvwY/WAXodjNrB+d8fPox4c
         zkipikxruYHWddwdhVBZa/nj5uxALs57TnBLyB02oSri0Oir2MVSOAMzHUCGStDLowQp
         kt3opN5a/W7r7TuTX760SKDiGM6m01eClFmMaNbR3Pnq0eKr6MDXrre7kLUsp16FTkBJ
         bGGw==
X-Gm-Message-State: AJIora+CNad6HI6gd/HPT+B3doTI1w+QJlYvM9gqFeIEic8q6yYiHjCK
        hmigzD1glUoQOQfbvBiwJV50gbL39XU=
X-Google-Smtp-Source: AGRyM1sbwglEx0BlPhMMOZNE0jpEXe76n+4iqU4Ih7zHedDYjv1uDixwYjmV6lhROhzVG7idWlSU5w==
X-Received: by 2002:a17:902:c40d:b0:164:1a71:f7c0 with SMTP id k13-20020a170902c40d00b001641a71f7c0mr465121plk.90.1655147834531;
        Mon, 13 Jun 2022 12:17:14 -0700 (PDT)
Received: from localhost.localdomain ([60.243.255.226])
        by smtp.gmail.com with ESMTPSA id x15-20020a17090abc8f00b001e310303275sm5567202pjr.54.2022.06.13.12.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 12:17:13 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] iio: Add new event type gesture and use direction for single and double tap
Date:   Tue, 14 Jun 2022 00:47:05 +0530
Message-Id: <20220613191706.31239-2-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220613191706.31239-1-jagathjog1996@gmail.com>
References: <20220613191706.31239-1-jagathjog1996@gmail.com>
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
 Documentation/ABI/testing/sysfs-bus-iio | 24 ++++++++++++++++++++++++
 drivers/iio/industrialio-event.c        |  5 ++++-
 include/uapi/linux/iio/types.h          |  3 +++
 tools/iio/iio_event_monitor.c           |  8 +++++++-
 4 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 3e00d7f7ee22..4eaf85e01911 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2035,3 +2035,27 @@ Description:
 		Available range for the forced calibration value, expressed as:
 
 		- a range specified as "[min step max]"
+
+What:		/sys/.../events/in_accel_gesture_singletap_en
+What:		/sys/.../events/in_accel_gesture_doubletap_en
+KernelVersion:	5.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Device generates an event on a single or double tap.
+
+What:		/sys/.../events/in_accel_gesture_singletap_value
+What:		/sys/.../events/in_accel_gesture_doubletap_value
+KernelVersion:	5.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Specifies the threshold value that the device is comparing
+		against to generate the tap gesture event. Units and exact
+		meaning of value are device specific.
+
+What:		/sys/.../events/in_accel_gesture_doubletap_period
+KernelVersion:	5.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Minimum time period between before and after the double tap
+		event. Units and exact meaning of period value are device
+		specific.
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

