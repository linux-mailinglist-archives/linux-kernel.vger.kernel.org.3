Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EB35177BF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 22:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387256AbiEBULO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 16:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387197AbiEBUKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 16:10:54 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E7CDF0D
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 13:07:20 -0700 (PDT)
Received: from ipservice-092-217-077-109.092.217.pools.vodafone-ip.de ([92.217.77.109] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nlcKC-0007ch-SC; Mon, 02 May 2022 22:07:17 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 8/9] staging: r8188eu: use standard category defines
Date:   Mon,  2 May 2022 22:06:51 +0200
Message-Id: <20220502200652.143665-9-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220502200652.143665-1-martin@kaiser.cx>
References: <20220502200652.143665-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace some of the driver-specific defines for action categories with the
defines from ieee80211.h.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 24 ++++++++++-----------
 drivers/staging/r8188eu/core/rtw_p2p.c      |  4 ++--
 drivers/staging/r8188eu/include/ieee80211.h |  2 --
 3 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 96b0da90c2ba..848b5051aa13 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -1494,7 +1494,7 @@ unsigned int OnAction_back(struct adapter *padapter, struct recv_frame *precv_fr
 	frame_body = (unsigned char *)(pframe + sizeof(struct ieee80211_hdr_3addr));
 
 	category = frame_body[0];
-	if (category == RTW_WLAN_CATEGORY_BACK) { /*  representing Block Ack */
+	if (category == WLAN_CATEGORY_BACK) { /*  representing Block Ack */
 		if (!pmlmeinfo->HT_enable)
 			return _SUCCESS;
 		action = frame_body[1];
@@ -1551,7 +1551,7 @@ static int get_reg_classes_full_count(struct p2p_channels *channel_list)
 
 void issue_p2p_GO_request(struct adapter *padapter, u8 *raddr)
 {
-	unsigned char category = RTW_WLAN_CATEGORY_PUBLIC;
+	unsigned char category = WLAN_CATEGORY_PUBLIC;
 	u8 action = P2P_PUB_ACTION_ACTION;
 	__be32 p2poui = cpu_to_be32(P2POUI);
 	u8 oui_subtype = P2P_GO_NEGO_REQ;
@@ -1881,7 +1881,7 @@ void issue_p2p_GO_request(struct adapter *padapter, u8 *raddr)
 
 static void issue_p2p_GO_response(struct adapter *padapter, u8 *raddr, u8 *frame_body, uint len, u8 result)
 {
-	unsigned char category = RTW_WLAN_CATEGORY_PUBLIC;
+	unsigned char category = WLAN_CATEGORY_PUBLIC;
 	u8 action = P2P_PUB_ACTION_ACTION;
 	__be32			p2poui = cpu_to_be32(P2POUI);
 	u8 oui_subtype = P2P_GO_NEGO_RESP;
@@ -2243,7 +2243,7 @@ static void issue_p2p_GO_response(struct adapter *padapter, u8 *raddr, u8 *frame
 
 static void issue_p2p_GO_confirm(struct adapter *padapter, u8 *raddr, u8 result)
 {
-	unsigned char category = RTW_WLAN_CATEGORY_PUBLIC;
+	unsigned char category = WLAN_CATEGORY_PUBLIC;
 	u8 action = P2P_PUB_ACTION_ACTION;
 	__be32			p2poui = cpu_to_be32(P2POUI);
 	u8 oui_subtype = P2P_GO_NEGO_CONF;
@@ -2404,7 +2404,7 @@ static void issue_p2p_GO_confirm(struct adapter *padapter, u8 *raddr, u8 result)
 
 void issue_p2p_invitation_request(struct adapter *padapter, u8 *raddr)
 {
-	unsigned char category = RTW_WLAN_CATEGORY_PUBLIC;
+	unsigned char category = WLAN_CATEGORY_PUBLIC;
 	u8 action = P2P_PUB_ACTION_ACTION;
 	__be32			p2poui = cpu_to_be32(P2POUI);
 	u8 oui_subtype = P2P_INVIT_REQ;
@@ -2651,7 +2651,7 @@ void issue_p2p_invitation_request(struct adapter *padapter, u8 *raddr)
 
 void issue_p2p_invitation_response(struct adapter *padapter, u8 *raddr, u8 dialogToken, u8 status_code)
 {
-	unsigned char category = RTW_WLAN_CATEGORY_PUBLIC;
+	unsigned char category = WLAN_CATEGORY_PUBLIC;
 	u8 action = P2P_PUB_ACTION_ACTION;
 	__be32			p2poui = cpu_to_be32(P2POUI);
 	u8 oui_subtype = P2P_INVIT_RESP;
@@ -2841,7 +2841,7 @@ void issue_p2p_invitation_response(struct adapter *padapter, u8 *raddr, u8 dialo
 
 void issue_p2p_provision_request(struct adapter *padapter, u8 *pssid, u8 ussidlen, u8 *pdev_raddr)
 {
-	unsigned char category = RTW_WLAN_CATEGORY_PUBLIC;
+	unsigned char category = WLAN_CATEGORY_PUBLIC;
 	u8 action = P2P_PUB_ACTION_ACTION;
 	u8 dialogToken = 1;
 	u8 oui_subtype = P2P_PROVISION_DISC_REQ;
@@ -3812,7 +3812,7 @@ unsigned int on_action_public(struct adapter *padapter, struct recv_frame *precv
 		goto exit;
 
 	category = frame_body[0];
-	if (category != RTW_WLAN_CATEGORY_PUBLIC)
+	if (category != WLAN_CATEGORY_PUBLIC)
 		goto exit;
 
 	action = frame_body[1];
@@ -3874,10 +3874,10 @@ unsigned int OnAction(struct adapter *padapter, struct recv_frame *precv_frame)
 	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)precv_frame->rx_data;
 
 	switch (mgmt->u.action.category) {
-	case RTW_WLAN_CATEGORY_BACK:
+	case WLAN_CATEGORY_BACK:
 		OnAction_back(padapter, precv_frame);
 		break;
-	case RTW_WLAN_CATEGORY_PUBLIC:
+	case WLAN_CATEGORY_PUBLIC:
 		on_action_public(padapter, precv_frame);
 		break;
 	case RTW_WLAN_CATEGORY_P2P:
@@ -5370,7 +5370,7 @@ int issue_deauth_ex(struct adapter *padapter, u8 *da, unsigned short reason, int
 
 void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned char action, unsigned short status)
 {
-	u8 category = RTW_WLAN_CATEGORY_BACK;
+	u8 category = WLAN_CATEGORY_BACK;
 	u16 start_seq;
 	u16 BA_para_set;
 	u16 reason_code;
@@ -5504,7 +5504,7 @@ static void issue_action_BSSCoexistPacket(struct adapter *padapter)
 	if (pmlmeinfo->bwmode_updated)
 		return;
 
-	category = RTW_WLAN_CATEGORY_PUBLIC;
+	category = WLAN_CATEGORY_PUBLIC;
 	action = ACT_PUBLIC_BSSCOEXIST;
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
index fadacef44813..59bb1bd12d59 100644
--- a/drivers/staging/r8188eu/core/rtw_p2p.c
+++ b/drivers/staging/r8188eu/core/rtw_p2p.c
@@ -171,7 +171,7 @@ static void issue_p2p_devdisc_resp(struct wifidirect_info *pwdinfo, u8 *da, u8 s
 	struct adapter *padapter = pwdinfo->padapter;
 	struct xmit_priv			*pxmitpriv = &padapter->xmitpriv;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	unsigned char category = RTW_WLAN_CATEGORY_PUBLIC;
+	unsigned char category = WLAN_CATEGORY_PUBLIC;
 	u8			action = P2P_PUB_ACTION_ACTION;
 	__be32			p2poui = cpu_to_be32(P2POUI);
 	u8			oui_subtype = P2P_DEVDISC_RESP;
@@ -233,7 +233,7 @@ static void issue_p2p_devdisc_resp(struct wifidirect_info *pwdinfo, u8 *da, u8 s
 static void issue_p2p_provision_resp(struct wifidirect_info *pwdinfo, u8 *raddr, u8 *frame_body, u16 config_method)
 {
 	struct adapter *padapter = pwdinfo->padapter;
-	unsigned char category = RTW_WLAN_CATEGORY_PUBLIC;
+	unsigned char category = WLAN_CATEGORY_PUBLIC;
 	u8			action = P2P_PUB_ACTION_ACTION;
 	u8			dialogToken = frame_body[7];	/*	The Dialog Token of provisioning discovery request frame. */
 	__be32			p2poui = cpu_to_be32(P2POUI);
diff --git a/drivers/staging/r8188eu/include/ieee80211.h b/drivers/staging/r8188eu/include/ieee80211.h
index c593f9278868..4d3e89939114 100644
--- a/drivers/staging/r8188eu/include/ieee80211.h
+++ b/drivers/staging/r8188eu/include/ieee80211.h
@@ -596,8 +596,6 @@ static inline int is_broadcast_mac_addr(const u8 *addr)
 
 /* Action category code */
 enum rtw_ieee80211_category {
-	RTW_WLAN_CATEGORY_BACK = 3,
-	RTW_WLAN_CATEGORY_PUBLIC = 4, /* IEEE 802.11 public action frames */
 	RTW_WLAN_CATEGORY_P2P = 0x7f,/* P2P action frames */
 };
 
-- 
2.30.2

