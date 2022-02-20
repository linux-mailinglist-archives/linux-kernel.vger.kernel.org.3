Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AC74BCDA0
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 11:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243688AbiBTKDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 05:03:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243714AbiBTKC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 05:02:58 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EB83A73D
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 02:02:21 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id x5so23365419edd.11
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 02:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PvjuSNwJ8S2bAfJeYCb6vqgAaUeufjbgam2qLYBulCE=;
        b=IWyTuQ9QU3bxQYW4bVMBvLJ/2j7QXL7x4dcZ6FZxSeWS6fWDqJCwgRCBusT81WzwDK
         nfUjLwsdxpxFrMSfckvEoxnCmR3bz/dkc//ItMXow+wiPGDcG6X7E7Z3hM8fUrIrn8iQ
         UtlKwzkGFdRnxLpjvj8DnBydIy4sF1aAB9Se/4LndqM6cP2fIchvgtTlomVBEh+1bwmy
         ERkl4ULYmKX/hnR2N6sxZaIUKB5kGuR2vGQpOKF/xHjQkdUUopQQl+0M40rHxjGaCJE/
         ZD8biY+HHp+hLWxwPCdkh8/FZiYXJWyAxM9ZWWLlEVnKKDi48eicBKIdRvdRoOnMATpB
         TGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PvjuSNwJ8S2bAfJeYCb6vqgAaUeufjbgam2qLYBulCE=;
        b=BamQhEqXzOcSCj9Fgj1ygO5Wp+A3rB+NJi5uymewTIcyCuvG2szThnwsExS5Fmsiop
         l4tmU4AZ/Tby1xGWANAtCuniAACKVjMa5ay5UhpBTyJVHzuEDzdk6o/0tB2XadUj8zct
         mtcyJzEbVBLF9qMLtEgCV/9rmAes5X64VKsr4UVJvsXDwX5aSuZfWseaNcNBsQGNv40q
         X8p7ki62jGUkCc4OTeEdCbw44fVFLBXVXTEZwcvAaUC0oxasU2pERCpF1zNSwX2yFDm3
         41/6LULNV1pvfs8vOCXzGd57Uph2fDRi0lNE3ctC9/7Ci+MTwOnOKAdIrfBy+C7kW8Sr
         oNlQ==
X-Gm-Message-State: AOAM532F24fwxJpZjl0UIRJywINS56CGetrut7+uEgrE8TM3m86FLWQ/
        DmoaCM3mJ0v2VumHlxaOgv4=
X-Google-Smtp-Source: ABdhPJzylaPtQT7mAPX4yfG6fnOqCWzjjIWykVIZG1NnOeHK3b8Y9JWsjDsSPBi/x0vBfek+pjKLjQ==
X-Received: by 2002:a05:6402:2801:b0:40f:f179:c3ca with SMTP id h1-20020a056402280100b0040ff179c3camr16321779ede.226.1645351339825;
        Sun, 20 Feb 2022 02:02:19 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb8f.dynamic.kabel-deutschland.de. [95.90.187.143])
        by smtp.gmail.com with ESMTPSA id dx7sm3265223ejb.23.2022.02.20.02.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 02:02:19 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/5] staging: r8188eu: remove ODM_CmnInfoHook()
Date:   Sun, 20 Feb 2022 11:02:08 +0100
Message-Id: <20220220100212.7466-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220220100212.7466-1-straube.linux@gmail.com>
References: <20220220100212.7466-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each case in ODM_CmnInfoHook() just sets a single variable. Set the
variables directly and remove ODM_CmnInfoHook().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c         | 31 -----------------------
 drivers/staging/r8188eu/hal/rtl8188e_dm.c | 13 +++++-----
 drivers/staging/r8188eu/include/odm.h     | 14 ----------
 3 files changed, 7 insertions(+), 51 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index e0824eefd83a..6f594ae33c6e 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -639,37 +639,6 @@ void ODM_CmnInfoInit(struct odm_dm_struct *pDM_Odm, enum odm_common_info_def Cmn
 	pDM_Odm->BbSwingFlagOfdm		= false;
 }
 
-void ODM_CmnInfoHook(struct odm_dm_struct *pDM_Odm, enum odm_common_info_def CmnInfo, void *pValue)
-{
-	/*  */
-	/*  Hook call by reference pointer. */
-	/*  */
-	switch	(CmnInfo) {
-	/*  Dynamic call by reference pointer. */
-	case	ODM_CMNINFO_WM_MODE:
-		pDM_Odm->pWirelessMode = (u8 *)pValue;
-		break;
-	case	ODM_CMNINFO_SEC_CHNL_OFFSET:
-		pDM_Odm->pSecChOffset = (u8 *)pValue;
-		break;
-	case	ODM_CMNINFO_BW:
-		pDM_Odm->pBandWidth = (u8 *)pValue;
-		break;
-	case	ODM_CMNINFO_CHNL:
-		pDM_Odm->pChannel = (u8 *)pValue;
-		break;
-	case	ODM_CMNINFO_SCAN:
-		pDM_Odm->pbScanInProcess = (bool *)pValue;
-		break;
-	case	ODM_CMNINFO_POWER_SAVING:
-		pDM_Odm->pbPowerSaving = (bool *)pValue;
-		break;
-	default:
-		/* do nothing */
-		break;
-	}
-}
-
 /*  Update Band/CHannel/.. The values are dynamic but non-per-packet. */
 void ODM_CmnInfoUpdate(struct odm_dm_struct *pDM_Odm, u32 CmnInfo, u64 Value)
 {
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
index a05d8687c18d..09e78c4855f9 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
@@ -38,12 +38,13 @@ static void Update_ODM_ComInfo_88E(struct adapter *Adapter)
 
 	ODM_CmnInfoUpdate(dm_odm, ODM_CMNINFO_ABILITY, pdmpriv->InitODMFlag);
 
-	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_WM_MODE, &pmlmeext->cur_wireless_mode);
-	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_SEC_CHNL_OFFSET, &hal_data->nCur40MhzPrimeSC);
-	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_BW, &hal_data->CurrentChannelBW);
-	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_CHNL, &hal_data->CurrentChannel);
-	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_SCAN, &pmlmepriv->bScanInProcess);
-	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_POWER_SAVING, &pwrctrlpriv->bpower_saving);
+	dm_odm->pWirelessMode = &pmlmeext->cur_wireless_mode;
+	dm_odm->pSecChOffset = &hal_data->nCur40MhzPrimeSC;
+	dm_odm->pBandWidth = (u8 *)&hal_data->CurrentChannelBW;
+	dm_odm->pChannel = &hal_data->CurrentChannel;
+	dm_odm->pbScanInProcess = (bool *)&pmlmepriv->bScanInProcess;
+	dm_odm->pbPowerSaving = (bool *)&pwrctrlpriv->bpower_saving;
+
 	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_RF_ANTENNA_TYPE, hal_data->TRxAntDivType);
 
 	for (i = 0; i < NUM_STA; i++)
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 9fb09e0a0df9..0e85bd88ab8a 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -126,17 +126,6 @@ enum odm_common_info_def {
 	ODM_CMNINFO_MP_TEST_CHIP,
 	/* HOOK BEFORE REG INIT-----------  */
 
-	/*  Dynamic value: */
-/*  POINTER REFERENCE-----------  */
-	ODM_CMNINFO_WM_MODE,		/*  ODM_WIRELESS_MODE_E */
-	ODM_CMNINFO_SEC_CHNL_OFFSET,	/*  ODM_SEC_CHNL_OFFSET_E */
-	ODM_CMNINFO_BW,			/*  ODM_BW_E */
-	ODM_CMNINFO_CHNL,
-
-	ODM_CMNINFO_SCAN,
-	ODM_CMNINFO_POWER_SAVING,
-/*  POINTER REFERENCE----------- */
-
 /* CALL BY VALUE------------- */
 	ODM_CMNINFO_LINK,
 	ODM_CMNINFO_RSSI_MIN,
@@ -472,9 +461,6 @@ void ODM_DMWatchdog(struct odm_dm_struct *pDM_Odm);
 void ODM_CmnInfoInit(struct odm_dm_struct *pDM_Odm,
 		     enum odm_common_info_def CmnInfo, u32 Value);
 
-void ODM_CmnInfoHook(struct odm_dm_struct *pDM_Odm,
-		     enum odm_common_info_def CmnInfo, void *pValue);
-
 void ODM_CmnInfoUpdate(struct odm_dm_struct *pDM_Odm, u32 CmnInfo, u64 Value);
 
 #endif
-- 
2.35.1

