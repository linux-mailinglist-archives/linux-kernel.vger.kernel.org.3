Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7895B24FB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 19:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbiIHRll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 13:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbiIHRlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 13:41:03 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF6B2D1F9
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 10:39:44 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so3211000pjh.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 10:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yocom-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=LPhRLaWef+Hz3zJYtHqHes7JAiIwNYbeVpUYbArIE2g=;
        b=Ucysblj0jQtpYnQ3v4BxSFf8awFsQO6SNWAv27Ne5Oaf1DVywieh6hyvVkdIn1GaIt
         J99PU5di1sfx7L1oA3hG5OBNxGXRU44BmfT/0uV3FKolG3WIiTpCJ2985G+uu0BPUTjq
         99CTwtQXPny/QtEkocGOjR/kUH5HDV9fhp8tOQgH8EP1WEXlDVkLYFWeqdF8xLmuIXGA
         nOXSAVNfey+oqypYxI1/yb9ACm4Z8qhI0JmAfqWt0embyRDuI+mdVac83oO6gJ1FtODG
         F9yurCeAAOV23J/Oa4RxRZhSLamYvPoEMdunO3z3JnhdAnrW22M3E/CYhgTVNpWuHeo7
         YYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LPhRLaWef+Hz3zJYtHqHes7JAiIwNYbeVpUYbArIE2g=;
        b=rslAGuE/fQzpGFfe+QNeWeJKDu4eBR5T9UGNRDzE66ypx2jOZEh9AUeowmfZZfAcwJ
         UmoE3Qz86OPMGYpSR60dIOLqQzJQWjdBAoDSELHyXnlpzfUzKIDrkaE02YlXwTu7j7S3
         KSYDskT/7ipmapklDNyjphmUj6M6cRS1zyy4B+HmWueSeosCHA8BMoaudrhCifB/Og8l
         bYyvKFOMvCnQiCcuDzq/N3USrVXFfAbYl8OX1zketuQdyzs4nZZYknH+fMSQQ/Was/eh
         fjE+8oAyMW/Lb+COvLgNx5BVmMPGAJggxU0ldwYHw0GUccyM52MgQ9Munq7IDZm0Ktwl
         CNKA==
X-Gm-Message-State: ACgBeo3ufpC6LobrrdxExX2kDBe+hg6MgRmCHw6Zx8LgTLV/mWdjuYXu
        c8624iST09yqhMph6B0Cn0+3ew==
X-Google-Smtp-Source: AA6agR5zSanZ9Zsj5sMjjDtbnqCwGnovjeUHi7EGp81MgWKH1PNLzfe7cG5tBpWWgfLi0ZKTnMEKsQ==
X-Received: by 2002:a17:902:c951:b0:176:d421:7502 with SMTP id i17-20020a170902c95100b00176d4217502mr10059051pla.72.1662658781195;
        Thu, 08 Sep 2022 10:39:41 -0700 (PDT)
Received: from ghaven-kernel.yocom.org.beta.tailscale.net ([2601:600:8f80:973::5f])
        by smtp.gmail.com with ESMTPSA id x76-20020a62864f000000b0052d4b0d0c74sm15166767pfd.70.2022.09.08.10.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 10:39:40 -0700 (PDT)
From:   Nate Yocom <nate@yocom.org>
To:     dmitry.torokhov@gmail.com
Cc:     nate@yocom.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, hadess@hadess.net,
        benjamin.tissoires@redhat.com
Subject: [PATCH v6 5/5] Input: joystick: xpad: Add X-Box Adaptive Profile button
Date:   Thu,  8 Sep 2022 10:39:30 -0700
Message-Id: <20220908173930.28940-6-nate@yocom.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220908173930.28940-1-nate@yocom.org>
References: <20220908173930.28940-1-nate@yocom.org>
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
states, reflected as an ABS_PROFILE axis with 4 values.

Signed-off-by: Nate Yocom <nate@yocom.org>
Tested-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/input/joystick/xpad.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index dff0d099d416..ece38f00dfff 100644
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
 
+	/* Profile button has a value of 0-3, so it is reported as an axis */
+	if (xpad->mapping & MAP_PROFILE_BUTTON)
+		input_report_abs(dev, ABS_PROFILE, data[34]);
+
 	input_sync(dev);
 }
 
@@ -1623,6 +1628,9 @@ static void xpad_set_up_abs(struct input_dev *input_dev, signed short abs)
 	case ABS_HAT0Y:	/* the d-pad (only if dpad is mapped to axes */
 		input_set_abs_params(input_dev, abs, -1, 1, 0, 0);
 		break;
+	case ABS_PROFILE: /* 4 value profile button (such as on XAC) */
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
+		xpad_set_up_abs(input_dev, ABS_PROFILE);
+
 	error = xpad_init_ff(xpad);
 	if (error)
 		goto err_free_input;
-- 
2.30.2

