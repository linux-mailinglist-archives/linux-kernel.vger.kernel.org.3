Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294F349EE83
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 00:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344106AbiA0XIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 18:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239780AbiA0XIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 18:08:32 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9922C061747
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 15:08:32 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id 128so4337872pfe.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 15:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZfhvZdFs5TObb5S4eewDrBMOltALFoSNTdZ7kqpym+w=;
        b=npEbe3pKve6T0stjeDsyP2hlb1l9yn6TxS2m1sa+3SXZ04FPuvMdfmzsTIJNsLSdxi
         t6w0LMTqu1IkNqXOqN4942uEw/i8X5WRoVPoa8nM8w6m7VUaLVyx4MINNlIxcDmTvOQd
         xGhmHBDLy9pUDKcWGknlP0bT+XZ24P1uaSnpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZfhvZdFs5TObb5S4eewDrBMOltALFoSNTdZ7kqpym+w=;
        b=OhRiz7bkKbwcFQ+zNbfZDhuxEWWDeGBSKbp61bWp/8e3I+Doa4fUICko/+IcggN4wZ
         U3OASP6XTI8mHReEtMq+o8/VCYuJFUuQ1VRQV4lfqE6iPX6/Ohgsl43WNUIvSCgSO3ot
         T982WPC1KHgZENSqxFnzQXEtxRAhagdELWAtuwZ6XchxTudAB+BY5D1mycnTpFQnebyJ
         lpfEEklX0yXCGm9TEPhLHYe9fgYvlX13lcHDAHehjo5zVarNWgzTAi6Z2/1fYWTJTTiZ
         dBA35tBscZEMxppvQJfHg8dt0HtE04hsM4hZSp52ESa+s+o63ZXHsWdhrNNqc5VYsZPW
         MgSg==
X-Gm-Message-State: AOAM531Ku8TjhHJEqQGdr/rD3UQexIOXINZvzlKJWw6g+vyVuIPwi76g
        zzXVHtRA9f+PoIairXNAckXNPg==
X-Google-Smtp-Source: ABdhPJzWfp15WA+agQIDXTl8cUPnuwXcqyV2WF4QJ4q1xpLKzz6EakugAmhaPwx/3rCjwXSRJkmH8Q==
X-Received: by 2002:a05:6a00:b42:: with SMTP id p2mr5377425pfo.50.1643324912230;
        Thu, 27 Jan 2022 15:08:32 -0800 (PST)
Received: from localhost ([2620:15c:202:201:723d:38a9:9e7f:3435])
        by smtp.gmail.com with UTF8SMTPSA id r14sm339902pjo.39.2022.01.27.15.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 15:08:31 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Lin Huang <hl@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org,
        Derek Basehore <dbasehore@chromium.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 04/15] dt-bindings: devfreq: rk3399_dmc: Specify idle params in nanoseconds
Date:   Thu, 27 Jan 2022 15:07:15 -0800
Message-Id: <20220127150615.v2.4.I01c6a2b2db578136686b42d463af985cfdff2fd9@changeid>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220127230727.3369358-1-briannorris@chromium.org>
References: <20220127230727.3369358-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's inefficient to use the same number of cycles for all OPPs, since
lower frequencies make for longer idle times. Let's specify the idle
time instead, so software can pick the optimal number of cycles on its
own.

NB: these bindings aren't used anywhere yet.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 - New patch

 .../bindings/devfreq/rk3399_dmc.yaml          | 50 +++++++++++++++++--
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml
index 8bb778df92ae..8786b7fa9b28 100644
--- a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml
+++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml
@@ -55,42 +55,52 @@ properties:
       being used.
 
   rockchip,pd_idle:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       Configure the PD_IDLE value. Defines the power-down idle period in which
       memories are placed into power-down mode if bus is idle for PD_IDLE DFI
       clock cycles.
+      See also rockchip,pd-idle-ns.
 
   rockchip,sr_idle:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       Configure the SR_IDLE value. Defines the self-refresh idle period in
       which memories are placed into self-refresh mode if bus is idle for
       SR_IDLE * 1024 DFI clock cycles (DFI clocks freq is half of DRAM clock).
       Default value is "0".
+      See also rockchip,sr-idle-ns.
 
   rockchip,sr_mc_gate_idle:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       Defines the memory self-refresh and controller clock gating idle period.
       Memories are placed into self-refresh mode and memory controller clock
       arg gating started if bus is idle for sr_mc_gate_idle*1024 DFI clock
       cycles.
+      See also rockchip,sr-mc-gate-idle-ns.
 
   rockchip,srpd_lite_idle:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       Defines the self-refresh power down idle period in which memories are
       placed into self-refresh power down mode if bus is idle for
       srpd_lite_idle * 1024 DFI clock cycles. This parameter is for LPDDR4
       only.
+      See also rockchip,srpd-lite-idle-ns.
 
   rockchip,standby_idle:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       Defines the standby idle period in which memories are placed into
       self-refresh mode. The controller, pi, PHY and DRAM clock will be gated
       if bus is idle for standby_idle * DFI clock cycles.
+      See also rockchip,standby-idle-ns.
 
   rockchip,dram_dll_dis_freq:
     deprecated: true
@@ -259,6 +269,36 @@ properties:
       When the DRAM type is LPDDR4, this parameter defines the PHY side ODT
       strength. Default value is 60.
 
+  rockchip,pd-idle-ns:
+    description:
+      Configure the PD_IDLE value in nanoseconds. Defines the power-down idle
+      period in which memories are placed into power-down mode if bus is idle
+      for PD_IDLE nanoseconds.
+
+  rockchip,sr-idle-ns:
+    description:
+      Configure the SR_IDLE value in nanoseconds. Defines the self-refresh idle
+      period in which memories are placed into self-refresh mode if bus is idle
+      for SR_IDLE nanoseconds. Default value is "0".
+
+  rockchip,sr-mc-gate-idle-ns:
+    description:
+      Defines the memory self-refresh and controller clock gating idle period in nanoseconds.
+      Memories are placed into self-refresh mode and memory controller clock
+      arg gating started if bus is idle for sr_mc_gate_idle nanoseconds.
+
+  rockchip,srpd-lite-idle-ns:
+    description:
+      Defines the self-refresh power down idle period in which memories are
+      placed into self-refresh power down mode if bus is idle for
+      srpd_lite_idle nanoseonds. This parameter is for LPDDR4 only.
+
+  rockchip,standby-idle-ns:
+    description:
+      Defines the standby idle period in which memories are placed into
+      self-refresh mode. The controller, pi, PHY and DRAM clock will be gated
+      if bus is idle for standby_idle nanoseconds.
+
 required:
   - compatible
   - devfreq-events
@@ -282,11 +322,11 @@ examples:
       clock-names = "dmc_clk";
       operating-points-v2 = <&dmc_opp_table>;
       center-supply = <&ppvar_centerlogic>;
-      rockchip,pd_idle = <0x40>;
-      rockchip,sr_idle = <0x2>;
-      rockchip,sr_mc_gate_idle = <0x3>;
-      rockchip,srpd_lite_idle = <0x4>;
-      rockchip,standby_idle = <0x2000>;
+      rockchip,pd-idle-ns = <160>;
+      rockchip,sr-idle-ns = <10240>;
+      rockchip,sr-mc-gate-idle-ns = <40960>;
+      rockchip,srpd-lite-idle-ns = <61440>;
+      rockchip,standby-idle-ns = <81920>;
       rockchip,ddr3_odt_dis_freq = <333000000>;
       rockchip,lpddr3_odt_dis_freq = <333000000>;
       rockchip,lpddr4_odt_dis_freq = <333000000>;
-- 
2.35.0.rc0.227.g00780c9af4-goog

