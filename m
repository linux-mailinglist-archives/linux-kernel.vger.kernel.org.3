Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CFD56C867
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 11:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiGIJpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 05:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiGIJpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 05:45:13 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E4F65D6D
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 02:45:12 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id b11so1369548eju.10
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 02:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gGNrZWcZve4ntLjDaNg+77tzOugVuMr5ZGinbcK3AS0=;
        b=mbzt/VM2GakxdRKK+ghwIOvW9inDdugRBB/rzwsxpv3evLOD0n5IS53Q2ifRPIHnJt
         3v5DQMstb96+IxscvcFEuGuc0I/KLfyWh0JgRjkl6LJlmxq9Upj/05Bnv6Qg93VRRbuT
         rlQe5gRpuMT9pQGgUzN2Qi0mt6QYaLeblp073awe5RsOSigM+jXCPX08/F2hn5r7S5TT
         4brED+9aN1ZIB48FKZXrZ4TXNGa66Lb43A8UXZp35GnVwsVjtMzg0lr8NLMzbZ6KCl/f
         5cUyUrKV1hYpmoWhB8xNSvSd8TyA06biBvHTBC7d919tjJ5mjYYllAP/xVs1Ea0Pw8aF
         PqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gGNrZWcZve4ntLjDaNg+77tzOugVuMr5ZGinbcK3AS0=;
        b=XuoItCc9AK229fwo7PXNVdwv/VIa0yY9W2pLqIh0HTGTHcqrDj4Pq1wBZhIFX5/6G1
         7ktgCNaQwuMYANCLG/qLpbXWYcsQFQjal1/IHRxkA1+s/DohZhRUWTDl6PnMT9rTTcjB
         McTR+U2Y8a7aSavWk9AWazRoY3Ru/3VKEuXRoh8lYmNpJMIvJFWe/dMAiZgUGm1dxdVH
         J95D2qj9mZ6HDebgmnvDz1iOurSKwTLxcBZ4S1xI2El4bOnTptMC5Jd+I4KM+Ymn8nGG
         HES0WFMo6rFWSKYYYmCqZhg/+Adcf125GczshNQZ/ED0nMzhboDyqT2s5M57othsucPk
         WeJg==
X-Gm-Message-State: AJIora9V12+MrLWYMKKQ6OGSSO1aork+Ba/uV9dWZikt2pk1rie1CS92
        WerF+I4Ck3lknCmB6OJI5Xs=
X-Google-Smtp-Source: AGRyM1tZehRvHfOA19V71v/2gVhkK0TWSbmapDF7TpKevVIV6liGDFmsTVVPsMj+RrD0iTFd3ha52A==
X-Received: by 2002:a17:906:c048:b0:718:ca61:e7b9 with SMTP id bm8-20020a170906c04800b00718ca61e7b9mr7965328ejb.120.1657359911561;
        Sat, 09 Jul 2022 02:45:11 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb6f.dynamic.kabel-deutschland.de. [95.90.187.111])
        by smtp.gmail.com with ESMTPSA id hy10-20020a1709068a6a00b00704757b1debsm441521ejc.9.2022.07.09.02.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 02:45:11 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/5] staging: r8188eu: remove HW_VAR_DM_FUNC_CLR from SetHwReg8188EU()
Date:   Sat,  9 Jul 2022 11:44:58 +0200
Message-Id: <20220709094458.9578-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220709094458.9578-1-straube.linux@gmail.com>
References: <20220709094458.9578-1-straube.linux@gmail.com>
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

Remove the HW_VAR_DM_FUNC_CLR case from SetHwReg8188EU() and move its
functionality to a static function. This is part of the ongoing effort
to get rid of SetHwReg8188EU().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 12 ++++++++++--
 drivers/staging/r8188eu/hal/usb_halinit.c   |  5 -----
 drivers/staging/r8188eu/include/hal_intf.h  |  1 -
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 31d936ad063a..eecb00e41d6a 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -6655,6 +6655,14 @@ static void rtw_reset_dm_func_flag(struct adapter *adapter)
 	odmpriv->SupportAbility = dmpriv->InitODMFlag;
 }
 
+static void rtw_clear_dm_func_flag(struct adapter *adapter)
+{
+	struct hal_data_8188e *haldata = &adapter->haldata;
+	struct odm_dm_struct *odmpriv = &haldata->odmpriv;
+
+	odmpriv->SupportAbility = 0;
+}
+
 void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
 {
 	struct sta_info		*psta, *psta_bmc;
@@ -7110,7 +7118,7 @@ u8 createbss_hdl(struct adapter *padapter, u8 *pbuf)
 
 		/* disable dynamic functions, such as high power, DIG */
 		Save_DM_Func_Flag(padapter);
-		SetHwReg8188EU(padapter, HW_VAR_DM_FUNC_CLR, NULL);
+		rtw_clear_dm_func_flag(padapter);
 
 		/* cancel link timer */
 		_cancel_timer_ex(&pmlmeext->link_timer);
@@ -7380,7 +7388,7 @@ u8 sitesurvey_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 	if ((pmlmeext->sitesurvey_res.state == SCAN_START) || (pmlmeext->sitesurvey_res.state == SCAN_TXNULL)) {
 		/* disable dynamic functions, such as high power, DIG */
 		Save_DM_Func_Flag(padapter);
-		SetHwReg8188EU(padapter, HW_VAR_DM_FUNC_CLR, NULL);
+		rtw_clear_dm_func_flag(padapter);
 
 		/* config the initial gain under scanning, need to write the BB registers */
 		if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE))
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 92446cd1a096..04beded95475 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1061,8 +1061,6 @@ static void hw_var_set_opmode(struct adapter *Adapter, u8 *val)
 
 void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 {
-	struct hal_data_8188e *haldata = &Adapter->haldata;
-	struct odm_dm_struct *podmpriv = &haldata->odmpriv;
 	u8 reg;
 	int res;
 
@@ -1156,9 +1154,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			rtw_write32(Adapter, REG_RCR, reg32 | RCR_CBSSID_BCN);
 		}
 		break;
-	case HW_VAR_DM_FUNC_CLR:
-		podmpriv->SupportAbility = 0;
-		break;
 	default:
 		break;
 	}
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index d33e75bcac74..c1db7f834e20 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -12,7 +12,6 @@ enum hw_variables {
 	HW_VAR_SET_OPMODE,
 	HW_VAR_CORRECT_TSF,
 	HW_VAR_MLME_SITESURVEY,
-	HW_VAR_DM_FUNC_CLR,
 };
 
 typedef s32 (*c2h_id_filter)(u8 id);
-- 
2.36.1

