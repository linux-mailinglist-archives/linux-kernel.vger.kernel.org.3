Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D664816C4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 21:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbhL2Uvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 15:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbhL2Uve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 15:51:34 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE58C061746
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:33 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id s1so46669289wrg.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Voegb2xpegnCxWOKPmYjaZUmHs/ExPIFWc9KSTvPpck=;
        b=KzcT6yyV4jXNFhhAJaAN+O7HyYxCU/Ioj/htGZM6qeHTO/jSIfavJdFXdaXTBNrB3f
         xvFU9qURmxeK2NuwV3IiOeNdcnxyKXU6Q2Gaw0mtcaioffgIm0WeQOcukzTRS+6zXBt8
         XoR8etRI7cL5v1OCBsSpvko5XQMpbHcBsXS6QlcgUKymHTELxoGN4EXsm54qcL52tePe
         iSSMPaLXQft33OqxEUTkRR/7FF7VmzdgJhrsi7JnLnCTyvvUIDqhSRAbmUpLrQzyncP8
         uNyxXJWGKapSBvkDYwxWFxQ0a20MvvpwW/Rb46ADn9MPm//IP+fA1dCd4EF2iO7KAmlM
         PiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Voegb2xpegnCxWOKPmYjaZUmHs/ExPIFWc9KSTvPpck=;
        b=1QNNKWjPUKQTqoAvWwHuhaM1TWEDeBnqiGnNeaZF9vJFnd2w4pj6tu3HKa+JEU/bu+
         7dER2rZKWHwRyzmHguiY87YmYBMUTnZhFtXrk/UsDaT3eFe+h6YgrJ0dYf3YLHB63UNt
         Hf+lbOl+NXbRKA31f5VvJX5OnYxbw0IlClgU32fz0qcxDLLGMjmoSpCQdotl7D/HxM3q
         4LAkZ0eSh2M6qM0ZeDqPdnBwxQ4LQBxBv2Qze2bpD+zskLIri3jW0fCoGJWDhatSS0xP
         hoMxqRf41ias7dJ2fHYZOXFRVu98oqACy1tDkvwWtrIirnf2QTtkzlLMmODg0XGGhyVr
         J+ng==
X-Gm-Message-State: AOAM532riEePo7JiWY6Kf5nmTY0SadEW3lpQFRYKhuOjjv/pC1qCaTTN
        W0N317oo1min2HhEmiPx1gw=
X-Google-Smtp-Source: ABdhPJwnFY2g2qx9RjegpZzQiFoIqPTG1gh39+o6f2i5XjCvT5cIm/4Q3RCjZOdd1Jhg/YaHCjYBDQ==
X-Received: by 2002:a5d:47c6:: with SMTP id o6mr22939682wrc.326.1640811092221;
        Wed, 29 Dec 2021 12:51:32 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id l12sm27421989wmq.2.2021.12.29.12.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 12:51:31 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 08/32] staging: r8188eu: remove ODM_sleep_ms()
Date:   Wed, 29 Dec 2021 21:50:44 +0100
Message-Id: <20211229205108.26373-9-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229205108.26373-1-straube.linux@gmail.com>
References: <20211229205108.26373-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ODM_sleep_ms() is just a wrapper around msleep().
Remove ODM_sleep_ms() and call msleep() directly.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c     | 2 +-
 drivers/staging/r8188eu/hal/odm_RegConfig8188E.c | 6 +++---
 drivers/staging/r8188eu/hal/odm_interface.c      | 5 -----
 drivers/staging/r8188eu/include/odm_interface.h  | 2 --
 4 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index 24e653eb5321..35e1c81bf9a7 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -858,7 +858,7 @@ static void phy_LCCalibrate_8188E(struct adapter *adapt, bool is2t)
 	/* 4. Set LC calibration begin	bit15 */
 	rtl8188e_PHY_SetRFReg(adapt, RF_PATH_A, RF_CHNLBW, bMask12Bits, LC_Cal | 0x08000);
 
-	ODM_sleep_ms(100);
+	msleep(100);
 
 	/* Restore original situation */
 	if ((tmpreg & 0x70) != 0) {
diff --git a/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c b/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
index 3c591bf9459c..8a829190b752 100644
--- a/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
+++ b/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
@@ -8,7 +8,7 @@ void odm_ConfigRFReg_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr,
 			   u32 RegAddr)
 {
 	if (Addr == 0xffe) {
-		ODM_sleep_ms(50);
+		msleep(50);
 	} else if (Addr == 0xfd) {
 		ODM_delay_ms(5);
 	} else if (Addr == 0xfc) {
@@ -50,7 +50,7 @@ void odm_ConfigBB_PHY_REG_PG_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr,
 				   u32 Bitmask, u32 Data)
 {
 	if (Addr == 0xfe)
-		ODM_sleep_ms(50);
+		msleep(50);
 	else if (Addr == 0xfd)
 		ODM_delay_ms(5);
 	else if (Addr == 0xfc)
@@ -68,7 +68,7 @@ void odm_ConfigBB_PHY_REG_PG_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr,
 void odm_ConfigBB_PHY_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u32 Bitmask, u32 Data)
 {
 	if (Addr == 0xfe) {
-		ODM_sleep_ms(50);
+		msleep(50);
 	} else if (Addr == 0xfd) {
 		ODM_delay_ms(5);
 	} else if (Addr == 0xfc) {
diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
index f701d8520019..249577a9f867 100644
--- a/drivers/staging/r8188eu/hal/odm_interface.c
+++ b/drivers/staging/r8188eu/hal/odm_interface.c
@@ -20,8 +20,3 @@ void ODM_delay_us(u32 us)
 {
 	udelay(us);
 }
-
-void ODM_sleep_ms(u32 ms)
-{
-	msleep(ms);
-}
diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
index fa5b8220a8f3..183899e782b1 100644
--- a/drivers/staging/r8188eu/include/odm_interface.h
+++ b/drivers/staging/r8188eu/include/odm_interface.h
@@ -21,6 +21,4 @@ void ODM_delay_ms(u32 ms);
 
 void ODM_delay_us(u32 us);
 
-void ODM_sleep_ms(u32 ms);
-
 #endif	/*  __ODM_INTERFACE_H__ */
-- 
2.34.1

