Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 853AC482C80
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 19:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiABSAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 13:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiABSAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 13:00:24 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07743C061784
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 10:00:23 -0800 (PST)
Received: from dslb-188-104-058-096.188.104.pools.vodafone-ip.de ([188.104.58.96] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n459X-0005Ye-Pu; Sun, 02 Jan 2022 19:00:20 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 5/5] staging: r8188eu: turbo scan is always off for r8188eu
Date:   Sun,  2 Jan 2022 18:59:32 +0100
Message-Id: <20220102175932.89127-6-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220102175932.89127-1-martin@kaiser.cx>
References: <20220102175932.89127-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turbo scan is always disabled. Remove the TurboScanOff variable and
related checks.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c | 21 +++++++------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
index 0b982cc7c86f..6e0231099986 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
@@ -87,28 +87,21 @@ rtl8188e_PHY_RF6052SetCckTxPower(
 	struct hal_data_8188e *pHalData = &Adapter->haldata;
 	struct mlme_ext_priv *pmlmeext = &Adapter->mlmeextpriv;
 	u32 TxAGC[2] = {0, 0}, tmpval = 0, pwrtrac_value;
-	bool TurboScanOff = false;
 	u8 idx1, idx2;
 	u8 *ptr;
 	u8 direction;
-	/* FOR CE ,must disable turbo scan */
-	TurboScanOff = true;
 
 	if (pmlmeext->sitesurvey_res.state == SCAN_PROCESS) {
 		TxAGC[RF_PATH_A] = 0x3f3f3f3f;
 		TxAGC[RF_PATH_B] = 0x3f3f3f3f;
 
-		TurboScanOff = true;/* disable turbo scan */
-
-		if (TurboScanOff) {
-			for (idx1 = RF_PATH_A; idx1 <= RF_PATH_B; idx1++) {
-				TxAGC[idx1] =
-					pPowerlevel[idx1] | (pPowerlevel[idx1] << 8) |
-					(pPowerlevel[idx1] << 16) | (pPowerlevel[idx1] << 24);
-				/*  2010/10/18 MH For external PA module. We need to limit power index to be less than 0x20. */
-				if (TxAGC[idx1] > 0x20 && pHalData->ExternalPA)
-					TxAGC[idx1] = 0x20;
-			}
+		for (idx1 = RF_PATH_A; idx1 <= RF_PATH_B; idx1++) {
+			TxAGC[idx1] =
+				pPowerlevel[idx1] | (pPowerlevel[idx1] << 8) |
+				(pPowerlevel[idx1] << 16) | (pPowerlevel[idx1] << 24);
+			/*  2010/10/18 MH For external PA module. We need to limit power index to be less than 0x20. */
+			if (TxAGC[idx1] > 0x20 && pHalData->ExternalPA)
+				TxAGC[idx1] = 0x20;
 		}
 	} else {
 		for (idx1 = RF_PATH_A; idx1 <= RF_PATH_B; idx1++) {
-- 
2.30.2

