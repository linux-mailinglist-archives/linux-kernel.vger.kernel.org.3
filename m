Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 453A2482708
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 09:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiAAISN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 03:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiAAISJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 03:18:09 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A546C061574
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jan 2022 00:18:08 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id n14-20020a7bcbce000000b00332f4abf43fso8992989wmi.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jan 2022 00:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V/ySfznrCVwP33nHINhDWA0To2qZRQwyQe3jvr0Q578=;
        b=V37BQwEVVnSS2lKE1SO4KaC7cKd5pd5SQVAuwhWCPRwvfKzcLfM78buuuYweTdm+6I
         RWtW/ga1F0/BHu359sg3H76w6+9jIgT1n0dSPf7fXJfEIe3gT/OXsEqOVVlaHcERLbqb
         0MjFG8E6BWS3Hi82bXHM2L4bFr+PMjWlwmBsmBsh3ixYObwDrCzTdMteKh0wKuG4vxC7
         v9iPW36XmIH5MmqFHmlsm0jAHsDqB1RZ+ewDUum1dAjR12fGEjeQI/DAXDF4FiwaHl/y
         i/tzkABEIGCVoxwCzhb4rLB/mhdr4iFT0NjBy0T6PEkFAoMngYlAMsm/kX9/KTUGU97K
         yvtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V/ySfznrCVwP33nHINhDWA0To2qZRQwyQe3jvr0Q578=;
        b=PK8ojdXgGRRad7I9LcMPZs2qsC2x3+6i3UJkdPM7LcKLg+AviNcHSD7YkR7v1SaPrF
         F45IVjXrJMavS6IcXRF+En7zaT7gj1pa4jcyFTD7Ig1hstpTtEnzHSRuC9yn1grZY1Jb
         UPc2GeXhS7T/TgLB+uQ2zgdrsS7HhH1ouBZUxqS8nvoFx7F2haXueRnE90MYzhrO1zHA
         djQcP5THJaQvnwdrI2GziBOaQjcMvmx4IJay/1g7E4nnVKSokbBfxPmd0IswpGKO0aos
         AZIXUqdyPvgAhnYCWJhqe7gfhg2I+rGcIwgc53j+aGcyygB7plOf3uuu4NKTLua+dmqP
         T3Mg==
X-Gm-Message-State: AOAM532jSNPq19oXuRgq5/eEwl4NbycqQK0owHI4GsOlgycqAyYppVv8
        H4sqmkqKs06n28uMYYtlELo=
X-Google-Smtp-Source: ABdhPJy1Ob1E9s+MfJ0wRuUANVYtAtgJGP6Jbjlh3QPDn83Qc6hu31IsZzKfpbX+vph7xnIVLkRang==
X-Received: by 2002:a1c:9d14:: with SMTP id g20mr32131418wme.134.1641025087270;
        Sat, 01 Jan 2022 00:18:07 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id u9sm30693651wmm.7.2022.01.01.00.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jan 2022 00:18:06 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 4/7] staging: r8188eu: bAPKThermalMeterIgnore is set but never used
Date:   Sat,  1 Jan 2022 09:17:55 +0100
Message-Id: <20220101081758.9716-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220101081758.9716-1-straube.linux@gmail.com>
References: <20220101081758.9716-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The field bAPKThermalMeterIgnore of struct hal_data_8188e is set but
never used. Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v2: no changes

 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 5 ++---
 drivers/staging/r8188eu/include/rtl8188e_hal.h  | 1 -
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 065c2701077d..cce291ca44b1 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1230,9 +1230,8 @@ void Hal_ReadThermalMeter_88E(struct adapter *Adapter, u8 *PROMContent, bool Aut
 	else
 		pHalData->EEPROMThermalMeter = EEPROM_Default_ThermalMeter_88E;
 
-	if (pHalData->EEPROMThermalMeter == 0xff || AutoloadFail) {
-		pHalData->bAPKThermalMeterIgnore = true;
+	if (pHalData->EEPROMThermalMeter == 0xff || AutoloadFail)
 		pHalData->EEPROMThermalMeter = EEPROM_Default_ThermalMeter_88E;
-	}
+
 	DBG_88E("ThermalMeter = 0x%x\n", pHalData->EEPROMThermalMeter);
 }
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index de58c85b8bdc..40b3db34b8f2 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -181,7 +181,6 @@ struct hal_data_8188e {
 	u8	EEPROMRegulatory;
 
 	u8	EEPROMThermalMeter;
-	u8	bAPKThermalMeterIgnore;
 
 	bool	EepromOrEfuse;
 
-- 
2.34.1

