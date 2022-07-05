Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C2656668F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiGEJtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiGEJtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:49:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54186266B;
        Tue,  5 Jul 2022 02:49:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C855561912;
        Tue,  5 Jul 2022 09:49:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29831C341D1;
        Tue,  5 Jul 2022 09:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657014542;
        bh=PRWF0dxD1eXxpPCxf2RrBgIGlcN0HFetPfQNjqW6hVY=;
        h=From:To:Cc:Subject:Date:From;
        b=AID+pfdcyTF9puV9smoekOeujTxZItnvAW8tiIHIpKy5zpbSoSh1TGtKgyuvokq38
         muyKEZmytORg7XJujwIQ/IUayRyPB0vHyoiBjx64I+1Rap9UeZSmPuC9PSt5vzUm6M
         70b5MSa1CDT4b+2YovO8NscM0UQRgbstOqh+kdYKTsC8yt8gh3oNdpY/y70lFQmv6w
         gxP8ZX6+xn/iPtbXKu3JGY8Uav19ohF7IRYKB6YhlodehgqLvX40yHWGdwJwwgZi3v
         vhTGeWCitD/hQ81aZ1pp32+HX7W3jPXTrYSGl083FaDvyrkHVVUTLPnzAz4OfyGTFk
         +CkS4e3PVUc0A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o8fB0-0004Wr-GB; Tue, 05 Jul 2022 11:49:02 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 00/43] phy: qcom,qmp: fix dt-bindings and deprecate lane suffix
Date:   Tue,  5 Jul 2022 11:41:56 +0200
Message-Id: <20220705094239.17174-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When adding support for SC8280XP to the QMP PHY driver I noticed that
the PHY provider child node was not described by the current DT schema.

The SC8280XP PHYs also need a second fixed-divider PIPE clock
("pipediv2") and I didn't want to have to add a bogus "lane" suffix to
the clock name just to match the current "pipe0" name so I decided to
deprecate the unnecessary suffix in the current binding instead.

To be able to add the missing child-node schema and handle device
specifics like additional PIPE clocks, it quickly became obvious that
the binding needs to be split up.

This series fixes some issue with the current schema before splitting
it up in separate schemas for PCIe, UFS and USB, which are then cleaned
up further before adding missing parts like the child PHY provider
nodes and examples.

The MSM8996 PCIe PHY gets its own schema as this is the only non-combo
PHY that actually provides more than one PHY per IP block. Note that the
"lane" suffix is still unnecessary and misleading.

The final patches adds support for the new resource names to the
(recently split up) PHY drivers. Included is also a related combo PHY
cleanup.

I'll post a separate series with related DTS fixes caught while
developing this series.

Johan


Johan Hovold (43):
  dt-bindings: phy: qcom,qmp: fix bogus clock-cells property
  dt-bindings: phy: qcom,qmp: sort compatible strings
  dt-bindings: phy: qcom,qmp: clean up descriptions
  dt-bindings: phy: qcom,qmp: clean up example
  dt-bindings: phy: qcom,qmp: drop child-node comment
  dt-bindings: phy: qcom,qmp: split out msm8996-qmp-pcie-phy
  dt-bindings: phy: qcom,msm8996-qmp-pcie: clean up constraints
  dt-bindings: phy: qcom,msm8996-qmp-pcie: add missing child node schema
  dt-bindings: phy: qcom,msm8996-qmp-pcie: add example node
  dt-bindings: phy: qcom,msm8996-qmp-pcie: deprecate PIPE clock names
  dt-bindings: phy: qcom,msm8996-qmp-pcie: deprecate reset names
  dt-bindings: phy: qcom,qmp: split out PCIe PHY binding
  dt-bindings: phy: qcom,qmp-pcie: clean up register constraints
  dt-bindings: phy: qcom,qmp-pcie: clean up clock constraints
  dt-bindings: phy: qcom,qmp-pcie: clean up reset constraints
  dt-bindings: phy: qcom,qmp-pcie: drop unused vddp-ref-clk supply
  dt-bindings: phy: qcom,qmp-pcie: add missing child node schema
  dt-bindings: phy: qcom,qmp-pcie: add example node
  dt-bindings: phy: qcom,qmp-pcie: deprecate PIPE clock name
  dt-bindings: phy: qcom,qmp: split out UFS PHY binding
  dt-bindings: phy: qcom,qmp-ufs: clean up supplies
  dt-bindings: phy: qcom,qmp-ufs: clean up reset providers
  dt-bindings: phy: qcom,qmp-ufs: clean up clock constraints
  dt-bindings: phy: qcom,qmp-ufs: clean up register constraints
  dt-bindings: phy: qcom,qmp-ufs: add missing SM8450 clock
  dt-bindings: phy: qcom,qmp-ufs: add missing SM8150 power domain
  dt-bindings: phy: qcom,qmp-ufs: add missing child node schema
  dt-bindings: phy: qcom,qmp-ufs: add example node
  dt-bindings: phy: qcom,qmp: split out USB binding
  dt-bindings: phy: qcom,qmp-usb: clean up clock constraints
  dt-bindings: phy: qcom,qmp-usb: clean up supplies
  dt-bindings: phy: qcom,qmp-usb: drop unused vddp-ref-clk supply
  dt-bindings: phy: qcom,qmp-usb: clean up reset providers
  dt-bindings: phy: qcom,qmp-usb: add missing child node schema
  dt-bindings: phy: qcom,qmp-usb: deprecate PIPE clock name
  dt-bindings: phy: qcom,qmp-usb3-dp: fix bogus clock-cells property
  dt-bindings: phy: qcom,qmp-usb3-dp: deprecate USB PIPE clock name
  phy: qcom-qmp-pcie: drop pipe clock lane suffix
  phy: qcom-qmp-combo: drop unused lane reset
  phy: qcom-qmp-combo: drop pipe clock lane suffix
  phy: qcom-qmp-pcie-msm8996: drop pipe clock lane suffix
  phy: qcom-qmp-pcie-msm8996: drop reset lane suffix
  phy: qcom-qmp-usb: drop pipe clock lane suffix

 .../phy/qcom,msm8996-qmp-pcie-phy.yaml        | 212 ++++++++
 .../bindings/phy/qcom,qmp-pcie-phy.yaml       | 309 +++++++++++
 .../devicetree/bindings/phy/qcom,qmp-phy.yaml | 500 ------------------
 .../bindings/phy/qcom,qmp-ufs-phy.yaml        | 249 +++++++++
 .../bindings/phy/qcom,qmp-usb-phy.yaml        | 417 +++++++++++++++
 .../bindings/phy/qcom,qmp-usb3-dp-phy.yaml    |  15 +-
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c     |  10 +-
 .../phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c  |  17 +-
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      |   8 +-
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c       |   8 +-
 10 files changed, 1224 insertions(+), 521 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml

-- 
2.35.1

