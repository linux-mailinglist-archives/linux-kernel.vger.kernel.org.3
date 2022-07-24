Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C6257F65D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 20:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbiGXSZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 14:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiGXSZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 14:25:45 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF6F10557
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 11:25:44 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id sz17so16820536ejc.9
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 11:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mc8TRcMxDtFgQPktrRYxaiC84c9xSC4w48WZBhDyELI=;
        b=oCa1EnIGhj2fSSmj29Q1sdTyfzuWOOqeNHEPnZvDIZLbdBnKn7tqWEj5H02S5YN8Hj
         8PEtlPX+XhzBIoYeVq2KG0Vu4PSu/jCQCTfWNuy965gZ/DPDpGg2kvhmj7Id7XwHAPA8
         1Lr7nRIj0VhGvFM956rn7q6KF7RhywN7DhFakrtwPP0nOuQBRH0oI+ah6ETcCABh2Dgm
         aNBZosGaGOkhp3zkYkcldZ4nf++YMymGLbv3vd4q4xnqw6Ds+bLhv9Pyc2qSiZYgNdDK
         TGBpXQzVoboNfn8xkMUWZnUFUcEQqXLq15G+7zqz7vLbLoTxYnpb5zzF3fulBXm85SN+
         clHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mc8TRcMxDtFgQPktrRYxaiC84c9xSC4w48WZBhDyELI=;
        b=THDJDTPARGuR7EhXaNaHD4n8ovv0kOYt8DG+BaPvhYwrul0cQR3QKGSr9N9RpA8Ftp
         aAcpmHxnF1yPUCiBxDicuIloLWe8PWM3tcw0CDReKp/REX0L28Rvb6gHqYKd0Yf/mdnK
         nShM7L9KKoIaWkX/9hjW05jBh3b/FfE0J93j/n5TSMtkgTYLIvWTDls0AHAyWEsQmbT7
         WH6BTUv8Jt0WyZq+NCvsjVMu7kt0/dqh1sfi0Dng51dZItHRhYspTQtClK9pUL1wYZzU
         AXWWEcytiWnWsuJ2xCM10gjoknNnUNuAUyHanwPGzvLIo/R3iz6RabsSf3wGr9rmXVVh
         hwYw==
X-Gm-Message-State: AJIora9trKVLpLUM2r2XaQpegEWYJBKcqaDE+zet86BPIftAPTyT1fW8
        RNksQyA79MjmRQIxTOMzCOI=
X-Google-Smtp-Source: AGRyM1tnh2sZ3SyAw6PmlacimcW8Fpy9h94p1H4tYt/5uTnGQM/5ePImjhHqdDkrb63u+aY7/FyInw==
X-Received: by 2002:a17:907:87b0:b0:72f:8d3d:2010 with SMTP id qv48-20020a17090787b000b0072f8d3d2010mr7355936ejc.743.1658687142570;
        Sun, 24 Jul 2022 11:25:42 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb56.dynamic.kabel-deutschland.de. [95.90.187.86])
        by smtp.gmail.com with ESMTPSA id cb8-20020a0564020b6800b0043bb7c11a59sm5943505edb.93.2022.07.24.11.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 11:25:41 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: make dump_chip_info() static
Date:   Sun, 24 Jul 2022 20:25:20 +0200
Message-Id: <20220724182520.7794-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function dump_chip_info() is only used in rtl8188e_hal_init.c.
Make it static to reduce the driver object file size by 281 bytes.

before:
  text    data     bss     dec     hex filename
530606   43897    7072  581575   8dfc7 drivers/staging/r8188eu/r8188eu.o

after:
  text    data     bss     dec     hex filename
530405   43817    7072  581294   8deae drivers/staging/r8188eu/r8188eu.o

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/hal_com.c         | 39 -------------------
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 39 +++++++++++++++++++
 drivers/staging/r8188eu/include/hal_com.h     |  3 --
 3 files changed, 39 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/hal_com.c b/drivers/staging/r8188eu/hal/hal_com.c
index e9a32dd84a8e..6a1cdc67335b 100644
--- a/drivers/staging/r8188eu/hal/hal_com.c
+++ b/drivers/staging/r8188eu/hal/hal_com.c
@@ -10,45 +10,6 @@
 
 #define _HAL_INIT_C_
 
-void dump_chip_info(struct HAL_VERSION	chip_vers)
-{
-	uint cnt = 0;
-	char buf[128];
-
-	cnt += sprintf((buf + cnt), "Chip Version Info: CHIP_8188E_");
-	cnt += sprintf((buf + cnt), "%s_", IS_NORMAL_CHIP(chip_vers) ?
-		       "Normal_Chip" : "Test_Chip");
-	cnt += sprintf((buf + cnt), "%s_", IS_CHIP_VENDOR_TSMC(chip_vers) ?
-		       "TSMC" : "UMC");
-
-	switch (chip_vers.CUTVersion) {
-	case A_CUT_VERSION:
-		cnt += sprintf((buf + cnt), "A_CUT_");
-		break;
-	case B_CUT_VERSION:
-		cnt += sprintf((buf + cnt), "B_CUT_");
-		break;
-	case C_CUT_VERSION:
-		cnt += sprintf((buf + cnt), "C_CUT_");
-		break;
-	case D_CUT_VERSION:
-		cnt += sprintf((buf + cnt), "D_CUT_");
-		break;
-	case E_CUT_VERSION:
-		cnt += sprintf((buf + cnt), "E_CUT_");
-		break;
-	default:
-		cnt += sprintf((buf + cnt), "UNKNOWN_CUT(%d)_", chip_vers.CUTVersion);
-		break;
-	}
-
-	cnt += sprintf((buf + cnt), "1T1R_");
-
-	cnt += sprintf((buf + cnt), "RomVer(%d)\n", 0);
-
-	pr_info("%s", buf);
-}
-
 #define	CHAN_PLAN_HW	0x80
 
 u8 /* return the final channel plan decision */
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index fe477438899e..5b8f1a912bbb 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -526,6 +526,45 @@ void rtl8188e_ReadEFuse(struct adapter *Adapter, u16 _size_byte, u8 *pbuf)
 	Hal_EfuseReadEFuse88E(Adapter, 0, _size_byte, pbuf);
 }
 
+static void dump_chip_info(struct HAL_VERSION chip_vers)
+{
+	uint cnt = 0;
+	char buf[128];
+
+	cnt += sprintf((buf + cnt), "Chip Version Info: CHIP_8188E_");
+	cnt += sprintf((buf + cnt), "%s_", IS_NORMAL_CHIP(chip_vers) ?
+		       "Normal_Chip" : "Test_Chip");
+	cnt += sprintf((buf + cnt), "%s_", IS_CHIP_VENDOR_TSMC(chip_vers) ?
+		       "TSMC" : "UMC");
+
+	switch (chip_vers.CUTVersion) {
+	case A_CUT_VERSION:
+		cnt += sprintf((buf + cnt), "A_CUT_");
+		break;
+	case B_CUT_VERSION:
+		cnt += sprintf((buf + cnt), "B_CUT_");
+		break;
+	case C_CUT_VERSION:
+		cnt += sprintf((buf + cnt), "C_CUT_");
+		break;
+	case D_CUT_VERSION:
+		cnt += sprintf((buf + cnt), "D_CUT_");
+		break;
+	case E_CUT_VERSION:
+		cnt += sprintf((buf + cnt), "E_CUT_");
+		break;
+	default:
+		cnt += sprintf((buf + cnt), "UNKNOWN_CUT(%d)_", chip_vers.CUTVersion);
+		break;
+	}
+
+	cnt += sprintf((buf + cnt), "1T1R_");
+
+	cnt += sprintf((buf + cnt), "RomVer(%d)\n", 0);
+
+	pr_info("%s", buf);
+}
+
 void rtl8188e_read_chip_version(struct adapter *padapter)
 {
 	u32				value32;
diff --git a/drivers/staging/r8188eu/include/hal_com.h b/drivers/staging/r8188eu/include/hal_com.h
index 56ba356b5371..d7e333f6ce39 100644
--- a/drivers/staging/r8188eu/include/hal_com.h
+++ b/drivers/staging/r8188eu/include/hal_com.h
@@ -131,9 +131,6 @@
 #define REG_NOA_DESC_START			0x05E8
 #define REG_NOA_DESC_COUNT			0x05EC
 
-#include "HalVerDef.h"
-void dump_chip_info(struct HAL_VERSION	ChipVersion);
-
 /* return the final channel plan decision */
 u8 hal_com_get_channel_plan(struct adapter *padapter,
 			    u8 hw_channel_plan,
-- 
2.37.1

