Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD8A4C8A74
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 12:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbiCALRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 06:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiCALR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 06:17:26 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD929134D;
        Tue,  1 Mar 2022 03:16:44 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 221BGRb5031460;
        Tue, 1 Mar 2022 05:16:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1646133387;
        bh=hgoYOfg51sWvCO51C/Y8M5TUnxSuo7QxMthh6uJ+J5g=;
        h=From:To:CC:Subject:Date;
        b=fFkyQjA6w/dyas0gFnfdOIk815jUjNCel0ehfxUmgF/HLkuGbWwsEYMtNjF9ThPM3
         L8/MdCUpK41LMY3+zY4/Y2XEv17YWxg+MIwHsJfBBhD1FYEENCxcicxZwchyFHNhwg
         +Cb6zAy1kibaGjSWzwlZeaoYF60VQlSHIkxCr8Y0=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 221BGQBb017771
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Mar 2022 05:16:26 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 1
 Mar 2022 05:16:26 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 1 Mar 2022 05:16:26 -0600
Received: from pratyush-4F-325.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 221BGMAl116021;
        Tue, 1 Mar 2022 05:16:23 -0600
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
Subject: [PATCH v10 0/4] Rx mode support for Cadence DPHY
Date:   Tue, 1 Mar 2022 16:46:17 +0530
Message-ID: <20220301111621.2992275-1-p.yadav@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Changes in v10:
- Change SPDX license to GPL-2.0-only.
- Change copyright year to 2022.

Changes in v9:
- Use %ld instead of %d for printing PTR_ERR().

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
2.34.1

