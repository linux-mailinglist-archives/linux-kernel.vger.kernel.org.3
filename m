Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CD553260A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 11:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbiEXJBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 05:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbiEXJA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 05:00:59 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2864A77F0B
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 02:00:59 -0700 (PDT)
Received: from 162.sub194.ddfr.nl ([83.136.194.162] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1ntQPO-0006Y3-29; Tue, 24 May 2022 11:00:54 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 01/12] staging: r8188eu: remove unnecessary category check
Date:   Tue, 24 May 2022 11:00:18 +0200
Message-Id: <20220524090029.242584-2-martin@kaiser.cx>
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

Remove the unnecessary category check in issue_action_BA. category is
initialised to 3 (WLAN_CATEGORY_BACK) and never updated.

The rtw_set_fixed_ie call gets a pointer to category but it doesn't update
the value.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 94 ++++++++++-----------
 1 file changed, 46 insertions(+), 48 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index faf23fc950c5..f47cf3e7316c 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -5415,60 +5415,58 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 	pframe = rtw_set_fixed_ie(pframe, 1, &(category), &pattrib->pktlen);
 	pframe = rtw_set_fixed_ie(pframe, 1, &(action), &pattrib->pktlen);
 
-	if (category == 3) {
-		switch (action) {
-		case 0: /* ADDBA req */
-			do {
-				pmlmeinfo->dialogToken++;
-			} while (pmlmeinfo->dialogToken == 0);
-			pframe = rtw_set_fixed_ie(pframe, 1, &pmlmeinfo->dialogToken, &pattrib->pktlen);
+	switch (action) {
+	case 0: /* ADDBA req */
+		do {
+			pmlmeinfo->dialogToken++;
+		} while (pmlmeinfo->dialogToken == 0);
+		pframe = rtw_set_fixed_ie(pframe, 1, &pmlmeinfo->dialogToken, &pattrib->pktlen);
 
-			BA_para_set = (0x1002 | ((status & 0xf) << 2)); /* immediate ack & 64 buffer size */
-			le_tmp = cpu_to_le16(BA_para_set);
-			pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)&le_tmp, &pattrib->pktlen);
+		BA_para_set = (0x1002 | ((status & 0xf) << 2)); /* immediate ack & 64 buffer size */
+		le_tmp = cpu_to_le16(BA_para_set);
+		pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)&le_tmp, &pattrib->pktlen);
 
-			BA_timeout_value = 5000;/*  5ms */
-			le_tmp = cpu_to_le16(BA_timeout_value);
-			pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)&le_tmp, &pattrib->pktlen);
+		BA_timeout_value = 5000;/*  5ms */
+		le_tmp = cpu_to_le16(BA_timeout_value);
+		pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)&le_tmp, &pattrib->pktlen);
 
-			psta = rtw_get_stainfo(pstapriv, raddr);
-			if (psta) {
-				start_seq = (psta->sta_xmitpriv.txseq_tid[status & 0x07] & 0xfff) + 1;
+		psta = rtw_get_stainfo(pstapriv, raddr);
+		if (psta) {
+			start_seq = (psta->sta_xmitpriv.txseq_tid[status & 0x07] & 0xfff) + 1;
 
-				psta->BA_starting_seqctrl[status & 0x07] = start_seq;
+			psta->BA_starting_seqctrl[status & 0x07] = start_seq;
 
-				BA_starting_seqctrl = start_seq << 4;
-			}
-			le_tmp = cpu_to_le16(BA_starting_seqctrl);
-			pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)&le_tmp, &pattrib->pktlen);
-			break;
-		case 1: /* ADDBA rsp */
-			pframe = rtw_set_fixed_ie(pframe, 1, &pmlmeinfo->ADDBA_req.dialog_token, &pattrib->pktlen);
-			pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)&status, &pattrib->pktlen);
-			BA_para_set = le16_to_cpu(pmlmeinfo->ADDBA_req.BA_para_set) & 0x3f;
-			BA_para_set |= 0x1000; /* 64 buffer size */
-
-			if (pregpriv->ampdu_amsdu == 0)/* disabled */
-				BA_para_set = BA_para_set & ~BIT(0);
-			else if (pregpriv->ampdu_amsdu == 1)/* enabled */
-				BA_para_set = BA_para_set | BIT(0);
-			le_tmp = cpu_to_le16(BA_para_set);
-
-			pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)&le_tmp, &pattrib->pktlen);
-			pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)&pmlmeinfo->ADDBA_req.BA_timeout_value, &pattrib->pktlen);
-			break;
-		case 2:/* DELBA */
-			BA_para_set = (status & 0x1F) << 3;
-			le_tmp = cpu_to_le16(BA_para_set);
-			pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)&le_tmp, &pattrib->pktlen);
-
-			reason_code = 37;/* Requested from peer STA as it does not want to use the mechanism */
-			le_tmp = cpu_to_le16(reason_code);
-			pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)&le_tmp, &pattrib->pktlen);
-			break;
-		default:
-			break;
+			BA_starting_seqctrl = start_seq << 4;
 		}
+		le_tmp = cpu_to_le16(BA_starting_seqctrl);
+		pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)&le_tmp, &pattrib->pktlen);
+		break;
+	case 1: /* ADDBA rsp */
+		pframe = rtw_set_fixed_ie(pframe, 1, &pmlmeinfo->ADDBA_req.dialog_token, &pattrib->pktlen);
+		pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)&status, &pattrib->pktlen);
+		BA_para_set = le16_to_cpu(pmlmeinfo->ADDBA_req.BA_para_set) & 0x3f;
+		BA_para_set |= 0x1000; /* 64 buffer size */
+
+		if (pregpriv->ampdu_amsdu == 0)/* disabled */
+			BA_para_set = BA_para_set & ~BIT(0);
+		else if (pregpriv->ampdu_amsdu == 1)/* enabled */
+			BA_para_set = BA_para_set | BIT(0);
+		le_tmp = cpu_to_le16(BA_para_set);
+
+		pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)&le_tmp, &pattrib->pktlen);
+		pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)&pmlmeinfo->ADDBA_req.BA_timeout_value, &pattrib->pktlen);
+		break;
+	case 2:/* DELBA */
+		BA_para_set = (status & 0x1F) << 3;
+		le_tmp = cpu_to_le16(BA_para_set);
+		pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)&le_tmp, &pattrib->pktlen);
+
+		reason_code = 37;/* Requested from peer STA as it does not want to use the mechanism */
+		le_tmp = cpu_to_le16(reason_code);
+		pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)&le_tmp, &pattrib->pktlen);
+		break;
+	default:
+		break;
 	}
 
 	pattrib->last_txcmdsz = pattrib->pktlen;
-- 
2.30.2

