Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9FF4BD727
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 08:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbiBUHeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 02:34:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346326AbiBUHdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 02:33:55 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C6913EAE
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 23:33:18 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a8so30880381ejc.8
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 23:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LmobdHxkxm4sdZUtfeeL0jQWyBgw3L2XhUOirp2Pdv8=;
        b=JFK//iev0pBvNj0CFQ9+b4BEWenMAl8usHqaW23BHSYyZtw9W/X7F/NKjK+fyHz/6n
         qEUzb1v+9BsdAXdg2zQSHBXGVy0lObGc/bLnYXNi5sBEA6g3IzTHkrnOe++R/CzL/49y
         7aUC6ci5LMzdG13gm3mWL43W39ZcoX1eSDD32wIKSCsq6w45oi8tDNfj2c5B5sVqbnGz
         4bk7Svz3Jy2GQvlkvtFnQi43WrBR5wx36uNA9F937H6lNsmO9WJaSjbYZx6VXkbts6tX
         IyhN6BdqKDfzTv/RfnvvVVYaddb7Tuy0gJCB3yubDu6m6Op6kUxO6Jk0zFgFrBjuYi1b
         u97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LmobdHxkxm4sdZUtfeeL0jQWyBgw3L2XhUOirp2Pdv8=;
        b=7sK1wCJ9YzFlj0s11gjgt+KP5HcNG426nulXR28k9btdUsVXY40ObRWKhTusxH9Xe0
         SHZr8Dv7raXpbwI6LMJMAwP4lIQ5InmyzLFqGV8BjQTSUN3VxqV3aOf0O+hIZOeC1bT/
         LytBzXm4HQ1DXoVcTKHdaRjApWTezTYzSl0rgJl/XtlPUkdqxv/bhop+qN4mgdn8nhCi
         MGvTy3lnr7mFY0CEq6pXeOBhEIwdcwQXBctGi4F66qCXKBXQiyN5Y6R9vkAU62CEaoyD
         1DXqfUAKcRJ+VF63nOh9VD8XIRJAfEhB61gTlfb9gRu0J+gMYV3rKsqYsE5IB0Ylh/E1
         w8Fg==
X-Gm-Message-State: AOAM530NY6jITD5yZ1FFKKxSGRtD3t2C536yiB3i88gGN55q6OWMr251
        pDrnJd0I1sHd5Sqrn9eKSIg=
X-Google-Smtp-Source: ABdhPJwekhD4/9toUXVwuLkN3p5pIZZr2uNzNF7c7+/+v4nqnQ1e/O3LotKXODnpNJ8mdR+A7sxGXA==
X-Received: by 2002:a17:906:37cf:b0:6ce:6321:5ecb with SMTP id o15-20020a17090637cf00b006ce63215ecbmr14897728ejc.385.1645428796658;
        Sun, 20 Feb 2022 23:33:16 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb8f.dynamic.kabel-deutschland.de. [95.90.187.143])
        by smtp.gmail.com with ESMTPSA id c11sm8673128edx.42.2022.02.20.23.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 23:33:16 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 2/5] staging: r8188eu: convert two u8 variables to bool
Date:   Mon, 21 Feb 2022 08:33:03 +0100
Message-Id: <20220221073306.16636-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221073306.16636-1-straube.linux@gmail.com>
References: <20220221073306.16636-1-straube.linux@gmail.com>
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

The variables bScanInProcess in struct mlme_priv and bpower_saving in
struct pwrctrl_priv are both used to store only boolean values true
and false. Convert them from u8 to bool to avoid type casts in the
function Update_ODM_ComInfo_88E().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v2:
Fixed a typo in the commit message.
unsed -> used

 drivers/staging/r8188eu/hal/rtl8188e_dm.c     | 4 ++--
 drivers/staging/r8188eu/include/rtw_mlme.h    | 2 +-
 drivers/staging/r8188eu/include/rtw_pwrctrl.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
index 09e78c4855f9..082104c9b2e8 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
@@ -42,8 +42,8 @@ static void Update_ODM_ComInfo_88E(struct adapter *Adapter)
 	dm_odm->pSecChOffset = &hal_data->nCur40MhzPrimeSC;
 	dm_odm->pBandWidth = (u8 *)&hal_data->CurrentChannelBW;
 	dm_odm->pChannel = &hal_data->CurrentChannel;
-	dm_odm->pbScanInProcess = (bool *)&pmlmepriv->bScanInProcess;
-	dm_odm->pbPowerSaving = (bool *)&pwrctrlpriv->bpower_saving;
+	dm_odm->pbScanInProcess = &pmlmepriv->bScanInProcess;
+	dm_odm->pbPowerSaving = &pwrctrlpriv->bpower_saving;
 
 	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_RF_ANTENNA_TYPE, hal_data->TRxAntDivType);
 
diff --git a/drivers/staging/r8188eu/include/rtw_mlme.h b/drivers/staging/r8188eu/include/rtw_mlme.h
index 1e16fa615b94..d418d57f99b6 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme.h
@@ -310,7 +310,7 @@ struct qos_priv {
 struct mlme_priv {
 	spinlock_t lock;
 	int fw_state;	/* shall we protect this variable? maybe not necessarily... */
-	u8 bScanInProcess;
+	bool bScanInProcess;
 	u8 to_join; /* flag */
 	u8 to_roaming; /*  roaming trying times */
 
diff --git a/drivers/staging/r8188eu/include/rtw_pwrctrl.h b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
index 2d5298373d74..7c3cb895c3cd 100644
--- a/drivers/staging/r8188eu/include/rtw_pwrctrl.h
+++ b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
@@ -49,7 +49,7 @@ struct pwrctrl_priv {
 
 	u32	alives;
 	struct work_struct cpwm_event;
-	u8	bpower_saving;
+	bool	bpower_saving;
 
 	u8	reg_rfoff;
 	u8	reg_pdnmode; /* powerdown mode */
-- 
2.35.1

