Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFF151FFD2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 16:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237281AbiEIObW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 10:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237095AbiEIOa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 10:30:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C893423F391;
        Mon,  9 May 2022 07:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652106422; x=1683642422;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7NHU7oUM3DXm3+UgzqYybldzdLiN0cjWXHYNSTmv0K4=;
  b=Yzvq14AmtVIggDFc/k6e8rGUvWpe5cf7wahSO0Xa4YWTJcvlamodh5Im
   ms6HKyFELVY7UmZfzrCD0XrfC8GTBTcK+TG6SGx/eZcI61ykcR5Ed/PqF
   32DhJQQhFiVs+2haL0T02bHVT4ebTP6hSJewtUYGfdqGhQqLVJzHs/UHn
   7a79PdneUr9Nb6dKWHTgZ9sI/EM8uIUI0WThLpXYGvUfvFyFiuCAG8SBH
   6RVCICAIo9cutt42E9HUtbYzbwBFUQ6BCo4HNqZb6vTJehvuLcwcZycXT
   yAEksY6OiMb8v2D6CfGCtvYkPBx2jwJ1nrxZmtamZr8k6lww5RZK3ekGE
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="162858686"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 May 2022 07:27:02 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 9 May 2022 07:27:00 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 9 May 2022 07:26:58 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Cyril Jean <Cyril.Jean@microchip.com>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v5 05/10] riscv: dts: microchip: make the fabric dtsi board specific
Date:   Mon, 9 May 2022 15:26:06 +0100
Message-ID: <20220509142610.128590-6-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220509142610.128590-1-conor.dooley@microchip.com>
References: <20220509142610.128590-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently mpfs-fabric.dtsi is included by mpfs.dtsi - which is fine
currently since there is only one board with this SoC upstream.

However if another board was added, it would include the fabric contents
of the Icicle Kit's reference design. To avoid this, rename
mpfs-fabric.dtsi to mpfs-icicle-kit-fabric.dtsi & include it in the dts
rather than mpfs.dtsi.

mpfs-icicle-kit-fabric.dtsi specifically matches the 22.03 reference
design for the icicle kit's FPGA fabric & an older version of the
design may not have the i2c or pwm devices - so add the compatible
string to document this.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../microchip/{mpfs-fabric.dtsi => mpfs-icicle-kit-fabric.dtsi} | 2 ++
 arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts               | 1 +
 arch/riscv/boot/dts/microchip/mpfs.dtsi                         | 1 -
 3 files changed, 3 insertions(+), 1 deletion(-)
 rename arch/riscv/boot/dts/microchip/{mpfs-fabric.dtsi => mpfs-icicle-kit-fabric.dtsi} (91%)

diff --git a/arch/riscv/boot/dts/microchip/mpfs-fabric.dtsi b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
similarity index 91%
rename from arch/riscv/boot/dts/microchip/mpfs-fabric.dtsi
rename to arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
index ccaac3371cf9..0d28858b83f2 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-fabric.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
@@ -2,6 +2,8 @@
 /* Copyright (c) 2020-2021 Microchip Technology Inc */
 
 / {
+	compatible = "microchip,mpfs-icicle-reference-rtlv2203", "microchip,mpfs";
+
 	core_pwm0: pwm@41000000 {
 		compatible = "microchip,corepwm-rtl-v4";
 		reg = <0x0 0x41000000 0x0 0xF0>;
diff --git a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
index 84b0015dfd47..739dfa52bed1 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
+++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
@@ -4,6 +4,7 @@
 /dts-v1/;
 
 #include "mpfs.dtsi"
+#include "mpfs-icicle-kit-fabric.dtsi"
 
 /* Clock frequency (in Hz) of the rtcclk */
 #define RTCCLK_FREQ		1000000
diff --git a/arch/riscv/boot/dts/microchip/mpfs.dtsi b/arch/riscv/boot/dts/microchip/mpfs.dtsi
index cc3386068c2d..695c4e2807f5 100644
--- a/arch/riscv/boot/dts/microchip/mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs.dtsi
@@ -3,7 +3,6 @@
 
 /dts-v1/;
 #include "dt-bindings/clock/microchip,mpfs-clock.h"
-#include "mpfs-fabric.dtsi"
 
 / {
 	#address-cells = <2>;
-- 
2.35.2

