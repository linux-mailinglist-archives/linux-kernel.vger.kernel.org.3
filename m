Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E15249BB45
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 19:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbiAYS1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 13:27:38 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:32522 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231648AbiAYS11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 13:27:27 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20PBvEBN025025;
        Tue, 25 Jan 2022 10:27:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=Hag+V4dTl1FKxWjDLKyfP1UsEo2dP9jEeUF8/qk66Hc=;
 b=Rote/Pye2onCI8K2noKdvt2w4MDD3v56TpV1pDjY7mdPhfCw9LO24vnDxnmE7u+E7Fy8
 eAz627TRxfB8WcdpxtFgTJGawYVZCs/sSiRJjFOyyrTauhhVwwC45znoW7Bk9CNfyjRl
 gfbkiSsym1kAflm2NxktSj5RieYBWcpTtEiKY7uGQ1tfMAKGyK/9nj260uvE5TxcOq0l
 sOIpIUKMX6C04iWxO2shvYeQoQlaTlxQbvP1diYH05gwz7dIBLxI3l7yFAN10tMjm6WE
 sHI8dN3eynlnGZbM0UqgrGNxBeP8b9GNhuOnXsXhzr1oXL8gyM6YtHXpIelKaIWLlqW6 TQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3dt8muk0fw-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 10:27:04 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 25 Jan
 2022 10:27:02 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 25 Jan 2022 10:27:02 -0800
Received: from localhost.localdomain (unknown [10.28.34.29])
        by maili.marvell.com (Postfix) with ESMTP id D7E375E6868;
        Tue, 25 Jan 2022 10:26:58 -0800 (PST)
From:   Shijith Thotton <sthotton@marvell.com>
To:     Arnaud Ebalard <arno@natisbad.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Boris Brezillon <bbrezillon@kernel.org>
CC:     Srujana Challa <schalla@marvell.com>,
        <linux-crypto@vger.kernel.org>, <jerinj@marvell.com>,
        <sgoutham@marvell.com>, Shijith Thotton <sthotton@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] crypto: octeontx2: CN10K CPT to RNM workaround
Date:   Tue, 25 Jan 2022 23:56:22 +0530
Message-ID: <ab2269cb3ef3049ed0ab73f28be29f6669a06e36.1643134480.git.sthotton@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: BGR3gVtfA4ao3ejI6oAShdfYzRYB1cq7
X-Proofpoint-GUID: BGR3gVtfA4ao3ejI6oAShdfYzRYB1cq7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-25_03,2022-01-25_02,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srujana Challa <schalla@marvell.com>

When software sets CPT_AF_CTL[RNM_REQ_EN]=1 and RNM in not producing
entropy(i.e., RNM_ENTROPY_STATUS[NORMAL_CNT] < 0x40), the first cycle of
the response may be lost due to a conditional clocking issue. Due to
this, the subsequent random number stream will be corrupted. So, this
patch adds support to ensure RNM_ENTROPY_STATUS[NORMAL_CNT] = 0x40
before writing CPT_AF_CTL[RNM_REQ_EN] = 1, as a workaround.

Signed-off-by: Srujana Challa <schalla@marvell.com>
Signed-off-by: Shijith Thotton <sthotton@marvell.com>
---
 .../marvell/octeontx2/otx2_cptpf_ucode.c      | 43 ++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c b/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
index 4c8ebdf671ca..addc760501a9 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
@@ -1076,6 +1076,39 @@ static void delete_engine_grps(struct pci_dev *pdev,
 		delete_engine_group(&pdev->dev, &eng_grps->grp[i]);
 }
 
+#define PCI_DEVID_CN10K_RNM 0xA098
+#define RNM_ENTROPY_STATUS  0x8
+
+static void rnm_to_cpt_errata_fixup(struct device *dev)
+{
+	struct pci_dev *pdev;
+	void __iomem *base;
+	int timeout = 5000;
+
+	pdev = pci_get_device(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_CN10K_RNM, NULL);
+	if (!pdev)
+		return;
+
+	base = pci_ioremap_bar(pdev, 0);
+	if (!base)
+		goto put_pdev;
+
+	while ((readq(base + RNM_ENTROPY_STATUS) & 0x7F) != 0x40) {
+		cpu_relax();
+		udelay(1);
+		timeout--;
+		if (!timeout) {
+			dev_warn(dev, "RNM is not producing entropy\n");
+			break;
+		}
+	}
+
+	iounmap(base);
+
+put_pdev:
+	pci_dev_put(pdev);
+}
+
 int otx2_cpt_get_eng_grp(struct otx2_cpt_eng_grps *eng_grps, int eng_type)
 {
 
@@ -1189,9 +1222,17 @@ int otx2_cpt_create_eng_grps(struct otx2_cptpf_dev *cptpf,
 
 	if (is_dev_otx2(pdev))
 		goto unlock;
+
+	/*
+	 * Ensure RNM_ENTROPY_STATUS[NORMAL_CNT] = 0x40 before writing
+	 * CPT_AF_CTL[RNM_REQ_EN] = 1 as a workaround for HW errata.
+	 */
+	rnm_to_cpt_errata_fixup(&pdev->dev);
+
 	/*
 	 * Configure engine group mask to allow context prefetching
-	 * for the groups.
+	 * for the groups and enable random number request, to enable
+	 * CPT to request random numbers from RNM.
 	 */
 	otx2_cpt_write_af_reg(&cptpf->afpf_mbox, pdev, CPT_AF_CTL,
 			      OTX2_CPT_ALL_ENG_GRPS_MASK << 3 | BIT_ULL(16),
-- 
2.25.1

