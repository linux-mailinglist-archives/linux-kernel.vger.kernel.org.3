Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D779B55B35E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 20:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiFZSHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 14:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbiFZSHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 14:07:46 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB45BCA1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 11:07:45 -0700 (PDT)
Received: from dslb-188-104-057-109.188.104.pools.vodafone-ip.de ([188.104.57.109] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1o5Wfa-00073R-OY; Sun, 26 Jun 2022 20:07:38 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] staging: r8188eu: drop return value from receive_disconnect
Date:   Sun, 26 Jun 2022 20:07:34 +0200
Message-Id: <20220626180734.287137-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
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

The receive_disconnect function always returns _SUCCESS. None of the
callers checks the return value. We can remove it.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c    | 5 ++---
 drivers/staging/r8188eu/include/rtw_mlme_ext.h | 3 +--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index cce0575e93b7..fc6e06d7b5ca 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -6191,14 +6191,14 @@ void start_clnt_assoc(struct adapter *padapter)
 	set_link_timer(pmlmeext, REASSOC_TO);
 }
 
-unsigned int receive_disconnect(struct adapter *padapter, unsigned char *MacAddr, unsigned short reason)
+void receive_disconnect(struct adapter *padapter, unsigned char *MacAddr, unsigned short reason)
 {
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 	/* check A3 */
 	if (!(!memcmp(MacAddr, get_my_bssid(&pmlmeinfo->network), ETH_ALEN)))
-		return _SUCCESS;
+		return;
 
 	if ((pmlmeinfo->state & 0x03) == WIFI_FW_STATION_STATE) {
 		if (pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) {
@@ -6209,7 +6209,6 @@ unsigned int receive_disconnect(struct adapter *padapter, unsigned char *MacAddr
 			report_join_res(padapter, -2);
 		}
 	}
-	return _SUCCESS;
 }
 
 static void process_80211d(struct adapter *padapter, struct wlan_bssid_ex *bssid)
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index 71864733b1c0..56c0e584bb6c 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -468,8 +468,7 @@ unsigned int update_MSC_rate(struct HT_caps_element *pHT_caps);
 void Update_RA_Entry(struct adapter *padapter, u32 mac_id);
 void set_sta_rate(struct adapter *padapter, struct sta_info *psta);
 
-unsigned int receive_disconnect(struct adapter *padapter,
-				unsigned char *macaddr, unsigned short reason);
+void receive_disconnect(struct adapter *padapter, unsigned char *macaddr, unsigned short reason);
 
 unsigned char get_highest_rate_idx(u32 mask);
 int support_short_GI(struct adapter *padapter, struct HT_caps_element *caps);
-- 
2.30.2

