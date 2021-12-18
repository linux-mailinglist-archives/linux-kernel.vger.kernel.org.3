Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C40B7479AAD
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 13:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbhLRMFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 07:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbhLRMEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 07:04:54 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9245C06173E
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 04:04:53 -0800 (PST)
Received: from dslb-178-004-169-039.178.004.pools.vodafone-ip.de ([178.4.169.39] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1myYSI-0008I6-6T; Sat, 18 Dec 2021 13:04:50 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 9/9] staging: r8188: ODM_BB_RA_MASK is always set
Date:   Sat, 18 Dec 2021 13:04:23 +0100
Message-Id: <20211218120423.29906-10-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211218120423.29906-1-martin@kaiser.cx>
References: <20211218120423.29906-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the ODM_BB_RA_MASK capability. It is always set for this driver.

Like for ODM_BB_DIG before, we can be sure that ODM_BB_RA_MASK was never
checked before it was set.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/odm.c         | 3 ---
 drivers/staging/r8188eu/hal/rtl8188e_dm.c | 3 +--
 drivers/staging/r8188eu/include/odm.h     | 1 -
 3 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 70c83465a0a6..7a42687b3128 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -725,9 +725,6 @@ void odm_RefreshRateAdaptiveMask(struct odm_dm_struct *pDM_Odm)
 	u8 i;
 	struct adapter *pAdapter = pDM_Odm->Adapter;
 
-	if (!(pDM_Odm->SupportAbility & ODM_BB_RA_MASK))
-		return;
-
 	if (pAdapter->bDriverStopped)
 		return;
 
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
index 865e520a246d..685431034495 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
@@ -53,8 +53,7 @@ static void Update_ODM_ComInfo_88E(struct adapter *Adapter)
 	struct dm_priv	*pdmpriv = &hal_data->dmpriv;
 	int i;
 
-	pdmpriv->InitODMFlag = ODM_BB_RA_MASK |
-				ODM_BB_FA_CNT |
+	pdmpriv->InitODMFlag = ODM_BB_FA_CNT |
 				ODM_BB_RSSI_MONITOR |
 				ODM_BB_CCK_PD |
 				ODM_MAC_EDCA_TURBO |
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 6199190e5426..19e859b989ad 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -240,7 +240,6 @@ enum odm_common_info_def {
 
 enum odm_ability_def {
 	/*  BB ODM section BIT 0-15 */
-	ODM_BB_RA_MASK			= BIT(1),
 	ODM_BB_FA_CNT			= BIT(3),
 	ODM_BB_RSSI_MONITOR		= BIT(4),
 	ODM_BB_CCK_PD			= BIT(5),
-- 
2.20.1

