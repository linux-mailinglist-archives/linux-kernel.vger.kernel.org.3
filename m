Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C904F1274
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 11:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355475AbiDDJ7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 05:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355176AbiDDJ7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 05:59:24 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4083C48D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 02:57:28 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2EEA222255;
        Mon,  4 Apr 2022 11:57:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1649066246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j904Obz7z0f9BMGRXiWX07Usnwp/ORQFPcf7fLFab5g=;
        b=jrxnZimPuYcg7vhCzupFLMjC648tABQHXkZGvNzwa9loh5/w38AxSF79HG4Oc8Ogf6hU3U
        dJtO2LIPEYkNJ1Nwb2tWOkFO3syJ+71ODjRcprZBHmb2kiA37cD2+gfK2XKWtsDeImW+Oy
        vBx8aq5h60V3C9WpviDFdaEEDY4MBE4=
From:   Michael Walle <michael@walle.cc>
To:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH RESEND v2 7/7] soc: fsl: guts: add serial_number support
Date:   Mon,  4 Apr 2022 11:56:09 +0200
Message-Id: <20220404095609.3932782-8-michael@walle.cc>
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

Most layerscapes provide a security fuse processor where the vendor
will store a unique id per part. Unfortunately, we cannot use the
corresponding efuse driver because this driver needs to be ready
early during the boot phase. To get the unique identifier, we just
need to access two registers. Thus we just search the device tree
for the corresponding device, map its memory to read the id and then
unmap it again.

Because it is likely that the offset within the fuses is dependent
on the SoC, we need a per SoC data. Also, the compatible string is
different among the SoCs. For now, this add support for the LS1028A
SoC.

Signed-off-by: Michael Walle <michael@walle.cc>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/soc/fsl/guts.c | 48 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index 370be923aa0f..27035de062f8 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -20,6 +20,11 @@ struct fsl_soc_die_attr {
 	u32	mask;
 };
 
+struct fsl_soc_data {
+	const char *sfp_compat;
+	u32 uid_offset;
+};
+
 /* SoC die attribute definition for QorIQ platform */
 static const struct fsl_soc_die_attr fsl_soc_die[] = {
 	/*
@@ -110,6 +115,33 @@ static const struct fsl_soc_die_attr *fsl_soc_die_match(
 	return NULL;
 }
 
+static u64 fsl_guts_get_soc_uid(const char *compat, unsigned int offset)
+{
+	struct device_node *np;
+	void __iomem *sfp_base;
+	u64 uid;
+
+	np = of_find_compatible_node(NULL, NULL, compat);
+	if (!np)
+		return 0;
+
+	sfp_base = of_iomap(np, 0);
+
+	uid = ioread32(sfp_base + offset);
+	uid <<= 32;
+	uid |= ioread32(sfp_base + offset + 4);
+
+	iounmap(sfp_base);
+	of_node_put(np);
+
+	return uid;
+}
+
+static const struct fsl_soc_data ls1028a_data = {
+	.sfp_compat = "fsl,ls1028a-sfp",
+	.uid_offset = 0x21c,
+};
+
 /*
  * Table for matching compatible strings, for device tree
  * guts node, for Freescale QorIQ SOCs.
@@ -138,7 +170,7 @@ static const struct of_device_id fsl_guts_of_match[] = {
 	{ .compatible = "fsl,ls1012a-dcfg", },
 	{ .compatible = "fsl,ls1046a-dcfg", },
 	{ .compatible = "fsl,lx2160a-dcfg", },
-	{ .compatible = "fsl,ls1028a-dcfg", },
+	{ .compatible = "fsl,ls1028a-dcfg", .data = &ls1028a_data},
 	{}
 };
 
@@ -147,16 +179,20 @@ static int __init fsl_guts_init(void)
 	struct soc_device_attribute *soc_dev_attr;
 	static struct soc_device *soc_dev;
 	const struct fsl_soc_die_attr *soc_die;
+	const struct fsl_soc_data *soc_data;
+	const struct of_device_id *match;
 	struct ccsr_guts __iomem *regs;
 	const char *machine = NULL;
 	struct device_node *np;
 	bool little_endian;
+	u64 soc_uid = 0;
 	u32 svr;
 	int ret;
 
-	np = of_find_matching_node_and_match(NULL, fsl_guts_of_match, NULL);
+	np = of_find_matching_node_and_match(NULL, fsl_guts_of_match, &match);
 	if (!np)
 		return 0;
+	soc_data = match->data;
 
 	regs = of_iomap(np, 0);
 	if (IS_ERR(regs)) {
@@ -204,6 +240,13 @@ static int __init fsl_guts_init(void)
 	if (!soc_dev_attr->revision)
 		goto err_nomem;
 
+	if (soc_data)
+		soc_uid = fsl_guts_get_soc_uid(soc_data->sfp_compat,
+					       soc_data->uid_offset);
+	if (soc_uid)
+		soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX",
+							soc_uid);
+
 	soc_dev = soc_device_register(soc_dev_attr);
 	if (IS_ERR(soc_dev)) {
 		ret = PTR_ERR(soc_dev);
@@ -224,6 +267,7 @@ static int __init fsl_guts_init(void)
 	kfree(soc_dev_attr->family);
 	kfree(soc_dev_attr->soc_id);
 	kfree(soc_dev_attr->revision);
+	kfree(soc_dev_attr->serial_number);
 	kfree(soc_dev_attr);
 
 	return ret;
-- 
2.30.2

