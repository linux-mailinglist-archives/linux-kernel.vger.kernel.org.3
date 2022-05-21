Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338C952FDE2
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 17:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355443AbiEUPjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 11:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245169AbiEUPii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 11:38:38 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D2862CD2
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 08:38:37 -0700 (PDT)
Received: from dslb-188-096-138-194.188.096.pools.vodafone-ip.de ([188.96.138.194] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nsRBZ-0007XY-Dy; Sat, 21 May 2022 17:38:33 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 06/12] staging: r8188eu: use mgmt to set the category
Date:   Sat, 21 May 2022 17:38:18 +0200
Message-Id: <20220521153824.218196-7-martin@kaiser.cx>
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

Use the mgmt structure in issue_action_BA to set the category of the
outgoing frame. Remove the rtw_set_fixed_ie call.

We can now use the define directly, the category variable can be removed.

rtw_set_fixed_ie increments pattrib->pktlen, we have to do this ourselves
now (until we use a proper way to calculate the packet length).

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 9a26b67d49bd..dd736416ddcf 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -5365,7 +5365,6 @@ int issue_deauth_ex(struct adapter *padapter, u8 *da, unsigned short reason, int
 
 void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned char action, unsigned short status)
 {
-	u8 category = WLAN_CATEGORY_BACK;
 	u16 start_seq;
 	u16 BA_para_set;
 	u16 reason_code;
@@ -5410,7 +5409,8 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 	pframe += sizeof(struct ieee80211_hdr_3addr);
 	pattrib->pktlen = sizeof(struct ieee80211_hdr_3addr);
 
-	pframe = rtw_set_fixed_ie(pframe, 1, &(category), &pattrib->pktlen);
+	mgmt->u.action.category = WLAN_CATEGORY_BACK;
+	pattrib->pktlen++;
 	pframe = rtw_set_fixed_ie(pframe, 1, &(action), &pattrib->pktlen);
 
 	switch (action) {
-- 
2.30.2

