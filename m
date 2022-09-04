Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988865AC483
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 15:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbiIDNf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 09:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiIDNfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 09:35:24 -0400
Received: from smtp.smtpout.orange.fr (smtp09.smtpout.orange.fr [80.12.242.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B442B2E69C
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 06:35:22 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id UpmRocfhftUbyUpmRoyoAn; Sun, 04 Sep 2022 15:35:20 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 04 Sep 2022 15:35:20 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Corey Minyard <minyard@acm.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        openipmi-developer@lists.sourceforge.net
Subject: [PATCH] ipmi: kcs_bmc: Avoid wasting some memory.
Date:   Sun,  4 Sep 2022 15:35:16 +0200
Message-Id: <5d69a2d0939ce3917c856b36ef1e41b579081be6.1662298496.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KCS_MSG_BUFSIZ is 1000.

When using devm_kmalloc(), there is a small memory overhead and, on most
systems, this leads to 40 bytes of extra memory allocation.
So 1040 bytes are expected to be allocated.

The memory allocator works with fixed size hunks of memory. In this case,
it will require 2048 bytes of memory because more than 1024 bytes are
required.

So, when requesting 3 x 1000 bytes, it ends up to 2048 x 3.

In order to avoid wasting 3ko of memory, allocate buffers all at once.
3000+40 bytes will be required and 4ko allocated. This still wastes 1ko,
but it is already better.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Looking at this code, I wonder why priv->miscdev.name is not freed in
kcs_bmc_ipmi_remove_device()?

If this make sense, this also mean that KCS_MSG_BUFSIZ can be increased at
no cost.
Or it could be slightly reduce to around 1024-40-1 bytes to keep the logic
which is in place.

Another solution would be to use just kmalloc and add a
devm_add_action_or_reset() call and a function that frees the memory.
If it make sense, KCS_MSG_BUFSIZ could be increased to 1024 and we would
allocate just a little above 3x1024 bytes.
---
 drivers/char/ipmi/kcs_bmc_cdev_ipmi.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c b/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
index 486834a962c3..15a4a39a6478 100644
--- a/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
+++ b/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
@@ -485,14 +485,15 @@ static int kcs_bmc_ipmi_add_device(struct kcs_bmc_device *kcs_bmc)
 
 	priv->client.dev = kcs_bmc;
 	priv->client.ops = &kcs_bmc_ipmi_client_ops;
-	priv->data_in = devm_kmalloc(kcs_bmc->dev, KCS_MSG_BUFSIZ, GFP_KERNEL);
-	priv->data_out = devm_kmalloc(kcs_bmc->dev, KCS_MSG_BUFSIZ, GFP_KERNEL);
-	priv->kbuffer = devm_kmalloc(kcs_bmc->dev, KCS_MSG_BUFSIZ, GFP_KERNEL);
+	/* Allocate buffers all at once */
+	priv->data_in = devm_kmalloc(kcs_bmc->dev, KCS_MSG_BUFSIZ * 3, GFP_KERNEL);
+	priv->data_out = priv->data_in + KCS_MSG_BUFSIZ;
+	priv->kbuffer  = priv->data_in + KCS_MSG_BUFSIZ * 2;
 
 	priv->miscdev.minor = MISC_DYNAMIC_MINOR;
 	priv->miscdev.name = devm_kasprintf(kcs_bmc->dev, GFP_KERNEL, "%s%u", DEVICE_NAME,
 					   kcs_bmc->channel);
-	if (!priv->data_in || !priv->data_out || !priv->kbuffer || !priv->miscdev.name)
+	if (!priv->data_in || !priv->miscdev.name)
 		return -EINVAL;
 
 	priv->miscdev.fops = &kcs_bmc_ipmi_fops;
@@ -531,8 +532,6 @@ static int kcs_bmc_ipmi_remove_device(struct kcs_bmc_device *kcs_bmc)
 
 	misc_deregister(&priv->miscdev);
 	kcs_bmc_disable_device(priv->client.dev, &priv->client);
-	devm_kfree(kcs_bmc->dev, priv->kbuffer);
-	devm_kfree(kcs_bmc->dev, priv->data_out);
 	devm_kfree(kcs_bmc->dev, priv->data_in);
 	devm_kfree(kcs_bmc->dev, priv);
 
-- 
2.34.1

