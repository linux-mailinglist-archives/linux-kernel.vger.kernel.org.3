Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F8F4F0B66
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 18:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359582AbiDCQ5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 12:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359574AbiDCQ5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 12:57:02 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5460B393D8
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 09:55:04 -0700 (PDT)
Received: from dslb-094-219-033-178.094.219.pools.vodafone-ip.de ([94.219.33.178] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nb3V9-0008D7-AI; Sun, 03 Apr 2022 18:54:55 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 11/11] staging: r8188eu: remove the bretry variable
Date:   Sun,  3 Apr 2022 18:54:38 +0200
Message-Id: <20220403165438.357728-12-martin@kaiser.cx>
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

Remove the bretry variable. It's set and used only once. Call the
ieee80211 helper directly.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index e9209785b1c9..91a6e0f035f4 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -936,7 +936,6 @@ static void validate_recv_mgnt_frame(struct adapter *padapter,
 static int validate_recv_data_frame(struct adapter *adapter,
 				    struct recv_frame *precv_frame)
 {
-	u8 bretry;
 	struct sta_info *psta = NULL;
 	u8 *ptr = precv_frame->rx_data;
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)precv_frame->rx_data;
@@ -944,8 +943,6 @@ static int validate_recv_data_frame(struct adapter *adapter,
 	struct security_priv	*psecuritypriv = &adapter->securitypriv;
 	int ret;
 
-	bretry = ieee80211_has_retry(hdr->frame_control);
-
 	memcpy(pattrib->dst, ieee80211_get_DA(hdr), ETH_ALEN);
 	memcpy(pattrib->src, ieee80211_get_SA(hdr), ETH_ALEN);
 
@@ -999,7 +996,8 @@ static int validate_recv_data_frame(struct adapter *adapter,
 	precv_frame->preorder_ctrl = &psta->recvreorder_ctrl[pattrib->priority];
 
 	/*  decache, drop duplicate recv packets */
-	if (recv_decache(precv_frame, bretry, &psta->sta_recvpriv.rxcache) == _FAIL)
+	if (recv_decache(precv_frame, ieee80211_has_retry(hdr->frame_control),
+			 &psta->sta_recvpriv.rxcache) == _FAIL)
 		return _FAIL;
 
 	if (pattrib->privacy) {
-- 
2.30.2

