Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4ED850478D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 12:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbiDQKZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 06:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbiDQKZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 06:25:12 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB92C27FEF
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 03:22:37 -0700 (PDT)
Received: from dslb-188-096-140-061.188.096.pools.vodafone-ip.de ([188.96.140.61] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1ng237-0002FP-Jp; Sun, 17 Apr 2022 12:22:33 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 4/6] staging: r8188eu: replace mlme_handler with function pointer
Date:   Sun, 17 Apr 2022 12:22:19 +0200
Message-Id: <20220417102221.466524-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220417102221.466524-1-martin@kaiser.cx>
References: <20220417102221.466524-1-martin@kaiser.cx>
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

mlme_sta_tbl is an array of struct mlme_handler. mlme_handler's num and
str components are not used. The code in mgt_dispatcher uses the subtype
number of the incoming frame to select the array entry for compiling the
repsonse.

We can remove struct mlme_handler and make mlme_sta_tbl an array of
function pointers.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 49 +++++++++----------
 .../staging/r8188eu/include/rtw_mlme_ext.h    |  6 +--
 2 files changed, 23 insertions(+), 32 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 77a14f55b743..492f481b61ec 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -14,25 +14,22 @@
 #include "../include/rtl8188e_xmit.h"
 #include "../include/rtl8188e_dm.h"
 
-static struct mlme_handler mlme_sta_tbl[] = {
-	{WIFI_ASSOCREQ,		"OnAssocReq",	&OnAssocReq},
-	{WIFI_ASSOCRSP,		"OnAssocRsp",	&OnAssocRsp},
-	{WIFI_REASSOCREQ,	"OnReAssocReq",	&OnAssocReq},
-	{WIFI_REASSOCRSP,	"OnReAssocRsp",	&OnAssocRsp},
-	{WIFI_PROBEREQ,		"OnProbeReq",	&OnProbeReq},
-	{WIFI_PROBERSP,		"OnProbeRsp",		&OnProbeRsp},
-
-	/*----------------------------------------------------------
-					below 2 are reserved
-	-----------------------------------------------------------*/
-	{0,					"DoReserved",		&DoReserved},
-	{0,					"DoReserved",		&DoReserved},
-	{WIFI_BEACON,		"OnBeacon",		&OnBeacon},
-	{WIFI_ATIM,			"OnATIM",		&OnAtim},
-	{WIFI_DISASSOC,		"OnDisassoc",		&OnDisassoc},
-	{WIFI_AUTH,			"OnAuth",		&OnAuthClient},
-	{WIFI_DEAUTH,		"OnDeAuth",		&OnDeAuth},
-	{WIFI_ACTION,		"OnAction",		&OnAction},
+/* response function for each management frame subtype, do not reorder */
+static mlme_handler mlme_sta_tbl[] = {
+	OnAssocReq,
+	OnAssocRsp,
+	OnAssocReq,
+	OnAssocRsp,
+	OnProbeReq,
+	OnProbeRsp,
+	DoReserved,
+	DoReserved,
+	OnBeacon,
+	OnAtim,
+	OnDisassoc,
+	OnAuthClient,
+	OnDeAuth,
+	OnAction,
 };
 
 static struct action_handler OnAction_tbl[] = {
@@ -393,7 +390,7 @@ void free_mlme_ext_priv(struct mlme_ext_priv *pmlmeext)
 void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
 {
 	int index;
-	struct mlme_handler *ptable;
+	mlme_handler fct;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)precv_frame->rx_data;
 	struct sta_info *psta = rtw_get_stainfo(&padapter->stapriv, hdr->addr2);
@@ -406,12 +403,10 @@ void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
 	    !is_broadcast_ether_addr(hdr->addr1))
 		return;
 
-	ptable = mlme_sta_tbl;
-
 	index = (le16_to_cpu(hdr->frame_control) & IEEE80211_FCTL_STYPE) >> 4;
 	if (index > 13)
 		return;
-	ptable += index;
+	fct = mlme_sta_tbl[index];
 
 	if (psta) {
 		if (ieee80211_has_retry(hdr->frame_control)) {
@@ -424,13 +419,13 @@ void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
 
 	if (ieee80211_is_auth(hdr->frame_control)) {
 		if (check_fwstate(pmlmepriv, WIFI_AP_STATE))
-			ptable->func = &OnAuth;
+			fct = OnAuth;
 		else
-			ptable->func = &OnAuthClient;
+			fct = OnAuthClient;
 	}
 
-	if (ptable->func)
-		ptable->func(padapter, precv_frame);
+	if (fct)
+		fct(padapter, precv_frame);
 }
 
 static u32 p2p_listen_state_process(struct adapter *padapter, unsigned char *da)
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index 0875472dbb72..dcf91e7894a5 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -184,11 +184,7 @@ enum SCAN_STATE {
 	SCAN_STATE_MAX,
 };
 
-struct mlme_handler {
-	unsigned int   num;
-	char *str;
-	unsigned int (*func)(struct adapter *adapt, struct recv_frame *frame);
-};
+typedef unsigned int (*mlme_handler)(struct adapter *adapt, struct recv_frame *frame);
 
 struct action_handler {
 	unsigned int   num;
-- 
2.30.2

