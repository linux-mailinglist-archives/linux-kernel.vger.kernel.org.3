Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D2156099D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 20:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbiF2Sp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 14:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiF2SpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 14:45:07 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D9433EB6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 11:45:00 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id r81-20020a1c4454000000b003a0297a61ddso182467wma.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 11:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qoN7yg76UgsEFXHXaQt2AveJ+WlGKI9wi9pTAfeqlpQ=;
        b=e4CuTg/9p48DvSTUNdv17K46g3T0j+a8aeAGEEKwZCfJKs9OjS34vhGZ7HFoE764Hd
         j8xFaBJnEvmew0GGSReaaY9xNCu/fR2Sc34atEiERkguYgduxUnuc58gW9QTCtElfHoh
         +e4aG+8roo0EfND8Dp2rzL5lveRBxroMVkaiGySBPM8Qh9bYqkiTIqpFq/W5RA0SiiOj
         PkZRxnuQRLUqrKTYridgjCyNZyMdVCaIDrvKh8cbK07c3fQ7hSJhIcZF+zo6hofXTYZU
         rLSvEmCJJCmqf5LBxTtJA5BYCL/pC3D+iLf1VIJRxuvt++JTQuIt9u9ZtTRVQGNCwcNI
         LZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qoN7yg76UgsEFXHXaQt2AveJ+WlGKI9wi9pTAfeqlpQ=;
        b=fjSbTq/ABlhxZNsRJWm++RsrWZrXJUDtd42VFWkPOAulTZtDZAVXUoxo28eOYlk/UM
         W2dgFVyKv+7TQ/5msJKkzCv7wPBm8lPIwPzWb+4RyiRXRq2TUNWc51lBzYJ/QBHAjx9G
         edrUjc61C4cRG3BG2criBwJF/Z1OUJjvbeukEGL+h5DI8xgM2J7XFKFLiYm0cYlfikIG
         LQ9Jj64W3ewYX3zu0OzD01foe6tE2njGefV4SR4oyl9KDxCRyZM0rZ+viPd4FEXht9xi
         3XhXEBJq7dBMmoh89XfNedYxTy/qTw/b/5mzWkoX2NA3hZ/HTB8xwCEn9yWozjBSXMk5
         Czkg==
X-Gm-Message-State: AJIora82GE6yNlHU/7B5/q2yQPxtUA8Q24ChmcZdIJSeS7lVZAU7rIjK
        eOYddjo4NEJ+Z67A2aybi/m8cA==
X-Google-Smtp-Source: AGRyM1sAH2pQyXCWdny+eGMynhGGuuyXhbj2gCp3uhWDHvXjt8YqOA4VdUet5wJ8GqcAeQgDcQfsCA==
X-Received: by 2002:a7b:c1ca:0:b0:3a0:3b9e:fd96 with SMTP id a10-20020a7bc1ca000000b003a03b9efd96mr5210627wmj.86.1656528299365;
        Wed, 29 Jun 2022 11:44:59 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id u23-20020a7bcb17000000b0039aef592ca0sm3834371wmj.35.2022.06.29.11.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 11:44:58 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v3 14/15] riscv: dts: canaan: add specific compatible for kd233's LCD
Date:   Wed, 29 Jun 2022 19:43:43 +0100
Message-Id: <20220629184343.3438856-15-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220629184343.3438856-1-mail@conchuod.ie>
References: <20220629184343.3438856-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Add the recently introduced compatible for the LCD on the Canaan KD233.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/canaan/canaan_kd233.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/canaan/canaan_kd233.dts b/arch/riscv/boot/dts/canaan/canaan_kd233.dts
index 4a540158f287..b0cd0105a5bd 100644
--- a/arch/riscv/boot/dts/canaan/canaan_kd233.dts
+++ b/arch/riscv/boot/dts/canaan/canaan_kd233.dts
@@ -127,7 +127,7 @@ &spi0 {
 	cs-gpios = <&gpio0 20 GPIO_ACTIVE_HIGH>;
 
 	panel@0 {
-		compatible = "ilitek,ili9341";
+		compatible = "canaan,kd233-tft", "ilitek,ili9341";
 		reg = <0>;
 		dc-gpios = <&gpio0 21 GPIO_ACTIVE_HIGH>;
 		spi-max-frequency = <10000000>;
-- 
2.36.1

