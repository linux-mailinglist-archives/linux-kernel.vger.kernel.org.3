Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3904816C6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 21:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbhL2Uvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 15:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbhL2Uvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 15:51:36 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B74C061751
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:35 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id v7so46496628wrv.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0tEcEKEhMAf+p+W97OxzOZ8O3ogIaO1IGoSzDMSrfzs=;
        b=R9aqlwl15GTLUUilUJhnb/9qpCu+pknb2U2GZzHRxXrNGFq2Mh+g2xhfLS+U41usk+
         Hk6zJbjS6BCy5zaXpKh1TPi4YSsWViI43oZZvhBX8ye4HnF3v9pagieZfTyUPf9FIJMP
         Q0mHIOfi9iw8f1mO5xMi5yR/qsvCrifP2C3ATr8vEXB0x9cw9dTYHgdlmybHdsOHCFf3
         GECM/vaikgK3KshqjYA7ORr/hEm2AZ5g5Hc4md5TFOaacIqDgj9W75rDMAvKiAK0ESSV
         7JZqFg2KMUxIK/WXoA1UDDYd7MKW2Q/XV/2gdSk+qIj43e7ykdF4iY7gMZVnh8P2pJTx
         uFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0tEcEKEhMAf+p+W97OxzOZ8O3ogIaO1IGoSzDMSrfzs=;
        b=gOL4KgJYmL8AU/Qt4Ef1Ub0IyyMx1a+4KO6/yv5QINcaMDg6sjcsbg3DyJs0jI8CQK
         t+F7bnN3hXRkP0iB3AIEMOXRcvrgtp1VZvGSfB4020lywrFKA9kcJF0T4rBoJTJtE11g
         a8xHWzzjeWkI4f8MrcZQNy50z5DTp47ieygYIfNWxAaFgb6iwDVcBuqJIAuJjtPCXUTN
         ltz+yTz7lJKtRR7BSi3/Ep4Gf4Y7qZS0gylgtbFWPYA4fs3/xZSCbDIKAOZpN9xToTHD
         Se3zsQhDntFCn4vAE++/azoFucqvKesMpCcS6BkNLXYxDclwWkqfzxU/RkUYh+pFWy4U
         YW1Q==
X-Gm-Message-State: AOAM530OT27XlZAu/l83HnUQzynDbEARnswLMZqATMf5aRvuy+Vz0YuI
        13FiMvpAE0F/IqI5PXgoxkY=
X-Google-Smtp-Source: ABdhPJxCQaA3FvH2D6UhnZjVj5FKFwgMTkEYTm5voVwWrAEumomx573p3TOgsc8PPLdjzrwTm+UHjg==
X-Received: by 2002:adf:dd11:: with SMTP id a17mr22208307wrm.174.1640811093648;
        Wed, 29 Dec 2021 12:51:33 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id l12sm27421989wmq.2.2021.12.29.12.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 12:51:33 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 10/32] staging: r8188eu: remove ODM_delay_ms()
Date:   Wed, 29 Dec 2021 21:50:46 +0100
Message-Id: <20211229205108.26373-11-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229205108.26373-1-straube.linux@gmail.com>
References: <20211229205108.26373-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ODM_delay_ms() is just a wrapper around mdelay().
Remove ODM_delay_ms() and call mdelay() directly.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c     |  8 ++++----
 drivers/staging/r8188eu/hal/odm_RegConfig8188E.c | 12 ++++++------
 drivers/staging/r8188eu/hal/odm_interface.c      |  6 ------
 drivers/staging/r8188eu/include/odm_interface.h  |  3 ---
 4 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index 35e1c81bf9a7..5db8ea92046e 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -382,7 +382,7 @@ phy_PathA_IQK_8188E(struct adapter *adapt)
 
 	/*  delay x ms */
 	/* PlatformStallExecution(IQK_DELAY_TIME_88E*1000); */
-	ODM_delay_ms(IQK_DELAY_TIME_88E);
+	mdelay(IQK_DELAY_TIME_88E);
 
 	/*  Check failed */
 	regeac = rtl8188e_PHY_QueryBBReg(adapt, rRx_Power_After_IQK_A_2, bMaskDWord);
@@ -434,7 +434,7 @@ phy_PathA_RxIQK(struct adapter *adapt)
 	rtl8188e_PHY_SetBBReg(adapt, rIQK_AGC_Pts, bMaskDWord, 0xf8000000);
 
 	/*  delay x ms */
-	ODM_delay_ms(IQK_DELAY_TIME_88E);
+	mdelay(IQK_DELAY_TIME_88E);
 
 	/*  Check failed */
 	regeac = rtl8188e_PHY_QueryBBReg(adapt, rRx_Power_After_IQK_A_2, bMaskDWord);
@@ -478,7 +478,7 @@ phy_PathA_RxIQK(struct adapter *adapt)
 
 	/*  delay x ms */
 	/* PlatformStallExecution(IQK_DELAY_TIME_88E*1000); */
-	ODM_delay_ms(IQK_DELAY_TIME_88E);
+	mdelay(IQK_DELAY_TIME_88E);
 
 	/*  Check failed */
 	regeac = rtl8188e_PHY_QueryBBReg(adapt, rRx_Power_After_IQK_A_2, bMaskDWord);
@@ -1000,7 +1000,7 @@ void PHY_LCCalibrate_8188E(struct adapter *adapt)
 		return;
 
 	while (*dm_odm->pbScanInProcess && timecount < timeout) {
-		ODM_delay_ms(50);
+		mdelay(50);
 		timecount += 50;
 	}
 
diff --git a/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c b/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
index 20201353c14f..3f1e30eb1a15 100644
--- a/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
+++ b/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
@@ -10,9 +10,9 @@ void odm_ConfigRFReg_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr,
 	if (Addr == 0xffe) {
 		msleep(50);
 	} else if (Addr == 0xfd) {
-		ODM_delay_ms(5);
+		mdelay(5);
 	} else if (Addr == 0xfc) {
-		ODM_delay_ms(1);
+		mdelay(1);
 	} else if (Addr == 0xfb) {
 		udelay(50);
 	} else if (Addr == 0xfa) {
@@ -52,9 +52,9 @@ void odm_ConfigBB_PHY_REG_PG_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr,
 	if (Addr == 0xfe)
 		msleep(50);
 	else if (Addr == 0xfd)
-		ODM_delay_ms(5);
+		mdelay(5);
 	else if (Addr == 0xfc)
-		ODM_delay_ms(1);
+		mdelay(1);
 	else if (Addr == 0xfb)
 		udelay(50);
 	else if (Addr == 0xfa)
@@ -70,9 +70,9 @@ void odm_ConfigBB_PHY_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u32 Bitmask
 	if (Addr == 0xfe) {
 		msleep(50);
 	} else if (Addr == 0xfd) {
-		ODM_delay_ms(5);
+		mdelay(5);
 	} else if (Addr == 0xfc) {
-		ODM_delay_ms(1);
+		mdelay(1);
 	} else if (Addr == 0xfb) {
 		udelay(50);
 	} else if (Addr == 0xfa) {
diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
index ce9832ab7b13..03a149069126 100644
--- a/drivers/staging/r8188eu/hal/odm_interface.c
+++ b/drivers/staging/r8188eu/hal/odm_interface.c
@@ -9,9 +9,3 @@ s32 ODM_CompareMemory(struct odm_dm_struct *pDM_Odm, void *pBuf1, void *pBuf2, u
 {
 	return !memcmp(pBuf1, pBuf2, length);
 }
-
-/*  ODM Timer relative API. */
-void ODM_delay_ms(u32 ms)
-{
-	mdelay(ms);
-}
diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
index 20c662628646..d5a75dfe0f8e 100644
--- a/drivers/staging/r8188eu/include/odm_interface.h
+++ b/drivers/staging/r8188eu/include/odm_interface.h
@@ -16,7 +16,4 @@ typedef void (*RT_WORKITEM_CALL_BACK)(void *pContext);
 s32 ODM_CompareMemory(struct odm_dm_struct *pDM_Odm, void *pBuf1, void *pBuf2,
 		      u32 length);
 
-/*  ODM Timer relative API. */
-void ODM_delay_ms(u32 ms);
-
 #endif	/*  __ODM_INTERFACE_H__ */
-- 
2.34.1

