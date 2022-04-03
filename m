Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39164F0B60
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 18:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359669AbiDCQ5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 12:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359608AbiDCQ5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 12:57:12 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2793982E
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 09:55:13 -0700 (PDT)
Received: from dslb-094-219-033-178.094.219.pools.vodafone-ip.de ([94.219.33.178] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nb3V8-0008D7-BK; Sun, 03 Apr 2022 18:54:54 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 10/11] staging: r8188eu: don't call get_hdr_bssid
Date:   Sun,  3 Apr 2022 18:54:37 +0200
Message-Id: <20220403165438.357728-11-martin@kaiser.cx>
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

Do not call get_hdr_bssid from validate_recv_data_frame.

We already distinguish between the four cases for to_ds, from_ds. Copy
the bssid address as described in the "DS bit usage" table in
include/linux/ieee80211.h.

Eventually, we should remove get_hdr_bssid (and other similar
driver-specific parsing functions).

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 63ce66489146..e9209785b1c9 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -937,7 +937,6 @@ static int validate_recv_data_frame(struct adapter *adapter,
 				    struct recv_frame *precv_frame)
 {
 	u8 bretry;
-	u8 *pbssid;
 	struct sta_info *psta = NULL;
 	u8 *ptr = precv_frame->rx_data;
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)precv_frame->rx_data;
@@ -947,15 +946,9 @@ static int validate_recv_data_frame(struct adapter *adapter,
 
 	bretry = ieee80211_has_retry(hdr->frame_control);
 
-	pbssid = get_hdr_bssid(ptr);
-	if (!pbssid)
-		return _FAIL;
-
 	memcpy(pattrib->dst, ieee80211_get_DA(hdr), ETH_ALEN);
 	memcpy(pattrib->src, ieee80211_get_SA(hdr), ETH_ALEN);
 
-	memcpy(pattrib->bssid, pbssid, ETH_ALEN);
-
 	/* address4 is used only if both to_ds and from_ds are set */
 	if (ieee80211_has_a4(hdr->frame_control))
 		return _FAIL;
@@ -963,12 +956,16 @@ static int validate_recv_data_frame(struct adapter *adapter,
 	memcpy(pattrib->ra, hdr->addr1, ETH_ALEN);
 	memcpy(pattrib->ta, hdr->addr2, ETH_ALEN);
 
-	if (ieee80211_has_fromds(hdr->frame_control))
+	if (ieee80211_has_fromds(hdr->frame_control)) {
+		memcpy(pattrib->bssid, hdr->addr2, ETH_ALEN);
 		ret = ap2sta_data_frame(adapter, precv_frame, &psta);
-	else if (ieee80211_has_tods(hdr->frame_control))
+	} else if (ieee80211_has_tods(hdr->frame_control)) {
+		memcpy(pattrib->bssid, hdr->addr1, ETH_ALEN);
 		ret = sta2ap_data_frame(adapter, precv_frame, &psta);
-	else
+	} else {
+		memcpy(pattrib->bssid, hdr->addr3, ETH_ALEN);
 		ret = sta2sta_data_frame(adapter, precv_frame, &psta);
+	}
 
 	if (ret == _FAIL || ret == RTW_RX_HANDLED)
 		return ret;
-- 
2.30.2

