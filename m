Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D6D564999
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 21:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbiGCTlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 15:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbiGCTlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 15:41:49 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3BF6157;
        Sun,  3 Jul 2022 12:41:47 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id z1so1057044plb.1;
        Sun, 03 Jul 2022 12:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XI0bxFBrEKRBuDqtanZl8S03OsomJgySRxxoYC8Ucrc=;
        b=BMRuLECs2RX8B6S5+IZV8fP93sQaUeK4uPrhUKicuUsLE9HU0FKZbfklpf6VirX9lg
         9DCIhzlSiWlXIR09aOkB1etop/nGQ2JVntWXMNI6BYXbDZ9HxM4BTi6NqLFEqYAPCqxc
         evfCU8JZ4TeOuxzq1Z8Z3SK7FDZ7C4LW3FPjfkTGGG2FXFfkgnj3jWLQ46QgxSdYFnr8
         56zMstllAfIfejEk13ksSdnSKnnNCtlgQ+3sVsrRCtoQunL1VR3PAUGJH7oBTWYlod3l
         CoGaIWQYtZasb9muld9wqIkOQvxQGl7pbEng/KsLHt6eVjmrmYTTgw5+boH+lgqR/IQo
         O5kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XI0bxFBrEKRBuDqtanZl8S03OsomJgySRxxoYC8Ucrc=;
        b=CgPR+DwRAussj78jccWiQo8LClR04YQ5dwGcxAZdJlx3wWE3iKw0cQupaobeMdjKur
         0XJABIlvylFG1ArpXItZwnBJGoj0r7bq9F29blsX/TDF6s4MY08L/0cbSrBAF4gMnOLr
         j5pmpCe8xH2t4sVF5CnkxqNVoc2bhSC3X2ToBH/dDCJLcXXg/f2sb/+95TgxUa16akmT
         lgGlibMnoY5gLrhBwAZs3Y/3iXgXtV1TEghaJfNgsTENufk0wn2YteuB4ouiOxjYGFC9
         zWN3OmYS8C9j0qlE6VFMnU4U8ffct7lr266nCiJB386gtP2w2JLFsVK5SewqI1Z6jhyT
         DPSg==
X-Gm-Message-State: AJIora+0TjeAkyXfWPLVUuIbSGUEEMahhFgBcbM4Fe8PczoR8aB3Fa+N
        ndIIYjuedEAtLMwPb/W1yOs=
X-Google-Smtp-Source: AGRyM1tcLiw1b5SdWvCYRgaGNtv6D8+BAF8MpHbHdXcwoN9JYPJuqM+yVkIbHGghRgjIqW9rBqW3XA==
X-Received: by 2002:a17:90a:9401:b0:1ee:e31f:7523 with SMTP id r1-20020a17090a940100b001eee31f7523mr29827184pjo.175.1656877307226;
        Sun, 03 Jul 2022 12:41:47 -0700 (PDT)
Received: from prasmi.domain.name ([103.219.60.86])
        by smtp.gmail.com with ESMTPSA id y19-20020a17090aca9300b001e0c5da6a51sm10656104pjt.50.2022.07.03.12.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 12:41:46 -0700 (PDT)
From:   Lad Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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
Subject: [PATCH v7 3/5] gpio: gpiolib: Allow free() callback to be overridden
Date:   Sun,  3 Jul 2022 20:40:18 +0100
Message-Id: <20220703194020.78701-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220703194020.78701-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220703194020.78701-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

