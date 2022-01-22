Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A13496D02
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 18:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbiAVRGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 12:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234552AbiAVRGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 12:06:03 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A77C061744
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 09:06:02 -0800 (PST)
Received: from dslb-188-097-041-028.188.097.pools.vodafone-ip.de ([188.97.41.28] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nBJpv-0002IN-34; Sat, 22 Jan 2022 18:05:59 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 4/4] staging: r8188eu: merge Init_ODM_ComInfo_88E and rtl8188e_init_dm_priv
Date:   Sat, 22 Jan 2022 18:05:47 +0100
Message-Id: <20220122170547.68378-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220122170547.68378-1-martin@kaiser.cx>
References: <20220122170547.68378-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtl8188e_init_dm_priv is the only caller of Init_ODM_ComInfo_88E.
Merge the two functions.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/rtl8188e_dm.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
index 558aa85f1a9f..a05d8687c18d 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
@@ -22,21 +22,6 @@ static void dm_InitGPIOSetting(struct adapter *Adapter)
 /*  */
 /*  functions */
 /*  */
-static void Init_ODM_ComInfo_88E(struct adapter *Adapter)
-{
-	struct hal_data_8188e *hal_data = &Adapter->haldata;
-	struct odm_dm_struct *dm_odm = &hal_data->odmpriv;
-
-	/*  Init Value */
-	memset(dm_odm, 0, sizeof(*dm_odm));
-
-	dm_odm->Adapter = Adapter;
-
-	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_MP_TEST_CHIP, IS_NORMAL_CHIP(hal_data->VersionID));
-
-	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_RF_ANTENNA_TYPE, hal_data->TRxAntDivType);
-}
-
 static void Update_ODM_ComInfo_88E(struct adapter *Adapter)
 {
 	struct mlme_ext_priv	*pmlmeext = &Adapter->mlmeextpriv;
@@ -102,9 +87,14 @@ void rtl8188e_init_dm_priv(struct adapter *Adapter)
 {
 	struct hal_data_8188e *hal_data = &Adapter->haldata;
 	struct dm_priv	*pdmpriv = &hal_data->dmpriv;
+	struct odm_dm_struct *dm_odm = &hal_data->odmpriv;
 
 	memset(pdmpriv, 0, sizeof(struct dm_priv));
-	Init_ODM_ComInfo_88E(Adapter);
+	memset(dm_odm, 0, sizeof(*dm_odm));
+
+	dm_odm->Adapter = Adapter;
+	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_MP_TEST_CHIP, IS_NORMAL_CHIP(hal_data->VersionID));
+	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_RF_ANTENNA_TYPE, hal_data->TRxAntDivType);
 }
 
 /*  Add new function to reset the state of antenna diversity before link. */
-- 
2.30.2

