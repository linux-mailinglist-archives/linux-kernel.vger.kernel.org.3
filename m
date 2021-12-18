Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0B4479AA6
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 13:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbhLRMEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 07:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbhLRMEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 07:04:47 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B592C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 04:04:47 -0800 (PST)
Received: from dslb-178-004-169-039.178.004.pools.vodafone-ip.de ([178.4.169.39] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1myYSA-0008I6-Tu; Sat, 18 Dec 2021 13:04:42 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/9] staging: r8188: remove the dummy ioctl handler
Date:   Sat, 18 Dec 2021 13:04:16 +0100
Message-Id: <20211218120423.29906-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211218120423.29906-1-martin@kaiser.cx>
References: <20211218120423.29906-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The r8188 driver installs a dummy handler for some unused ioctls. All
that the dummy handler does is return -1.

Remove the dummy handler and let the wext core handle unused ioctls.
This way, user space gets a consistent errno for an unused wext ioctl,
regardless of which driver is used for the interface.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 77728ba78d76..e7f35143dfe1 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -2096,12 +2096,6 @@ static int rtw_wx_priv_null(struct net_device *dev, struct iw_request_info *a,
 	return -1;
 }
 
-static int dummy(struct net_device *dev, struct iw_request_info *a,
-		 union iwreq_data *wrqu, char *b)
-{
-	return -1;
-}
-
 static int rtw_wx_set_channel_plan(struct net_device *dev,
 			       struct iw_request_info *info,
 			       union iwreq_data *wrqu, char *extra)
@@ -4274,26 +4268,19 @@ static int rtw_test(
 
 static iw_handler rtw_handlers[] = {
 	IW_HANDLER(SIOCGIWNAME, rtw_wx_get_name),
-	IW_HANDLER(SIOCSIWNWID, dummy),
-	IW_HANDLER(SIOCGIWNWID, dummy),
 	IW_HANDLER(SIOCGIWFREQ, rtw_wx_get_freq),
 	IW_HANDLER(SIOCSIWMODE, rtw_wx_set_mode),
 	IW_HANDLER(SIOCGIWMODE, rtw_wx_get_mode),
-	IW_HANDLER(SIOCSIWSENS, dummy),
 	IW_HANDLER(SIOCGIWSENS, rtw_wx_get_sens),
 	IW_HANDLER(SIOCGIWRANGE, rtw_wx_get_range),
 	IW_HANDLER(SIOCSIWPRIV, rtw_wx_set_priv),
-	IW_HANDLER(SIOCSIWSPY, dummy),
-	IW_HANDLER(SIOCGIWSPY, dummy),
 	IW_HANDLER(SIOCSIWAP, rtw_wx_set_wap),
 	IW_HANDLER(SIOCGIWAP, rtw_wx_get_wap),
 	IW_HANDLER(SIOCSIWMLME, rtw_wx_set_mlme),
-	IW_HANDLER(SIOCGIWAPLIST, dummy),
 	IW_HANDLER(SIOCSIWSCAN, rtw_wx_set_scan),
 	IW_HANDLER(SIOCGIWSCAN, rtw_wx_get_scan),
 	IW_HANDLER(SIOCSIWESSID, rtw_wx_set_essid),
 	IW_HANDLER(SIOCGIWESSID, rtw_wx_get_essid),
-	IW_HANDLER(SIOCSIWNICKN, dummy),
 	IW_HANDLER(SIOCGIWNICKN, rtw_wx_get_nick),
 	IW_HANDLER(SIOCSIWRATE, rtw_wx_set_rate),
 	IW_HANDLER(SIOCGIWRATE, rtw_wx_get_rate),
@@ -4301,13 +4288,9 @@ static iw_handler rtw_handlers[] = {
 	IW_HANDLER(SIOCGIWRTS, rtw_wx_get_rts),
 	IW_HANDLER(SIOCSIWFRAG, rtw_wx_set_frag),
 	IW_HANDLER(SIOCGIWFRAG, rtw_wx_get_frag),
-	IW_HANDLER(SIOCSIWTXPOW, dummy),
-	IW_HANDLER(SIOCGIWTXPOW, dummy),
-	IW_HANDLER(SIOCSIWRETRY, dummy),
 	IW_HANDLER(SIOCGIWRETRY, rtw_wx_get_retry),
 	IW_HANDLER(SIOCSIWENCODE, rtw_wx_set_enc),
 	IW_HANDLER(SIOCGIWENCODE, rtw_wx_get_enc),
-	IW_HANDLER(SIOCSIWPOWER, dummy),
 	IW_HANDLER(SIOCGIWPOWER, rtw_wx_get_power),
 	IW_HANDLER(SIOCSIWGENIE, rtw_wx_set_gen_ie),
 	IW_HANDLER(SIOCSIWAUTH, rtw_wx_set_auth),
-- 
2.20.1

