Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140F8481ADB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 09:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237938AbhL3Isi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 03:48:38 -0500
Received: from lucky1.263xmail.com ([211.157.147.133]:52410 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbhL3Ish (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 03:48:37 -0500
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id EFD68D845D;
        Thu, 30 Dec 2021 16:48:28 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P12624T140277015766784S1640854098676227_;
        Thu, 30 Dec 2021 16:48:28 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: yifeng.zhao@rock-chips.com
X-SENDER: zyf@rock-chips.com
X-LOGIN-NAME: yifeng.zhao@rock-chips.com
X-FST-TO: heiko@sntech.de
X-RCPT-COUNT: 17
X-LOCAL-RCPT-COUNT: 4
X-MUTI-DOMAIN-COUNT: 0
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-UNIQUE-TAG: <fc6286ea7d86f55f6b48c5286f6faf08>
X-System-Flag: 0
From:   Yifeng Zhao <yifeng.zhao@rock-chips.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, jbx6244@gmail.com, devicetree@vger.kernel.org,
        vkoul@kernel.org, michael.riesch@wolfvision.net,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, kishon@ti.com,
        p.zabel@pengutronix.de, cl@rock-chips.com,
        kever.yang@rock-chips.com, lee.jones@linaro.org,
        wulf@rock-chips.com, Yifeng Zhao <yifeng.zhao@rock-chips.com>
Subject: [PATCH v7 0/4] Add Naneng combo PHY support for RK3568
Date:   Thu, 30 Dec 2021 16:48:11 +0800
Message-Id: <20211230084815.28110-1-yifeng.zhao@rock-chips.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This phy can be used as pcie-phy, usb3-phy, sata-phy or sgmii-phy.

Changes in v7:
- remove u3otg0_port_en, u3otg1_port_en and pipe_sgmii_mac_sel
- rename regs

Changes in v5:
- modify description for ssc and ext-refclk
- remove apb reset
- add rockchip_combphy_updatel()
- restyle

Changes in v4:
- restyle
- remove some minItems
- add more properties
- remove reset-names
- move #phy-cells
- add rockchip,rk3568-pipe-grf
- add rockchip,rk3568-pipe-phy-grf
- add devm_reset_control_array_get()
- remove clk structure
- change refclk DT parse
- change dev_err message
- add dot to phrase
- add ext_refclk variable
- add enable_ssc variable
- rename rockchip_combphy_param_write
- remove param_read
- replace rockchip-naneng-combphy driver name
- rename node name

Changes in v3:
- Using api devm_reset_control_get_optional_exclusive and dev_err_probe.
- Remove apb_rst.
- Redefine registers address.
- Move pipe_phy_grf0 to rk3568.dtsi

Changes in v2:
- Fix dtschema/dtc warnings/errors
- Using api devm_platform_get_and_ioremap_resource.
- Modify rockchip_combphy_set_Mode.
- Add some PHY registers definition.
- Move phy0 to rk3568.dtsi

Johan Jonker (1):
  dt-bindings: mfd: syscon: add naneng combo phy register compatible

Yifeng Zhao (3):
  dt-bindings: phy: rockchip: Add Naneng combo PHY bindings
  phy: rockchip: add naneng combo phy for RK3568
  arm64: dts: rockchip: add naneng combo phy nodes for rk3568

 .../devicetree/bindings/mfd/syscon.yaml       |   2 +
 .../phy/phy-rockchip-naneng-combphy.yaml      | 109 ++++
 arch/arm64/boot/dts/rockchip/rk3568.dtsi      |  21 +
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      |  47 ++
 drivers/phy/rockchip/Kconfig                  |   8 +
 drivers/phy/rockchip/Makefile                 |   1 +
 .../rockchip/phy-rockchip-naneng-combphy.c    | 589 ++++++++++++++++++
 7 files changed, 777 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
 create mode 100644 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c

-- 
2.17.1



