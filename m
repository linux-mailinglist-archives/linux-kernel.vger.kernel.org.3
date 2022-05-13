Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4955852606E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379650AbiEMK7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 06:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbiEMK7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 06:59:03 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB072A1883;
        Fri, 13 May 2022 03:59:02 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 9EC8510000D;
        Fri, 13 May 2022 10:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652439540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=phRAVilaCphqNifvq+II7qoJeSQm2Yxjtyairx0TGxE=;
        b=BWoReh7KEljZ6rp733n7DaxE6O3w/PkXy52Umpq4rC+LntdeIKWrdw4hyZjf1aval39utR
        Z12bsAvU8GqaTCkQy/bs41Z3BHiDdk36Yg2aMrpKwFcODuSgPaw+JjPe0aEoOHf+vsZkWr
        iBUqm+WDgKyWkweDTRCzrndjx/sjmZdS3F39fl+xNQm8c9rJbNRd+Nv6fnyoawZQtDurFr
        n+HxqiFHbPC9VLF8ClXjBv76ZOG11LtGH7jpXUXWpwKSiD5VG3BGWdH0I2dEHL3DsPIvkg
        8BtAP5HdSHPV7dj7ZVUE1H1jJeciC2EOVEvz3Of1cWhPCtGWwsYVKBzGKo6Jmw==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH 1/3] clk: lan966x: Fix the lan966x clock gate register address
Date:   Fri, 13 May 2022 12:58:48 +0200
Message-Id: <20220513105850.310375-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220513105850.310375-1-herve.codina@bootlin.com>
References: <20220513105850.310375-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The register address used for the clock gate register is the base
register address coming from first reg map (ie. the generic
clock registers) instead of the second reg map defining the clock
gate register.

Use the correct clock gate register address.

Fixes: 5ad5915dea00 ("clk: lan966x: Extend lan966x clock driver for clock gating support")
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/clk/clk-lan966x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-lan966x.c b/drivers/clk/clk-lan966x.c
index d1535ac13e89..81cb90955d68 100644
--- a/drivers/clk/clk-lan966x.c
+++ b/drivers/clk/clk-lan966x.c
@@ -213,7 +213,7 @@ static int lan966x_gate_clk_register(struct device *dev,
 
 		hw_data->hws[i] =
 			devm_clk_hw_register_gate(dev, clk_gate_desc[idx].name,
-						  "lan966x", 0, base,
+						  "lan966x", 0, gate_base,
 						  clk_gate_desc[idx].bit_idx,
 						  0, &clk_gate_lock);
 
-- 
2.35.1

