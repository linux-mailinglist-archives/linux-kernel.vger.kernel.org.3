Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0720E4D0C80
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 01:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344043AbiCHALS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 19:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344003AbiCHALJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 19:11:09 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAC13700E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 16:10:13 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id p3-20020a17090a680300b001bbfb9d760eso695634pjj.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 16:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9DsPzlIyhwiKh9kSwdMVXp8vwwz1bE2ouL+bXEUROQw=;
        b=ObutdUvDeNU9/Wlev57ZphfiNYkPKdRx0Vk7ljvt9DfEErSAQZwkpEGHFPFRsni0wS
         4k9/ucgGDth6GriLixSizUhHBkXCLW3Alnw8YCQpfF46Z+A5rwUDjfHa1fiIgCiCiwYo
         4bDmMfLwOXftGl+n/XDCYGcyY4zJJEYliEsQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9DsPzlIyhwiKh9kSwdMVXp8vwwz1bE2ouL+bXEUROQw=;
        b=VbxIIErnzAEN1I2wNowCn9mW9qldYdRefEUdF4TGoxwr0SV1RO7bIaZ2gm4ZwRBKVo
         fVcHe9wifN8W2FkM0dyLEXamtAbNeB8rFIGgzi6WF2Yu+kHZh1ailQgMMqCnUzaM/ILp
         9bay5eWEzMIDqNe6gzzR+jsQEo4zfoTSm8UvACUeB1PLqjWXatG0xHIBudzNTtTgMw+M
         uIyd4n5ZXDqFLZc0U1alt+FAg+dXWh7ur1joe+zI98M8SDY9jP9nUlEEIueB5bzzG6eg
         YEU98iaJr4ThMUAT0aF6ETywftlGCUMRRgCMIRN9VOM4i2t1W6JTXKf+UD4tLRWygocw
         oILQ==
X-Gm-Message-State: AOAM531PHnM6ivy01gMLi6VsEzWq8dCIwpojzVzn4yg3JcttQ9UrHokh
        qPM8uRMK0CTScgB25dgDF/k5Yg==
X-Google-Smtp-Source: ABdhPJx4ooAkyw+rxawtckEW2qNYCpse5tIF/afponFdY+RwJ3scPkG7xqLG4qC/Ubu7uWbU7zfEuA==
X-Received: by 2002:a17:90b:788:b0:1bf:41d:a9ff with SMTP id l8-20020a17090b078800b001bf041da9ffmr1650623pjz.116.1646698213306;
        Mon, 07 Mar 2022 16:10:13 -0800 (PST)
Received: from localhost ([2620:15c:202:201:e551:44dc:2842:57f1])
        by smtp.gmail.com with UTF8SMTPSA id lb4-20020a17090b4a4400b001b9b20eabc4sm477883pjb.5.2022.03.07.16.10.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 16:10:12 -0800 (PST)
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
        Brian Norris <briannorris@chromium.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 04/15] dt-bindings: devfreq: rk3399_dmc: Specify idle params in nanoseconds
Date:   Mon,  7 Mar 2022 16:09:34 -0800
Message-Id: <20220307160918.v3.4.I01c6a2b2db578136686b42d463af985cfdff2fd9@changeid>
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

It's inefficient to use the same number of cycles for all OPPs, since
lower frequencies make for longer idle times. Let's specify the idle
time instead, so software can pick the optimal number of cycles on its
own.

NB: these bindings aren't used anywhere yet.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v3:
 * Add Reviewed-by

Changes in v2:
 * New patch

 .../bindings/devfreq/rk3399_dmc.yaml          | 50 +++++++++++++++++--
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml
index 2904ae4115f3..6a33a7b44741 100644
--- a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml
+++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml
@@ -56,42 +56,52 @@ properties:
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
@@ -260,6 +270,36 @@ properties:
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
@@ -283,11 +323,11 @@ examples:
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
2.35.1.616.g0bdcbb4464-goog

