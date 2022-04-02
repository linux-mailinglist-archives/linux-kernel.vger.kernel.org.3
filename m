Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376904F04F2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 18:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358205AbiDBQgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 12:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358194AbiDBQgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 12:36:38 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D7A5E764
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 09:34:45 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id r13so11790847ejd.5
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 09:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/FUIvc/vDnMsC8g3By0xz2o93YIAaNo0DmbUPR75Tlc=;
        b=Ioi61ehSCrXnxLXiUDHyumdLEB4WVYi0QVlxNUL2ed3iV843fKZaDve+2MpfC/8G5J
         x4KZDzHzRvf5A9KYLawd2xkLz3U3C2lc/ofNKczlkanAj5jwaZVkKKkrmeaKbbiaLeof
         oi8LgC+BF5j3duxC/OEIitiA/o+xBkNhgB09T3wwbJ40k1yBS2K+6FatLnxPu0GHZUrs
         KmuipXAqwxdBUFU+O19jfc2TBpM2iLafe8ARV9lZaphs7EYb+0iDUvB1wKN/rS0Qt4+s
         bkHGMxghC9ZADEqlsTctvDu7TyNIYX17XomcLzYbJ5dMwVBxVI7/VkFC/caEdkepdKuL
         i9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/FUIvc/vDnMsC8g3By0xz2o93YIAaNo0DmbUPR75Tlc=;
        b=zNVQWwAgQswbDHBVQ9X5dxeKe4/APca9+kUuP3tQAcGp1WtQ4MVsmp+SO/ZR/qyptO
         CPm/5Y2ExG0ZxxlUVn3v3kV2fE0n691EA2Q5oh0x/SxTh+Y8iaQsHhKjQLiZ/WafS+iR
         flCgPwMXfdH1jpI6JKh8NhWwtk7xzfk8rfqMBmKAjAQ7NwsXtOKNJ0vqY5O89Oc4SYZG
         14QOD+/xVgEXiwKqlkl+JG6tGaplxUActlbB4/ZFrH1YS+46dUvbGqo3LEp3UUv01e+D
         GYdMlyZhGIZropUsvAkVL5mHFivLsVAExnkj0K908S9/9MTbYAHj3Fzfm4GoCtIGmkj8
         5OqQ==
X-Gm-Message-State: AOAM530YJUBwSD6DNJwKR1EdrHYDGi2fSqHGemBBSV/pe/yyLKNa57Vx
        isxA6ufVAuTkYzxf/hiSeEw=
X-Google-Smtp-Source: ABdhPJy2M5JbKf2OjnCPA6qJuPiQbgigSFQO/VYzmNX4uOlglDcSFd71pcHoDc/5PYlOC4uf4RS7eg==
X-Received: by 2002:a17:906:b107:b0:6e0:a25a:af6e with SMTP id u7-20020a170906b10700b006e0a25aaf6emr4308839ejy.359.1648917284171;
        Sat, 02 Apr 2022 09:34:44 -0700 (PDT)
Received: from localhost.localdomain (host-95-249-145-232.retail.telecomitalia.it. [95.249.145.232])
        by smtp.gmail.com with ESMTPSA id ka22-20020a170907921600b006e4c1ab0bbdsm2191216ejb.207.2022.04.02.09.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 09:34:42 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] staging: r8188eu: Use the ARRAY_SIZE() macro
Date:   Sat,  2 Apr 2022 18:34:39 +0200
Message-Id: <20220402163439.20457-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Use the ARRAY_SIZE() macro in places where there are open coded
calculations of the size of arrays.

ARRAY_SIZE(arr) makes sure that "arr" is an array, it's safer than
sizeof(arr) / sizeof(arr[0]), and improves readibility.

Detected with the help of Coccinelle.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c     | 2 +-
 drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c  | 6 +++---
 drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c | 2 +-
 drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c  | 2 +-
 drivers/staging/r8188eu/os_dep/ioctl_linux.c    | 6 +++---
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 10d5f1222936..2ce130165b39 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -3985,7 +3985,7 @@ unsigned int OnAction(struct adapter *padapter, struct recv_frame *precv_frame)
 
 	category = frame_body[0];
 
-	for (i = 0; i < sizeof(OnAction_tbl) / sizeof(struct action_handler); i++) {
+	for (i = 0; i < ARRAY_SIZE(OnAction_tbl); i++) {
 		ptable = &OnAction_tbl[i];
 		if (category == ptable->num)
 			ptable->func(padapter, precv_frame);
diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
index e7f834b02567..7901d0afa2e7 100644
--- a/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
@@ -170,7 +170,7 @@ enum HAL_STATUS ODM_ReadAndConfig_AGC_TAB_1T_8188E(struct odm_dm_struct *dm_odm)
 {
 	u32     hex         = 0;
 	u32     i           = 0;
-	u32     arraylen    = sizeof(array_agc_tab_1t_8188e) / sizeof(u32);
+	u32     arraylen    = ARRAY_SIZE(array_agc_tab_1t_8188e);
 	u32    *array       = array_agc_tab_1t_8188e;
 	bool		biol = false;
 	struct adapter *adapter =  dm_odm->Adapter;
@@ -446,7 +446,7 @@ enum HAL_STATUS ODM_ReadAndConfig_PHY_REG_1T_8188E(struct odm_dm_struct *dm_odm)
 {
 	u32     hex         = 0;
 	u32     i           = 0;
-	u32     arraylen    = sizeof(array_phy_reg_1t_8188e) / sizeof(u32);
+	u32     arraylen    = ARRAY_SIZE(array_phy_reg_1t_8188e);
 	u32    *array       = array_phy_reg_1t_8188e;
 	bool	biol = false;
 	struct adapter *adapter =  dm_odm->Adapter;
@@ -651,7 +651,7 @@ void ODM_ReadAndConfig_PHY_REG_PG_8188E(struct odm_dm_struct *dm_odm)
 {
 	u32  hex;
 	u32  i           = 0;
-	u32  arraylen    = sizeof(array_phy_reg_pg_8188e) / sizeof(u32);
+	u32  arraylen    = ARRAY_SIZE(array_phy_reg_pg_8188e);
 	u32 *array       = array_phy_reg_pg_8188e;
 
 	hex = ODM_ITRF_USB << 8;
diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
index 20ce1571fc26..77b25885c63b 100644
--- a/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
@@ -132,7 +132,7 @@ enum HAL_STATUS ODM_ReadAndConfig_MAC_REG_8188E(struct odm_dm_struct *dm_odm)
 
 	u32     hex         = 0;
 	u32     i;
-	u32     array_len    = sizeof(array_MAC_REG_8188E) / sizeof(u32);
+	u32     array_len    = ARRAY_SIZE(array_MAC_REG_8188E);
 	u32    *array       = array_MAC_REG_8188E;
 	bool	biol = false;
 
diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
index 9dc888a66d09..08cbfce3808d 100644
--- a/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
@@ -138,7 +138,7 @@ enum HAL_STATUS ODM_ReadAndConfig_RadioA_1T_8188E(struct odm_dm_struct *pDM_Odm)
 
 	u32     hex         = 0;
 	u32     i           = 0;
-	u32     ArrayLen    = sizeof(Array_RadioA_1T_8188E) / sizeof(u32);
+	u32     ArrayLen    = ARRAY_SIZE(Array_RadioA_1T_8188E);
 	u32    *Array       = Array_RadioA_1T_8188E;
 	bool		biol = false;
 	struct adapter *Adapter =  pDM_Odm->Adapter;
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index eb9375b0c660..dd2f9ae59c3f 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -3958,10 +3958,10 @@ static struct iw_statistics *rtw_get_wireless_stats(struct net_device *dev)
 
 struct iw_handler_def rtw_handlers_def = {
 	.standard = rtw_handlers,
-	.num_standard = sizeof(rtw_handlers) / sizeof(iw_handler),
+	.num_standard = ARRAY_SIZE(rtw_handlers),
 	.private = rtw_private_handler,
 	.private_args = (struct iw_priv_args *)rtw_private_args,
-	.num_private = sizeof(rtw_private_handler) / sizeof(iw_handler),
-	.num_private_args = sizeof(rtw_private_args) / sizeof(struct iw_priv_args),
+	.num_private = ARRAY_SIZE(rtw_private_handler),
+	.num_private_args = ARRAY_SIZE(rtw_private_args),
 	.get_wireless_stats = rtw_get_wireless_stats,
 };
-- 
2.34.1

