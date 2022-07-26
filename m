Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F1F580F11
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 10:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238209AbiGZIdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 04:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238039AbiGZIdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 04:33:16 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB5D2DA9A;
        Tue, 26 Jul 2022 01:33:15 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id D1509DFD7B;
        Tue, 26 Jul 2022 01:33:15 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id D02DUHP9NRY1; Tue, 26 Jul 2022 01:33:15 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1658824395; bh=85peDTtgZNpuR8CVV06JKnQ8YE3l4H7dqTVa9ek/70Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HrmlhUiMonVdYsnG7cM3pJjmGaTVJKMWpHvXVq284dVRtG6f7miqVxj7W6Di6qafn
         GoM3aaRiICss6PwgT47zP/TufgMDOK9eH7JkuBtnXdxnAziUTaofB9K809ano2+Gw9
         aH9YzgPajfytUXtngcX/703EJKRUpAoU75RIU6QyEScqfb4WASq0oPCoQpdS1L3zdm
         ryixrHkmwqdnMjht7RD1Ib4mWjY5Y69Y10/XqWO6WYaq3s6izKQl5l1rr9sYHsc0k1
         xjhetCBmHhfLuePtYn7uyi7gGcdtet1CnuVQ+Ucm3JV7YaAZa7+mKaO1T9Y9FJHxp3
         U6cCE1GHNDH4w==
To:     rafael@kernel.org, khilman@kernel.org, ulf.hansson@linaro.org,
        robh@kernel.org, krzysztof.kozlowski@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        pavel@ucw.cz
Cc:     kernel@puri.sm, linux-imx@nxp.com, broonie@kernel.org,
        l.stach@pengutronix.de, aford173@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v6 2/2] soc: imx: gpcv2: fix suspend/resume by setting GENPD_FLAG_IRQ_ON
Date:   Tue, 26 Jul 2022 10:32:57 +0200
Message-Id: <20220726083257.1730630-3-martin.kepplinger@puri.sm>
In-Reply-To: <20220726083257.1730630-1-martin.kepplinger@puri.sm>
References: <20220726083257.1730630-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For boards that use power-domains' power-supplies that need interrupts
to work (like regulator over i2c), set GENPD_FLAG_IRQ_ON.
This will tell genpd to adjust accordingly. Currently it "only" sets the
correct suspend/resume callbacks.

This fixes suspend/resume on imx8mq-librem5 boards (tested) and
imx8mq-evk (by looking at dts) and possibly more.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 drivers/soc/imx/gpcv2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 6383a4edc360..199a621d8186 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -1337,6 +1337,9 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
 		regmap_update_bits(domain->regmap, domain->regs->map,
 				   domain->bits.map, domain->bits.map);
 
+	if (of_property_read_bool(domain->dev->of_node, "power-supply"))
+		domain->genpd.flags |= GENPD_FLAG_IRQ_ON;
+
 	ret = pm_genpd_init(&domain->genpd, NULL, true);
 	if (ret) {
 		dev_err(domain->dev, "Failed to init power domain\n");
-- 
2.30.2

