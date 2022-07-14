Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048FC574E06
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239456AbiGNMoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238942AbiGNMoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:44:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C2D1FCC5;
        Thu, 14 Jul 2022 05:44:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADBA361F73;
        Thu, 14 Jul 2022 12:44:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071EFC341C8;
        Thu, 14 Jul 2022 12:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657802644;
        bh=QHwAddHD+o4YxO5fPQSFi9XnW6UkKE5vsIk/KhPzzLA=;
        h=From:To:Cc:Subject:Date:From;
        b=Q9uRBvGUgpgtTAHKFRXMYMkj30Mqice1ld3NADNMzlptVtV737ILZ/ImXwVblxgIA
         rv+PPI5HaOxNhDgU8LV9DgZv1JGDm8rqgPulMslpPSKjep/29tsS6MHDYstp1U64ck
         N8M00Go1CsENReeNJNFE5iTh5JalID16eslk42C+i/qwuZy+TqKeg3Jno7g2aydOJo
         WuhkYplxSlfFaz/E4I50p2NjORflqgWeZ+NwF1H5ZhWwsGoZbxsxk0QO6YjHBCS23E
         CtRZ1B6kcJWqDstrTApqhI7TeB6sAF1Qkk3wvtGOvOxen7UV2XUdGOBfh5w3KwZdl4
         ETCZxmLWrZ3Ow==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oByCO-0007D5-M9; Thu, 14 Jul 2022 14:44:08 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v3 00/30] phy: qcom,qmp: fix dt-bindings and deprecate lane suffix
Date:   Thu, 14 Jul 2022 14:43:03 +0200
Message-Id: <20220714124333.27643-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

This series clean up and fixes some issue with the current schema before
splitting it up in separate schemas for PCIe, UFS and USB and adding
missing parts like the child PHY provider nodes.

The MSM8996 PCIe PHY gets its own schema as this is the only non-combo
PHY that actually provides more than one PHY per IP block. Note that the
"lane" suffix is still unnecessary and misleading.

The final patches add support for the updated binding to the (recently
split up) PHY drivers. Included is also a related combo PHY cleanup.

Johan


Changes in v3
 - rebase on linux-next which has a new binding for IPQ8074
 - fix git-bisect breakage due to removal of an unused variable one
   patch too soon (Krzysztof)
 - replace one Fixes tag with reference in commit message (Krzysztof)
 - drop two redundant minItems (Krzysztof)
 - fix two Fixes tags that lacked the actual tag
 - add more ack and review tags from Krzysztof

Changes in v2
 - squash split + cleanup + example patches (Krzysztof)
 - deprecate clock-names instead of dropping suffix (Krzysztof)
 - deprecate reset-names instead of dropping suffix (Krzysztof)
 - flatten child reg if/then schemas (Krzysztof)
 - add back optional vddp-ref-clk to all bindings even though it likely
   only applies to MSM8996/98 UFS (Krzysztof)
 - add missing sc7180 schema to USB binding
 - misc clean ups
   - shorten or drop descriptions
   - drop quotes around $id and $schema (Krzysztof)
   - use maxItems with clock-output-names
   - combine two USB clock+reset schemas
 - add Reviewed-by/Acked-by tags


Johan Hovold (30):
  dt-bindings: phy: qcom,qmp: fix bogus clock-cells property
  dt-bindings: phy: qcom,qmp: sort compatible strings
  dt-bindings: phy: qcom,qmp: drop redundant descriptions
  dt-bindings: phy: qcom,qmp: fix child node description
  dt-bindings: phy: qcom,qmp: clean up descriptions
  dt-bindings: phy: qcom,qmp: clean up example
  dt-bindings: phy: qcom,qmp: drop child-node comment
  dt-bindings: phy: add qcom,msm8996-qmp-pcie-phy schema
  dt-bindings: phy: qcom,msm8996-qmp-pcie: add missing child node schema
  dt-bindings: phy: qcom,msm8996-qmp-pcie: deprecate PIPE clock names
  dt-bindings: phy: qcom,msm8996-qmp-pcie: deprecate reset names
  dt-bindings: phy: add QMP PCIe PHY schema
  dt-bindings: phy: qcom,qmp-pcie: add missing child node schema
  dt-bindings: phy: qcom,qmp-pcie: deprecate PIPE clock name
  dt-bindings: phy: add QMP UFS PHY schema
  dt-bindings: phy: qcom,qmp-ufs: add missing SM8450 clock
  dt-bindings: phy: qcom,qmp-ufs: add missing SM8150 power domain
  dt-bindings: phy: qcom,qmp-ufs: add missing child node schema
  dt-bindings: phy: add QMP USB PHY schema
  dt-bindings: phy: qcom,qmp-usb: add missing child node schema
  dt-bindings: phy: qcom,qmp-usb: deprecate PIPE clock name
  dt-bindings: phy: qcom,qmp-usb: add missing qcom,sc7180-qmp-usb3-phy
    schema
  dt-bindings: phy: qcom,qmp-usb3-dp: fix bogus clock-cells property
  dt-bindings: phy: qcom,qmp-usb3-dp: deprecate USB PIPE clock name
  phy: qcom-qmp-pcie: drop pipe clock lane suffix
  phy: qcom-qmp-combo: drop unused lane reset
  phy: qcom-qmp-combo: drop pipe clock lane suffix
  phy: qcom-qmp-pcie-msm8996: drop pipe clock lane suffix
  phy: qcom-qmp-pcie-msm8996: drop reset lane suffix
  phy: qcom-qmp-usb: drop pipe clock lane suffix

 .../phy/qcom,msm8996-qmp-pcie-phy.yaml        | 189 +++++++
 .../bindings/phy/qcom,qmp-pcie-phy.yaml       | 296 +++++++++++
 .../devicetree/bindings/phy/qcom,qmp-phy.yaml | 502 ------------------
 .../bindings/phy/qcom,qmp-ufs-phy.yaml        | 239 +++++++++
 .../bindings/phy/qcom,qmp-usb-phy.yaml        | 385 ++++++++++++++
 .../bindings/phy/qcom,qmp-usb3-dp-phy.yaml    |   8 +-
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c     |   6 +-
 .../phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c  |   8 +-
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      |   4 +-
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c       |   4 +-
 10 files changed, 1115 insertions(+), 526 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml

-- 
2.35.1

