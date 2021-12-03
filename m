Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E35467EC6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 21:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383094AbhLCUaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 15:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233528AbhLCUaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 15:30:02 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF27C061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 12:26:38 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id l25so16125822eda.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 12:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9zHipByrsNK0qk+HHU/d1JXlrjGn7rcQqoiAh21t8ds=;
        b=l4GFWECq5qmLbXfAQOX7iJRHDEu8A/P7w2MnzLbhUBogNlo+L0tRrDzsmS0j5uyqmO
         gVHVezGFR8CSnsNtrak01SKfgQeC0Ez3kpnW5QVeJpd5QVvloDPryeyiCA4aFXLoA2Tw
         /mS4mw0/sMSeGlioDD6+qtkZKkaniX6ZrqQHlvci42OLT51SISgrhBQM5IcoqfXReJAD
         L5iWDSMDJGmvmeXvtVOvxhZeTXihp1vl7g35jwuN7081aAhnYSicvpmr6sc9pK3cECbX
         FYpR2rUeELm7oW2k7P/YmlQZSnRbyUhRgJKfGvsqfLwmginIVSeT7mKm8lZUpsS5vgqL
         Wk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9zHipByrsNK0qk+HHU/d1JXlrjGn7rcQqoiAh21t8ds=;
        b=Be8ur990EtCj1K3hmsm5u8JrjF18UeIrRudLuG6TXYSXy9tFiOym1atqjsnr5IjxUC
         KO6SntoWu6AbNDsLyEnj1FGApyFuanAeYE5tHP1tGgIZiWjvds63GpXcV0yIGwFYDZVw
         /2EcwsGd5pZv997JsPV4dgqJj28XiJgeUoyL+L1u4FwedvKwtE1XXdtjYov28SVs1f5V
         W2IsZ5ySGXqmMOz/vPZykWQuYqB6bDwbyGY6gotojmWhKtd+C2Zfi26ZpLszl3oQ0LLI
         lF24W8qrrF9YDmIK0sVseYCDuB8SD2y3ZRKMn1woNw4F4lWBz7fve5kczljaSiu5lLI3
         J2Kw==
X-Gm-Message-State: AOAM532bWl6vDdk/us53EVGQTgPk1zlnBliUh6LRJcF1B7Fe/jwZcgIy
        EkDacXEA18MiBjcU4vZ//m0=
X-Google-Smtp-Source: ABdhPJyp8uxqvwbPQ9viHB/F27DeLB2IJdAOVMZJ4dToWRGr/Qj8cDyyU6h0h2neBEwXNS6FncBy7A==
X-Received: by 2002:a05:6402:3596:: with SMTP id y22mr29793203edc.297.1638563196598;
        Fri, 03 Dec 2021 12:26:36 -0800 (PST)
Received: from bulldog.fritz.box (host-79-17-112-183.retail.telecomitalia.it. [79.17.112.183])
        by smtp.gmail.com with ESMTPSA id f17sm2596547edq.39.2021.12.03.12.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 12:26:36 -0800 (PST)
From:   Alberto Merciai <alb3rt0.m3rciai@gmail.com>
To:     alb3rt0.m3rciai@gmail.com
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        =?UTF-8?q?Aldas=20Tara=C5=A1kevi=C4=8Dius?= <aldas60@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: vt6655: refactor byRadioCtl to radio_ctl
Date:   Fri,  3 Dec 2021 21:24:06 +0100
Message-Id: <20211203202410.3807147-1-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace camelcase hungarian notated variable "byRadioCtl"
into linux kernel coding style equivalent variable "radio_ctl".

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---

v2 -> v3
- replace typo inside mail message body
v1 -> v2
- Correct mail subject

 drivers/staging/vt6655/device.h      | 2 +-
 drivers/staging/vt6655/device_main.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index c51eba94230d..245f992e5a23 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -227,7 +227,7 @@ struct vnt_private {
 	bool bPWBitOn;
 
 	/* GPIO Radio Control */
-	unsigned char byRadioCtl;
+	unsigned char radio_ctl;
 	unsigned char byGPIO;
 	bool hw_radio_off;
 	bool bPrvActive4RadioOFF;
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 897d70cf32b8..37a82550ca82 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -371,18 +371,18 @@ static void device_init_registers(struct vnt_private *priv)
 
 	priv->radio_off = false;
 
-	priv->byRadioCtl = SROMbyReadEmbedded(priv->port_offset,
+	priv->radio_ctl = SROMbyReadEmbedded(priv->port_offset,
 					      EEP_OFS_RADIOCTL);
 	priv->hw_radio_off = false;
 
-	if (priv->byRadioCtl & EEP_RADIOCTL_ENABLE) {
+	if (priv->radio_ctl & EEP_RADIOCTL_ENABLE) {
 		/* Get GPIO */
 		MACvGPIOIn(priv->port_offset, &priv->byGPIO);
 
 		if (((priv->byGPIO & GPIO0_DATA) &&
-		     !(priv->byRadioCtl & EEP_RADIOCTL_INV)) ||
+		     !(priv->radio_ctl & EEP_RADIOCTL_INV)) ||
 		     (!(priv->byGPIO & GPIO0_DATA) &&
-		     (priv->byRadioCtl & EEP_RADIOCTL_INV)))
+		     (priv->radio_ctl & EEP_RADIOCTL_INV)))
 			priv->hw_radio_off = true;
 	}
 
-- 
2.25.1

