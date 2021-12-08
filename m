Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089E046CFC5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 10:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhLHJOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 04:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbhLHJOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 04:14:20 -0500
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [IPv6:2001:4b7a:2000:18::165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAB6C061746;
        Wed,  8 Dec 2021 01:10:48 -0800 (PST)
Received: from Marijn-Arch-PC.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 2251020384;
        Wed,  8 Dec 2021 10:10:45 +0100 (CET)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/2] Global Clock Controller driver for MSM8976/56
Date:   Wed,  8 Dec 2021 10:10:34 +0100
Message-Id: <20211208091036.132334-1-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the Global Clock Controller (GCC) driver for MSM8956, MSM8976
and APQ variants and it has been tested on two Sony phones featuring the
Qualcomm MSM8956 SoC.

In addition to GCC this driver is also responsible for providing MDSS
and GFX3D clocks which reside in the same register space.

SoMainline is dedicated to getting their long-awaited msm8976 support,
including the Xperia X, X Compact and if feasible also the Xperia Touch
projector (APQ8056) slowly but steadily upstreamed.

Changes since v5:
- Set vdd_gfx-supply in yaml example, which was added as required
  property in v5 but forgotten from the example; this is only caught by
  running dt_binding_check in addition to dtbs_check.

v5: https://lore.kernel.org/linux-clk/20211004195255.701220-1-marijn.suijten@somainline.org/T

Changes since v4:
- Insert error handling that left `int ret;` in gcc_msm8976_probe unused
  when the original regmap read, xor, and write were replaced with
  regmap_update_bits in v3;
- Document vdd_gfx supply, required in oxili_gx_gdsc;
- Dual-license the yaml Documentation and DT bindings (Rob).

Changes since v3:
- Set the enable_mask of gcc_apss_ahb_clk and gcc_apss_axi_clk to BIT 14
  and 13 respectively instead of overlapping gcc_crypto_ahb_clk's BIT 0.

Changes since v2:
- Rebased on v5.14;
- Various minor cleanups (lowercase hex, const where appropriate,
  removal of unused enum constants);
- Fixed XOR confusion in probe;
- All remnants of global clock name dependencies are removed, all
  inter-driver dependencies must be fully specified in DT;
- Added proper dt-bindings yaml validation, listing the required clocks;
- Moved dt-bindings header to the dt-bindings patch.

Changes since v1:
- Rebased onto linux-next 20191015
- Fixed platform driver name (qcom,gcc-8976 => gcc-msm8976)
- Splitted changes to dt-bindings to a separate commit

AngeloGioacchino Del Regno (1):
  clk: qcom: Add MSM8976/56 Global Clock Controller (GCC) driver

Marijn Suijten (1):
  dt-bindings: clk: qcom: Document MSM8976 Global Clock Controller

 .../bindings/clock/qcom,gcc-msm8976.yaml      |   97 +
 drivers/clk/qcom/Kconfig                      |    8 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/gcc-msm8976.c                | 4160 +++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-msm8976.h  |  240 +
 5 files changed, 4506 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-msm8976.yaml
 create mode 100644 drivers/clk/qcom/gcc-msm8976.c
 create mode 100644 include/dt-bindings/clock/qcom,gcc-msm8976.h


base-commit: 0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1
--
2.34.1

