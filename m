Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693555A92F3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 11:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiIAJSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 05:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233511AbiIAJSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:18:02 -0400
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27A9E11EB43
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 02:18:00 -0700 (PDT)
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-05 (Coremail) with SMTP id zQCowAAnL6_BeBBj7WEDAA--.2690S2;
        Thu, 01 Sep 2022 17:17:54 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, arnd@arndb.de, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH v2 1/2] virt: vbox: Add check for device_create_file
Date:   Thu,  1 Sep 2022 17:17:52 +0800
Message-Id: <20220901091752.3474095-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAAnL6_BeBBj7WEDAA--.2690S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFWxGw13uryUAr4UXr17GFg_yoW8Aw4Upa
        n3Ga43t3yrWw4jgw47Aa4qva45urWxJ3yxZrWxGw1FgrnxArsYvFWkGFyUArZ5JFZ5GF48
        Xw1UtrWrCayUuF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyK14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
        xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAK
        I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
        xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
        jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
        0EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
        7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU5WlkUUUUU
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As device_create_file() can return error number,
it should be better to check the return value and
deal with the exception.
Moreover, this driver should be using an attribute group.

Fixes: 0ba002bc4393 ("virt: Add vboxguest driver for Virtual Box Guest integration")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
Change log:

v1 -> v2:

1. Use gdev->dev instead of dev.
2. Remove file when creation failed.
---
 drivers/virt/vboxguest/vboxguest_linux.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/virt/vboxguest/vboxguest_linux.c b/drivers/virt/vboxguest/vboxguest_linux.c
index 4ccfd30c2a30..2fb9a6d91b53 100644
--- a/drivers/virt/vboxguest/vboxguest_linux.c
+++ b/drivers/virt/vboxguest/vboxguest_linux.c
@@ -390,8 +390,13 @@ static int vbg_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
 	}
 
 	pci_set_drvdata(pci, gdev);
-	device_create_file(dev, &dev_attr_host_version);
-	device_create_file(dev, &dev_attr_host_features);
+
+	ret = device_create_file(gdev->dev, &dev_attr_host_features);
+	if (ret)
+		goto err_unregister_misc_device_user;
+	ret = device_create_file(gdev->dev, &dev_attr_host_version);
+	if (ret)
+		goto err_remove_file_features;
 
 	vbg_info("vboxguest: misc device minor %d, IRQ %d, I/O port %x, MMIO at %pap (size %pap)\n",
 		 gdev->misc_device.minor, pci->irq, gdev->io_port,
@@ -399,6 +404,8 @@ static int vbg_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
 
 	return 0;
 
+err_remove_file_features:
+	device_remove_file(gdev->dev, &dev_attr_host_features);
 err_unregister_misc_device_user:
 	misc_deregister(&gdev->misc_device_user);
 err_unregister_misc_device:
-- 
2.25.1

