Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905A34ED645
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbiCaIx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbiCaIxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:53:54 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B006A078;
        Thu, 31 Mar 2022 01:52:02 -0700 (PDT)
Received: from kwepemi100002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KTcVP524SzdZPx;
        Thu, 31 Mar 2022 16:51:41 +0800 (CST)
Received: from kwepeml500002.china.huawei.com (7.221.188.128) by
 kwepemi100002.china.huawei.com (7.221.188.188) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 31 Mar 2022 16:52:00 +0800
Received: from huawei.com (10.175.104.82) by kwepeml500002.china.huawei.com
 (7.221.188.128) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 31 Mar
 2022 16:52:00 +0800
From:   Huang Guobin <huangguobin4@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tty: Fix a possible resource leak in icom_probe
Date:   Thu, 31 Mar 2022 17:10:05 +0800
Message-ID: <20220331091005.3290753-1-huangguobin4@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepeml500002.china.huawei.com (7.221.188.128)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When pci_read_config_dword failed, call pci_release_regions() and
pci_disable_device() to recycle the resource previously allocated.

Signed-off-by: Huang Guobin <huangguobin4@huawei.com>
---
 drivers/tty/serial/icom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/icom.c b/drivers/tty/serial/icom.c
index 03a2fe9f4c9a..02b375ba2f07 100644
--- a/drivers/tty/serial/icom.c
+++ b/drivers/tty/serial/icom.c
@@ -1501,7 +1501,7 @@ static int icom_probe(struct pci_dev *dev,
 	retval = pci_read_config_dword(dev, PCI_COMMAND, &command_reg);
 	if (retval) {
 		dev_err(&dev->dev, "PCI Config read FAILED\n");
-		return retval;
+		goto probe_exit0;
 	}
 
 	pci_write_config_dword(dev, PCI_COMMAND,
-- 
2.25.1

