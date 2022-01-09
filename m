Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA91A488CB7
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 22:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237258AbiAIVyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 16:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbiAIVyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 16:54:35 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9A9C06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 13:54:34 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id q8so23168191wra.12
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 13:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vdq1YRATZXZW2zTmJrFcNBwG86kVUBqymJ+QklrHyQY=;
        b=gv/eMrPNGoJxfFDDr+alQE/D+5aLkbxcJNLkK4YWX8UDGNdJ4k7poYXy18d2nrkdQS
         RTYAwoVFeG+gKq78kdCsctxjoq6t2hy6FoNEjiXwIjOYa59jdy4KSw5rk/6rDb5g6QYz
         whCeJ042WBl4BbrVwPrVCCRULFicOZGczziQ/FEMTwoFVf+8V1Kqgxs7/B5CsiAqcz+I
         oGpR8pb9n77OOXHlqPQdIM9UzD/GMoEnqH9eo0V8uRBoPD+7VTJoIuZWYHofCe5hq7ks
         EBjBntojRj4/rA76IYCgSURnoJY570k6rqG4WUYnnqswOscaZv8JcUjRQAKaU5r/WbP1
         OuSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vdq1YRATZXZW2zTmJrFcNBwG86kVUBqymJ+QklrHyQY=;
        b=vXQQ484FBMmzoe72nngKnasONFpvPVH6ndn7Sze6RzUTEP4xFhJrpo37IlHc7wxBmG
         nBjVNITI98d17p7UBR5+ijSwZwLduavf4UVCRTlD5d8FRsYukkdytoYbRCmSS2Et6K+J
         xrSJToHdLKBR3nV1HkbZqH5bXeGp0oETfiZObeeHbpMxmc/nfn0BZmX9zinfGz554msZ
         YMLqGFU9kVU5Mg1Zmoc+/ZYxM0vENxK2Y7N9icjS7YJfMhCUYB0Cyh1rjblFxiUBu7xt
         ECNwC7ZO3kM4LI2uIAf3QhKI4O9QDvyihghzF11xSL1CsnjV5bUEUhFPLni43eg8uSGK
         5hzQ==
X-Gm-Message-State: AOAM5330ot63Zuadcj15LurM79f/30oDjQvQ3THyoIFS+3/SPi6TD6pb
        R6BixH7XIJPlURF0/OUvJcAQkw==
X-Google-Smtp-Source: ABdhPJxUpUmT5MbLA5YoZ7kD2mSLR+NDmKiRNWUKB6301WvAE03Ywl4Vx2fqSE4IOYlCkgCdqXzRTg==
X-Received: by 2002:adf:f303:: with SMTP id i3mr2467096wro.413.1641765273222;
        Sun, 09 Jan 2022 13:54:33 -0800 (PST)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id r13sm5065650wmq.28.2022.01.09.13.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 13:54:32 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] staging: r8188eu: convert DBG_88E calls in core/rtw_ioctl_set.c
Date:   Sun,  9 Jan 2022 21:54:25 +0000
Message-Id: <20220109215427.887-6-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220109215427.887-1-phil@philpotter.co.uk>
References: <20220109215427.887-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the DBG_88E macro calls in core/rtw_ioctl_set.c to use netdev_dbg,
as their information may be useful to observers, and this gets the
driver closer to the point of being able to remove DBG_88E itself.
Also remove one unnecessary DBG_88E call which was already commented
out.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_ioctl_set.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
index eadfbdb94dd5..c95ca471ae55 100644
--- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
@@ -122,7 +122,8 @@ u8 rtw_set_802_11_bssid(struct adapter *padapter, u8 *bssid)
 
 	spin_lock_bh(&pmlmepriv->lock);
 
-	DBG_88E("Set BSSID under fw_state = 0x%08x\n", get_fwstate(pmlmepriv));
+	netdev_dbg(padapter->pnetdev, "Set BSSID under fw_state = 0x%08x\n",
+		   get_fwstate(pmlmepriv));
 	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY))
 		goto handle_tkip_countermeasure;
 	else if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING))
@@ -195,7 +196,8 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
 
 	spin_lock_bh(&pmlmepriv->lock);
 
-	DBG_88E("Set SSID under fw_state = 0x%08x\n", get_fwstate(pmlmepriv));
+	netdev_dbg(padapter->pnetdev, "Set SSID under fw_state = 0x%08x\n",
+		   get_fwstate(pmlmepriv));
 	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY)) {
 		goto handle_tkip_countermeasure;
 	} else if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING)) {
@@ -280,8 +282,6 @@ u8 rtw_set_802_11_infrastructure_mode(struct adapter *padapter,
 	if (*pold_state != networktype) {
 		spin_lock_bh(&pmlmepriv->lock);
 
-		/* DBG_88E("change mode, old_mode =%d, new_mode =%d, fw_state = 0x%x\n", *pold_state, networktype, get_fwstate(pmlmepriv)); */
-
 		if (*pold_state == Ndis802_11APMode) {
 			/* change to other mode from Ndis802_11APMode */
 			cur_network->join_res = -1;
@@ -364,7 +364,7 @@ u8 rtw_set_802_11_bssid_list_scan(struct adapter *padapter, struct ndis_802_11_s
 		res = true;
 	} else {
 		if (rtw_is_scan_deny(padapter)) {
-			DBG_88E(FUNC_ADPT_FMT": scan deny\n", FUNC_ADPT_ARG(padapter));
+			netdev_dbg(padapter->pnetdev, "scan deny\n");
 			indicate_wx_scan_complete_event(padapter);
 			return _SUCCESS;
 		}
-- 
2.33.1

