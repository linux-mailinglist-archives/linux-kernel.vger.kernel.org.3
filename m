Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54031580718
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 00:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237095AbiGYWH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 18:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237058AbiGYWHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 18:07:54 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1842494B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 15:07:53 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d13so10152880wrn.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 15:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YX8gya+JdH9wcWgAwtkJP8fnVfZ0melPvDPSG5XgAwk=;
        b=uP5ZrHyO3Da3m+8fcPU+hZfqxTj1rmQSmkFTz0TsZ+h73S7Dv8je/l/8dPisJepd2+
         jyEEKzhCW/SuhSRzNZ4ChGBFnAfNnso1pol8yLgF2DmrtStfHVWiq9vy2OTiT3FBkWmh
         N+NIX2iD6I/cKcbU4HQyED0eb9NAJvagbYcPJh/0nu4albRZ8YWUai7ws+nrSAKCnkMb
         8snbh0kn5zx0/FB4bzS6d4JOABze1oDS01pAg34PDiT9YekK/TN7W+vzmroav2Elc4A0
         sMEBMiXlctGcH60swBUh5v1E1y+2P9vujKxvIOnzx3WFSGwqvdeB1razWinbqV1Cpseq
         i/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YX8gya+JdH9wcWgAwtkJP8fnVfZ0melPvDPSG5XgAwk=;
        b=z1xv0HJLmZv+sQ8SR1hOEGvypva1klfIuMaMn7gLa/q4db0rG5dDWM6ErT46dRQFhl
         ZzBZsliIPXm6kbJThNYH51loWct81mzazAn6bjPNLvcYoEOfLRQNqq+6sMSptL3LyYc9
         uPVWPePoQVmbUeed2UUyL28YQlVic+9Z0rDiBV0HzAnvDQFU1QkPku1M/v9U+rHWFvDF
         KwuAT8BWhFu7KfpIcKiau+rDy96JNcYKZara54jsA5KfziHXYcsFMKx/tQzUdYv3g6pp
         wIWvFeNI+ptpfCL2Z7xiJ8BwDXlFRQvnfzdUQFxjGa94YezqU4nrEk9KYzfMHM0xJbPz
         7IJg==
X-Gm-Message-State: AJIora9ZRYf4FsnGCu6ksGj9QEfgD8ytSEJ16jKwlbaR9pBGXlYkMK+f
        7ayvAyhIQm6ZTkVS1yGx0e7kgA==
X-Google-Smtp-Source: AGRyM1umpNC75XUN/7mel0QlFYq/UYpC3/HLHO+ITlI6lmANEzWxyyEhxEYle2PDQ6CprDUOEZoULA==
X-Received: by 2002:a5d:6848:0:b0:21e:5e37:b2e4 with SMTP id o8-20020a5d6848000000b0021e5e37b2e4mr9137487wrw.530.1658786871669;
        Mon, 25 Jul 2022 15:07:51 -0700 (PDT)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id s3-20020a05600c384300b003a2d47d3051sm17636475wmr.41.2022.07.25.15.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 15:07:51 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org, dan.carpenter@oracle.com
Cc:     Larry.Finger@lwfinger.net, paskripkin@gmail.com,
        straube.linux@gmail.com, martin@kaiser.cx, abdun.nihaal@gmail.com,
        philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: r8188eu: convert rtw_pwr_wakeup to correct error code semantics
Date:   Mon, 25 Jul 2022 23:07:45 +0100
Message-Id: <20220725220745.12739-1-phil@philpotter.co.uk>
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

Convert the rtw_pwr_wakeup function to use 0 on success and an appropriate
error code on error. For the first failure block where ips_leave is
invoked, use -ENOMEM as this is the main cause of failure here anyway.
For the second failure block, use -EBUSY, as it seems the most
appropriate.

Finally, within the functions rtw_wx_set_mode, rtw_wx_set_wap,
rtw_wx_set_scan and rtw_wx_set_essid, pass the error code on from
rtw_pwr_wakeup as appropriate now that it is converted.

This gets the driver closer to removal of the non-standard _SUCCESS and
_FAIL definitions, which are inverted compared to the standard in-kernel
error code mechanism.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---

Changes from V1: Act on feedback from Dan Carpenter:
* Try to use more appropriate error codes than -EPERM.
* Revert the places where existing -1 was converted as they are out of
  scope.
* Preserve error codes in places where calling function already uses
  proper negative semantics, so that they can be passed through to the
  caller.

---
 drivers/staging/r8188eu/core/rtw_p2p.c       |  4 ++--
 drivers/staging/r8188eu/core/rtw_pwrctrl.c   | 10 ++++----
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 24 +++++++-------------
 3 files changed, 15 insertions(+), 23 deletions(-)

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
index cf9020a73933..8b1c50668dfe 100644
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
+		ret = -ENOMEM;
 		goto exit;
 	}
 
 	if (padapter->bDriverStopped || !padapter->bup || !padapter->hw_init_completed) {
-		ret = _FAIL;
+		ret = -EBUSY;
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
index 930bb4aea435..7f91dac2e41b 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -687,12 +687,9 @@ static int rtw_wx_set_mode(struct net_device *dev, struct iw_request_info *a,
 	enum ndis_802_11_network_infra networkType;
 	int ret = 0;
 
-
-
-	if (_FAIL == rtw_pwr_wakeup(padapter)) {
-		ret = -EPERM;
+	ret = rtw_pwr_wakeup(padapter);
+	if (ret)
 		goto exit;
-	}
 
 	if (!padapter->hw_init_completed) {
 		ret = -EPERM;
@@ -931,12 +928,9 @@ static int rtw_wx_set_wap(struct net_device *dev,
 	struct	wlan_network	*pnetwork = NULL;
 	enum ndis_802_11_auth_mode	authmode;
 
-
-
-	if (_FAIL == rtw_pwr_wakeup(padapter)) {
-		ret = -1;
+	ret = rtw_pwr_wakeup(padapter);
+	if (ret)
 		goto exit;
-	}
 
 	if (!padapter->bup) {
 		ret = -1;
@@ -1049,10 +1043,9 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 	struct ndis_802_11_ssid ssid[RTW_SSID_SCAN_AMOUNT];
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
-	if (_FAIL == rtw_pwr_wakeup(padapter)) {
-		ret = -1;
+	ret = rtw_pwr_wakeup(padapter);
+	if (ret)
 		goto exit;
-	}
 
 	if (padapter->bDriverStopped) {
 		ret = -1;
@@ -1252,10 +1245,9 @@ static int rtw_wx_set_essid(struct net_device *dev,
 
 	uint ret = 0, len;
 
-	if (_FAIL == rtw_pwr_wakeup(padapter)) {
-		ret = -1;
+	ret = rtw_pwr_wakeup(padapter);
+	if (ret)
 		goto exit;
-	}
 
 	if (!padapter->bup) {
 		ret = -1;
-- 
2.36.1

