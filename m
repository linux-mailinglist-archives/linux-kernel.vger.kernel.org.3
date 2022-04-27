Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D446C511190
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 08:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358289AbiD0GuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 02:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243581AbiD0GuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 02:50:11 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B48B14AF4C;
        Tue, 26 Apr 2022 23:47:00 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23R6kokt089870;
        Wed, 27 Apr 2022 01:46:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651042010;
        bh=KGi/ekF3SuZyRebWtuWFzY0RYXae9mHAvZOh5DGvamM=;
        h=From:To:CC:Subject:Date;
        b=JQ9Al7jVMmOkruPpifvVAHHMyR8Y0prEdlzQoVigK/8D3K2CSAAFULJ9T6eyyaS5C
         +krhxWpkKew83KBo0x5/NwRMtAJUBwBRd9BUkoyyrgwW//6xZe+3sKtBCKKAkyOi9e
         25QEfig06roHk6ym9Ys2jNpiNbzyzYJZAOWz1v4s=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23R6koUY021131
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Apr 2022 01:46:50 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 27
 Apr 2022 01:46:50 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 27 Apr 2022 01:46:50 -0500
Received: from keerthy.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23R6kjX6031550;
        Wed, 27 Apr 2022 01:46:46 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <robh+dt@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <amitk@kernel.org>, <kristo@kernel.org>,
        <vigneshr@ti.com>, <krzysztof.kozlowski@linaro.org>
CC:     <j-keerthy@ti.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 0/4] thermal: k3_j72xx_bandgap: Add the bandgap driver support
Date:   Wed, 27 Apr 2022 12:16:31 +0530
Message-ID: <20220427064635.24898-1-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add VTM thermal support. In the Voltage Thermal Management
Module(VTM), K3 J72XX supplies a voltage reference and a temperature
sensor feature that are gathered in the band gap voltage and
temperature sensor (VBGAPTS) module. The band gap provides current and
voltage reference for its internal circuits and other analog IP
blocks. The analog-to-digital converter (ADC) produces an output value
that is proportional to the silicon temperature.

Currently reading temperatures only is supported.  There are no
active/passive cooling agent supported.

J721e SoCs have errata i2128: https://www.ti.com/lit/pdf/sprz455

The series also incorporates workaround for Errata i2128.

Changes in v6:

  * Fixed the DT comments that were missed in v5.
  * Changed the offsets, bit masks to 2-D array.
  * Clean up

Changes in v5:

  * Simplified the computation of the table.
  * Removed unnecessary members in the structures.

Changes in v4:

  * Fixed compilation warning with W=1.

Changes in v3:

  * Removed static look up tables & added functions to dynamically generate them.

Changes in v2:

  * Fixed DT binding errors.

Keerthy (4):
  dt-bindings: thermal: k3-j72xx: Add VTM bindings documentation
  arm64: dts: ti: j721e: Add VTM node
  arm64: dts: ti: j7200: Add VTM node
  thermal: k3_j72xx_bandgap: Add the bandgap driver support

 .../bindings/thermal/ti,j72xx-thermal.yaml    |  64 ++
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      |   9 +
 arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi  |  47 ++
 arch/arm64/boot/dts/ti/k3-j7200.dtsi          |   2 +
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |   9 +
 arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi  |  75 +++
 arch/arm64/boot/dts/ti/k3-j721e.dtsi          |   2 +
 drivers/thermal/Makefile                      |   2 +-
 drivers/thermal/k3_j72xx_bandgap.c            | 566 ++++++++++++++++++
 9 files changed, 775 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
 create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi
 create mode 100644 drivers/thermal/k3_j72xx_bandgap.c

-- 
2.17.1

