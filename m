Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D5D46DB99
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 19:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239436AbhLHS6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 13:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbhLHS6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 13:58:34 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA46C061746;
        Wed,  8 Dec 2021 10:55:02 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id x6so11657491edr.5;
        Wed, 08 Dec 2021 10:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bnPHoPGFbiP7HW6F6zOKM0rgVaYMVXPavRbOAOjdXS4=;
        b=YWUipWbNKn+WE4X1AJBFj6SdUdsfpJqfWH6KTGw7YQhc/rEDxoiDdvt28tCKJq22vt
         ihppBznyw20mhvOswtn5Dp7/zLuf/4KdBBeQAEgpEAyS2bHI8Y3DQ2NmyoCy9pFrSL+g
         jNJBapMSBkC6ewyy893GUlJMxa7MTJvW46aITAD2ItCH4DpwDGTO9T7/Nd4uXlcmqdjL
         E186Psi3QOmIclSqydJjkygbITDeFwK1nGsWVZy1jgMol+rY6X72Nlp8FqmRHa4GkYdW
         tAwOO+0UJfh6RIFAwQ3eNCs//f7aSI7tt9rzSYH9RjHHN+Mn5A9yXF8wKme2Z19xclgx
         HOxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bnPHoPGFbiP7HW6F6zOKM0rgVaYMVXPavRbOAOjdXS4=;
        b=S3yw32OHU3J/xobk3BKjcN/lAO42rOuX45pM/zuRcFr8kyw37nOwqz2G5Ilo9BbUCl
         Wp1KJu+O8uYqZbkdkXbWzvYgLqdc1OJ27YdvdZw6ug7LvZIgR+ITpu5i/42kZ5KlWFBy
         KYOT5ScvDCJvTmt8zYXFqCwrOH3vXnsG5odt61/rrE5kn4cFcmmnZ9yxPoiROUt9lE4z
         l41ELp6kUtCiNdQB+ci2NCWtcnEHbACyK4iXuBOHho8tCuLd5DoWYVGgAVNgirxmXQak
         B8cTmBN8VU7DQ+YvELBrhCx8ZaYR7hcDr3J82ucv+WradSg9iN3NSXybI+NG4wTb8PD7
         TNpw==
X-Gm-Message-State: AOAM533ZC+j/qscRq/mEPjXNfNFrrLoNRlNg4FKkNU+Blz5cVIgSF1vO
        MpmFnBO2hGISw/CiTcRp0Jc=
X-Google-Smtp-Source: ABdhPJznVmQ3VvZ89Mh6gdPWTlgjs19404uNVgYQF8HGSOYkSiNmrgRb9fWkKB9AG0atjUTx1+KUog==
X-Received: by 2002:a17:907:7ba8:: with SMTP id ne40mr9599335ejc.391.1638989701002;
        Wed, 08 Dec 2021 10:55:01 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id g18sm1862273ejt.36.2021.12.08.10.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 10:55:00 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, kishon@ti.com, vkoul@kernel.org,
        p.zabel@pengutronix.de, yifeng.zhao@rock-chips.com,
        kever.yang@rock-chips.com, cl@rock-chips.com,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 0/4] Add Naneng combo PHY support for RK3568
Date:   Wed,  8 Dec 2021 19:54:45 +0100
Message-Id: <20211208185449.16763-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This phy can be used as pcie-phy, usb3-phy, sata-phy or sgmii-phy.

=============================================

Changed V4 by Johan Jonker:
  TEST COMPILED ONLY!
  Driver not verified with hardware!
  Produced in the hope that we can get some review progress
  with this serie for the documents and driver.
  Use at your own risk!

  restyle
  add devm_reset_control_array_get()
  remove clk structure
  change refclk DT parse
  change dev_err message
  add dot to phrase
  add ext_refclk variable
  add enable_ssc variable
  rename rockchip_combphy_param_write
  remove param_read
  replace rockchip-naneng-combphy driver name

  rename node name
  remove reset-names
  move #phy-cells
  add rockchip,rk3568-pipe-grf
  add rockchip,rk3568-pipe-phy-grf

=============================================

Changes V3:
  Using api devm_reset_control_get_optional_exclusive and dev_err_probe
  Remove apb_rst
  Redefine registers address
  Move pipe_phy_grf0 to rk3568.dtsi

Changes V2:
  Fix dtschema/dtc warnings/errors
  Using api devm_platform_get_and_ioremap_resource.
  Modify rockchip_combphy_set_Mode.
  Add some PHY registers definition.
  Move phy0 to rk3568.dtsi

Johan Jonker (1):
  dt-bindings: mfd: syscon: add naneng combo phy register compatible

Yifeng Zhao (3):
  dt-bindings: phy: rockchip: Add Naneng combo PHY bindings
  phy: rockchip: add naneng combo phy for RK3568
  arm64: dts: rockchip: add naneng combo phy nodes for rk3568

 .../devicetree/bindings/mfd/syscon.yaml       |   2 +
 .../phy/phy-rockchip-naneng-combphy.yaml      | 127 ++++
 arch/arm64/boot/dts/rockchip/rk3568.dtsi      |  21 +
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      |  47 ++
 drivers/phy/rockchip/Kconfig                  |   8 +
 drivers/phy/rockchip/Makefile                 |   1 +
 .../rockchip/phy-rockchip-naneng-combphy.c    | 608 ++++++++++++++++++
 7 files changed, 814 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
 create mode 100644 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c

-- 
2.20.1

