Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4537547FC02
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 11:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbhL0K4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 05:56:13 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50644 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbhL0K4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 05:56:11 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BRAtoWf054700;
        Mon, 27 Dec 2021 04:55:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1640602550;
        bh=pDGeltek1WQaDMMmseYWv9CYCbGSEC5eBTDw5UBcrLo=;
        h=From:To:CC:Subject:Date;
        b=JyVkO0e43sKKpIPkbUryTrVIN3jLU59roB60H4vwcVGhKMbCQB+txyVwg+e3JGE1N
         A8T0r439Pky4x65hqIQtgun7BU2sc+2fE6wOWmMrrRei59+4AZW3AgU4wPdqLXSdkL
         8prGmKZLl5bFut1Ymwuu+nvfP5iUinYjGzOs50Kc=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BRAto6K103344
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Dec 2021 04:55:50 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 27
 Dec 2021 04:55:50 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 27 Dec 2021 04:55:50 -0600
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BRAtkVL029188;
        Mon, 27 Dec 2021 04:55:47 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
Subject: [PATCH v7 0/4] Rx mode support for Cadence DPHY
Date:   Mon, 27 Dec 2021 16:25:41 +0530
Message-ID: <20211227105545.4852-1-p.yadav@ti.com>
X-Mailer: git-send-email 2.33.1.835.ge9e5ba39a7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds support for Cadence DPHY Rx driver. It has been split
off from [0] to facilitate easier merging. I have still kept the version
number to maintain continuity with the previous patches. The earlier
version used the same binding for Tx and Rx DPHY. With the separate
driver, I have added a separate binding. But I am still keeping the old
conversion patch in this series since I have already done the work in
converting the binding to yaml, might as well get it merged.

Tested on TI's J721E with OV5640 sensor.

[0] https://patchwork.linuxtv.org/project/linux-media/list/?series=5526&state=%2A&archive=both

Changes in v7:
- Add spaces after { and before } in the bands table.
- Drop the wrapping around the for loop on cdns_dphy_rx_get_band_ctrl().
- Make cdns_dphy_rx_wait_for_bit() inline.
- Print an error message if registering PHY provider fails.

Changes in v6:
- Add a new binding for DPHY Rx.
- Move the DPHY Rx part to a separate driver.
- Drop Rx specific changes from the cdns,dphy.yaml binding. Keep those
  in cdns,dphy-rx.yaml

Changes in v5:
- Use the new cdns_dphy_info to specify PHY ops.
- Re-order include in alphabetical order.
- Make bands const.
- Drop num_bands.
- Make i, lanes unsigned.
- Drop the maximum check in cdns_dphy_rx_get_band_ctrl(). Let the loop
  complete and return -EOPNOTSUPP when we reach the end.
- Drop the "rate < bands[i].min_rate" check since the bands are in
  ascending order.
- Move data_lane_ctrl to start of function and make it static const.

Changes in v4:
- Drop the submode parts. Use a different compatible for the Rx ops.
- Make bands and num_bands static.
- Drop the submode patches. Use a different compatible for Rx mode DPHY
instead.

Changes in v3:
- Use a table to select the band.
- Use a table to poll the data lane ready bits.
- Multiply the DPHY HS clock rate by 2 to get the bit rate since the
  clock is DDR.
- Add Rob's R-by.

Changes in v2:
- Drop reg description.
- Add a description for each DPHY clock.
- Rename dphy@... to phy@... in example.
- Add Laurent's R-by.
- Re-order subject prefixes.
- Add power-domain to the example.
- Add Laurent's R-by.
- Re-order subject prefixes.

Pratyush Yadav (4):
  phy: cadence: Add Cadence D-PHY Rx driver
  phy: dt-bindings: Convert Cadence DPHY binding to YAML
  phy: dt-bindings: cdns,dphy: add power-domains property
  phy: dt-bindings: Add Cadence D-PHY Rx bindings

 .../devicetree/bindings/phy/cdns,dphy-rx.yaml |  42 +++
 .../devicetree/bindings/phy/cdns,dphy.txt     |  20 --
 .../devicetree/bindings/phy/cdns,dphy.yaml    |  56 ++++
 drivers/phy/cadence/Kconfig                   |   8 +
 drivers/phy/cadence/Makefile                  |   1 +
 drivers/phy/cadence/cdns-dphy-rx.c            | 255 ++++++++++++++++++
 6 files changed, 362 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy-rx.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy.yaml
 create mode 100644 drivers/phy/cadence/cdns-dphy-rx.c

-- 
2.33.1.835.ge9e5ba39a7

