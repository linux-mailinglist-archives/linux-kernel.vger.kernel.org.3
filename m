Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9EF4E894B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 20:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236304AbiC0SMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 14:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236294AbiC0SLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 14:11:51 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75593366AF
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 11:10:06 -0700 (PDT)
Received: from dslb-178-004-173-219.178.004.pools.vodafone-ip.de ([178.4.173.219] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nYXL1-00019B-3V; Sun, 27 Mar 2022 20:10:03 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <David.Laight@ACULAB.COM>,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 8/9] staging: r8188eu: use ieee80211 macro for sequence number
Date:   Sun, 27 Mar 2022 20:09:43 +0200
Message-Id: <20220327180944.712545-9-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220327180944.712545-1-martin@kaiser.cx>
References: <20220323074859.177425-1-martin@kaiser.cx>
 <20220327180944.712545-1-martin@kaiser.cx>
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

Use the IEEE80211_SEQ_TO_SN macro in function validate_recv_frame to get
the sequence number of an incoming frame.

Map the incoming rx bytes to a struct ieee80211_hdr. Replace the fc
variable with struct ieee80211_hdr's frame control component.

The IEEE80211_SEQ_TO_SN macro takes the sequence control field of an
ieee80211 header and extracts the sequence number. The macro's input
parameter must be in host endianness, the sequence number in the 80211
header is little-endian, we have to convert it to host endianness.

Remove the local GetSequence macro, it is not used any more.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 24 ++++++++++++------------
 drivers/staging/r8188eu/include/wifi.h  |  3 ---
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index bb67abd3ed99..415747da7e3b 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -1063,7 +1063,7 @@ static int validate_recv_frame(struct adapter *adapter, struct recv_frame *precv
 	u8 bDumpRxPkt;
 	struct rx_pkt_attrib *pattrib = &precv_frame->attrib;
 	u8 *ptr = precv_frame->rx_data;
-	__le16 fc = *(__le16 *)ptr;
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)precv_frame->rx_data;
 	struct mlme_ext_priv *pmlmeext = &adapter->mlmeextpriv;
 
 	if (pmlmeext->sitesurvey_res.state == SCAN_PROCESS) {
@@ -1072,31 +1072,31 @@ static int validate_recv_frame(struct adapter *adapter, struct recv_frame *precv
 			pmlmeext->channel_set[ch_set_idx].rx_count++;
 	}
 
-	if ((fc & cpu_to_le16(IEEE80211_FCTL_VERS)) != 0)
+	if ((hdr->frame_control & cpu_to_le16(IEEE80211_FCTL_VERS)) != 0)
 		return _FAIL;
 
 	pattrib->to_fr_ds = get_tofr_ds(ptr);
 
 	pattrib->frag_num = GetFragNum(ptr);
-	pattrib->seq_num = GetSequence(ptr);
+	pattrib->seq_num = IEEE80211_SEQ_TO_SN(le16_to_cpu(hdr->seq_ctrl));
 
-	pattrib->pw_save = ieee80211_has_pm(fc);
-	pattrib->mfrag = ieee80211_has_morefrags(fc);
-	pattrib->mdata = ieee80211_has_moredata(fc);
-	pattrib->privacy = ieee80211_has_protected(fc);
-	pattrib->order = ieee80211_has_order(fc);
+	pattrib->pw_save = ieee80211_has_pm(hdr->frame_control);
+	pattrib->mfrag = ieee80211_has_morefrags(hdr->frame_control);
+	pattrib->mdata = ieee80211_has_moredata(hdr->frame_control);
+	pattrib->privacy = ieee80211_has_protected(hdr->frame_control);
+	pattrib->order = ieee80211_has_order(hdr->frame_control);
 
 	/* Dump rx packets */
 	GetHalDefVar8188EUsb(adapter, HAL_DEF_DBG_DUMP_RXPKT, &bDumpRxPkt);
 
 	/* We return _SUCCESS only for data frames. */
-	if (ieee80211_is_mgmt(fc))
+	if (ieee80211_is_mgmt(hdr->frame_control))
 		validate_recv_mgnt_frame(adapter, precv_frame);
-	else if (ieee80211_is_ctl(fc))
+	else if (ieee80211_is_ctl(hdr->frame_control))
 		validate_recv_ctrl_frame(adapter, precv_frame);
-	else if (ieee80211_is_data(fc)) {
+	else if (ieee80211_is_data(hdr->frame_control)) {
 		rtw_led_control(adapter, LED_CTL_RX);
-		pattrib->qos = ieee80211_is_data_qos(fc);
+		pattrib->qos = ieee80211_is_data_qos(hdr->frame_control);
 		retval = validate_recv_data_frame(adapter, precv_frame);
 		if (retval == _FAIL) {
 			struct recv_priv *precvpriv = &adapter->recvpriv;
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 24d404f0f5f4..dbda1880c45a 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -189,9 +189,6 @@ enum WIFI_REG_DOMAIN {
 		*(__le16 *)(pbuf) |= cpu_to_le16(type); \
 	} while (0)
 
-#define GetSequence(pbuf)			\
-	(le16_to_cpu(*(__le16 *)((size_t)(pbuf) + 22)) >> 4)
-
 #define GetFragNum(pbuf)			\
 	(le16_to_cpu(*(__le16 *)((size_t)(pbuf) + 22)) & 0x0f)
 
-- 
2.30.2

