Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E5C527875
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 17:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbiEOP2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 11:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233933AbiEOP2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 11:28:32 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1341208A
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 08:28:30 -0700 (PDT)
Received: from dslb-188-096-141-066.188.096.pools.vodafone-ip.de ([188.96.141.66] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nqGAS-0006Dx-Gb; Sun, 15 May 2022 17:28:24 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>, Joe Perches <joe@perches.com>
Subject: [PATCH] staging: r8188eu: use defines for addba response status
Date:   Sun, 15 May 2022 17:27:59 +0200
Message-Id: <20220515152759.335889-1-martin@kaiser.cx>
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

Replace the numeric values with defines from ieee80211.h.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---

This should be applied after yesterday's series "more cleanups in
OnAction_back".

 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index b24c6a79646d..65330baa5a73 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -1504,7 +1504,8 @@ unsigned int OnAction_back(struct adapter *padapter, struct recv_frame *precv_fr
 		preorder_ctrl->enable = pmlmeinfo->bAcceptAddbaReq;
 
 		issue_action_BA(padapter, mgmt->sa, WLAN_ACTION_ADDBA_RESP,
-				pmlmeinfo->bAcceptAddbaReq ? 0 : 37);
+				pmlmeinfo->bAcceptAddbaReq ?
+					WLAN_STATUS_SUCCESS : WLAN_STATUS_REQUEST_DECLINED);
 		break;
 	case WLAN_ACTION_ADDBA_RESP:
 		tid = u16_get_bits(le16_to_cpu(mgmt->u.action.u.addba_resp.capab),
-- 
2.30.2

