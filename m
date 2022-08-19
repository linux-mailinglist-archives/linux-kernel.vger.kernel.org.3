Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A86C599609
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 09:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347038AbiHSHaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 03:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241145AbiHSH3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 03:29:53 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392A08A7FB
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 00:29:53 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4M8Cz44qSnzGpgt;
        Fri, 19 Aug 2022 15:28:16 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 19 Aug 2022 15:29:51 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 19 Aug
 2022 15:29:50 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>
CC:     <venkataprasad.potturu@amd.com>, <Vijendar.Mukunda@amd.com>,
        <broonie@kernel.org>
Subject: [PATCH -next 3/3] ASoC: amd: acp: add a label to make error path more clean
Date:   Fri, 19 Aug 2022 15:37:58 +0800
Message-ID: <20220819073758.1273160-3-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220819073758.1273160-1-yangyingliang@huawei.com>
References: <20220819073758.1273160-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move platform_device_unregister() to a new label to make code more clean.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 sound/soc/amd/acp/acp-pci.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sound/soc/amd/acp/acp-pci.c b/sound/soc/amd/acp/acp-pci.c
index 691350646f1b..ef2ce083521e 100644
--- a/sound/soc/amd/acp/acp-pci.c
+++ b/sound/soc/amd/acp/acp-pci.c
@@ -103,16 +103,14 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
 	addr = pci_resource_start(pci, 0);
 	chip->base = devm_ioremap(&pci->dev, addr, pci_resource_len(pci, 0));
 	if (!chip->base) {
-		platform_device_unregister(dmic_dev);
 		ret = -ENOMEM;
-		goto release_regions;
+		goto unregister_dmic_dev;
 	}
 
 	res = devm_kzalloc(&pci->dev, sizeof(struct resource) * num_res, GFP_KERNEL);
 	if (!res) {
-		platform_device_unregister(dmic_dev);
 		ret = -ENOMEM;
-		goto release_regions;
+		goto unregister_dmic_dev;
 	}
 
 	for (i = 0; i < num_res; i++, res_acp++) {
@@ -139,13 +137,14 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
 	pdev = platform_device_register_full(&pdevinfo);
 	if (IS_ERR(pdev)) {
 		dev_err(&pci->dev, "cannot register %s device\n", pdevinfo.name);
-		platform_device_unregister(dmic_dev);
 		ret = PTR_ERR(pdev);
-		goto release_regions;
+		goto unregister_dmic_dev;
 	}
 
 	return ret;
 
+unregister_dmic_dev:
+	platform_device_unregister(dmic_dev);
 release_regions:
 	pci_release_regions(pci);
 disable_pci:
-- 
2.25.1

