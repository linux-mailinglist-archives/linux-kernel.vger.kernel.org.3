Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406714CE54F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 15:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbiCEOmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 09:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbiCEOme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 09:42:34 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BAD6929A
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 06:41:44 -0800 (PST)
Received: from dslb-084-059-247-134.084.059.pools.vodafone-ip.de ([84.59.247.134] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nQVbI-0007ms-GD; Sat, 05 Mar 2022 15:41:40 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 5/5] staging: r8188eu: remove comments in update_recvframe_attrib_88e
Date:   Sat,  5 Mar 2022 15:41:17 +0100
Message-Id: <20220305144117.1380534-6-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220305144117.1380534-1-martin@kaiser.cx>
References: <20220305144117.1380534-1-martin@kaiser.cx>
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

Remove a couple of comments in update_recvframe_attrib_88e that provide no
useful information.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c | 48 +++++++++----------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c b/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
index cbc3ce34a50d..b4c9738ed868 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
@@ -60,48 +60,44 @@ void update_recvframe_attrib_88e(struct recv_frame *precvframe, struct recv_stat
 	struct rx_pkt_attrib *pattrib = &precvframe->attrib;
 	memset(pattrib, 0, sizeof(struct rx_pkt_attrib));
 
-	pattrib->crc_err = (le32_to_cpu(prxstat->rxdw0) >> 14) & 0x1;/* u8)prxreport->crc32; */
+	pattrib->crc_err = (le32_to_cpu(prxstat->rxdw0) >> 14) & 0x1;
 
-	/*  update rx report to recv_frame attribute */
-	pattrib->pkt_rpt_type = (le32_to_cpu(prxstat->rxdw3) >> 14) & 0x3;/* prxreport->rpt_sel; */
+	pattrib->pkt_rpt_type = (le32_to_cpu(prxstat->rxdw3) >> 14) & 0x3;
 
-	if (pattrib->pkt_rpt_type == NORMAL_RX) { /* Normal rx packet */
-		pattrib->pkt_len = le32_to_cpu(prxstat->rxdw0) & 0x00003fff;/* u16)prxreport->pktlen; */
-		pattrib->drvinfo_sz = ((le32_to_cpu(prxstat->rxdw0) >> 16) & 0xf) * 8;/* u8)(prxreport->drvinfosize << 3); */
+	if (pattrib->pkt_rpt_type == NORMAL_RX) {
+		pattrib->pkt_len = le32_to_cpu(prxstat->rxdw0) & 0x00003fff;
+		pattrib->drvinfo_sz = ((le32_to_cpu(prxstat->rxdw0) >> 16) & 0xf) * 8;
 
-		pattrib->physt = (le32_to_cpu(prxstat->rxdw0) >> 26) & 0x1;/* u8)prxreport->physt; */
+		pattrib->physt = (le32_to_cpu(prxstat->rxdw0) >> 26) & 0x1;
 
-		pattrib->bdecrypted = (le32_to_cpu(prxstat->rxdw0) & BIT(27)) ? 0 : 1;/* u8)(prxreport->swdec ? 0 : 1); */
-		pattrib->encrypt = (le32_to_cpu(prxstat->rxdw0) >> 20) & 0x7;/* u8)prxreport->security; */
+		pattrib->bdecrypted = (le32_to_cpu(prxstat->rxdw0) & BIT(27)) ? 0 : 1;
+		pattrib->encrypt = (le32_to_cpu(prxstat->rxdw0) >> 20) & 0x7;
 
-		pattrib->qos = (le32_to_cpu(prxstat->rxdw0) >> 23) & 0x1;/* prxreport->qos; */
-		pattrib->priority = (le32_to_cpu(prxstat->rxdw1) >> 8) & 0xf;/* u8)prxreport->tid; */
+		pattrib->qos = (le32_to_cpu(prxstat->rxdw0) >> 23) & 0x1;
+		pattrib->priority = (le32_to_cpu(prxstat->rxdw1) >> 8) & 0xf;
 
-		pattrib->amsdu = (le32_to_cpu(prxstat->rxdw1) >> 13) & 0x1;/* u8)prxreport->amsdu; */
+		pattrib->amsdu = (le32_to_cpu(prxstat->rxdw1) >> 13) & 0x1;
 
-		pattrib->seq_num = le32_to_cpu(prxstat->rxdw2) & 0x00000fff;/* u16)prxreport->seq; */
-		pattrib->frag_num = (le32_to_cpu(prxstat->rxdw2) >> 12) & 0xf;/* u8)prxreport->frag; */
-		pattrib->mfrag = (le32_to_cpu(prxstat->rxdw1) >> 27) & 0x1;/* u8)prxreport->mf; */
-		pattrib->mdata = (le32_to_cpu(prxstat->rxdw1) >> 26) & 0x1;/* u8)prxreport->md; */
+		pattrib->seq_num = le32_to_cpu(prxstat->rxdw2) & 0x00000fff;
+		pattrib->frag_num = (le32_to_cpu(prxstat->rxdw2) >> 12) & 0xf;
+		pattrib->mfrag = (le32_to_cpu(prxstat->rxdw1) >> 27) & 0x1;
+		pattrib->mdata = (le32_to_cpu(prxstat->rxdw1) >> 26) & 0x1;
 
-		pattrib->mcs_rate = le32_to_cpu(prxstat->rxdw3) & 0x3f;/* u8)prxreport->rxmcs; */
-		pattrib->rxht = (le32_to_cpu(prxstat->rxdw3) >> 6) & 0x1;/* u8)prxreport->rxht; */
+		pattrib->mcs_rate = le32_to_cpu(prxstat->rxdw3) & 0x3f;
+		pattrib->rxht = (le32_to_cpu(prxstat->rxdw3) >> 6) & 0x1;
 
-		pattrib->icv_err = (le32_to_cpu(prxstat->rxdw0) >> 15) & 0x1;/* u8)prxreport->icverr; */
+		pattrib->icv_err = (le32_to_cpu(prxstat->rxdw0) >> 15) & 0x1;
 		pattrib->shift_sz = (le32_to_cpu(prxstat->rxdw0) >> 24) & 0x3;
 	} else if (pattrib->pkt_rpt_type == TX_REPORT1) { /* CCX */
 		pattrib->pkt_len = TX_RPT1_PKT_LEN;
-	} else if (pattrib->pkt_rpt_type == TX_REPORT2) { /*  TX RPT */
-		pattrib->pkt_len = le32_to_cpu(prxstat->rxdw0) & 0x3FF;/* Rx length[9:0] */
+	} else if (pattrib->pkt_rpt_type == TX_REPORT2) {
+		pattrib->pkt_len = le32_to_cpu(prxstat->rxdw0) & 0x3FF;
 
-		/*  */
-		/*  Get TX report MAC ID valid. */
-		/*  */
 		pattrib->MacIDValidEntry[0] = le32_to_cpu(prxstat->rxdw4);
 		pattrib->MacIDValidEntry[1] = le32_to_cpu(prxstat->rxdw5);
 
-	} else if (pattrib->pkt_rpt_type == HIS_REPORT) { /*  USB HISR RPT */
-		pattrib->pkt_len = le32_to_cpu(prxstat->rxdw0) & 0x00003fff;/* u16)prxreport->pktlen; */
+	} else if (pattrib->pkt_rpt_type == HIS_REPORT) {
+		pattrib->pkt_len = le32_to_cpu(prxstat->rxdw0) & 0x00003fff;
 	}
 }
 
-- 
2.30.2

