Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E47953BEEF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 21:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238689AbiFBTiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 15:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238714AbiFBThw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 15:37:52 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AC52F00A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 12:37:50 -0700 (PDT)
Received: from ipservice-092-217-081-045.092.217.pools.vodafone-ip.de ([92.217.81.45] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nwqdd-0003py-AX; Thu, 02 Jun 2022 21:37:45 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 07/11] staging: r8188eu: use mgmt to set delba params
Date:   Thu,  2 Jun 2022 21:37:22 +0200
Message-Id: <20220602193726.280922-8-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220602193726.280922-1-martin@kaiser.cx>
References: <20220602193726.280922-1-martin@kaiser.cx>
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

Use the mgmt struct to set the delba parameters. Use the exact same value
for the parameters as the current code.

Remove a dead increment of pframe, we don't use pframe for the delba
message any more.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 97bc5a968a84..b4d22dae212a 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -5366,8 +5366,6 @@ int issue_deauth_ex(struct adapter *padapter, u8 *da, unsigned short reason, int
 void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned char action, unsigned short status)
 {
 	u16 start_seq;
-	u16 BA_para_set;
-	__le16	le_tmp;
 	u16 BA_starting_seqctrl = 0;
 	struct xmit_frame *pmgntframe;
 	struct pkt_attrib *pattrib;
@@ -5403,7 +5401,6 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 	mgmt->seq_ctrl = cpu_to_le16(pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
 
-	pframe += sizeof(struct ieee80211_hdr_3addr);
 	pattrib->pktlen = sizeof(struct ieee80211_hdr_3addr);
 
 	mgmt->u.action.category = WLAN_CATEGORY_BACK;
@@ -5452,10 +5449,8 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 	case WLAN_ACTION_DELBA:
 		mgmt->u.action.u.delba.action_code = WLAN_ACTION_DELBA;
 		pattrib->pktlen++;
-		BA_para_set = (status & 0x1F) << 3;
-		le_tmp = cpu_to_le16(BA_para_set);
-		pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)&le_tmp, &pattrib->pktlen);
-
+		mgmt->u.action.u.delba.params = cpu_to_le16((status & 0x1F) << 3);
+		pattrib->pktlen += 2;
 		mgmt->u.action.u.delba.reason_code = cpu_to_le16(WLAN_STATUS_REQUEST_DECLINED);
 		pattrib->pktlen += 2;
 		break;
-- 
2.30.2

