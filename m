Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487DD5A7555
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 06:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiHaE7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 00:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiHaE73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 00:59:29 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68E49B6012;
        Tue, 30 Aug 2022 21:59:27 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxYOKi6g5j_2UNAA--.59804S2;
        Wed, 31 Aug 2022 12:59:20 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <greg@kroah.com>,
        Patchwork Bot <patchwork-bot@kernel.org>
Cc:     zhuyinbo@loongson.cn
Subject: [PATCH v2] usb: ohci-platform: fix usb disconnect issue after s4
Date:   Wed, 31 Aug 2022 12:59:10 +0800
Message-Id: <20220831045910.12203-1-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxYOKi6g5j_2UNAA--.59804S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF47CrW3JFWUJr1rtFyxZrb_yoWrJFW3pr
        4UJFWrtr48KF42g3y7twn7ZFWrCw4Sg3y7K348Kw1jv398tr98Jay2vFy0yFn3Xry7Gw17
        tF4jyFWUuF4UZr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
        1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVCm-wCF
        04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid retaining bogus hardware states during resume-from-hibernation.
Previously we had reset the hardware as part of preparing to reinstate
the snapshot image. But we can do better now with the new PM framework,
since we know exactly which resume operations are from hibernation.

According to the commit 'cd1965db054e ("USB: ohci: move ohci_pci_{
suspend,resume} to ohci-hcd.c")' and commit '6ec4beb5c701 ("USB: new
flag for resume-from-hibernation")', the flag "hibernated" is for
resume-from-hibernation and it should be true when usb resume from disk.

When this flag "hibernated" is set, the drivers will reset the hardware
to get rid of any existing state and make sure resume from hibernation
re-enumerates everything for ohci.

Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
---
Change in v2:
		1. Revise the commit log infomation.	
		2. Wrap the ohci_platform_renew() function with two 
		   helpers that are ohci_platform_renew_hibernated() 
		   and ohci_platform_renew().

 drivers/usb/host/ohci-platform.c | 49 ++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
index 0adae6265127..56cb424d3bb0 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -289,7 +289,7 @@ static int ohci_platform_suspend(struct device *dev)
 	return ret;
 }
 
-static int ohci_platform_resume(struct device *dev)
+static int ohci_platform_renew(struct device *dev)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
 	struct usb_ohci_pdata *pdata = dev_get_platdata(dev);
@@ -297,6 +297,7 @@ static int ohci_platform_resume(struct device *dev)
 
 	if (pdata->power_on) {
 		int err = pdata->power_on(pdev);
+
 		if (err < 0)
 			return err;
 	}
@@ -309,6 +310,38 @@ static int ohci_platform_resume(struct device *dev)
 
 	return 0;
 }
+
+static int ohci_platform_renew_hibernated(struct device *dev)
+{
+	struct usb_hcd *hcd = dev_get_drvdata(dev);
+	struct usb_ohci_pdata *pdata = dev_get_platdata(dev);
+	struct platform_device *pdev = to_platform_device(dev);
+
+	if (pdata->power_on) {
+		int err = pdata->power_on(pdev);
+
+		if (err < 0)
+			return err;
+	}
+
+	ohci_resume(hcd, true);
+
+	pm_runtime_disable(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	return 0;
+}
+
+static int ohci_platform_resume(struct device *dev)
+{
+	return ohci_platform_renew(dev);
+}
+
+static int ohci_platform_restore(struct device *dev)
+{
+	return ohci_platform_renew_hibernated(dev);
+}
 #endif /* CONFIG_PM_SLEEP */
 
 static const struct of_device_id ohci_platform_ids[] = {
@@ -325,8 +358,16 @@ static const struct platform_device_id ohci_platform_table[] = {
 };
 MODULE_DEVICE_TABLE(platform, ohci_platform_table);
 
-static SIMPLE_DEV_PM_OPS(ohci_platform_pm_ops, ohci_platform_suspend,
-	ohci_platform_resume);
+#ifdef CONFIG_PM_SLEEP
+static const struct dev_pm_ops ohci_platform_pm_ops = {
+	.suspend = ohci_platform_suspend,
+	.resume = ohci_platform_resume,
+	.freeze = ohci_platform_suspend,
+	.thaw = ohci_platform_resume,
+	.poweroff = ohci_platform_suspend,
+	.restore = ohci_platform_restore,
+};
+#endif
 
 static struct platform_driver ohci_platform_driver = {
 	.id_table	= ohci_platform_table,
@@ -335,7 +376,9 @@ static struct platform_driver ohci_platform_driver = {
 	.shutdown	= usb_hcd_platform_shutdown,
 	.driver		= {
 		.name	= "ohci-platform",
+#ifdef CONFIG_PM_SLEEP
 		.pm	= &ohci_platform_pm_ops,
+#endif
 		.of_match_table = ohci_platform_ids,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	}
-- 
2.31.1

