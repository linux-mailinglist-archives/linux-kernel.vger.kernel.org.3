Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A180D482B62
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 14:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbiABNMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 08:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbiABNL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 08:11:59 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5F6C061761
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 05:11:58 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id w20so55896105wra.9
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jan 2022 05:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FvRr2zZDRC53mbDlWtlWTMxZW+0hRkGNjiqPsLCyMz4=;
        b=gIkLRRM+UV1pDPoaS/7PJTG1mSHdLKtOBdge1Kj2WRJCkdKjxDdJL+Ms9nTffQ5Lkp
         ZaAikvNdvBUt9MfPnfRW1W4B5VEheTRD15XSRUzusandtMpONGUaKfg8puo2YpEuyWbb
         ardBHBU5/z4vv/W647fLu1Rc+0MiNyw3x+sw2cU4NI+19Q4HjAH8GgstTp9rqY8dXvJA
         f5hWx5Ws/wK2iuXeiiv3XazjjqF6joLha8cVG2apIWKO/u9C451tLNVJykJyqcu9JO2u
         xgTLWq4zXVszy1NclnzlhBmrm/cFZd5AIJ6d0w1nuue1z/WQtX7ctqTHTt+bDj0v2ym0
         +ClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FvRr2zZDRC53mbDlWtlWTMxZW+0hRkGNjiqPsLCyMz4=;
        b=vyMHmoZJ0XwUidl97b4LC2vU03z5IA8WGiphiNoiMOItYfGdAAVYuau9B9qoXcTOG2
         y6GR+QyC4wUByh83yc37hK7AZSeIRn2bNUECRG9cDu3iOgrSS46M/WR0DHxKo7kwG4Io
         uzT5t0eiJVBK/WWlvsPVTCBYk7iVsBsEJJp3BJ9U3cwmnGQ4vC1fhIyCI3z9gnm7/dRs
         lEmSB6yypdBBoRQGSaluVoX7dKR24o64w0BsZSvH/gxeCSpLm/60v8DVGXnvEJ8s6OJj
         fFRQe+yoK2dPPr1zfwVLpDH/gHqND3/61cwDiiN84JINGAoasoG2m9GG0AXFv7HmKYpN
         Z9fw==
X-Gm-Message-State: AOAM533lvmsVHt7eVB8/Zn1wdPTn7ctMLL43hSKM57yeUL2JhmCfhUU4
        mRVBfxFkZjBGFJzX5JdjM6M=
X-Google-Smtp-Source: ABdhPJwIPHrznNLgwuB/dcsf7O5UKl+4zvCbCdjvkZHzgYi6P31JlAZpTV+0vBGEvqSR/tcotzFpqQ==
X-Received: by 2002:a05:6000:1867:: with SMTP id d7mr35500365wri.21.1641129117322;
        Sun, 02 Jan 2022 05:11:57 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id m35sm65640044wms.1.2022.01.02.05.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 05:11:57 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 05/11] staging: r8188eu: clean up struct rtw_dig
Date:   Sun,  2 Jan 2022 14:11:35 +0100
Message-Id: <20220102131141.12310-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220102131141.12310-1-straube.linux@gmail.com>
References: <20220102131141.12310-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused and set but never used fields from struct rtw_dig.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c     | 11 ---------
 drivers/staging/r8188eu/include/odm.h | 32 ---------------------------
 2 files changed, 43 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 4ec377f1b90c..d8fa587ff286 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -146,24 +146,14 @@ static void odm_DIGInit(struct odm_dm_struct *pDM_Odm)
 	struct adapter *adapter = pDM_Odm->Adapter;
 
 	pDM_DigTable->CurIGValue = (u8)rtl8188e_PHY_QueryBBReg(adapter, ODM_REG_IGI_A_11N, ODM_BIT_IGI_11N);
-	pDM_DigTable->RssiLowThresh	= DM_DIG_THRESH_LOW;
-	pDM_DigTable->RssiHighThresh	= DM_DIG_THRESH_HIGH;
-	pDM_DigTable->FALowThresh	= DM_false_ALARM_THRESH_LOW;
-	pDM_DigTable->FAHighThresh	= DM_false_ALARM_THRESH_HIGH;
 	pDM_DigTable->rx_gain_range_max = DM_DIG_MAX_NIC;
 	pDM_DigTable->rx_gain_range_min = DM_DIG_MIN_NIC;
-	pDM_DigTable->BackoffVal = DM_DIG_BACKOFF_DEFAULT;
-	pDM_DigTable->BackoffVal_range_max = DM_DIG_BACKOFF_MAX;
-	pDM_DigTable->BackoffVal_range_min = DM_DIG_BACKOFF_MIN;
-	pDM_DigTable->PreCCK_CCAThres = 0xFF;
 	pDM_DigTable->CurCCK_CCAThres = 0x83;
 	pDM_DigTable->ForbiddenIGI = DM_DIG_MIN_NIC;
 	pDM_DigTable->LargeFAHit = 0;
 	pDM_DigTable->Recover_cnt = 0;
 	pDM_DigTable->DIG_Dynamic_MIN_0 = DM_DIG_MIN_NIC;
-	pDM_DigTable->DIG_Dynamic_MIN_1 = DM_DIG_MIN_NIC;
 	pDM_DigTable->bMediaConnect_0 = false;
-	pDM_DigTable->bMediaConnect_1 = false;
 
 	/* To Initialize pDM_Odm->bDMInitialGainEnable == false to avoid DIG error */
 	pDM_Odm->bDMInitialGainEnable = true;
@@ -771,7 +761,6 @@ void ODM_Write_CCK_CCA_Thres(struct odm_dm_struct *pDM_Odm, u8 CurCCK_CCAThres)
 
 	if (pDM_DigTable->CurCCK_CCAThres != CurCCK_CCAThres)		/* modify by Guo.Mingzhi 2012-01-03 */
 		rtw_write8(pDM_Odm->Adapter, ODM_REG_CCK_CCA_11N, CurCCK_CCAThres);
-	pDM_DigTable->PreCCK_CCAThres = pDM_DigTable->CurCCK_CCAThres;
 	pDM_DigTable->CurCCK_CCAThres = CurCCK_CCAThres;
 }
 
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 46fdc87a5e2f..065f2ec91a38 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -5,43 +5,21 @@
 #define __HALDMOUTSRC_H__
 
 struct rtw_dig {
-	u8		Dig_Enable_Flag;
-	u8		Dig_Ext_Port_Stage;
-
-	int		RssiLowThresh;
-	int		RssiHighThresh;
-
-	u32		FALowThresh;
-	u32		FAHighThresh;
-
-	u8		CurSTAConnectState;
-	u8		PreSTAConnectState;
-	u8		CurMultiSTAConnectState;
-
 	u8		PreIGValue;
 	u8		CurIGValue;
 	u8		BackupIGValue;
 
-	s8		BackoffVal;
-	s8		BackoffVal_range_max;
-	s8		BackoffVal_range_min;
 	u8		rx_gain_range_max;
 	u8		rx_gain_range_min;
-	u8		Rssi_val_min;
 
-	u8		PreCCK_CCAThres;
 	u8		CurCCK_CCAThres;
-	u8		PreCCKPDState;
-	u8		CurCCKPDState;
 
 	u8		LargeFAHit;
 	u8		ForbiddenIGI;
 	u32		Recover_cnt;
 
 	u8		DIG_Dynamic_MIN_0;
-	u8		DIG_Dynamic_MIN_1;
 	bool		bMediaConnect_0;
-	bool		bMediaConnect_1;
 
 	u32		AntDiv_RSSI_max;
 	u32		RSSI_max;
@@ -482,12 +460,6 @@ enum odm_bb_config_type {
     CONFIG_BB_PHY_REG_PG,
 };
 
-#define		DM_DIG_THRESH_HIGH	40
-#define		DM_DIG_THRESH_LOW	35
-
-#define		DM_false_ALARM_THRESH_LOW	400
-#define		DM_false_ALARM_THRESH_HIGH	1000
-
 #define		DM_DIG_MAX_NIC			0x4e
 #define		DM_DIG_MIN_NIC			0x1e /* 0x22/0x1c */
 
@@ -499,10 +471,6 @@ enum odm_bb_config_type {
 #define		DM_DIG_FA_TH1			0x300/* 0x100 */
 #define		DM_DIG_FA_TH2			0x400/* 0x200 */
 
-#define		DM_DIG_BACKOFF_MAX		12
-#define		DM_DIG_BACKOFF_MIN		-4
-#define		DM_DIG_BACKOFF_DEFAULT		10
-
 /* 3=========================================================== */
 /* 3 Rate Adaptive */
 /* 3=========================================================== */
-- 
2.34.1

