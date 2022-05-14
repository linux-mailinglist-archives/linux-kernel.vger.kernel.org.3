Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3AB52731D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 18:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbiENQrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 12:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbiENQrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 12:47:53 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B0232077
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 09:47:52 -0700 (PDT)
Received: from dslb-188-097-047-153.188.097.pools.vodafone-ip.de ([188.97.47.153] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1npuvj-0003kw-Rh; Sat, 14 May 2022 18:47:47 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/7] staging: r8188eu: read addba resp tid from ieee80211_mgmt
Date:   Sat, 14 May 2022 18:47:35 +0200
Message-Id: <20220514164740.282552-3-martin@kaiser.cx>
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

Use the same code as ieee80211_process_addba_resp to calculate the tid
from the capability field of an addba response message.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 4d8337d0dc20..03c9b2d0d4e8 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -1505,7 +1505,8 @@ unsigned int OnAction_back(struct adapter *padapter, struct recv_frame *precv_fr
 			issue_action_BA(padapter, mgmt->sa, WLAN_ACTION_ADDBA_RESP, 37);/* reject ADDBA Req */
 		break;
 	case WLAN_ACTION_ADDBA_RESP:
-		tid = ((frame_body[5] >> 2) & 0x7);
+		tid = u16_get_bits(le16_to_cpu(mgmt->u.action.u.addba_resp.capab),
+				   IEEE80211_ADDBA_PARAM_TID_MASK);
 		if (mgmt->u.action.u.addba_resp.status == 0) {	/* successful */
 			psta->htpriv.agg_enable_bitmap |= 1 << tid;
 			psta->htpriv.candidate_tid_bitmap &= ~BIT(tid);
-- 
2.30.2

