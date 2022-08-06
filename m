Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD4658B528
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 13:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241803AbiHFLOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 07:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiHFLOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 07:14:15 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464B211806
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 04:14:14 -0700 (PDT)
Received: from dslb-188-097-043-167.188.097.pools.vodafone-ip.de ([188.97.43.167] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oKHkt-0001FX-Bb; Sat, 06 Aug 2022 13:14:07 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 1/5] staging: r8188eu: replace a get_da call
Date:   Sat,  6 Aug 2022 13:13:48 +0200
Message-Id: <20220806111352.690650-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220806111352.690650-1-martin@kaiser.cx>
References: <20220724153917.138848-1-martin@kaiser.cx>
 <20220806111352.690650-1-martin@kaiser.cx>
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

The r8188eu driver implements an internal get_da function to read the
destination address (da) from an incoming message. Callers of this
function should be updated to use the ieee80211 framework, with the goal
of removing get_da eventually.

This patch replaces a get_da call in the OnAssocRsp function.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
v2:
 - rewrite the summary and the commit message

 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 32d0e101d0c2..f5f718488929 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -1320,6 +1320,7 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 
 unsigned int OnAssocRsp(struct adapter *padapter, struct recv_frame *precv_frame)
 {
+	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)precv_frame->rx_data;
 	uint i;
 	int res;
 	unsigned short	status;
@@ -1331,7 +1332,7 @@ unsigned int OnAssocRsp(struct adapter *padapter, struct recv_frame *precv_frame
 	uint pkt_len = precv_frame->len;
 
 	/* check A1 matches or not */
-	if (memcmp(myid(&padapter->eeprompriv), get_da(pframe), ETH_ALEN))
+	if (memcmp(myid(&padapter->eeprompriv), mgmt->da, ETH_ALEN))
 		return _SUCCESS;
 
 	if (!(pmlmeinfo->state & (WIFI_FW_AUTH_SUCCESS | WIFI_FW_ASSOC_STATE)))
-- 
2.30.2

