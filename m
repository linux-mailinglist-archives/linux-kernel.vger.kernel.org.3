Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DA05679B9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 23:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbiGEVwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 17:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbiGEVwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 17:52:38 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239AD18B02
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 14:52:35 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id k129so7822398wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 14:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M74NHYWFVlubiyzjgBD3mtVBmUu/qEzBrtkUN6AlacI=;
        b=LbsmErJNj1SSPN0AV+Q9z9lT2N70/Up5BN2W8NH0wehmNKWQlNFrk5OqDzZYsXhdTQ
         Hls2B8wQmS6GVJiUmKU+y+yaAJc7rgO6Ud5AhtZzvidys3JAlk3J/1edTCp+TvTD957T
         42dzwHznCiQRrS/MgCgQeJ09qasxSpiV8miztZ7pEhH6qGce7h/pR1qJUNII4mzRjcPq
         g8TwWvnNrgB//oOp/UvWsKxjTFwctFHKdUfT4ZpyIYsUSVZYSvwFretmizy5s1OLt8wb
         YnUIbT3XDNd6vPA5xwOWmzcguEwV6zvMahHkg5IH0SkZmGb2HXJrkR3W9FnRywLNWmxh
         bGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M74NHYWFVlubiyzjgBD3mtVBmUu/qEzBrtkUN6AlacI=;
        b=qkBqABFlON/b9jgKZvNzSwvABNjG0zPanM3Wog7BkZxPw8eup3chnZixRFt9pd0SFO
         DcRK9QfrWu0RuEp/z4TbLxVvDrBgRmInOJl29xIEoz+SFj2cJ0+TRu/s8+4NaiBUdCf3
         3AFUannrz1g+/fisxdILQXIkz0bWzVG7CFNwFJVT+lCVPEaxTaTZLQpsKFtu3Qw8z/Rc
         2N+TPAO+PMWP+vx2djZDWx5rcih59Ih+B3wVxchGkOhK/9WN+0VuyeM2/tzCPdJKFyn+
         wmArNIk1HBzpuJUg3glmG31x9sdUkq880GkZGp48Uh59/8K+ZmL8eeLWbubd2Sn+0nAz
         gIGQ==
X-Gm-Message-State: AJIora88WuPryhhTQrQlyFtgiVFJDI5MxXqTMXZlWO0siEfTwL9tW6MU
        gCABvY1ixpHx0JrFwLOSsJSw9g==
X-Google-Smtp-Source: AGRyM1uO7vMG/o91hp3+JmOnC/LWvd4jQWu7ahaOiYX0BCambKOIE9rOv6ReR4Y7BVC7IcBtd6QPxw==
X-Received: by 2002:a05:600c:3788:b0:3a0:4279:5142 with SMTP id o8-20020a05600c378800b003a042795142mr36273470wmr.21.1657057953730;
        Tue, 05 Jul 2022 14:52:33 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id g34-20020a05600c4ca200b0039c7dbafa7asm18353920wmp.19.2022.07.05.14.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 14:52:33 -0700 (PDT)
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
Subject: [PATCH v5 07/13] riscv: dts: canaan: fix mmc node names
Date:   Tue,  5 Jul 2022 22:52:08 +0100
Message-Id: <20220705215213.1802496-8-mail@conchuod.ie>
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

The newly-converted-to-dt-schema binding expects the mmc node name to be
'^mmc(@.*)?$' so align the devicetree with the schema.

Tested-by: Niklas Cassel <niklas.cassel@wdc.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/canaan/canaan_kd233.dts     | 2 +-
 arch/riscv/boot/dts/canaan/sipeed_maix_bit.dts  | 2 +-
 arch/riscv/boot/dts/canaan/sipeed_maix_dock.dts | 2 +-
 arch/riscv/boot/dts/canaan/sipeed_maix_go.dts   | 2 +-
 arch/riscv/boot/dts/canaan/sipeed_maixduino.dts | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/boot/dts/canaan/canaan_kd233.dts b/arch/riscv/boot/dts/canaan/canaan_kd233.dts
index 039b92abf046..40992d495aa8 100644
--- a/arch/riscv/boot/dts/canaan/canaan_kd233.dts
+++ b/arch/riscv/boot/dts/canaan/canaan_kd233.dts
@@ -142,7 +142,7 @@ &spi1 {
 	cs-gpios = <&gpio0 16 GPIO_ACTIVE_LOW>;
 	status = "okay";
 
-	slot@0 {
+	mmc@0 {
 		compatible = "mmc-spi-slot";
 		reg = <0>;
 		voltage-ranges = <3300 3300>;
diff --git a/arch/riscv/boot/dts/canaan/sipeed_maix_bit.dts b/arch/riscv/boot/dts/canaan/sipeed_maix_bit.dts
index b9e30df127fe..5e809d0e11fb 100644
--- a/arch/riscv/boot/dts/canaan/sipeed_maix_bit.dts
+++ b/arch/riscv/boot/dts/canaan/sipeed_maix_bit.dts
@@ -189,7 +189,7 @@ &spi1 {
 	cs-gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
 	status = "okay";
 
-	slot@0 {
+	mmc@0 {
 		compatible = "mmc-spi-slot";
 		reg = <0>;
 		voltage-ranges = <3300 3300>;
diff --git a/arch/riscv/boot/dts/canaan/sipeed_maix_dock.dts b/arch/riscv/boot/dts/canaan/sipeed_maix_dock.dts
index 8d23401b0bbb..4be5ffac6b4a 100644
--- a/arch/riscv/boot/dts/canaan/sipeed_maix_dock.dts
+++ b/arch/riscv/boot/dts/canaan/sipeed_maix_dock.dts
@@ -191,7 +191,7 @@ &spi1 {
 	cs-gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
 	status = "okay";
 
-	slot@0 {
+	mmc@0 {
 		compatible = "mmc-spi-slot";
 		reg = <0>;
 		voltage-ranges = <3300 3300>;
diff --git a/arch/riscv/boot/dts/canaan/sipeed_maix_go.dts b/arch/riscv/boot/dts/canaan/sipeed_maix_go.dts
index 24fd83b43d9d..5c63f79b18ec 100644
--- a/arch/riscv/boot/dts/canaan/sipeed_maix_go.dts
+++ b/arch/riscv/boot/dts/canaan/sipeed_maix_go.dts
@@ -199,7 +199,7 @@ &spi1 {
 	cs-gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
 	status = "okay";
 
-	slot@0 {
+	mmc@0 {
 		compatible = "mmc-spi-slot";
 		reg = <0>;
 		voltage-ranges = <3300 3300>;
diff --git a/arch/riscv/boot/dts/canaan/sipeed_maixduino.dts b/arch/riscv/boot/dts/canaan/sipeed_maixduino.dts
index 25341f38292a..59f7eaf74655 100644
--- a/arch/riscv/boot/dts/canaan/sipeed_maixduino.dts
+++ b/arch/riscv/boot/dts/canaan/sipeed_maixduino.dts
@@ -164,7 +164,7 @@ &spi1 {
 	cs-gpios = <&gpio1_0 2 GPIO_ACTIVE_LOW>;
 	status = "okay";
 
-	slot@0 {
+	mmc@0 {
 		compatible = "mmc-spi-slot";
 		reg = <0>;
 		voltage-ranges = <3300 3300>;
-- 
2.37.0

