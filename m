Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C4D527319
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 18:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbiENQsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 12:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234373AbiENQry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 12:47:54 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C9032079
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 09:47:52 -0700 (PDT)
Received: from dslb-188-097-047-153.188.097.pools.vodafone-ip.de ([188.97.47.153] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1npuvk-0003kw-Ju; Sat, 14 May 2022 18:47:48 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/7] staging: r8188eu: merge process_addba_req into OnAction_back
Date:   Sat, 14 May 2022 18:47:36 +0200
Message-Id: <20220514164740.282552-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220514164740.282552-1-martin@kaiser.cx>
References: <20220514164740.282552-1-martin@kaiser.cx>
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

The process_addba_req function is called only by OnAction_back. Merge the
two functions.

OnAction_back has already checked that psta != NULL, we can drop the check
in process_addba_req before merging the functions. We can also simplify
the parsing of the tid by using struct ieee80211.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   |  6 ++++-
 drivers/staging/r8188eu/core/rtw_wlan_util.c  | 22 -------------------
 .../staging/r8188eu/include/rtw_mlme_ext.h    |  2 --
 3 files changed, 5 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 03c9b2d0d4e8..77f229121b4d 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -1497,7 +1497,11 @@ unsigned int OnAction_back(struct adapter *padapter, struct recv_frame *precv_fr
 	switch (mgmt->u.action.u.addba_req.action_code) {
 	case WLAN_ACTION_ADDBA_REQ:
 		memcpy(&pmlmeinfo->ADDBA_req, &frame_body[2], sizeof(struct ADDBA_request));
-		process_addba_req(padapter, (u8 *)&pmlmeinfo->ADDBA_req, mgmt->sa);
+		tid = u16_get_bits(le16_to_cpu(mgmt->u.action.u.addba_req.capab),
+				   IEEE80211_ADDBA_PARAM_TID_MASK);
+		preorder_ctrl = &psta->recvreorder_ctrl[tid];
+		preorder_ctrl->indicate_seq = 0xffff;
+		preorder_ctrl->enable = pmlmeinfo->bAcceptAddbaReq;
 
 		if (pmlmeinfo->bAcceptAddbaReq)
 			issue_action_BA(padapter, mgmt->sa, WLAN_ACTION_ADDBA_RESP, 0);
diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index 27035eac6e61..9585ab41cd3f 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -1464,28 +1464,6 @@ int update_sta_support_rate(struct adapter *padapter, u8 *pvar_ie, uint var_ie_l
 	return _SUCCESS;
 }
 
-void process_addba_req(struct adapter *padapter, u8 *paddba_req, u8 *addr)
-{
-	struct sta_info *psta;
-	u16 tid;
-	u16 param;
-	struct recv_reorder_ctrl *preorder_ctrl;
-	struct sta_priv *pstapriv = &padapter->stapriv;
-	struct ADDBA_request	*preq = (struct ADDBA_request *)paddba_req;
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
-
-	psta = rtw_get_stainfo(pstapriv, addr);
-
-	if (psta) {
-		param = le16_to_cpu(preq->BA_para_set);
-		tid = (param >> 2) & 0x0f;
-		preorder_ctrl = &psta->recvreorder_ctrl[tid];
-		preorder_ctrl->indicate_seq = 0xffff;
-		preorder_ctrl->enable = pmlmeinfo->bAcceptAddbaReq;
-	}
-}
-
 void update_TSF(struct mlme_ext_priv *pmlmeext, u8 *pframe, uint len)
 {
 	u8 *pIE;
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index 888b12a9f755..573d65b175cc 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -592,8 +592,6 @@ void addba_timer_hdl(struct sta_info *psta);
 bool cckrates_included(unsigned char *rate, int ratelen);
 bool cckratesonly_included(unsigned char *rate, int ratelen);
 
-void process_addba_req(struct adapter *padapter, u8 *paddba_req, u8 *addr);
-
 void update_TSF(struct mlme_ext_priv *pmlmeext, u8 *pframe, uint len);
 void correct_TSF(struct adapter *padapter, struct mlme_ext_priv *pmlmeext);
 
-- 
2.30.2

