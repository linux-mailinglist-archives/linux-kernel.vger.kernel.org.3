Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90435A0D86
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 12:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240076AbiHYKIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 06:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240558AbiHYKIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:08:30 -0400
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02399AB4F4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 03:08:28 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id R9mjo8BOznj75R9mkodWvg; Thu, 25 Aug 2022 12:08:26 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 25 Aug 2022 12:08:26 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mike Turquette <mturquette@linaro.org>,
        Gabriel FERNANDEZ <gabriel.fernandez@st.com>,
        Pankaj Dev <pankaj.dev@st.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-clk@vger.kernel.org
Subject: [PATCH] clk: st: Fix some error handling path in st_of_quadfs_setup()
Date:   Thu, 25 Aug 2022 12:08:24 +0200
Message-Id: <dfa8886d700395249851f237ee0b783063168ec7.1661422054.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an error occurs, some resources still need to be released.

Add the corresponding error handing path.

Fixes: 5f7aa9071e93 ("clk: st: Support for QUADFS inside ClockGenB/C/D/E/F")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is NOT compile tested.
I don't have the needed build tool chain.
---
 drivers/clk/st/clkgen-fsyn.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/st/clkgen-fsyn.c b/drivers/clk/st/clkgen-fsyn.c
index d820292a381d..d1b3a4162682 100644
--- a/drivers/clk/st/clkgen-fsyn.c
+++ b/drivers/clk/st/clkgen-fsyn.c
@@ -984,7 +984,7 @@ static void __init st_of_quadfs_setup(struct device_node *np,
 		struct clkgen_quadfs_data_clks *datac)
 {
 	struct clk *clk;
-	const char *pll_name, *clk_parent_name;
+	const char *pll_name = NULL, *clk_parent_name;
 	void __iomem *reg;
 	spinlock_t *lock;
 	struct device_node *parent_np;
@@ -1006,32 +1006,38 @@ static void __init st_of_quadfs_setup(struct device_node *np,
 
 	clk_parent_name = of_clk_get_parent_name(np, 0);
 	if (!clk_parent_name)
-		return;
+		goto err_unmap;
 
 	pll_name = kasprintf(GFP_KERNEL, "%pOFn.pll", np);
 	if (!pll_name)
-		return;
+		goto err_unmap;
 
 	lock = kzalloc(sizeof(*lock), GFP_KERNEL);
 	if (!lock)
-		goto err_exit;
+		goto err_unmap;
 
 	spin_lock_init(lock);
 
 	clk = st_clk_register_quadfs_pll(pll_name, clk_parent_name, datac->data,
 			reg, lock);
 	if (IS_ERR(clk))
-		goto err_exit;
-	else
-		pr_debug("%s: parent %s rate %u\n",
-			__clk_get_name(clk),
-			__clk_get_name(clk_get_parent(clk)),
-			(unsigned int)clk_get_rate(clk));
+		goto err_free_lock;
+
+	pr_debug("%s: parent %s rate %u\n",
+		 __clk_get_name(clk), __clk_get_name(clk_get_parent(clk)),
+		 (unsigned int)clk_get_rate(clk));
 
 	st_of_create_quadfs_fsynths(np, pll_name, datac, reg, lock);
 
-err_exit:
+out:
 	kfree(pll_name); /* No longer need local copy of the PLL name */
+	return;
+
+err_free_lock:
+	kfree(lock);
+err_unmap:
+	iounmap(reg);
+	goto out;
 }
 
 static void __init st_of_quadfs660C_setup(struct device_node *np)
-- 
2.34.1

