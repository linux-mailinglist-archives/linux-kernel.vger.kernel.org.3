Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8DC5AF43D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiIFTLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiIFTLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:11:17 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F54A4070;
        Tue,  6 Sep 2022 12:11:16 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c2so12232995plo.3;
        Tue, 06 Sep 2022 12:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Uxyfydq6mAQset0rLjj0lZ4kT2T9DNQSTtQIf3P/WBc=;
        b=oxJVDLjYXG19wqnH1nnFoB8v1YUHjmBDOpxhsRIcHu18Lp+SuatKIr8BBiqhtCS2zS
         8FdV2LiA2sf+BltT5uHDrkQomWbRcswYAw9e4LKWCFH0WxWZYyFzBWPig2oThOXgwr06
         EP9UxK+6dic8lRLj/pt7mK7VlghHDkYFfBb9q4W23L5T838up4tW8Y0yQ+S4+8FnXRUg
         FWJVXIMLx0GCU31MZH/KI58HZA5v1ebcsU4XE4Yxh4Zo6Ep+dRO4FRufHZakBcO6SAjT
         XJ7XshjTMqg+L/1nNyfRRifLY5Qq/Ll8Dbj8fAy1AVdV20YF/awcuCEL2zoLtw/KJyhB
         OnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Uxyfydq6mAQset0rLjj0lZ4kT2T9DNQSTtQIf3P/WBc=;
        b=gGOlq6hvXL9j/Ht7qtnnA8DWqMh1dK1m6OFf4QrY4gT5O6moalThOrX/5nx73q+Huy
         oPfnuR0GC/39f1ccW8vJIsOmb+qSPUH6NuFTVwSlElW1+1vrO2X9Vlhf2UjY4kTu/ctf
         YLq31Al10u3MW5d5Gr8pwMUIwA7Wn5wAU8PS8XxvWD8VMSsXhqtPCff1HqfmvAsfXDVn
         GaloM+SwAFcE4YamxgDZagdNLlt0mWxw8Cs7FRAa4hZiPYZOO65X2SQs3TxTSbcZn1w8
         6ujJyI3EhhS30U3pf3bakW83N0sqQUecFKC+XMHI3YyVY2HUunv5O8vebfgE++SQebhO
         rX7Q==
X-Gm-Message-State: ACgBeo32g7hfp77MJlYqQZviNPkGhbwu9V1XMBbzyPRsheaXfcELgY1a
        ZoH07XV/ptPmi8sOEfWE7C370/iSgjTRDg==
X-Google-Smtp-Source: AA6agR6KeD/ronskaUphIe75PRVpn0Gz8ycVJHGWaWdgrnikNAJXC7eBzzsQfBetAAs0ds0Sb0bBtQ==
X-Received: by 2002:a17:902:aa8c:b0:173:4137:55c4 with SMTP id d12-20020a170902aa8c00b00173413755c4mr56436346plr.108.1662491475771;
        Tue, 06 Sep 2022 12:11:15 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1f28:3ecf:7535:6f32:453c:4179])
        by smtp.googlemail.com with ESMTPSA id h10-20020a170902680a00b0016d4f05eb95sm10213461plk.272.2022.09.06.12.11.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Sep 2022 12:11:15 -0700 (PDT)
From:   Vishal Badole <badolevishal1116@gmail.com>
To:     sboyd@kernel.org
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mintupatel89@gmail.com,
        chinmoyghosh2001@gmail.com, vimal.kumar32@gmail.com,
        Vishal Badole <badolevishal1116@gmail.com>
Subject: [PATCH v4] Common clock: To list active consumers of clocks
Date:   Wed,  7 Sep 2022 00:39:51 +0530
Message-Id: <1662491391-12111-1-git-send-email-badolevishal1116@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This feature lists the clock consumer's name and respective connection
id. Using this feature user can easily check that which user has
acquired and enabled a particular clock.

Co-developed-by: Chinmoy Ghosh <chinmoyghosh2001@gmail.com>
Signed-off-by: Chinmoy Ghosh <chinmoyghosh2001@gmail.com>
Co-developed-by: Mintu Patel <mintupatel89@gmail.com>
Signed-off-by: Mintu Patel <mintupatel89@gmail.com>
Co-developed-by: Vimal Kumar <vimal.kumar32@gmail.com>
Signed-off-by: Vimal Kumar <vimal.kumar32@gmail.com>
Signed-off-by: Vishal Badole <badolevishal1116@gmail.com>
---
 drivers/clk/clk.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index f00d4c1..db48f84 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2953,28 +2953,41 @@ static void clk_summary_show_one(struct seq_file *s, struct clk_core *c,
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
+		seq_printf(s, "%*s%-*s  %-25s\n",
+			   level * 3 + 2 + 105 * multi_node, "",
+			   30,
+			   clk_user->dev_id ? clk_user->dev_id : "deviceless",
+			   clk_user->con_id ? clk_user->con_id : "no_connection_id");
+
+		multi_node = 1;
+	}
+
 }
 
 static void clk_summary_show_subtree(struct seq_file *s, struct clk_core *c,
@@ -2995,9 +3008,10 @@ static int clk_summary_show(struct seq_file *s, void *data)
 	struct clk_core *c;
 	struct hlist_head **lists = (struct hlist_head **)s->private;
 
-	seq_puts(s, "                                 enable  prepare  protect                                duty  hardware\n");
-	seq_puts(s, "   clock                          count    count    count        rate   accuracy phase  cycle    enable\n");
-	seq_puts(s, "-------------------------------------------------------------------------------------------------------\n");
+	seq_puts(s, "                                 enable  prepare  protect                                duty  hardware                            connection\n");
+	seq_puts(s, "   clock                          count    count    count        rate   accuracy phase  cycle    enable   consumer                         id\n");
+	seq_puts(s, "---------------------------------------------------------------------------------------------------------------------------------------------\n");
+
 
 	clk_prepare_lock();
 
-- 
2.7.4

