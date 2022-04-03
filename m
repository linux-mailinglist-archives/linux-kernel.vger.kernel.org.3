Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C842C4F0B6B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 18:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359573AbiDCQ5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 12:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359583AbiDCQ52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 12:57:28 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700CC3A5DA
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 09:55:21 -0700 (PDT)
Received: from dslb-094-219-033-178.094.219.pools.vodafone-ip.de ([94.219.33.178] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nb3V5-0008D7-UZ; Sun, 03 Apr 2022 18:54:52 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 07/11] staging: r8188eu: remove to_fr_ds from struct rx_pkt_attrib
Date:   Sun,  3 Apr 2022 18:54:34 +0200
Message-Id: <20220403165438.357728-8-martin@kaiser.cx>
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

to_fr_ds in struct rx_pkt_attrib stores the values of the to_ds and
from_ds bits of an incoming data frame. to_fr_ds is set by parsing the
frame control bytes and it's used only in validate_recv_data_frame.

Remove to_fr_ds from struct rx_pkt_attrib and use the ieee80211 helpers
to distinguish between the four different cases for to_ds, from_ds.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_recv.c    | 26 +++++++++-------------
 drivers/staging/r8188eu/include/rtw_recv.h |  1 -
 drivers/staging/r8188eu/include/wifi.h     |  2 --
 3 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index c200e1251545..0098f3de31d7 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -958,25 +958,22 @@ static int validate_recv_data_frame(struct adapter *adapter,
 
 	memcpy(pattrib->bssid, pbssid, ETH_ALEN);
 
-	switch (pattrib->to_fr_ds) {
-	case 0:
-		memcpy(pattrib->ra, pda, ETH_ALEN);
-		memcpy(pattrib->ta, psa, ETH_ALEN);
-		ret = sta2sta_data_frame(adapter, precv_frame, &psta);
-		break;
-	case 1:
+	/* address4 is used only if both to_ds and from_ds are set */
+	if (ieee80211_has_a4(hdr->frame_control))
+		return _FAIL;
+
+	if (ieee80211_has_fromds(hdr->frame_control)) {
 		memcpy(pattrib->ra, pda, ETH_ALEN);
 		memcpy(pattrib->ta, pbssid, ETH_ALEN);
 		ret = ap2sta_data_frame(adapter, precv_frame, &psta);
-		break;
-	case 2:
+	} else if (ieee80211_has_tods(hdr->frame_control)) {
 		memcpy(pattrib->ra, pbssid, ETH_ALEN);
 		memcpy(pattrib->ta, psa, ETH_ALEN);
 		ret = sta2ap_data_frame(adapter, precv_frame, &psta);
-		break;
-	default:
-		ret = _FAIL;
-		break;
+	} else {
+		memcpy(pattrib->ra, pda, ETH_ALEN);
+		memcpy(pattrib->ta, psa, ETH_ALEN);
+		ret = sta2sta_data_frame(adapter, precv_frame, &psta);
 	}
 
 	if (ret == _FAIL || ret == RTW_RX_HANDLED)
@@ -1035,7 +1032,6 @@ static int validate_recv_frame(struct adapter *adapter, struct recv_frame *precv
 
 	int retval = _FAIL;
 	struct rx_pkt_attrib *pattrib = &precv_frame->attrib;
-	u8 *ptr = precv_frame->rx_data;
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)precv_frame->rx_data;
 	struct mlme_ext_priv *pmlmeext = &adapter->mlmeextpriv;
 
@@ -1048,8 +1044,6 @@ static int validate_recv_frame(struct adapter *adapter, struct recv_frame *precv
 	if ((hdr->frame_control & cpu_to_le16(IEEE80211_FCTL_VERS)) != 0)
 		return _FAIL;
 
-	pattrib->to_fr_ds = get_tofr_ds(ptr);
-
 	pattrib->frag_num = le16_to_cpu(hdr->seq_ctrl) & IEEE80211_SCTL_FRAG;
 	pattrib->seq_num = IEEE80211_SEQ_TO_SN(le16_to_cpu(hdr->seq_ctrl));
 
diff --git a/drivers/staging/r8188eu/include/rtw_recv.h b/drivers/staging/r8188eu/include/rtw_recv.h
index 4ac4e6b3e177..59b4773bc3c9 100644
--- a/drivers/staging/r8188eu/include/rtw_recv.h
+++ b/drivers/staging/r8188eu/include/rtw_recv.h
@@ -80,7 +80,6 @@ struct rx_pkt_attrib {
 	u8	drvinfo_sz;
 	u8	shift_sz;
 	u8	hdrlen; /* the WLAN Header Len */
-	u8	to_fr_ds;
 	u8	amsdu;
 	bool	qos;
 	u8	priority;
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index eb3cb1fb285f..a252a416d3e5 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -152,8 +152,6 @@ enum WIFI_REG_DOMAIN {
 
 #define GetFrDs(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_FROM_DS_)) != 0)
 
-#define get_tofr_ds(pframe)	((GetToDs(pframe) << 1) | GetFrDs(pframe))
-
 #define SetMFrag(pbuf)	\
 	*(__le16 *)(pbuf) |= cpu_to_le16(_MORE_FRAG_)
 
-- 
2.30.2

