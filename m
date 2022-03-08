Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647A44D0C84
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 01:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343999AbiCHALL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 19:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343979AbiCHALE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 19:11:04 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAB531201
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 16:10:07 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id s42so3250449pfg.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 16:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PTaEtbbk28Qrbp5jCMDXpaLMTe5fwbMLEeGPGWRSKk0=;
        b=hCKHsIWD5G0ErcT111YtQnY8t6Pyu07NYRKlP7I4hyrkR4Txajl2o+7bNBuAef4NHZ
         GNDrfWkCXtPwke4vseQLSrFi1WkxGGCTkqNKzcZD3nfwGezMrK+Re4B+1kWwqD0cJI0X
         q4LFlVbp5NqgM4sKHbc/LzQffK4BC3f22cSGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PTaEtbbk28Qrbp5jCMDXpaLMTe5fwbMLEeGPGWRSKk0=;
        b=ggigLeMmQa4mQ1YW5sattEp4vKXTSudy9hcRY5Hx1SIqPIG21cmz/MOqL/DXuG8r6m
         RZgZdAiYgE1f5ZEKOm5/UaSCJIt+NaNkroN4JxWyxGhif0mYTlJqr8/eCK/I1jRtZ1hI
         B1pP6MZA+OnERbFic5jmeqNdjoq0bjhAowcQUdQmyAUA+CLzhsDvEez+lsMbNuznEZbm
         YWu6//w1iVJlbq8BiN94QqyOloD3KnRGDXpWx8/rmn13MuGNLFlxXj8SGrDG32SyfDKf
         1kTPJBFc81I+onxEKDZWabQE4CEGAPPsZodP29MUjidlQYhMb3jJlIre07mRBHlv6Ord
         2jyg==
X-Gm-Message-State: AOAM530+gjYs0pa3wP+e+Ho2wUu+N2f86e5rEskVv55Cb79+hUqaIqiA
        hywCJNZJf+R4EDSX8OYVg8JJtg==
X-Google-Smtp-Source: ABdhPJyvd2JCoJ+FJDYAYvbKN00v6c3TvtxtDbR+E5KJQp0GzFKLh9Exe4WmLM9P8YXwa6ps8R8k6w==
X-Received: by 2002:a05:6a00:815:b0:4f6:ee04:30af with SMTP id m21-20020a056a00081500b004f6ee0430afmr10682880pfk.15.1646698206271;
        Mon, 07 Mar 2022 16:10:06 -0800 (PST)
Received: from localhost ([2620:15c:202:201:e551:44dc:2842:57f1])
        by smtp.gmail.com with UTF8SMTPSA id u8-20020a056a00158800b004f71a6962adsm2862762pfk.9.2022.03.07.16.10.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 16:10:05 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Lin Huang <hl@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
        Derek Basehore <dbasehore@chromium.org>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v3 01/15] dt-bindings: devfreq: rk3399_dmc: Convert to YAML
Date:   Mon,  7 Mar 2022 16:09:31 -0800
Message-Id: <20220307160918.v3.1.I875ab8f28c5155a7d2f103316191954d4b07ac13@changeid>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
In-Reply-To: <20220308000945.706701-1-briannorris@chromium.org>
References: <20220308000945.706701-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I want to add, deprecate, and bugfix some properties, as well as add the
first users. This is easier with a proper schema.

The transformation is mostly straightforward, plus a few notable tweaks:

 * Renamed rockchip,dram_speed_bin to rockchip,ddr3_speed_bin. The
   driver code and the example matched, but the description was
   different. I went with the implementation. Note that this property is
   also slated for deprecation/deletion in the subsequent patches.

 * Drop upthreshold and downdifferential properties from the example.
   These were undocumented (so, wouldn't pass validation), but were
   representing software properties (governor tweaks). I drop them from
   the driver in subsequent patches.

 * Rename clock from pclk_ddr_mon to dmc_clk. The driver, DT example,
   and all downstream users matched -- the binding definition was the
   exception. Anyway, "dmc_clk" is a more appropriately generic name.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v3:
 * Add |maxItems| for devfreq-events
 * Improve deprecation notes

Changes in v2:
 * rename to 'memory-controller' in example
 * place 'required' after properties
 * drop superluous free-form references and repetitions of other
   bindings
 * fix for yamllint

 .../bindings/devfreq/rk3399_dmc.txt           | 212 -------------
 .../bindings/devfreq/rk3399_dmc.yaml          | 294 ++++++++++++++++++
 2 files changed, 294 insertions(+), 212 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
 create mode 100644 Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml

diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
deleted file mode 100644
index 58fc8a6cebc7..000000000000
--- a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
+++ /dev/null
@@ -1,212 +0,0 @@
-* Rockchip rk3399 DMC (Dynamic Memory Controller) device
-
-Required properties:
-- compatible:		 Must be "rockchip,rk3399-dmc".
-- devfreq-events:	 Node to get DDR loading, Refer to
-			 Documentation/devicetree/bindings/devfreq/event/
-			 rockchip-dfi.txt
-- clocks:		 Phandles for clock specified in "clock-names" property
-- clock-names :		 The name of clock used by the DFI, must be
-			 "pclk_ddr_mon";
-- operating-points-v2:	 Refer to Documentation/devicetree/bindings/opp/opp-v2.yaml
-			 for details.
-- center-supply:	 DMC supply node.
-- status:		 Marks the node enabled/disabled.
-- rockchip,pmu:		 Phandle to the syscon managing the "PMU general register
-			 files".
-
-Optional properties:
-- interrupts:		 The CPU interrupt number. The interrupt specifier
-			 format depends on the interrupt controller.
-			 It should be a DCF interrupt. When DDR DVFS finishes
-			 a DCF interrupt is triggered.
-- rockchip,pmu:		 Phandle to the syscon managing the "PMU general register
-			 files".
-
-Following properties relate to DDR timing:
-
-- rockchip,dram_speed_bin :	  Value reference include/dt-bindings/clock/rk3399-ddr.h,
-				  it selects the DDR3 cl-trp-trcd type. It must be
-				  set according to "Speed Bin" in DDR3 datasheet,
-				  DO NOT use a smaller "Speed Bin" than specified
-				  for the DDR3 being used.
-
-- rockchip,pd_idle :		  Configure the PD_IDLE value. Defines the
-				  power-down idle period in which memories are
-				  placed into power-down mode if bus is idle
-				  for PD_IDLE DFI clock cycles.
-
-- rockchip,sr_idle :		  Configure the SR_IDLE value. Defines the
-				  self-refresh idle period in which memories are
-				  placed into self-refresh mode if bus is idle
-				  for SR_IDLE * 1024 DFI clock cycles (DFI
-				  clocks freq is half of DRAM clock), default
-				  value is "0".
-
-- rockchip,sr_mc_gate_idle :	  Defines the memory self-refresh and controller
-				  clock gating idle period. Memories are placed
-				  into self-refresh mode and memory controller
-				  clock arg gating started if bus is idle for
-				  sr_mc_gate_idle*1024 DFI clock cycles.
-
-- rockchip,srpd_lite_idle :	  Defines the self-refresh power down idle
-				  period in which memories are placed into
-				  self-refresh power down mode if bus is idle
-				  for srpd_lite_idle * 1024 DFI clock cycles.
-				  This parameter is for LPDDR4 only.
-
-- rockchip,standby_idle :	  Defines the standby idle period in which
-				  memories are placed into self-refresh mode.
-				  The controller, pi, PHY and DRAM clock will
-				  be gated if bus is idle for standby_idle * DFI
-				  clock cycles.
-
-- rockchip,dram_dll_dis_freq :	  Defines the DDR3 DLL bypass frequency in MHz.
-				  When DDR frequency is less than DRAM_DLL_DISB_FREQ,
-				  DDR3 DLL will be bypassed. Note: if DLL was bypassed,
-				  the odt will also stop working.
-
-- rockchip,phy_dll_dis_freq :	  Defines the PHY dll bypass frequency in
-				  MHz (Mega Hz). When DDR frequency is less than
-				  DRAM_DLL_DISB_FREQ, PHY DLL will be bypassed.
-				  Note: PHY DLL and PHY ODT are independent.
-
-- rockchip,ddr3_odt_dis_freq :	  When the DRAM type is DDR3, this parameter defines
-				  the ODT disable frequency in MHz (Mega Hz).
-				  when the DDR frequency is  less then ddr3_odt_dis_freq,
-				  the ODT on the DRAM side and controller side are
-				  both disabled.
-
-- rockchip,ddr3_drv :		  When the DRAM type is DDR3, this parameter defines
-				  the DRAM side driver strength in ohms. Default
-				  value is 40.
-
-- rockchip,ddr3_odt :		  When the DRAM type is DDR3, this parameter defines
-				  the DRAM side ODT strength in ohms. Default value
-				  is 120.
-
-- rockchip,phy_ddr3_ca_drv :	  When the DRAM type is DDR3, this parameter defines
-				  the phy side CA line (incluing command line,
-				  address line and clock line) driver strength.
-				  Default value is 40.
-
-- rockchip,phy_ddr3_dq_drv :	  When the DRAM type is DDR3, this parameter defines
-				  the PHY side DQ line (including DQS/DQ/DM line)
-				  driver strength. Default value is 40.
-
-- rockchip,phy_ddr3_odt : 	  When the DRAM type is DDR3, this parameter defines
-				  the PHY side ODT strength. Default value is 240.
-
-- rockchip,lpddr3_odt_dis_freq : When the DRAM type is LPDDR3, this parameter defines
-				  then ODT disable frequency in MHz (Mega Hz).
-				  When DDR frequency is less then ddr3_odt_dis_freq,
-				  the ODT on the DRAM side and controller side are
-				  both disabled.
-
-- rockchip,lpddr3_drv :		  When the DRAM type is LPDDR3, this parameter defines
-				  the DRAM side driver strength in ohms. Default
-				  value is 34.
-
-- rockchip,lpddr3_odt :		  When the DRAM type is LPDDR3, this parameter defines
-				  the DRAM side ODT strength in ohms. Default value
-				  is 240.
-
-- rockchip,phy_lpddr3_ca_drv :	  When the DRAM type is LPDDR3, this parameter defines
-				  the PHY side CA line (including command line,
-				  address line and clock line) driver strength.
-				  Default value is 40.
-
-- rockchip,phy_lpddr3_dq_drv :	  When the DRAM type is LPDDR3, this parameter defines
-				  the PHY side DQ line (including DQS/DQ/DM line)
-				  driver strength. Default value is 40.
-
-- rockchip,phy_lpddr3_odt : 	  When dram type is LPDDR3, this parameter define
-				  the phy side odt strength, default value is 240.
-
-- rockchip,lpddr4_odt_dis_freq : When the DRAM type is LPDDR4, this parameter
-				  defines the ODT disable frequency in
-				  MHz (Mega Hz). When the DDR frequency is less then
-				  ddr3_odt_dis_freq, the ODT on the DRAM side and
-				  controller side are both disabled.
-
-- rockchip,lpddr4_drv :		  When the DRAM type is LPDDR4, this parameter defines
-				  the DRAM side driver strength in ohms. Default
-				  value is 60.
-
-- rockchip,lpddr4_dq_odt : 	  When the DRAM type is LPDDR4, this parameter defines
-				  the DRAM side ODT on DQS/DQ line strength in ohms.
-				  Default value is 40.
-
-- rockchip,lpddr4_ca_odt :	  When the DRAM type is LPDDR4, this parameter defines
-				  the DRAM side ODT on CA line strength in ohms.
-				  Default value is 40.
-
-- rockchip,phy_lpddr4_ca_drv :	  When the DRAM type is LPDDR4, this parameter defines
-				  the PHY side CA line (including command address
-				  line) driver strength. Default value is 40.
-
-- rockchip,phy_lpddr4_ck_cs_drv : When the DRAM type is LPDDR4, this parameter defines
-				  the PHY side clock line and CS line driver
-				  strength. Default value is 80.
-
-- rockchip,phy_lpddr4_dq_drv :	  When the DRAM type is LPDDR4, this parameter defines
-				  the PHY side DQ line (including DQS/DQ/DM line)
-				  driver strength. Default value is 80.
-
-- rockchip,phy_lpddr4_odt :	  When the DRAM type is LPDDR4, this parameter defines
-				  the PHY side ODT strength. Default value is 60.
-
-Example:
-	dmc_opp_table: dmc_opp_table {
-		compatible = "operating-points-v2";
-
-		opp00 {
-			opp-hz = /bits/ 64 <300000000>;
-			opp-microvolt = <900000>;
-		};
-		opp01 {
-			opp-hz = /bits/ 64 <666000000>;
-			opp-microvolt = <900000>;
-		};
-	};
-
-	dmc: dmc {
-		compatible = "rockchip,rk3399-dmc";
-		devfreq-events = <&dfi>;
-		interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cru SCLK_DDRC>;
-		clock-names = "dmc_clk";
-		operating-points-v2 = <&dmc_opp_table>;
-		center-supply = <&ppvar_centerlogic>;
-		upthreshold = <15>;
-		downdifferential = <10>;
-		rockchip,ddr3_speed_bin = <21>;
-		rockchip,pd_idle = <0x40>;
-		rockchip,sr_idle = <0x2>;
-		rockchip,sr_mc_gate_idle = <0x3>;
-		rockchip,srpd_lite_idle	= <0x4>;
-		rockchip,standby_idle = <0x2000>;
-		rockchip,dram_dll_dis_freq = <300>;
-		rockchip,phy_dll_dis_freq = <125>;
-		rockchip,auto_pd_dis_freq = <666>;
-		rockchip,ddr3_odt_dis_freq = <333>;
-		rockchip,ddr3_drv = <40>;
-		rockchip,ddr3_odt = <120>;
-		rockchip,phy_ddr3_ca_drv = <40>;
-		rockchip,phy_ddr3_dq_drv = <40>;
-		rockchip,phy_ddr3_odt = <240>;
-		rockchip,lpddr3_odt_dis_freq = <333>;
-		rockchip,lpddr3_drv = <34>;
-		rockchip,lpddr3_odt = <240>;
-		rockchip,phy_lpddr3_ca_drv = <40>;
-		rockchip,phy_lpddr3_dq_drv = <40>;
-		rockchip,phy_lpddr3_odt = <240>;
-		rockchip,lpddr4_odt_dis_freq = <333>;
-		rockchip,lpddr4_drv = <60>;
-		rockchip,lpddr4_dq_odt = <40>;
-		rockchip,lpddr4_ca_odt = <40>;
-		rockchip,phy_lpddr4_ca_drv = <40>;
-		rockchip,phy_lpddr4_ck_cs_drv = <80>;
-		rockchip,phy_lpddr4_dq_drv = <80>;
-		rockchip,phy_lpddr4_odt = <60>;
-	};
diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml
new file mode 100644
index 000000000000..ddddddc5c6fb
--- /dev/null
+++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml
@@ -0,0 +1,294 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# %YAML 1.2
+---
+$id: http://devicetree.org/schemas/devfreq/rk3399_dmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip rk3399 DMC (Dynamic Memory Controller) device
+
+maintainers:
+  - Brian Norris <briannorris@chromium.org>
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3399-dmc
+
+  devfreq-events:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    minItems: 1
+    maxItems: 1
+    description:
+      Node to get DDR loading. Refer to
+      Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt.
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: dmc_clk
+
+  operating-points-v2: true
+
+  center-supply:
+    description:
+      DMC regulator supply.
+
+  rockchip,pmu:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the syscon managing the "PMU general register files".
+
+  interrupts:
+    maxItems: 1
+    description:
+      The CPU interrupt number. It should be a DCF interrupt. When DDR DVFS
+      finishes, a DCF interrupt is triggered.
+
+  rockchip,ddr3_speed_bin:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      For values, reference include/dt-bindings/clock/rk3399-ddr.h. Selects the
+      DDR3 cl-trp-trcd type. It must be set according to "Speed Bin" in DDR3
+      datasheet; DO NOT use a smaller "Speed Bin" than specified for the DDR3
+      being used.
+
+  rockchip,pd_idle:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Configure the PD_IDLE value. Defines the power-down idle period in which
+      memories are placed into power-down mode if bus is idle for PD_IDLE DFI
+      clock cycles.
+
+  rockchip,sr_idle:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Configure the SR_IDLE value. Defines the self-refresh idle period in
+      which memories are placed into self-refresh mode if bus is idle for
+      SR_IDLE * 1024 DFI clock cycles (DFI clocks freq is half of DRAM clock).
+      Default value is "0".
+
+  rockchip,sr_mc_gate_idle:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Defines the memory self-refresh and controller clock gating idle period.
+      Memories are placed into self-refresh mode and memory controller clock
+      arg gating started if bus is idle for sr_mc_gate_idle*1024 DFI clock
+      cycles.
+
+  rockchip,srpd_lite_idle:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Defines the self-refresh power down idle period in which memories are
+      placed into self-refresh power down mode if bus is idle for
+      srpd_lite_idle * 1024 DFI clock cycles. This parameter is for LPDDR4
+      only.
+
+  rockchip,standby_idle:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Defines the standby idle period in which memories are placed into
+      self-refresh mode. The controller, pi, PHY and DRAM clock will be gated
+      if bus is idle for standby_idle * DFI clock cycles.
+
+  rockchip,dram_dll_dis_freq:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Defines the DDR3 DLL bypass frequency in MHz. When DDR frequency is less
+      than DRAM_DLL_DISB_FREQ, DDR3 DLL will be bypassed.
+      Note: if DLL was bypassed, the odt will also stop working.
+
+  rockchip,phy_dll_dis_freq:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Defines the PHY dll bypass frequency in MHz (Mega Hz). When DDR frequency
+      is less than DRAM_DLL_DISB_FREQ, PHY DLL will be bypassed.
+      Note: PHY DLL and PHY ODT are independent.
+
+  rockchip,auto_pd_dis_freq:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Defines the auto PD disable frequency in MHz.
+
+  rockchip,ddr3_odt_dis_freq:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      When the DRAM type is DDR3, this parameter defines the ODT disable
+      frequency in MHz (Mega Hz). When the DDR frequency is less then
+      ddr3_odt_dis_freq, the ODT on the DRAM side and controller side are both
+      disabled.
+
+  rockchip,ddr3_drv:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      When the DRAM type is DDR3, this parameter defines the DRAM side drive
+      strength in ohms. Default value is 40.
+
+  rockchip,ddr3_odt:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      When the DRAM type is DDR3, this parameter defines the DRAM side ODT
+      strength in ohms. Default value is 120.
+
+  rockchip,phy_ddr3_ca_drv:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      When the DRAM type is DDR3, this parameter defines the phy side CA line
+      (incluing command line, address line and clock line) drive strength.
+      Default value is 40.
+
+  rockchip,phy_ddr3_dq_drv:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      When the DRAM type is DDR3, this parameter defines the PHY side DQ line
+      (including DQS/DQ/DM line) drive strength. Default value is 40.
+
+  rockchip,phy_ddr3_odt:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      When the DRAM type is DDR3, this parameter defines the PHY side ODT
+      strength. Default value is 240.
+
+  rockchip,lpddr3_odt_dis_freq:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      When the DRAM type is LPDDR3, this parameter defines then ODT disable
+      frequency in MHz (Mega Hz). When DDR frequency is less then
+      ddr3_odt_dis_freq, the ODT on the DRAM side and controller side are both
+      disabled.
+
+  rockchip,lpddr3_drv:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      When the DRAM type is LPDDR3, this parameter defines the DRAM side drive
+      strength in ohms. Default value is 34.
+
+  rockchip,lpddr3_odt:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      When the DRAM type is LPDDR3, this parameter defines the DRAM side ODT
+      strength in ohms. Default value is 240.
+
+  rockchip,phy_lpddr3_ca_drv:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      When the DRAM type is LPDDR3, this parameter defines the PHY side CA line
+      (including command line, address line and clock line) drive strength.
+      Default value is 40.
+
+  rockchip,phy_lpddr3_dq_drv:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      When the DRAM type is LPDDR3, this parameter defines the PHY side DQ line
+      (including DQS/DQ/DM line) drive strength. Default value is 40.
+
+  rockchip,phy_lpddr3_odt:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      When dram type is LPDDR3, this parameter define the phy side odt
+      strength, default value is 240.
+
+  rockchip,lpddr4_odt_dis_freq:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      When the DRAM type is LPDDR4, this parameter defines the ODT disable
+      frequency in MHz (Mega Hz). When the DDR frequency is less then
+      ddr3_odt_dis_freq, the ODT on the DRAM side and controller side are both
+      disabled.
+
+  rockchip,lpddr4_drv:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      When the DRAM type is LPDDR4, this parameter defines the DRAM side drive
+      strength in ohms. Default value is 60.
+
+  rockchip,lpddr4_dq_odt:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      When the DRAM type is LPDDR4, this parameter defines the DRAM side ODT on
+      DQS/DQ line strength in ohms. Default value is 40.
+
+  rockchip,lpddr4_ca_odt:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      When the DRAM type is LPDDR4, this parameter defines the DRAM side ODT on
+      CA line strength in ohms. Default value is 40.
+
+  rockchip,phy_lpddr4_ca_drv:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      When the DRAM type is LPDDR4, this parameter defines the PHY side CA line
+      (including command address line) drive strength. Default value is 40.
+
+  rockchip,phy_lpddr4_ck_cs_drv:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      When the DRAM type is LPDDR4, this parameter defines the PHY side clock
+      line and CS line drive strength. Default value is 80.
+
+  rockchip,phy_lpddr4_dq_drv:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      When the DRAM type is LPDDR4, this parameter defines the PHY side DQ line
+      (including DQS/DQ/DM line) drive strength. Default value is 80.
+
+  rockchip,phy_lpddr4_odt:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      When the DRAM type is LPDDR4, this parameter defines the PHY side ODT
+      strength. Default value is 60.
+
+required:
+  - compatible
+  - devfreq-events
+  - clocks
+  - clock-names
+  - operating-points-v2
+  - center-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rk3399-cru.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    memory-controller {
+      compatible = "rockchip,rk3399-dmc";
+      devfreq-events = <&dfi>;
+      rockchip,pmu = <&pmu>;
+      interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&cru SCLK_DDRC>;
+      clock-names = "dmc_clk";
+      operating-points-v2 = <&dmc_opp_table>;
+      center-supply = <&ppvar_centerlogic>;
+      rockchip,ddr3_speed_bin = <21>;
+      rockchip,pd_idle = <0x40>;
+      rockchip,sr_idle = <0x2>;
+      rockchip,sr_mc_gate_idle = <0x3>;
+      rockchip,srpd_lite_idle = <0x4>;
+      rockchip,standby_idle = <0x2000>;
+      rockchip,dram_dll_dis_freq = <300>;
+      rockchip,phy_dll_dis_freq = <125>;
+      rockchip,auto_pd_dis_freq = <666>;
+      rockchip,ddr3_odt_dis_freq = <333>;
+      rockchip,ddr3_drv = <40>;
+      rockchip,ddr3_odt = <120>;
+      rockchip,phy_ddr3_ca_drv = <40>;
+      rockchip,phy_ddr3_dq_drv = <40>;
+      rockchip,phy_ddr3_odt = <240>;
+      rockchip,lpddr3_odt_dis_freq = <333>;
+      rockchip,lpddr3_drv = <34>;
+      rockchip,lpddr3_odt = <240>;
+      rockchip,phy_lpddr3_ca_drv = <40>;
+      rockchip,phy_lpddr3_dq_drv = <40>;
+      rockchip,phy_lpddr3_odt = <240>;
+      rockchip,lpddr4_odt_dis_freq = <333>;
+      rockchip,lpddr4_drv = <60>;
+      rockchip,lpddr4_dq_odt = <40>;
+      rockchip,lpddr4_ca_odt = <40>;
+      rockchip,phy_lpddr4_ca_drv = <40>;
+      rockchip,phy_lpddr4_ck_cs_drv = <80>;
+      rockchip,phy_lpddr4_dq_drv = <80>;
+      rockchip,phy_lpddr4_odt = <60>;
+    };
-- 
2.35.1.616.g0bdcbb4464-goog

