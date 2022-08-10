Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94AD358E406
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 02:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiHJAUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 20:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiHJAUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 20:20:31 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696E0B05
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 17:20:28 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id 17so3460210pli.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 17:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yocom-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=1x7SOVtOei70cdAgsBLTaDzhKWbFRtoFMWwMze/rFM8=;
        b=RFUpjh/DphoZwLHaoft5BHiz2a9zHUo26WJH+Wv8XymWhJs5KZJNzguPNytnzagpC8
         obsMdqT2SP28aUZohDbG7TY6HXkXk+VakdhhiPwJMPaGuQHGRK9imgrpR1JHujJ4/mjR
         Ws02oUgfMZFBsOl+SYDkW5T2DThfQ6zR/hQvGEjrDhuoyGaGNRAYbteN+s2RTn3R6Hz8
         qg8ofbAUlNAdnsMO4GyRRwr1cojH/77dbIq0kLBXC4EKM/sAIPRAoJR7JqYl09i9z7JV
         hjZrpiyDVliI0Jg6dcLrT/QA5+E3hotNVmd/NZfYVXKh4cl8DC2Wwy1kfA8k5k+IYvlH
         Vppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=1x7SOVtOei70cdAgsBLTaDzhKWbFRtoFMWwMze/rFM8=;
        b=Twx3EnZCCBAu6AsMPdBA5z+nHmg6DjuRgQRr9Ha8zfZjzj0pjOuXS4hxis1kntjBbA
         8bS/v4uojaHixjGAGLcwc56fIEOwResx7OKXGHugs355INNQyq/CWW+JuW9UreMubIlu
         zCBW54ZB8TdS2ekhSsKQ8gbQkvtPqqlg7+P7IYbVbVWIo2FTzFAUVfjxuJn9/6RDYniL
         n9UbJ/uWupH0S1ve1SmP2pPwPUmiwqHk1S6PPsuAdSS+yHiuGRuijHCkn8RgrH4eN+CX
         3kGxKlG9XquRQz1aX+7YRAbn0duFQg48NiKdeFjB6kwRB569HktP7/Qsb9aZ41DMMvL/
         CRKQ==
X-Gm-Message-State: ACgBeo0vL6qbdQRpa++7+hux4m3KCgSDQley8fqEzIuL4JSW+2fOd77l
        og5ubEoZSxUK5NJX0lycpOWGbnGjihhm7mA3
X-Google-Smtp-Source: AA6agR4x3Y5olBaNr/fKSPGTFcGSwGvHlG3yZELirqR8W/0dyJiu5xlfDN5BpskP8ZYzQF7YwuayIg==
X-Received: by 2002:a17:902:8486:b0:16d:d4b1:ceb6 with SMTP id c6-20020a170902848600b0016dd4b1ceb6mr25708252plo.33.1660090827919;
        Tue, 09 Aug 2022 17:20:27 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:a07f:e6ac::1c])
        by smtp.gmail.com with ESMTPSA id i22-20020aa796f6000000b0050dc7628183sm495325pfq.93.2022.08.09.17.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 17:20:27 -0700 (PDT)
From:   Nate Yocom <nate@yocom.org>
To:     dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        nate@yocom.org
Subject: [PATCH] Input: joystick: xpad: Add X-Box Adaptive Controller support
Date:   Tue,  9 Aug 2022 17:20:24 -0700
Message-Id: <20220810002024.13686-1-nate@yocom.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for the X-Box Adaptive Controller, which is protocol
compatible with the XTYPE_XBOXONE support in the driver with two deltas:

 - The X-Box button sets 0x02 as its activation ID, where others set
   0x01
 - The controller has an additional "Layer" button with 4 active states,
   which this change maps to an Axis control with 4 possible values

Signed-off-by: Nate Yocom <nate@yocom.org>
---
 drivers/input/joystick/xpad.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 18190b529bca..0d02d88790b6 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -80,6 +80,7 @@
 #define MAP_TRIGGERS_TO_BUTTONS		(1 << 1)
 #define MAP_STICKS_TO_NULL		(1 << 2)
 #define MAP_SELECT_BUTTON		(1 << 3)
+#define MAP_LAYER_BUTTON		(1 << 4)
 #define DANCEPAD_MAP_CONFIG	(MAP_DPAD_TO_BUTTONS |			\
 				MAP_TRIGGERS_TO_BUTTONS | MAP_STICKS_TO_NULL)
 
@@ -131,6 +132,7 @@ static const struct xpad_device {
 	{ 0x045e, 0x02e3, "Microsoft X-Box One Elite pad", 0, XTYPE_XBOXONE },
 	{ 0x045e, 0x02ea, "Microsoft X-Box One S pad", 0, XTYPE_XBOXONE },
 	{ 0x045e, 0x0719, "Xbox 360 Wireless Receiver", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
+	{ 0x045e, 0x0b0a, "Microsoft X-Box Adaptive Controller", MAP_LAYER_BUTTON, XTYPE_XBOXONE },
 	{ 0x045e, 0x0b12, "Microsoft Xbox Series S|X Controller", MAP_SELECT_BUTTON, XTYPE_XBOXONE },
 	{ 0x046d, 0xc21d, "Logitech Gamepad F310", 0, XTYPE_XBOX360 },
 	{ 0x046d, 0xc21e, "Logitech Gamepad F510", 0, XTYPE_XBOX360 },
@@ -857,7 +859,17 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 		if (data[1] == 0x30)
 			xpadone_ack_mode_report(xpad, data[2]);
 
-		input_report_key(dev, BTN_MODE, data[4] & 0x01);
+		/*
+		 * X-Box Adaptive controller sets 0x02 when x-box button is pressed,
+		 * we could probably condense into just data[4] != 0, but explicitly
+		 * checking here ensures no regression if other devices set other bits.
+		 */
+		if (le16_to_cpu(xpad->dev->id.vendor) == 0x045e &&
+			le16_to_cpu(xpad->dev->id.product) == 0x0b0a)
+			input_report_key(dev, BTN_MODE, data[4] & 0x02);
+		else
+			input_report_key(dev, BTN_MODE, data[4] & 0x01);
+
 		input_sync(dev);
 		return;
 	}
@@ -926,6 +938,10 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 				 (__u16) le16_to_cpup((__le16 *)(data + 8)));
 	}
 
+	/* Layer button has a value of 0-4, so its reported as an axis */
+	if (xpad->mapping & MAP_LAYER_BUTTON)
+		input_report_abs(dev, ABS_MISC, data[34]);
+
 	input_sync(dev);
 }
 
@@ -1622,6 +1638,8 @@ static void xpad_set_up_abs(struct input_dev *input_dev, signed short abs)
 	case ABS_HAT0Y:	/* the d-pad (only if dpad is mapped to axes */
 		input_set_abs_params(input_dev, abs, -1, 1, 0, 0);
 		break;
+	case ABS_MISC: /* 4 value layer button (such as on the XAC) */
+		input_set_abs_params(input_dev, abs, 0, 4, 0, 0);
 	default:
 		input_set_abs_params(input_dev, abs, 0, 0, 0, 0);
 		break;
@@ -1714,6 +1732,10 @@ static int xpad_init_input(struct usb_xpad *xpad)
 			xpad_set_up_abs(input_dev, xpad_abs_triggers[i]);
 	}
 
+	/* setup layer buton as an axis with 4 possible values */
+	if (xpad->mapping & MAP_LAYER_BUTTON)
+		xpad_set_up_abs(input_dev, ABS_MISC);
+
 	error = xpad_init_ff(xpad);
 	if (error)
 		goto err_free_input;
-- 
2.30.2

