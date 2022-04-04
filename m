Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6FD4F1273
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 11:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239305AbiDDJ7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 05:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354905AbiDDJ7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 05:59:21 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3233C3BFB9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 02:57:26 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 356A722249;
        Mon,  4 Apr 2022 11:57:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1649066244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8H9WDff2V0whcBx4OOXlWzd8HqNMxJRqX9n6bDccO1g=;
        b=nvHqe8IEY4ITtcVoDHNFdJ8SV5LqTxDgclRU5ap8Vj3p94k4fA789MeXeJkoDwBJZPY3wb
        5or2MDkzUCpYeqms9j2ZCqwGuqupHH54JZGfwVSXb6kTnKth0wUDJEGPPUjVJ0b7q2BIPo
        uLvJs2vK/WCGe09fD+hGe9rnR5MQjWc=
From:   Michael Walle <michael@walle.cc>
To:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH RESEND v2 2/7] soc: fsl: guts: remove module_exit() and fsl_guts_remove()
Date:   Mon,  4 Apr 2022 11:56:04 +0200
Message-Id: <20220404095609.3932782-3-michael@walle.cc>
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

This driver will never be unloaded. Firstly, it is not available as a
module, but more importantly, other drivers will depend on this one to
apply possible chip errata.

Signed-off-by: Michael Walle <michael@walle.cc>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/soc/fsl/guts.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index be18d46c7b0f..0bea43770d51 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -27,7 +27,6 @@ struct fsl_soc_die_attr {
 
 static struct guts *guts;
 static struct soc_device_attribute soc_dev_attr;
-static struct soc_device *soc_dev;
 
 
 /* SoC die attribute definition for QorIQ platform */
@@ -138,6 +137,7 @@ static u32 fsl_guts_get_svr(void)
 static int fsl_guts_probe(struct platform_device *pdev)
 {
 	struct device_node *root, *np = pdev->dev.of_node;
+	static struct soc_device *soc_dev;
 	struct device *dev = &pdev->dev;
 	const struct fsl_soc_die_attr *soc_die;
 	const char *machine = NULL;
@@ -197,12 +197,6 @@ static int fsl_guts_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int fsl_guts_remove(struct platform_device *dev)
-{
-	soc_device_unregister(soc_dev);
-	return 0;
-}
-
 /*
  * Table for matching compatible strings, for device tree
  * guts node, for Freescale QorIQ SOCs.
@@ -242,7 +236,6 @@ static struct platform_driver fsl_guts_driver = {
 		.of_match_table = fsl_guts_of_match,
 	},
 	.probe = fsl_guts_probe,
-	.remove = fsl_guts_remove,
 };
 
 static int __init fsl_guts_init(void)
@@ -250,9 +243,3 @@ static int __init fsl_guts_init(void)
 	return platform_driver_register(&fsl_guts_driver);
 }
 core_initcall(fsl_guts_init);
-
-static void __exit fsl_guts_exit(void)
-{
-	platform_driver_unregister(&fsl_guts_driver);
-}
-module_exit(fsl_guts_exit);
-- 
2.30.2

