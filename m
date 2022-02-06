Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50214AB0A1
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 17:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244757AbiBFQSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 11:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244510AbiBFQSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 11:18:25 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C267DC043184
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 08:18:24 -0800 (PST)
Received: from ipservice-092-217-075-184.092.217.pools.vodafone-ip.de ([92.217.75.184] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nGkF3-0001bS-7i; Sun, 06 Feb 2022 17:18:21 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 05/14] staging: r8188eu: remove debug code to bypass IQ calibration
Date:   Sun,  6 Feb 2022 17:18:00 +0100
Message-Id: <20220206161809.423031-6-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220206161809.423031-1-martin@kaiser.cx>
References: <20220206161809.423031-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a check before the IQ calibration that is always false.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index 0c2dbef59197..8edae488d998 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -795,7 +795,6 @@ void PHY_IQCalibrate_8188E(struct adapter *adapt, bool recovery)
 	bool pathaok;
 	s32 RegE94, RegE9C, RegEA4, RegEB4, RegEBC;
 	bool is12simular, is13simular, is23simular;
-	bool singletone = false, carrier_sup = false;
 	u32 IQK_BB_REG_92C[IQK_BB_REG_NUM] = {
 		rOFDM0_XARxIQImbalance, rOFDM0_XBRxIQImbalance,
 		rOFDM0_ECCAThreshold, rOFDM0_AGCRSSITable,
@@ -803,10 +802,6 @@ void PHY_IQCalibrate_8188E(struct adapter *adapt, bool recovery)
 		rOFDM0_XCTxAFE, rOFDM0_XDTxAFE,
 		rOFDM0_RxIQExtAnta};
 
-	/*  20120213<Kordan> Turn on when continuous Tx to pass lab testing. (required by Edlu) */
-	if (singletone || carrier_sup)
-		return;
-
 	if (recovery) {
 		reload_adda_reg(adapt, IQK_BB_REG_92C, dm_odm->RFCalibrateInfo.IQK_BB_backup_recover, 9);
 		return;
-- 
2.30.2

