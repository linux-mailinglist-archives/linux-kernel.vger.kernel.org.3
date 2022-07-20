Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A46857B00C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 06:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237791AbiGTEgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 00:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238057AbiGTEgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 00:36:20 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A330C2CDD0;
        Tue, 19 Jul 2022 21:36:19 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 69A90DFF7B;
        Tue, 19 Jul 2022 21:35:49 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Oeqpp57CYaXJ; Tue, 19 Jul 2022 21:35:48 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1658291748; bh=cKfjsoRcWsaq1BiSf8wfxCOkxO8OBT+dw6FA+RdONSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MhOpSk469URVTq/qzhbzDBrb1obyApeVgx6oareYHG0KOfLR/sGNlqPir80WQa0S3
         vZ/LVBE9diDaIKhJiqlnNAs1Fs/2AfNy6Ro5KlJP57ctMne3k37jVD9nimn1uH0zHi
         4KcnjG11tpk2DFz12Lk8DUUD9mbudTH/HRa+L+Taf+90vU2nD+OrcXNaf8AOOh8M3D
         1WRqNaB28DwQCK/DJECQuil8L5nOd4MogK62x/IZUhvRuXKQy3aRUX7TzPec7SSBS1
         UkPbmCAg3DvA5V6DN7vF80kT/RM0bY/VPEczuyOU3qfa3EUj54c9OwlgyFuH1j1Rts
         Xs9gA7P+ynP0Q==
To:     rafael@kernel.org, khilman@kernel.org, ulf.hansson@linaro.org,
        robh@kernel.org, krzysztof.kozlowski@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        pavel@ucw.cz
Cc:     kernel@puri.sm, linux-imx@nxp.com, broonie@kernel.org,
        l.stach@pengutronix.de, aford173@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v4 3/3] soc: imx: gpcv2: fix suspend/resume by setting GENPD_FLAG_IRQ_ON
Date:   Wed, 20 Jul 2022 06:34:44 +0200
Message-Id: <20220720043444.1289952-4-martin.kepplinger@puri.sm>
In-Reply-To: <20220720043444.1289952-1-martin.kepplinger@puri.sm>
References: <20220720043444.1289952-1-martin.kepplinger@puri.sm>
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
 drivers/soc/imx/gpcv2.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 85aa86e1338a..46d2ead2352b 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -1303,6 +1303,7 @@ static const struct imx_pgc_domain_data imx8mn_pgc_domain_data = {
 static int imx_pgc_domain_probe(struct platform_device *pdev)
 {
 	struct imx_pgc_domain *domain = pdev->dev.platform_data;
+	struct device_node *dn;
 	int ret;
 
 	domain->dev = &pdev->dev;
@@ -1333,6 +1334,14 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
 		regmap_update_bits(domain->regmap, domain->regs->map,
 				   domain->bits.map, domain->bits.map);
 
+	dn = of_parse_phandle(domain->dev->of_node, "power-supply", 0);
+	if (dn) {
+		while ((dn = of_get_next_parent(dn))) {
+			if (of_get_property(dn, "interrupts", NULL))
+				domain->genpd.flags |= GENPD_FLAG_IRQ_ON;
+		}
+	}
+
 	ret = pm_genpd_init(&domain->genpd, NULL, true);
 	if (ret) {
 		dev_err(domain->dev, "Failed to init power domain\n");
-- 
2.30.2

