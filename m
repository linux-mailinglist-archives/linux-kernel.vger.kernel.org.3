Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8C6516778
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 21:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354002AbiEATal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 15:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353693AbiEATaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 15:30:07 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70542DA91
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 12:26:39 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id k2so17217265wrd.5
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 12:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod-ie.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rfHaik7/2US1P/NFRRn4iUnlONPLqG6WILHOUefbBUo=;
        b=mVdv9kcwOOIpX2quM/vp3HTG42F5lFQfkJxhE6lBERhLVc7FEwAM/Tn4kD+7r62ie8
         nvlAX46+VaiPTnF/vylOd4xI+lScf0samo6C4eeA/GEJ3KrbWWyOJe7OmoW+Vwii6HqG
         rWf8UXEHyGB2/s4ROjXXjewRBx1w/DyfWoz+chilBzG6ESM3ictgX6QuwAPWgZtrAMQt
         FBKns7Y1C/TbqWVRqL+8qkARg7ZrKNKNotJc+/nTWOdUs1fWwCOXM1WFnsji800uqj9Z
         YYMK7gooIH4sy+NV0qHp8CYytcOcOL/cVgfLYrvALtxEAKAJgLccYTYoodR9xMVbF2ES
         Y6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rfHaik7/2US1P/NFRRn4iUnlONPLqG6WILHOUefbBUo=;
        b=BwPNZLMxxMOEesx90UeD6yJGX0fUZgvHodeu4QZODOmqQr9xdpiC8isKTBxtgshQVx
         u9+aadUIQHbkMsaKlhCEi6X0j2nJahRrBWh6x9MWddP0TdVbxZDo4tnuio3G2nq7SlXi
         81gKWvbGPdgjrKwbqCZct8w6F9DVS+XUfC304/9cu9amTeaQFuzlnSJoJKhnUm+0oqNW
         XFvMNb1BbqSaltRo/m4gzuFR4jJRKAe8aPxBFdG5jMt1BM8f32pkdfVL92doS3QpNmfa
         9UBSfI+jEMxFPHJGl78xhBZmSDwjSE4xyg1QE3rcMQCOl2bl/k9gKwQTFOksCF2XS8ax
         dgcQ==
X-Gm-Message-State: AOAM531uunxoBGRnAcyCsBa/+oYd7KNnGGnXOvylW1IxofeCn3Q6ruOU
        +pIFObY9cQ53LGuCl1V0Dio3JQ==
X-Google-Smtp-Source: ABdhPJx2i0mes1PmcgvFU5xWJ4TRUZY/DT1oIlVE5UY3f+NAzTWLdIkcmmjjxXaExuxvVcYoCFsCag==
X-Received: by 2002:a5d:5012:0:b0:20a:d9a9:44dc with SMTP id e18-20020a5d5012000000b0020ad9a944dcmr7113624wrt.627.1651433198331;
        Sun, 01 May 2022 12:26:38 -0700 (PDT)
Received: from henark71.. ([109.77.36.132])
        by smtp.gmail.com with ESMTPSA id i14-20020adfa50e000000b0020c5253d8c6sm6448105wrb.18.2022.05.01.12.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 12:26:37 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     krzk+dt@kernel.org, palmer@dabbelt.com, robh+dt@kernel.org
Cc:     conor.dooley@microchip.com, Cyril.Jean@microchip.com,
        daire.mcnamara@microchip.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, palmer@rivosinc.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v3 8/8] riscv: dts: microchip: add the sundance polarberry
Date:   Sun,  1 May 2022 20:25:59 +0100
Message-Id: <20220501192557.2631936-9-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220501192557.2631936-1-mail@conchuod.ie>
References: <20220501192557.2631936-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

