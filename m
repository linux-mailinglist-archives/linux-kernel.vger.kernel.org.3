Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3EA64E961A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 14:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242146AbiC1MBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 08:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242112AbiC1MB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 08:01:26 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209EEE18
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:59:46 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KRrmD2cyWzCr9S;
        Mon, 28 Mar 2022 19:57:32 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Mar 2022 19:59:43 +0800
Received: from ubuntu1804.huawei.com (10.67.174.152) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Mar 2022 19:59:43 +0800
From:   Wang Weiyang <wangweiyang2@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <sheng@linux.intel.com>, <bruce.j.beare@intel.com>,
        <xiaohui.xin@intel.com>, <yunhong.jiang@intel.com>,
        <arve@google.com>
CC:     <linux-kernel@vger.kernel.org>, <wangweiyang2@huawei.com>
Subject: [PATCH] tty: goldfish: Use tty_port_destroy() to destroy port
Date:   Mon, 28 Mar 2022 19:58:44 +0800
Message-ID: <20220328115844.86032-1-wangweiyang2@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.152]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In goldfish_tty_probe(), the port initialized through tty_port_init()
should be destroyed in error paths.In goldfish_tty_remove(), qtty->port
also should be destroyed or else might leak resources.

Fix the above by calling tty_port_destroy().

Fixes: 666b7793d4bf ("goldfish: tty driver")
Signed-off-by: Wang Weiyang <wangweiyang2@huawei.com>
---
 drivers/tty/goldfish.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/goldfish.c b/drivers/tty/goldfish.c
index ad13532e92fe..9e1168c39e77 100644
--- a/drivers/tty/goldfish.c
+++ b/drivers/tty/goldfish.c
@@ -405,6 +405,7 @@ static int goldfish_tty_probe(struct platform_device *pdev)
 err_tty_register_device_failed:
 	free_irq(irq, qtty);
 err_dec_line_count:
+	tty_port_destroy(&qtty->port);
 	goldfish_tty_current_line_count--;
 	if (goldfish_tty_current_line_count == 0)
 		goldfish_tty_delete_driver();
@@ -426,6 +427,7 @@ static int goldfish_tty_remove(struct platform_device *pdev)
 	iounmap(qtty->base);
 	qtty->base = NULL;
 	free_irq(qtty->irq, pdev);
+	tty_port_destroy(&qtty->port);
 	goldfish_tty_current_line_count--;
 	if (goldfish_tty_current_line_count == 0)
 		goldfish_tty_delete_driver();
-- 
2.17.1

