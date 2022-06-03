Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDFC453CAD9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 15:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244781AbiFCNqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 09:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236623AbiFCNqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 09:46:32 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235FDF6E;
        Fri,  3 Jun 2022 06:46:31 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q15so2433647wrc.11;
        Fri, 03 Jun 2022 06:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=90pEoDN9oy+4O7tdS4pW3PQdGgDfNW6XB8YNiEK6tMw=;
        b=VuqrsEXLyCASAJP79//3p/DSqIrbW2a2pkUzmcyyW7o643KTpYM9vyfzS17iWDvUdl
         T7IX/Ppr7kAxXyEVC4L5q4EPn6QSbNu0uFxwiQfFWmuNa7mj3ZAOSUtGyNxF1/2Ev9Hd
         ijWPfewUzfWG+We0E6oh5BsQO8bn9dJuooLCNnzUdjs3nPSVqWUmocbG25IzlPnooxGM
         xlNQ5NFocwfmqswYfPbiWDeWuOTtjOgpVvJ02gc8vYDygNylRGBP3b/VOe7Tcylorowi
         qHEGeIAvwzczF5QbhHcOwsS8LzwpB+q7up61NYb17yLeeTunisL2bvh7fMQO1QT7horM
         6bWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=90pEoDN9oy+4O7tdS4pW3PQdGgDfNW6XB8YNiEK6tMw=;
        b=nFkHSAePeIs6TCheR4cog7b1EtSl9OU9q+S8hC4VN6CA3gyv17X7a3oXIP0yqqVtmx
         rBVSCa18ltqhocFgIbLke5WbcY8FPqfTj7tuPyfpyKDVzKHU5VJzvtufELMztG2jgT2o
         QAcRIQ68R/j7L6yg6/9YrINcEETtEHVv9w4OK7D0MpLegUCTdxBnmLhpq0gAaQ57cI03
         GTyu+LO51rUA4hcto3kV1LQbmnKdtKGqecDOvqpNk7TXpzJEgdezlF8VmMWXdG+hNjBg
         5qgokHi8vrOnCJwvq8uJlFaRIoeKfBKNrpVLw+/QDhiwbx5sNSOuPmHow/M2XtkPaZW3
         WP8g==
X-Gm-Message-State: AOAM530gkM2hy0bOyjWB6YaoFh30WVAXuYNlysUfX7APEWKfqNnGvSmC
        y85nncsCBeqP6YvcahybL7M=
X-Google-Smtp-Source: ABdhPJxWFmAyWeVpbhFYWpT5Pmljv2+cgZgPMAqDQ/Bi4FDGILAuOzYdJiYcnXpj0Lx2Q4HDj18EUw==
X-Received: by 2002:adf:f842:0:b0:213:5c4b:981d with SMTP id d2-20020adff842000000b002135c4b981dmr6634761wrq.694.1654263989667;
        Fri, 03 Jun 2022 06:46:29 -0700 (PDT)
Received: from localhost (92.40.203.126.threembb.co.uk. [92.40.203.126])
        by smtp.gmail.com with ESMTPSA id o22-20020a1c7516000000b003942a244ed1sm8280345wmc.22.2022.06.03.06.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 06:46:28 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: ingenic-tcu: Properly enable registers before accessing timers
Date:   Fri,  3 Jun 2022 14:47:05 +0100
Message-Id: <20220603134705.11156-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Access to registers is guarded by ingenic_tcu_{enable,disable}_regs()
so the stop bit can be cleared before accessing a timer channel, but
those functions did not clear the stop bit on SoCs with a global TCU
clock gate.

Testing on the X1000 has revealed that the stop bits must be cleared
_and_ the global TCU clock must be ungated to access timer registers.
Programming manuals for the X1000, JZ4740, and JZ4725B specify this
behavior. If the stop bit isn't cleared, then writes to registers do
not take effect, which can leave clocks with no defined parent when
registered and leave clock tree state out of sync with the hardware,
triggering bugs in downstream drivers relying on TCU clocks.

Fixing this is easy: have ingenic_tcu_{enable,disable}_regs() always
clear the stop bit, regardless of the presence of a global TCU gate.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/clk/ingenic/tcu.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/ingenic/tcu.c b/drivers/clk/ingenic/tcu.c
index 201bf6e6b6e0..d5544cbc5c48 100644
--- a/drivers/clk/ingenic/tcu.c
+++ b/drivers/clk/ingenic/tcu.c
@@ -101,15 +101,11 @@ static bool ingenic_tcu_enable_regs(struct clk_hw *hw)
 	bool enabled = false;
 
 	/*
-	 * If the SoC has no global TCU clock, we must ungate the channel's
-	 * clock to be able to access its registers.
-	 * If we have a TCU clock, it will be enabled automatically as it has
-	 * been attached to the regmap.
+	 * According to the programming manual, a timer channel's registers can
+	 * only be accessed when the channel's stop bit is clear.
 	 */
-	if (!tcu->clk) {
-		enabled = !!ingenic_tcu_is_enabled(hw);
-		regmap_write(tcu->map, TCU_REG_TSCR, BIT(info->gate_bit));
-	}
+	enabled = !!ingenic_tcu_is_enabled(hw);
+	regmap_write(tcu->map, TCU_REG_TSCR, BIT(info->gate_bit));
 
 	return enabled;
 }
@@ -120,8 +116,7 @@ static void ingenic_tcu_disable_regs(struct clk_hw *hw)
 	const struct ingenic_tcu_clk_info *info = tcu_clk->info;
 	struct ingenic_tcu *tcu = tcu_clk->tcu;
 
-	if (!tcu->clk)
-		regmap_write(tcu->map, TCU_REG_TSSR, BIT(info->gate_bit));
+	regmap_write(tcu->map, TCU_REG_TSSR, BIT(info->gate_bit));
 }
 
 static u8 ingenic_tcu_get_parent(struct clk_hw *hw)
-- 
2.35.1

