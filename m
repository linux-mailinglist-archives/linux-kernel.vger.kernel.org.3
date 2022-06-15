Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAA254C860
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 14:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348643AbiFOMXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 08:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348588AbiFOMXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:23:36 -0400
Received: from mail-m964.mail.126.com (mail-m964.mail.126.com [123.126.96.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E19A839175
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=/S7Lt
        ya1R558SjoL2Bmo37oQ/5sKW0975g2st9fErow=; b=AU6k1GCoeSNgChOeXIDO0
        nXYr0qSuT7/FYVN2/KZaL2Sa5dpN2yrhybSdSnOvOog4siprnWRmsAuWjZqQDce7
        I4evqhKkSpLF4sTteQzHKAOt4I1LPzGlIitsPmxSKqouF69wkvqMsyxnozRBQMft
        EfbY4/k/1Pa00tLYfbwVpg=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp9 (Coremail) with SMTP id NeRpCgCHLYM0z6lij5AsEw--.51216S2;
        Wed, 15 Jun 2022 20:23:18 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        windhl@126.com
Subject: [PATCH] drivers: soc: sifive: Add missing of_node_put() in sifive_l2_cache.c
Date:   Wed, 15 Jun 2022 20:23:15 +0800
Message-Id: <20220615122315.3965435-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NeRpCgCHLYM0z6lij5AsEw--.51216S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur4DAr47AryxJF1fCFW5Awb_yoW8Aryrpr
        W7XryYvry8Gws7WrW3Ja1DZFyF9r1Ik3y3KFyxuwnxAr15Jr1qqr4SyFyjqrZxCry8u398
        tr4jkr1DCFy0kFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pirWrdUUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/xtbBGgYhF1-HZTaAQAAAsh
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sifive_l2_init(), of_find_matching_node() will return a node pointer
with refcount incremented. We should use of_node_put() in each fail path
or when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 drivers/soc/sifive/sifive_l2_cache.c | 29 ++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/sifive/sifive_l2_cache.c b/drivers/soc/sifive/sifive_l2_cache.c
index 59640a1d0b28..2b9c9522ef21 100644
--- a/drivers/soc/sifive/sifive_l2_cache.c
+++ b/drivers/soc/sifive/sifive_l2_cache.c
@@ -198,29 +198,41 @@ static int __init sifive_l2_init(void)
 	struct resource res;
 	int i, rc, intr_num;
 
+	int ret;
+
 	np = of_find_matching_node(NULL, sifive_l2_ids);
 	if (!np)
 		return -ENODEV;
 
 	if (of_address_to_resource(np, 0, &res))
-		return -ENODEV;
+	{
+		ret = -ENODEV;
+		goto out_put;
+	}
 
 	l2_base = ioremap(res.start, resource_size(&res));
 	if (!l2_base)
-		return -ENOMEM;
+	{
+		ret = -ENOMEM;
+		goto out_put;
+	}
 
 	intr_num = of_property_count_u32_elems(np, "interrupts");
-	if (!intr_num) {
+	if (!intr_num) {		
 		pr_err("L2CACHE: no interrupts property\n");
-		return -ENODEV;
+		ret = -ENODEV
+		goto out_put;
 	}
 
 	for (i = 0; i < intr_num; i++) {
 		g_irq[i] = irq_of_parse_and_map(np, i);
 		rc = request_irq(g_irq[i], l2_int_handler, 0, "l2_ecc", NULL);
+		
 		if (rc) {
+			
 			pr_err("L2CACHE: Could not request IRQ %d\n", g_irq[i]);
-			return rc;
+			ret = rc;
+			goto out_put;
 		}
 	}
 
@@ -232,6 +244,11 @@ static int __init sifive_l2_init(void)
 #ifdef CONFIG_DEBUG_FS
 	setup_sifive_debug();
 #endif
-	return 0;
+	ret = 0;
+	
+	
+out_put:
+	of_node_put(np);
+	return ret;
 }
 device_initcall(sifive_l2_init);
-- 
2.25.1

