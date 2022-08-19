Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99AA59A576
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350639AbiHSSYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 14:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiHSSYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 14:24:14 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B28BD1FD
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 11:24:11 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id gk3so10279751ejb.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 11:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=ooRQXzLUe97i7byO6R46BlbFBy3Y8r9AZv+oUBRyyNk=;
        b=dC52cK47M+GcQ3HfB94JWV83L1H1/nK+0AbkeRCfkyYQSw3gNCJnPK0k2eZL2gbb2i
         TL3WtRZ7Q+j7IgkZhr6qEs46gKHzUN5d/c6y8iF2ydpvzLsTocAa2zs5f6HZFM2w38JI
         2uOWl/qcqTyLT68btQ4NE5Rfve9hnZnjChVgRYblXHqfTSeaSmLvWZILgkd3OSiO13Q9
         PGAu06+Tu8R0NrwVKl2ASyH8x6W2Teiq4GP6tpjer+oO/AeZFMJBkCAs5c4ObVK8k3DE
         DuT5bfdtdPnaIcayNi+xrk3HVRylqyHh72Snb/xpvILolYE+06LCX7vL38wN4xA/rfKj
         q3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=ooRQXzLUe97i7byO6R46BlbFBy3Y8r9AZv+oUBRyyNk=;
        b=7Nq+V6i+2ogcj/pVX9SI/QaRhGz6qHIXigfxB0sB/2KE/eOmnoSz3B2m+zR3DIql6g
         To3feC7wMSWs3RoAJjbjgWQ90z7MtiyFPxR+LzqCYW1wBbD4UVpMGi6uCbmZLbKUC1wm
         BCdTI6Tdfav9+l+G1R14whjyJEO1R0JyL3vS0IkOmzp66iutKR5xPQL3QWxD/xrb8bXP
         hMkMGanuN2zTOE5nDLaKfelnZh0B+QiB8IwoUN8+T4Pc5tAvcz6IfB0dP7XTgcXkh/Vq
         2chx+hxtAnTWxOCysgJa3zU2RyDZ6mY21o0RPngjlC7AVMArDgmb2ZnTU1nlYdFsnL0V
         cBww==
X-Gm-Message-State: ACgBeo2KgaTJdjrpMV3d/CeGLMq3bmcVKBXYAU0wHf47Tq+MK6wGDl97
        Yw4bUs5JvUYZ3Y+PgxpShL4lHY/W/C8=
X-Google-Smtp-Source: AA6agR6xQQLYgWhvB9yg+ScZlzpdyA/QuJ7PLcpSHm5sR9ANU3GSgcySus7auP2o6Qn+owfE8qiFTw==
X-Received: by 2002:a17:907:2cf3:b0:730:8b8c:6d55 with SMTP id hz19-20020a1709072cf300b007308b8c6d55mr5417331ejc.535.1660933450606;
        Fri, 19 Aug 2022 11:24:10 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb77.dynamic.kabel-deutschland.de. [95.90.187.119])
        by smtp.gmail.com with ESMTPSA id d2-20020a170906304200b0073c37199b86sm2159974ejd.159.2022.08.19.11.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 11:24:10 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: remove ODM_ConfigRFWithHeaderFile()
Date:   Fri, 19 Aug 2022 20:23:59 +0200
Message-Id: <20220819182359.24141-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function ODM_ConfigRFWithHeaderFile() is just a wrapper around
ODM_ReadAndConfig_RadioA_1T_8188E(). Remove the wrapper and call
ODM_ReadAndConfig_RadioA_1T_8188E() directly.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm_HWConfig.c     | 5 -----
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c  | 2 +-
 drivers/staging/r8188eu/include/odm_HWConfig.h | 1 -
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_HWConfig.c b/drivers/staging/r8188eu/hal/odm_HWConfig.c
index 54cc3d7789cd..035d94b3458e 100644
--- a/drivers/staging/r8188eu/hal/odm_HWConfig.c
+++ b/drivers/staging/r8188eu/hal/odm_HWConfig.c
@@ -347,8 +347,3 @@ void ODM_PhyStatusQuery(struct odm_dm_struct *dm_odm,
 	odm_RxPhyStatus92CSeries_Parsing(dm_odm, pPhyInfo, pPhyStatus, pPktinfo, adapt);
 	odm_Process_RSSIForDM(dm_odm, pPhyInfo, pPktinfo);
 }
-
-enum HAL_STATUS ODM_ConfigRFWithHeaderFile(struct odm_dm_struct *dm_odm)
-{
-	return ODM_ReadAndConfig_RadioA_1T_8188E(dm_odm);
-}
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
index d043b7bc4142..237232432f37 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
@@ -396,7 +396,7 @@ static int phy_RF6052_Config_ParaFile(struct adapter *Adapter)
 	udelay(1);/* PlatformStallExecution(1); */
 
 	/*----Initialize RF fom connfiguration file----*/
-	if (HAL_STATUS_FAILURE == ODM_ConfigRFWithHeaderFile(&pHalData->odmpriv))
+	if (ODM_ReadAndConfig_RadioA_1T_8188E(&pHalData->odmpriv) == HAL_STATUS_FAILURE)
 		rtStatus = _FAIL;
 
 	/*----Restore RFENV control type----*/;
diff --git a/drivers/staging/r8188eu/include/odm_HWConfig.h b/drivers/staging/r8188eu/include/odm_HWConfig.h
index b37962edb2ed..3f7185780e87 100644
--- a/drivers/staging/r8188eu/include/odm_HWConfig.h
+++ b/drivers/staging/r8188eu/include/odm_HWConfig.h
@@ -66,5 +66,4 @@ void ODM_PhyStatusQuery(struct odm_dm_struct *pDM_Odm,
 			struct odm_per_pkt_info *pPktinfo,
 			struct adapter *adapt);
 
-enum HAL_STATUS ODM_ConfigRFWithHeaderFile(struct odm_dm_struct *pDM_Odm);
 #endif
-- 
2.37.2

