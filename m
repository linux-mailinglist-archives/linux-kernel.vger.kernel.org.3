Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6875881BC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 20:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbiHBSLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 14:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237793AbiHBSLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 14:11:04 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B98117E13;
        Tue,  2 Aug 2022 11:11:00 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 23so13012873pgc.8;
        Tue, 02 Aug 2022 11:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VSuThS25A1SmF3lUm9zKQZW1zZmHE3Wa8nzE8cQc3xY=;
        b=MOST/R+9Pu82byZZKWzHAXHowM9RJkX/xUI4J81mR9yItGRirdWszF98BMKIxPBMMc
         eFq/ID+KIn3x/BMcVPOq7Bi6XBg5OQUaHTKQSeADQsTn6iOtLRyvId6U1uDfwomtA5VZ
         LTZH4P6s2gF4tLv4cWTa4PIDcuBkZngU3nUhgPvEwijLrDJnvgODE4I+eXddkoYr+NDr
         YWjGTVn9AQV62O92oy4+KJLOmMYiUAVXVWkeBdR9jJyDgbNfe9Kj6ycgRhXB1t2+YFE8
         FXXZi/GbneyhW1+4dplOoTGje3/dxMHcX5zm37yB1aLLe6C9uhdij9B4Ym+FUGaGfSEO
         sjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VSuThS25A1SmF3lUm9zKQZW1zZmHE3Wa8nzE8cQc3xY=;
        b=SYRQrTzij38LJm5CQ5gcoMeOPqMh4pr8QNimQUjx/Je/dxDPBuV7UgueaKaYuJ/RzD
         ExqSXsL/h3ZJSgXliGHSISwl/o875NkVQDaCXUEOzQce5ItX+haChgjPpzVa4CKk1Cqz
         YUEYyCoFsneXgpehZwmfI3LfQgFT4ljBKKjb8/m49oJv6CqHobFSSfibALiXO8TWimAK
         fBuHEzkI9NS/LxpikLyzL5UlnTwBmjFZlwhRiy7LUGVprTRYwvFYysWnumD5nLlbSOmb
         JmfsJZShQVYoVq8XWpIkAye5KDgMFkHZIdWRVewk3yuFyId/LeQt+5oDW3lnrWnH3Zxr
         C8SA==
X-Gm-Message-State: AJIora/m6mP3uUCBR4OiP2LyQy+JPaIzuV9v326Zmcj9ZbT8g9yGNetW
        BqG4oapVFewCI2Rv8BMQGdWj9ql4EuE=
X-Google-Smtp-Source: AGRyM1vyvI1vzvid8Bo8G+oWfNYRN17arAZ2ebp+U+Q4l6i2IbT8kUgZTGt/txgwEVoiTexo6aTxmA==
X-Received: by 2002:a05:6a00:1a44:b0:52a:ecd5:bbef with SMTP id h4-20020a056a001a4400b0052aecd5bbefmr21566896pfv.28.1659463859515;
        Tue, 02 Aug 2022 11:10:59 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1cc5:2406:5d81:6fe8:af08:c752])
        by smtp.googlemail.com with ESMTPSA id z22-20020aa79496000000b0052d8d7269d7sm4420525pfk.53.2022.08.02.11.10.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Aug 2022 11:10:59 -0700 (PDT)
From:   Vishal Badole <badolevishal1116@gmail.com>
To:     sboyd@kernel.org
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, chinmoyghosh2001@gmail.com,
        vimal.kumar32@gmail.com,
        Vishal Badole <badolevishal1116@gmail.com>,
        Mintu Patel <mintupatel89@gmail.com>
Subject: [PATCH v3] Common clock: To list active consumers of clocks
Date:   Tue,  2 Aug 2022 23:39:47 +0530
Message-Id: <1659463787-25976-1-git-send-email-badolevishal1116@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20220624010550.582BBC341C7@smtp.kernel.org>
References: <20220624010550.582BBC341C7@smtp.kernel.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
$ cat /sys/kernel/debug/clk/clk_summary
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
index f00d4c1..c96079f 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -102,6 +102,7 @@ struct clk {
 	unsigned long min_rate;
 	unsigned long max_rate;
 	unsigned int exclusive_count;
+	unsigned int enable_count;
 	struct hlist_node clks_node;
 };
 
@@ -1008,6 +1009,10 @@ void clk_disable(struct clk *clk)
 		return;
 
 	clk_core_disable_lock(clk->core);
+
+	if (clk->enable_count > 0)
+		clk->enable_count--;
+
 }
 EXPORT_SYMBOL_GPL(clk_disable);
 
@@ -1169,10 +1174,16 @@ EXPORT_SYMBOL_GPL(clk_restore_context);
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
 
@@ -2953,28 +2964,41 @@ static void clk_summary_show_one(struct seq_file *s, struct clk_core *c,
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
@@ -2995,9 +3019,9 @@ static int clk_summary_show(struct seq_file *s, void *data)
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

