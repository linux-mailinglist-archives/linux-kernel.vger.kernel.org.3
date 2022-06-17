Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2ED54F769
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 14:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381826AbiFQMWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 08:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245358AbiFQMWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 08:22:15 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9164F9E9;
        Fri, 17 Jun 2022 05:22:14 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id y19so8445398ejq.6;
        Fri, 17 Jun 2022 05:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RydpU3/Y4IwrqethePzwVBMR4EHpFdhl0iBO2HaWGOo=;
        b=RlcBBBRIzlH6kQoXVTZt5AiXbi9BDK/e/F0d36mdhebJwwjZAUpnRYzfg2d+ZNXBHC
         oNFKCMtx04SJZS5T8XsSoEL3Zn4+KTfFsuUCcR3N2Qjr2GaGbFfrfLEM1pr1YMdNWUyQ
         CnGoeZsMjqupvjIl75gM3qMvkeBbJOCTWEHjOra4noAF9uIP9QSGOtz6/lcUSBjL9nji
         5mP0bnAAWQj801+DnkFij89kDkRW3ZzmT1QfiZ2pC6jU9jHRirEh7Y+k2k0qb7BaImJf
         LhO0KMIJUDY6WC0TFn7cK7sLD7NgtLVL+QqOfyzkLsvI8BpUyST9neG+JcLxnfA264TI
         CX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RydpU3/Y4IwrqethePzwVBMR4EHpFdhl0iBO2HaWGOo=;
        b=jFPoXvxey0nyaAEnxLaVVGNM2I00yhFAQnBsHoZnv8yXcHmdPKB4J0R9nUcfVmyo9f
         RslHQurATZiqYQyHCVHEoyLraE0tipaBZ0xlllEHL7ss2+cYRHnpgguEl8oaUcipSJmC
         nMtxkZMn0BET+HStylHo8YSDuM2GJQVI5wBzZ7UnOQnWPR9Rn0A4yElZj5Wuhjofp8VH
         t7EDuKTHxjEtYl50JjytkdeJBQVi4sM9+g5bJZcF5UFXhuUJ+Vm2HFypld7NgQUn4OV1
         gNKNxW54FM6gm3Yow6yNNFQR55MEc0lcEIJqUzWIgdOEXBVAfWeeKvKz+U0HOFLtGOyz
         1ghw==
X-Gm-Message-State: AJIora/YPLV/XyLHZFK5D5YuFyp3u4tMQOYxbp4HGU2MjNoXNhuYLqvE
        kBNuMzeZJzM/+DF6TGVUrMs=
X-Google-Smtp-Source: AGRyM1tn/JU0YI5iK2BvBsGqmsGR8kMLwx+2/o/xkiZVgQArHzh3tWIGKimuBdMAKwTOh9EGrrbxnA==
X-Received: by 2002:a17:907:97c4:b0:711:ea9a:103b with SMTP id js4-20020a17090797c400b00711ea9a103bmr9512333ejc.155.1655468532770;
        Fri, 17 Jun 2022 05:22:12 -0700 (PDT)
Received: from localhost (92.40.168.188.threembb.co.uk. [92.40.168.188])
        by smtp.gmail.com with ESMTPSA id fm18-20020a1709072ad200b006f3ef214e63sm2059914ejc.201.2022.06.17.05.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 05:22:12 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     sboyd@kernel.org, mturquette@baylibre.com
Cc:     paul@crapouillou.net, paulburton@kernel.org,
        linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] clk: ingenic-tcu: Properly enable registers before accessing timers
Date:   Fri, 17 Jun 2022 13:22:54 +0100
Message-Id: <20220617122254.738900-1-aidanmacdonald.0x0@gmail.com>
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
This appears to be the norm on Ingenic SoCs, and is specified in the
documentation for the X1000 and numerous JZ47xx SoCs.

If the stop bit isn't cleared, register writes don't take effect and
the system can be left in a broken state, eg. the watchdog timer may
not run.

The bug probably went unnoticed because stop bits are zeroed when
the SoC is reset, and the kernel does not set them unless a timer
gets disabled at runtime. However, it is possible that a bootloader
or a previous kernel (if using kexec) leaves the stop bits set and
we should not rely on them being cleared.

Fixing this is easy: have ingenic_tcu_{enable,disable}_regs() always
clear the stop bit, regardless of the presence of a global TCU gate.

Reviewed-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Paul Cercueil <paul@crapouillou.net>
Fixes: 4f89e4b8f121 ("clk: ingenic: Add driver for the TCU clocks")
Cc: stable@vger.kernel.org
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
v2: Update commit description

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

