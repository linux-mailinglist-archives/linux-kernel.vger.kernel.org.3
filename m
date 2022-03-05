Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA834CE553
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 15:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbiCEOmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 09:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbiCEOmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 09:42:33 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5C16929A
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 06:41:43 -0800 (PST)
Received: from dslb-084-059-247-134.084.059.pools.vodafone-ip.de ([84.59.247.134] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nQVbH-0007ms-9q; Sat, 05 Mar 2022 15:41:39 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 4/5] staging: r8188eu: remove unnecessary casts
Date:   Sat,  5 Mar 2022 15:41:16 +0100
Message-Id: <20220305144117.1380534-5-martin@kaiser.cx>
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

Remove unnecessary casts in update_recvframe_attrib_88e.

The final bitwise-and limits the results to u8 or u16, respectively.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c | 36 +++++++++----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c b/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
index 6b83d7e80ad9..cbc3ce34a50d 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
@@ -60,39 +60,39 @@ void update_recvframe_attrib_88e(struct recv_frame *precvframe, struct recv_stat
 	struct rx_pkt_attrib *pattrib = &precvframe->attrib;
 	memset(pattrib, 0, sizeof(struct rx_pkt_attrib));
 
-	pattrib->crc_err = (u8)((le32_to_cpu(prxstat->rxdw0) >> 14) & 0x1);/* u8)prxreport->crc32; */
+	pattrib->crc_err = (le32_to_cpu(prxstat->rxdw0) >> 14) & 0x1;/* u8)prxreport->crc32; */
 
 	/*  update rx report to recv_frame attribute */
-	pattrib->pkt_rpt_type = (u8)((le32_to_cpu(prxstat->rxdw3) >> 14) & 0x3);/* prxreport->rpt_sel; */
+	pattrib->pkt_rpt_type = (le32_to_cpu(prxstat->rxdw3) >> 14) & 0x3;/* prxreport->rpt_sel; */
 
 	if (pattrib->pkt_rpt_type == NORMAL_RX) { /* Normal rx packet */
-		pattrib->pkt_len = (u16)(le32_to_cpu(prxstat->rxdw0) & 0x00003fff);/* u16)prxreport->pktlen; */
-		pattrib->drvinfo_sz = (u8)((le32_to_cpu(prxstat->rxdw0) >> 16) & 0xf) * 8;/* u8)(prxreport->drvinfosize << 3); */
+		pattrib->pkt_len = le32_to_cpu(prxstat->rxdw0) & 0x00003fff;/* u16)prxreport->pktlen; */
+		pattrib->drvinfo_sz = ((le32_to_cpu(prxstat->rxdw0) >> 16) & 0xf) * 8;/* u8)(prxreport->drvinfosize << 3); */
 
-		pattrib->physt =  (u8)((le32_to_cpu(prxstat->rxdw0) >> 26) & 0x1);/* u8)prxreport->physt; */
+		pattrib->physt = (le32_to_cpu(prxstat->rxdw0) >> 26) & 0x1;/* u8)prxreport->physt; */
 
 		pattrib->bdecrypted = (le32_to_cpu(prxstat->rxdw0) & BIT(27)) ? 0 : 1;/* u8)(prxreport->swdec ? 0 : 1); */
-		pattrib->encrypt = (u8)((le32_to_cpu(prxstat->rxdw0) >> 20) & 0x7);/* u8)prxreport->security; */
+		pattrib->encrypt = (le32_to_cpu(prxstat->rxdw0) >> 20) & 0x7;/* u8)prxreport->security; */
 
 		pattrib->qos = (le32_to_cpu(prxstat->rxdw0) >> 23) & 0x1;/* prxreport->qos; */
-		pattrib->priority = (u8)((le32_to_cpu(prxstat->rxdw1) >> 8) & 0xf);/* u8)prxreport->tid; */
+		pattrib->priority = (le32_to_cpu(prxstat->rxdw1) >> 8) & 0xf;/* u8)prxreport->tid; */
 
-		pattrib->amsdu = (u8)((le32_to_cpu(prxstat->rxdw1) >> 13) & 0x1);/* u8)prxreport->amsdu; */
+		pattrib->amsdu = (le32_to_cpu(prxstat->rxdw1) >> 13) & 0x1;/* u8)prxreport->amsdu; */
 
-		pattrib->seq_num = (u16)(le32_to_cpu(prxstat->rxdw2) & 0x00000fff);/* u16)prxreport->seq; */
-		pattrib->frag_num = (u8)((le32_to_cpu(prxstat->rxdw2) >> 12) & 0xf);/* u8)prxreport->frag; */
-		pattrib->mfrag = (u8)((le32_to_cpu(prxstat->rxdw1) >> 27) & 0x1);/* u8)prxreport->mf; */
-		pattrib->mdata = (u8)((le32_to_cpu(prxstat->rxdw1) >> 26) & 0x1);/* u8)prxreport->md; */
+		pattrib->seq_num = le32_to_cpu(prxstat->rxdw2) & 0x00000fff;/* u16)prxreport->seq; */
+		pattrib->frag_num = (le32_to_cpu(prxstat->rxdw2) >> 12) & 0xf;/* u8)prxreport->frag; */
+		pattrib->mfrag = (le32_to_cpu(prxstat->rxdw1) >> 27) & 0x1;/* u8)prxreport->mf; */
+		pattrib->mdata = (le32_to_cpu(prxstat->rxdw1) >> 26) & 0x1;/* u8)prxreport->md; */
 
-		pattrib->mcs_rate = (u8)(le32_to_cpu(prxstat->rxdw3) & 0x3f);/* u8)prxreport->rxmcs; */
-		pattrib->rxht = (u8)((le32_to_cpu(prxstat->rxdw3) >> 6) & 0x1);/* u8)prxreport->rxht; */
+		pattrib->mcs_rate = le32_to_cpu(prxstat->rxdw3) & 0x3f;/* u8)prxreport->rxmcs; */
+		pattrib->rxht = (le32_to_cpu(prxstat->rxdw3) >> 6) & 0x1;/* u8)prxreport->rxht; */
 
-		pattrib->icv_err = (u8)((le32_to_cpu(prxstat->rxdw0) >> 15) & 0x1);/* u8)prxreport->icverr; */
-		pattrib->shift_sz = (u8)((le32_to_cpu(prxstat->rxdw0) >> 24) & 0x3);
+		pattrib->icv_err = (le32_to_cpu(prxstat->rxdw0) >> 15) & 0x1;/* u8)prxreport->icverr; */
+		pattrib->shift_sz = (le32_to_cpu(prxstat->rxdw0) >> 24) & 0x3;
 	} else if (pattrib->pkt_rpt_type == TX_REPORT1) { /* CCX */
 		pattrib->pkt_len = TX_RPT1_PKT_LEN;
 	} else if (pattrib->pkt_rpt_type == TX_REPORT2) { /*  TX RPT */
-		pattrib->pkt_len = (u16)(le32_to_cpu(prxstat->rxdw0) & 0x3FF);/* Rx length[9:0] */
+		pattrib->pkt_len = le32_to_cpu(prxstat->rxdw0) & 0x3FF;/* Rx length[9:0] */
 
 		/*  */
 		/*  Get TX report MAC ID valid. */
@@ -101,7 +101,7 @@ void update_recvframe_attrib_88e(struct recv_frame *precvframe, struct recv_stat
 		pattrib->MacIDValidEntry[1] = le32_to_cpu(prxstat->rxdw5);
 
 	} else if (pattrib->pkt_rpt_type == HIS_REPORT) { /*  USB HISR RPT */
-		pattrib->pkt_len = (u16)(le32_to_cpu(prxstat->rxdw0) & 0x00003fff);/* u16)prxreport->pktlen; */
+		pattrib->pkt_len = le32_to_cpu(prxstat->rxdw0) & 0x00003fff;/* u16)prxreport->pktlen; */
 	}
 }
 
-- 
2.30.2

