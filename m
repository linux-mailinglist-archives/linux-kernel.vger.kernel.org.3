Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F38535AE2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242234AbiE0H7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 03:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbiE0H7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 03:59:34 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA51522BFD;
        Fri, 27 May 2022 00:59:32 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24R74NJ7013605;
        Fri, 27 May 2022 00:58:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=LlqQ4B1a0P9MJ7iI3TRfT391yR7H/yJDfSHMiZJgOm8=;
 b=bTsUxJifrX8/XarAaJ83tfQk53Fi+xF0vsf5VSs8l6I1c6vPBjfHqKksjExXST8tuPSN
 rWHuK/iPgz59yQpD6LskVnzrdYXbYghR4P/kei0sVJ11XnYzXbVQulX7ATs3O8Lpevv3
 uzrx6QpcN/+e0y37YzKUO9GSc//xI3xJuzbt3PmcJnArop3SRSzH23e2c6p7e/v8km10
 7ARjuYt8JE/yPQ3uDqo/+9Dmqm2Vy9tSaB08kdNesaVaNSbrGx4kK5tTNgippp3vlf0y
 N02teEI1f4+f9tDcvPX3lGFoem6lLbdpATw1QQ0KBYNJQBSRL7DH8sgcnd3dGmXIma5t Yg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3gaf2rtjtp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 27 May 2022 00:58:36 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 27 May
 2022 00:58:34 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Fri, 27 May 2022 00:58:35 -0700
Received: from localhost.localdomain (unknown [10.28.34.29])
        by maili.marvell.com (Postfix) with ESMTP id 626463F7065;
        Fri, 27 May 2022 00:58:31 -0700 (PDT)
From:   Shijith Thotton <sthotton@marvell.com>
To:     Arnaud Ebalard <arno@natisbad.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Boris Brezillon <bbrezillon@kernel.org>
CC:     Shijith Thotton <sthotton@marvell.com>,
        <linux-crypto@vger.kernel.org>, <jerinj@marvell.com>,
        <sgoutham@marvell.com>, Srujana Challa <schalla@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Harman Kalra <hkalra@marvell.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] crypto: octeontx2: fix potential null pointer access
Date:   Fri, 27 May 2022 13:27:56 +0530
Message-ID: <da89ba20819ad3ca6b99f9ef056f2bc1b076dc6d.1653632699.git.sthotton@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: nCMP_Exh7aKQiqy2ZuCfjlqnzIjuv-0G
X-Proofpoint-GUID: nCMP_Exh7aKQiqy2ZuCfjlqnzIjuv-0G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-27_02,2022-05-25_02,2022-02-23_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added missing checks to avoid null pointer dereference.

The patch fixes below issues reported by klocwork tool:
1. Pointer 'pcim_iomap_table(pdev)' returned from call to function
   'pcim_iomap_table' at line 365 may be NULL and will be dereferenced
   at line 365 in otx2_cptvf_main.c. Also there is a similar error on
   line 734 in otx2_cptpf_main.c.
2. Pointer 'strsep( &val, ":" )' returned from call to function 'strsep'
   at line 1608 may be NULL and will be dereferenced at line 1608. Also
   there are 2 similar errors on lines 1620, 1632 in otx2_cptpf_ucode.c.

Signed-off-by: Shijith Thotton <sthotton@marvell.com>
---
 .../crypto/marvell/octeontx2/otx2_cptpf_main.c |  9 ++++++++-
 .../marvell/octeontx2/otx2_cptpf_ucode.c       | 18 +++++++++++++++---
 .../crypto/marvell/octeontx2/otx2_cptvf_main.c |  9 ++++++++-
 3 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c b/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
index a402ccfac557..ae57cee424f0 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
@@ -703,6 +703,7 @@ static int otx2_cptpf_probe(struct pci_dev *pdev,
 {
 	struct device *dev = &pdev->dev;
 	struct otx2_cptpf_dev *cptpf;
+	void __iomem * const *iomap;
 	int err;
 
 	cptpf = devm_kzalloc(dev, sizeof(*cptpf), GFP_KERNEL);
@@ -731,7 +732,13 @@ static int otx2_cptpf_probe(struct pci_dev *pdev,
 	pci_set_drvdata(pdev, cptpf);
 	cptpf->pdev = pdev;
 
-	cptpf->reg_base = pcim_iomap_table(pdev)[PCI_PF_REG_BAR_NUM];
+	iomap = pcim_iomap_table(pdev);
+	if (!iomap) {
+		dev_err(dev, "Failed to get iomap table\n");
+		err = -ENODEV;
+		goto clear_drvdata;
+	}
+	cptpf->reg_base = iomap[PCI_PF_REG_BAR_NUM];
 
 	/* Check if AF driver is up, otherwise defer probe */
 	err = cpt_is_pf_usable(cptpf);
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c b/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
index 9cba2f714c7e..b91401929fc6 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
@@ -1605,7 +1605,11 @@ int otx2_cpt_dl_custom_egrp_create(struct otx2_cptpf_dev *cptpf,
 		if (!strncasecmp(val, "se", 2) && strchr(val, ':')) {
 			if (has_se || ucode_idx)
 				goto err_print;
-			tmp = strim(strsep(&val, ":"));
+			tmp = strsep(&val, ":");
+			if (tmp != NULL)
+				tmp = strim(tmp);
+			else
+				goto err_print;
 			if (!val)
 				goto err_print;
 			if (strlen(tmp) != 2)
@@ -1617,7 +1621,11 @@ int otx2_cpt_dl_custom_egrp_create(struct otx2_cptpf_dev *cptpf,
 		} else if (!strncasecmp(val, "ae", 2) && strchr(val, ':')) {
 			if (has_ae || ucode_idx)
 				goto err_print;
-			tmp = strim(strsep(&val, ":"));
+			tmp = strsep(&val, ":");
+			if (tmp != NULL)
+				tmp = strim(tmp);
+			else
+				goto err_print;
 			if (!val)
 				goto err_print;
 			if (strlen(tmp) != 2)
@@ -1629,7 +1637,11 @@ int otx2_cpt_dl_custom_egrp_create(struct otx2_cptpf_dev *cptpf,
 		} else if (!strncasecmp(val, "ie", 2) && strchr(val, ':')) {
 			if (has_ie || ucode_idx)
 				goto err_print;
-			tmp = strim(strsep(&val, ":"));
+			tmp = strsep(&val, ":");
+			if (tmp != NULL)
+				tmp = strim(tmp);
+			else
+				goto err_print;
 			if (!val)
 				goto err_print;
 			if (strlen(tmp) != 2)
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c b/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
index 3411e664cf50..9249ec1783bc 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
@@ -334,6 +334,7 @@ static int otx2_cptvf_probe(struct pci_dev *pdev,
 {
 	struct device *dev = &pdev->dev;
 	struct otx2_cptvf_dev *cptvf;
+	void __iomem * const *iomap;
 	int ret;
 
 	cptvf = devm_kzalloc(dev, sizeof(*cptvf), GFP_KERNEL);
@@ -362,7 +363,13 @@ static int otx2_cptvf_probe(struct pci_dev *pdev,
 	pci_set_drvdata(pdev, cptvf);
 	cptvf->pdev = pdev;
 
-	cptvf->reg_base = pcim_iomap_table(pdev)[PCI_PF_REG_BAR_NUM];
+	iomap = pcim_iomap_table(pdev);
+	if (!iomap) {
+		dev_err(dev, "Failed to get iomap table\n");
+		ret = -ENODEV;
+		goto clear_drvdata;
+	}
+	cptvf->reg_base = iomap[PCI_PF_REG_BAR_NUM];
 
 	otx2_cpt_set_hw_caps(pdev, &cptvf->cap_flag);
 
-- 
2.25.1

