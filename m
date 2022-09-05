Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279B65AD738
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 18:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiIEQPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 12:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiIEQPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 12:15:09 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432F91EC78;
        Mon,  5 Sep 2022 09:15:06 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id p1-20020a17090a2d8100b0020040a3f75eso4080490pjd.4;
        Mon, 05 Sep 2022 09:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=GSz8QcnAF3KVd+oYRHdCdNqyO/6sC9qiC/oawbq6vX0=;
        b=TZlspr0pqC2LgAzFjuWe4hTt2KUJ4JXaZhVc97pt14ru5A7+owVex9/HAE7cIKz5Jz
         UMOivxgzlnQ+1ldJyqEJ2EZCqbC15900NmBQKqE4mor/fPRtzZ4t4vGm4PsRQVb9mD27
         nPpg6eqkGVGT4kJX0t6Bo4JKFoWRFzmHN3naf7v5LIDEKD83UVYJP/e70P27NYnf5UpU
         gfqp4uyhs8Y6EPUSYszMQxSRmxVyurTGqqEeX83PVQFSU13neePKB3MjxYFuOix57JD+
         aIbbA8cMHFT7NUE9Qo0nioOQD4G/Qp5THv624d9YDb76JfcRT0uPwt+Q5FJH/b9ZicLM
         +Bwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=GSz8QcnAF3KVd+oYRHdCdNqyO/6sC9qiC/oawbq6vX0=;
        b=syKEUbrKZsbnWAnpwMuAqlRnNJwCBW8JyGFSOGWapqU5iOZB5iXTSQH4vrLlU9KYHu
         jK1cAuW+huyzjWc5N145+Sn1mLLWF7Ww0IkPyERBGIKerw2NTShGuKcd6tHmMqMZe3k9
         sUfMGg9H2NhlpwcPCq5tdLFcOi1O8C4UMNcsL0jGXurugtrongsvC3d2zBGQps6URHge
         os9TxHBGTbP0AfTOmoXwHj/Ma5t+TskJpWW04NxM/dKSCrxp76PHSeHWBB931LrYrQur
         PlHUKPEtKFq2TAvJrsfL6jpg6BksLjrzJfgTzw+vQQLJhUvWvTlfAMXDFHnzXAwQhxuj
         8f5w==
X-Gm-Message-State: ACgBeo1NEJrF568ZIEDk2SOoG5VENXejeRW8ANDfE4dniqebwj6/bG3S
        v+B0RF3RqAMN+ilsyCzEnNR5SLPPl8A=
X-Google-Smtp-Source: AA6agR6pRp+Oljy6r7Avsn/FovLn/AmM5J1ds+hM+Vy7Ewdg2DvGlA3YA4fF/rJfyRId1YnjOJ0oyQ==
X-Received: by 2002:a17:902:f787:b0:172:f321:2fd1 with SMTP id q7-20020a170902f78700b00172f3212fd1mr48939853pln.121.1662394505225;
        Mon, 05 Sep 2022 09:15:05 -0700 (PDT)
Received: from 7YHHR73.igp.broadcom.net (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id t12-20020a170902e84c00b0016d5b7fb02esm7817622plg.60.2022.09.05.09.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 09:15:04 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM IPROC ARM
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] clk: iproc: Do not rely on node name for correct PLL setup
Date:   Mon,  5 Sep 2022 09:15:03 -0700
Message-Id: <20220905161504.1526-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 31fd9b79dc58 ("ARM: dts: BCM5301X: update CRU block
description") a warning from clk-iproc-pll.c was generated due to a
duplicate PLL name as well as the console stopped working. Upon closer
inspection it became clear that iproc_pll_clk_setup() used the Device
Tree node unit name as an unique identifier as well as a parent name to
parent all clocks under the PLL.

BCM5301X was the first platform on which that got noticed because of the
DT node unit name renaming but the same assumptions hold true for any
user of the iproc_pll_clk_setup() function.

The first 'clock-output-names' property is always guaranteed to be
unique as well as providing the actual desired PLL clock name, so we
utilize that to register the PLL and as a parent name of all children
clock.

Fixes: 5fe225c105fd ("clk: iproc: add initial common clock support")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Rafał Miłecki <rafal@milecki.pl>
---
Changes in v2:

- added Acked-by
- remove empty newline



 drivers/clk/bcm/clk-iproc-pll.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/bcm/clk-iproc-pll.c b/drivers/clk/bcm/clk-iproc-pll.c
index 1a098db12062..680f9d8d357c 100644
--- a/drivers/clk/bcm/clk-iproc-pll.c
+++ b/drivers/clk/bcm/clk-iproc-pll.c
@@ -726,6 +726,7 @@ void iproc_pll_clk_setup(struct device_node *node,
 	const char *parent_name;
 	struct iproc_clk *iclk_array;
 	struct clk_hw_onecell_data *clk_data;
+	const char *clk_name;
 
 	if (WARN_ON(!pll_ctrl) || WARN_ON(!clk_ctrl))
 		return;
@@ -773,7 +774,12 @@ void iproc_pll_clk_setup(struct device_node *node,
 	iclk = &iclk_array[0];
 	iclk->pll = pll;
 
-	init.name = node->name;
+	ret = of_property_read_string_index(node, "clock-output-names",
+					    0, &clk_name);
+	if (WARN_ON(ret))
+		goto err_pll_register;
+
+	init.name = clk_name;
 	init.ops = &iproc_pll_ops;
 	init.flags = 0;
 	parent_name = of_clk_get_parent_name(node, 0);
@@ -793,13 +799,11 @@ void iproc_pll_clk_setup(struct device_node *node,
 		goto err_pll_register;
 
 	clk_data->hws[0] = &iclk->hw;
+	parent_name = clk_name;
 
 	/* now initialize and register all leaf clocks */
 	for (i = 1; i < num_clks; i++) {
-		const char *clk_name;
-
 		memset(&init, 0, sizeof(init));
-		parent_name = node->name;
 
 		ret = of_property_read_string_index(node, "clock-output-names",
 						    i, &clk_name);
-- 
2.25.1

