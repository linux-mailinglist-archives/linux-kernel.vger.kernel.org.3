Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0C349E7CA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 17:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243995AbiA0Qlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 11:41:47 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:52881 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243916AbiA0Qln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:41:43 -0500
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 4B9B6223F0;
        Thu, 27 Jan 2022 17:41:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1643301702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1LihC01snsz2jvGOnd10qw1QpXW5+8EkOXvBdUPwZNg=;
        b=B8c6IRQOCX9H308G07Q1+3M4mhhAkQFmCE+d1jyryGET+1xW8CFT/DYIb57c2ZUMJ7YZOt
        D2mEi2j7/wRW7bqFFblhKJung1+aEzMTARc6zZTFDQb2VJzKxW4kxeoNKLNkD4GfllpIRz
        ZnitdI8mblVQp4kkWu7a6cJOhaVJ9wI=
From:   Michael Walle <michael@walle.cc>
To:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Michael Walle <michael@walle.cc>
Subject: [PATCH v1 4/7] soc: fsl: guts: allocate soc_dev_attr on the heap
Date:   Thu, 27 Jan 2022 17:41:22 +0100
Message-Id: <20220127164125.3651285-5-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220127164125.3651285-1-michael@walle.cc>
References: <20220127164125.3651285-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the last global static variable. Drop it and allocate the memory
on the heap instead.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/soc/fsl/guts.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index 536377988fb4..383b35a4ed58 100644
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
@@ -124,6 +122,10 @@ static int fsl_guts_probe(struct platform_device *pdev)
 	bool little_endian;
 	u32 svr;
 
+	soc_dev_attr = devm_kzalloc(dev, sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		return -ENOMEM;
+
 	little_endian = of_property_read_bool(np, "little-endian");
 
 	regs = of_iomap(np, 0);
@@ -141,8 +143,8 @@ static int fsl_guts_probe(struct platform_device *pdev)
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
@@ -151,30 +153,30 @@ static int fsl_guts_probe(struct platform_device *pdev)
 
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
+	soc_dev_attr->soc_id = devm_kasprintf(dev, GFP_KERNEL,
 					     "svr:0x%08x", svr);
-	if (!soc_dev_attr.soc_id)
+	if (!soc_dev_attr->soc_id)
 		return -ENOMEM;
-	soc_dev_attr.revision = devm_kasprintf(dev, GFP_KERNEL, "%d.%d",
+	soc_dev_attr->revision = devm_kasprintf(dev, GFP_KERNEL, "%d.%d",
 					       (svr >>  4) & 0xf, svr & 0xf);
-	if (!soc_dev_attr.revision)
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

