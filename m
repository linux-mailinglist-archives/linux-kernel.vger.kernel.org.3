Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8E3528B8D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 19:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344098AbiEPREp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 13:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344076AbiEPREh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 13:04:37 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D303255B5
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 10:04:36 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id i17so15004477pla.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 10:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9jbHJ9DXcGeuMwC9N2+XOhDP8Q1hP8OkPUBuzaHRk2o=;
        b=QAOmnexkaoqNsviKOMfuSuZVNMVGMjr83P8AXqth1R9RNk17459XGSTTqsa0119IPz
         FhzqQYXi0OgmH3NWe7MaYnxI1o8h2ecD8CFunYTqjSrrjA04ckAmKYJJaf8yknIBSvZP
         9L3UOrRAoSIg3nEvLFf8mczdQM3OTWsZi0aszJ9dR59EAxRBa45Lx1NgdRLkeqUJ2Qgm
         KFTLTVmKLOF8FGviGrf5Kw75+hy0Pfoi8S3Gvpx5UdcNTejinezKN5gqrwlZHAYRZn9i
         PmA96uEPGjzvSiMJYI5X4CQKjWJfC2uRbWV2gcsetcuQY1+Zpokeg5ndIihrZuRrYhvt
         1JBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9jbHJ9DXcGeuMwC9N2+XOhDP8Q1hP8OkPUBuzaHRk2o=;
        b=S7WDj4O4TNjVAuHjrs/Hdef2/zJSp2oaUNaPgbb61xfi22j6pPgTmYxsuELkuoDkH9
         5ol0LyRGoKwKgm/Bg3FMe1d2ii60/Nea1HD3SdNdn2ueA7GlMPominj1SuGkoFjBEhOf
         fjP8hIj3xaYRe/SSj9aamR90njNL+KSex/l3S5Bj6Kk5fAByvOvIuzucdQ+0spXkqh7j
         kySl0cuLmn9FOU51SPFokrj/kz3iGkhb9rlRLSqhnj6yMhz+ucpOCVATu+t2o33mwcTC
         nj7onN8adkPAGfAatFNzCmndffv+DMQcWZSeovTBvb9WRV23NQepbIM4QdUzZYQzDlZ8
         xPBw==
X-Gm-Message-State: AOAM532tH1Zk1MDXUoLm96TVt5XM6nwhlmWPEjcNvJDoay7DAQa6rXl9
        qP7/bUy6Mo9381nkMPi+eBY=
X-Google-Smtp-Source: ABdhPJzk9CdpJcTevaAlgNRWRiJ+uNF5sQx/jiB2remF5bOdYS0r2MleRnQvMO96cQ1LDCFGpCbP7Q==
X-Received: by 2002:a17:902:76cb:b0:15e:e178:e2eb with SMTP id j11-20020a17090276cb00b0015ee178e2ebmr18430608plt.0.1652720674692;
        Mon, 16 May 2022 10:04:34 -0700 (PDT)
Received: from makvihas.localhost.com ([2405:201:202b:1:6465:4732:de67:bb26])
        by smtp.gmail.com with ESMTPSA id b190-20020a621bc7000000b0050dc762819csm7141292pfb.118.2022.05.16.10.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 10:04:34 -0700 (PDT)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH 2/3] staging: r8188eu: fix checkpatch.pl warnings in rtw_pwrctrl
Date:   Mon, 16 May 2022 22:33:05 +0530
Message-Id: <20220516170306.6008-3-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220516170306.6008-1-makvihas@gmail.com>
References: <20220516170306.6008-1-makvihas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        NO_RDNS_DOTCOM_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the code to fix following warnings:
    WARNING: Comparisons should place the constant on the right side of the test

Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_pwrctrl.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index 6990808ef..a54d47ba8 100644
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -59,7 +59,7 @@ int ips_leave(struct adapter *padapter)
 			pwrpriv->rf_pwrstate = rf_on;
 		}
 
-		if ((_WEP40_ == psecuritypriv->dot11PrivacyAlgrthm) || (_WEP104_ == psecuritypriv->dot11PrivacyAlgrthm)) {
+		if ((psecuritypriv->dot11PrivacyAlgrthm == _WEP40_) || (psecuritypriv->dot11PrivacyAlgrthm == _WEP104_)) {
 			set_channel_bwmode(padapter, padapter->mlmeextpriv.cur_channel, HAL_PRIME_CHNL_OFFSET_DONT_CARE, HT_CHANNEL_WIDTH_20);
 			for (keyid = 0; keyid < 4; keyid++) {
 				if (pmlmepriv->key_mask & BIT(keyid)) {
@@ -198,7 +198,7 @@ void rtw_set_ps_mode(struct adapter *padapter, u8 ps_mode, u8 smart_ps, u8 bcn_a
 		return;
 
 	if (pwrpriv->pwr_mode == ps_mode) {
-		if (PS_MODE_ACTIVE == ps_mode)
+		if (ps_mode == PS_MODE_ACTIVE)
 			return;
 
 		if ((pwrpriv->smart_ps == smart_ps) &&
@@ -356,7 +356,7 @@ void rtw_init_pwrctrl_priv(struct adapter *padapter)
 
 	pwrctrlpriv->LpsIdleCount = 0;
 	pwrctrlpriv->power_mgnt = padapter->registrypriv.power_mgnt;/*  PS_MODE_MIN; */
-	pwrctrlpriv->bLeisurePs = PS_MODE_ACTIVE != pwrctrlpriv->power_mgnt;
+	pwrctrlpriv->bLeisurePs =  pwrctrlpriv->power_mgnt != PS_MODE_ACTIVE;
 
 	pwrctrlpriv->bFwCurrentInPSMode = false;
 
@@ -409,12 +409,12 @@ int rtw_pm_set_lps(struct adapter *padapter, u8 mode)
 
 	if (mode < PS_MODE_NUM) {
 		if (pwrctrlpriv->power_mgnt != mode) {
-			if (PS_MODE_ACTIVE == mode)
+			if (mode == PS_MODE_ACTIVE)
 				LeaveAllPowerSaveMode(padapter);
 			else
 				pwrctrlpriv->LpsIdleCount = 2;
 			pwrctrlpriv->power_mgnt = mode;
-			pwrctrlpriv->bLeisurePs = PS_MODE_ACTIVE != pwrctrlpriv->power_mgnt;
+			pwrctrlpriv->bLeisurePs = pwrctrlpriv->power_mgnt != PS_MODE_ACTIVE;
 		}
 	} else {
 		ret = -EINVAL;
@@ -432,7 +432,7 @@ int rtw_pm_set_ips(struct adapter *padapter, u8 mode)
 		return 0;
 	} else if (mode == IPS_NONE) {
 		rtw_ips_mode_req(pwrctrlpriv, mode);
-		if ((padapter->bSurpriseRemoved == 0) && (_FAIL == rtw_pwr_wakeup(padapter)))
+		if ((padapter->bSurpriseRemoved == 0) && (rtw_pwr_wakeup(padapter) == _FAIL))
 			return -EFAULT;
 	} else {
 		return -EINVAL;
-- 
2.30.2

