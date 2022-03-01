Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426854C8A84
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 12:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbiCALTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 06:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234484AbiCALT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 06:19:26 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5A92253C;
        Tue,  1 Mar 2022 03:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1646133526;
  x=1677669526;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KAoobEf0FgmH/phyTwuBEP9MQR4VO/sSwTaKsDfFC5Q=;
  b=SUAAsqaSBWYEmuv7bWXIZEcC0p8L1gZvwMLwCgOoQCyJsZ4Bi6IeRlU5
   y9vPHAn7ge5t9eQh5lN1x3qQOH+mv5yYAV+gIjGDvO7WnQlbdRhEOyDhO
   V3VkBVD9YbgWDfpwuCns9Q+wBTjR5pAiZei7lNhD1h1l0DK/coJCRM8eh
   nHPeOQ/iv9YP40QnMwZBE6h1pWw57VaXefar7E1XyPQDaIN4lwjBYFgdx
   3CTR+ggUKtbkpf8UaIFTLLtlVVp3+e2S4NXEBZeXvriqURwP33Gsasclh
   Gx3fRE7gqP4b8GvdlvBH0fgJQqZ9qPtyH4zeV0SamZFFT+Hi65svHrZdj
   A==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <kernel@axis.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH v2 3/3] regulator: virtual: add devicetree support
Date:   Tue, 1 Mar 2022 12:18:31 +0100
Message-ID: <20220301111831.3742383-4-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220301111831.3742383-1-vincent.whitchurch@axis.com>
References: <20220301111831.3742383-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reg-virt-consumer is very useful for development and testing of
regulator drivers since it allows voltages and modes to be set from
userspace.  However, it currently requires platform data so it cannot be
used without patching the kernel.  Add support for probing it from the
devicetree to remedy this.

Since this driver is only meant for testing and is a purely software
construct, no binding documentation is added.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---

Notes:
    v2:
    - Only use the "default" supply name if dt
    - Add a comment explaining the "default" supply name

 drivers/regulator/virtual.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/regulator/virtual.c b/drivers/regulator/virtual.c
index 9e0abbee1df5..5d32628a5011 100644
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
@@ -305,6 +314,14 @@ static int regulator_virtual_probe(struct platform_device *pdev)
 	if (drvdata == NULL)
 		return -ENOMEM;
 
+	/*
+	 * This virtual consumer does not have any hardware-defined supply
+	 * name, so just allow the regulator to be specified in a property
+	 * named "default-supply" when we're being probed from devicetree.
+	 */
+	if (!reg_id && pdev->dev.of_node)
+		reg_id = "default";
+
 	mutex_init(&drvdata->lock);
 
 	drvdata->regulator = devm_regulator_get(&pdev->dev, reg_id);
@@ -345,6 +362,7 @@ static struct platform_driver regulator_virtual_consumer_driver = {
 	.remove		= regulator_virtual_remove,
 	.driver		= {
 		.name		= "reg-virt-consumer",
+		.of_match_table = of_match_ptr(regulator_virtual_consumer_of_match),
 	},
 };
 
-- 
2.34.1

