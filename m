Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079C855E89E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346991AbiF1Nzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346983AbiF1Nzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:55:39 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9A330F64;
        Tue, 28 Jun 2022 06:55:37 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LXQzr47xSzkWL4;
        Tue, 28 Jun 2022 21:53:44 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 21:55:34 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 28 Jun
 2022 21:55:34 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
CC:     <conor.dooley@microchip.com>,
        <valentina.fernandezalanis@microchip.com>,
        <gregkh@linuxfoundation.org>
Subject: [PATCH -next] usb: musb: mpfs: add missing  clk_disable_unprepare() in mpfs_remove()
Date:   Tue, 28 Jun 2022 22:05:27 +0800
Message-ID: <20220628140527.1404439-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

clock source is prepared and enabled by clk_prepare_enable()
in probe function, but no disable or unprepare in remove.

Fixes: 7a96b6ea90a4 ("usb: musb: Add support for PolarFire SoC's musb controller")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/usb/musb/mpfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/musb/mpfs.c b/drivers/usb/musb/mpfs.c
index a69ca338eace..cea2e8108867 100644
--- a/drivers/usb/musb/mpfs.c
+++ b/drivers/usb/musb/mpfs.c
@@ -239,6 +239,7 @@ static int mpfs_remove(struct platform_device *pdev)
 {
 	struct mpfs_glue *glue = platform_get_drvdata(pdev);
 
+	clk_disable_unprepare(glue->clk);
 	platform_device_unregister(glue->musb);
 	usb_phy_generic_unregister(pdev);
 
-- 
2.25.1

