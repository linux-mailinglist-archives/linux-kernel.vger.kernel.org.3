Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4EE5650AA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbiGDJZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiGDJZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:25:25 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C440A656D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 02:25:24 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Lc0j81JWJzkWtR;
        Mon,  4 Jul 2022 17:23:24 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Jul 2022 17:25:22 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Jul
 2022 17:25:22 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <john.garry@huawei.com>,
        <rafael@kernel.org>
CC:     <andriy.shevchenko@linux.intel.com>, <gregkh@linuxfoundation.org>
Subject: [PATCH v2] bus: hisi_lpc: fix missing platform_device_put() in hisi_lpc_acpi_probe()
Date:   Mon, 4 Jul 2022 17:34:56 +0800
Message-ID: <20220704093456.1405484-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

In error case in hisi_lpc_acpi_probe() after calling platform_device_alloc(),
if platform_device_add() is not called successfully, hisi_lpc_acpi_remove()
can't release the failed 'pdev' including its resource and data, so they will
be leaked, call platform_device_put() to put the refcount, then they will be
freed in platform_device_release().
I'v constructed this error case and tested this patch on D05 board.

Fixes: 99c0228d6ff1 ("HISI LPC: Re-Add ACPI child enumeration support")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
v2:
  - keep declartion of pdev reverse-firtree ordering
  - update commit message
---
 drivers/bus/hisi_lpc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
index 378f5d62a991..05e9357bf006 100644
--- a/drivers/bus/hisi_lpc.c
+++ b/drivers/bus/hisi_lpc.c
@@ -502,6 +502,7 @@ static void hisi_lpc_acpi_remove(struct device *hostdev)
 static int hisi_lpc_acpi_probe(struct device *hostdev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(hostdev);
+	struct platform_device *pdev;
 	struct acpi_device *child;
 	int ret;
 
@@ -509,7 +510,6 @@ static int hisi_lpc_acpi_probe(struct device *hostdev)
 	list_for_each_entry(child, &adev->children, node) {
 		const char *hid = acpi_device_hid(child);
 		const struct hisi_lpc_acpi_cell *cell;
-		struct platform_device *pdev;
 		const struct resource *res;
 		bool found = false;
 		int num_res;
@@ -571,22 +571,24 @@ static int hisi_lpc_acpi_probe(struct device *hostdev)
 
 		ret = platform_device_add_resources(pdev, res, num_res);
 		if (ret)
-			goto fail;
+			goto fail_put_device;
 
 		ret = platform_device_add_data(pdev, cell->pdata,
 					       cell->pdata_size);
 		if (ret)
-			goto fail;
+			goto fail_put_device;
 
 		ret = platform_device_add(pdev);
 		if (ret)
-			goto fail;
+			goto fail_put_device;
 
 		acpi_device_set_enumerated(child);
 	}
 
 	return 0;
 
+fail_put_device:
+	platform_device_put(pdev);
 fail:
 	hisi_lpc_acpi_remove(hostdev);
 	return ret;
-- 
2.25.1

