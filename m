Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048E357F601
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 18:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbiGXQbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 12:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiGXQbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 12:31:09 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2007011477
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 09:31:06 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id a18-20020a05600c349200b003a30de68697so6784565wmq.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 09:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vwmHKWFDT+EF3UFGxnIVN4ln9oL/VoZExBNeZ8SwUlo=;
        b=i3aMTYks0VKvRrw6hNkEf4pg2pQkPMFfqcXgLBWJAYspOmgY8mrJIXW4n08Qk/LN6Q
         MhRAW7GLxY/sWiVUD4xWdnrp+LEC4PiRc1j2mcqqg+s6lZd6HREQtgBgZ4xUG5o0FhJv
         Cqt2byFkb59gZQEBoRGQdTASprvwgPd/3fH04IGvBxFkkfHsp9Nn5Whmq/XkgmDUg4Ve
         VbpX5mpxrQjnYp7vpXzTOaX4CH7KtUwe79zM342PdexqcwqdMVGLlJym1UvDCOqmvNrF
         HG/zfXkf/poP4misp+AfUajW2YwUCKD0plAqupLg0E8AexHmU+rkYWKpIgaNyEtZweNT
         eOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vwmHKWFDT+EF3UFGxnIVN4ln9oL/VoZExBNeZ8SwUlo=;
        b=Th0J2Zy17IWEVdO6ynQDafsuvB0JOcWkzHBZXMuoEjkK6nS1EDliD8Cqz5nb+FiEdk
         aI01kiEmAqmMQPA7bimKeA6HtiBsVcUmkWu+kA6mYHqF6Fv6dixxpDikRgmoaGJvEDSK
         6rW/xGAyg0sz7UnEApaL6Q2pfLc2VkdjVMAOnnHpEUihk1oXrxRnWgOrip+YLiDF/Djv
         O5bKPE27IO4PMxloG91EnfRj0n52d5ZYDfPSJ/Ca/o8dzNuIpEDCNmK8cA4x9N1tnoSi
         l7LpPx01CxXKmICqzOYLLYAKMWHrEwmczUtGrwP/LyRMx50Cl3l0t7xHBttPgvBT4bzN
         tt4Q==
X-Gm-Message-State: AJIora8KdsFUpMOMNQg1djOP5AOtpQANhmNkWwG+33BwzVPJuPmcon5o
        yaIW7TApFw9wnZrw84e3oH90WA==
X-Google-Smtp-Source: AGRyM1spY+uBQ8rMFx8tCu2udBcI01FoWufstT9z+G4mUpi86kQIxUVItfrc6i6rcUn6f34EJhQy4Q==
X-Received: by 2002:a05:600c:1e29:b0:3a3:d15:e6fb with SMTP id ay41-20020a05600c1e2900b003a30d15e6fbmr19593305wmb.5.1658680264539;
        Sun, 24 Jul 2022 09:31:04 -0700 (PDT)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id k6-20020a5d5186000000b0021e571a99d5sm9084948wrv.17.2022.07.24.09.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 09:31:03 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, paskripkin@gmail.com,
        straube.linux@gmail.com, martin@kaiser.cx, abdun.nihaal@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: r8188eu: convert rtw_pwr_wakeup to correct error code semantics
Date:   Sun, 24 Jul 2022 17:30:55 +0100
Message-Id: <20220724163055.961-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the rtw_pwr_wakeup function to use 0 on success and -EPERM on
error - in all places where we handle this response, we use either -1 or
-EPERM currently anyway, which are equivalent. Also, for other places
along the same call chain where we are using -1, use -EPERM.

This gets the driver closer to removal of the non-standard _SUCCESS and
_FAIL definitions, which are inverted compared to the standard in-kernel
error code mechanism.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_p2p.c       |  4 +--
 drivers/staging/r8188eu/core/rtw_pwrctrl.c   | 10 +++---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 32 ++++++++++----------
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
index c306aafa183b..bd654d4ff8b4 100644
--- a/drivers/staging/r8188eu/core/rtw_p2p.c
+++ b/drivers/staging/r8188eu/core/rtw_p2p.c
@@ -1888,7 +1888,7 @@ int rtw_p2p_enable(struct adapter *padapter, enum P2P_ROLE role)
 
 	if (role == P2P_ROLE_DEVICE || role == P2P_ROLE_CLIENT || role == P2P_ROLE_GO) {
 		/* leave IPS/Autosuspend */
-		if (rtw_pwr_wakeup(padapter) == _FAIL) {
+		if (rtw_pwr_wakeup(padapter)) {
 			ret = _FAIL;
 			goto exit;
 		}
@@ -1902,7 +1902,7 @@ int rtw_p2p_enable(struct adapter *padapter, enum P2P_ROLE role)
 		init_wifidirect_info(padapter, role);
 
 	} else if (role == P2P_ROLE_DISABLE) {
-		if (rtw_pwr_wakeup(padapter) == _FAIL) {
+		if (rtw_pwr_wakeup(padapter)) {
 			ret = _FAIL;
 			goto exit;
 		}
diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index cf9020a73933..1cef3ef4d5f1 100644
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -381,24 +381,24 @@ int rtw_pwr_wakeup(struct adapter *padapter)
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	unsigned long timeout = jiffies + msecs_to_jiffies(3000);
 	unsigned long deny_time;
-	int ret = _SUCCESS;
+	int ret = 0;
 
 	while (pwrpriv->ps_processing && time_before(jiffies, timeout))
 		msleep(10);
 
 	/* I think this should be check in IPS, LPS, autosuspend functions... */
 	if (check_fwstate(pmlmepriv, _FW_LINKED)) {
-		ret = _SUCCESS;
+		ret = 0;
 		goto exit;
 	}
 
 	if (pwrpriv->rf_pwrstate == rf_off && ips_leave(padapter) == _FAIL) {
-		ret = _FAIL;
+		ret = -EPERM;
 		goto exit;
 	}
 
 	if (padapter->bDriverStopped || !padapter->bup || !padapter->hw_init_completed) {
-		ret = _FAIL;
+		ret = -EPERM;
 		goto exit;
 	}
 
@@ -439,7 +439,7 @@ int rtw_pm_set_ips(struct adapter *padapter, u8 mode)
 		return 0;
 	} else if (mode == IPS_NONE) {
 		rtw_ips_mode_req(pwrctrlpriv, mode);
-		if ((padapter->bSurpriseRemoved == 0) && (rtw_pwr_wakeup(padapter) == _FAIL))
+		if ((padapter->bSurpriseRemoved == 0) && rtw_pwr_wakeup(padapter))
 			return -EFAULT;
 	} else {
 		return -EINVAL;
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 930bb4aea435..e0ae0c3c51f8 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -689,7 +689,7 @@ static int rtw_wx_set_mode(struct net_device *dev, struct iw_request_info *a,
 
 
 
-	if (_FAIL == rtw_pwr_wakeup(padapter)) {
+	if (rtw_pwr_wakeup(padapter)) {
 		ret = -EPERM;
 		goto exit;
 	}
@@ -933,13 +933,13 @@ static int rtw_wx_set_wap(struct net_device *dev,
 
 
 
-	if (_FAIL == rtw_pwr_wakeup(padapter)) {
-		ret = -1;
+	if (rtw_pwr_wakeup(padapter)) {
+		ret = -EPERM;
 		goto exit;
 	}
 
 	if (!padapter->bup) {
-		ret = -1;
+		ret = -EPERM;
 		goto exit;
 	}
 
@@ -1049,23 +1049,23 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 	struct ndis_802_11_ssid ssid[RTW_SSID_SCAN_AMOUNT];
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
-	if (_FAIL == rtw_pwr_wakeup(padapter)) {
-		ret = -1;
+	if (rtw_pwr_wakeup(padapter)) {
+		ret = -EPERM;
 		goto exit;
 	}
 
 	if (padapter->bDriverStopped) {
-		ret = -1;
+		ret = -EPERM;
 		goto exit;
 	}
 
 	if (!padapter->bup) {
-		ret = -1;
+		ret = -EPERM;
 		goto exit;
 	}
 
 	if (!padapter->hw_init_completed) {
-		ret = -1;
+		ret = -EPERM;
 		goto exit;
 	}
 
@@ -1164,7 +1164,7 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 	}
 
 	if (!_status)
-		ret = -1;
+		ret = -EPERM;
 
 exit:
 
@@ -1252,13 +1252,13 @@ static int rtw_wx_set_essid(struct net_device *dev,
 
 	uint ret = 0, len;
 
-	if (_FAIL == rtw_pwr_wakeup(padapter)) {
-		ret = -1;
+	if (rtw_pwr_wakeup(padapter)) {
+		ret = -EPERM;
 		goto exit;
 	}
 
 	if (!padapter->bup) {
-		ret = -1;
+		ret = -EPERM;
 		goto exit;
 	}
 
@@ -1268,7 +1268,7 @@ static int rtw_wx_set_essid(struct net_device *dev,
 	}
 
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
-		ret = -1;
+		ret = -EPERM;
 		goto exit;
 	}
 
@@ -1301,7 +1301,7 @@ static int rtw_wx_set_essid(struct net_device *dev,
 				}
 
 				if (!rtw_set_802_11_infrastructure_mode(padapter, pnetwork->network.InfrastructureMode)) {
-					ret = -1;
+					ret = -EPERM;
 					spin_unlock_bh(&queue->lock);
 					goto exit;
 				}
@@ -1312,7 +1312,7 @@ static int rtw_wx_set_essid(struct net_device *dev,
 		spin_unlock_bh(&queue->lock);
 		rtw_set_802_11_authentication_mode(padapter, authmode);
 		if (!rtw_set_802_11_ssid(padapter, &ndis_ssid)) {
-			ret = -1;
+			ret = -EPERM;
 			goto exit;
 		}
 	}
-- 
2.36.1

