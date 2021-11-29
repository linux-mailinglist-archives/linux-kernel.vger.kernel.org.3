Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6624A462590
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbhK2WlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234031AbhK2Wjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:39:53 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4DDC04CBDA
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 14:14:49 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id gt5so13788772pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 14:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h0rKDnr3HA7cDoLv06yMW4nxDm9zJoG/YcBzOXbNpVs=;
        b=LCke5qOcLhSuGGEWgEBFvEbBsjbSIJnOWICVxR6DxvkbQUGbpt75LdCWutQ1uGOs0v
         HRXHdX1OQLypVQHCP8F9ulUSukjD+kI4rH4Y4zjflmZLLwf3DXOQHWZf/hA+h3p0+8ZH
         DqcslgLvsQNyn3OWVz6lTp5hziJoVxJI4Nepcw+YatmwtqsFvFT2SZi1pEaP/Os+3svU
         9aKUqiiriMpANHRx0PmswS43t281PKUVV6jIfmpJ4VpaJll50oJFb/x+QqXbHI8Sw5FN
         sQiTEtRAdyhMuicl/ElZ1m+8u0egNe/kHS68iT9rKLNDhVJaPzBnuzgdfAVk3wfRcuHv
         K7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h0rKDnr3HA7cDoLv06yMW4nxDm9zJoG/YcBzOXbNpVs=;
        b=SVqZK/ySMDlbKojPKqY0RCwsOtOGhJUJhHim8F7vIQqOrbkKSh/nL6WhPAxyR66z06
         lyqXrlSF+H838L4gZMg36xZqiUrelWVmRslLud5fue4G+wZUzr5GArqKxeof+2+ALsla
         0GFvS3mozrRPNhatGyXV1reRFWGMcPy0b0kCQLp5asP6sGpyFOZxsINgfN4AqaV+3KA2
         YC9E+KISmAMPrVEWy1xE+/NNY7Kig3+Zloy+BMgDN7Wy5gepCBN5M6KZyRr4t9OFdBoA
         x5tgZwky1iGPfPmAGfug9XY3Cn30Sso0rATJ4jSJxxmEUhLJ7RSQxVLI5n5HiRBZUx1t
         RP/Q==
X-Gm-Message-State: AOAM53242Hwa0Ox6WxPHWG7/qe4AGbKPSpe8IcDe4hP45pbjlM+5q/Ms
        j89sQ6bC5xuoRnLRX5IMFyA=
X-Google-Smtp-Source: ABdhPJxOF5Gb96QP7i2fxwNIGOtjrUWeRJ6/yn5SWWJtR/GegW+1J1oXqucKpPoOupGm3FQURJAVqg==
X-Received: by 2002:a17:902:e2c3:b0:143:9b60:d16d with SMTP id l3-20020a170902e2c300b001439b60d16dmr62355324plc.42.1638224088687;
        Mon, 29 Nov 2021 14:14:48 -0800 (PST)
Received: from makvihas.makvihas.com ([103.161.98.32])
        by smtp.gmail.com with ESMTPSA id hg4sm308347pjb.1.2021.11.29.14.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 14:14:48 -0800 (PST)
From:   Vihas Mak <makvihas@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk
Cc:     gregkh@linuxfoundation.org, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vihas Mak <makvihas@gmail.com>
Subject: [PATCH] staging: r8188eu: use ARRAY_SIZE() macro and fix camelcase issues
Date:   Tue, 30 Nov 2021 03:43:47 +0530
Message-Id: <20211129221346.365883-1-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix camelcase warnings from checkpatch.pl and use ARRAY_SIZE()
to make the code cleaner and avoid following cocci warnings:

	drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c:142:51-52: WARNING: Use ARRAY_SIZE
	drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c:174:52-53: WARNING: Use ARRAY_SIZE
	drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c:450:52-53: WARNING: Use ARRAY_SIZE
	drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c:655:49-50: WARNING: Use ARRAY_SIZE
	drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c:136:50-51: WARNING: Use ARRAY_SIZE

Signed-off-by: Vihas Mak <makvihas@gmail.com>
---
 .../staging/r8188eu/hal/HalHWImg8188E_BB.c    |  6 ++---
 .../staging/r8188eu/hal/HalHWImg8188E_MAC.c   |  2 +-
 .../staging/r8188eu/hal/HalHWImg8188E_RF.c    | 24 +++++++++----------
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
index f6e4243e0..ce46b3651 100644
--- a/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
@@ -171,7 +171,7 @@ enum HAL_STATUS ODM_ReadAndConfig_AGC_TAB_1T_8188E(struct odm_dm_struct *dm_odm)
 {
 	u32     hex         = 0;
 	u32     i           = 0;
-	u32     arraylen    = sizeof(array_agc_tab_1t_8188e) / sizeof(u32);
+	u32     arraylen    = ARRAY_SIZE(array_agc_tab_1t_8188e);
 	u32    *array       = array_agc_tab_1t_8188e;
 	bool		biol = false;
 	struct adapter *adapter =  dm_odm->Adapter;
@@ -447,7 +447,7 @@ enum HAL_STATUS ODM_ReadAndConfig_PHY_REG_1T_8188E(struct odm_dm_struct *dm_odm)
 {
 	u32     hex         = 0;
 	u32     i           = 0;
-	u32     arraylen    = sizeof(array_phy_reg_1t_8188e) / sizeof(u32);
+	u32     arraylen    = ARRAY_SIZE(array_phy_reg_1t_8188e);
 	u32    *array       = array_phy_reg_1t_8188e;
 	bool	biol = false;
 	struct adapter *adapter =  dm_odm->Adapter;
@@ -652,7 +652,7 @@ void ODM_ReadAndConfig_PHY_REG_PG_8188E(struct odm_dm_struct *dm_odm)
 {
 	u32  hex;
 	u32  i           = 0;
-	u32  arraylen    = sizeof(array_phy_reg_pg_8188e) / sizeof(u32);
+	u32  arraylen    = ARRAY_SIZE(array_phy_reg_pg_8188e);
 	u32 *array       = array_phy_reg_pg_8188e;
 
 	hex = ODM_ITRF_USB << 8;
diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
index b4c55863d..89061e1a3 100644
--- a/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
@@ -133,7 +133,7 @@ enum HAL_STATUS ODM_ReadAndConfig_MAC_REG_8188E(struct odm_dm_struct *dm_odm)
 
 	u32     hex         = 0;
 	u32     i;
-	u32     array_len    = sizeof(array_MAC_REG_8188E) / sizeof(u32);
+	u32     array_len    = ARRAY_SIZE(array_MAC_REG_8188E);
 	u32    *array       = array_MAC_REG_8188E;
 	bool	biol = false;
 
diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
index 5e0a96200..f708d9d90 100644
--- a/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
@@ -29,7 +29,7 @@ static bool CheckCondition(const u32  Condition, const u32  Hex)
 *                           RadioA_1T.TXT
 ******************************************************************************/
 
-static u32 Array_RadioA_1T_8188E[] = {
+static u32 array_RadioA_1T_8188E[] = {
 		0x000, 0x00030000,
 		0x008, 0x00084000,
 		0x018, 0x00000407,
@@ -134,13 +134,13 @@ static u32 Array_RadioA_1T_8188E[] = {
 enum HAL_STATUS ODM_ReadAndConfig_RadioA_1T_8188E(struct odm_dm_struct *pDM_Odm)
 {
 	#define READ_NEXT_PAIR(v1, v2, i) do	\
-		 { i += 2; v1 = Array[i];	\
-		 v2 = Array[i + 1]; } while (0)
+		 { i += 2; v1 = array[i];	\
+		 v2 = array[i + 1]; } while (0)
 
 	u32     hex         = 0;
 	u32     i           = 0;
-	u32     ArrayLen    = sizeof(Array_RadioA_1T_8188E) / sizeof(u32);
-	u32    *Array       = Array_RadioA_1T_8188E;
+	u32     array_len    = ARRAY_SIZE(array_RadioA_1T_8188E);
+	u32    *array       = array_RadioA_1T_8188E;
 	bool		biol = false;
 	struct adapter *Adapter =  pDM_Odm->Adapter;
 	struct xmit_frame *pxmit_frame = NULL;
@@ -160,9 +160,9 @@ enum HAL_STATUS ODM_ReadAndConfig_RadioA_1T_8188E(struct odm_dm_struct *pDM_Odm)
 		}
 	}
 
-	for (i = 0; i < ArrayLen; i += 2) {
-		u32 v1 = Array[i];
-		u32 v2 = Array[i + 1];
+	for (i = 0; i < array_len; i += 2) {
+		u32 v1 = array[i];
+		u32 v2 = array[i + 1];
 
 		/*  This (offset, data) pair meets the condition. */
 		if (v1 < 0xCDCDCDCD) {
@@ -189,19 +189,19 @@ enum HAL_STATUS ODM_ReadAndConfig_RadioA_1T_8188E(struct odm_dm_struct *pDM_Odm)
 			}
 			continue;
 		} else { /*  This line is the start line of branch. */
-			if (!CheckCondition(Array[i], hex)) {
+			if (!CheckCondition(array[i], hex)) {
 				/*  Discard the following (offset, data) pairs. */
 				READ_NEXT_PAIR(v1, v2, i);
 				while (v2 != 0xDEAD &&
 				       v2 != 0xCDEF &&
-				       v2 != 0xCDCD && i < ArrayLen - 2)
+				       v2 != 0xCDCD && i < array_len - 2)
 					READ_NEXT_PAIR(v1, v2, i);
 				i -= 2; /*  prevent from for-loop += 2 */
 			} else { /*  Configure matched pairs and skip to end of if-else. */
 			READ_NEXT_PAIR(v1, v2, i);
 				while (v2 != 0xDEAD &&
 				       v2 != 0xCDEF &&
-				       v2 != 0xCDCD && i < ArrayLen - 2) {
+				       v2 != 0xCDCD && i < array_len - 2) {
 					if (biol) {
 						if (rtw_IOL_cmd_boundary_handle(pxmit_frame))
 							bndy_cnt++;
@@ -226,7 +226,7 @@ enum HAL_STATUS ODM_ReadAndConfig_RadioA_1T_8188E(struct odm_dm_struct *pDM_Odm)
 					READ_NEXT_PAIR(v1, v2, i);
 				}
 
-				while (v2 != 0xDEAD && i < ArrayLen - 2)
+				while (v2 != 0xDEAD && i < array_len - 2)
 					READ_NEXT_PAIR(v1, v2, i);
 			}
 		}
-- 
2.30.2

