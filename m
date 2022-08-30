Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228FF5A63F8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 14:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiH3MxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 08:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiH3MxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:53:20 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F78FC32C;
        Tue, 30 Aug 2022 05:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661864000; x=1693400000;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Na5ymG3WsoWgpmp/AyB5cJm9j+CWRAHLF47sr1rq6nk=;
  b=MjQ4Vw2PCSu1UGHaeaY3iBf5QdxupFRfzn9WUpq+eO/4jHEAR35J9yXQ
   Y0M2wXxPLasn06qWeumCriHVQTsV/TPTj8iNmZm+XeuwjX9Yvk5OALEhk
   bsKHNxatXAPciTuoeDJLKKAVCRkqzTNXEgM3miMrp04bEqaxeZMf5sFwG
   txdEpWIVxyCT7cSmS5EWm6oG6Wy6ZWw0U5SpUX4199XmLNr5SrKPS8Rye
   66HXpTs7nBAAxfqiXH9MAUkkbQQ6TA4VZORewmFTOqHqW2mf4uCW2pWsr
   m2ms3KaPhpfLZl+hK0QTxnCSd/3EHnRCJkITioP9dff1XyxtyBvG5xv7t
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="178301544"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Aug 2022 05:53:19 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 30 Aug 2022 05:53:18 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Tue, 30 Aug 2022 05:53:15 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        "Nathan Chancellor" <nathan@kernel.org>
Subject: [PATCH v4 01/13] clk: microchip: mpfs: fix clk_cfg array bounds violation
Date:   Tue, 30 Aug 2022 13:52:38 +0100
Message-ID: <20220830125249.2373416-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220830125110.2372514-1-conor.dooley@microchip.com>
References: <20220830125110.2372514-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unnoticed in current code, there is an array bounds violation present
during clock registration. This seems to fail gracefully in v6.0-rc1,
and life carrys on. While converting the driver to use standard clock
structs/ops, kernel panics were seen during boot when built with clang:

[    0.581754] Unable to handle kernel NULL pointer dereference at virtual address 00000000000000b1
[    0.591520] Oops [#1]
[    0.594045] Modules linked in:
[    0.597435] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.0.0-rc1-00011-g8e1459cf4eca #1
[    0.606188] Hardware name: Microchip PolarFire-SoC Icicle Kit (DT)
[    0.613012] epc : __clk_register+0x4a6/0x85c
[    0.617759]  ra : __clk_register+0x49e/0x85c
[    0.622489] epc : ffffffff803faf7c ra : ffffffff803faf74 sp : ffffffc80400b720
[    0.630466]  gp : ffffffff810e93f8 tp : ffffffe77fe60000 t0 : ffffffe77ffb3800
[    0.638443]  t1 : 000000000000000a t2 : ffffffffffffffff s0 : ffffffc80400b7c0
[    0.646420]  s1 : 0000000000000001 a0 : 0000000000000001 a1 : 0000000000000000
[    0.654396]  a2 : 0000000000000001 a3 : 0000000000000000 a4 : 0000000000000000
[    0.662373]  a5 : ffffffff803a5810 a6 : 0000000200000022 a7 : 0000000000000006
[    0.670350]  s2 : ffffffff81099d48 s3 : ffffffff80d6e28e s4 : 0000000000000028
[    0.678327]  s5 : ffffffff810ed3c8 s6 : ffffffff810ed3d0 s7 : ffffffe77ffbc100
[    0.686304]  s8 : ffffffe77ffb1540 s9 : ffffffe77ffb1540 s10: 0000000000000008
[    0.694281]  s11: 0000000000000000 t3 : 00000000000000c6 t4 : 0000000000000007
[    0.702258]  t5 : ffffffff810c78c0 t6 : ffffffe77ff88cd0
[    0.708125] status: 0000000200000120 badaddr: 00000000000000b1 cause: 000000000000000d
[    0.716869] [<ffffffff803fb892>] devm_clk_hw_register+0x62/0xaa
[    0.723420] [<ffffffff80403412>] mpfs_clk_probe+0x1e0/0x244

It fails on "clk_periph_timer" - which uses a different parent, that it
tries to find using the macro:
\#define PARENT_CLK(PARENT) (&mpfs_cfg_clks[CLK_##PARENT].cfg.hw)

If parent is RTCREF, so the macro becomes: &mpfs_cfg_clks[33].cfg.hw
which is well beyond the end of the array. Amazingly, builds with GCC
11.1 see no problem here, booting correctly and hooking the parent up
etc. Builds with clang-15 do not, with the above panic.

Drop the macro for the RTCREF and use the array directly to avoid the
panic, using a newly added define that brings the index into the valid
range.

Fixes: 1c6a7ea32b8c ("clk: microchip: mpfs: add RTCREF clock control")
CC: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/clk/microchip/clk-mpfs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/microchip/clk-mpfs.c b/drivers/clk/microchip/clk-mpfs.c
index 070c3b896559..9e41f07b3fa6 100644
--- a/drivers/clk/microchip/clk-mpfs.c
+++ b/drivers/clk/microchip/clk-mpfs.c
@@ -27,6 +27,8 @@
 #define MSSPLL_POSTDIV_WIDTH	0x07u
 #define MSSPLL_FIXED_DIV	4u
 
+#define RTCREF_OFFSET		(CLK_RTCREF - CLK_ENVM)
+
 struct mpfs_clock_data {
 	void __iomem *base;
 	void __iomem *msspll_base;
@@ -381,7 +383,8 @@ static struct mpfs_periph_hw_clock mpfs_periph_clks[] = {
 	CLK_PERIPH(CLK_MAC0, "clk_periph_mac0", PARENT_CLK(AHB), 1, 0),
 	CLK_PERIPH(CLK_MAC1, "clk_periph_mac1", PARENT_CLK(AHB), 2, 0),
 	CLK_PERIPH(CLK_MMC, "clk_periph_mmc", PARENT_CLK(AHB), 3, 0),
-	CLK_PERIPH(CLK_TIMER, "clk_periph_timer", PARENT_CLK(RTCREF), 4, 0),
+	CLK_PERIPH(CLK_TIMER, "clk_periph_timer",
+		   &mpfs_cfg_clks[CLK_RTCREF - RTCREF_OFFSET].hw, 4, 0),
 	CLK_PERIPH(CLK_MMUART0, "clk_periph_mmuart0", PARENT_CLK(AHB), 5, CLK_IS_CRITICAL),
 	CLK_PERIPH(CLK_MMUART1, "clk_periph_mmuart1", PARENT_CLK(AHB), 6, 0),
 	CLK_PERIPH(CLK_MMUART2, "clk_periph_mmuart2", PARENT_CLK(AHB), 7, 0),
-- 
2.36.1

