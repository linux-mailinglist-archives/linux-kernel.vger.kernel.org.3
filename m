Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6344BB7A9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 12:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbiBRLGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 06:06:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234228AbiBRLGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 06:06:31 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777E828881F;
        Fri, 18 Feb 2022 03:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1645182375;
  x=1676718375;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TtCwuTI/iRWtd93Jw/84z0sfqwMlErfgG6nVne3l2O4=;
  b=iOaC0tRmVWuo4XIL2mEUhQQLo9encK3/GxBIx6RwFCmLlRwU6F9M6bdB
   jZF5doyFxaIOSVO33C17EHRNFAn5gLRs4xejce5C3IoQi5b4dEHs+zgJ3
   VzcZBY8BzDv4CQEJC8I4j1NZJBRzfgf1s+fJbEeNocnkdAFwoL+KgWQpX
   JPcKr9w79QtR0LB4zChTwBZyTYWK/Ixs9tyN0cWpNcnU4iBdZAlALk/Zi
   MjbEzjFHFGtzv2lcdSeyeHhnZvE29vVrekN6+nsu8PbRlmCNVh5HPoTno
   3RA5aJqfGC/HKVAC0F1ImsxAwU5kwbyneRT0oZhSNxdBWsuYF0U4wOqmM
   A==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     <kernel@axis.com>, <devicetree@vger.kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] regulator: virtual: add devicetree support
Date:   Fri, 18 Feb 2022 12:06:03 +0100
Message-ID: <20220218110604.1329024-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
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

The reg-virt-consumer is very useful for development and testing of
regulator drivers since it allows voltages and modes to be set from
userspace.  However, it currently requires platform data so it cannot be
used on modern platforms.  Add support for probing it from the
devicetree to remedy this.

Since this driver is only meant for testing and is a purely software
construct, no binding documentation is added.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/regulator/virtual.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/regulator/virtual.c b/drivers/regulator/virtual.c
index 52c5a0e0acd8..c4d56b484ed5 100644
--- a/drivers/regulator/virtual.c
+++ b/drivers/regulator/virtual.c
@@ -13,6 +13,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/of.h>
 
 struct virtual_consumer_data {
 	struct mutex lock;
@@ -281,6 +282,14 @@ static const struct attribute_group regulator_virtual_attr_group = {
 	.attrs	= regulator_virtual_attributes,
 };
 
+#ifdef CONFIG_OF
+static const struct of_device_id regulator_virtual_consumer_of_match[] = {
+	{ .compatible = "regulator-virtual-consumer" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, regulator_virtual_consumer_of_match);
+#endif
+
 static int regulator_virtual_probe(struct platform_device *pdev)
 {
 	char *reg_id = dev_get_platdata(&pdev->dev);
@@ -292,6 +301,9 @@ static int regulator_virtual_probe(struct platform_device *pdev)
 	if (drvdata == NULL)
 		return -ENOMEM;
 
+	if (!reg_id)
+		reg_id = "default";
+
 	mutex_init(&drvdata->lock);
 
 	drvdata->regulator = devm_regulator_get(&pdev->dev, reg_id);
@@ -334,6 +346,7 @@ static struct platform_driver regulator_virtual_consumer_driver = {
 	.remove		= regulator_virtual_remove,
 	.driver		= {
 		.name		= "reg-virt-consumer",
+		.of_match_table = of_match_ptr(regulator_virtual_consumer_of_match),
 	},
 };
 
-- 
2.34.1

