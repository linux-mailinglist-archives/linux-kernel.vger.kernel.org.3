Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02DD449E7CE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 17:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244037AbiA0Qly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 11:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243924AbiA0Qlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:41:44 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C1FC06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 08:41:44 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id CEE05223F7;
        Thu, 27 Jan 2022 17:41:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1643301702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t+OnNgeK+rVH8xs/1ISiBYCo+CfY2rbiof36ukWZZ40=;
        b=uxBfDXV26Ep7vtF+pq7UItlkQEwAHK9zFK6BMAzWu16ONFvKMKw79t+uLSjtLPdWW4pQts
        +NZNWFoLPUndmMhxfHh40At6hKDBB9koFjdVfc2DaZ+lRg67KDDAwh151tTWSb+1/nyFz2
        NuEX9T6YWCyPbj/5NlK4uCmFjR3MmoU=
From:   Michael Walle <michael@walle.cc>
To:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Michael Walle <michael@walle.cc>
Subject: [PATCH v1 6/7] soc: fsl: guts: drop platform driver
Date:   Thu, 27 Jan 2022 17:41:24 +0100
Message-Id: <20220127164125.3651285-7-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220127164125.3651285-1-michael@walle.cc>
References: <20220127164125.3651285-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver cannot be unloaded and it will be needed very early in the
boot process because other driver (weakly) depend on it (eg. for chip
errata handling). Drop all the platform driver and devres stuff and
simply make it a core_initcall.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/soc/fsl/guts.c | 127 +++++++++++++++++++++--------------------
 1 file changed, 65 insertions(+), 62 deletions(-)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index 04c3eb6a6e17..be961a9193f4 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -110,19 +110,55 @@ static const struct fsl_soc_die_attr *fsl_soc_die_match(
 	return NULL;
 }
 
-static int fsl_guts_probe(struct platform_device *pdev)
+/*
+ * Table for matching compatible strings, for device tree
+ * guts node, for Freescale QorIQ SOCs.
+ */
+static const struct of_device_id fsl_guts_of_match[] = {
+	{ .compatible = "fsl,qoriq-device-config-1.0", },
+	{ .compatible = "fsl,qoriq-device-config-2.0", },
+	{ .compatible = "fsl,p1010-guts", },
+	{ .compatible = "fsl,p1020-guts", },
+	{ .compatible = "fsl,p1021-guts", },
+	{ .compatible = "fsl,p1022-guts", },
+	{ .compatible = "fsl,p1023-guts", },
+	{ .compatible = "fsl,p2020-guts", },
+	{ .compatible = "fsl,bsc9131-guts", },
+	{ .compatible = "fsl,bsc9132-guts", },
+	{ .compatible = "fsl,mpc8536-guts", },
+	{ .compatible = "fsl,mpc8544-guts", },
+	{ .compatible = "fsl,mpc8548-guts", },
+	{ .compatible = "fsl,mpc8568-guts", },
+	{ .compatible = "fsl,mpc8569-guts", },
+	{ .compatible = "fsl,mpc8572-guts", },
+	{ .compatible = "fsl,ls1021a-dcfg", },
+	{ .compatible = "fsl,ls1043a-dcfg", },
+	{ .compatible = "fsl,ls2080a-dcfg", },
+	{ .compatible = "fsl,ls1088a-dcfg", },
+	{ .compatible = "fsl,ls1012a-dcfg", },
+	{ .compatible = "fsl,ls1046a-dcfg", },
+	{ .compatible = "fsl,lx2160a-dcfg", },
+	{ .compatible = "fsl,ls1028a-dcfg", },
+	{}
+};
+
+static int __init fsl_guts_init(void)
 {
-	struct device_node *np = pdev->dev.of_node;
 	struct soc_device_attribute *soc_dev_attr;
 	static struct soc_device *soc_dev;
-	struct device *dev = &pdev->dev;
 	const struct fsl_soc_die_attr *soc_die;
 	struct ccsr_guts __iomem *regs;
 	const char *machine = NULL;
+	struct device_node *np;
 	bool little_endian;
 	u32 svr;
+	int ret;
 
-	soc_dev_attr = devm_kzalloc(dev, sizeof(*soc_dev_attr), GFP_KERNEL);
+	np = of_find_matching_node_and_match(NULL, fsl_guts_of_match, NULL);
+	if (!np)
+		return 0;
+
+	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
 	if (!soc_dev_attr)
 		return -ENOMEM;
 
@@ -138,87 +174,54 @@ static int fsl_guts_probe(struct platform_device *pdev)
 		svr = ioread32be(&regs->svr);
 	iounmap(regs);
 
-	/* Register soc device */
 	if (of_property_read_string(of_root, "model", &machine))
 		of_property_read_string_index(of_root, "compatible", 0, &machine);
 	if (machine) {
-		soc_dev_attr->machine = devm_kstrdup(dev, machine, GFP_KERNEL);
+		soc_dev_attr->machine = kstrdup(machine, GFP_KERNEL);
 		if (!soc_dev_attr->machine)
 			return -ENOMEM;
 	}
 
 	soc_die = fsl_soc_die_match(svr, fsl_soc_die);
 	if (soc_die) {
-		soc_dev_attr->family = devm_kasprintf(dev, GFP_KERNEL,
-						      "QorIQ %s", soc_die->die);
+		soc_dev_attr->family = kasprintf(GFP_KERNEL, "QorIQ %s",
+						 soc_die->die);
 	} else {
-		soc_dev_attr->family = devm_kasprintf(dev, GFP_KERNEL, "QorIQ");
+		soc_dev_attr->family = kasprintf(GFP_KERNEL, "QorIQ");
 	}
 	if (!soc_dev_attr->family)
-		return -ENOMEM;
-	soc_dev_attr->soc_id = devm_kasprintf(dev, GFP_KERNEL,
-					     "svr:0x%08x", svr);
+		goto err_nomem;
+
+	soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "svr:0x%08x", svr);
 	if (!soc_dev_attr->soc_id)
-		return -ENOMEM;
-	soc_dev_attr->revision = devm_kasprintf(dev, GFP_KERNEL, "%d.%d",
-					       (svr >>  4) & 0xf, svr & 0xf);
+		goto err_nomem;
+
+	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%d.%d",
+					   (svr >>  4) & 0xf, svr & 0xf);
 	if (!soc_dev_attr->revision)
-		return -ENOMEM;
+		goto err_nomem;
 
 	soc_dev = soc_device_register(soc_dev_attr);
-	if (IS_ERR(soc_dev))
-		return PTR_ERR(soc_dev);
+	if (IS_ERR(soc_dev)) {
+		ret = PTR_ERR(soc_dev);
+		goto err;
+	}
 
 	pr_info("Machine: %s\n", soc_dev_attr->machine);
 	pr_info("SoC family: %s\n", soc_dev_attr->family);
 	pr_info("SoC ID: %s, Revision: %s\n",
 		soc_dev_attr->soc_id, soc_dev_attr->revision);
-	return 0;
-}
 
-/*
- * Table for matching compatible strings, for device tree
- * guts node, for Freescale QorIQ SOCs.
- */
-static const struct of_device_id fsl_guts_of_match[] = {
-	{ .compatible = "fsl,qoriq-device-config-1.0", },
-	{ .compatible = "fsl,qoriq-device-config-2.0", },
-	{ .compatible = "fsl,p1010-guts", },
-	{ .compatible = "fsl,p1020-guts", },
-	{ .compatible = "fsl,p1021-guts", },
-	{ .compatible = "fsl,p1022-guts", },
-	{ .compatible = "fsl,p1023-guts", },
-	{ .compatible = "fsl,p2020-guts", },
-	{ .compatible = "fsl,bsc9131-guts", },
-	{ .compatible = "fsl,bsc9132-guts", },
-	{ .compatible = "fsl,mpc8536-guts", },
-	{ .compatible = "fsl,mpc8544-guts", },
-	{ .compatible = "fsl,mpc8548-guts", },
-	{ .compatible = "fsl,mpc8568-guts", },
-	{ .compatible = "fsl,mpc8569-guts", },
-	{ .compatible = "fsl,mpc8572-guts", },
-	{ .compatible = "fsl,ls1021a-dcfg", },
-	{ .compatible = "fsl,ls1043a-dcfg", },
-	{ .compatible = "fsl,ls2080a-dcfg", },
-	{ .compatible = "fsl,ls1088a-dcfg", },
-	{ .compatible = "fsl,ls1012a-dcfg", },
-	{ .compatible = "fsl,ls1046a-dcfg", },
-	{ .compatible = "fsl,lx2160a-dcfg", },
-	{ .compatible = "fsl,ls1028a-dcfg", },
-	{}
-};
-MODULE_DEVICE_TABLE(of, fsl_guts_of_match);
+	return 0;
 
-static struct platform_driver fsl_guts_driver = {
-	.driver = {
-		.name = "fsl-guts",
-		.of_match_table = fsl_guts_of_match,
-	},
-	.probe = fsl_guts_probe,
-};
+err_nomem:
+	ret = -ENOMEM;
+err:
+	kfree(soc_dev_attr->machine);
+	kfree(soc_dev_attr->family);
+	kfree(soc_dev_attr->soc_id);
+	kfree(soc_dev_attr->revision);
 
-static int __init fsl_guts_init(void)
-{
-	return platform_driver_register(&fsl_guts_driver);
+	return ret;
 }
 core_initcall(fsl_guts_init);
-- 
2.30.2

