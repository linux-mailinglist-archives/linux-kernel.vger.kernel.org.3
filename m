Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012A9468BA7
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 16:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbhLEPQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 10:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbhLEPQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 10:16:46 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44001C061714
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 07:13:19 -0800 (PST)
Received: from dslb-188-097-212-203.188.097.pools.vodafone-ip.de ([188.97.212.203] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mttCV-0007gF-C0; Sun, 05 Dec 2021 16:13:15 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 10/10] staging: r8188eu: AntCombination is always 2
Date:   Sun,  5 Dec 2021 16:12:51 +0100
Message-Id: <20211205151251.6861-11-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211205151251.6861-1-martin@kaiser.cx>
References: <20211205151251.6861-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AntCombination is initialized with 2 and never changed. Remove
resulting dead code.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/odm_RTL8188E.c | 41 +++++-----------------
 1 file changed, 8 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_RTL8188E.c b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
index e7a765f375d6..837e5a850264 100644
--- a/drivers/staging/r8188eu/hal/odm_RTL8188E.c
+++ b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
@@ -58,7 +58,6 @@ static void odm_FastAntTrainingInit(struct odm_dm_struct *dm_odm)
 {
 	u32	value32, i;
 	struct fast_ant_train *dm_fat_tbl = &dm_odm->DM_FatTable;
-	u32	AntCombination = 2;
 
 	for (i = 0; i < 6; i++) {
 		dm_fat_tbl->Bssid[i] = 0;
@@ -85,36 +84,12 @@ static void odm_FastAntTrainingInit(struct odm_dm_struct *dm_odm)
 	ODM_SetBBReg(dm_odm, 0xb2c, BIT(31), 1);	/* Regb2c[31]=1'b1	output at CG only */
 	ODM_SetBBReg(dm_odm, 0xca4, bMaskDWord, 0x000000a0);
 
-	/* antenna mapping table */
-	if (AntCombination == 2) {
-		if (!dm_odm->bIsMPChip) { /* testchip */
-			ODM_SetBBReg(dm_odm, 0x858, BIT(10) | BIT(9) | BIT(8), 1);	/* Reg858[10:8]=3'b001 */
-			ODM_SetBBReg(dm_odm, 0x858, BIT(13) | BIT(12) | BIT(11), 2);	/* Reg858[13:11]=3'b010 */
-		} else { /* MPchip */
-			ODM_SetBBReg(dm_odm, 0x914, bMaskByte0, 1);
-			ODM_SetBBReg(dm_odm, 0x914, bMaskByte1, 2);
-		}
-	} else if (AntCombination == 7) {
-		if (!dm_odm->bIsMPChip) { /* testchip */
-			ODM_SetBBReg(dm_odm, 0x858, BIT(10) | BIT(9) | BIT(8), 0);	/* Reg858[10:8]=3'b000 */
-			ODM_SetBBReg(dm_odm, 0x858, BIT(13) | BIT(12) | BIT(11), 1);	/* Reg858[13:11]=3'b001 */
-			ODM_SetBBReg(dm_odm, 0x878, BIT(16), 0);
-			ODM_SetBBReg(dm_odm, 0x858, BIT(15) | BIT(14), 2);	/* Reg878[0],Reg858[14:15])=3'b010 */
-			ODM_SetBBReg(dm_odm, 0x878, BIT(19) | BIT(18) | BIT(17), 3);/* Reg878[3:1]=3b'011 */
-			ODM_SetBBReg(dm_odm, 0x878, BIT(22) | BIT(21) | BIT(20), 4);/* Reg878[6:4]=3b'100 */
-			ODM_SetBBReg(dm_odm, 0x878, BIT(25) | BIT(24) | BIT(23), 5);/* Reg878[9:7]=3b'101 */
-			ODM_SetBBReg(dm_odm, 0x878, BIT(28) | BIT(27) | BIT(26), 6);/* Reg878[12:10]=3b'110 */
-			ODM_SetBBReg(dm_odm, 0x878, BIT(31) | BIT(30) | BIT(29), 7);/* Reg878[15:13]=3b'111 */
-		} else { /* MPchip */
-			ODM_SetBBReg(dm_odm, 0x914, bMaskByte0, 0);
-			ODM_SetBBReg(dm_odm, 0x914, bMaskByte1, 1);
-			ODM_SetBBReg(dm_odm, 0x914, bMaskByte2, 2);
-			ODM_SetBBReg(dm_odm, 0x914, bMaskByte3, 3);
-			ODM_SetBBReg(dm_odm, 0x918, bMaskByte0, 4);
-			ODM_SetBBReg(dm_odm, 0x918, bMaskByte1, 5);
-			ODM_SetBBReg(dm_odm, 0x918, bMaskByte2, 6);
-			ODM_SetBBReg(dm_odm, 0x918, bMaskByte3, 7);
-		}
+	if (!dm_odm->bIsMPChip) { /* testchip */
+		ODM_SetBBReg(dm_odm, 0x858, BIT(10) | BIT(9) | BIT(8), 1);	/* Reg858[10:8]=3'b001 */
+		ODM_SetBBReg(dm_odm, 0x858, BIT(13) | BIT(12) | BIT(11), 2);	/* Reg858[13:11]=3'b010 */
+	} else { /* MPchip */
+		ODM_SetBBReg(dm_odm, 0x914, bMaskByte0, 1);
+		ODM_SetBBReg(dm_odm, 0x914, bMaskByte1, 2);
 	}
 
 	/* Default Ant Setting when no fast training */
@@ -122,8 +97,8 @@ static void odm_FastAntTrainingInit(struct odm_dm_struct *dm_odm)
 	ODM_SetBBReg(dm_odm, 0x864, BIT(5) | BIT(4) | BIT(3), 0);	/* Default RX */
 	ODM_SetBBReg(dm_odm, 0x864, BIT(8) | BIT(7) | BIT(6), 1);	/* Optional RX */
 
-	/* Enter Traing state */
-	ODM_SetBBReg(dm_odm, 0x864, BIT(2) | BIT(1) | BIT(0), (AntCombination - 1));	/* Reg864[2:0]=3'd6	ant combination=reg864[2:0]+1 */
+	/* Enter Training state */
+	ODM_SetBBReg(dm_odm, 0x864, BIT(2) | BIT(1) | BIT(0), 1);
 	ODM_SetBBReg(dm_odm, 0xc50, BIT(7), 1);	/* RegC50[7]=1'b1		enable HW AntDiv */
 }
 
-- 
2.20.1

