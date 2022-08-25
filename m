Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F89C5A1CA3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 00:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243970AbiHYWnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 18:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243975AbiHYWng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 18:43:36 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A257C6B5C
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:43:33 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id u9so13249815ejy.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=balfug.com; s=gm;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=BjT8hRfQ7izuh4D1WYligk8wTQyrhZzfhom7KTiNQuo=;
        b=mDh43DmZqaka1sbgKzyUAIflP049W3mt4vxnWIz4WvJo0Rf0KoZJ/br+va+lCTj1wO
         Ho2w0BiO8UGXzM/X8zuiayvu5RY9AqFojQiSBXkY3V9+gG7rS7ctnLHKJPSA22r8Qwvw
         Pj7Cw1/AtS4zQ/AN11r7m6HerImNpimhd0MP2zVd/TDKsDG86XJqidU4pnmEjokUCLTJ
         xRZyIr1ns3oLEiU7B78S7t2wDknYexhZDdpK6mcu00TU6MfZYWXTV7naSPiKgMN/LAMz
         V/IpHzd02AGMOisvJtRTbi2cNBECc3zv5SIw3k8dfpDruMeVGm2V7uppqvHOeAnDxUBB
         DIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=BjT8hRfQ7izuh4D1WYligk8wTQyrhZzfhom7KTiNQuo=;
        b=CmQ47cDl0DTNVsPyQYPnoZZJ/vZgUgpIF+XVPtUwdg3gGePoXI1arCKi0L++qxuXSP
         PkTTBz/n3QYaIRKzANPuj5nwFPp3gichsuchr+WXpJYkPvTAmrruzM+w2H0jYiYgZ57l
         HxvXLiILp9WuFYY8MJdTaLGhUpV5DnhTz1hfDMVXKLbCYWl3CIQJZxI70TgrSwBkcbdb
         zf5zxGXPM8G+TSP05eKzdiuJYeO+jVyGaG1xZzdCpuAG6iksqUngyX2hy5qx5Df5msBD
         2QD/JYEL2Xe7V16lWzb8a0SOV8AC8w1xML+pIQ5ev0LhhIy9OE+XetFoi25zj1hDBJD+
         9jcg==
X-Gm-Message-State: ACgBeo3uBpnrelgSKZe1ZazuAvxc1SaX3CwrIopdLV0Ca4Zz5hEKA5WZ
        B+C7IWBOdCeIP6OG1pY8VQDCNw==
X-Google-Smtp-Source: AA6agR4/7s7jq/v0Qr12IvcUGeWGwtrlzjkdJsfSfGnq2bZtiRaYoP7YA0jeyPIhLDTNvQONHIumtg==
X-Received: by 2002:a17:907:6e89:b0:73d:a846:c29e with SMTP id sh9-20020a1709076e8900b0073da846c29emr3641758ejc.577.1661467411612;
        Thu, 25 Aug 2022 15:43:31 -0700 (PDT)
Received: from localhost.localdomain (20014C4E198D65010944FE0C94C0B856.dsl.pool.telekom.hu. [2001:4c4e:198d:6501:944:fe0c:94c0:b856])
        by smtp.gmail.com with ESMTPSA id i2-20020aa7c702000000b0043cb1a83c9fsm357529edq.71.2022.08.25.15.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 15:43:31 -0700 (PDT)
From:   Szabolcs Sipos <labuwx@balfug.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Szabolcs Sipos <labuwx@balfug.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: btusb: RTL8761BUV consistent naming
Date:   Fri, 26 Aug 2022 00:42:07 +0200
Message-Id: <20220825224208.343700-1-labuwx@balfug.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on photos available from the FCC, all currently supported RTL8761B
series USB dongles have the same chip: RTL8761BUV.

rtl8761bu is often used to refer to this chip.
rtl8761b sometimes refers to this chip, and other times to its
UART variant (RTL8761BTV).

+----------------+---------+---------+---------------+
|     Dongle     | USB VID | USB PID |    FCC ID     |
+----------------+---------+---------+---------------+
| ASUS USB-BT500 | 0x0b05  | 0x190e  | MSQ-USBBTJB00 |
| TP-Link UB500  | 0x2357  | 0x0604  | 2AXJ4UB500    |
| EDUP EP-B3519  |         |         | 2AHRD-EPB3519 |
| EDUP EP-B3536  |         |         | 2AHRDEP-B3536 |
| UGREEN CM390   |         |         | 2AQI5-CM390   |
+----------------+---------+---------+---------------+

Signed-off-by: Szabolcs Sipos <labuwx@balfug.com>
---
 drivers/bluetooth/btusb.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 30dd443f395f..ecedaee1d965 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -519,17 +519,13 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0bda, 0xb009), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x2ff8, 0xb011), .driver_info = BTUSB_REALTEK },
 
-	/* Additional Realtek 8761B Bluetooth devices */
+	/* Additional Realtek 8761BUV Bluetooth devices */
 	{ USB_DEVICE(0x2357, 0x0604), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
-
-	/* Additional Realtek 8761BU Bluetooth devices */
 	{ USB_DEVICE(0x0b05, 0x190e), .driver_info = BTUSB_REALTEK |
 	  					     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x2550, 0x8761), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
-
-	/* Additional Realtek 8761BUV Bluetooth devices */
 	{ USB_DEVICE(0x0bda, 0x8771), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 
-- 
2.37.2

