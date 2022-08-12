Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBD2590A9C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 05:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236830AbiHLDXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 23:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236947AbiHLDXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 23:23:10 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EABA3D47;
        Thu, 11 Aug 2022 20:23:05 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27C3Mu0C119184;
        Thu, 11 Aug 2022 22:22:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1660274576;
        bh=lNW3BqQa6fQK97rdDGIYSbO0YwDXxe23ONuU/uOYiSs=;
        h=From:To:CC:Subject:Date;
        b=Dl8fpbpaP/FIFBxXmmERg/kRzmvqM0r6IDj75DA78fwOuJuhcXqrqlNONy0I9vo3W
         1gtY563s/fc2QHAU44hzkXKPndRN0LSn6ixfif8JaFA2/SUxdTxDXmEmMfV4gHL2uR
         eEgQ8yLkJbeowdXm4fT6IGKEtVODZB/JGpvH9nKY=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27C3MuNE013572
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Aug 2022 22:22:56 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 11
 Aug 2022 22:22:55 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 11 Aug 2022 22:22:55 -0500
Received: from ubuntu.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27C3MkOq096105;
        Thu, 11 Aug 2022 22:22:48 -0500
From:   Matt Ranostay <mranostay@ti.com>
To:     <nm@ti.com>, <j-keerthy@ti.com>, <lee@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Matt Ranostay <mranostay@ti.com>
Subject: [PATCH v2 0/6] mfd: add tps6594x support for Jacinto platform
Date:   Thu, 11 Aug 2022 20:22:36 -0700
Message-ID: <20220812032242.564026-1-mranostay@ti.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset series adds support for the TPS6594x PMIC along with
initial support for its RTC, and poweroff sequence.

Additionally, add usage of the PMIC for the various Jacintor platforms
devicetree's.

Changes from v1:
* Corrected devicetree documentation issues found with dt-schema
* Changed MFD references to PMIC reflecting the more valid use of driver
* Cleaning up variable naming and ordering within functions
* Adding gpio + regulator cells for upcoming driver support 
* Switching from .probe to .probe_new API
* Revising comments within drivers to be more concise
* Adding device tree nodes for j721s2 and j721e platforms

Keerthy (3):
  MFD: TPS6594x: Add new PMIC device driver for TPS6594x chips
  rtc: rtc-tps6594x: Add support for TPS6594X PMIC RTC
  arm64: dts: ti: k3-j7200-common-proc-board: Add TPS6594x PMIC node

Matt Ranostay (3):
  Documentation: tps6594x: Add DT bindings for the TPS6594x PMIC
  arm64: dts: ti: k3-j721e-common-proc-board: Add TPS6594x PMIC node
  arm64: dts: ti: k3-j721s2-common-proc-board: Add TPS6594x PMIC node

 .../devicetree/bindings/mfd/ti,tps6594x.yaml  |  56 ++++++
 .../dts/ti/k3-j7200-common-proc-board.dts     |  16 ++
 .../dts/ti/k3-j721e-common-proc-board.dts     |  16 ++
 .../dts/ti/k3-j721s2-common-proc-board.dts    |  16 ++
 drivers/mfd/Kconfig                           |  14 ++
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/tps6594x.c                        | 121 ++++++++++++
 drivers/rtc/Kconfig                           |  10 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-tps6594x.c                    | 181 ++++++++++++++++++
 include/linux/mfd/tps6594x.h                  |  84 ++++++++
 11 files changed, 516 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,tps6594x.yaml
 create mode 100644 drivers/mfd/tps6594x.c
 create mode 100644 drivers/rtc/rtc-tps6594x.c
 create mode 100644 include/linux/mfd/tps6594x.h

-- 
2.36.1

