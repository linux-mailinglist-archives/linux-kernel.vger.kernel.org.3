Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99DE949BB44
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 19:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbiAYS1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 13:27:33 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:57442 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231579AbiAYS11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 13:27:27 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20PCAuXq025182;
        Tue, 25 Jan 2022 10:27:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=+h39RChS+0CN9mJaBI6E+sK09CmnAMsUeduNbnMVVUA=;
 b=SEQ7WYfGIhigSdDd6nnDC6icR0g56SOV6xMTxh5h3s0ds0Ad7mMR4aJrgNRHF5kOoWAd
 hev2nE8tk4EAVW2k2GNMwpNboJsV3/iuVJSeRVxo2QwTR/3Y+1f1tuFOtMkoub3hDvTG
 e67DZkmRPdnRwLWKGXUf6/SaSneh4Pkq6S6O4s38mQUBNv+J/5nmXvGRW0pY75zUB0tu
 OHV7790uvrZ3NIzpAmR8ZPmqPjAnao81Kw4D/uf4N1qgYdZHRxcMY8mr61ElrrlacSgn
 y3EhL+CcUOrlIQVElSQcoW/KMaR3yTgizZ/LGDH113KcQanmx+yUEWqZVooVV6N52Aop IA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3dt8muk0gr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 10:27:17 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 25 Jan
 2022 10:27:15 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 25 Jan 2022 10:27:15 -0800
Received: from localhost.localdomain (unknown [10.28.34.29])
        by maili.marvell.com (Postfix) with ESMTP id 108EC5E6867;
        Tue, 25 Jan 2022 10:27:11 -0800 (PST)
From:   Shijith Thotton <sthotton@marvell.com>
To:     Arnaud Ebalard <arno@natisbad.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Boris Brezillon <bbrezillon@kernel.org>
CC:     Srujana Challa <schalla@marvell.com>,
        <linux-crypto@vger.kernel.org>, <jerinj@marvell.com>,
        <sgoutham@marvell.com>, Shijith Thotton <sthotton@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] crypto: octeontx2: increase CPT HW instruction queue length
Date:   Tue, 25 Jan 2022 23:56:24 +0530
Message-ID: <2088adbb37511e84b963fbcd6eff16c62610e2d2.1643134404.git.sthotton@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ab2269cb3ef3049ed0ab73f28be29f6669a06e36.1643134480.git.sthotton@marvell.com>
References: <ab2269cb3ef3049ed0ab73f28be29f6669a06e36.1643134480.git.sthotton@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: i5xHCSonRquudcMAxgH8-RdPxuDR79-9
X-Proofpoint-GUID: i5xHCSonRquudcMAxgH8-RdPxuDR79-9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-25_03,2022-01-25_02,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srujana Challa <schalla@marvell.com>

LDWB is getting incorrectly used in HW when
CPT_AF_LF()_PTR_CTL[IQB_LDWB]=1 and CPT instruction queue has less than
320 free entries. So, increase HW instruction queue size by 320 and give
320 entries less for SW/NIX RX as a SW workaround.

Signed-off-by: Srujana Challa <schalla@marvell.com>
Signed-off-by: Shijith Thotton <sthotton@marvell.com>
---
 drivers/crypto/marvell/octeontx2/otx2_cptlf.h | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptlf.h b/drivers/crypto/marvell/octeontx2/otx2_cptlf.h
index b691b6c1d5c4..4fcaf61a70e3 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptlf.h
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptlf.h
@@ -26,12 +26,22 @@
  */
 #define OTX2_CPT_INST_QLEN_MSGS	((OTX2_CPT_SIZE_DIV40 - 1) * 40)
 
+/*
+ * LDWB is getting incorrectly used when IQB_LDWB = 1 and CPT instruction
+ * queue has less than 320 free entries. So, increase HW instruction queue
+ * size by 320 and give 320 entries less for SW/NIX RX as a workaround.
+ */
+#define OTX2_CPT_INST_QLEN_EXTRA_BYTES  (320 * OTX2_CPT_INST_SIZE)
+#define OTX2_CPT_EXTRA_SIZE_DIV40       (320/40)
+
 /* CPT instruction queue length in bytes */
-#define OTX2_CPT_INST_QLEN_BYTES (OTX2_CPT_SIZE_DIV40 * 40 * \
-				  OTX2_CPT_INST_SIZE)
+#define OTX2_CPT_INST_QLEN_BYTES                                               \
+		((OTX2_CPT_SIZE_DIV40 * 40 * OTX2_CPT_INST_SIZE) +             \
+		OTX2_CPT_INST_QLEN_EXTRA_BYTES)
 
 /* CPT instruction group queue length in bytes */
-#define OTX2_CPT_INST_GRP_QLEN_BYTES (OTX2_CPT_SIZE_DIV40 * 16)
+#define OTX2_CPT_INST_GRP_QLEN_BYTES                                           \
+		((OTX2_CPT_SIZE_DIV40 + OTX2_CPT_EXTRA_SIZE_DIV40) * 16)
 
 /* CPT FC length in bytes */
 #define OTX2_CPT_Q_FC_LEN 128
@@ -179,7 +189,8 @@ static inline void otx2_cptlf_do_set_iqueue_size(struct otx2_cptlf_info *lf)
 {
 	union otx2_cptx_lf_q_size lf_q_size = { .u = 0x0 };
 
-	lf_q_size.s.size_div40 = OTX2_CPT_SIZE_DIV40;
+	lf_q_size.s.size_div40 = OTX2_CPT_SIZE_DIV40 +
+				 OTX2_CPT_EXTRA_SIZE_DIV40;
 	otx2_cpt_write64(lf->lfs->reg_base, BLKADDR_CPT0, lf->slot,
 			 OTX2_CPT_LF_Q_SIZE, lf_q_size.u);
 }
-- 
2.25.1

