Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F055AA81B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 08:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbiIBGg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 02:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiIBGg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 02:36:56 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F9D1A1A42;
        Thu,  1 Sep 2022 23:36:53 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxFeJ5pBFjqpsPAA--.2392S2;
        Fri, 02 Sep 2022 14:36:46 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <greg@kroah.com>,
        Patchwork Bot <patchwork-bot@kernel.org>
Cc:     zhuyinbo@loongson.cn
Subject: [PATCH v4] usb: ohci-platform: fix usb disconnect issue after s4
Date:   Fri,  2 Sep 2022 14:36:39 +0800
Message-Id: <20220902063639.17875-1-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxFeJ5pBFjqpsPAA--.2392S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGFW3KrWDtFyDZFyrArW7XFb_yoW5tw4UpF
        4UJFWftr48GF42g3y7AwnrZFWrCwsag3y7K34UKwnF9a90q3s8JF4jyFy0yFnxXry7Jw1k
        tF4jyFWUCF4UZrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
        xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
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

The ohci retaining bogus hardware states cause usb disconnect devices
connected before hibernation(s4), this issue occur when ohci-platform
driver build as a module and the built-in ohci-platform driver will
re probe and re enumerate the devices, so there will be no such problem.

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
Change in v4:
		Add explain what this disconnect issue is.

 drivers/usb/host/ohci-platform.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
index 0adae6265127..822a0f927e62 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -289,7 +289,7 @@ static int ohci_platform_suspend(struct device *dev)
 	return ret;
 }
 
-static int ohci_platform_resume(struct device *dev)
+static int ohci_platform_resume_common(struct device *dev, bool hibernated)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
 	struct usb_ohci_pdata *pdata = dev_get_platdata(dev);
@@ -301,7 +301,7 @@ static int ohci_platform_resume(struct device *dev)
 			return err;
 	}
 
-	ohci_resume(hcd, false);
+	ohci_resume(hcd, hibernated);
 
 	pm_runtime_disable(dev);
 	pm_runtime_set_active(dev);
@@ -309,6 +309,16 @@ static int ohci_platform_resume(struct device *dev)
 
 	return 0;
 }
+
+static int ohci_platform_resume(struct device *dev)
+{
+	return ohci_platform_resume_common(dev, false);
+}
+
+static int ohci_platform_restore(struct device *dev)
+{
+	return ohci_platform_resume_common(dev, true);
+}
 #endif /* CONFIG_PM_SLEEP */
 
 static const struct of_device_id ohci_platform_ids[] = {
@@ -325,8 +335,16 @@ static const struct platform_device_id ohci_platform_table[] = {
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
@@ -335,7 +353,9 @@ static struct platform_driver ohci_platform_driver = {
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

