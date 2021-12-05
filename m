Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C72F468B4C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 14:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbhLEODF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 09:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234487AbhLEOC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 09:02:58 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDFBC061751
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 05:59:31 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id z5so32426504edd.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 05:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DwRLv5H29GbAV6Kv9MVr4Rdwt+uLpu89Tpr+vCGYYpQ=;
        b=AeOJ1gDkvGtFxC5yp11D1aJE3b5pC2jHwg1z0HeKWs/kEcRbOXz7FY0m+grHnTZRQg
         9jzOxUP+EMSXUYoQUukCEr2qdpEl2rDbhRh92HKe9kAGbC5/79naS8w6oNRGBTJO0u7B
         5CZn41eC34Kq86TMEpFtYOj2MBEaDBepfNIgHCy8zLh7b8RQ/ZTHK3PLFKdJQsoT1jM7
         imLDPPJGWer2qdm+r2Hjtz1t46DXtwU+84TwSrBhNeCHvNH9wP9BqsSehNKREQQKnkEf
         7NpL26JgbwqEixoUCvD72G3cHefHi4JhOjKIurj6YtfaQR7eQK0KSCOua8ZSHu+ZZg5x
         HwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DwRLv5H29GbAV6Kv9MVr4Rdwt+uLpu89Tpr+vCGYYpQ=;
        b=yf3V5jA1zwPYd6BcmeWbHHNQh/fKnIGoFCdprH4ExwNV1hQageWCxmx3WRPw5iJdLE
         NJmLi3PJBMFX1Hf2y5yxv/8cNYo2Tu9sWm+X/GWyvmV6qARU5fjWYriWOMzE39souqkZ
         s9NtMO/4G5kUqhImn5UF/QD6XrFnvXnaCPnZtaP8+MxngasTzkA1DoJu/ouWCHR6wPy0
         fzb4qZFSF8ZkjAMNTqhhn2NXOPHIZwNaBvzZwCZJb+ayzdmo7CEIofl6jCMhHNERUoOa
         ixVRjCMkxGRjsV0vF0/y1iK/+m56tkRDbD2y116hBl8kYtHEvngEMlVaI27jUe3rGwkO
         vPLw==
X-Gm-Message-State: AOAM533McfwXIRtlftQScD9zPnWWovpXXMy4VzzaVe3RezzY+hQfdkit
        xQ8ISt7WhbaKUsXUqnwymXM=
X-Google-Smtp-Source: ABdhPJwiTEvfFy/PvMIVt1w7UD0Z+QQ7j13+kd3hFVFeNi0E3mMlh+hwLG6iO+mvJwBBszAIayrJug==
X-Received: by 2002:a17:906:d54e:: with SMTP id cr14mr38072571ejc.458.1638712769771;
        Sun, 05 Dec 2021 05:59:29 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::5a05])
        by smtp.gmail.com with ESMTPSA id yd20sm5146451ejb.47.2021.12.05.05.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 05:59:29 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 03/12] staging: r8188eu: remove macro PHY_SetRFReg
Date:   Sun,  5 Dec 2021 14:59:10 +0100
Message-Id: <20211205135919.30460-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205135919.30460-1-straube.linux@gmail.com>
References: <20211205135919.30460-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro PHY_SetRFReg just re-defines rtl8188e_PHY_SetRFReg().
Call rtl8188e_PHY_SetRFReg() directly and remove the macro.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c                | 2 +-
 drivers/staging/r8188eu/hal/odm_interface.c      | 2 +-
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c    | 2 +-
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c    | 4 ++--
 drivers/staging/r8188eu/include/Hal8188EPhyCfg.h | 2 --
 5 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 4cce9bf215f4..8779d5accf52 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -890,7 +890,7 @@ void ODM_TXPowerTrackingCheck(struct odm_dm_struct *pDM_Odm)
 		return;
 
 	if (!pDM_Odm->RFCalibrateInfo.TM_Trigger) {		/* at least delay 1 sec */
-		PHY_SetRFReg(Adapter, RF_PATH_A, RF_T_METER_88E, BIT(17) | BIT(16), 0x03);
+		rtl8188e_PHY_SetRFReg(Adapter, RF_PATH_A, RF_T_METER_88E, BIT(17) | BIT(16), 0x03);
 
 		pDM_Odm->RFCalibrateInfo.TM_Trigger = 1;
 		return;
diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
index 966712bd3bcb..b6f55709df9f 100644
--- a/drivers/staging/r8188eu/hal/odm_interface.c
+++ b/drivers/staging/r8188eu/hal/odm_interface.c
@@ -31,7 +31,7 @@ u32 ODM_GetBBReg(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u32 BitMask)
 void ODM_SetRFReg(struct odm_dm_struct *pDM_Odm, enum rf_radio_path	eRFPath, u32 RegAddr, u32 BitMask, u32 Data)
 {
 	struct adapter *Adapter = pDM_Odm->Adapter;
-	PHY_SetRFReg(Adapter, (enum rf_radio_path)eRFPath, RegAddr, BitMask, Data);
+	rtl8188e_PHY_SetRFReg(Adapter, (enum rf_radio_path)eRFPath, RegAddr, BitMask, Data);
 }
 
 u32 ODM_GetRFReg(struct odm_dm_struct *pDM_Odm, enum rf_radio_path	eRFPath, u32 RegAddr, u32 BitMask)
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index 3d921767db91..99096a5d3041 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -771,7 +771,7 @@ static void _PHY_SwChnl8192C(struct adapter *Adapter, u8 channel)
 	param1 = RF_CHNLBW;
 	param2 = channel;
 	pHalData->RfRegChnlVal[eRFPath] = ((pHalData->RfRegChnlVal[eRFPath] & 0xfffffc00) | param2);
-	PHY_SetRFReg(Adapter, (enum rf_radio_path)eRFPath, param1, bRFRegOffsetMask, pHalData->RfRegChnlVal[eRFPath]);
+	rtl8188e_PHY_SetRFReg(Adapter, (enum rf_radio_path)eRFPath, param1, bRFRegOffsetMask, pHalData->RfRegChnlVal[eRFPath]);
 }
 
 void PHY_SwChnl8188E(struct adapter *Adapter, u8 channel)
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
index 813dd938c817..45ab988e9be7 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
@@ -51,11 +51,11 @@ void rtl8188e_PHY_RF6052SetBandwidth(struct adapter *Adapter,
 	switch (Bandwidth) {
 	case HT_CHANNEL_WIDTH_20:
 		pHalData->RfRegChnlVal[0] = ((pHalData->RfRegChnlVal[0] & 0xfffff3ff) | BIT(10) | BIT(11));
-		PHY_SetRFReg(Adapter, RF_PATH_A, RF_CHNLBW, bRFRegOffsetMask, pHalData->RfRegChnlVal[0]);
+		rtl8188e_PHY_SetRFReg(Adapter, RF_PATH_A, RF_CHNLBW, bRFRegOffsetMask, pHalData->RfRegChnlVal[0]);
 		break;
 	case HT_CHANNEL_WIDTH_40:
 		pHalData->RfRegChnlVal[0] = ((pHalData->RfRegChnlVal[0] & 0xfffff3ff) | BIT(10));
-		PHY_SetRFReg(Adapter, RF_PATH_A, RF_CHNLBW, bRFRegOffsetMask, pHalData->RfRegChnlVal[0]);
+		rtl8188e_PHY_SetRFReg(Adapter, RF_PATH_A, RF_CHNLBW, bRFRegOffsetMask, pHalData->RfRegChnlVal[0]);
 		break;
 	default:
 		break;
diff --git a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
index 6b108800d8d2..467ee48fa49c 100644
--- a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
+++ b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
@@ -140,7 +140,5 @@ void storePwrIndexDiffRateOffset(struct adapter *adapter, u32 regaddr,
 	 rtl8188e_PHY_SetBBReg((adapt), (regaddr), (bitmask), (data))
 #define PHY_QueryRFReg(adapt, rfpath, regaddr, bitmask)	\
 	rtl8188e_PHY_QueryRFReg((adapt), (rfpath), (regaddr), (bitmask))
-#define PHY_SetRFReg(adapt, rfpath, regaddr, bitmask, data)	\
-	rtl8188e_PHY_SetRFReg((adapt), (rfpath), (regaddr), (bitmask), (data))
 
 #endif	/*  __INC_HAL8192CPHYCFG_H */
-- 
2.34.1

