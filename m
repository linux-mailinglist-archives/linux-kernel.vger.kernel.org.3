Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3BA5A1C42
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 00:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244391AbiHYWYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 18:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244296AbiHYWYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 18:24:40 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341A0C5786
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:24:39 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id p18so27975plr.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yocom-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=RadgG83WWa4faHpqBE1rZrrs1XrwjergMGKfR9KHj1E=;
        b=WLHay7cHzXyTv10asVvWKdXH+2pVHOLoPnd6N7Cjk9GRWGu5ksjOkUbBD3yU0nm6AX
         EnslDc4NywiHEANmvggunDmGLl9mOYjXH2Rm+qAfhaYs9fxCg15AuFA2OEDdL91Edz9G
         9XcqGyxngcducRt1RbvwcDpe7zwVM+PeRHd+I+o2s4F6labGsTYHuOqjXEPO0q8UdYQI
         XToS5KD6I/H9gQK7WEseTWsvyNQzs9+fc8Rn86l4j6cgCb1BxVNBtp07Swku38GcKLWF
         angHxo0cOmdQ94d93XKxqlJ5wzyGK8pwSx/3O6ocTSYP8evTjcpHH9W6YKUv7cBwAj/N
         wl1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=RadgG83WWa4faHpqBE1rZrrs1XrwjergMGKfR9KHj1E=;
        b=BnlUZAxqbhAHMcVEZLGvPPknbLSD9Tl5CpAHyO/k16waN9Sfq6AhZC8IGyn+7xMu+e
         AvYHoggWoywZhPf8JrYt/3DEPz4fzTMdfWxwS+p3afbcIw4bRynmyc0i83MJZnGph574
         d3hGdG8H+7ar3Y+Ww21NBYyd4ZMKtanWiwOlZhzqqFzEDVCFrTNyEKI3eF/Tvr4oHSwB
         eduR1bzvKN0aUYZLRiDns2rKgcQE1KrPVqKwWSdiEfBW/uyt3T2+fJZ53yKH2KMJ7wF9
         IbBW/EqXsOLGBfSpeLj+N3wiRjpXcvEF2IfLAHUj/2r4SIG68biQlOqYkbHboM5LPp8P
         5M8Q==
X-Gm-Message-State: ACgBeo3zKDytoC/v0bImD62vVX054Q080hS5vIg1pTW5u9vb9LCHeAps
        rVcVG9+vrq5W6iCruw2Wmq394Q==
X-Google-Smtp-Source: AA6agR48sZ3vduQgsEP2EBX/tvxsSK1d6ePZxssCzRsia8eNCik0Kbf+Bsf/Cni0qjwoKxQ+WyIOJQ==
X-Received: by 2002:a17:90a:f48d:b0:1f7:2e00:f7f8 with SMTP id bx13-20020a17090af48d00b001f72e00f7f8mr1302071pjb.94.1661466278714;
        Thu, 25 Aug 2022 15:24:38 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:8f80:973::5f])
        by smtp.gmail.com with ESMTPSA id e23-20020a63db17000000b00429b6e6c539sm81820pgg.61.2022.08.25.15.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 15:24:38 -0700 (PDT)
From:   Nate Yocom <nate@yocom.org>
To:     dmitry.torokhov@gmail.com
Cc:     nate@yocom.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, hadess@hadess.net,
        benjamin.tissoires@redhat.com
Subject: [PATCH v5 3/4] Input: joystick: xpad: Add X-Box Adaptive Controller Profile button
Date:   Thu, 25 Aug 2022 15:24:19 -0700
Message-Id: <20220825222420.6833-4-nate@yocom.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220825222420.6833-1-nate@yocom.org>
References: <20220825222420.6833-1-nate@yocom.org>
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
index c8b38bb73d34..9557e4768f14 100644
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

