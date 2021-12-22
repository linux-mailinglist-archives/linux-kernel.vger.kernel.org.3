Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7AB47D8BB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 22:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238823AbhLVVan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 16:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbhLVVal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 16:30:41 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB4EC061574;
        Wed, 22 Dec 2021 13:30:41 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id w16so13527959edc.11;
        Wed, 22 Dec 2021 13:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=coEccP6zZM5PP15UOTxsrXWW0cXc+iHQhmE0IjhaoXA=;
        b=bcNp1CEVtu7v7nuRrlPp98+zljrvIF77G8t06sYR5Zbo9dNuEoLl786DxwhmBRTou7
         Ul0UGE3V24X+95XbTcaYLCenGf0afhvOn7j2CoGU342YbYljzOsziOPX9FaRy4i+vtdO
         GibmYZq50QT9z+VYfCDoCzAOrx+SWR/pWWFbnZtn/tLqdjFV8nhZ7/EMuMvAHH34T6JB
         avoOe7OEj9l83OVPt4yBA6VrmvY6uCqpkpNaEYYjSkq2V5FbH1RAdW66MLmrmYRKMkla
         R+6Q0SsGuEu3RbAv7UOZj/Lj5/AB8yDdjrK0rDjiiou5w6Fkkx3VJo6xBGRZ3++W6vXL
         X5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=coEccP6zZM5PP15UOTxsrXWW0cXc+iHQhmE0IjhaoXA=;
        b=VhyC5pLwHHtzoDhb6caLgK1uTdvk1NS3gj3qtt87uxz5aBqzAKwR3BIIx7V+dPjTeV
         KVRdMVIp/moJQIbG8Ft4hYsmx+uEwvLWOtJ8Y+XgLXzdYTcn7FAj7/x/u1RjlO3rZu0j
         oilw+94WQJ/MxBXrvvr5YNMOTJe68AeQYkYMm4PVS30YMy4Xj8y1x4V/2U1fMNSBU/Ij
         ARfN8wAgry4PQViYr3GSNn/V5NEswvnl4NcIRzs7M9x+PKdb2eEsvA6nxciaerxgzoU7
         clljdRryhg7WzKjlCbOC/Ds43qWR947OmtGUdSby0cQC1rAYRoi4kzr3/5QNOk+4DTal
         bDNg==
X-Gm-Message-State: AOAM531BUfsO63VPCTB+Uex1W3zz7fEhcBgyqGDqr5J7IlB0Q3NW+2Be
        UjnW6H1wm1aHdiZgXUrNFa0=
X-Google-Smtp-Source: ABdhPJxvSWOETcPDqQj7WXzbmesiuA3Egb0BiA6ohcGR6dWmohDfq5vLRiZt97656OhB2eVMXPBc9w==
X-Received: by 2002:a17:906:37d3:: with SMTP id o19mr4162211ejc.32.1640208639816;
        Wed, 22 Dec 2021 13:30:39 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id ne2sm1087776ejc.108.2021.12.22.13.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 13:30:39 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, kishon@ti.com, vkoul@kernel.org,
        p.zabel@pengutronix.de, lee.jones@linaro.org,
        yifeng.zhao@rock-chips.com, kever.yang@rock-chips.com,
        cl@rock-chips.com, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v6 0/4] Add Naneng multi phy support for rk3568
Date:   Wed, 22 Dec 2021 22:30:28 +0100
Message-Id: <20211222213032.7678-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=============================================

TEST COMPILED ONLY!
Driver not verified with hardware!
Produced in the hope that we can get some review progress
with this serie for the documents and driver.
Use at your own risk!

Renamed the combi phy driver to multi phy to highlight the different approach and
not to confuse with the driver from the Rockchip manufacturer tree.
By using a parent node it makes it hopefully easier to coordinate
for new futures/functions between nodes.

Removed a few properties, because it's not entire clear how they should be used.
To prevent the obligation to keep supporting them despite changed handling.

=============================================

Changes in v6:
- restyle
- rename defines
- change from comb to multi phy
- clean up includes
- add parent node
- change compatible strings
- remove rockchip,sgmii-mac-sel support
- remove rockchip,dis-u3otg0-port support
- remove rockchip,dis-u3otg1-port support

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
  dt-bindings: mfd: syscon: add naneng multi phy register compatible

Yifeng Zhao (3):
  dt-bindings: phy: rockchip: add naneng multi phy bindings
  phy: rockchip: add naneng multi phy for rk3568
  arm64: dts: rockchip: add naneng multi phy nodes for rk3568

 .../devicetree/bindings/mfd/syscon.yaml       |   2 +
 .../phy/phy-rockchip-naneng-multiphy.yaml     | 167 +++++
 arch/arm64/boot/dts/rockchip/rk3566.dtsi      |   4 +
 arch/arm64/boot/dts/rockchip/rk3568.dtsi      |  23 +
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      |  50 ++
 drivers/phy/rockchip/Kconfig                  |   8 +
 drivers/phy/rockchip/Makefile                 |   1 +
 .../rockchip/phy-rockchip-naneng-multiphy.c   | 661 ++++++++++++++++++
 8 files changed, 916 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-naneng-multiphy.yaml
 create mode 100644 drivers/phy/rockchip/phy-rockchip-naneng-multiphy.c

-- 
2.20.1

