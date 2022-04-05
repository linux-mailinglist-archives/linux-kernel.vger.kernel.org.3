Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B104F4D6F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1582325AbiDEXmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384483AbiDEOSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 10:18:07 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F2199EDD;
        Tue,  5 Apr 2022 06:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1649163848;
  x=1680699848;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SRDguBSs1Y1J0kKrsj8H5WlSWoje+dTygZTrpaj2/6I=;
  b=M04nl71coNVbG2fv/0z56zzyyJfVDcMraxWfrECBCe+tu+a+0QEHfgWf
   c3B/1qZZMSrHnk3j0YYnQJbkiwt1SuCpAjIPfuVYHLz3qydKMbCPO16zR
   r9ih6s8weXPOlAzQo/7rKjiyXXnWBODpbyzaydKrx9nJqSkGtC8vQYXRf
   LhXCjnAA1s1i3aDowW+PN/yYkgjvrXHDlihfg7RP5yTJoMdjQWaca0swD
   biGFcbimL+lVV8sLTpd+rflwCIyrbS098Rn999X+KpGAqL7mFOCCWOS5a
   JWbwqCs5yKBmkPqIBLx5cSu/86XUsEMipguMhPHK7iOA0dZnDRlk3w+Vj
   Q==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <vigneshr@ti.com>, <richard@nod.at>, <miquel.raynal@bootlin.com>,
        <joern@lazybastard.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <frowand.list@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/4] mtd: phram: Allow probing via reserved-memory
Date:   Tue, 5 Apr 2022 15:03:49 +0200
Message-ID: <20220405130350.1640985-4-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220405130350.1640985-1-vincent.whitchurch@axis.com>
References: <20220405130350.1640985-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow phram to be probed from the devicetree.  It expects to be in a
reserved-memory node as documented by the bindings.  This allows things
like partitioning to be specified via the devicetree.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/mtd/devices/phram.c | 67 ++++++++++++++++++++++++++++++++++---
 drivers/of/platform.c       |  1 +
 2 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/devices/phram.c b/drivers/mtd/devices/phram.c
index d503821a3e60..6dfe9401a3c5 100644
--- a/drivers/mtd/devices/phram.c
+++ b/drivers/mtd/devices/phram.c
@@ -27,6 +27,9 @@
 #include <linux/slab.h>
 #include <linux/mtd/mtd.h>
 #include <asm/div64.h>
+#include <linux/platform_device.h>
+#include <linux/of_address.h>
+#include <linux/of.h>
 
 struct phram_mtd_list {
 	struct mtd_info mtd;
@@ -89,8 +92,10 @@ static void unregister_devices(void)
 	}
 }
 
-static int register_device(char *name, phys_addr_t start, size_t len, uint32_t erasesize)
+static int register_device(struct platform_device *pdev, const char *name,
+			   phys_addr_t start, size_t len, uint32_t erasesize)
 {
+	struct device_node *np = pdev ? pdev->dev.of_node : NULL;
 	struct phram_mtd_list *new;
 	int ret = -ENOMEM;
 
@@ -119,13 +124,19 @@ static int register_device(char *name, phys_addr_t start, size_t len, uint32_t e
 	new->mtd.erasesize = erasesize;
 	new->mtd.writesize = 1;
 
+	mtd_set_of_node(&new->mtd, np);
+
 	ret = -EAGAIN;
 	if (mtd_device_register(&new->mtd, NULL, 0)) {
 		pr_err("Failed to register new device\n");
 		goto out2;
 	}
 
-	list_add_tail(&new->list, &phram_list);
+	if (pdev)
+		platform_set_drvdata(pdev, new);
+	else
+		list_add_tail(&new->list, &phram_list);
+
 	return 0;
 
 out2:
@@ -278,7 +289,7 @@ static int phram_setup(const char *val)
 		goto error;
 	}
 
-	ret = register_device(name, start, len, (uint32_t)erasesize);
+	ret = register_device(NULL, name, start, len, (uint32_t)erasesize);
 	if (ret)
 		goto error;
 
@@ -325,10 +336,54 @@ static int phram_param_call(const char *val, const struct kernel_param *kp)
 module_param_call(phram, phram_param_call, NULL, NULL, 0200);
 MODULE_PARM_DESC(phram, "Memory region to map. \"phram=<name>,<start>,<length>[,<erasesize>]\"");
 
+#ifdef CONFIG_OF
+static const struct of_device_id phram_of_match[] = {
+	{ .compatible = "phram" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, phram_of_match)
+#endif
+
+static int phram_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENOMEM;
+
+	/* mtd_set_of_node() reads name from "label" */
+	return register_device(pdev, NULL, res->start, resource_size(res),
+			       PAGE_SIZE);
+}
+
+static int phram_remove(struct platform_device *pdev)
+{
+	struct phram_mtd_list *phram = platform_get_drvdata(pdev);
+
+	mtd_device_unregister(&phram->mtd);
+	iounmap(phram->mtd.priv);
+	kfree(phram);
+
+	return 0;
+}
+
+static struct platform_driver phram_driver = {
+	.probe		= phram_probe,
+	.remove		= phram_remove,
+	.driver		= {
+		.name		= "phram",
+		.of_match_table	= of_match_ptr(phram_of_match),
+	},
+};
 
 static int __init init_phram(void)
 {
-	int ret = 0;
+	int ret;
+
+	ret = platform_driver_register(&phram_driver);
+	if (ret)
+		return ret;
 
 #ifndef MODULE
 	if (phram_paramline[0])
@@ -336,12 +391,16 @@ static int __init init_phram(void)
 	phram_init_called = 1;
 #endif
 
+	if (ret)
+		platform_driver_unregister(&phram_driver);
+
 	return ret;
 }
 
 static void __exit cleanup_phram(void)
 {
 	unregister_devices();
+	platform_driver_unregister(&phram_driver);
 }
 
 module_init(init_phram);
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index a16b74f32aa9..55d62b82c650 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -509,6 +509,7 @@ EXPORT_SYMBOL_GPL(of_platform_default_populate);
 
 #ifndef CONFIG_PPC
 static const struct of_device_id reserved_mem_matches[] = {
+	{ .compatible = "phram" },
 	{ .compatible = "qcom,rmtfs-mem" },
 	{ .compatible = "qcom,cmd-db" },
 	{ .compatible = "qcom,smem" },
-- 
2.34.1

