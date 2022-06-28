Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90C455D55E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244263AbiF1FLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 01:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244420AbiF1FLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 01:11:23 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3728A1B4;
        Mon, 27 Jun 2022 22:11:21 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id w24so11438146pjg.5;
        Mon, 27 Jun 2022 22:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vnGv6vDn6qnrKuuz+/Sh2Rg6no8kgH/1Xp8PSIsPGhg=;
        b=am8dQ7vXTYHhEFPkccT6o/AlWUm5T1XoBhfUVhVjo0xjrvv+Ja72tXivfz8P8XrL2i
         iuypwtFq9gAiCocYQHgKZsjCOJX3ojIy906qjVFUEpHI1FepxH5NyyeEjIpTbIY1IHdk
         pHgzaf9h6OyP/0voGgf6hNv9zZHOCvRdzRwxQddaY1SP8X6GzPbCuWO38I0wrUIqC88L
         eUr64MOInloAxqHhZUhSg+dPMYeMfSozWVh70aBX4VB67yYzCMag9Jt7YCfTrG4lWKv+
         rLRoJMw5FlnWoIIvCVARN+hME7afseplwuKnMVsb+p/u3+hs/qU/sOXfAs2pZNAmAs0C
         sVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vnGv6vDn6qnrKuuz+/Sh2Rg6no8kgH/1Xp8PSIsPGhg=;
        b=1VQhuwDY5JxsC77jYyycRmXLqHu4rvkkTxseG3kRdlIhCLu5Is8Mlpm5wt2g62ZJw7
         OYa1upOfx6RbPMpe/HevlGAoVqHhSl7fmBBlEenzVnEh0/OtkYymSwkFaPiEhtFtuHGQ
         q3dyo/SdeYE0n2ajOYTJsuvpmrUMmKQSdJmXNzslWl9zXwsfsoc6Jg5/wdceaBDb/zAK
         I8eDCH07PDPcTzJakwZjpQW5+KQD45oK1IEOh1AheuR+4Uzq3uw3QmXjHiMwm60QcZ04
         eg21FR5CzRvphL7k0zMAIBMixboVM/wYVO8zanAebMKSZKP86CK4eszZST1Oo+na8RLE
         zIjA==
X-Gm-Message-State: AJIora/6SVWOJG3yM40FYsUC1ig4hnjB7GPTV8TNDAQ+oDn1U+ybO1+L
        5366ocTXLDRidB8XJOgFwXA=
X-Google-Smtp-Source: AGRyM1thi22W1H9JgV0MovDTCGGD2x9ERpjK0ECtuGEiLxeaGI13bl+mLS+wUQMsuNmqoC6zeKQH5w==
X-Received: by 2002:a17:90b:4b8c:b0:1ec:c7b8:7cb9 with SMTP id lr12-20020a17090b4b8c00b001ecc7b87cb9mr24863418pjb.86.1656393081076;
        Mon, 27 Jun 2022 22:11:21 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1f29:4aa9:50e7:2716:415:b90c])
        by smtp.googlemail.com with ESMTPSA id n17-20020a170903405100b0016a25ba1f46sm8051002pla.256.2022.06.27.22.11.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jun 2022 22:11:20 -0700 (PDT)
From:   Vishal Badole <badolevishal1116@gmail.com>
To:     sboyd@kernel.org
Cc:     mturquette@baylibre.com, inux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, chinmoyghosh2001@gmail.com,
        mintupatel89@gmail.com, vimal.kumar32@gmail.com,
        Vishal Badole <badolevishal1116@gmail.com>
Subject: [PATCH v3] Common clock: To list active consumers of clocks
Date:   Tue, 28 Jun 2022 10:38:42 +0530
Message-Id: <1656392922-11428-1-git-send-email-badolevishal1116@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20220624010550.582BBC341C7@smtp.kernel.org>
References: <20220624010550.582BBC341C7@smtp.kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This feature lists the clock consumer's name and per-user enable count
in clock summary. Using this feature user can easily check which device
has acquired a perticular clock and it is enabled by respective device
or not.
for example:
debian@beaglebone:~$ cat /sys/kernel/debug/clk/clk_summary
                      enable  prepare  protect                           duty  hardware                            per-user
   clock               count    count    count    rate   accuracy phase cycle    enable   consumer                    count
----------------------------------------------------------------------------------------------------------------------------
 clk_mcasp0_fixed         0        0        0    24576000      0     0  50000     Y      deviceless                      0
                                                                                         deviceless                      0
    clk_mcasp0            0        0        0    24576000      0     0  50000     N          simple-audio-card,cpu           0
                                                                                             deviceless                      0

Co-developed-by: Chinmoy Ghosh <chinmoyghosh2001@gmail.com>
Signed-off-by: Chinmoy Ghosh <chinmoyghosh2001@gmail.com>
Co-developed-by: Mintu Patel <mintupatel89@gmail.com>
Signed-off-by: Mintu Patel <mintupatel89@gmail.com>
Co-developed-by: Vimal Kumar <vimal.kumar32@gmail.com>
Signed-off-by: Vimal Kumar <vimal.kumar32@gmail.com>
Signed-off-by: Vishal Badole <badolevishal1116@gmail.com>
---
 drivers/clk/clk.c | 46 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index ed11918..6c4249e 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -102,6 +102,7 @@ struct clk {
 	unsigned long min_rate;
 	unsigned long max_rate;
 	unsigned int exclusive_count;
+	unsigned int enable_count;
 	struct hlist_node clks_node;
 };
 
@@ -1015,6 +1016,10 @@ void clk_disable(struct clk *clk)
 		return;
 
 	clk_core_disable_lock(clk->core);
+
+	if (clk->enable_count > 0)
+		clk->enable_count--;
+
 }
 EXPORT_SYMBOL_GPL(clk_disable);
 
@@ -1176,10 +1181,16 @@ EXPORT_SYMBOL_GPL(clk_restore_context);
  */
 int clk_enable(struct clk *clk)
 {
+	int ret;
+
 	if (!clk)
 		return 0;
 
-	return clk_core_enable_lock(clk->core);
+	ret = clk_core_enable_lock(clk->core);
+	if (!ret)
+		clk->enable_count++;
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(clk_enable);
 
@@ -2960,28 +2971,41 @@ static void clk_summary_show_one(struct seq_file *s, struct clk_core *c,
 				 int level)
 {
 	int phase;
+	struct clk *clk_user;
+	int multi_node = 0;
 
-	seq_printf(s, "%*s%-*s %7d %8d %8d %11lu %10lu ",
+	seq_printf(s, "%*s%-*s %-7d %-8d %-8d %-11lu %-10lu ",
 		   level * 3 + 1, "",
-		   30 - level * 3, c->name,
+		   35 - level * 3, c->name,
 		   c->enable_count, c->prepare_count, c->protect_count,
 		   clk_core_get_rate_recalc(c),
 		   clk_core_get_accuracy_recalc(c));
 
 	phase = clk_core_get_phase(c);
 	if (phase >= 0)
-		seq_printf(s, "%5d", phase);
+		seq_printf(s, "%-5d", phase);
 	else
 		seq_puts(s, "-----");
 
-	seq_printf(s, " %6d", clk_core_get_scaled_duty_cycle(c, 100000));
+	seq_printf(s, " %-6d", clk_core_get_scaled_duty_cycle(c, 100000));
 
 	if (c->ops->is_enabled)
-		seq_printf(s, " %9c\n", clk_core_is_enabled(c) ? 'Y' : 'N');
+		seq_printf(s, " %5c ", clk_core_is_enabled(c) ? 'Y' : 'N');
 	else if (!c->ops->enable)
-		seq_printf(s, " %9c\n", 'Y');
+		seq_printf(s, " %5c ", 'Y');
 	else
-		seq_printf(s, " %9c\n", '?');
+		seq_printf(s, " %5c ", '?');
+
+	hlist_for_each_entry(clk_user, &c->clks, clks_node) {
+		seq_printf(s, "%*s%-*s  %-4d\n",
+			   level * 3 + 2 + 105 * multi_node, "",
+			   30,
+			   clk_user->dev_id ? clk_user->dev_id : "deviceless",
+			   clk_user->enable_count);
+
+		multi_node = 1;
+	}
+
 }
 
 static void clk_summary_show_subtree(struct seq_file *s, struct clk_core *c,
@@ -3002,9 +3026,9 @@ static int clk_summary_show(struct seq_file *s, void *data)
 	struct clk_core *c;
 	struct hlist_head **lists = (struct hlist_head **)s->private;
 
-	seq_puts(s, "                                 enable  prepare  protect                                duty  hardware\n");
-	seq_puts(s, "   clock                          count    count    count        rate   accuracy phase  cycle    enable\n");
-	seq_puts(s, "-------------------------------------------------------------------------------------------------------\n");
+	seq_puts(s, "                                 enable  prepare  protect                                duty  hardware                            per-user\n");
+	seq_puts(s, "   clock                          count    count    count        rate   accuracy phase  cycle    enable   consumer                    count\n");
+	seq_puts(s, "-------------------------------------------------------------------------------------------------------------------------------------------\n");
 
 	clk_prepare_lock();
 
-- 
2.7.4

