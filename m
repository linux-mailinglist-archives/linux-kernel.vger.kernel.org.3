Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D7A468B4B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 14:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbhLEODD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 09:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234490AbhLEOC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 09:02:59 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C04C061714
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 05:59:31 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id r11so31835678edd.9
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 05:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mbpd+m6t3FhZn6q2UWR6mi6rF/xhaVQT3CnluKIB01M=;
        b=PrWKfjP2NhEIWI7GwYqYRynk3d4Kl1cU+CDjAYkZ/QWJN0J9tvcivPPpjs4KwQndsr
         uv1J4KjZhCyqQ7EY83VuzXeJzpb7a+wAdK9zFjWydohdnoc2mG3ILcPFHWOPx9UlTPNV
         7h6BnMuzxTv7Mkw7ooehGus/fLMO/BCj5N5WkbFRFwVEirLRoybosZsHM/v4kK8uTbEq
         3go63AINf58Asp7Vb1ls1TExHUscg+z/mupYOhO4oqxSRB2UjjwOtKptbfBwkq7yanHA
         hgPGX63LW5X0TeFort90D0hI/6m46A6i9hsFqUyWIt7LRFo4OAy2c84eqykwOhBX/mFx
         1ynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mbpd+m6t3FhZn6q2UWR6mi6rF/xhaVQT3CnluKIB01M=;
        b=ayuYStI0atRS2UlMgM8TrRSCHu8/u2F9mwLkZbpQa+ASxg2V8xKTx9OBShS4cOqhgQ
         OwIrYL4nm8zn65UZMF8buKPHcdfp2QQDYVsRKanBCkVGs14jMWoysv1R00hFj3M6gGTl
         HvuarOZThfJdwnF5VeBiAejZJsqHaQaMIqmjGlqEAjC0Izh6GPEksxc9TensCszAnLq0
         WNi4wbZwbNJDt9bcuMOPymcszeZtB5Zo1sxA3p3vXzHgLvEeOp1yP0rVHn0yXAp4MhiE
         iMcMaR1EeO8F/Hmi8+mJqrB6UGQFhXONvZkjKaaIu2tUlzj538fAQEX8nK4yCbpH9HW+
         Uoqw==
X-Gm-Message-State: AOAM533QruQ9XzX0q8bNCjL6cYm0rBWst2FQIUcFDL/w5kEzvUDEoh13
        DbFqbzEx6WkhHIj4lpTQqflTS6WQ9WI=
X-Google-Smtp-Source: ABdhPJz8O4adVabGwglWbuiRzDSUC2EPZXAAeqB71HMVAvED6itbiRhJaY+/wJ3/Au3ohlH0n9h6lg==
X-Received: by 2002:a17:907:d89:: with SMTP id go9mr38826362ejc.330.1638712770471;
        Sun, 05 Dec 2021 05:59:30 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::5a05])
        by smtp.gmail.com with ESMTPSA id yd20sm5146451ejb.47.2021.12.05.05.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 05:59:30 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 04/12] staging: r8188eu: remove macro PHY_QueryRFReg
Date:   Sun,  5 Dec 2021 14:59:11 +0100
Message-Id: <20211205135919.30460-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205135919.30460-1-straube.linux@gmail.com>
References: <20211205135919.30460-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro PHY_QueryRFReg just re-defines rtl8188e_PHY_QueryRFReg().
Call rtl8188e_PHY_QueryRFReg() directly and remove the macro.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c     | 6 +++---
 drivers/staging/r8188eu/hal/odm_interface.c      | 2 +-
 drivers/staging/r8188eu/hal/usb_halinit.c        | 4 ++--
 drivers/staging/r8188eu/include/Hal8188EPhyCfg.h | 2 --
 4 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index 5c82e5f6cebf..701708d01233 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -853,11 +853,11 @@ static void phy_LCCalibrate_8188E(struct adapter *adapt, bool is2t)
 	if ((tmpreg & 0x70) != 0) {
 		/* 1. Read original RF mode */
 		/* Path-A */
-		RF_Amode = PHY_QueryRFReg(adapt, RF_PATH_A, RF_AC, bMask12Bits);
+		RF_Amode = rtl8188e_PHY_QueryRFReg(adapt, RF_PATH_A, RF_AC, bMask12Bits);
 
 		/* Path-B */
 		if (is2t)
-			RF_Bmode = PHY_QueryRFReg(adapt, RF_PATH_B, RF_AC, bMask12Bits);
+			RF_Bmode = rtl8188e_PHY_QueryRFReg(adapt, RF_PATH_B, RF_AC, bMask12Bits);
 
 		/* 2. Set RF mode = standby mode */
 		/* Path-A */
@@ -869,7 +869,7 @@ static void phy_LCCalibrate_8188E(struct adapter *adapt, bool is2t)
 	}
 
 	/* 3. Read RF reg18 */
-	LC_Cal = PHY_QueryRFReg(adapt, RF_PATH_A, RF_CHNLBW, bMask12Bits);
+	LC_Cal = rtl8188e_PHY_QueryRFReg(adapt, RF_PATH_A, RF_CHNLBW, bMask12Bits);
 
 	/* 4. Set LC calibration begin	bit15 */
 	ODM_SetRFReg(dm_odm, RF_PATH_A, RF_CHNLBW, bMask12Bits, LC_Cal | 0x08000);
diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
index b6f55709df9f..df981ca4fb29 100644
--- a/drivers/staging/r8188eu/hal/odm_interface.c
+++ b/drivers/staging/r8188eu/hal/odm_interface.c
@@ -37,7 +37,7 @@ void ODM_SetRFReg(struct odm_dm_struct *pDM_Odm, enum rf_radio_path	eRFPath, u32
 u32 ODM_GetRFReg(struct odm_dm_struct *pDM_Odm, enum rf_radio_path	eRFPath, u32 RegAddr, u32 BitMask)
 {
 	struct adapter *Adapter = pDM_Odm->Adapter;
-	return PHY_QueryRFReg(Adapter, (enum rf_radio_path)eRFPath, RegAddr, BitMask);
+	return rtl8188e_PHY_QueryRFReg(Adapter, (enum rf_radio_path)eRFPath, RegAddr, BitMask);
 }
 
 /*  ODM Memory relative API. */
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index e995904cf85c..b53392161f09 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -745,8 +745,8 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	rtw_write16(Adapter, REG_PKT_BE_BK_LIFE_TIME, 0x0400);	/*  unit: 256us. 256ms */
 
 	/* Keep RfRegChnlVal for later use. */
-	haldata->RfRegChnlVal[0] = PHY_QueryRFReg(Adapter, (enum rf_radio_path)0, RF_CHNLBW, bRFRegOffsetMask);
-	haldata->RfRegChnlVal[1] = PHY_QueryRFReg(Adapter, (enum rf_radio_path)1, RF_CHNLBW, bRFRegOffsetMask);
+	haldata->RfRegChnlVal[0] = rtl8188e_PHY_QueryRFReg(Adapter, (enum rf_radio_path)0, RF_CHNLBW, bRFRegOffsetMask);
+	haldata->RfRegChnlVal[1] = rtl8188e_PHY_QueryRFReg(Adapter, (enum rf_radio_path)1, RF_CHNLBW, bRFRegOffsetMask);
 
 	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_TURN_ON_BLOCK);
 	_BBTurnOnBlock(Adapter);
diff --git a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
index 467ee48fa49c..a60eb2e39684 100644
--- a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
+++ b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
@@ -138,7 +138,5 @@ void storePwrIndexDiffRateOffset(struct adapter *adapter, u32 regaddr,
 	 rtl8188e_PHY_QueryBBReg((adapt), (regaddr), (mask))
 #define PHY_SetBBReg(adapt, regaddr, bitmask, data)		\
 	 rtl8188e_PHY_SetBBReg((adapt), (regaddr), (bitmask), (data))
-#define PHY_QueryRFReg(adapt, rfpath, regaddr, bitmask)	\
-	rtl8188e_PHY_QueryRFReg((adapt), (rfpath), (regaddr), (bitmask))
 
 #endif	/*  __INC_HAL8192CPHYCFG_H */
-- 
2.34.1

