Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8163159A618
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 21:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351185AbiHSTIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 15:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351089AbiHSTI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 15:08:28 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EB532AA9;
        Fri, 19 Aug 2022 12:08:25 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27JJ7ZR4090751;
        Fri, 19 Aug 2022 14:07:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1660936055;
        bh=u9P/5Oz+onGjKnverq4DWRIAD3ByWF1SyU5y0haCG5c=;
        h=From:To:CC:Subject:Date;
        b=OU120/eiD1tFkJStijVybhM3IjU8LE4xI31Dz7a1nKhKJI8C3ScfNp41BCV21tjHm
         RS/iTeHk/aqCSLpGyCvyzTn4dcV9HPSQ6uh22Mg9tHeXV6gg2JH5sNra3eSZKrf8an
         Bpj9i6KKbd++ir6hozvaxL4mDIRLnIOrCzlDiIsA=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27JJ7ZVP123338
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Aug 2022 14:07:35 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 19
 Aug 2022 14:07:35 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 19 Aug 2022 14:07:35 -0500
Received: from LT5CD112GSQZ.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27JJ7T2s051038;
        Fri, 19 Aug 2022 14:07:30 -0500
From:   Apurva Nandan <a-nandan@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
CC:     Apurva Nandan <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>
Subject: [PATCH 0/3] Fix ti,sci-inta/intr and mmc dtbs_check warnings for TI K3 platforms
Date:   Sat, 20 Aug 2022 00:37:26 +0530
Message-ID: <20220819190729.32358-1-a-nandan@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes the following warnings common across all TI K3
platforms:

k3-j721e-common-proc-board.dtb: interrupt-controller@33d00000: Unevaluated properties are not allowed ('#interrupt-cells' was unexpected)
From schema: linux/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml

k3-j721s2-common-proc-board.dtb: mmc@4f80000: Unevaluated properties are not allowed ('dma-coherent' was unexpected)
From schema: linux/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml

k3-j721s2-common-proc-board.dtb: interrupt-controller@310e0000: Unevaluated properties are not allowed ('reg' was unexpected)
From schema: linux/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.yaml

Apurva Nandan (3):
  dt-bindings: irqchip: ti, sci-intr/inta: Fix warning
    '#interrupt-cells' was unexpected
  dt-bindings: mmc: Fix 'dma-coherent' was unexpected
  dt-bindings: interrupt-controller: Fix 'reg' was unexpected

 .../devicetree/bindings/interrupt-controller/ti,sci-inta.yaml  | 3 +++
 .../devicetree/bindings/interrupt-controller/ti,sci-intr.yaml  | 3 +++
 Documentation/devicetree/bindings/mmc/sdhci-am654.yaml         | 3 +++
 3 files changed, 9 insertions(+)

-- 
2.17.1

