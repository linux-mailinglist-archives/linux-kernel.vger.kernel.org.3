Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C263468BA5
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 16:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235449AbhLEPQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 10:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235363AbhLEPQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 10:16:44 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48759C0613F8
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 07:13:17 -0800 (PST)
Received: from dslb-188-097-212-203.188.097.pools.vodafone-ip.de ([188.97.212.203] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mttCT-0007gF-GZ; Sun, 05 Dec 2021 16:13:13 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 08/10] staging: r8188eu: remove two write-only wifi direct variables
Date:   Sun,  5 Dec 2021 16:12:49 +0100
Message-Id: <20211205151251.6861-9-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211205151251.6861-1-martin@kaiser.cx>
References: <20211205151251.6861-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove two variables related to wifidirect which are set but not used.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_p2p.c     |  3 ---
 drivers/staging/r8188eu/include/rtw_mlme.h | 12 ------------
 2 files changed, 15 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
index b265b5e46851..315a9e6c5cd3 100644
--- a/drivers/staging/r8188eu/core/rtw_p2p.c
+++ b/drivers/staging/r8188eu/core/rtw_p2p.c
@@ -1806,8 +1806,6 @@ void reset_global_wifidirect_info(struct adapter *padapter)
 	pwdinfo = &padapter->wdinfo;
 	pwdinfo->persistent_supported = 0;
 	pwdinfo->session_available = true;
-	pwdinfo->wfd_tdls_enable = 0;
-	pwdinfo->wfd_tdls_weaksec = 0;
 }
 
 void rtw_init_wifidirect_timers(struct adapter *padapter)
@@ -1912,7 +1910,6 @@ void init_wifidirect_info(struct adapter *padapter, enum P2P_ROLE role)
 	memset(pwdinfo->rx_prov_disc_info.strconfig_method_desc_of_prov_disc_req, 0x00, 4);
 	memset(pwdinfo->rx_prov_disc_info.strconfig_method_desc_of_prov_disc_req, '0', 3);
 	memset(&pwdinfo->groupid_info, 0x00, sizeof(struct group_id_info));
-	pwdinfo->wfd_tdls_enable = 0;
 	memset(pwdinfo->p2p_peer_interface_addr, 0x00, ETH_ALEN);
 	memset(pwdinfo->p2p_peer_device_addr, 0x00, ETH_ALEN);
 
diff --git a/drivers/staging/r8188eu/include/rtw_mlme.h b/drivers/staging/r8188eu/include/rtw_mlme.h
index e8d51f495702..77169c15080a 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme.h
@@ -243,18 +243,6 @@ struct wifidirect_info {
 	 * by using the sta_preset CAPI. */
 	/*	0: disable */
 	/*	1: enable */
-	u8 wfd_tdls_enable; /* Flag to enable or disable the TDLS by WFD Sigma*/
-			    /* 0: disable */
-			    /*	1: enable */
-	u8 wfd_tdls_weaksec; /* Flag to enable or disable the weak security
-			      * function for TDLS by WFD Sigma */
-			     /* 0: disable */
-			     /* In this case, the driver can't issue the tdsl
-			      * setup request frame. */
-			     /*	1: enable */
-			     /* In this case, the driver can issue the tdls
-			      * setup request frame */
-			     /*	even the current security is weak security. */
 
 	/* This field will store the WPS value (PIN value or PBC) that UI had
 	 * got from the user. */
-- 
2.20.1

