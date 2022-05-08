Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB1451EEE1
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 18:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbiEHQTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 12:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235384AbiEHQTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 12:19:00 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB34101DA
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 09:15:09 -0700 (PDT)
Received: from dslb-094-219-036-010.094.219.pools.vodafone-ip.de ([94.219.36.10] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nnjYn-00045H-RK; Sun, 08 May 2022 18:15:05 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 5/5] staging: r8188eu: read back action code from ieee80211_mgmt
Date:   Sun,  8 May 2022 18:14:51 +0200
Message-Id: <20220508161451.115847-6-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220508161451.115847-1-martin@kaiser.cx>
References: <20220508161451.115847-1-martin@kaiser.cx>
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

Read the back action code from struct ieee80211_mgmt.

struct ieee80211_mgmt contains an "action" union. Each of its members
starts with an 8-bit action code. Treat the union as addba_req when we
read the action code although we do not yet know if it is an addba_req.
This approach is similar to ieee80211_iface_process_skb.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 2a7b85aefa56..8a9236ba7c66 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -1471,7 +1471,6 @@ unsigned int OnAction_back(struct adapter *padapter, struct recv_frame *precv_fr
 	struct sta_info *psta = NULL;
 	struct recv_reorder_ctrl *preorder_ctrl;
 	unsigned char		*frame_body;
-	unsigned char		action;
 	unsigned short	tid, status;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
@@ -1494,8 +1493,8 @@ unsigned int OnAction_back(struct adapter *padapter, struct recv_frame *precv_fr
 
 	if (!pmlmeinfo->HT_enable)
 		return _SUCCESS;
-	action = frame_body[1];
-	switch (action) {
+	/* All union members start with an action code, it's ok to use addba_req. */
+	switch (mgmt->u.action.u.addba_req.action_code) {
 	case WLAN_ACTION_ADDBA_REQ:
 		memcpy(&pmlmeinfo->ADDBA_req, &frame_body[2], sizeof(struct ADDBA_request));
 		process_addba_req(padapter, (u8 *)&pmlmeinfo->ADDBA_req, mgmt->sa);
-- 
2.30.2

