Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01395A76A9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 08:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiHaGbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 02:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiHaGb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 02:31:28 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F5CB4EB4;
        Tue, 30 Aug 2022 23:31:26 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id mj6so8178417pjb.1;
        Tue, 30 Aug 2022 23:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=q2CGYVvZJHebKb3NsH/50oGHEhc189ycTOR07ytpgm8=;
        b=qdFaE0028T/JAnbIfaI9jP6AxwYtymj0fZexLpE5kDMpM+IBVuHCH0aqlDzY+tAEx0
         PEHkP34Pa9/su2dlDpIMrSRlhG+4tU5U+IPwEPbQBa7/2JFhWQZt1ZkZFnjeS61rdA/X
         W8wAoOyhgiCuSGdTXrhWz5GBimjOE0CSbXv+MOC+wu7luE6mg8IPkw3AClsxiSIIcJwI
         oXefuZEkGiLI74t6qtTn/ydxzc8mH7RhPpMRzWBKRhpbGMirVy0Wg3QJYmB+2m7ffE6X
         QEWeyrg5dytB25q6cRd8XiZeIoLF9Gd7zoLMpzV914TPr6lwTZkdqfNdxn81hDWbbzEj
         AvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=q2CGYVvZJHebKb3NsH/50oGHEhc189ycTOR07ytpgm8=;
        b=7qHgu44U6gTLkAsODRHGRHwfZCrTRhk9lOhhfx8kP7Mbcc/uVhT0mndCgg4BBitpov
         bKLQOPfeHkFWhsjpU9ApQ5a4ck9XfLQ73lBFqGbEJtz2EJ9rFP3pXZowVwEgd1xguElv
         z0Bw0G6sBgvNBb6eJOXcGW9brDLxrH71vrNa25yH07H8iKnfWCwdG++eizbzYlTJVKiz
         TD+4cihGHF/SveqhhUsUcdpQuEcusqMm6RojBm8cLvAOPImT9nt1ocd4TYXKNqdR5PN7
         o6oP8JATtqxoYRCKYQdGmxY9BmM4BBZsvmjyPhTjPoP5jGliWDvxr0VMdXKMqbP05SR2
         KDCQ==
X-Gm-Message-State: ACgBeo07K6X14DoS+y9dWz9LPRHhl+qBp61Tj6yd5ZvDYMm5ZHYXlro3
        ZJzPsLGH/0Q5t859BCTjrN8=
X-Google-Smtp-Source: AA6agR469xBKb6C0MPbyxGhM33H7XJlAu+6n6rzggrXGSokOZ/98ops87x3A8hFBFFrOClCzRhffDQ==
X-Received: by 2002:a17:902:c94f:b0:175:298:377a with SMTP id i15-20020a170902c94f00b001750298377amr9168511pla.133.1661927485338;
        Tue, 30 Aug 2022 23:31:25 -0700 (PDT)
Received: from localhost.localdomain ([115.99.190.245])
        by smtp.gmail.com with ESMTPSA id z30-20020a62d11e000000b0052d24402e52sm10362220pfg.79.2022.08.30.23.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 23:31:24 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, andy.shevchenko@gmail.com, hadess@hadess.net,
        hdegoede@redhat.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] iio: Add new event type gesture and use direction for single and double tap
Date:   Wed, 31 Aug 2022 12:01:16 +0530
Message-Id: <20220831063117.4141-2-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220831063117.4141-1-jagathjog1996@gmail.com>
References: <20220831063117.4141-1-jagathjog1996@gmail.com>
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

