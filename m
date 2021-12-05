Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B82468C58
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 18:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236643AbhLERSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 12:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236605AbhLERSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 12:18:04 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC5AC061714
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 09:14:36 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id t5so33409118edd.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 09:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DwRLv5H29GbAV6Kv9MVr4Rdwt+uLpu89Tpr+vCGYYpQ=;
        b=j1CPpLEkuliVU7NxMjE3+goGmyEf8DX0sJG0tkKIFX96p5IlHbNzXC/fsJ+9RPhNtA
         CbPp6fTjtaicZuqNBzI3eXLIgJjoui7+OcUTJQbCspMuNwBEsoaeaLwBWo9iK6CKbuGA
         64LOflnMEWBc345CEL2VsoxfLE539hG+KZtjnQS9mXWeCtK4jmsr7/sGbsu3FlsAE5Og
         0mYA6LPHXteXcR9wH9sdHKhZ9/q/Ng0U5sWMyCBjfVhWuz97ukMYJOOIfO57aOJWY5vR
         1hKxLdV7iKcYp2YDStdoi3aD6sz/KPiAlPscOi1aRxF4f4vqtO49Uf5IgYC25bksdnmD
         QNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DwRLv5H29GbAV6Kv9MVr4Rdwt+uLpu89Tpr+vCGYYpQ=;
        b=mx5/VeJWPNY7LithYU/EzseWgRGYyN3aDYeyEJVydEXgDZNy5fM8ob0BLPOmEd9YLR
         X7HWQ72X6y5bMfRAXUi45JrVaNBvdpS/ilZpaWlAiFtzPZxNxbjbS4vUWMcgYo3WWlxP
         f92mWd9GluxDRPb2EHVuoT6llCF9z2ya/ojJoV7v2yoIv8nGgfO6/rK0nGKIHdJ3H0sZ
         ikwLcMR5m++o3BPIAot48dQBjGzVJhbTAbu0CJuHgrrR3w2g5tyEARQpRB7Whba1ROV7
         vFBw/98NVGkgSjLiyb+FkzKSYwDksNwK5G+dPuVs0X0TBju3o7JD+kl9NS41nRibmZZ9
         8HpQ==
X-Gm-Message-State: AOAM53245377QDDXMWjhVKbrWDsGe7YPsRc1sFyMfdlxuIryxIXqDGbk
        51IFCc8F15Dpn7oSbG8YlOE=
X-Google-Smtp-Source: ABdhPJzwuoACsnDRuBh1aqAdibFzKDKKVRzUA0IjvIjdLyaYu0ggrsaw9HcqghV5Mu1/paOYSqBNzQ==
X-Received: by 2002:a17:906:b88f:: with SMTP id hb15mr39663359ejb.91.1638724475512;
        Sun, 05 Dec 2021 09:14:35 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::b792])
        by smtp.gmail.com with ESMTPSA id ch28sm6071773edb.72.2021.12.05.09.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 09:14:35 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 03/10] staging: r8188eu: remove macro PHY_SetRFReg
Date:   Sun,  5 Dec 2021 18:13:35 +0100
Message-Id: <20211205171342.20551-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205171342.20551-1-straube.linux@gmail.com>
References: <20211205171342.20551-1-straube.linux@gmail.com>
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

