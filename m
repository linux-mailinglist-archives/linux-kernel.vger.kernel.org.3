Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194B84F1275
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 11:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355750AbiDDJ7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 05:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355204AbiDDJ7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 05:59:24 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD09C3C486
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 02:57:27 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id D502822253;
        Mon,  4 Apr 2022 11:57:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1649066246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v4ovPMtZKYrSYvnne++2NCiqISTem+2ORO/rEGf1fnU=;
        b=FypPdnh/aC2DXD/HlOitMRUQ3uYoaroPYDYv3JWgzbYoHd+HF3NaueOHbLAJx22YGkPSM6
        8wAtBaM7n8kCMqx7O2YV2Wa5NmuGCJ8hnrzF+uGUEJVn6b7B4xhEsPGqKl1ywh9YbT6Vn2
        UQhM1uoD6iMuG+38xeZK/MADI5BhQfo=
From:   Michael Walle <michael@walle.cc>
To:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH RESEND v2 6/7] soc: fsl: guts: drop platform driver
Date:   Mon,  4 Apr 2022 11:56:08 +0200
Message-Id: <20220404095609.3932782-7-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404095609.3932782-1-michael@walle.cc>
References: <20220404095609.3932782-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver cannot be unloaded and it will be needed very early in the
boot process because other driver (weakly) depend on it (eg. for chip
errata handling). Drop all the platform driver and devres stuff and
simply make it a core_initcall.

Signed-off-by: Michael Walle <michael@walle.cc>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/soc/fsl/guts.c | 134 ++++++++++++++++++++++-------------------
 1 file changed, 71 insertions(+), 63 deletions(-)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index 585cbd9d8224..370be923aa0f 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -110,21 +110,59 @@ static const struct fsl_soc_die_attr *fsl_soc_die_match(
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
+
+	np = of_find_matching_node_and_match(NULL, fsl_guts_of_match, NULL);
+	if (!np)
+		return 0;
 
 	regs = of_iomap(np, 0);
-	if (IS_ERR(regs))
+	if (IS_ERR(regs)) {
+		of_node_put(np);
 		return PTR_ERR(regs);
+	}
 
 	little_endian = of_property_read_bool(np, "little-endian");
 	if (little_endian)
@@ -132,92 +170,62 @@ static int fsl_guts_probe(struct platform_device *pdev)
 	else
 		svr = ioread32be(&regs->svr);
 	iounmap(regs);
+	of_node_put(np);
 
 	/* Register soc device */
-	soc_dev_attr = devm_kzalloc(dev, sizeof(*soc_dev_attr), GFP_KERNEL);
+	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
 	if (!soc_dev_attr)
 		return -ENOMEM;
 
 	if (of_property_read_string(of_root, "model", &machine))
 		of_property_read_string_index(of_root, "compatible", 0, &machine);
 	if (machine) {
-		soc_dev_attr->machine = devm_kstrdup(dev, machine, GFP_KERNEL);
+		soc_dev_attr->machine = kstrdup(machine, GFP_KERNEL);
 		if (!soc_dev_attr->machine)
-			return -ENOMEM;
+			goto err_nomem;
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
-					      "svr:0x%08x", svr);
+		goto err_nomem;
+
+	soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "svr:0x%08x", svr);
 	if (!soc_dev_attr->soc_id)
-		return -ENOMEM;
-	soc_dev_attr->revision = devm_kasprintf(dev, GFP_KERNEL, "%d.%d",
-						(svr >>  4) & 0xf, svr & 0xf);
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
+	kfree(soc_dev_attr);
 
-static int __init fsl_guts_init(void)
-{
-	return platform_driver_register(&fsl_guts_driver);
+	return ret;
 }
 core_initcall(fsl_guts_init);
-- 
2.30.2

