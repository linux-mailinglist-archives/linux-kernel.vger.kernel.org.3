Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E816B4FFFC7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 22:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238634AbiDMUKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 16:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238305AbiDMUKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 16:10:16 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5A27D015
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 13:07:54 -0700 (PDT)
Received: from dslb-178-004-174-121.178.004.pools.vodafone-ip.de ([178.4.174.121] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nejHL-0005wN-BK; Wed, 13 Apr 2022 22:07:51 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/4] staging: r8188eu: use ieee80211 helpers in mgt_dispatcher
Date:   Wed, 13 Apr 2022 22:07:41 +0200
Message-Id: <20220413200742.276806-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220413200742.276806-1-martin@kaiser.cx>
References: <20220413200742.276806-1-martin@kaiser.cx>
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

Use structs and functions from ieee80211.h in mgt_dispatcher to parse
the incoming frame.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index ba071de4c05c..b6ee6a24930a 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -396,14 +396,15 @@ void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
 	struct mlme_handler *ptable;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	u8 *pframe = precv_frame->rx_data;
-	struct sta_info *psta = rtw_get_stainfo(&padapter->stapriv, GetAddr2Ptr(pframe));
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)precv_frame->rx_data;
+	struct sta_info *psta = rtw_get_stainfo(&padapter->stapriv, hdr->addr2);
 
-	if (GetFrameType(pframe) != IEEE80211_FTYPE_MGMT)
+	if (!ieee80211_is_mgmt(hdr->frame_control))
 		return;
 
 	/* receive the frames that ra(a1) is my address or ra(a1) is bc address. */
-	if (memcmp(GetAddr1Ptr(pframe), myid(&padapter->eeprompriv), ETH_ALEN) &&
-	    !is_broadcast_ether_addr(GetAddr1Ptr(pframe)))
+	if (memcmp(hdr->addr1, myid(&padapter->eeprompriv), ETH_ALEN) &&
+	    !is_broadcast_ether_addr(hdr->addr1))
 		return;
 
 	ptable = mlme_sta_tbl;
@@ -415,7 +416,7 @@ void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
 	ptable += index;
 
 	if (psta) {
-		if (GetRetry(pframe)) {
+		if (ieee80211_has_retry(hdr->frame_control)) {
 			if (precv_frame->attrib.seq_num == psta->RxMgmtFrameSeqNum)
 				/* drop the duplicate management frame */
 				return;
@@ -423,7 +424,7 @@ void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
 		psta->RxMgmtFrameSeqNum = precv_frame->attrib.seq_num;
 	}
 
-	if (GetFrameSubType(pframe) == WIFI_AUTH) {
+	if (ieee80211_is_auth(hdr->frame_control)) {
 		if (check_fwstate(pmlmepriv, WIFI_AP_STATE))
 			ptable->func = &OnAuth;
 		else
@@ -432,8 +433,8 @@ void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
 
 	if (ptable->func) {
 	/* receive the frames that ra(a1) is my address or ra(a1) is bc address. */
-		if (memcmp(GetAddr1Ptr(pframe), myid(&padapter->eeprompriv), ETH_ALEN) &&
-		    !is_broadcast_ether_addr(GetAddr1Ptr(pframe)))
+		if (memcmp(hdr->addr1, myid(&padapter->eeprompriv), ETH_ALEN) &&
+		    !is_broadcast_ether_addr(hdr->addr1))
 			return;
 		ptable->func(padapter, precv_frame);
 	}
-- 
2.30.2

