Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4FC495CF5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 10:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349517AbiAUJjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 04:39:16 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:46012 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbiAUJjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 04:39:15 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 20L9crMD021567;
        Fri, 21 Jan 2022 03:38:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1642757934;
        bh=NGkWcYJhb8tmuQ79tTJSmE7wfgQ3vfZP7fid1WSgqtc=;
        h=From:To:CC:Subject:Date;
        b=wG7ol1vSSh92oQctNf9vdEJDWj87UgJNcXCuJTl8mOThFmF3db50b8TEHMOYWocl1
         /Ts1vqXZOiIoXz2YuNLjEptft3v8hkwVU3Xn9E8X9anrovv3Dxu99RNbc/mWWCxbHC
         DjTE2ol0sjZBCHWCly19RPWAWTvDh4Qq5xuJGqWA=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 20L9crDx022146
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Jan 2022 03:38:53 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 21
 Jan 2022 03:38:53 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 21 Jan 2022 03:38:53 -0600
Received: from pratyush-4F-325.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 20L9cndM048554;
        Fri, 21 Jan 2022 03:38:50 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
Subject: [PATCH v8 0/4] Rx mode support for Cadence DPHY
Date:   Fri, 21 Jan 2022 15:08:45 +0530
Message-ID: <20220121093849.3218092-1-p.yadav@ti.com>
X-Mailer: git-send-email 2.34.1
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

Changes in v8:
- Move lanes check to start of configure sequence.
- Change MODULE_LICENSE() to "GPL".

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
2.25.1

