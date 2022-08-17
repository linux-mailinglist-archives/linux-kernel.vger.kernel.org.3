Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2748597553
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 19:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240036AbiHQRvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 13:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238328AbiHQRvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 13:51:41 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E004F7A75A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 10:51:39 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id o14-20020a17090a0a0e00b001fabfd3369cso1297236pjo.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 10:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yocom-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Rm03kdd5pGdzOHdddpGCv8ErrczhXETsQw8dLYIZL0M=;
        b=1uPKWl+apyqatLAu66fj0JNNHmuDuVVQccZvz5HSwyetKNz9JnbhyZIVDm1Hj4Ltry
         5cwbKmpezbMiIbaV3Mf2hrzArnOK+45hBOvHLh66sSzCvGr+kfGTwWyfFf558whTM0I7
         jSH5+kpUiTlx+hmETztwQJqEme/XafLd5keDmK6wPlKI219bd4L2g4hcVN6oOipGWe/o
         n/tiot5+yh/Dv0i7YJQX4HhzBoKuFGwlS96rdTo1dYx9BQw5QMGBjng+JZmQl+axvam2
         0mXpqKZnrc2CIafBo9646ZTEJHVw9cnP5byCMfkKsCbRq4cF94pIZrOM4niGgiiD7TCA
         2xww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Rm03kdd5pGdzOHdddpGCv8ErrczhXETsQw8dLYIZL0M=;
        b=62kWGQVI22D6+qglIsMsH/Ym2fZ2uSTjfK8TdJpzJD9IUbcHQkwNe7i2ZuBqfv17+c
         O8JNlEOTfiKStfEeuHRXZBj+rAnH0BzdKD+3lckx0Cvaf90O58SD5udPN8bPMMXRtBvO
         XFIC7EmjhJVgvWFGz/QavG052Aq1f/MQUOhjfDWaYvC8tynb1cKf2Meno7y1UeQWm3rt
         VsDLgMmSK/F1vCeiI4N0bmar1dGnkBoQicYRyEY7eTfx6K+aG7KRnZzguN2zXt5PKbAd
         9S2Hq5oQnboDky2+eBkVnWXBbnS4OM7Nv1834jalHWNM1h8HYEbIFbZ+S1K0eNNE7tP3
         HXNA==
X-Gm-Message-State: ACgBeo2zet2MyD21/kkRxLnkgoH2BGhcuqcrRnzLGDjlm7b7HFJ2mqQk
        g9UYXACgogKQ+LuBUwJ3BtuOfw==
X-Google-Smtp-Source: AA6agR6TLuX0lYssHXw9af8lp2B1LND3h0QRniPS5UVzXlF9zI1nlmYE0VtjJu6SENiEqfXr4mehvQ==
X-Received: by 2002:a17:903:22c7:b0:171:516d:d2a4 with SMTP id y7-20020a17090322c700b00171516dd2a4mr27699865plg.98.1660758699407;
        Wed, 17 Aug 2022 10:51:39 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:8f80:973::5f])
        by smtp.gmail.com with ESMTPSA id z29-20020aa7991d000000b0052f0a616a87sm10734127pff.168.2022.08.17.10.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 10:51:38 -0700 (PDT)
From:   Nate Yocom <nate@yocom.org>
To:     dmitry.torokhov@gmail.com
Cc:     nate@yocom.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, hadess@hadess.net
Subject: [PATCH v4 2/3] Input: joystick: xpad: Add X-Box Adaptive Controller Profile button
Date:   Wed, 17 Aug 2022 10:51:33 -0700
Message-Id: <20220817175134.15084-3-nate@yocom.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220817175134.15084-1-nate@yocom.org>
References: <20220817175134.15084-1-nate@yocom.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a new quirk for controllers that have a Profile button which has 4
states, reflected as an ABS_MISC axis with 4 values.

Signed-off-by: Nate Yocom <nate@yocom.org>
Tested-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/input/joystick/xpad.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index c8b38bb73d34..561e097396fb 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -80,6 +80,7 @@
 #define MAP_TRIGGERS_TO_BUTTONS		(1 << 1)
 #define MAP_STICKS_TO_NULL		(1 << 2)
 #define MAP_SELECT_BUTTON		(1 << 3)
+#define MAP_PROFILE_BUTTON		(1 << 4)
 #define DANCEPAD_MAP_CONFIG	(MAP_DPAD_TO_BUTTONS |			\
 				MAP_TRIGGERS_TO_BUTTONS | MAP_STICKS_TO_NULL)
 
@@ -131,7 +132,7 @@ static const struct xpad_device {
 	{ 0x045e, 0x02e3, "Microsoft X-Box One Elite pad", 0, XTYPE_XBOXONE },
 	{ 0x045e, 0x02ea, "Microsoft X-Box One S pad", 0, XTYPE_XBOXONE },
 	{ 0x045e, 0x0719, "Xbox 360 Wireless Receiver", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
-	{ 0x045e, 0x0b0a, "Microsoft X-Box Adaptive Controller", 0, XTYPE_XBOXONE },
+	{ 0x045e, 0x0b0a, "Microsoft X-Box Adaptive Controller", MAP_PROFILE_BUTTON, XTYPE_XBOXONE },
 	{ 0x045e, 0x0b12, "Microsoft Xbox Series S|X Controller", MAP_SELECT_BUTTON, XTYPE_XBOXONE },
 	{ 0x046d, 0xc21d, "Logitech Gamepad F310", 0, XTYPE_XBOX360 },
 	{ 0x046d, 0xc21e, "Logitech Gamepad F510", 0, XTYPE_XBOX360 },
@@ -927,6 +928,10 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 				 (__u16) le16_to_cpup((__le16 *)(data + 8)));
 	}
 
+	/* Profile button has a value of 0-4, so it is reported as an axis */
+	if (xpad->mapping & MAP_PROFILE_BUTTON)
+		input_report_abs(dev, ABS_MISC, data[34]);
+
 	input_sync(dev);
 }
 
@@ -1623,6 +1628,9 @@ static void xpad_set_up_abs(struct input_dev *input_dev, signed short abs)
 	case ABS_HAT0Y:	/* the d-pad (only if dpad is mapped to axes */
 		input_set_abs_params(input_dev, abs, -1, 1, 0, 0);
 		break;
+	case ABS_MISC: /* 4 value profile button (such as on XAC) */
+		input_set_abs_params(input_dev, abs, 0, 4, 0, 0);
+		break;
 	default:
 		input_set_abs_params(input_dev, abs, 0, 0, 0, 0);
 		break;
@@ -1715,6 +1723,10 @@ static int xpad_init_input(struct usb_xpad *xpad)
 			xpad_set_up_abs(input_dev, xpad_abs_triggers[i]);
 	}
 
+	/* setup profile button as an axis with 4 possible values */
+	if (xpad->mapping & MAP_PROFILE_BUTTON)
+		xpad_set_up_abs(input_dev, ABS_MISC);
+
 	error = xpad_init_ff(xpad);
 	if (error)
 		goto err_free_input;
-- 
2.30.2

