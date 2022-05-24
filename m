Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA13A532605
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 11:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbiEXJCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 05:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234444AbiEXJBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 05:01:10 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5517AF13
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 02:01:05 -0700 (PDT)
Received: from 162.sub194.ddfr.nl ([83.136.194.162] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1ntQPU-0006Y3-GM; Tue, 24 May 2022 11:01:00 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 10/12] staging: r8188eu: use ieee80211 to set addba capabilities
Date:   Tue, 24 May 2022 11:00:27 +0200
Message-Id: <20220524090029.242584-11-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220524090029.242584-1-martin@kaiser.cx>
References: <20220521153824.218196-1-martin@kaiser.cx>
 <20220524090029.242584-1-martin@kaiser.cx>
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

Use the mgmt structure and defines from ieee80211.h to set the
capabilities field of an addba request.

If issue_action_BA is called with action == WLAN_ACTION_ADDBA_REQ, the
status parameter contains the tid.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index da0c0363eb4d..823c54837364 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -5380,6 +5380,7 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct registry_priv *pregpriv = &padapter->registrypriv;
 	struct ieee80211_mgmt *mgmt;
+	u16 capab;
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe)
@@ -5419,9 +5420,12 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 		mgmt->u.action.u.addba_req.dialog_token = pmlmeinfo->dialogToken;
 		pattrib->pktlen++;
 
-		BA_para_set = (0x1002 | ((status & 0xf) << 2)); /* immediate ack & 64 buffer size */
-		le_tmp = cpu_to_le16(BA_para_set);
-		pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)&le_tmp, &pattrib->pktlen);
+		/* immediate ack & 64 buffer size */
+		capab = u16_encode_bits(64, IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK);
+		capab |= u16_encode_bits(1, IEEE80211_ADDBA_PARAM_POLICY_MASK);
+		capab |= u16_encode_bits(status, IEEE80211_ADDBA_PARAM_TID_MASK);
+		mgmt->u.action.u.addba_req.capab = cpu_to_le16(capab);
+		pattrib->pktlen += 2;
 
 		mgmt->u.action.u.addba_req.timeout = cpu_to_le16(5000); /* 5 ms */
 		pattrib->pktlen += 2;
-- 
2.30.2

