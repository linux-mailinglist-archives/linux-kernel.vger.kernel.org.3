Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067BF5884D8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 01:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbiHBXoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 19:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiHBXoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 19:44:15 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1065465D
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 16:44:14 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id a18-20020a05600c349200b003a30de68697so1232564wmq.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 16:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LdDwNECNKOvsqe41unvtSWJtqFXY0vco7mkCCiO+5zA=;
        b=Me9ngPLMG9NwxgPxLEPrV78K+02GbdHmULeqAhvxcSynw/dYDkSGOX3g9GQBQROOIE
         tS6jz+TsARqv0yzYh7E+lyp+bCaCcETeryRArofAmv9Jq7bZEqc/XTub+oy7Yb6Z4BU3
         nQWklkOQcN6w4BrD0E0EFdYKkks+1NbTbvhjbOoQykXaOYari+Jf5NZViMaAAImRrysr
         +9eqIGN6NIr0qzummthstNjdy707nTFwmh1kd/9qTnM5dTywPMBP4aM060T3Q+I0tF2x
         Xyj8WVwBuPeqNVxtYOuWmKtC+jJHL+EEmEDPh0GSH7sF9y120lTasGs6ngAJsTKCR0v6
         Vgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LdDwNECNKOvsqe41unvtSWJtqFXY0vco7mkCCiO+5zA=;
        b=PRzmzQdgH+qq4um9xK+m6GsLQ6Z5e5oewFrUl9CNMuFq7gGWg12CVw/iOz7gs8kocN
         hw44kbdwb9xCknl3f+4fG9XZeWQNRIeu1VV7uc9fojOs8Ad7rPTVfR7ri9RvF4y9Xyce
         spwdLpQ7H7uLZv0U9/LDHXkdeSIhy7MEzG0sg+hXxVghTbf6rBvC8t61cYLlptyR/t54
         7Cd+BkFAIpiykqcoS2aMCWpJdizGMFaYiPna6PAOajjzA7Cd8dh8BzoWT1q1CaDo7xgf
         Ud9KX383Bire8+qQecbx94PlQ0OpO9TufSYozY9aakpT8NONdoK3WJ0wV0bbPomJeoPI
         eWjQ==
X-Gm-Message-State: ACgBeo0sT0J2PL5uyZWapVBcV9Y3BV9g97Vw5agFF9kejexhdjS3Y21X
        +/kgUsRU+5T0JAuLe/jOu6xy7mrxhS1LSA==
X-Google-Smtp-Source: AA6agR7eO6ES2+kK8YX/k7Qd1X7tV4TDZC1/ibzpACd/4CXVQcuP+uC90AqOhIC4/DXi/0XiuqHmUQ==
X-Received: by 2002:a05:600c:384c:b0:3a3:744d:8dd2 with SMTP id s12-20020a05600c384c00b003a3744d8dd2mr994110wmr.117.1659483853048;
        Tue, 02 Aug 2022 16:44:13 -0700 (PDT)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c359300b003a32297598csm220092wmq.43.2022.08.02.16.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 16:44:12 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, paskripkin@gmail.com,
        straube.linux@gmail.com, martin@kaiser.cx, abdun.nihaal@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: r8188eu: convert rtw_p2p_enable to correct error code semantics
Date:   Wed,  3 Aug 2022 00:44:08 +0100
Message-Id: <20220802234408.930-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.37.1
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

Convert the rtw_p2p_enable function to use correct error code semantics
rather than _SUCCESS/_FAIL, and also make sure we allow these to be
passed through properly in the one caller where we actually check the
code, rtw_wext_p2p_enable.

This change moves these functions to a clearer 'return 0;' style at the
end of the function, and in the case of errors now returns ret instead
of jumping to the end of the function, so that these can still be passed
through but without using a goto to jump to a single return statement at
the end which is less clear.

This change moves the driver slowly closer to using standard error code
semantics everywhere.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_p2p.c       | 19 ++++++++-----------
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 12 +++++-------
 2 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
index bd654d4ff8b4..dc159e58f428 100644
--- a/drivers/staging/r8188eu/core/rtw_p2p.c
+++ b/drivers/staging/r8188eu/core/rtw_p2p.c
@@ -1883,15 +1883,14 @@ void init_wifidirect_info(struct adapter *padapter, enum P2P_ROLE role)
 
 int rtw_p2p_enable(struct adapter *padapter, enum P2P_ROLE role)
 {
-	int ret = _SUCCESS;
+	int ret;
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
 	if (role == P2P_ROLE_DEVICE || role == P2P_ROLE_CLIENT || role == P2P_ROLE_GO) {
 		/* leave IPS/Autosuspend */
-		if (rtw_pwr_wakeup(padapter)) {
-			ret = _FAIL;
-			goto exit;
-		}
+		ret = rtw_pwr_wakeup(padapter);
+		if (ret)
+			return ret;
 
 		/*	Added by Albert 2011/03/22 */
 		/*	In the P2P mode, the driver should not support the b mode. */
@@ -1902,10 +1901,9 @@ int rtw_p2p_enable(struct adapter *padapter, enum P2P_ROLE role)
 		init_wifidirect_info(padapter, role);
 
 	} else if (role == P2P_ROLE_DISABLE) {
-		if (rtw_pwr_wakeup(padapter)) {
-			ret = _FAIL;
-			goto exit;
-		}
+		ret = rtw_pwr_wakeup(padapter);
+		if (ret)
+			return ret;
 
 		/* Disable P2P function */
 		if (!rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE)) {
@@ -1923,6 +1921,5 @@ int rtw_p2p_enable(struct adapter *padapter, enum P2P_ROLE role)
 		update_tx_basic_rate(padapter, padapter->registrypriv.wireless_mode);
 	}
 
-exit:
-	return ret;
+	return 0;
 }
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 7f91dac2e41b..e9802d42aa1b 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -2079,7 +2079,7 @@ static int rtw_wext_p2p_enable(struct net_device *dev,
 			       struct iw_request_info *info,
 			       union iwreq_data *wrqu, char *extra)
 {
-	int ret = 0;
+	int ret;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
@@ -2094,10 +2094,9 @@ static int rtw_wext_p2p_enable(struct net_device *dev,
 	else if (*extra == '3')
 		init_role = P2P_ROLE_GO;
 
-	if (_FAIL == rtw_p2p_enable(padapter, init_role)) {
-		ret = -EFAULT;
-		goto exit;
-	}
+	ret = rtw_p2p_enable(padapter, init_role);
+	if (ret)
+		return ret;
 
 	/* set channel/bandwidth */
 	if (init_role != P2P_ROLE_DISABLE) {
@@ -2121,8 +2120,7 @@ static int rtw_wext_p2p_enable(struct net_device *dev,
 		set_channel_bwmode(padapter, channel, ch_offset, bwmode);
 	}
 
-exit:
-	return ret;
+	return 0;
 }
 
 static void rtw_p2p_set_go_nego_ssid(struct net_device *dev,
-- 
2.37.1

