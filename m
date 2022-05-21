Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288A852FDE9
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 17:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355420AbiEUPjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 11:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245207AbiEUPij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 11:38:39 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42AF62CDE
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 08:38:38 -0700 (PDT)
Received: from dslb-188-096-138-194.188.096.pools.vodafone-ip.de ([188.96.138.194] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nsRBa-0007XY-5j; Sat, 21 May 2022 17:38:34 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 07/12] staging: r8188eu: use mgmt to set the action codes
Date:   Sat, 21 May 2022 17:38:19 +0200
Message-Id: <20220521153824.218196-8-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220521153824.218196-1-martin@kaiser.cx>
References: <20220521153824.218196-1-martin@kaiser.cx>
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

Use the mgmt structure in issue_action_BA to set the action codes.
We have to distinguish between the different message types.

We also have to increment the packet length manually as we're no longer
calling rtw_set_fixed_ie, which increments the length.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index dd736416ddcf..efffbbfd495e 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -5411,10 +5411,11 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 
 	mgmt->u.action.category = WLAN_CATEGORY_BACK;
 	pattrib->pktlen++;
-	pframe = rtw_set_fixed_ie(pframe, 1, &(action), &pattrib->pktlen);
 
 	switch (action) {
 	case WLAN_ACTION_ADDBA_REQ:
+		mgmt->u.action.u.addba_req.action_code = WLAN_ACTION_ADDBA_REQ;
+		pattrib->pktlen++;
 		do {
 			pmlmeinfo->dialogToken++;
 		} while (pmlmeinfo->dialogToken == 0);
@@ -5440,6 +5441,8 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 		pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)&le_tmp, &pattrib->pktlen);
 		break;
 	case WLAN_ACTION_ADDBA_RESP:
+		mgmt->u.action.u.addba_resp.action_code = WLAN_ACTION_ADDBA_RESP;
+		pattrib->pktlen++;
 		pframe = rtw_set_fixed_ie(pframe, 1, &pmlmeinfo->ADDBA_req.dialog_token, &pattrib->pktlen);
 		pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)&status, &pattrib->pktlen);
 		BA_para_set = le16_to_cpu(pmlmeinfo->ADDBA_req.BA_para_set) & 0x3f;
@@ -5455,6 +5458,8 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 		pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)&pmlmeinfo->ADDBA_req.BA_timeout_value, &pattrib->pktlen);
 		break;
 	case WLAN_ACTION_DELBA:
+		mgmt->u.action.u.delba.action_code = WLAN_ACTION_DELBA;
+		pattrib->pktlen++;
 		BA_para_set = (status & 0x1F) << 3;
 		le_tmp = cpu_to_le16(BA_para_set);
 		pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)&le_tmp, &pattrib->pktlen);
-- 
2.30.2

