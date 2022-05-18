Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1F552B086
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 04:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbiERCp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 22:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbiERCpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 22:45:22 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5408E2D1E9;
        Tue, 17 May 2022 19:45:20 -0700 (PDT)
Received: from kwepemi500014.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L2y3x2ft8z1JCDy;
        Wed, 18 May 2022 10:43:57 +0800 (CST)
Received: from huawei.com (10.67.174.157) by kwepemi500014.china.huawei.com
 (7.221.188.232) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 18 May
 2022 10:45:17 +0800
From:   Li Zhengyu <lizhengyu3@huawei.com>
To:     <dbaryshkov@gmail.com>
CC:     <stern@rowland.harvard.edu>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] usb: host: ohci-tmio: Remove redundant if statement
Date:   Wed, 18 May 2022 10:43:47 +0800
Message-ID: <20220518024347.213402-1-lizhengyu3@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.157]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500014.china.huawei.com (7.221.188.232)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(ret == 0) is true when (ret) is false, so remove it.
Also remove unreachable code.

Signed-off-by: Li Zhengyu <lizhengyu3@huawei.com>
---
 drivers/usb/host/ohci-tmio.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/usb/host/ohci-tmio.c b/drivers/usb/host/ohci-tmio.c
index 49539b9f0e94..6bcb0cb53f7c 100644
--- a/drivers/usb/host/ohci-tmio.c
+++ b/drivers/usb/host/ohci-tmio.c
@@ -243,12 +243,8 @@ static int ohci_hcd_tmio_drv_probe(struct platform_device *dev)
 	ret = usb_add_hcd(hcd, irq, 0);
 	if (ret)
 		goto err_add_hcd;
-
 	device_wakeup_enable(hcd->self.controller);
-	if (ret == 0)
-		return ret;
-
-	usb_remove_hcd(hcd);
+	return ret;
 
 err_add_hcd:
 	tmio_stop_hc(dev);
-- 
2.17.1

