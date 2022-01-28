Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35F849F82A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 12:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348169AbiA1LUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 06:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348159AbiA1LUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 06:20:35 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18831C061714;
        Fri, 28 Jan 2022 03:20:35 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id CA6991F45E5C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643368833;
        bh=x9fTrAMc+WSP7mUnGClV42n8Ny1xy61uKU+6iyvm7GM=;
        h=From:To:Cc:Subject:Date:From;
        b=UcgiNIymLKglSL0k9dF6TP6kXedYMV/pfnHQ9UiAenR0xAImysoIGXUDO+9BAY5IF
         cMSesaH7aLUKdK3xdapCkWVtd7hk6s9lvFxRjjklNpRLo6m2wLCPUEOJ8hU9AAmjW4
         U/ZS3Gb1lq7uskP5t00uH7q++y+52eYHKuoQEIsizcl2JWQ/vuRMbtzTain71HmTMM
         w4YKMbkklB6uFS8UtqjPLarLkHUD1j+XbW1saitECLY+q3OmvAGVqVRo6QdIIWO28a
         cVAxORaNevI2LcY5rxxKYYQtOr0B8vHpf753CgxAE4QC9IMncSEXu+z3CCk7++UjK3
         lOf+l4c/MDFlg==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, kernel-janitors@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rt8188eu: Remove dead code
Date:   Fri, 28 Jan 2022 16:19:54 +0500
Message-Id: <20220128111954.1028121-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtStatus is _SUCCESS when the execution reaches this if condition.
Remove the dead code.

Fixes: 67396d2dfef3 ("staging: r8188eu: merge ODM_ConfigBBWithHeaderFile with its callers")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index 0b0690dfb947c..41a0d7f0d29f4 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -504,9 +504,6 @@ static	int phy_BB8188E_Config_ParaFile(struct adapter *Adapter)
 		ODM_ReadAndConfig_PHY_REG_PG_8188E(&pHalData->odmpriv);
 	}
 
-	if (rtStatus != _SUCCESS)
-		goto phy_BB8190_Config_ParaFile_Fail;
-
 	/*  3. BB AGC table Initialization */
 	if (HAL_STATUS_FAILURE == ODM_ReadAndConfig_AGC_TAB_1T_8188E(&pHalData->odmpriv))
 		rtStatus = _FAIL;
-- 
2.30.2

