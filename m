Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F52A4FDDFD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352388AbiDLLfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 07:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352820AbiDLLfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:35:23 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C4813F78;
        Tue, 12 Apr 2022 03:14:28 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23CAENQc014341;
        Tue, 12 Apr 2022 05:14:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649758463;
        bh=ipQpcgHXpfbJcelLyl6HL6bFtANq2NPuGwT1Zv7GR7s=;
        h=From:To:CC:Subject:Date;
        b=X41862wbNGiNWnnv9sSegH48kEYfCpdGYJpO4nmuVMJLowjNNvNSyjdvAQqRO8KM+
         Pa7P12vjmp799tGzDGmbxuqqhFPp4C0mfQCRYDA5WqfTme7dq0esZwkeaWGfEwhG4Q
         ASAkJsuknoD+gYPxH4jhAanGw9zofsLp3XB0lE3A=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23CAENLd037774
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Apr 2022 05:14:23 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 12
 Apr 2022 05:14:23 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 12 Apr 2022 05:14:23 -0500
Received: from keerthy.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23CAEJmN122452;
        Tue, 12 Apr 2022 05:14:20 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <robh+dt@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <amitk@kernel.org>, <kristo@kernel.org>
CC:     <j-keerthy@ti.com>, <linux-pm@vger.kernel.org>, <vigneshr@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 0/4] thermal: k3_j72xx_bandgap: Add the bandgap driver support
Date:   Tue, 12 Apr 2022 15:44:05 +0530
Message-ID: <20220412101409.7980-1-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
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

Daniel,

Apologies for the long silence on this!

- Keerthy

Changes in v5:

  * Fixed all the comments on v4.
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

 .../bindings/thermal/ti,j72xx-thermal.yaml    |  62 ++
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      |   9 +
 arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi  |  45 ++
 arch/arm64/boot/dts/ti/k3-j7200.dtsi          |   4 +
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |   9 +
 arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi  |  73 ++
 arch/arm64/boot/dts/ti/k3-j721e.dtsi          |   4 +
 drivers/thermal/Makefile                      |   2 +-
 drivers/thermal/k3_j72xx_bandgap.c            | 623 ++++++++++++++++++
 9 files changed, 830 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
 create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi
 create mode 100644 drivers/thermal/k3_j72xx_bandgap.c

-- 
2.17.1

