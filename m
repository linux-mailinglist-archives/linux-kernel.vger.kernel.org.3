Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D64952A149
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 14:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237053AbiEQMOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 08:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbiEQMOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:14:47 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF3445ADF;
        Tue, 17 May 2022 05:14:46 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 24HCEesL085760;
        Tue, 17 May 2022 07:14:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1652789680;
        bh=snpMXomRtpDDePOTZho9J8n23UeRGv7WkTI+OKiZcq4=;
        h=From:To:CC:Subject:Date;
        b=xyYz/SbV77sfRCpvIte/vuJ1r/i5OW66XbpiLu2PWGde56EJE/yL+XGOtmKwylFmm
         x7F3blU+CqhiLh9lmlYSArKuzOWsnVPyTPUR3jVGAtjssq53ngOvK0/oHjJPvsJTZ5
         GY/z0qXAVtK1hHy2tmkBG+DJNF3fsasNP4aV3B+4=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 24HCEeg4060029
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 May 2022 07:14:40 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 17
 May 2022 07:14:39 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 17 May 2022 07:14:40 -0500
Received: from keerthy.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 24HCEZdI014354;
        Tue, 17 May 2022 07:14:36 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <amitk@kernel.org>, <kristo@kernel.org>
CC:     <j-keerthy@ti.com>, <rafael@kernel.org>,
        <linux-pm@vger.kernel.org>, <vigneshr@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 0/2] thermal: k3_j72xx_bandgap: Add the bandgap driver support
Date:   Tue, 17 May 2022 17:44:21 +0530
Message-ID: <20220517121423.8017-1-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Changes in v8:

  * Removed redundant items from compatible in the Documentation patch

Changes in v7:

  * Separated the DT patches from this series.
  * Fixed description of reg property in the DT documentation patch.

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
 

Keerthy (2):
  dt-bindings: thermal: k3-j72xx: Add VTM bindings documentation
  thermal: k3_j72xx_bandgap: Add the bandgap driver support

 .../bindings/thermal/ti,j72xx-thermal.yaml    |  63 ++
 drivers/thermal/Makefile                      |   2 +-
 drivers/thermal/k3_j72xx_bandgap.c            | 566 ++++++++++++++++++
 3 files changed, 630 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
 create mode 100644 drivers/thermal/k3_j72xx_bandgap.c

-- 
2.17.1

