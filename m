Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE355200D9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238075AbiEIPSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238078AbiEIPSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:18:15 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F95F1FA64;
        Mon,  9 May 2022 08:14:21 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id gj17-20020a17090b109100b001d8b390f77bso17280492pjb.1;
        Mon, 09 May 2022 08:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VxaY2CaQXKasRpf6kPykVpFMOeU3YbfMP1tGgUzsF6E=;
        b=dc80k80GoGz8fuwhEp3O1QAx9Zq2f/CuNW34zaKkZrLIPXL4X4QND5i2Qo9NCLMfM2
         40tziY1NupspO9nEz4wUkK3++sblZJvCU1uIT4VCnCr2QAa+3D/j3LRo1HfxvrqZz5Ev
         xgBXCP9VphhB0p0PbLsuV/B3GiBp8tEp0EYwsafJhpibJqEiqdbtR1/T3lqVyKKCQuWc
         +aWlWtZH+51B7M+PYuUDexZgsuuocMsMxRxwsHjNsNskWHfZHq3Uv034klQLK1vnfuL+
         YgGOrCSDAfGYNL/9gjWsbE9S2kXFFdnPHYdeq0gwHJ9yQp3Owj5ka8bnetcnHuJQiLYq
         u3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VxaY2CaQXKasRpf6kPykVpFMOeU3YbfMP1tGgUzsF6E=;
        b=oNGf8obpX7is0vkgS6wszQ1SIn+2kQYX1+nVW+dMrXsv5SfJnsGg9RRdS6RWfCiGeO
         0bjD0h3GoxdFyCOWEe7dmzBG+XWkWQwYrmhUhMiRJXZBXErcr7KzNA1oR96Qv/aSI/CV
         I4MF2oQ5a2lK5XquAhkOI/TAx+Sc9XIJlFenBRVahZ9JH6hcfw08JGuDClEB+WnycNt7
         PVsMUrGuK4QjjCFDYeVUHBtaPmDxVejIKdwD3C5q3b6i7+YXgilrltwHZlMnXp6hBqmY
         srTxjsWQx5uq6H33DGv9VQWBvre3H/zFGfiBHewbz8erfB9xfEvfsvTtd4Wb6ce+z3Dp
         xWnA==
X-Gm-Message-State: AOAM530kqT4ubbXQLEIjIGqoymfEwMjKunSA7gHI+PfXGfe96oNrIBnh
        DsuhcaFpaPKaWT+O6F3cEzJpCAwmA4mC17gU
X-Google-Smtp-Source: ABdhPJx3o2uKlMst0NqqHq284RCuXaHgmGCaNzGIi5fze4asH3VUuWmUNgs5ZmRTwQHfG/LiSJ2UuA==
X-Received: by 2002:a17:902:d717:b0:15e:b6ed:4824 with SMTP id w23-20020a170902d71700b0015eb6ed4824mr16531436ply.110.1652109260904;
        Mon, 09 May 2022 08:14:20 -0700 (PDT)
Received: from potin-quanta.dhcpserver.local (125-228-123-29.hinet-ip.hinet.net. [125.228.123.29])
        by smtp.gmail.com with ESMTPSA id k7-20020a056a00134700b0050dc76281b6sm9221596pfu.144.2022.05.09.08.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 08:14:20 -0700 (PDT)
From:   Potin Lai <potin.lai.pt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH 2/6] ARM: dts: aspeed: bletchley: switch spi2 driver to aspeed-smc
Date:   Mon,  9 May 2022 23:11:14 +0800
Message-Id: <20220509151118.4899-3-potin.lai.pt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220509151118.4899-1-potin.lai.pt@gmail.com>
References: <20220509151118.4899-1-potin.lai.pt@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to DVT schematic has stable spi signal, switch back to aspeed-smc
driver for improving performance.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 .../dts/aspeed-bmc-facebook-bletchley.dts     | 33 ++++++++-----------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index b7439df65423..eefb624d4850 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -51,26 +51,6 @@
 		};
 	};
 
-	spi2_gpio: spi2-gpio {
-		compatible = "spi-gpio";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		gpio-sck = <&gpio0 ASPEED_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
-		gpio-mosi = <&gpio0 ASPEED_GPIO(X, 4) GPIO_ACTIVE_HIGH>;
-		gpio-miso = <&gpio0 ASPEED_GPIO(X, 5) GPIO_ACTIVE_HIGH>;
-		num-chipselects = <1>;
-		cs-gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>;
-
-		flash@0 {
-			reg = <0>;
-			compatible = "jedec,spi-nor";
-			m25p,fast-read;
-			label = "pnor";
-			spi-max-frequency = <100000000>;
-		};
-	};
-
 	switchphy: ethernet-phy@0 {
 		// Fixed link
 	};
@@ -242,6 +222,19 @@
 	};
 };
 
+&spi2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi2_default>;
+
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "pnor";
+		spi-max-frequency = <50000000>;
+	};
+};
+
 &i2c0 {
 	status = "okay";
 	ina230@45 {
-- 
2.17.1

