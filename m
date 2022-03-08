Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D264D2108
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 20:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349913AbiCHTKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 14:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236771AbiCHTKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 14:10:16 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1CB4927C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 11:09:19 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id g19so180942pfc.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 11:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aQBXnYV77u8nGKn/MzXkBt16/3DAVGbxcTfsybprNzY=;
        b=mCBxWxx6dpCtH8y2eYwy4bA86huPX44nffjFiMfYcPzNPGzEFjY5/isggSYFRHymfA
         SuD4SuNPjNsJ0gkJYzcGgdErOmEBtQK42eAtTXzl0CzUbbb3DU6mP7Wjcl3SNwJ+5LLY
         wSdrD/ZIqmJZP1nklPmE9Wmp+ikm+Mt4f1pKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aQBXnYV77u8nGKn/MzXkBt16/3DAVGbxcTfsybprNzY=;
        b=u74E2ieEddWHT5mfNi8YZGr8rZ67jDXQtgSYhBj1Zr/5lhraGl7fEXHouPbANBYfd2
         Qm9YS3vFR+PqInwMBl5Di/9RqhcDzkXzY/e1l84w3I2P7ig/WzWdYIO4FR7uZKPjRhBq
         PbIRy2AdjjvrwEs26/8BCtuCYIR2T3OXrZeZ0mGS+RyAnFY8HqzRKh5QxM3CSjfH1K9Z
         vacJrXSItmQ/KcTukoinSEi5GbM+Ijpxnuujj9A/JhrntpCpAX6TqHu9NCtyp2pFLsgd
         2SmnACsTXwtrl9kGlA0PcaJtueYJtv3eYS8VxU8x/sxCLxg7Nph3Inv2psef39pu/Ats
         Od4Q==
X-Gm-Message-State: AOAM533RSQ7G5D1T9wdhALdMuXt+E+1LXQIF9qSTlZH+4JquUXArW1Vz
        +WB9/rnTernoEr61azCreZGBfA==
X-Google-Smtp-Source: ABdhPJy2G8NKjzBfMuq+zr/kLWgKLJwymWEQdXwGWRkQT7dOHPkeLllLbPtznYqzy9tlAdivDeqCgA==
X-Received: by 2002:a05:6a00:1490:b0:4f6:f2bd:1dd3 with SMTP id v16-20020a056a00149000b004f6f2bd1dd3mr13949465pfu.58.1646766558818;
        Tue, 08 Mar 2022 11:09:18 -0800 (PST)
Received: from localhost ([2620:15c:202:201:b3e3:a188:cbfc:3a0e])
        by smtp.gmail.com with UTF8SMTPSA id p186-20020a62d0c3000000b004f6fa49c4b9sm9110384pfg.218.2022.03.08.11.09.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 11:09:18 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Derek Basehore <dbasehore@chromium.org>,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, Lin Huang <hl@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v4 04/15] dt-bindings: devfreq: rk3399_dmc: Specify idle params in nanoseconds
Date:   Tue,  8 Mar 2022 11:08:50 -0800
Message-Id: <20220308110825.v4.4.I01c6a2b2db578136686b42d463af985cfdff2fd9@changeid>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
In-Reply-To: <20220308190901.3144566-1-briannorris@chromium.org>
References: <20220308190901.3144566-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---

Changes in v4:
 * Use 'default:'

Changes in v3:
 * Add Reviewed-by

Changes in v2:
 * New patch

 .../rockchip,rk3399-dmc.yaml                  | 51 +++++++++++++++++--
 1 file changed, 46 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/rockchip,rk3399-dmc.yaml b/Documentation/devicetree/bindings/memory-controllers/rockchip,rk3399-dmc.yaml
index 96efb23cfc0f..5228a32b5962 100644
--- a/Documentation/devicetree/bindings/memory-controllers/rockchip,rk3399-dmc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/rockchip,rk3399-dmc.yaml
@@ -54,42 +54,52 @@ properties:
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
+      See also rockchip,sr-idle-ns.
     default: 0
 
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
@@ -272,6 +282,37 @@ properties:
       strength.
     default: 60
 
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
+      for SR_IDLE nanoseconds.
+    default: 0
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
@@ -295,11 +336,11 @@ examples:
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

