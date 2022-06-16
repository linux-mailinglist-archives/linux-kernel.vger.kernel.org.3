Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236A054E5DB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 17:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238136AbiFPPTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 11:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbiFPPTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 11:19:51 -0400
Received: from m15111.mail.126.com (m15111.mail.126.com [220.181.15.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC5BF11816
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 08:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=nsVvp
        /8TetDFrxpido6IqFxlF0d+SkPkvOqKIqtD0WE=; b=JRXx6VdfJRgtM7cqNamoD
        iDlPiD9x3Jz7b7UXz+tWd08mcWIrjoLX6bp/Nmq40hPImFzDaa0BeA6ntT70cV6e
        +UeVF+bPj6Be3t786E2PtoEIimFp4cRM+rphjKsN/2HS3rYcUatoHzruJEzTxDtc
        pNAUIy3LDv2FpVQS2U2mpM=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp1 (Coremail) with SMTP id C8mowACn1CTkSatiqJdkEg--.27454S2;
        Thu, 16 Jun 2022 23:19:02 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     oss@buserror.net, mpe@ellerman.id.au, paulus@samba.org,
        christophe.leroy@csgroup.eu, nixiaoming@huawei.com
Cc:     windhl@126.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arch: powerpc: platforms: 85xx: Add missing of_node_put in sgy_cts1000.c
Date:   Thu, 16 Jun 2022 23:19:01 +0800
Message-Id: <20220616151901.3989078-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8mowACn1CTkSatiqJdkEg--.27454S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFW8uw1UJF13CF4xKrWktFb_yoW8KryfpF
        Z8GrWSkrWkGr1xG3s7ta1DuFy3tw10qay3tw13Cws7C3WUX3yqvry0vF4rXr1fWFW8C3yr
        Jr4akayj9FZFv3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRfMarUUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbizgciF18RPTmY+QAAsX
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In gpio_halt_probe(), of_find_matching_node() will return a node pointer with
refcount incremented. We should use of_node_put() in each fail path or when it
is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 changelog:

 v2: use goto-label patch style advised by Christophe.
 v1: add of_node_put() before each exit.

 arch/powerpc/platforms/85xx/sgy_cts1000.c | 27 +++++++++++++++--------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/sgy_cts1000.c b/arch/powerpc/platforms/85xx/sgy_cts1000.c
index 98ae64075193..e280f963d88c 100644
--- a/arch/powerpc/platforms/85xx/sgy_cts1000.c
+++ b/arch/powerpc/platforms/85xx/sgy_cts1000.c
@@ -73,6 +73,7 @@ static int gpio_halt_probe(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 	int gpio, err, irq;
 	int trigger;
+	int ret;
 
 	if (!node)
 		return -ENODEV;
@@ -84,20 +85,24 @@ static int gpio_halt_probe(struct platform_device *pdev)
 
 	/* Technically we could just read the first one, but punish
 	 * DT writers for invalid form. */
-	if (of_gpio_count(halt_node) != 1)
-		return -EINVAL;
+	if (of_gpio_count(halt_node) != 1) {
+		ret = -EINVAL;
+		goto err_put;
+	}
 
 	/* Get the gpio number relative to the dynamic base. */
 	gpio = of_get_gpio_flags(halt_node, 0, &flags);
-	if (!gpio_is_valid(gpio))
-		return -EINVAL;
+	if (!gpio_is_valid(gpio)) {
+		ret = -EINVAL;
+		gotot err_put;
+	}
 
 	err = gpio_request(gpio, "gpio-halt");
 	if (err) {
 		printk(KERN_ERR "gpio-halt: error requesting GPIO %d.\n",
 		       gpio);
-		halt_node = NULL;
-		return err;
+		ret = err;
+		goto err_put;
 	}
 
 	trigger = (flags == OF_GPIO_ACTIVE_LOW);
@@ -112,8 +117,8 @@ static int gpio_halt_probe(struct platform_device *pdev)
 		printk(KERN_ERR "gpio-halt: error requesting IRQ %d for "
 		       "GPIO %d.\n", irq, gpio);
 		gpio_free(gpio);
-		halt_node = NULL;
-		return err;
+		ret = err;
+		goto err_put;
 	}
 
 	/* Register our halt function */
@@ -122,8 +127,12 @@ static int gpio_halt_probe(struct platform_device *pdev)
 
 	printk(KERN_INFO "gpio-halt: registered GPIO %d (%d trigger, %d"
 	       " irq).\n", gpio, trigger, irq);
+	ret = 0;
 
-	return 0;
+err_put:
+	of_node_put(halt_node);
+	halt_node = NULL;
+	return ret;
 }
 
 static int gpio_halt_remove(struct platform_device *pdev)
-- 
2.25.1

