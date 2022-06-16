Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC1C54DC42
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242049AbiFPH4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiFPH4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:56:45 -0400
Received: from m15111.mail.126.com (m15111.mail.126.com [220.181.15.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DCD355D5F7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 00:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=LIcj/
        J5ZMaTfidoH1YqlkSee/mURHk9R9nwbtWge7aM=; b=EvBfc518sCN4qXUYM/cVQ
        wF2itf/pzkLdTTHVZpIRHZEIpBuDH4CoKk707YdMqTb4+bT7a8h4afm4xBDM1FIm
        i+myGI4QMqIz1QMpyI9MyC5yzWK3Pu0l0wLMP9I+7C7JONQOmJaMHl4C+MC6h3A9
        p8VTdRAbnX6rLzHGjZ3Hvg=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp1 (Coremail) with SMTP id C8mowABXNd4i4qpi5JAYEg--.33043S2;
        Thu, 16 Jun 2022 15:56:19 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu
Cc:     windhl@126.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] soc: sifive: Add missing of_node_put() in sifive_l2_cache.c
Date:   Thu, 16 Jun 2022 15:56:18 +0800
Message-Id: <20220616075618.3983977-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8mowABXNd4i4qpi5JAYEg--.33043S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur4DAr47AryxJF1fCFW5Awb_yoW8urWrpr
        W7JryYvry8Ww4xWrZxJas8ZFyF9r1I93y7KFy7uwn8Zr17Jr1qqr4SyFyUZFZxCrW8uws3
        tr4jkF1DCF109FDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi5fQtUUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbiuBQiF2JVj47iXgACsR
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
 changelog:

 v3: (1) fix error introduced by v2, missing 'int ret;' (2) fix error
      reported by checkpatch.pl (3) change subject title based on
      Conor's advice and drop the 'Reported by KLP' as this commit
      has not been applied.
 v2: fix error introduced by v1, missing ';'
 v1: fix missing of_node_put bug


 drivers/soc/sifive/sifive_l2_cache.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/sifive/sifive_l2_cache.c b/drivers/soc/sifive/sifive_l2_cache.c
index 59640a1d0b28..dbaa66f59048 100644
--- a/drivers/soc/sifive/sifive_l2_cache.c
+++ b/drivers/soc/sifive/sifive_l2_cache.c
@@ -197,22 +197,28 @@ static int __init sifive_l2_init(void)
 	struct device_node *np;
 	struct resource res;
 	int i, rc, intr_num;
+	int ret;
 
 	np = of_find_matching_node(NULL, sifive_l2_ids);
 	if (!np)
 		return -ENODEV;
 
-	if (of_address_to_resource(np, 0, &res))
-		return -ENODEV;
+	if (of_address_to_resource(np, 0, &res)) {
+		ret = -ENODEV;
+		goto out_put;
+	}
 
 	l2_base = ioremap(res.start, resource_size(&res));
-	if (!l2_base)
-		return -ENOMEM;
+	if (!l2_base) {
+		ret = -ENOMEM;
+		goto out_put;
+	}
 
 	intr_num = of_property_count_u32_elems(np, "interrupts");
 	if (!intr_num) {
 		pr_err("L2CACHE: no interrupts property\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out_put;
 	}
 
 	for (i = 0; i < intr_num; i++) {
@@ -220,7 +226,8 @@ static int __init sifive_l2_init(void)
 		rc = request_irq(g_irq[i], l2_int_handler, 0, "l2_ecc", NULL);
 		if (rc) {
 			pr_err("L2CACHE: Could not request IRQ %d\n", g_irq[i]);
-			return rc;
+			ret = rc;
+			goto out_put;
 		}
 	}
 
@@ -232,6 +239,9 @@ static int __init sifive_l2_init(void)
 #ifdef CONFIG_DEBUG_FS
 	setup_sifive_debug();
 #endif
-	return 0;
+	ret = 0;
+out_put:
+	of_node_put(np);
+	return ret;
 }
 device_initcall(sifive_l2_init);
-- 
2.25.1

