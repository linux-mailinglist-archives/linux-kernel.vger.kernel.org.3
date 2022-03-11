Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920984D6A72
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiCKWqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 17:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiCKWpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 17:45:45 -0500
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D76127DF9C;
        Fri, 11 Mar 2022 14:21:26 -0800 (PST)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout2.routing.net (Postfix) with ESMTP id B06455FD39;
        Fri, 11 Mar 2022 21:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1647032658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dqoouwB8fBLOnpT8CCz+WpgKrPdobpaCbLTnMi6n0lU=;
        b=iPcsVWFSj21ZM3iK3XmjYgxqSVjaj9ZH8UYoNzMLz40zFttSNLDigs1B4DbQrnU15I3Nbt
        55djBEwWjJM6s1fFBehC8r5ghWNox79S2wetCsnmx4zNx+KLWgQO26pAjp0c7moO7bMPGh
        juiPmVMDo9zhwpBsxZnQgaUBMeSaLvs=
Received: from localhost.localdomain (fttx-pool-217.61.144.196.bambit.de [217.61.144.196])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id 3A602402CA;
        Fri, 11 Mar 2022 21:04:17 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     devicetree@vger.kernel.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v6 0/6] Add sata nodes to rk356x
Date:   Fri, 11 Mar 2022 22:03:51 +0100
Message-Id: <20220311210357.222830-1-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: c2271224-4634-4d57-8dd2-2e15f21c9f88
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

This Series converts the binding for ahci-platform to yaml and adds
sata nodes to rockchip rk356x device trees.

---

v6:
  - add fix for spear1340
  - fix indentation of examples
  - add compatible marvell,berlin2-ahci
  - change maximum of ports-implemented
  - add select to exclude qcom compatibles
  - drop marvell,armada-380-ahci
    it is not handled in the ahci-platform.c but ahci_mvebu.c
    and incompatible due to missing phys/target-supply

v5:
  DTS:
  - drop broadcom-patch as it is already applied
  - add fix for marvell
  YAML:
  - change subject
  - drop brcm,iproc-ahci from standalone enum
  - fix reg address in example 2
  - move clocknames next to clocks, regnames to reg
  - drop interrupts description
  - drop newline from dma-coherent
  - drop max-items from ports-implemented
  - min2max in child phys
  - fix identation for compatible and sata-common
  - add additionalProperties=false for subnodes
  - pipe for paragraphs and newline after title
  - add maximum for ports-implemented (found only 0x1 as its value)
  - add phy-names to sata-ports
v4:
  YAML binding:
  - fix min vs. max
  - fix indention of examples
  - move up sata-common.yaml
  - reorder compatible
  - add descriptions/maxitems
  - fix compatible-structure
  - fix typo in example achi vs. ahci
  - add clock-names and reg-names
  DTS-Patches:
  - drop newline in dts
  - re-add clock-names
  - add soc specific compatible
  - fix sata nodename in arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
v3:
  - add conversion to sata-series
  - fix some errors in dt_binding_check and dtbs_check
  - move to unevaluated properties = false
  - add power-domain to yaml
  - move sata0 to rk3568.dtsi
  - drop clock-names and interrupt-names

Frank Wunderlich (6):
  dt-bindings: ata: ahci-platform: Convert DT bindings to yaml
  arm64: dts: marvell: Fix anyOf conditional failed
  ARM: dts: spear13xx: Fix sata node name
  dt-bindings: ata: ahci-platform: Add power-domains property
  dt-bindings: ata: ahci-platform: Add rk3568-dwc-ahci compatible
  arm64: dts: rockchip: Add sata nodes to rk356x

 .../devicetree/bindings/ata/ahci-platform.txt |  79 --------
 .../bindings/ata/ahci-platform.yaml           | 189 ++++++++++++++++++
 arch/arm/boot/dts/spear1310.dtsi              |   6 +-
 arch/arm/boot/dts/spear1340-evb.dts           |   2 +-
 arch/arm/boot/dts/spear1340.dtsi              |   2 +-
 .../arm64/boot/dts/marvell/armada-7040-db.dts |   1 +
 .../boot/dts/marvell/armada-7040-mochabin.dts |   2 +
 .../marvell/armada-8040-clearfog-gt-8k.dts    |   1 +
 .../arm64/boot/dts/marvell/armada-8040-db.dts |   2 +
 .../boot/dts/marvell/armada-8040-mcbin.dtsi   |   1 +
 .../dts/marvell/armada-8040-puzzle-m801.dts   |   2 +
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi |   2 +
 arch/arm64/boot/dts/marvell/cn9130-crb-B.dts  |   1 +
 arch/arm64/boot/dts/marvell/cn9131-db.dtsi    |   1 +
 arch/arm64/boot/dts/marvell/cn9132-db.dtsi    |   1 +
 arch/arm64/boot/dts/rockchip/rk3568.dtsi      |  14 ++
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      |  28 +++
 17 files changed, 250 insertions(+), 84 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ata/ahci-platform.txt
 create mode 100644 Documentation/devicetree/bindings/ata/ahci-platform.yaml

-- 
2.25.1

