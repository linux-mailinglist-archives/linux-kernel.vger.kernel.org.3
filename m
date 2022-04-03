Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E794F0B4F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 18:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359471AbiDCQrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 12:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356397AbiDCQrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 12:47:43 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E06438DA5
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 09:45:49 -0700 (PDT)
Received: from dslb-094-219-033-178.094.219.pools.vodafone-ip.de ([94.219.33.178] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nb3MC-00085T-2k; Sun, 03 Apr 2022 18:45:40 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/5] staging: r8188eu: make validate_recv_ctrl_frame return void
Date:   Sun,  3 Apr 2022 18:45:22 +0200
Message-Id: <20220403164526.357371-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220403164526.357371-1-martin@kaiser.cx>
References: <20220403164526.357371-1-martin@kaiser.cx>
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

Make validate_recv_ctrl_frame return void.

At the moment, the function always returns _FAIL, the caller does not
check the return value.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 1a79c3f46bbf..931bd81b0886 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -795,8 +795,8 @@ static int sta2ap_data_frame(struct adapter *adapter,
 	return ret;
 }
 
-static int validate_recv_ctrl_frame(struct adapter *padapter,
-				    struct recv_frame *precv_frame)
+static void validate_recv_ctrl_frame(struct adapter *padapter,
+				     struct recv_frame *precv_frame)
 {
 	struct rx_pkt_attrib *pattrib = &precv_frame->attrib;
 	struct sta_priv *pstapriv = &padapter->stapriv;
@@ -805,11 +805,11 @@ static int validate_recv_ctrl_frame(struct adapter *padapter,
 	/* uint len = precv_frame->len; */
 
 	if (!ieee80211_is_ctl(fc))
-		return _FAIL;
+		return;
 
 	/* receive the frames that ra(a1) is my address */
 	if (memcmp(GetAddr1Ptr(pframe), myid(&padapter->eeprompriv), ETH_ALEN))
-		return _FAIL;
+		return;
 
 	/* only handle ps-poll */
 	if (GetFrameSubType(pframe) == WIFI_PSPOLL) {
@@ -821,7 +821,7 @@ static int validate_recv_ctrl_frame(struct adapter *padapter,
 		psta = rtw_get_stainfo(pstapriv, GetAddr2Ptr(pframe));
 
 		if (!psta || psta->aid != aid)
-			return _FAIL;
+			return;
 
 		/* for rx pkt statistics */
 		psta->sta_stats.rx_ctrl_pkts++;
@@ -847,7 +847,7 @@ static int validate_recv_ctrl_frame(struct adapter *padapter,
 		}
 
 		if (wmmps_ac)
-			return _FAIL;
+			return;
 
 		if (psta->state & WIFI_STA_ALIVE_CHK_STATE) {
 			psta->expire_to = pstapriv->expire_to;
@@ -905,8 +905,6 @@ static int validate_recv_ctrl_frame(struct adapter *padapter,
 			spin_unlock_bh(&pxmitpriv->lock);
 		}
 	}
-
-	return _FAIL;
 }
 
 struct recv_frame *recvframe_chk_defrag(struct adapter *padapter, struct recv_frame *precv_frame);
-- 
2.30.2

