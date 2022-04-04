Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452EF4F10CE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 10:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352360AbiDDIXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349065AbiDDIXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:23:46 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29C43B3FC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 01:21:50 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id r10so4354749eda.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 01:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eYi42idZagF7+PntnhrV7u1NVJ1zH5gAAuFaLqoUChg=;
        b=JjsmMULs94skPzT6xphNvB4kqywkZnL72/HghLakTvfFcbUjYvX0Z4O/7mNIZGfWEw
         ONrgKXfIvNmc81bgyIfTtuNsLlaOHKLs/xkV7+5/yyJRRXc0Dzno3BX+au9N1Y0Vd7L1
         1VHqTMV7EgKErFvvwhs532WZtJCMETyv1yJTHhxE9kx9XhOOBhBFq9Jn2C+dd0nu+h88
         VhPfT4LdevaT3mqECsz+X/O0uEAimqT3tC/92w9eGHao4Nn25aO20OACQ/hiXIl8kdz2
         UkF/mOr/KxuZUY7CiOlhF1CtDACs3O5qoUcDgG3cVBmBUFDj/29QoyQQQFY8GAGwxnyx
         bV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eYi42idZagF7+PntnhrV7u1NVJ1zH5gAAuFaLqoUChg=;
        b=T6OZz0NFZZOL//shYgSVGY/OMsSVsFdUt1ABmCm9xm/MgOiQIm63B1DWSGJzkdykI5
         dKvavQbItItlAeQ8BsjT56KmlmA0wuMkzxYfAgIdRPPwH1uDwqqQo9OEeQBY8YLfHV26
         Vf/dyvv0dEVsdkYf9vI1qM/cZnwdYlhOn9YoJ9nhEA97Wh7Nxt/J9/dERd63ag883pfg
         M2mSxk/F25EulgssS0YvHCh9If93AuTSHgTKzufZJL/vQ6M8J9lMX4TUH3ly37G95Nmu
         jREZn5NXt3p6CbOIiKd6aQ67guvsPffTGsvhT0yyBfbzxnc4trJT09X6lWzoy9NDk6I4
         RItg==
X-Gm-Message-State: AOAM532rnAZJwfh6mG2S5c05iDRYy0sI/T+5dhsDh50Acz2MITs9LP4t
        unDIkiOOPEkEdu8ZoLzjVYI5GdDx1oI=
X-Google-Smtp-Source: ABdhPJxNjt+nCbqV1xpIeLBTsFp/FnJSPk2UM+b7LWRvSinLDRADDXWo4LlRiMDnzweqhORcZxmCgQ==
X-Received: by 2002:a50:f092:0:b0:41c:b7dd:cdb5 with SMTP id v18-20020a50f092000000b0041cb7ddcdb5mr7649642edl.225.1649060509500;
        Mon, 04 Apr 2022 01:21:49 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id n3-20020a1709061d0300b006da94efcc7esm4047336ejh.204.2022.04.04.01.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 01:21:48 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/5] staging: r8188eu: pwr_state_check_cnts is always zero
Date:   Mon,  4 Apr 2022 10:21:41 +0200
Message-Id: <20220404082142.4639-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220404082142.4639-1-straube.linux@gmail.com>
References: <20220404082142.4639-1-straube.linux@gmail.com>
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

The field pwr_state_check_cnts in struct pwrctrl_priv is set to 0 and
never changed. Remove it and remove related dead code.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_pwrctrl.c    | 4 +---
 drivers/staging/r8188eu/include/rtw_pwrctrl.h | 1 -
 drivers/staging/r8188eu/os_dep/os_intfs.c     | 3 ---
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index 5d468e8b4920..939909e5316f 100644
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -133,9 +133,8 @@ void rtw_ps_processor(struct adapter *padapter)
 	if (!rtw_pwr_unassociated_idle(padapter))
 		goto exit;
 
-	if ((pwrpriv->rf_pwrstate == rf_on) && ((pwrpriv->pwr_state_check_cnts % 4) == 0)) {
+	if (pwrpriv->rf_pwrstate == rf_on) {
 		pwrpriv->change_rfpwrstate = rf_off;
-
 		ips_enter(padapter);
 	}
 exit:
@@ -342,7 +341,6 @@ void rtw_init_pwrctrl_priv(struct adapter *padapter)
 	pwrctrlpriv->ips_mode_req = padapter->registrypriv.ips_mode;
 
 	pwrctrlpriv->pwr_state_check_interval = RTW_PWR_STATE_CHK_INTERVAL;
-	pwrctrlpriv->pwr_state_check_cnts = 0;
 	pwrctrlpriv->bInSuspend = false;
 	pwrctrlpriv->bkeepfwalive = false;
 
diff --git a/drivers/staging/r8188eu/include/rtw_pwrctrl.h b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
index 94a65056a77e..162792988910 100644
--- a/drivers/staging/r8188eu/include/rtw_pwrctrl.h
+++ b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
@@ -69,7 +69,6 @@ struct pwrctrl_priv {
 	u8		bSupportRemoteWakeup;
 	struct timer_list pwr_state_check_timer;
 	int		pwr_state_check_interval;
-	u8		pwr_state_check_cnts;
 
 	int		ps_flag;
 
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index c531504acc9e..5a9374957e3a 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -441,7 +441,6 @@ static void rtw_init_default_value(struct adapter *padapter)
 u8 rtw_reset_drv_sw(struct adapter *padapter)
 {
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct pwrctrl_priv *pwrctrlpriv = &padapter->pwrctrlpriv;
 
 	/* hal_priv */
 	rtl8188eu_init_default_value(padapter);
@@ -457,8 +456,6 @@ u8 rtw_reset_drv_sw(struct adapter *padapter)
 
 	_clr_fwstate_(pmlmepriv, _FW_UNDER_SURVEY | _FW_UNDER_LINKING);
 
-	pwrctrlpriv->pwr_state_check_cnts = 0;
-
 	/* mlmeextpriv */
 	padapter->mlmeextpriv.sitesurvey_res.state = SCAN_DISABLE;
 
-- 
2.35.1

