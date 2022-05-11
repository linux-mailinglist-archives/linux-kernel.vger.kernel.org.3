Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9858B523123
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 13:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240055AbiEKLHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 07:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiEKLHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 07:07:21 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F0940E4D;
        Wed, 11 May 2022 04:07:19 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 24BB7GF3129910;
        Wed, 11 May 2022 06:07:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1652267236;
        bh=iV1SLFpjrGIYwgvCE4NMaMRZ+Eegx4IYkpwBtbRSIpY=;
        h=From:To:CC:Subject:Date;
        b=RJMTbH8vv45sfFZakEm0X/gQLi2J94t3t4NAkiOQ6gaU0scLmXlIcTM0zNcpSZSee
         wL0Hq5z5FaUiJmJ6IllaDQWte7rAaDQgtD8kbnm7pwVGdVyb0fYfA+heqP5ttqLQLp
         YvEWIc11PZpyDGvXgdtXSpLxH2B3moudl8GEewPY=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 24BB7GKA090418
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 May 2022 06:07:16 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 11
 May 2022 06:07:15 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 11 May 2022 06:07:15 -0500
Received: from keerthy.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 24BB7ChS001558;
        Wed, 11 May 2022 06:07:13 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <robh+dt@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <amitk@kernel.org>, <kristo@kernel.org>
CC:     <j-keerthy@ti.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 0/2] thermal: k3_j72xx_bandgap: Add the bandgap driver support
Date:   Wed, 11 May 2022 16:36:55 +0530
Message-ID: <20220511110657.16305-1-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

 .../bindings/thermal/ti,j72xx-thermal.yaml    |  64 ++
 drivers/thermal/Makefile                      |   2 +-
 drivers/thermal/k3_j72xx_bandgap.c            | 566 ++++++++++++++++++
 3 files changed, 631 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
 create mode 100644 drivers/thermal/k3_j72xx_bandgap.c

-- 
2.17.1

