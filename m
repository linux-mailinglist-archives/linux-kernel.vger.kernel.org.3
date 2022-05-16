Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305C7527D24
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 07:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239906AbiEPFsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 01:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiEPFsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 01:48:37 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8370611C3D
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 22:48:36 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id j28so2789861eda.13
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 22:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z35PekQ/2obmmP7m7D/fzPEe8sTueCxczGR+BZRhlAI=;
        b=M4P11R9PJwApTYAm8LsM2xM4jNSNLLzKTJjeUWS0QlNd0RkPanh0VzzdIFIYoZ+xCM
         s8wesEf9PTAFw04UsFo1RUMNdcGcxy3HcMNTAX93Gnyy+mqsT19v7Ycjp7DH12+n6kwF
         2W2UC3P27/0Z4Fsdx9nUvp220CgfQmLtCGryHWwKfdfxLP7ZChsHs0+3khn5DV+K2K3Q
         QuRIiAL276RH6Pvm2UU00IxVYljHemP0x+4qgPS/X7JQpf8FFd77clKOV8RI4P9g+Cd5
         XkMflytUzc73AqyAV7jr1+a7cBoxNtonGpvy4x/m3mCMr2g+5EgZa7Cq6lWLmYxzQpcK
         qGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z35PekQ/2obmmP7m7D/fzPEe8sTueCxczGR+BZRhlAI=;
        b=pm2zUklM8MhA/dTtSRUfKiroEKWk4BIx+WcVXffJAnaxCedjv1s/IFaIj7FWE3IRbw
         vJY5KhXMZIcC82MoOaZAfZJsd9KekI4hJEXkEKvZ8R9IwJwSXYNYtUJKGPWAwuakt8hF
         bEyuok73dW8oEHrqgGiTlJjvric9acInNffT7AjFSxCLgI7i9ImkF9J5SYwXLq/Tu2fH
         qz7HGFGlFmg5E/uWSUy17l7SllZDGCGNAhnVWmrulPv+AFCNcLTIuqL3Y8zRpAm3pVAU
         r1LWMqyKj58z0FXx96Qql0S02FfVUkDpG8gRDrJgjXzJNGcr5AZaU+p1PtWGTOqA72br
         apCg==
X-Gm-Message-State: AOAM533rrLee0uHRe6rMhPF387jWr2rjAVUtCZK6qKOR2WhydHbAPtlH
        7xhSgxEsn4EzreWS2iFuzCw=
X-Google-Smtp-Source: ABdhPJwVqd1ZeHGsghwoGNZPevd88H+ELuP25CPf+/RB5GwvGCtb4HyBoE3EOdQlZtNxuXChWVPuFQ==
X-Received: by 2002:a05:6402:849:b0:427:edfe:1b7e with SMTP id b9-20020a056402084900b00427edfe1b7emr11360145edz.355.1652680115148;
        Sun, 15 May 2022 22:48:35 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb79.dynamic.kabel-deutschland.de. [95.90.187.121])
        by smtp.gmail.com with ESMTPSA id u19-20020aa7d0d3000000b0042ab87ea713sm343714edo.22.2022.05.15.22.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 22:48:34 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: remove HW_VAR_AC_PARAM_BE from SetHwReg8188EU()
Date:   Mon, 16 May 2022 07:48:30 +0200
Message-Id: <20220516054830.8702-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the HW_VAR_AC_PARAM_BE case from SetHwReg8188EU() and move the
functionality to the place where SetHwReg8188EU() is called. This is
part of the ongoing effort to get rid of the unwanted hal layer.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_wlan_util.c | 4 +++-
 drivers/staging/r8188eu/hal/usb_halinit.c    | 4 ----
 drivers/staging/r8188eu/include/hal_intf.h   | 1 -
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index 27035eac6e61..6c75363c76d4 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -539,6 +539,7 @@ void WMMOnAssocRsp(struct adapter *padapter)
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	struct xmit_priv		*pxmitpriv = &padapter->xmitpriv;
 	struct registry_priv	*pregpriv = &padapter->registrypriv;
+	struct hal_data_8188e *haldata = &padapter->haldata;
 
 	if (pmlmeinfo->WMM_enable == 0) {
 		padapter->mlmepriv.acm_mask = 0;
@@ -567,7 +568,8 @@ void WMMOnAssocRsp(struct adapter *padapter)
 
 		switch (ACI) {
 		case 0x0:
-			SetHwReg8188EU(padapter, HW_VAR_AC_PARAM_BE, (u8 *)(&acParm));
+			haldata->AcParam_BE = acParm;
+			rtw_write32(padapter, REG_EDCA_BE_PARAM, acParm);
 			acm_mask |= (ACM ? BIT(1) : 0);
 			edca[XMIT_BE_QUEUE] = acParm;
 			break;
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index b62ebd011886..a217272a07f8 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1075,10 +1075,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 	case HW_VAR_DM_FUNC_CLR:
 		podmpriv->SupportAbility = 0;
 		break;
-	case HW_VAR_AC_PARAM_BE:
-		haldata->AcParam_BE = ((u32 *)(val))[0];
-		rtw_write32(Adapter, REG_EDCA_BE_PARAM, ((u32 *)(val))[0]);
-		break;
 	case HW_VAR_AMPDU_FACTOR:
 		{
 			u8 RegToSet_Normal[4] = {0x41, 0xa8, 0x72, 0xb9};
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 26dd395c239f..a56f3d6ca399 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -18,7 +18,6 @@ enum hw_variables {
 	HW_VAR_DM_FUNC_OP,
 	HW_VAR_DM_FUNC_RESET,
 	HW_VAR_DM_FUNC_CLR,
-	HW_VAR_AC_PARAM_BE,
 	HW_VAR_AMPDU_FACTOR,
 	HW_VAR_H2C_MEDIA_STATUS_RPT,
 };
-- 
2.36.1

