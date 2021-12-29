Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0DAE4816D2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 21:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbhL2Uw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 15:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbhL2Uvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 15:51:49 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C9DC06175D
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:45 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id f134-20020a1c1f8c000000b00345c05bc12dso12313545wmf.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KNcBsGkgbuF3jMvtnNADnzVX5XV2OEwlyvafToFPdO0=;
        b=ntmCOynjOVu6CT64KOi5XybB6ojWl5kzqPoXOoQ5LX9RqCIpNj0sMhk1pMmy9sabKe
         Ga1oEN9gn9XslKY2r0yAVXnEf2ve05cYaK52KhQbDnEI09hEtLY0+5lmfsTBCoUGfYrA
         PWTdMzNYjlO0UHgTYvjAtuDPiHk9t72nt7fyk9jO7p2mLTJgXM7JK4jy+OiygxAhiWHy
         cxGUwAVzG4Toa7oMv9UalcUeRUeT4N4x+8kvt7GNFe0vD0akcyjil/vAwuPYvos0aBbE
         jOwEiYCo400tmNogBMtIl6iRg6lWsybRXhgdLGiPJmB7oZ8kM2DEFbdruUM4ZZFG+lE8
         DxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KNcBsGkgbuF3jMvtnNADnzVX5XV2OEwlyvafToFPdO0=;
        b=q8BgVR1AuRIZmq/2pS6pNWjBda6hAoNW7EO9KE19/JwDnwc4KVKTjzOHbd0/aGM7Ls
         kG/UizqfJypXf5akuKmrpldvURNpEkBXY+Pi6j+7u4gXVYcBh7sr81ZHhG7cFj5abIhM
         ohcVVZJILdsYBA166VPARZLWoHC+RG0Qc/g/bARYA940r/QUmvt8TQtKvzLVtSz9pg5y
         FQHnolF0OqNFYp4dkxAUw/58Uplsd3PgvayI+oEbRw7BgcVu3Y49zWK1DlflP928mymr
         mgBz3b222od5l8xUo7TgYNvSAaefvrMJOSumeA8rQ+CwmY0XN+3IQn8LnoWHGNCdm0dl
         4tnA==
X-Gm-Message-State: AOAM532OWzPFWTCpWYGqbDheS47bUKZPy8EQIN7iWS/Uh1vVIwdrX9T4
        1xogTLNIzba5n4l7wYCQHfU=
X-Google-Smtp-Source: ABdhPJxpcBXzLBTXK1CC834Ev/TfD3ZATrVeAoSRqJKQn1OJ4SovdHKSaENeB8g7jszRdL1LhBqpQg==
X-Received: by 2002:a05:600c:2308:: with SMTP id 8mr23139236wmo.14.1640811103700;
        Wed, 29 Dec 2021 12:51:43 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id l12sm27421989wmq.2.2021.12.29.12.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 12:51:43 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 24/32] staging: r8188eu: make odm_RSSIMonitorCheck() static
Date:   Wed, 29 Dec 2021 21:51:00 +0100
Message-Id: <20211229205108.26373-25-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229205108.26373-1-straube.linux@gmail.com>
References: <20211229205108.26373-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function odm_RSSIMonitorCheck() is only used in odm.c.
Make it static.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c             | 148 +++++++++---------
 drivers/staging/r8188eu/include/odm_precomp.h |   1 -
 2 files changed, 72 insertions(+), 77 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 88ce6675fb30..a8b477f70c29 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -456,6 +456,78 @@ static void odm_CCKPacketDetectionThresh(struct odm_dm_struct *pDM_Odm)
 	ODM_Write_CCK_CCA_Thres(pDM_Odm, CurCCK_CCAThres);
 }
 
+static void FindMinimumRSSI(struct adapter *pAdapter)
+{
+	struct hal_data_8188e *pHalData = &pAdapter->haldata;
+	struct dm_priv	*pdmpriv = &pHalData->dmpriv;
+	struct mlme_priv	*pmlmepriv = &pAdapter->mlmepriv;
+
+	/* 1 1.Determine the minimum RSSI */
+	if (!check_fwstate(pmlmepriv, _FW_LINKED) &&
+	    pdmpriv->EntryMinUndecoratedSmoothedPWDB == 0)
+		pdmpriv->MinUndecoratedPWDBForDM = 0;
+
+	pdmpriv->MinUndecoratedPWDBForDM = pdmpriv->EntryMinUndecoratedSmoothedPWDB;
+}
+
+static void odm_RSSIMonitorCheck(struct odm_dm_struct *pDM_Odm)
+{
+	struct adapter *Adapter = pDM_Odm->Adapter;
+	struct hal_data_8188e *pHalData = &Adapter->haldata;
+	struct dm_priv	*pdmpriv = &pHalData->dmpriv;
+	int	i;
+	int	tmpEntryMaxPWDB = 0, tmpEntryMinPWDB = 0xff;
+	u8	sta_cnt = 0;
+	u32 PWDB_rssi[NUM_STA] = {0};/* 0~15]:MACID, [16~31]:PWDB_rssi */
+	struct sta_info *psta;
+
+	if (!(pDM_Odm->SupportAbility & ODM_BB_RSSI_MONITOR))
+		return;
+
+	if (!check_fwstate(&Adapter->mlmepriv, _FW_LINKED))
+		return;
+
+	for (i = 0; i < ODM_ASSOCIATE_ENTRY_NUM; i++) {
+		psta = pDM_Odm->pODM_StaInfo[i];
+		if (IS_STA_VALID(psta) &&
+		    (psta->state & WIFI_ASOC_STATE) &&
+		    !is_broadcast_ether_addr(psta->hwaddr) &&
+		    memcmp(psta->hwaddr, myid(&Adapter->eeprompriv), ETH_ALEN)) {
+			if (psta->rssi_stat.UndecoratedSmoothedPWDB < tmpEntryMinPWDB)
+				tmpEntryMinPWDB = psta->rssi_stat.UndecoratedSmoothedPWDB;
+
+			if (psta->rssi_stat.UndecoratedSmoothedPWDB > tmpEntryMaxPWDB)
+				tmpEntryMaxPWDB = psta->rssi_stat.UndecoratedSmoothedPWDB;
+			if (psta->rssi_stat.UndecoratedSmoothedPWDB != (-1))
+				PWDB_rssi[sta_cnt++] = (psta->mac_id | (psta->rssi_stat.UndecoratedSmoothedPWDB << 16));
+		}
+	}
+
+	for (i = 0; i < sta_cnt; i++) {
+		if (PWDB_rssi[i] != (0)) {
+			if (pHalData->fw_ractrl) {
+				/*  Report every sta's RSSI to FW */
+			} else {
+				ODM_RA_SetRSSI_8188E(
+				&pHalData->odmpriv, (PWDB_rssi[i] & 0xFF), (u8)((PWDB_rssi[i] >> 16) & 0xFF));
+			}
+		}
+	}
+
+	if (tmpEntryMaxPWDB != 0)	/*  If associated entry is found */
+		pdmpriv->EntryMaxUndecoratedSmoothedPWDB = tmpEntryMaxPWDB;
+	else
+		pdmpriv->EntryMaxUndecoratedSmoothedPWDB = 0;
+
+	if (tmpEntryMinPWDB != 0xff) /*  If associated entry is found */
+		pdmpriv->EntryMinUndecoratedSmoothedPWDB = tmpEntryMinPWDB;
+	else
+		pdmpriv->EntryMinUndecoratedSmoothedPWDB = 0;
+
+	FindMinimumRSSI(Adapter);
+	ODM_CmnInfoUpdate(&pHalData->odmpriv, ODM_CMNINFO_RSSI_MIN, pdmpriv->MinUndecoratedPWDBForDM);
+}
+
 /* 3 Export Interface */
 
 /*  2011/09/21 MH Add to describe different team necessary resource allocate?? */
@@ -753,82 +825,6 @@ bool ODM_RAStateCheck(struct odm_dm_struct *pDM_Odm, s32 RSSI, bool bForceUpdate
 	return false;
 }
 
-/* 3============================================================ */
-/* 3 RSSI Monitor */
-/* 3============================================================ */
-
-static void FindMinimumRSSI(struct adapter *pAdapter)
-{
-	struct hal_data_8188e *pHalData = &pAdapter->haldata;
-	struct dm_priv	*pdmpriv = &pHalData->dmpriv;
-	struct mlme_priv	*pmlmepriv = &pAdapter->mlmepriv;
-
-	/* 1 1.Determine the minimum RSSI */
-	if (!check_fwstate(pmlmepriv, _FW_LINKED) &&
-	    pdmpriv->EntryMinUndecoratedSmoothedPWDB == 0)
-		pdmpriv->MinUndecoratedPWDBForDM = 0;
-
-	pdmpriv->MinUndecoratedPWDBForDM = pdmpriv->EntryMinUndecoratedSmoothedPWDB;
-}
-
-void odm_RSSIMonitorCheck(struct odm_dm_struct *pDM_Odm)
-{
-	struct adapter *Adapter = pDM_Odm->Adapter;
-	struct hal_data_8188e *pHalData = &Adapter->haldata;
-	struct dm_priv	*pdmpriv = &pHalData->dmpriv;
-	int	i;
-	int	tmpEntryMaxPWDB = 0, tmpEntryMinPWDB = 0xff;
-	u8	sta_cnt = 0;
-	u32 PWDB_rssi[NUM_STA] = {0};/* 0~15]:MACID, [16~31]:PWDB_rssi */
-	struct sta_info *psta;
-
-	if (!(pDM_Odm->SupportAbility & ODM_BB_RSSI_MONITOR))
-		return;
-
-	if (!check_fwstate(&Adapter->mlmepriv, _FW_LINKED))
-		return;
-
-	for (i = 0; i < ODM_ASSOCIATE_ENTRY_NUM; i++) {
-		psta = pDM_Odm->pODM_StaInfo[i];
-		if (IS_STA_VALID(psta) &&
-		    (psta->state & WIFI_ASOC_STATE) &&
-		    !is_broadcast_ether_addr(psta->hwaddr) &&
-		    memcmp(psta->hwaddr, myid(&Adapter->eeprompriv), ETH_ALEN)) {
-			if (psta->rssi_stat.UndecoratedSmoothedPWDB < tmpEntryMinPWDB)
-				tmpEntryMinPWDB = psta->rssi_stat.UndecoratedSmoothedPWDB;
-
-			if (psta->rssi_stat.UndecoratedSmoothedPWDB > tmpEntryMaxPWDB)
-				tmpEntryMaxPWDB = psta->rssi_stat.UndecoratedSmoothedPWDB;
-			if (psta->rssi_stat.UndecoratedSmoothedPWDB != (-1))
-				PWDB_rssi[sta_cnt++] = (psta->mac_id | (psta->rssi_stat.UndecoratedSmoothedPWDB << 16));
-		}
-	}
-
-	for (i = 0; i < sta_cnt; i++) {
-		if (PWDB_rssi[i] != (0)) {
-			if (pHalData->fw_ractrl) {
-				/*  Report every sta's RSSI to FW */
-			} else {
-				ODM_RA_SetRSSI_8188E(
-				&pHalData->odmpriv, (PWDB_rssi[i] & 0xFF), (u8)((PWDB_rssi[i] >> 16) & 0xFF));
-			}
-		}
-	}
-
-	if (tmpEntryMaxPWDB != 0)	/*  If associated entry is found */
-		pdmpriv->EntryMaxUndecoratedSmoothedPWDB = tmpEntryMaxPWDB;
-	else
-		pdmpriv->EntryMaxUndecoratedSmoothedPWDB = 0;
-
-	if (tmpEntryMinPWDB != 0xff) /*  If associated entry is found */
-		pdmpriv->EntryMinUndecoratedSmoothedPWDB = tmpEntryMinPWDB;
-	else
-		pdmpriv->EntryMinUndecoratedSmoothedPWDB = 0;
-
-	FindMinimumRSSI(Adapter);
-	ODM_CmnInfoUpdate(&pHalData->odmpriv, ODM_CMNINFO_RSSI_MIN, pdmpriv->MinUndecoratedPWDBForDM);
-}
-
 /* 3============================================================ */
 /* 3 Tx Power Tracking */
 /* 3============================================================ */
diff --git a/drivers/staging/r8188eu/include/odm_precomp.h b/drivers/staging/r8188eu/include/odm_precomp.h
index 71f3cd6eb9cd..9a22a9211d1c 100644
--- a/drivers/staging/r8188eu/include/odm_precomp.h
+++ b/drivers/staging/r8188eu/include/odm_precomp.h
@@ -34,7 +34,6 @@
 void odm_TXPowerTrackingInit(struct odm_dm_struct *pDM_Odm);
 void ODM_EdcaTurboInit(struct odm_dm_struct *pDM_Odm);
 void odm_EdcaTurboCheck(struct odm_dm_struct *pDM_Odm);
-void odm_RSSIMonitorCheck(struct odm_dm_struct *pDM_Odm);
 void odm_TXPowerTrackingThermalMeterInit(struct odm_dm_struct *pDM_Odm);
 void odm_InitHybridAntDiv(struct odm_dm_struct *pDM_Odm);
 void odm_HwAntDiv(struct odm_dm_struct *pDM_Odm);
-- 
2.34.1

