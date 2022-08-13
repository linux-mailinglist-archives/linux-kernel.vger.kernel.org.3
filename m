Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6AB591936
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 09:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238640AbiHMHSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 03:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238278AbiHMHSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 03:18:12 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BD85FAE8;
        Sat, 13 Aug 2022 00:18:11 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id ha11so2818904pjb.2;
        Sat, 13 Aug 2022 00:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=H+v//CJowdz+BeeZeTamwKu68BJkRamvRrjN3I5wJKE=;
        b=Ov+K7HzbazKkgOypRfaJTuYRPsQyfBmM2EvIsznIY+ydO47FBS1BFQlFR7+WfOtvyo
         SBM4vvXbTitgX6o4uNp6HOr3DQvwgB4h1mJzgMnXRVUXqRzdGgdFx+OQ/zKBHgpXakpq
         EV6Sp87fYO2qlyF4izY2k0zdv11LyIxgGVkiNzqGUbICV8S83PUOK7bQvmZw/EWNrb79
         oefNF86zvjSEU+mwf0OZT6f0zYyLR6Xx1xhMjoYKf/fqhN19dzPYO8wmp+xPiLb/PALg
         6n8sJXXVRJm4whlB9+gV0ybJVmB7wFMG2lZGLjkHLReJ2qqpSDsc2aSSH1ZclbFzMh/E
         Ypbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=H+v//CJowdz+BeeZeTamwKu68BJkRamvRrjN3I5wJKE=;
        b=dxtgD3I0O5G4IOae/AsIKbzN7lI48FISz8mMS521u2tjSTpw6WKHLMIQPHi3PSzof2
         MZgl11rMmujq9LY0vvxveKoLLHUjTOUt8DUz3xHBOs3GJU3DE6RXKY7ExIy6Viw1BQ+c
         KhOMmT6oaTSdQnNhfHamf56BVzbB59pWtK/RIqECSCKYBqbmhWWOuESkzKqnb2JetdKb
         ghu9AH1wmE0BQ7yUrSxc5EcDa3PsPanrPMImfzBnJl9P+9q8b/7Nl80q7UemlKyzWt2S
         gggra+pd7A96Okf5rlHNte6vqdgo07+eUkR6ciLeIDsAeR61eSAP2RB7nXrV2207DgwZ
         bDBA==
X-Gm-Message-State: ACgBeo1GvQUX0mzwVRK0MlBHpWxc2pVvTr1UbONQgx04GQFcB8mr4XY8
        V8ADrsqRlcTMqDV8iml/6Oo=
X-Google-Smtp-Source: AA6agR4k1BISR9GkpXkWK0ggharXt+sBmdb6n5FPKgvVS5IPKeuaIzh4LOhuZdD1S7ILEBajaLiLzQ==
X-Received: by 2002:a17:903:28f:b0:16e:e00e:31ba with SMTP id j15-20020a170903028f00b0016ee00e31bamr7580947plr.154.1660375090593;
        Sat, 13 Aug 2022 00:18:10 -0700 (PDT)
Received: from localhost.localdomain ([115.99.250.21])
        by smtp.gmail.com with ESMTPSA id r12-20020a6560cc000000b0041975999455sm2423001pgv.75.2022.08.13.00.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 00:18:10 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, andy.shevchenko@gmail.com, hadess@hadess.net,
        hdegoede@redhat.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] iio: Add new event type gesture and use direction for single and double tap
Date:   Sat, 13 Aug 2022 12:48:02 +0530
Message-Id: <20220813071803.4692-2-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220813071803.4692-1-jagathjog1996@gmail.com>
References: <20220813071803.4692-1-jagathjog1996@gmail.com>
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
 Documentation/ABI/testing/sysfs-bus-iio | 41 +++++++++++++++++++++++++
 drivers/iio/industrialio-event.c        |  7 ++++-
 include/linux/iio/types.h               |  2 ++
 include/uapi/linux/iio/types.h          |  3 ++
 tools/iio/iio_event_monitor.c           |  8 ++++-
 5 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index e81ba6f5e1c8..54cb925f714c 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2038,3 +2038,44 @@ Description:
 		Available range for the forced calibration value, expressed as:
 
 		- a range specified as "[min step max]"
+
+What:		/sys/.../events/in_accel_gesture_singletap_en
+What:		/sys/.../events/in_accel_gesture_doubletap_en
+KernelVersion:	5.21
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Device generates an event on a single or double tap.
+
+What:		/sys/.../events/in_accel_gesture_singletap_value
+What:		/sys/.../events/in_accel_gesture_doubletap_value
+KernelVersion:	5.21
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Specifies the threshold value that the device is comparing
+		against to generate the tap gesture event. Units and exact
+		meaning of value are device specific.
+
+What:		/sys/.../events/in_accel_gesture_singletap_reset_timeout
+What:		/sys/.../events/in_accel_gesture_doubletap_reset_timeout
+KernelVersion:	5.21
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Specifies the timeout value in seconds for the tap detector
+		to not to look for another tap event after the event as
+		occoured. Basically the minimum quiet time between the two
+		single-tap's or two double-tap's.
+
+What:		/sys/.../events/in_accel_gesture_doubletap_tap_2min_delay
+KernelVersion:	5.21
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Specifies the minimum quiet time in seconds between the two
+		taps of a double tap.
+
+What:		/sys/.../events/in_accel_gesture_maxtomin_time
+KernelVersion:	5.21
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Specifies the maximum time difference allowed between upper
+		and lower peak of tap to consider it as the valid tap event.
+		Units in seconds.
diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index b5e059e15b0a..b63be2a4ac02 100644
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
+	[IIO_EV_INFO_TAP_2MIN_DELAY] = "tap_2min_delay",
 };
 
 static enum iio_event_direction iio_ev_attr_dir(struct iio_dev_attr *attr)
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index a7aa91f3a8dc..e33069d6a3d8 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -17,6 +17,8 @@ enum iio_event_info {
 	IIO_EV_INFO_HIGH_PASS_FILTER_3DB,
 	IIO_EV_INFO_LOW_PASS_FILTER_3DB,
 	IIO_EV_INFO_TIMEOUT,
+	IIO_EV_INFO_RESET_TIMEOUT,
+	IIO_EV_INFO_TAP_2MIN_DELAY,
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

