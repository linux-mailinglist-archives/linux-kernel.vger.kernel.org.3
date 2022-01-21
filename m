Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D05E49634C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 17:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381766AbiAUQ5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 11:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379874AbiAUQ4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 11:56:49 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B246C06176C;
        Fri, 21 Jan 2022 08:55:39 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id q13-20020a9d4b0d000000b0059b1209d708so12478481otf.10;
        Fri, 21 Jan 2022 08:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z6NMdJmJY0918lK7MEwP90+HahbtL5bkAvsIK2mROkA=;
        b=ALwBxRoNLaUVojdxu1UguTgJFEO/82SZFhkbgYEuonAQegmTYzNFfsRNgj6/ZT+Awt
         vSjyx55OfaySiDO8ebcX2PhLzpDQGFCCho3P/uPLnwZtBp/YTrKrOrUm4/4q0NQefk4S
         LfAXU+3oyS0do27wY18gbjge/cVfM8d27+dP7A/ZPV3rPVS4cFhvlvx2qGdz1WeXRW7L
         SZ/djoWj/kvENVc8jGiWNz1C9BlYw7XbgvrCkWoZdTlkEQJyUzZJn+vAOf7Raf2p6QSR
         EfI/DsoiRkf0xrgCrRNT2Da9yRHnJXLCl8jRkKppUVYAdaz1YBisZl5C0wFK/CcDFHKY
         vlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z6NMdJmJY0918lK7MEwP90+HahbtL5bkAvsIK2mROkA=;
        b=4fA6o1nQydvYzZTAXAE67lvDgS1T/rHWi8TvC9m8Lii3+/SZQPJJ+V+qDSk0RozUed
         jC0JMy6rBr7i5qoehZCppePmjAdjmn0bu+b5aL1XP6H6T5e0FzrZNElO/Xb3u8knfALv
         wOlhcfoodxT8yuZ4qvC1FSXjZY4xhSH4n5fkxssrfAi/bR7fDRE09A0qX/gAirLFdi4L
         UZgqxnm3d5tSKsMgGcQq2vcI728Gd/pJXDECxWRbau8LmrHQExvWXJ6+2AmQ+Q6DhBSP
         aUVANv8z9sHsGyAkAk7C7wh4zGm8ZRqnB81495SfKVKyn7qwslsQCiu64L124fROpreW
         yqtw==
X-Gm-Message-State: AOAM533HEsVI/Ouyx/8US5+WS0f2JWLUBa9bsxOGucO3vTXpa/kjAzRj
        pgXvAPWXodvzezeKVsnrr5jwWmakUkU=
X-Google-Smtp-Source: ABdhPJy/hpy/QZlbs/qzPqVwNjr+5RZEo6fmAPgo+WXiKx1V4audpzhkpeR32y92eA/k8WW86Plb2g==
X-Received: by 2002:a05:6830:60a:: with SMTP id w10mr3376814oti.111.1642784138528;
        Fri, 21 Jan 2022 08:55:38 -0800 (PST)
Received: from thinkpad.localdomain ([2804:14d:5cd1:5d03:cf72:4317:3105:f6e5])
        by smtp.gmail.com with ESMTPSA id y8sm1089271oou.23.2022.01.21.08.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 08:55:38 -0800 (PST)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Luiz Sampaio <sampaio.ime@gmail.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH 23/31] usb: core: changing LED_* from enum led_brightness to actual value
Date:   Fri, 21 Jan 2022 13:54:28 -0300
Message-Id: <20220121165436.30956-24-sampaio.ime@gmail.com>
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
 drivers/usb/core/ledtrig-usbport.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/ledtrig-usbport.c b/drivers/usb/core/ledtrig-usbport.c
index ba371a24ff78..85fa5699bb3d 100644
--- a/drivers/usb/core/ledtrig-usbport.c
+++ b/drivers/usb/core/ledtrig-usbport.c
@@ -73,7 +73,7 @@ static void usbport_trig_update_count(struct usbport_trig_data *usbport_data)
 
 	usbport_data->count = 0;
 	usb_for_each_dev(usbport_data, usbport_trig_usb_dev_check);
-	led_set_brightness(led_cdev, usbport_data->count ? LED_FULL : LED_OFF);
+	led_set_brightness(led_cdev, usbport_data->count ? 255 : 0);
 }
 
 /***************************************
@@ -287,12 +287,12 @@ static int usbport_trig_notify(struct notifier_block *nb, unsigned long action,
 	case USB_DEVICE_ADD:
 		usbport_trig_add_usb_dev_ports(usb_dev, usbport_data);
 		if (observed && usbport_data->count++ == 0)
-			led_set_brightness(led_cdev, LED_FULL);
+			led_set_brightness(led_cdev, 255);
 		return NOTIFY_OK;
 	case USB_DEVICE_REMOVE:
 		usbport_trig_remove_usb_dev_ports(usbport_data, usb_dev);
 		if (observed && --usbport_data->count == 0)
-			led_set_brightness(led_cdev, LED_OFF);
+			led_set_brightness(led_cdev, 0);
 		return NOTIFY_OK;
 	}
 
-- 
2.34.1

