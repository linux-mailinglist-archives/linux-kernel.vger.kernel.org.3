Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3A449633A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 17:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379682AbiAUQ4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 11:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379753AbiAUQzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 11:55:04 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B6FC061748;
        Fri, 21 Jan 2022 08:54:54 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id c3-20020a9d6c83000000b00590b9c8819aso12498612otr.6;
        Fri, 21 Jan 2022 08:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WfWZ8z/c/kEADyr83ZdSZ7HmhzMbcPfKaXMwZ33jf64=;
        b=QB83QpSASmCXMToFqXDtKMEQRhXoMgyyyCiWNfu8VEiMPRd4Lp9HrXXmUaY/bN+74s
         bwRWXUaMr6Tun1Bg7/dWpT3nmESJOGlHDjUU429H4HH9IX3RlADya7L78fr4ysnpuWsM
         ZEBdIDFB3pj9VFbTbxRv2TXP8PHt64lo88E+tTC8NK+Ipn7Hl8hk+EQGg94XKEVnESc8
         q+8Wts7mftymr7j7CdzS/rb8N5J2S2hfUl0ld+m9a+yMmAo5IRYuApGKVhm0m6kgUCru
         zEPP+bxNr7W+1Wwz5QZkC3UfAXAPRvMmJIfAe4Iu2NCOkgF9IhT43yg480OIkrsY4U9q
         TQrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WfWZ8z/c/kEADyr83ZdSZ7HmhzMbcPfKaXMwZ33jf64=;
        b=i7FP1UeXc8gg+WI3l98bcM7H5Xa5ItoYafh2oA9uA26pSYBEalJQZAcsJwugHHhCok
         qfSyPixDOUhu5QckiI0JkT7uxNt1+/W+zLsWtQza11LHiQWSbNEdgWhOOSKRFPUjZ4Vc
         uZhhYs7H07lrX78KMpKBSLuxr7j3XvNE0WMj9U8sFvkbMw7HYO1o/sb5m/Kof7/j9bim
         /GMbSQ4/oVVm+yZSgz3uKIJwt2xOUTMxFZ3y0zLu1crd4JRzRqgF1cedwKtVLCvvAdzc
         07mt8Jy0H5LdwWy5c0LpRxUdhl1pOdNY9HtcMPVFmX/coVCWgbFWUSkn96eXmmxdFjwn
         TWJA==
X-Gm-Message-State: AOAM5326WPIl/tgQskE7Fd0TEVzHJ0G7dJOIPYpBiZcUxjA8F5MOsebI
        3HWipmsIBFaMyanVBGMLTHG9NsdHpos=
X-Google-Smtp-Source: ABdhPJzu1YXz0p2R3AreojsTRQmVu1cEtFeHh4gHzGHQ2i4QnVquGgkJyRDCzA+AyL+U0X7fJBrO1g==
X-Received: by 2002:a05:6830:3152:: with SMTP id c18mr3442539ots.244.1642784093746;
        Fri, 21 Jan 2022 08:54:53 -0800 (PST)
Received: from thinkpad.localdomain ([2804:14d:5cd1:5d03:cf72:4317:3105:f6e5])
        by smtp.gmail.com with ESMTPSA id y8sm1089271oou.23.2022.01.21.08.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 08:54:53 -0800 (PST)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Luiz Sampaio <sampaio.ime@gmail.com>,
        linux-media@vger.kernel.org
Subject: [PATCH 10/31] media: radio: changing LED_* from enum led_brightness to actual value
Date:   Fri, 21 Jan 2022 13:54:15 -0300
Message-Id: <20220121165436.30956-11-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121165436.30956-1-sampaio.ime@gmail.com>
References: <20220121165436.30956-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enum led_brightness, which contains the declaration of LED_OFF,
LED_ON, LED_HALF and LED_FULL is obsolete, as the led class now supports
max_brightness.
---
 drivers/media/radio/radio-shark.c  | 6 +++---
 drivers/media/radio/radio-shark2.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/media/radio/radio-shark.c b/drivers/media/radio/radio-shark.c
index 8230da828d0e..7998b75df525 100644
--- a/drivers/media/radio/radio-shark.c
+++ b/drivers/media/radio/radio-shark.c
@@ -217,19 +217,19 @@ static void shark_led_set_red(struct led_classdev *led_cdev,
 static const struct led_classdev shark_led_templates[NO_LEDS] = {
 	[BLUE_LED] = {
 		.name		= "%s:blue:",
-		.brightness	= LED_OFF,
+		.brightness	= 0,
 		.max_brightness = 127,
 		.brightness_set = shark_led_set_blue,
 	},
 	[BLUE_PULSE_LED] = {
 		.name		= "%s:blue-pulse:",
-		.brightness	= LED_OFF,
+		.brightness	= 0,
 		.max_brightness = 255,
 		.brightness_set = shark_led_set_blue_pulse,
 	},
 	[RED_LED] = {
 		.name		= "%s:red:",
-		.brightness	= LED_OFF,
+		.brightness	= 0,
 		.max_brightness = 1,
 		.brightness_set = shark_led_set_red,
 	},
diff --git a/drivers/media/radio/radio-shark2.c b/drivers/media/radio/radio-shark2.c
index d150f12382c6..776877a294d8 100644
--- a/drivers/media/radio/radio-shark2.c
+++ b/drivers/media/radio/radio-shark2.c
@@ -189,13 +189,13 @@ static void shark_led_set_red(struct led_classdev *led_cdev,
 static const struct led_classdev shark_led_templates[NO_LEDS] = {
 	[BLUE_LED] = {
 		.name		= "%s:blue:",
-		.brightness	= LED_OFF,
+		.brightness	= 0,
 		.max_brightness = 127,
 		.brightness_set = shark_led_set_blue,
 	},
 	[RED_LED] = {
 		.name		= "%s:red:",
-		.brightness	= LED_OFF,
+		.brightness	= 0,
 		.max_brightness = 1,
 		.brightness_set = shark_led_set_red,
 	},
-- 
2.34.1

