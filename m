Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DAD54F086
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 07:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379928AbiFQFXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 01:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379464AbiFQFW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 01:22:57 -0400
Received: from mail-m965.mail.126.com (mail-m965.mail.126.com [123.126.96.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F92313E9B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 22:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=0tJ4S
        pzNNBnmG2C5jwqBC4QjnWPEch+HDg3rp/QBvCg=; b=Hm8dxOP3SZpJYO+bbs27h
        dea4DapVSkn8rcQY24dP8Viai5KiG58jzA9uJ4uQ75yTS/SnrWT65FfqqSM42gvO
        GfTvsC7WHVApOQCQ4kYLemf7Cn5vXHVY1qeYrjF2RLTGaiV4dMIpD/NxbpeC/ImC
        OjYqxcBrXpQlXcjfCYlffA=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp10 (Coremail) with SMTP id NuRpCgD3XYKHD6xisFtmEw--.28813S2;
        Fri, 17 Jun 2022 13:22:15 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     oss@buserror.net, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, christophe.jaillet@wanadoo.fr, windhl@126.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] powerpc:85xx: Add missing of_node_put() in sgy_cst1000
Date:   Fri, 17 Jun 2022 13:22:14 +0800
Message-Id: <20220617052214.4004188-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NuRpCgD3XYKHD6xisFtmEw--.28813S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFWDXw4xtF1xAw15tF4kCrg_yoW5CrykpF
        Z8CrZakrWkGw1xGw1Sya4DuFyayw18G3yxJw1fCan7C34UX34Dtr10vF15WrnxWrW8C3yr
        Jr4aka4YkFZrZa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR-B_UUUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbiuAcjF2JVj6VAsQAAsn
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In gpio_halt_probe(), of_find_matching_node() will return a node
pointer with refcount incremented. We should use of_node_put() in
fail path or when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/powerpc/platforms/85xx/sgy_cts1000.c | 39 +++++++++++++++--------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/sgy_cts1000.c b/arch/powerpc/platforms/85xx/sgy_cts1000.c
index 98ae64075193..a8690fc552cf 100644
--- a/arch/powerpc/platforms/85xx/sgy_cts1000.c
+++ b/arch/powerpc/platforms/85xx/sgy_cts1000.c
@@ -71,33 +71,39 @@ static int gpio_halt_probe(struct platform_device *pdev)
 {
 	enum of_gpio_flags flags;
 	struct device_node *node = pdev->dev.of_node;
+	struct device_node *child_node;
 	int gpio, err, irq;
 	int trigger;
+	int ret;
 
 	if (!node)
 		return -ENODEV;
 
 	/* If there's no matching child, this isn't really an error */
-	halt_node = of_find_matching_node(node, child_match);
-	if (!halt_node)
+	child_node = of_find_matching_node(node, child_match);
+	if (!child_node)
 		return 0;
 
 	/* Technically we could just read the first one, but punish
 	 * DT writers for invalid form. */
-	if (of_gpio_count(halt_node) != 1)
-		return -EINVAL;
+	if (of_gpio_count(child_node) != 1) {
+		ret = -EINVAL;
+		goto err_put;
+	}
 
 	/* Get the gpio number relative to the dynamic base. */
-	gpio = of_get_gpio_flags(halt_node, 0, &flags);
-	if (!gpio_is_valid(gpio))
-		return -EINVAL;
+	gpio = of_get_gpio_flags(child_node, 0, &flags);
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
@@ -105,15 +111,15 @@ static int gpio_halt_probe(struct platform_device *pdev)
 	gpio_direction_output(gpio, !trigger);
 
 	/* Now get the IRQ which tells us when the power button is hit */
-	irq = irq_of_parse_and_map(halt_node, 0);
+	irq = irq_of_parse_and_map(child_node, 0);
 	err = request_irq(irq, gpio_halt_irq, IRQF_TRIGGER_RISING |
-			  IRQF_TRIGGER_FALLING, "gpio-halt", halt_node);
+			  IRQF_TRIGGER_FALLING, "gpio-halt", child_node);
 	if (err) {
 		printk(KERN_ERR "gpio-halt: error requesting IRQ %d for "
 		       "GPIO %d.\n", irq, gpio);
 		gpio_free(gpio);
-		halt_node = NULL;
-		return err;
+		ret = err;
+		goto err_put;
 	}
 
 	/* Register our halt function */
@@ -122,8 +128,12 @@ static int gpio_halt_probe(struct platform_device *pdev)
 
 	printk(KERN_INFO "gpio-halt: registered GPIO %d (%d trigger, %d"
 	       " irq).\n", gpio, trigger, irq);
+	ret = 0;
+	halt_node = of_node_get(child_node);
 
-	return 0;
+err_put:
+	of_node_put(child_node);
+	return ret;
 }
 
 static int gpio_halt_remove(struct platform_device *pdev)
@@ -139,6 +149,7 @@ static int gpio_halt_remove(struct platform_device *pdev)
 
 		gpio_free(gpio);
 
+		of_node_put(halt_node);
 		halt_node = NULL;
 	}
 
-- 
2.25.1

