Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF8D58EE02
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 16:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiHJOPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 10:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiHJOP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 10:15:27 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8199F24F2E
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 07:15:24 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id z19so14369598plb.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 07:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yocom-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=DE7kWGPbgjvQmtjthwX9rNykAQvMNixqw5ivlEeVRls=;
        b=uQDghEUL+SZyNQ2MOFoedH1eRmbX7kmqp5AlET/aLVOMztOSypPG2iH7alqQOmM3VT
         tJvPZHj4tWXTd410fGwkWsisBkBKH0qC1y+cPcUizvgIon2c3XYY0JRAhFaoHj8kTlbL
         NyKpXedCmRKHas66ZBKZ+tr0Ye1t+TG6KFHOl015aQpxdmFfxt8HOFnqZIsRnEpd81M6
         h5BVBBU2ULAWfFiu/JPOISkHBunBHn+OH4BetgEeotbgH70wf0GutMTuNtsm8IqEV/KS
         cRlv9R6JpYFju4ohgy1o/j2TXgq+Qxu9gA5FVkTQxLs5is/PHWExau6638EnZQrYFwFO
         J4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=DE7kWGPbgjvQmtjthwX9rNykAQvMNixqw5ivlEeVRls=;
        b=3no/lDW4lhSzIn577KEQRuaK3wrZUxt7jcI2Fm5KZzOcdrJnt0TiZpVvmEgTLZH0nR
         SupdoqdzIm1LMhRfbRvaySoZ8WZgiwPQuElMRSfqsbv+hGj+jeASyY39G3hN2hZ9+lrr
         gC75Klnyx3hjrMg9JSMJHDcFUjPBzTB6AtlKdIxnfY9eCY0NFag7pnhRBt1KWiy3OT/K
         D4kdV9z0x0CpY+jFzwppnVbdipxP9Q86Tb1uXMx9UDJ08UOiXlq1Vuc64y1weti7LYaO
         CS1ApuxkccmnvMMTkxfgoEPSZnmeV6IJZQjXXbnZlHp8IX3WdKouZ4w0juKCd7bd9h4F
         EROQ==
X-Gm-Message-State: ACgBeo3rZkXs+/wXIZuNzCap6EKDvDd3gmkWUJS0o7Q1OQv1D0iviaSt
        airuMpCHmlwfcqJ1QdAjxdCpiISb3zR/Q+Pw
X-Google-Smtp-Source: AA6agR5wy9Jask3wpEltPycPqHVoqPicxz/mC3iJDNT7/ZyzZ2ASCzOoBtydt6N9ZDP6GPUAKs1kqA==
X-Received: by 2002:a17:902:f30b:b0:170:c8ec:63b1 with SMTP id c11-20020a170902f30b00b00170c8ec63b1mr12113865ple.125.1660140923832;
        Wed, 10 Aug 2022 07:15:23 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:a07f:e6ac::1c])
        by smtp.gmail.com with ESMTPSA id z125-20020a623383000000b0052c92329115sm2001576pfz.218.2022.08.10.07.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 07:15:23 -0700 (PDT)
From:   Nate Yocom <nate@yocom.org>
To:     dmitry.torokhov@gmail.com
Cc:     nate@yocom.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] Input: joystick: xpad: Add X-Box Adaptive Controller support
Date:   Wed, 10 Aug 2022 07:15:11 -0700
Message-Id: <20220810141511.11827-1-nate@yocom.org>
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
 v2: Fix warning Reported-by: kernel test robot <lkp@intel.com>

 drivers/input/joystick/xpad.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 18190b529bca..b411bfb9a6b8 100644
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
 
@@ -1622,6 +1638,9 @@ static void xpad_set_up_abs(struct input_dev *input_dev, signed short abs)
 	case ABS_HAT0Y:	/* the d-pad (only if dpad is mapped to axes */
 		input_set_abs_params(input_dev, abs, -1, 1, 0, 0);
 		break;
+	case ABS_MISC: /* 4 value layer button (such as on the XAC) */
+		input_set_abs_params(input_dev, abs, 0, 4, 0, 0);
+		break;
 	default:
 		input_set_abs_params(input_dev, abs, 0, 0, 0, 0);
 		break;
@@ -1714,6 +1733,10 @@ static int xpad_init_input(struct usb_xpad *xpad)
 			xpad_set_up_abs(input_dev, xpad_abs_triggers[i]);
 	}
 
+	/* setup layer buton as an axis with 4 possible values */
+	if (xpad->mapping & MAP_LAYER_BUTTON)
+		xpad_set_up_abs(input_dev, ABS_MISC);
+
 	error = xpad_init_ff(xpad);
 	if (error)
 		goto err_free_input;

base-commit: 15205c2829ca2cbb5ece5ceaafe1171a8470e62b
-- 
2.30.2

