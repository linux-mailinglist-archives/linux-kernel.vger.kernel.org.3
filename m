Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D855151C91D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 21:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385111AbiEETfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 15:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236532AbiEETft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 15:35:49 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 618DB5B3D5;
        Thu,  5 May 2022 12:32:08 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.91,203,1647270000"; 
   d="scan'208";a="120034524"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 06 May 2022 04:32:07 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 395D740E1669;
        Fri,  6 May 2022 04:32:02 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH 0/4] Add CPG wrapper for Renesas RZ/Five SoC
Date:   Thu,  5 May 2022 20:31:39 +0100
Message-Id: <20220505193143.31826-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This patch series adds CPG wrapper for Renesas RZ/Five SoC. RZ/Five SoC
has almost identical clock structure compared to RZ/G2UL, so
r9a07g043-cpg.c file is re-used to add support for Renesas RZ/Five SoC.

Sending this as RFC in case there is a better approach for patch#2 to
avoid looping. This patch has been tested on Renesas RZ/Five SMARC EVK.
Below is the clock structure reported by Linux with this patch series:

/ # cat /sys/devices/soc0/family 
RZ/Five
/ # cat /sys/devices/soc0/machine 
Renesas SMARC EVK based on r9a07g043
/ # cat /sys/devices/soc0/revision 
0
/ # cat /sys/devices/soc0/soc_id 
r9a07g043
/ # cat /sys/kernel/debug/clk/clk_summary 
                                 enable  prepare  protect                                duty  hardware
   clock                          count    count    count        rate   accuracy phase  cycle    enable
-------------------------------------------------------------------------------------------------------
 extal                                3        3        0    24000000          0     0  50000         Y
    .pll6                             0        0        0   500000000          0     0  50000         Y
       .pll6_250                      0        0        0   250000000          0     0  50000         Y
          HP                          0        0        0   250000000          0     0  50000         Y
    .pll3                             1        1        0  1600000000          0     0  50000         Y
       .pll3_533                      0        0        0   533333333          0     0  50000         Y
          .sel_pll3_3                 0        0        0   533333333          0     0  50000         Y
             divpl3c                  0        0        0   266666667          0     0  50000         Y
                SPI1                  0        0        0    66666666          0     0  50000         Y
                   spi_clk2           0        0        0    66666666          0     0  50000         N
                SPI0                  0        0        0   133333333          0     0  50000         Y
                   spi_clk            0        0        0   133333333          0     0  50000         N
       .pll3_400                      0        0        0   400000000          0     0  50000         Y
       .pll3_div2                     1        1        0   800000000          0     0  50000         Y
          .pll3_div2_4                1        1        0   200000000          0     0  50000         Y
             M0                       0        0        0   200000000          0     0  50000         Y
                eth1_axi              0        0        0   200000000          0     0  50000         N
                eth0_axi              0        0        0   200000000          0     0  50000         N
             P1                       2        2        0   200000000          0     0  50000         Y
                iax45_clk             1        1        0   200000000          0     0  50000         Y
                usb_pclk              0        0        0   200000000          0     0  50000         N
                usb0_func             0        0        0   200000000          0     0  50000         N
                usb1_host             0        0        0   200000000          0     0  50000         N
                usb0_host             0        0        0   200000000          0     0  50000         N
                sdhi1_aclk            0        0        0   200000000          0     0  50000         N
                sdhi0_aclk            0        0        0   200000000          0     0  50000         N
                dmac_aclk             1        1        0   200000000          0     0  50000         Y
                P1_DIV2               0        0        0   100000000          0     0  50000         Y
                   dmac_pclk          0        0        0   100000000          0     0  50000         N
             .pll3_div2_4_2           0        0        0   100000000          0     0  50000         Y
                ZT                    0        0        0   100000000          0     0  50000         Y
                   eth1_chi           0        0        0   100000000          0     0  50000         N
                   eth0_chi           0        0        0   100000000          0     0  50000         N
                P2                    0        0        0   100000000          0     0  50000         Y
                   iax45_pclk         0        0        0   100000000          0     0  50000         N
    .pll2                             1        1        0  1600000000          0     0  50000         Y
       .clk_533                       0        0        0   533333333          0     0  50000         Y
          sd1                         0        0        0   533333333          0     0  50000         Y
             sdhi1_clk_hs             0        0        0   533333333          0     0  50000         N
             SD1_DIV4                 0        0        0   133333333          0     0  50000         Y
                sdhi1_imclk2          0        0        0   133333333          0     0  50000         N
                sdhi1_imclk           0        0        0   133333333          0     0  50000         N
          sd0                         0        0        0   533333333          0     0  50000         Y
             sdhi0_clk_hs             0        0        0   533333333          0     0  50000         N
             SD0_DIV4                 0        0        0   133333333          0     0  50000         Y
                sdhi0_imclk2          0        0        0   133333333          0     0  50000         N
                sdhi0_imclk           0        0        0   133333333          0     0  50000         N
          .clk_266                    0        0        0   266666666          0     0  50000         Y
       .clk_800                       0        0        0   800000000          0     0  50000         Y
          .clk_400                    0        0        0   400000000          0     0  50000         Y
       .pll2_div2                     1        1        0   800000000          0     0  50000         Y
          .pll2_div2_10               0        0        0    80000000          0     0  50000         Y
             TSU                      0        0        0    80000000          0     0  50000         Y
                tsu_pclk              0        0        0    80000000          0     0  50000         N
                adc_adclk             0        0        0    80000000          0     0  50000         N
          .pll2_div2_8                1        1        0   100000000          0     0  50000         Y
             P0                       1        1        0   100000000          0     0  50000         Y
                adc_pclk              0        0        0   100000000          0     0  50000         N
                canfd                 0        0        0   100000000          0     0  50000         N
                rspi2                 0        0        0   100000000          0     0  50000         N
                rspi1                 0        0        0   100000000          0     0  50000         N
                rspi0                 0        0        0   100000000          0     0  50000         N
                sci1                  0        0        0   100000000          0     0  50000         N
                sci0                  0        0        0   100000000          0     0  50000         N
                scif4                 0        0        0   100000000          0     0  50000         N
                scif3                 0        0        0   100000000          0     0  50000         N
                scif2                 0        0        0   100000000          0     0  50000         N
                scif1                 0        0        0   100000000          0     0  50000         N
                scif0                 2        2        0   100000000          0     0  50000         Y
                i2c3                  0        0        0   100000000          0     0  50000         N
                i2c2                  0        0        0   100000000          0     0  50000         N
                i2c1                  0        0        0   100000000          0     0  50000         N
                i2c0                  0        0        0   100000000          0     0  50000         N
                ssi3_sfr              0        0        0   100000000          0     0  50000         N
                ssi3_pclk             0        0        0   100000000          0     0  50000         N
                ssi2_sfr              0        0        0   100000000          0     0  50000         N
                ssi2_pclk             0        0        0   100000000          0     0  50000         N
                ssi1_sfr              0        0        0   100000000          0     0  50000         N
                ssi1_pclk             0        0        0   100000000          0     0  50000         N
                ssi0_sfr              0        0        0   100000000          0     0  50000         N
                ssi0_pclk             0        0        0   100000000          0     0  50000         N
                wdt2_pclk             0        0        0   100000000          0     0  50000         N
                wdt0_pclk             0        0        0   100000000          0     0  50000         N
                ostm2                 0        0        0   100000000          0     0  50000         N
                ostm1                 0        0        0   100000000          0     0  50000         N
                ostm0                 0        0        0   100000000          0     0  50000         N
                P0_DIV2               0        0        0    50000000          0     0  50000         Y
    .pll1                             0        0        0  1000000000          0     0  50000         Y
       I                              0        0        0  1000000000          0     0  50000         Y
    .osc_div1000                      0        0        0       24000          0     0  50000         Y
    .osc                              1        1        0    24000000          0     0  50000         Y
       gpio                           1        2        0    24000000          0     0  50000         Y
       wdt2_clk                       0        0        0    24000000          0     0  50000         N
       wdt0_clk                       0        0        0    24000000          0     0  50000         N
/ # 
/ # 

This patch series depends on branch [0].

[0] https://git.kernel.org/pub/scm/linux/kernel/git/geert/
renesas-drivers.git/log/?h=renesas-clk-for-v5.19

Cheers,
Prabhakar

Lad Prabhakar (4):
  dt-bindings: clock: r9a07g043-cpg: Add Renesas RZ/Five CPG Clock and
    Reset Definitions
  clk: renesas: rzg2l-cpg: Add support to stack the resets instead of
    indexing
  clk: renesas: r9a07g043: Split up core, module and resets array
  clk: renesas: r9a07g043: Add support for RZ/Five SoC

 drivers/clk/renesas/r9a07g043-cpg.c       | 514 ++++++++++++----------
 drivers/clk/renesas/rzg2l-cpg.c           |  76 +++-
 drivers/clk/renesas/rzg2l-cpg.h           |   4 +-
 include/dt-bindings/clock/r9a07g043-cpg.h |  20 +
 4 files changed, 376 insertions(+), 238 deletions(-)

-- 
2.25.1

