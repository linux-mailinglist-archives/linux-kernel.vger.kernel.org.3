Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C66E54C824
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 14:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348411AbiFOMIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 08:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240502AbiFOMIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:08:42 -0400
Received: from m15112.mail.126.com (m15112.mail.126.com [220.181.15.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 396F7403F2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=58oAQ
        UJN8JUwGFEUGf4YZNmf+AqCGHJHSJulELfzgaU=; b=jtp6v+PUhO9GNmrF3z/lh
        0YvwA/qXsvMuR21y9cY0bfot3aw8wi2eiEyEFMCr4ZAoCAp8shH7dwgsnkp/X9cS
        JZENlIEfTmg6Q6SjQbpMi3Dr2de3eKq1qIwcayjuzFAnJjdSlP5q4bmNykTOvCLh
        pf/4HcfWS+IXJ+a+BIQH+U=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp2 (Coremail) with SMTP id DMmowABnegV1y6liCKo0DQ--.43270S2;
        Wed, 15 Jun 2022 20:07:18 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     oss@buserror.net, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Liang He <windhl@126.com>
Subject: [PATCH] arch: powerpc: platforms: 85xx: Add missing of_node_put in sgy_cts1000.c
Date:   Wed, 15 Jun 2022 20:07:17 +0800
Message-Id: <20220615120717.3965164-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMmowABnegV1y6liCKo0DQ--.43270S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF4DZF45Cw48ur1rAr1UKFg_yoW8XFykpF
        s0kayfCFsrWryxGasrtas8CFy7t3W0qay7Jw1akws7C3W8X39Fvry8ZF4xXrn3uFW8G3yr
        Jr1ayayq9FsFv3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRT7KfUUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/xtbBGgchF1-HZTZrDwAAsE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liang He <windhl@126.com>
---
 arch/powerpc/platforms/85xx/sgy_cts1000.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/platforms/85xx/sgy_cts1000.c b/arch/powerpc/platforms/85xx/sgy_cts1000.c
index 98ae64075193..2a45b30852b2 100644
--- a/arch/powerpc/platforms/85xx/sgy_cts1000.c
+++ b/arch/powerpc/platforms/85xx/sgy_cts1000.c
@@ -85,17 +85,24 @@ static int gpio_halt_probe(struct platform_device *pdev)
 	/* Technically we could just read the first one, but punish
 	 * DT writers for invalid form. */
 	if (of_gpio_count(halt_node) != 1)
+	{
+		of_node_put(halt_node);
 		return -EINVAL;
+	}
 
 	/* Get the gpio number relative to the dynamic base. */
 	gpio = of_get_gpio_flags(halt_node, 0, &flags);
 	if (!gpio_is_valid(gpio))
+	{
+		of_node_put(halt_node);
 		return -EINVAL;
+	}
 
 	err = gpio_request(gpio, "gpio-halt");
 	if (err) {
 		printk(KERN_ERR "gpio-halt: error requesting GPIO %d.\n",
 		       gpio);
+		of_node_put(halt_node);
 		halt_node = NULL;
 		return err;
 	}
@@ -112,6 +119,7 @@ static int gpio_halt_probe(struct platform_device *pdev)
 		printk(KERN_ERR "gpio-halt: error requesting IRQ %d for "
 		       "GPIO %d.\n", irq, gpio);
 		gpio_free(gpio);
+		of_node_put(halt_node);
 		halt_node = NULL;
 		return err;
 	}
@@ -123,6 +131,8 @@ static int gpio_halt_probe(struct platform_device *pdev)
 	printk(KERN_INFO "gpio-halt: registered GPIO %d (%d trigger, %d"
 	       " irq).\n", gpio, trigger, irq);
 
+	of_node_put(halt_node);
+
 	return 0;
 }
 
-- 
2.25.1

