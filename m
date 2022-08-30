Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7A05A6178
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 13:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiH3LPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 07:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiH3LP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:15:27 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07DBE26121;
        Tue, 30 Aug 2022 04:15:13 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx72st8Q1jtF8MAA--.51656S2;
        Tue, 30 Aug 2022 19:15:02 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <greg@kroah.com>,
        Patchwork Bot <patchwork-bot@kernel.org>
Cc:     zhuyinbo@loongson.cn
Subject: [PATCH v1] usb: ohci-platform: fix usb disconnect issue after s4
Date:   Tue, 30 Aug 2022 19:14:49 +0800
Message-Id: <20220830111449.2300-1-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx72st8Q1jtF8MAA--.51656S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF47CrWDAF13ur1rWF1kuFg_yoW5AFW3pr
        4UJFWftr48GF42g3y7twnrZFWrCwsaq3y7K34UKwnF9a98t3s8Ja1jyFy0vFnxXry7Jwn5
        tF4jyFWUuF4UZrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK6svPMxAI
        w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
        4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxG
        rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
        CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
        z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
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
since we know exactly which resume operations are from hibernation

According to the commit "cd1965db0" and "6ec4beb5c" that the flag
"hibernated" is for resume-from-hibernation and it should be true when
usb resume from disk.

When this flag "hibernated" is set, the drivers will reset the hardware
to get rid of any existing state and make sure resume from hibernation
re-enumerates everything for ohci.

Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
---
 drivers/usb/host/ohci-platform.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
index 0adae6265127..e733da2cd3b7 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -289,7 +289,7 @@ static int ohci_platform_suspend(struct device *dev)
 	return ret;
 }
 
-static int ohci_platform_resume(struct device *dev)
+static int ohci_platform_renew(struct device *dev, bool hibernated)
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
+	return ohci_platform_renew(dev, false);
+}
+
+static int ohci_platform_restore(struct device *dev)
+{
+	return ohci_platform_renew(dev, true);
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

