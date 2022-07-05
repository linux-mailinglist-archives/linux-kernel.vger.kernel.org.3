Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8089F5679C3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 23:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiGEVxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 17:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiGEVwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 17:52:50 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26A319C37
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 14:52:39 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id s1so19375222wra.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 14:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j2Z7TaOJeXWEtVLR0e0XhsP1PHcFQhAlsDhisuCTI68=;
        b=XggLeeA/WTS9mEYdccjis5lFemn3ADc/NC/Rio0Njit6fDYwe4KqULiDHCG1BZE6D7
         xE1+PrCMW9skQC1G33FqTwwPeBVBm/URrT/J92o4sQSWXYea58XJ8ipPVetQcYT5JnKf
         mZMGjP9ep5bFp6GU9hORlbtT4huMBIwRMdf0/KPbAZpcIRuPjVBV3UH8TZOhacY8n4dM
         PAM8XYn2VU8Fb8hzhh1pfmCjiAz+jbVzQe5YMIidd2uNKPz+nr7Nw2qaI4Snuqv4SzxU
         fRbg2ISKK9sV333yjUBDG+pIjyUIkQl6puDYlat0+7RJr6DyNpJs9468VUk0tOPfCyhB
         qhSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j2Z7TaOJeXWEtVLR0e0XhsP1PHcFQhAlsDhisuCTI68=;
        b=nR/736XlPkAe9CQvg+kU33lh0opQXVgrIcosYIwLHjvgwZlO/pzg0XyDFzMZuW+HlY
         YloqbgrugjPurRyOHz0k28sQkvFAh/CvBhl8FhALznFDt3cCh78hJdEZYcilZmdaDkhH
         LXXK3A0ZE8QE5l2QC69e0cibowOg8JwMBw20AaV3pBSBvzU5ZSC0ow3+8Z1fk61lKsu+
         vcgEnEXjvC0y5xIQW4udwYskWgk+80SBiBxmUQ2vGi3cBEulRrK27mEKzrphaG9hB6wK
         +wIYEeDpTcA+IkeGK1oUIlt/jAHnqZcxEuHX1fO0aL9Gio7o+3UET4xSsdyuVO+EMVii
         5naw==
X-Gm-Message-State: AJIora/rsNFVZlTXSqIaUZqzv5IG6kfHMrUN5j7GI6Fc7nSlWGtvaGHC
        HG6jUnhu4IrJ3THBcBEaoOqhXg==
X-Google-Smtp-Source: AGRyM1tF/SegsE28614QkBK2sYVrZTXXYKFS981VORFpPqAQkmqnt12b3RBEdHc9eSvsFhzUnB+QyQ==
X-Received: by 2002:a5d:5292:0:b0:21d:6c3b:a30a with SMTP id c18-20020a5d5292000000b0021d6c3ba30amr10584330wrv.602.1657057959345;
        Tue, 05 Jul 2022 14:52:39 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id g34-20020a05600c4ca200b0039c7dbafa7asm18353920wmp.19.2022.07.05.14.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 14:52:38 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v5 11/13] riscv: dts: canaan: fix bus {ranges,reg} warnings
Date:   Tue,  5 Jul 2022 22:52:12 +0100
Message-Id: <20220705215213.1802496-12-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220705215213.1802496-1-mail@conchuod.ie>
References: <20220705215213.1802496-1-mail@conchuod.ie>
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

The k210 devicetrees warn about missing/empty reg and/or ranges
properties:
arch/riscv/boot/dts/canaan/k210.dtsi:408.22-460.5: Warning (unit_address_vs_reg): /soc/bus@52000000: node has a unit name, but no reg or ranges property
arch/riscv/boot/dts/canaan/k210.dtsi:352.22-406.5: Warning (simple_bus_reg): /soc/bus@50400000: missing or empty reg/ranges property

Add a ranges properties that naively caps the buses after the
allocation of their last devices.

Tested-by: Niklas Cassel <niklas.cassel@wdc.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/canaan/k210.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/boot/dts/canaan/k210.dtsi b/arch/riscv/boot/dts/canaan/k210.dtsi
index 948dc235e39d..a515e5fb1af3 100644
--- a/arch/riscv/boot/dts/canaan/k210.dtsi
+++ b/arch/riscv/boot/dts/canaan/k210.dtsi
@@ -163,7 +163,7 @@ apb0: bus@50200000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "simple-pm-bus";
-			ranges;
+			ranges = <0x50200000 0x50200000 0x200000>;
 			clocks = <&sysclk K210_CLK_APB0>;
 
 			gpio1: gpio@50200000 {
@@ -382,7 +382,7 @@ apb1: bus@50400000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "simple-pm-bus";
-			ranges;
+			ranges = <0x50400000 0x50400000 0x40100>;
 			clocks = <&sysclk K210_CLK_APB1>;
 
 			wdt0: watchdog@50400000 {
@@ -437,7 +437,7 @@ apb2: bus@52000000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "simple-pm-bus";
-			ranges;
+			ranges = <0x52000000 0x52000000 0x2000200>;
 			clocks = <&sysclk K210_CLK_APB2>;
 
 			spi0: spi@52000000 {
-- 
2.37.0

