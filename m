Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54EDB5A19C3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 21:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243323AbiHYTqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 15:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239857AbiHYTqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 15:46:15 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780EA58B6E;
        Thu, 25 Aug 2022 12:46:14 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id 67so12601921pfv.2;
        Thu, 25 Aug 2022 12:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=q2CGYVvZJHebKb3NsH/50oGHEhc189ycTOR07ytpgm8=;
        b=aQvjRQDRC2KN0JUnRr7YcSOyknJ+LtQeZ/5/aPot78P/QMJ73xi4RxcL4fwexVVXYD
         7uljwpRPsi53WyAo16nqTqjj+TiuKcGe+iUitjBAKXIjuAgujCZwckw+jwjyRJFRVCOs
         2Iy6Sa60VbLY/plTHEq5WoGTwEh9b73jskwBHLJqyMQ29VkeFnGdAVaTXZVwZHLNXNNH
         lBOpaH6X47PZX9rfF7lvkttYgseSz5PlVju/ENeEngvZVB4g4b1FyO9KyhMeqJ1Kaum4
         5yjKyAysEX7WEO6ThKh4wZgW1kyNzJkd926jETX0J+FFn2eYEqNHNcQR/fL5GrXwOlCX
         OFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=q2CGYVvZJHebKb3NsH/50oGHEhc189ycTOR07ytpgm8=;
        b=auGASO9FuIq3iEFIFgkpco3RVleMhMeMPcANl+VrVkNhw8+Zth7Ib3KrlWGHyxGCUQ
         Kw6aJA2NunaPMxyjuSRFZRnZ1tJv/GRJRTR/4SD1QKgnMiM2njIDuuJmuujmGCVX8ps8
         bvGXEBuYir3yULU5n/bNl+B7eTSQ68v7r3FqlONjwlW4KNQXyfPeWJL01uhqF+n4FGgN
         9wQ+rpZLeEPNZ+YCi1PSEjRoxbO3+eAunCnJ+x3cCUTsb8e3JY9ZPU+21WGLThkPMw1X
         Ftvu3ncQMLp4JAdIUbhbAtqfblmeWOkJNiwk3xmvW4gs52Z6ns0CNrp2UfnzQ6/TfJbZ
         b2XA==
X-Gm-Message-State: ACgBeo0qeIZ6dm34p9xMvxB2Z66tKw/73u+2VYaYiqOc1ko6V1f1cHFG
        CyiYIKjZEZD0lfsYdvlo7bpXKEq0PWs=
X-Google-Smtp-Source: AA6agR6Doelj7h4b6BEO7Ifv0OcUk/Fw41dpQvL22bF2XTJWM5DZ/UWx/7Pvmr4HyUaw56y9v2scHw==
X-Received: by 2002:a05:6a00:a04:b0:534:d8a6:40ce with SMTP id p4-20020a056a000a0400b00534d8a640cemr538338pfh.15.1661456773892;
        Thu, 25 Aug 2022 12:46:13 -0700 (PDT)
Received: from localhost.localdomain ([115.99.106.178])
        by smtp.gmail.com with ESMTPSA id d32-20020a17090a6f2300b001f7a76d6f28sm108789pjk.18.2022.08.25.12.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 12:46:13 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, andy.shevchenko@gmail.com, hadess@hadess.net,
        hdegoede@redhat.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] iio: Add new event type gesture and use direction for single and double tap
Date:   Fri, 26 Aug 2022 01:16:03 +0530
Message-Id: <20220825194604.15645-2-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220825194604.15645-1-jagathjog1996@gmail.com>
References: <20220825194604.15645-1-jagathjog1996@gmail.com>
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
 Documentation/ABI/testing/sysfs-bus-iio | 69 +++++++++++++++++++++++++
 drivers/iio/industrialio-event.c        |  7 ++-
 include/linux/iio/types.h               |  2 +
 include/uapi/linux/iio/types.h          |  3 ++
 tools/iio/iio_event_monitor.c           |  8 ++-
 5 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index e81ba6f5e1c8..4035173030b7 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2038,3 +2038,72 @@ Description:
 		Available range for the forced calibration value, expressed as:
 
 		- a range specified as "[min step max]"
+
+What:		/sys/.../events/in_accel_gesture_singletap_en
+What:		/sys/.../events/in_accel_gesture_doubletap_en
+KernelVersion:	6.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Device generates an event on a single or double tap.
+
+What:		/sys/.../events/in_accel_gesture_singletap_value
+What:		/sys/.../events/in_accel_gesture_doubletap_value
+KernelVersion:	6.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Specifies the threshold value that the device is comparing
+		against to generate the tap gesture event. The lower
+		threshold value increases the sensitivity of tap detection.
+		Units and the exact meaning of value are device-specific.
+
+What:		/sys/.../events/in_accel_gesture_tap_value_available
+KernelVersion:	6.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Lists all available threshold values which can be used to
+		modify the sensitivity of the tap detection.
+
+What:		/sys/.../events/in_accel_gesture_singletap_reset_timeout
+What:		/sys/.../events/in_accel_gesture_doubletap_reset_timeout
+KernelVersion:	6.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Specifies the timeout value in seconds for the tap detector
+		to not to look for another tap event after the event as
+		occurred. Basically the minimum quiet time between the two
+		single-tap's or two double-tap's.
+
+What:		/sys/.../events/in_accel_gesture_tap_reset_timeout_available
+KernelVersion:	6.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Lists all available tap reset timeout values. Units in seconds.
+
+What:		/sys/.../events/in_accel_gesture_doubletap_tap2_min_delay
+KernelVersion:	6.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Specifies the minimum quiet time in seconds between the two
+		taps of a double tap.
+
+What:		/sys/.../events/in_accel_gesture_doubletap_tap2_min_delay_available
+KernelVersion:	6.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Lists all available delay values between two taps in the double
+		tap. Units in seconds.
+
+What:		/sys/.../events/in_accel_gesture_tap_maxtomin_time
+KernelVersion:	6.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Specifies the maximum time difference allowed between upper
+		and lower peak of tap to consider it as the valid tap event.
+		Units in seconds.
+
+What:		/sys/.../events/in_accel_gesture_tap_maxtomin_time_available
+KernelVersion:	6.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Lists all available time values between upper peak to lower
+		peak. Units in seconds.
diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index b5e059e15b0a..65ef0fc3be23 100644
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
@@ -247,6 +250,8 @@ static const char * const iio_ev_info_text[] = {
 	[IIO_EV_INFO_HIGH_PASS_FILTER_3DB] = "high_pass_filter_3db",
 	[IIO_EV_INFO_LOW_PASS_FILTER_3DB] = "low_pass_filter_3db",
 	[IIO_EV_INFO_TIMEOUT] = "timeout",
+	[IIO_EV_INFO_RESET_TIMEOUT] = "reset_timeout",
+	[IIO_EV_INFO_TAP2_MIN_DELAY] = "tap2_min_delay",
 };
 
 static enum iio_event_direction iio_ev_attr_dir(struct iio_dev_attr *attr)
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index a7aa91f3a8dc..4716a4b3d614 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -17,6 +17,8 @@ enum iio_event_info {
 	IIO_EV_INFO_HIGH_PASS_FILTER_3DB,
 	IIO_EV_INFO_LOW_PASS_FILTER_3DB,
 	IIO_EV_INFO_TIMEOUT,
+	IIO_EV_INFO_RESET_TIMEOUT,
+	IIO_EV_INFO_TAP2_MIN_DELAY,
 };
 
 #define IIO_VAL_INT 1
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

