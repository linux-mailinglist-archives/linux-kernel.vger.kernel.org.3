Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF575A9850
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbiIANTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234270AbiIANSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:18:43 -0400
Received: from cstnet.cn (smtp23.cstnet.cn [159.226.251.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D78A079EF8
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 06:15:52 -0700 (PDT)
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-03 (Coremail) with SMTP id rQCowADHvFFbsBBjmkMbAA--.34673S2;
        Thu, 01 Sep 2022 21:15:08 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, arnd@arndb.de, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH v3 1/2] virt: vbox: Add check for device_create_file
Date:   Thu,  1 Sep 2022 21:15:06 +0800
Message-Id: <20220901131506.3550180-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowADHvFFbsBBjmkMbAA--.34673S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFWxGw13uryUAr4UXFyUAwb_yoW8tw4Upa
        93Ja4SvF4fGa1UWw42ya4jva45uw1rG3yxZrZ3Gw4Fgr9xA39FvFWDCFWjyr95GFZ5WF4F
        qr1UtryrCFWUuF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48J
        MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
        AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
        0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
        v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
        14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU5WlkUUUUU
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

v2-> v3:

1. Switch to use an attribute group.

v1 -> v2:

1. Use gdev->dev instead of dev.
2. Remove file when creation failed.
---
 drivers/virt/vboxguest/vboxguest_linux.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/virt/vboxguest/vboxguest_linux.c b/drivers/virt/vboxguest/vboxguest_linux.c
index 4ccfd30c2a30..6fc81347ae72 100644
--- a/drivers/virt/vboxguest/vboxguest_linux.c
+++ b/drivers/virt/vboxguest/vboxguest_linux.c
@@ -270,6 +270,13 @@ static ssize_t host_features_show(struct device *dev,
 static DEVICE_ATTR_RO(host_version);
 static DEVICE_ATTR_RO(host_features);
 
+static struct attribute *vbg_pci_attrs[] = {
+	&dev_attr_host_version.attr,
+	&dev_attr_host_features.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(vbg_pci);
+
 /**
  * Does the PCI detection and init of the device.
  *
@@ -390,8 +397,6 @@ static int vbg_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
 	}
 
 	pci_set_drvdata(pci, gdev);
-	device_create_file(dev, &dev_attr_host_version);
-	device_create_file(dev, &dev_attr_host_features);
 
 	vbg_info("vboxguest: misc device minor %d, IRQ %d, I/O port %x, MMIO at %pap (size %pap)\n",
 		 gdev->misc_device.minor, pci->irq, gdev->io_port,
@@ -422,8 +427,6 @@ static void vbg_pci_remove(struct pci_dev *pci)
 	mutex_unlock(&vbg_gdev_mutex);
 
 	free_irq(pci->irq, gdev);
-	device_remove_file(gdev->dev, &dev_attr_host_features);
-	device_remove_file(gdev->dev, &dev_attr_host_version);
 	misc_deregister(&gdev->misc_device_user);
 	misc_deregister(&gdev->misc_device);
 	vbg_core_exit(gdev);
@@ -488,6 +491,7 @@ MODULE_DEVICE_TABLE(pci,  vbg_pci_ids);
 
 static struct pci_driver vbg_pci_driver = {
 	.name		= DEVICE_NAME,
+	.dev_groups	= vbg_pci_groups,
 	.id_table	= vbg_pci_ids,
 	.probe		= vbg_pci_probe,
 	.remove		= vbg_pci_remove,
-- 
2.25.1

