Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4313453BF1F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 21:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238950AbiFBTsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 15:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238889AbiFBTsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 15:48:21 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8D8E5A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 12:48:20 -0700 (PDT)
Received: from ipservice-092-217-081-045.092.217.pools.vodafone-ip.de ([92.217.81.45] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nwqno-000400-Fn; Thu, 02 Jun 2022 21:48:16 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/3] staging: r8188eu: use ieee80211 defines for back action codes
Date:   Thu,  2 Jun 2022 21:48:05 +0200
Message-Id: <20220602194807.281115-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220602194807.281115-1-martin@kaiser.cx>
References: <20220602194807.281115-1-martin@kaiser.cx>
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

Replace the driver-specific defines for back action codes with the defines
from ieee80211.h.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 6 +++---
 drivers/staging/r8188eu/include/ieee80211.h | 7 -------
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 1c1598c71b78..87bf37f33606 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -5606,7 +5606,7 @@ unsigned int send_delba(struct adapter *padapter, u8 initiator, u8 *addr)
 	if (initiator == 0) { /*  recipient */
 		for (tid = 0; tid < MAXTID; tid++) {
 			if (psta->recvreorder_ctrl[tid].enable) {
-				issue_action_BA(padapter, addr, RTW_WLAN_ACTION_DELBA, (((tid << 1) | initiator) & 0x1F));
+				issue_action_BA(padapter, addr, WLAN_ACTION_DELBA, (((tid << 1) | initiator) & 0x1F));
 				psta->recvreorder_ctrl[tid].enable = false;
 				psta->recvreorder_ctrl[tid].indicate_seq = 0xffff;
 			}
@@ -5614,7 +5614,7 @@ unsigned int send_delba(struct adapter *padapter, u8 initiator, u8 *addr)
 	} else if (initiator == 1) { /*  originator */
 		for (tid = 0; tid < MAXTID; tid++) {
 			if (psta->htpriv.agg_enable_bitmap & BIT(tid)) {
-				issue_action_BA(padapter, addr, RTW_WLAN_ACTION_DELBA, (((tid << 1) | initiator) & 0x1F));
+				issue_action_BA(padapter, addr, WLAN_ACTION_DELBA, (((tid << 1) | initiator) & 0x1F));
 				psta->htpriv.agg_enable_bitmap &= ~BIT(tid);
 				psta->htpriv.candidate_tid_bitmap &= ~BIT(tid);
 			}
@@ -7458,7 +7458,7 @@ u8 add_ba_hdl(struct adapter *padapter, unsigned char *pbuf)
 
 	if (((pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) && (pmlmeinfo->HT_enable)) ||
 	    ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE)) {
-		issue_action_BA(padapter, pparm->addr, RTW_WLAN_ACTION_ADDBA_REQ, (u16)pparm->tid);
+		issue_action_BA(padapter, pparm->addr, WLAN_ACTION_ADDBA_REQ, (u16)pparm->tid);
 		_set_timer(&psta->addba_retry_timer, ADDBA_TO);
 	} else {
 		psta->htpriv.candidate_tid_bitmap &= ~BIT(pparm->tid);
diff --git a/drivers/staging/r8188eu/include/ieee80211.h b/drivers/staging/r8188eu/include/ieee80211.h
index 15636a808f52..e7a4f8af497a 100644
--- a/drivers/staging/r8188eu/include/ieee80211.h
+++ b/drivers/staging/r8188eu/include/ieee80211.h
@@ -624,13 +624,6 @@ enum _PUBLIC_ACTION {
 	ACT_PUBLIC_MAX
 };
 
-/* BACK action code */
-enum rtw_ieee80211_back_actioncode {
-	RTW_WLAN_ACTION_ADDBA_REQ = 0,
-	RTW_WLAN_ACTION_ADDBA_RESP = 1,
-	RTW_WLAN_ACTION_DELBA = 2,
-};
-
 #define OUI_MICROSOFT 0x0050f2 /* Microsoft (also used in Wi-Fi specs)
 				* 00:50:F2 */
 #define WME_OUI_TYPE 2
-- 
2.30.2

