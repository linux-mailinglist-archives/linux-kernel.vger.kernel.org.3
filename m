Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 485E7487E87
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 22:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiAGVvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 16:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiAGVuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 16:50:51 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45E7C06173E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 13:50:50 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id e9so12002788wra.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 13:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qd2MUjateJP8WxPnVI13o6zs3521STkyo0JY4qUchOI=;
        b=cg3dKnod/AnHI9m0rDURb9DUp8cIFfp4L7lxM4gWOhML9io1tWgDxBaRb41VqoepQh
         m8ejqBO6PXVjWhuRPfQjydiVAGViz4K8Q5UnZvYwwrwIfnlLXvc5vsDfGt8UxhzDHyrZ
         2jtVxVHQIhumH0Z0gDXN5P2ggk7wkwJeNlkmPEjqvmO3Betm66G0f3LfjlazgWnjCKZD
         F/JsXw8o6X7Vx4P0TQYlz9crzFOY513aDU41ZO1gh6OlEKCCoalPMdJdms1FKfOKUi6u
         2yz+wfy/naElUNXkhWk0cAEpu7C0st6NWW7i4wE244ab61TEjbuUhyEDtjzE8vLuXWie
         l5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qd2MUjateJP8WxPnVI13o6zs3521STkyo0JY4qUchOI=;
        b=AcvpaaX62h7CIyaE35ErTP4759dbwMrzxHlHxbF5emnGbZWARUrP9aJPgo8NXViVh3
         sGFMHA8wKpEJ+gyxEOlotPvMVlTbw4MTyqBwwS1yAQLRpLpzUDHpavnCzf7H2X6YWQCc
         NJw9PLUqnoVBNmmAo4SvczcJk+VfZjKlAev/zCP5JD5exU4rjT8swV7JoohHlJdYt36D
         K7SDsdNQWhDicfhsv/O8jtBgiKDUE1Zlh0zqGBGNcqnl4kgur63xRHa6+NQBhRgGtaH+
         6ExFuEUnq6HkbWRUfTNBk6T/LJHvPfZSYD31l3Wmn0yqhTJTcqZR0hBo7wDCXo7qoS7W
         KGXQ==
X-Gm-Message-State: AOAM5313r0OsmIi+oYUKJ8ye8edXKjJgr7jPsV2CSuVMNVRTUrFaxe94
        uML4QeeaRwkhUgNLjFTW8wQ=
X-Google-Smtp-Source: ABdhPJwiThWEV7gGSM22XNZ+RKjltQa7kWzD3PiqHMPyhToHoHJKII0nTb/zcktv3VRgRDsHeJAAPA==
X-Received: by 2002:adf:e70e:: with SMTP id c14mr3489753wrm.334.1641592249500;
        Fri, 07 Jan 2022 13:50:49 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::51e2])
        by smtp.gmail.com with ESMTPSA id k14sm1729161wrn.59.2022.01.07.13.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 13:50:49 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/6] staging: r8188eu: EfuseUsedBytes is set but never used
Date:   Fri,  7 Jan 2022 22:50:32 +0100
Message-Id: <20220107215033.12257-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107215033.12257-1-straube.linux@gmail.com>
References: <20220107215033.12257-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The field EfuseUsedBytes of struct hal_data_8188e is set but never
used. Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 3 ---
 drivers/staging/r8188eu/hal/usb_halinit.c       | 3 ---
 drivers/staging/r8188eu/include/hal_intf.h      | 1 -
 drivers/staging/r8188eu/include/rtl8188e_hal.h  | 2 --
 4 files changed, 9 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index b818872e0d19..53328c4b1fd1 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -797,9 +797,6 @@ static void Hal_EfuseReadEFuse88E(struct adapter *Adapter,
 	for (i = 0; i < _size_byte; i++)
 		pbuf[i] = efuseTbl[_offset + i];
 
-	/*  5. Calculate Efuse utilization. */
-	SetHwReg8188EU(Adapter, HW_VAR_EFUSE_BYTES, (u8 *)&eFuse_Addr);
-
 exit:
 	kfree(efuseTbl);
 	kfree(eFuseWord);
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index c1129c83ebf7..10e40e654775 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1528,9 +1528,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			}
 		}
 		break;
-	case HW_VAR_EFUSE_BYTES: /*  To set EFUE total used bytes, added by Roger, 2008.12.22. */
-		haldata->EfuseUsedBytes = *((u16 *)val);
-		break;
 	case HW_VAR_FIFO_CLEARN_UP:
 		{
 			struct pwrctrl_priv *pwrpriv = &Adapter->pwrctrlpriv;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 37c2d2b82ea8..a86cb376a125 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -59,7 +59,6 @@ enum hw_variables {
 	HW_VAR_ANTENNA_DIVERSITY_SELECT,
 	HW_VAR_SWITCH_EPHY_WoWLAN,
 	HW_VAR_EFUSE_USAGE,
-	HW_VAR_EFUSE_BYTES,
 	HW_VAR_EFUSE_BT_USAGE,
 	HW_VAR_EFUSE_BT_BYTES,
 	HW_VAR_FIFO_CLEARN_UP,
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 8134a173ea07..837b633cf98a 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -232,8 +232,6 @@ struct hal_data_8188e {
 	u8	OutEpQueueSel;
 	u8	OutEpNumber;
 
-	u16	EfuseUsedBytes;
-
 	struct P2P_PS_Offload_t	p2p_ps_offload;
 
 	/*  Auto FSM to Turn On, include clock, isolation, power control
-- 
2.34.1

