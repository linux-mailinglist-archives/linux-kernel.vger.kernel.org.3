Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07935A63FD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 14:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiH3Mx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 08:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiH3MxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:53:23 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F25FC332;
        Tue, 30 Aug 2022 05:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661864002; x=1693400002;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fdjX5tbqzbcZLdj3QtoTUweKd5AlbElmyy/Hw5S6d5w=;
  b=mI4QYnCTqD0YG1J6OzOawn8OjfS2Lv+z4ADjTru8CcMSaKE/AbiZBcPy
   eJrqLVHW2FRN+mDclSWpRPqOqLeOEmGK+3a850JDZjMRUCHCmGQlpecve
   OVdPN/WeCJdLOzpHf361yv93BrWTVkg+JbFDwoThPT9ML8eF4VrCh1f2/
   N6ZQLh2z6C6BJ/JlCLFh0tHAFXkDvY6Yw4LfS0wV/PuTiv/4YBzFe9t7O
   vj6GTywka/VIes0kQAoHOfSPr6BHFi6QjBEIhaOKV3Y/LwnBmI1nq34Yk
   sgc/np7meDmIjMwU3PCksdxICLUv8kYUNMn8nPI1VwvlzxIQJTxEqA3Sd
   w==;
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="188645501"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Aug 2022 05:53:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 30 Aug 2022 05:53:21 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Tue, 30 Aug 2022 05:53:18 -0700
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
        "Rob Herring" <robh@kernel.org>
Subject: [PATCH v4 02/13] dt-bindings: clk: microchip: mpfs: add reset controller support
Date:   Tue, 30 Aug 2022 13:52:39 +0100
Message-ID: <20220830125249.2373416-2-conor.dooley@microchip.com>
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

The "peripheral" devices on PolarFire SoC can be put into reset, so
update the device tree binding to reflect the presence of a reset
controller.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Daire McNamara <daire.mcnamara@microchip.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/clock/microchip,mpfs.yaml          | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/microchip,mpfs.yaml b/Documentation/devicetree/bindings/clock/microchip,mpfs.yaml
index 016a4f378b9b..1d0b6a4fda42 100644
--- a/Documentation/devicetree/bindings/clock/microchip,mpfs.yaml
+++ b/Documentation/devicetree/bindings/clock/microchip,mpfs.yaml
@@ -40,8 +40,21 @@ properties:
     const: 1
     description: |
       The clock consumer should specify the desired clock by having the clock
-      ID in its "clocks" phandle cell. See include/dt-bindings/clock/microchip,mpfs-clock.h
-      for the full list of PolarFire clock IDs.
+      ID in its "clocks" phandle cell.
+      See include/dt-bindings/clock/microchip,mpfs-clock.h for the full list of
+      PolarFire clock IDs.
+
+  resets:
+    maxItems: 1
+
+  '#reset-cells':
+    description:
+      The AHB/AXI peripherals on the PolarFire SoC have reset support, so from
+      CLK_ENVM to CLK_CFM. The reset consumer should specify the desired
+      peripheral via the clock ID in its "resets" phandle cell.
+      See include/dt-bindings/clock/microchip,mpfs-clock.h for the full list of
+      PolarFire clock IDs.
+    const: 1
 
 required:
   - compatible
-- 
2.36.1

