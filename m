Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7E159F662
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 11:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235760AbiHXJeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 05:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235463AbiHXJe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 05:34:29 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD709883C2;
        Wed, 24 Aug 2022 02:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661333667; x=1692869667;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ggvgSTbI/3n106FcPTJ8++adTEBX7bnWFulBMj2Sqa4=;
  b=iwKZyjAeMh4mzGYdA7TuJJDQs6GxKAtqKIXUMyPfFKNe3IKzILeQV25e
   arZos7PjWz8EajYMQsBtpbdqo0ZAUDHW8cVQ67zX/9743CUkDOvfCqtji
   IAdrvDHXyFYD5oiTz3pwBVoY9fPytLl2RT7YqHPKKdBnDc/0dzidsGciP
   4Y/X/irgWADTe5hZ+VmRwEBjb4mnBFy+9FfK9blCrLzTK9GIibBXvugKG
   LsGyr/rFKASq9wfMHA5x3j/I/a/MZfw79hVj7VXAU68zJlsq6iU1FmZ3O
   Dl9h2DO0vIzZrjxIXFP9ymzxQEbFS1W+QkvOch+/bDjah5j0Hq8p3U2ep
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="173887594"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2022 02:34:26 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 24 Aug 2022 02:34:25 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Wed, 24 Aug 2022 02:34:23 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Hugh Breslin <hugh.breslin@microchip.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 3/5] dt-bindings: clk: add PolarFire SoC fabric clock ids
Date:   Wed, 24 Aug 2022 10:33:41 +0100
Message-ID: <20220824093342.187844-4-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220824093342.187844-1-conor.dooley@microchip.com>
References: <20220824093342.187844-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each Clock Conditioning Circuitry block contains 2 PLLs and 2 DLLs.
The PLLs have 4 outputs each and the DLLs 2. Add 16 new IDs covering
these clocks. For more information on the CCC hardware, see the
"PolarFire SoC FPGA Clocking Resources" document at the link below.

Link: https://onlinedocs.microchip.com/pr/GUID-8F0CC4C0-0317-4262-89CA-CE7773ED1931-en-US-1/index.html
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../dt-bindings/clock/microchip,mpfs-clock.h  | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/dt-bindings/clock/microchip,mpfs-clock.h b/include/dt-bindings/clock/microchip,mpfs-clock.h
index 4048669bf756..79775a5134ca 100644
--- a/include/dt-bindings/clock/microchip,mpfs-clock.h
+++ b/include/dt-bindings/clock/microchip,mpfs-clock.h
@@ -45,4 +45,27 @@
 #define CLK_RTCREF	33
 #define CLK_MSSPLL	34
 
+/* Clock Conditioning Circuitry Clock IDs */
+
+#define CLK_CCC_PLL0		0
+#define CLK_CCC_PLL1		1
+#define CLK_CCC_DLL0		2
+#define CLK_CCC_DLL1		3
+
+#define CLK_CCC_PLL0_OUT0	4
+#define CLK_CCC_PLL0_OUT1	5
+#define CLK_CCC_PLL0_OUT2	6
+#define CLK_CCC_PLL0_OUT3	7
+
+#define CLK_CCC_PLL1_OUT0	8
+#define CLK_CCC_PLL1_OUT1	9
+#define CLK_CCC_PLL1_OUT2	10
+#define CLK_CCC_PLL1_OUT3	11
+
+#define CLK_CCC_DLL0_OUT0	12
+#define CLK_CCC_DLL0_OUT1	13
+
+#define CLK_CCC_DLL1_OUT0	14
+#define CLK_CCC_DLL1_OUT1	15
+
 #endif	/* _DT_BINDINGS_CLK_MICROCHIP_MPFS_H_ */
-- 
2.36.1

