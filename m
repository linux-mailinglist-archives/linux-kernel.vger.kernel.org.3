Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734435885EE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 04:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235305AbiHCC7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 22:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiHCC65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 22:58:57 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000CA22515;
        Tue,  2 Aug 2022 19:58:54 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id s206so13976701pgs.3;
        Tue, 02 Aug 2022 19:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=NkV3OzYi4AyJ1Ks2Na+Cpx7tYi6xJjC1EGQ4Lxx986g=;
        b=iPoOBpqGez2XdRMxsM0RUtmTarTEndBr1O0ftlGpWhKVXL0DASQM9iAVJXRH7eaOLa
         qzHyjAgAgESZq+xSqh2fM2c6dwTt4QEfx5lBFDo3Y6Xbf4WAeSw9E7j7h/f8sEK5BBqF
         4Kf3S+5vEIYFp9E2wyCfIIyxWQbtLMRvVC3pAPlRjNev1xiSbTAUtxB7g/ebNrM67Z7Z
         J/iKcV7o5FPY662mVDyb6jWvyFRkHzYDjyMSY1iG8qe+CwYHz5bW6D6OPbJK662AmYnt
         AIU5cMJA+i/z7OLfB9GwpTZSr6AycPtG2E7jX+ilbpeXvvrjcXtQwk4W2LmC6J09KChh
         Wz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=NkV3OzYi4AyJ1Ks2Na+Cpx7tYi6xJjC1EGQ4Lxx986g=;
        b=p3pVmWUTgmUVyx7rJApooeIEVWryj2cAKUVzSmaVjBNV6c7G9XivvJA0MZHZBiaVdK
         twLrL4q6sFc5CKfZOoQqx5dLDWkxJifVij+QNcViQI3xzewx/BaHtDyi+HzCTmYEeLvf
         DPg18wl0m/o44Xt4qLZeIL1gdzkXtPhv16AEkSQk4vkOuEk9zn13Sph/Rh/GPG3AL2TR
         13Ko2dVVmdks99qr2C8B11ay2KnfqPt/zUvDiiiDHz8ztfQHiOYLPyWcBvBepbRhS+0N
         03M7nXnDKEV+xa7B/1Oll3uuuezrm55r2o5rAOZOwdoEx5iNq0vZIuZdUah5W72shBAC
         Te6w==
X-Gm-Message-State: AJIora+lE0pgNPykMr2p4bNNjBSUfB5h4cu7QkvjRYthI9Niwwn+vo3A
        pcQbEuarEb6PUt6KT0y9erb34MeDzsw=
X-Google-Smtp-Source: AA6agR573v0yHmoXGweA78VvVsbkfA9igmH4jeVqrosgwZyN3y4JAUA+PjzFaYSBRhugAnR3fJOYwg==
X-Received: by 2002:a05:6a00:a93:b0:528:77d6:f660 with SMTP id b19-20020a056a000a9300b0052877d6f660mr24005567pfl.50.1659495534060;
        Tue, 02 Aug 2022 19:58:54 -0700 (PDT)
Received: from localhost.localdomain (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id a13-20020aa78e8d000000b0052d90521d02sm4803725pfr.126.2022.08.02.19.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 19:58:53 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     rafal@milecki.pl, Florian Fainelli <f.fainelli@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM IPROC ARM
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] clk: iproc: Do not rely on node name for correct PLL setup
Date:   Tue,  2 Aug 2022 19:58:34 -0700
Message-Id: <20220803025836.107886-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
---
Rafal,

This is a replacement for this patch that you checked into OpenWrt:

https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=target/linux/bcm53xx/patches-5.15/320-ARM-dts-BCM5301X-Switch-back-to-old-clock-nodes-name.patch;h=cee37732ab9e2ac8bc2a399a53d01b9ead756cb8;hb=HEAD


 drivers/clk/bcm/clk-iproc-pll.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/bcm/clk-iproc-pll.c b/drivers/clk/bcm/clk-iproc-pll.c
index 33da30f99c79..92be88eb1d11 100644
--- a/drivers/clk/bcm/clk-iproc-pll.c
+++ b/drivers/clk/bcm/clk-iproc-pll.c
@@ -736,6 +736,7 @@ void iproc_pll_clk_setup(struct device_node *node,
 	const char *parent_name;
 	struct iproc_clk *iclk_array;
 	struct clk_hw_onecell_data *clk_data;
+	const char *clk_name;
 
 	if (WARN_ON(!pll_ctrl) || WARN_ON(!clk_ctrl))
 		return;
@@ -783,7 +784,12 @@ void iproc_pll_clk_setup(struct device_node *node,
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
@@ -803,13 +809,12 @@ void iproc_pll_clk_setup(struct device_node *node,
 		goto err_pll_register;
 
 	clk_data->hws[0] = &iclk->hw;
+	parent_name = clk_name;
 
 	/* now initialize and register all leaf clocks */
 	for (i = 1; i < num_clks; i++) {
-		const char *clk_name;
 
 		memset(&init, 0, sizeof(init));
-		parent_name = node->name;
 
 		ret = of_property_read_string_index(node, "clock-output-names",
 						    i, &clk_name);
-- 
2.25.1

