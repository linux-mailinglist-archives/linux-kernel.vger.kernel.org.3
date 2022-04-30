Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA4C515D6B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 15:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379430AbiD3NQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 09:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382716AbiD3NQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 09:16:25 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEF382D23
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 06:13:03 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e2so14045328wrh.7
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 06:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod-ie.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5BDpWQnhgIgr6un23nDrSpiOtZvz8Bid/I/OR7bUXBg=;
        b=SlG01VQDuxSxdPy8VMdSmhznbCqvszukWiPbnb3FyMJXyipQCen4pPNN94SZggFHBR
         Khv8/STbGnjHar2BvWcMavvK+nWHNx4/vLDyhSmKF1w724sCgNYYjRtvGQEwbJnjRTnI
         SsCBr2A7+YyYPewKZbXskdXlem0Tx0wsiuw0sTypY8DTgT8EJBv4p9x1e8jA5Gfnv02n
         YJkDQH5oaeAP9EjFiV4q4h3/aZgXkSeR+WJ8b1+dsG8AI3hq2n081ke8V2vUU6UX3Evk
         bcIsgmakIN3lF27zSgQVwm4S1yL2dE9uKV+ImcWStQjPfAsY4OfloiF484vCfyGRcmmN
         27hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5BDpWQnhgIgr6un23nDrSpiOtZvz8Bid/I/OR7bUXBg=;
        b=4q0UfRoVVSZj6VkYtLdZQukK/3Tw6r2lFZ5nVm60+3UG+GNmHXwC+EmyeIbPmtoKZd
         vkExvs1Bq51urtOI8D14V/2r1bZn2yrYP3/j+2p3ZSSIuvLRaaau1nyhoaWwYWEHYn4D
         a+Iof0HsHT3mB1CVPoEf+CgNsbxQArVr7ROG2yg+4GY2ZkTbgTBvMIpUF8MEzENIzUfn
         AYNuOgecA7lglGNDHuws6Bp/u1q+MswoYbekytBf5+EocoPGStVlE7sZqQzb2wo2J+OR
         Jia97sXDdys3+jsLa9hwsHB0NXVCVZ0Fq/ZmM83kDPvNDjfKD1VznhIuWuaplAM72s3g
         EQzQ==
X-Gm-Message-State: AOAM531dVDk2k3SIo9nSv79I6OwkBur/W6RBhCtAquIovh01eRPKV3zS
        twiDAHU/c/0k4oObonPq6kGHQQ==
X-Google-Smtp-Source: ABdhPJzGWomTAcKYy8TjYtr6rv50Fq2fu7zj7OZUjLU0Hb9oHeoK5Z30y35gwYrn24hopjf/OilbsA==
X-Received: by 2002:a05:6000:1689:b0:20c:4fa1:ffb7 with SMTP id y9-20020a056000168900b0020c4fa1ffb7mr3111374wrd.48.1651324382219;
        Sat, 30 Apr 2022 06:13:02 -0700 (PDT)
Received: from henark71.. ([109.77.36.132])
        by smtp.gmail.com with ESMTPSA id p9-20020adfa209000000b0020c5253d8ebsm2004439wra.55.2022.04.30.06.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 06:13:01 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     krzk+dt@kernel.org, palmer@dabbelt.com, robh+dt@kernel.org
Cc:     conor.dooley@microchip.com, Cyril.Jean@microchip.com,
        daire.mcnamara@microchip.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, palmer@rivosinc.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Conor Dooley <mail@conchuod.ie>
Subject: [PATCH v2 8/8] riscv: dts: microchip: add the sundance polarberry
Date:   Sat, 30 Apr 2022 14:09:23 +0100
Message-Id: <20220430130922.3504268-9-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220430130922.3504268-1-mail@conchuod.ie>
References: <20220430130922.3504268-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
Signed-off-by: Conor Dooley <mail@conchuod.ie>
---
 arch/riscv/boot/dts/microchip/Makefile        |  1 +
 .../dts/microchip/mpfs-polarberry-fabric.dtsi | 16 ++++
 .../boot/dts/microchip/mpfs-polarberry.dts    | 95 +++++++++++++++++++
 3 files changed, 112 insertions(+)
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
index 000000000000..96ec589d1571
--- /dev/null
+++ b/arch/riscv/boot/dts/microchip/mpfs-polarberry.dts
@@ -0,0 +1,95 @@
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
+		serial0 = &mmuart0;
+		ethernet0 = &mac1;
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
+		status = "okay";
+	};
+
+	ddrc_cache_hi: memory@1000000000 {
+		device_type = "memory";
+		reg = <0x10 0x00000000 0x0 0xC0000000>;
+		status = "okay";
+	};
+};
+
+&refclk {
+	clock-frequency = <125000000>;
+};
+
+&mmuart0 {
+	status = "okay";
+};
+
+&mmc {
+	status = "okay";
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
+&mac0 {
+	status = "disabled";
+	phy-mode = "sgmii";
+	phy-handle = <&phy0>;
+};
+
+&rtc {
+	status = "okay";
+};
+
+&mbox {
+	status = "okay";
+};
+
+&syscontroller {
+	status = "okay";
+};
-- 
2.36.0

