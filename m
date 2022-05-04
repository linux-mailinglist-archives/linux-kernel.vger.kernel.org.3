Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D52051AF5B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378288AbiEDUjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378159AbiEDUjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:39:02 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AAEB7F0
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 13:35:23 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id a14-20020a7bc1ce000000b00393fb52a386so3929108wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 13:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fsh4pbs3Reo8M+2WhELoDR9Jgw5waXtKp+zOH5sp9UY=;
        b=BVwVA9Mihadsw+0aZxp3gkgbyCJ+Dg52FAHNdNppEqfjL91z9zMOjvJwUsz7TtzE9o
         bLajepeEas5+xQlj67PBRX07sXnY5tkzCXadRDHg+LO7lXwkI3kSJt1qTUfbKNZx9ZqD
         EjDUg3YXP3yq5wG/qpj4wrbVtoeF/0P/PLIlq3t1kEuEgwYglnpwSKgKeUYxgPOaHKMy
         wVzLEHX3D7ADUTMrsXbrhFdz1MvvG03zKypEg4SEq5b+2MJNwmOCQuOG8PT53ykhjSTt
         PzC74e7eqwqrWqNJEAofERfKaHOU5YhAco7aY9P5j7G64a6sDZXZxE5j+3K/DE7rbLsQ
         dz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fsh4pbs3Reo8M+2WhELoDR9Jgw5waXtKp+zOH5sp9UY=;
        b=74Qt4oK64tmHpB9qI5fyJQtN/4m9xurTRTBit2MaLImo764hR4WX0zBOdvqUMGLyQ0
         1UY1pn6ao3kLWSiNdNIFNdwXZ0E+nReCyN0FDl9LcAjXu8z6HFewJ7KGcXNuOHb22s10
         YlE3r+q9TYMx0p8jgaFoxbDkyGGGbjN7sUzRodjaH5bCNr3Es/08exfIC9TTStX480+T
         q1aO+JhF56qEIK7w+cC48ervUbL026nL1ECbXZeAPqRValApwxDtrf2Cz577AvDwNfv2
         /l1uwlgvnxuDFJGfQtk5xq9jWKOZ185efGzwkI18AukuGW9/AND7cG+WsjPSOcFm6Vb9
         UApA==
X-Gm-Message-State: AOAM531bTwYIxoGGR285lx+UJ32POaiHWyUOv/pte/Cu/xuOMmEOCkwp
        ELeHrdQxrAwN5O0SNinEv9RjiQ==
X-Google-Smtp-Source: ABdhPJzBd2X1g1vv5U4f2un+q/En59yasOly1MTqtmipkBqEI+cZhShIPdGKAXebzJkRSYAqxPMV1g==
X-Received: by 2002:a05:600c:9:b0:393:ea67:1c68 with SMTP id g9-20020a05600c000900b00393ea671c68mr1127451wmc.92.1651696522583;
        Wed, 04 May 2022 13:35:22 -0700 (PDT)
Received: from henark71.. ([109.77.36.132])
        by smtp.gmail.com with ESMTPSA id l20-20020adfc794000000b0020c5253d8dfsm13330101wrg.43.2022.05.04.13.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 13:35:22 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     krzk+dt@kernel.org, palmer@dabbelt.com, robh+dt@kernel.org
Cc:     conor.dooley@microchip.com, Cyril.Jean@microchip.com,
        daire.mcnamara@microchip.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, palmer@rivosinc.com, arnd@arndb.de,
        heiko@sntech.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v4 8/8] riscv: dts: microchip: add the sundance polarberry
Date:   Wed,  4 May 2022 21:30:52 +0100
Message-Id: <20220504203051.1210355-9-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220504203051.1210355-1-mail@conchuod.ie>
References: <20220504203051.1210355-1-mail@conchuod.ie>
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

Add a minimal device tree for the PolarFire SoC based Sundance
PolarBerry.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/microchip/Makefile        |  1 +
 .../dts/microchip/mpfs-polarberry-fabric.dtsi | 16 +++
 .../boot/dts/microchip/mpfs-polarberry.dts    | 97 +++++++++++++++++++
 3 files changed, 114 insertions(+)
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-polarberry-fabric.dtsi
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-polarberry.dts

diff --git a/arch/riscv/boot/dts/microchip/Makefile b/arch/riscv/boot/dts/microchip/Makefile
index af3a5059b350..39aae7b04f1c 100644
--- a/arch/riscv/boot/dts/microchip/Makefile
+++ b/arch/riscv/boot/dts/microchip/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_SOC_MICROCHIP_POLARFIRE) += mpfs-icicle-kit.dtb
+dtb-$(CONFIG_SOC_MICROCHIP_POLARFIRE) += mpfs-polarberry.dtb
 obj-$(CONFIG_BUILTIN_DTB) += $(addsuffix .o, $(dtb-y))
diff --git a/arch/riscv/boot/dts/microchip/mpfs-polarberry-fabric.dtsi b/arch/riscv/boot/dts/microchip/mpfs-polarberry-fabric.dtsi
new file mode 100644
index 000000000000..49380c428ec9
--- /dev/null
+++ b/arch/riscv/boot/dts/microchip/mpfs-polarberry-fabric.dtsi
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/* Copyright (c) 2020-2022 Microchip Technology Inc */
+
+/ {
+	fabric_clk3: fabric-clk3 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <62500000>;
+	};
+
+	fabric_clk1: fabric-clk1 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;
+	};
+};
diff --git a/arch/riscv/boot/dts/microchip/mpfs-polarberry.dts b/arch/riscv/boot/dts/microchip/mpfs-polarberry.dts
new file mode 100644
index 000000000000..1cad5b0d42e1
--- /dev/null
+++ b/arch/riscv/boot/dts/microchip/mpfs-polarberry.dts
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/* Copyright (c) 2020-2022 Microchip Technology Inc */
+
+/dts-v1/;
+
+#include "mpfs.dtsi"
+#include "mpfs-polarberry-fabric.dtsi"
+
+/* Clock frequency (in Hz) of the rtcclk */
+#define MTIMER_FREQ	1000000
+
+/ {
+	model = "Sundance PolarBerry";
+	compatible = "sundance,polarberry", "microchip,mpfs";
+
+	aliases {
+		ethernet0 = &mac1;
+		serial0 = &mmuart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	cpus {
+		timebase-frequency = <MTIMER_FREQ>;
+	};
+
+	ddrc_cache_lo: memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x2e000000>;
+	};
+
+	ddrc_cache_hi: memory@1000000000 {
+		device_type = "memory";
+		reg = <0x10 0x00000000 0x0 0xC0000000>;
+	};
+};
+
+/*
+ * phy0 is connected to mac0, but the port itself is on the (optional) carrier
+ * board.
+ */
+&mac0 {
+	status = "disabled";
+	phy-mode = "sgmii";
+	phy-handle = <&phy0>;
+};
+
+&mac1 {
+	status = "okay";
+	phy-mode = "sgmii";
+	phy-handle = <&phy1>;
+	phy1: ethernet-phy@5 {
+		reg = <5>;
+		ti,fifo-depth = <0x01>;
+	};
+	phy0: ethernet-phy@4 {
+		reg = <4>;
+		ti,fifo-depth = <0x01>;
+	};
+};
+
+&mbox {
+	status = "okay";
+};
+
+&mmc {
+	bus-width = <4>;
+	disable-wp;
+	cap-sd-highspeed;
+	cap-mmc-highspeed;
+	card-detect-delay = <200>;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	status = "okay";
+};
+
+&mmuart0 {
+	status = "okay";
+};
+
+&refclk {
+	clock-frequency = <125000000>;
+};
+
+&rtc {
+	status = "okay";
+};
+
+&syscontroller {
+	status = "okay";
+};
-- 
2.36.0

