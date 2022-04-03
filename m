Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B17F4F0B61
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 18:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359538AbiDCQ4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 12:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235645AbiDCQ4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 12:56:48 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E98B39172
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 09:54:54 -0700 (PDT)
Received: from dslb-094-219-033-178.094.219.pools.vodafone-ip.de ([94.219.33.178] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nb3V3-0008D7-Jp; Sun, 03 Apr 2022 18:54:49 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 04/11] staging: r8188eu: simplify error handling
Date:   Sun,  3 Apr 2022 18:54:31 +0200
Message-Id: <20220403165438.357728-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220403165438.357728-1-martin@kaiser.cx>
References: <20220403165438.357728-1-martin@kaiser.cx>
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

Simplify the error handling in validate_recv_data_frame. The function does
not have to do any cleanup for errors, we can return immediately.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 33 +++++++++----------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index c75b0592a63d..200d8c6c6e11 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -943,17 +943,15 @@ static int validate_recv_data_frame(struct adapter *adapter,
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)precv_frame->rx_data;
 	struct rx_pkt_attrib	*pattrib = &precv_frame->attrib;
 	struct security_priv	*psecuritypriv = &adapter->securitypriv;
-	int ret = _SUCCESS;
+	int ret;
 
 	bretry = ieee80211_has_retry(hdr->frame_control);
 	pda = ieee80211_get_DA(hdr);
 	psa = ieee80211_get_SA(hdr);
-	pbssid = get_hdr_bssid(ptr);
 
-	if (!pbssid) {
-		ret = _FAIL;
-		goto exit;
-	}
+	pbssid = get_hdr_bssid(ptr);
+	if (!pbssid)
+		return _FAIL;
 
 	memcpy(pattrib->dst, pda, ETH_ALEN);
 	memcpy(pattrib->src, psa, ETH_ALEN);
@@ -986,16 +984,11 @@ static int validate_recv_data_frame(struct adapter *adapter,
 		break;
 	}
 
-	if (ret == _FAIL) {
-		goto exit;
-	} else if (ret == RTW_RX_HANDLED) {
-		goto exit;
-	}
+	if (ret == _FAIL || ret == RTW_RX_HANDLED)
+		return ret;
 
-	if (!psta) {
-		ret = _FAIL;
-		goto exit;
-	}
+	if (!psta)
+		return _FAIL;
 
 	/* psta->rssi = prxcmd->rssi; */
 	/* psta->signal_quality = prxcmd->sq; */
@@ -1023,10 +1016,8 @@ static int validate_recv_data_frame(struct adapter *adapter,
 	precv_frame->preorder_ctrl = &psta->recvreorder_ctrl[pattrib->priority];
 
 	/*  decache, drop duplicate recv packets */
-	if (recv_decache(precv_frame, bretry, &psta->sta_recvpriv.rxcache) == _FAIL) {
-		ret = _FAIL;
-		goto exit;
-	}
+	if (recv_decache(precv_frame, bretry, &psta->sta_recvpriv.rxcache) == _FAIL)
+		return _FAIL;
 
 	if (pattrib->privacy) {
 		GET_ENCRY_ALGO(psecuritypriv, psta, pattrib->encrypt, is_multicast_ether_addr(pattrib->ra));
@@ -1038,9 +1029,7 @@ static int validate_recv_data_frame(struct adapter *adapter,
 		pattrib->icv_len = 0;
 	}
 
-exit:
-
-	return ret;
+	return _SUCCESS;
 }
 
 static int validate_recv_frame(struct adapter *adapter, struct recv_frame *precv_frame)
-- 
2.30.2

