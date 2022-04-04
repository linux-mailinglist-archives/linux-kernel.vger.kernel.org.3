Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0CF4F1271
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 11:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355566AbiDDJ7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 05:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355033AbiDDJ7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 05:59:23 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609CD3BFBE
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 02:57:27 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2D7E32224E;
        Mon,  4 Apr 2022 11:57:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1649066245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6OyNeZS+QG1hA8GYAjcgVvsD0Y3gZ/R3mypb4i3MxqE=;
        b=dqX6rxz52L2kLkfD4q33e9A2jU23arfKYKfLcnfS1KnKRue1l/FWG9godj347kUe702IaX
        +eWNQPL2ChnQqET8pteLa1Q3WJtesB1oteA4SpwhzrM8zsXv0369buTj+LRlga3DVGSasC
        zcdL/4aNgMi3sL6UBTKUZCG3BDcrbSc=
From:   Michael Walle <michael@walle.cc>
To:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH RESEND v2 4/7] soc: fsl: guts: allocate soc_dev_attr on the heap
Date:   Mon,  4 Apr 2022 11:56:06 +0200
Message-Id: <20220404095609.3932782-5-michael@walle.cc>
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

This is the last global static variable. Drop it and allocate the memory
on the heap instead.

Signed-off-by: Michael Walle <michael@walle.cc>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/soc/fsl/guts.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index 4e5675ab5f73..44e7a9bf6392 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -20,9 +20,6 @@ struct fsl_soc_die_attr {
 	u32	mask;
 };
 
-static struct soc_device_attribute soc_dev_attr;
-
-
 /* SoC die attribute definition for QorIQ platform */
 static const struct fsl_soc_die_attr fsl_soc_die[] = {
 	/*
@@ -116,6 +113,7 @@ static const struct fsl_soc_die_attr *fsl_soc_die_match(
 static int fsl_guts_probe(struct platform_device *pdev)
 {
 	struct device_node *root, *np = pdev->dev.of_node;
+	struct soc_device_attribute *soc_dev_attr;
 	static struct soc_device *soc_dev;
 	struct device *dev = &pdev->dev;
 	const struct fsl_soc_die_attr *soc_die;
@@ -136,12 +134,16 @@ static int fsl_guts_probe(struct platform_device *pdev)
 	iounmap(regs);
 
 	/* Register soc device */
+	soc_dev_attr = devm_kzalloc(dev, sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		return -ENOMEM;
+
 	root = of_find_node_by_path("/");
 	if (of_property_read_string(root, "model", &machine))
 		of_property_read_string_index(root, "compatible", 0, &machine);
 	if (machine) {
-		soc_dev_attr.machine = devm_kstrdup(dev, machine, GFP_KERNEL);
-		if (!soc_dev_attr.machine) {
+		soc_dev_attr->machine = devm_kstrdup(dev, machine, GFP_KERNEL);
+		if (!soc_dev_attr->machine) {
 			of_node_put(root);
 			return -ENOMEM;
 		}
@@ -150,30 +152,30 @@ static int fsl_guts_probe(struct platform_device *pdev)
 
 	soc_die = fsl_soc_die_match(svr, fsl_soc_die);
 	if (soc_die) {
-		soc_dev_attr.family = devm_kasprintf(dev, GFP_KERNEL,
-						     "QorIQ %s", soc_die->die);
+		soc_dev_attr->family = devm_kasprintf(dev, GFP_KERNEL,
+						      "QorIQ %s", soc_die->die);
 	} else {
-		soc_dev_attr.family = devm_kasprintf(dev, GFP_KERNEL, "QorIQ");
+		soc_dev_attr->family = devm_kasprintf(dev, GFP_KERNEL, "QorIQ");
 	}
-	if (!soc_dev_attr.family)
+	if (!soc_dev_attr->family)
 		return -ENOMEM;
-	soc_dev_attr.soc_id = devm_kasprintf(dev, GFP_KERNEL,
-					     "svr:0x%08x", svr);
-	if (!soc_dev_attr.soc_id)
+	soc_dev_attr->soc_id = devm_kasprintf(dev, GFP_KERNEL,
+					      "svr:0x%08x", svr);
+	if (!soc_dev_attr->soc_id)
 		return -ENOMEM;
-	soc_dev_attr.revision = devm_kasprintf(dev, GFP_KERNEL, "%d.%d",
-					       (svr >>  4) & 0xf, svr & 0xf);
-	if (!soc_dev_attr.revision)
+	soc_dev_attr->revision = devm_kasprintf(dev, GFP_KERNEL, "%d.%d",
+						(svr >>  4) & 0xf, svr & 0xf);
+	if (!soc_dev_attr->revision)
 		return -ENOMEM;
 
-	soc_dev = soc_device_register(&soc_dev_attr);
+	soc_dev = soc_device_register(soc_dev_attr);
 	if (IS_ERR(soc_dev))
 		return PTR_ERR(soc_dev);
 
-	pr_info("Machine: %s\n", soc_dev_attr.machine);
-	pr_info("SoC family: %s\n", soc_dev_attr.family);
+	pr_info("Machine: %s\n", soc_dev_attr->machine);
+	pr_info("SoC family: %s\n", soc_dev_attr->family);
 	pr_info("SoC ID: %s, Revision: %s\n",
-		soc_dev_attr.soc_id, soc_dev_attr.revision);
+		soc_dev_attr->soc_id, soc_dev_attr->revision);
 	return 0;
 }
 
-- 
2.30.2

