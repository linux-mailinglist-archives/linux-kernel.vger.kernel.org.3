Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CA54F1270
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 11:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355413AbiDDJ7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 05:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355007AbiDDJ7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 05:59:23 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9848E3BFBC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 02:57:26 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 7E0282224D;
        Mon,  4 Apr 2022 11:57:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1649066244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nCHNYot625EnAVBK5VOhUP+5vbgUYJ9BdY/54uVs0mY=;
        b=ts+JPCiGtXb2+nvWTf7wPUYySMiTz4tdow6DFbPbVlFy/GT7hVythTAc0Tzs4I461Ae3EC
        oSF+/K/mkb1twTOhH5W+SmtxZtfi+DHemFShOxfDAmBrXYqz+bSjj9dllkv0f6mDTO606D
        k5vTJbwIoCdWl0CztRlWBylerNLtBTs=
From:   Michael Walle <michael@walle.cc>
To:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH RESEND v2 3/7] soc: fsl: guts: embed fsl_guts_get_svr() in probe()
Date:   Mon,  4 Apr 2022 11:56:05 +0200
Message-Id: <20220404095609.3932782-4-michael@walle.cc>
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

Move the reading of the SVR into the probe function as
fsl_guts_get_svr() is the only user of the static guts variable and this
lets us drop that as well as the malloc() for this variable. Also, we
can unmap the memory region after we accessed it, which will simplify
error handling later.

Signed-off-by: Michael Walle <michael@walle.cc>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/soc/fsl/guts.c | 42 +++++++++++-------------------------------
 1 file changed, 11 insertions(+), 31 deletions(-)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index 0bea43770d51..4e5675ab5f73 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -14,18 +14,12 @@
 #include <linux/platform_device.h>
 #include <linux/fsl/guts.h>
 
-struct guts {
-	struct ccsr_guts __iomem *regs;
-	bool little_endian;
-};
-
 struct fsl_soc_die_attr {
 	char	*die;
 	u32	svr;
 	u32	mask;
 };
 
-static struct guts *guts;
 static struct soc_device_attribute soc_dev_attr;
 
 
@@ -119,40 +113,27 @@ static const struct fsl_soc_die_attr *fsl_soc_die_match(
 	return NULL;
 }
 
-static u32 fsl_guts_get_svr(void)
-{
-	u32 svr = 0;
-
-	if (!guts || !guts->regs)
-		return svr;
-
-	if (guts->little_endian)
-		svr = ioread32(&guts->regs->svr);
-	else
-		svr = ioread32be(&guts->regs->svr);
-
-	return svr;
-}
-
 static int fsl_guts_probe(struct platform_device *pdev)
 {
 	struct device_node *root, *np = pdev->dev.of_node;
 	static struct soc_device *soc_dev;
 	struct device *dev = &pdev->dev;
 	const struct fsl_soc_die_attr *soc_die;
+	struct ccsr_guts __iomem *regs;
 	const char *machine = NULL;
+	bool little_endian;
 	u32 svr;
 
-	/* Initialize guts */
-	guts = devm_kzalloc(dev, sizeof(*guts), GFP_KERNEL);
-	if (!guts)
-		return -ENOMEM;
-
-	guts->little_endian = of_property_read_bool(np, "little-endian");
+	regs = of_iomap(np, 0);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
 
-	guts->regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(guts->regs))
-		return PTR_ERR(guts->regs);
+	little_endian = of_property_read_bool(np, "little-endian");
+	if (little_endian)
+		svr = ioread32(&regs->svr);
+	else
+		svr = ioread32be(&regs->svr);
+	iounmap(regs);
 
 	/* Register soc device */
 	root = of_find_node_by_path("/");
@@ -167,7 +148,6 @@ static int fsl_guts_probe(struct platform_device *pdev)
 	}
 	of_node_put(root);
 
-	svr = fsl_guts_get_svr();
 	soc_die = fsl_soc_die_match(svr, fsl_soc_die);
 	if (soc_die) {
 		soc_dev_attr.family = devm_kasprintf(dev, GFP_KERNEL,
-- 
2.30.2

