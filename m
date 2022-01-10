Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374B64898D0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 13:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245649AbiAJMqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 07:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbiAJMqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 07:46:51 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDA8C061748
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 04:46:51 -0800 (PST)
Received: from pd956d63d.dip0.t-ipconnect.de ([217.86.214.61] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n6u4V-0007Td-Ai; Mon, 10 Jan 2022 13:46:47 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/9] staging: r8188eu: fix phy_RF6052_Config_ParaFile error handling
Date:   Mon, 10 Jan 2022 13:46:30 +0100
Message-Id: <20220110124638.6909-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220110124638.6909-1-martin@kaiser.cx>
References: <20220110124638.6909-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the error handling in phy_RF6052_Config_ParaFile.
We can simply return rtStatus.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
index 6e0231099986..7e4744989a66 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
@@ -406,12 +406,6 @@ static int phy_RF6052_Config_ParaFile(struct adapter *Adapter)
 	/*----Restore RFENV control type----*/;
 	rtl8188e_PHY_SetBBReg(Adapter, pPhyReg->rfintfs, bRFSI_RFENV, u4RegValue);
 
-	if (rtStatus != _SUCCESS)
-		goto phy_RF6052_Config_ParaFile_Fail;
-
-	return rtStatus;
-
-phy_RF6052_Config_ParaFile_Fail:
 	return rtStatus;
 }
 
-- 
2.30.2

