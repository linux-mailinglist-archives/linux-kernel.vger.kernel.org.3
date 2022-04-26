Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204EE50FBB9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 13:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349407AbiDZLM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 07:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbiDZLM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 07:12:57 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB2342A01
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 04:09:49 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KnfJk3cF5zfbD5;
        Tue, 26 Apr 2022 19:08:54 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 19:09:47 +0800
From:   Yuan Can <yuancan@huawei.com>
To:     <linux-phy@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <kishon@ti.com>,
        <vkoul@kernel.org>, <mchehab+huawei@kernel.org>,
        <dan.carpenter@oracle.com>, <mani@kernel.org>, <yuancan@huawei.com>
Subject: [PATCH -next] phy: hisilicon: Add resource release in hi3670_pcie_get_resources_from_pcie
Date:   Tue, 26 Apr 2022 11:05:43 +0000
Message-ID: <20220426110543.49726-1-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reference count of pcie_port and pcie_dev should be decremented when
error occurs.

Fixes: 73075011ffff8 (phy: HiSilicon: Add driver for Kirin 970 PCIe PHY)
Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 drivers/phy/hisilicon/phy-hi3670-pcie.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/phy/hisilicon/phy-hi3670-pcie.c b/drivers/phy/hisilicon/phy-hi3670-pcie.c
index 0ac9634b398d..77c9c72d939e 100644
--- a/drivers/phy/hisilicon/phy-hi3670-pcie.c
+++ b/drivers/phy/hisilicon/phy-hi3670-pcie.c
@@ -567,6 +567,7 @@ static int hi3670_pcie_get_resources_from_pcie(struct hi3670_pcie_phy *phy)
 	pcie_dev = bus_find_device_by_of_node(&platform_bus_type, pcie_port);
 	if (!pcie_dev) {
 		dev_err(dev, "Didn't find pcie device\n");
+		of_node_put(pcie_port);
 		return -ENODEV;
 	}
 
@@ -581,6 +582,8 @@ static int hi3670_pcie_get_resources_from_pcie(struct hi3670_pcie_phy *phy)
 	phy->apb = dev_get_regmap(pcie_dev, "kirin_pcie_apb");
 	if (!phy->apb) {
 		dev_err(dev, "Failed to get APB regmap\n");
+		put_device(pcie_dev);
+		of_node_put(pcie_port);
 		return -ENODEV;
 	}
 
-- 
2.17.1

