Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947DF4F0B53
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 18:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359520AbiDCQsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 12:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359504AbiDCQrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 12:47:55 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C761138DAF
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 09:46:00 -0700 (PDT)
Received: from dslb-094-219-033-178.094.219.pools.vodafone-ip.de ([94.219.33.178] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nb3MD-00085T-Qy; Sun, 03 Apr 2022 18:45:41 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/5] staging: r8188eu: exit straight away if we have no pspoll frame
Date:   Sun,  3 Apr 2022 18:45:24 +0200
Message-Id: <20220403164526.357371-4-martin@kaiser.cx>
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

validate_recv_ctrl_frame wraps nearly all of its code into a large
if (pspoll) { ... } clause.

Revert this condition and exit if the incoming frame is not a pspoll
frame.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 146 ++++++++++++------------
 1 file changed, 73 insertions(+), 73 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 74fe2d7011fc..39834771519f 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -803,104 +803,104 @@ static void validate_recv_ctrl_frame(struct adapter *padapter,
 	u8 *pframe = precv_frame->rx_data;
 	__le16 fc = *(__le16 *)pframe;
 	/* uint len = precv_frame->len; */
+	u16 aid;
+	u8 wmmps_ac;
+	struct sta_info *psta;
 
 	/* receive the frames that ra(a1) is my address */
 	if (memcmp(GetAddr1Ptr(pframe), myid(&padapter->eeprompriv), ETH_ALEN))
 		return;
 
 	/* only handle ps-poll */
-	if (ieee80211_is_pspoll(fc)) {
-		u16 aid;
-		u8 wmmps_ac = 0;
-		struct sta_info *psta = NULL;
+	if (!ieee80211_is_pspoll(fc))
+		return;
 
-		aid = GetAid(pframe);
-		psta = rtw_get_stainfo(pstapriv, GetAddr2Ptr(pframe));
+	aid = GetAid(pframe);
+	psta = rtw_get_stainfo(pstapriv, GetAddr2Ptr(pframe));
 
-		if (!psta || psta->aid != aid)
-			return;
+	if (!psta || psta->aid != aid)
+		return;
 
-		/* for rx pkt statistics */
-		psta->sta_stats.rx_ctrl_pkts++;
+	/* for rx pkt statistics */
+	psta->sta_stats.rx_ctrl_pkts++;
 
-		switch (pattrib->priority) {
-		case 1:
-		case 2:
-			wmmps_ac = psta->uapsd_bk & BIT(0);
-			break;
-		case 4:
-		case 5:
-			wmmps_ac = psta->uapsd_vi & BIT(0);
-			break;
-		case 6:
-		case 7:
-			wmmps_ac = psta->uapsd_vo & BIT(0);
-			break;
-		case 0:
-		case 3:
-		default:
-			wmmps_ac = psta->uapsd_be & BIT(0);
-			break;
-		}
+	switch (pattrib->priority) {
+	case 1:
+	case 2:
+		wmmps_ac = psta->uapsd_bk & BIT(0);
+		break;
+	case 4:
+	case 5:
+		wmmps_ac = psta->uapsd_vi & BIT(0);
+		break;
+	case 6:
+	case 7:
+		wmmps_ac = psta->uapsd_vo & BIT(0);
+		break;
+	case 0:
+	case 3:
+	default:
+		wmmps_ac = psta->uapsd_be & BIT(0);
+		break;
+	}
 
-		if (wmmps_ac)
-			return;
+	if (wmmps_ac)
+		return;
 
-		if (psta->state & WIFI_STA_ALIVE_CHK_STATE) {
-			psta->expire_to = pstapriv->expire_to;
-			psta->state ^= WIFI_STA_ALIVE_CHK_STATE;
-		}
+	if (psta->state & WIFI_STA_ALIVE_CHK_STATE) {
+		psta->expire_to = pstapriv->expire_to;
+		psta->state ^= WIFI_STA_ALIVE_CHK_STATE;
+	}
 
-		if ((psta->state & WIFI_SLEEP_STATE) && (pstapriv->sta_dz_bitmap & BIT(psta->aid))) {
-			struct list_head *xmitframe_plist, *xmitframe_phead;
-			struct xmit_frame *pxmitframe = NULL;
-			struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
+	if ((psta->state & WIFI_SLEEP_STATE) && (pstapriv->sta_dz_bitmap & BIT(psta->aid))) {
+		struct list_head *xmitframe_plist, *xmitframe_phead;
+		struct xmit_frame *pxmitframe = NULL;
+		struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
 
-			spin_lock_bh(&pxmitpriv->lock);
+		spin_lock_bh(&pxmitpriv->lock);
 
-			xmitframe_phead = get_list_head(&psta->sleep_q);
-			xmitframe_plist = xmitframe_phead->next;
+		xmitframe_phead = get_list_head(&psta->sleep_q);
+		xmitframe_plist = xmitframe_phead->next;
 
-			if (xmitframe_phead != xmitframe_plist) {
-				pxmitframe = container_of(xmitframe_plist, struct xmit_frame, list);
+		if (xmitframe_phead != xmitframe_plist) {
+			pxmitframe = container_of(xmitframe_plist, struct xmit_frame, list);
 
-				xmitframe_plist = xmitframe_plist->next;
+			xmitframe_plist = xmitframe_plist->next;
 
-				list_del_init(&pxmitframe->list);
+			list_del_init(&pxmitframe->list);
 
-				psta->sleepq_len--;
+			psta->sleepq_len--;
 
-				if (psta->sleepq_len > 0)
-					pxmitframe->attrib.mdata = 1;
-				else
-					pxmitframe->attrib.mdata = 0;
+			if (psta->sleepq_len > 0)
+				pxmitframe->attrib.mdata = 1;
+			else
+				pxmitframe->attrib.mdata = 0;
 
-				pxmitframe->attrib.triggered = 1;
+			pxmitframe->attrib.triggered = 1;
 
-				if (psta->sleepq_len == 0) {
-					pstapriv->tim_bitmap &= ~BIT(psta->aid);
+			if (psta->sleepq_len == 0) {
+				pstapriv->tim_bitmap &= ~BIT(psta->aid);
 
-					/* upate BCN for TIM IE */
-					/* update_BCNTIM(padapter); */
-					update_beacon(padapter, _TIM_IE_, NULL, false);
-				}
-			} else {
-				if (pstapriv->tim_bitmap & BIT(psta->aid)) {
-					if (psta->sleepq_len == 0)
-						/* issue nulldata with More data bit = 0 to indicate we have no buffered packets */
-						issue_nulldata(padapter, psta->hwaddr, 0, 0, 0);
-					else
-						psta->sleepq_len = 0;
-
-					pstapriv->tim_bitmap &= ~BIT(psta->aid);
-
-					/* upate BCN for TIM IE */
-					/* update_BCNTIM(padapter); */
-					update_beacon(padapter, _TIM_IE_, NULL, false);
-				}
+				/* upate BCN for TIM IE */
+				/* update_BCNTIM(padapter); */
+				update_beacon(padapter, _TIM_IE_, NULL, false);
+			}
+		} else {
+			if (pstapriv->tim_bitmap & BIT(psta->aid)) {
+				if (psta->sleepq_len == 0)
+					/* issue nulldata with More data bit = 0 to indicate we have no buffered packets */
+					issue_nulldata(padapter, psta->hwaddr, 0, 0, 0);
+				else
+					psta->sleepq_len = 0;
+
+				pstapriv->tim_bitmap &= ~BIT(psta->aid);
+
+				/* upate BCN for TIM IE */
+				/* update_BCNTIM(padapter); */
+				update_beacon(padapter, _TIM_IE_, NULL, false);
 			}
-			spin_unlock_bh(&pxmitpriv->lock);
 		}
+		spin_unlock_bh(&pxmitpriv->lock);
 	}
 }
 
-- 
2.30.2

