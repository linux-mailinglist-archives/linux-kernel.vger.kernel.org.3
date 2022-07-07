Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA9556AA86
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236265AbiGGSZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236236AbiGGSZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:25:00 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B162F65B;
        Thu,  7 Jul 2022 11:24:58 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d10so7263699pfd.9;
        Thu, 07 Jul 2022 11:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5cMLmJlHSoTnoQ2xIzWJpEHkZ6TyCa/o1NQh7zaJChE=;
        b=jnOxLHE2q8q5o4UOglWqbsseNhQ1qB+LfzEo71qy2cuhFWf0PTKZFyQLE9Fvq2Ssb7
         gp5fxEztoIcgkQ5kLiyK/Ga6dLM6bv6uEFhFefslL2l79JBrbU3AdAx0Xx8lt3kjceup
         PGo7KMcSSqs5PpbXcvM7rfF21whmLcWMLlbV94yMDieEudRG8khU17Zd8jF2bQp0eL7x
         ayBPxIBJjVhfLPEGsl61PPQJE1U5ERQluEz4OjzIArCb+PV1GwUtgcEzMku+qgMIr9RT
         kIExHvIiP/HLn7gfoZ+r/sFRaL8k6kYXnTsPPEWFnXZ75G/HLS8Ci65p0SFG2vV6h6RM
         ViTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5cMLmJlHSoTnoQ2xIzWJpEHkZ6TyCa/o1NQh7zaJChE=;
        b=XI0FHlVtRpu6tIsbv3TQ9epWkYbE5OiHGQ0di/epiqzZmtj3p91Q/vqehb1jBniVJJ
         6jdrjlerjyg1rnOhfVJtNjpvKXdDy+FnUSdi51/2kfwIp/CLhVsTNePHly8hhYHGt4Hu
         SRgLt0uEI9jBY6cS623wsoWels3uSNTMoEREcIa25D/Bit+G0Rwo+7L0sQHHyJv7jpok
         t1Hic1VjAs19uSCxstwZtQ+yQggoe7rnisF3HI2g3RWMSlbuu/dKU5OKYUWC/tjOjdm2
         7DVeM5WrFIZuFYRSeFWtzoivOH3jO+Lw1HQcl36TvB4Hi01olKMEZaAvUSIFy6oTsG6Z
         6qng==
X-Gm-Message-State: AJIora8fyCt3Vsx7nBmMNU0SlzcW0/JjREcQBf9s20GKyu6oL7TCR7JC
        tcbU2f0mZmUi8WD5FSzfM+I=
X-Google-Smtp-Source: AGRyM1uEI6pX7Y121lDDFGHLGbvelHMJJQsxrHdZk6dH44z0BY9RPRIzrgLlsiidz/FlR6r/oy8Tpg==
X-Received: by 2002:a05:6a00:cce:b0:525:79b5:588c with SMTP id b14-20020a056a000cce00b0052579b5588cmr54588726pfv.19.1657218298499;
        Thu, 07 Jul 2022 11:24:58 -0700 (PDT)
Received: from prasmi.domain.name ([103.219.60.85])
        by smtp.gmail.com with ESMTPSA id o12-20020a170902d4cc00b0016a3f9e4865sm28589279plg.148.2022.07.07.11.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 11:24:57 -0700 (PDT)
From:   prabhakar.csengg@gmail.com
X-Google-Original-From: prabhakar.mahadev-lad.rj@bp.renesas.com
To:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-gpio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v8 4/6] gpio: gpiolib: Allow free() callback to be overridden
Date:   Thu,  7 Jul 2022 19:23:12 +0100
Message-Id: <20220707182314.66610-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707182314.66610-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220707182314.66610-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Allow free() callback to be overridden from irq_domain_ops for
hierarchical chips.

This allows drivers to free up resources which are allocated during
child_to_parent_hwirq()/populate_parent_alloc_arg() callbacks.

On Renesas RZ/G2L platform a bitmap is maintained for TINT slots, a slot
is allocated in child_to_parent_hwirq() callback which is freed up in free
callback hence this override.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpio/gpiolib.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index bfde94243752..68d9f95d7799 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1181,15 +1181,18 @@ static void gpiochip_hierarchy_setup_domain_ops(struct irq_domain_ops *ops)
 	ops->activate = gpiochip_irq_domain_activate;
 	ops->deactivate = gpiochip_irq_domain_deactivate;
 	ops->alloc = gpiochip_hierarchy_irq_domain_alloc;
-	ops->free = irq_domain_free_irqs_common;
 
 	/*
-	 * We only allow overriding the translate() function for
+	 * We only allow overriding the translate() and free() functions for
 	 * hierarchical chips, and this should only be done if the user
-	 * really need something other than 1:1 translation.
+	 * really need something other than 1:1 translation for translate()
+	 * callback and free if user wants to free up any resources which
+	 * were allocated during callbacks, for example populate_parent_alloc_arg.
 	 */
 	if (!ops->translate)
 		ops->translate = gpiochip_hierarchy_irq_domain_translate;
+	if (!ops->free)
+		ops->free = irq_domain_free_irqs_common;
 }
 
 static int gpiochip_hierarchy_add_domain(struct gpio_chip *gc)
-- 
2.25.1

