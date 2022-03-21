Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A679A4E26AB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 13:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347466AbiCUMha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347463AbiCUMh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:37:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECE391556
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 05:36:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2B88B81112
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 12:35:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33FB1C340E8;
        Mon, 21 Mar 2022 12:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647866158;
        bh=wgQJuzd2oKOAIM+mB86uHq8wLkr1vhTuWOO1Ky23SJo=;
        h=From:To:Cc:Subject:Date:From;
        b=qG39+to2FPC8hC0JucXvtghAXZ926TZHWAT8sAzrHF5KJ7y8IvLYmR92KnMN4HDY+
         UVn3IdwSapgiThujAjybo6uKfR7D7UyBhcNa6a6/5RUveIH0G8oGeFogwngA8n+rxi
         tDAxit9a0cYeMCF52T1rDa0N35P3VQumy10V6xgeXk6SayT4JgLD3XUg7jSogkjrRm
         tiJfB9+pY7RcV9CIj6v4gwzqundH2FuhEUQa7K69Eg62RedyG70BnClLv4bkJNNMmi
         6wBB4a0EGhUO/BgZJPZA/LF1jX4pIZH9NWTP+boNIXDMtaCCMY2QUEQmGoDpY84Nvr
         nie7xoW2+4fyw==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator updates for v5.18
Date:   Mon, 21 Mar 2022 12:35:47 +0000
Message-Id: <20220321123558.33FB1C340E8@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.18

for you to fetch changes up to 5999f85ddeb436b4007878f251a30ccc8b9c638b:

  regulator: qcom-rpmh: Add support for SDX65 (2022-03-18 16:05:06 +0000)

----------------------------------------------------------------
regulator: Updates for v5.18

Quite a quiet release for the regulator API, mainly a few new drivers
plus a lot of fixes for the Raspberry Pi panel driver.  There's also a
SPI commit in here which I managed to apply to the wrong tree and then
didn't notice until there were too many commits on top of it, sorry
about that.

 - Make it easier to use the virtual consumer test driver with DT
   systems.
 - Substantial overhaul providing various fixes and robustness
   improvements for the Raspberry Pi panel driver.
 - Support for Qualcomm PMX65 and SDX65, Richtek RT5190A, and Texas
   Instruments TPS62864x

----------------------------------------------------------------
Alexander Stein (1):
      regulator: pfuze100: Add missing regulator names

ChiYuan Huang (2):
      regulator: Add bindings for Richtek RT5190A PMIC
      regulator: rt5190a: Add support for Richtek RT5190A PMIC

Christophe JAILLET (1):
      spi: qcom: geni: Simplify DMA setting

Dave Stevenson (9):
      regulator: rpi-panel: Register with a unique backlight name
      regulator: rpi-panel: Handle I2C errors/timing to the Atmel
      regulator: rpi-panel: Serialise operations.
      regulator: rpi-panel: Ensure the backlight is off during probe.
      regulator: rpi-panel: Convert to drive lines directly
      regulator: rpi-panel: Add GPIO control for panel and touch resets
      regulator: rpi-panel: Remove get_brightness hook
      regulator/rpi-panel-attiny: Use the regmap cache
      regulator/rpi-panel-attiny: Use two transactions for I2C read

Georgi Vlaev (1):
      regulator: Convert TPS62360 binding to json-schema

Haowen Bai (1):
      regulator: vctrl: Use min() instead of doing it manually

Mark Brown (1):
      Merge existing fixes from regulator/for-5.17 into new branch

Rob Herring (1):
      regulator: maxim,max8973: Drop Tegra specifics from example

Rohit Agarwal (2):
      regulator: dt-bindings: Add PMX65 compatibles
      regulator: qcom-rpmh: Add support for SDX65

Tom Rix (1):
      regulator: cleanup comments

Vincent Whitchurch (6):
      regulator: Add bindings for TPS62864x
      regulator: Add support for TPS6286x
      regulator: tps62864: Fix bindings for SW property
      regulator: virtual: use dev_err_probe()
      regulator: virtual: warn against production use
      regulator: virtual: add devicetree support

kernel test robot (1):
      regulator: qcom_smd: fix for_each_child.cocci warnings

 .../bindings/regulator/maxim,max8973.yaml          |   5 +-
 .../devicetree/bindings/regulator/pfuze100.yaml    |   6 +-
 .../bindings/regulator/qcom,rpmh-regulator.yaml    |   2 +
 .../regulator/richtek,rt5190a-regulator.yaml       | 141 ++++++
 .../devicetree/bindings/regulator/ti,tps62360.yaml |  98 ++++
 .../devicetree/bindings/regulator/ti,tps62864.yaml |  63 +++
 .../bindings/regulator/tps62360-regulator.txt      |  44 --
 drivers/regulator/Kconfig                          |  20 +
 drivers/regulator/Makefile                         |   2 +
 drivers/regulator/max20086-regulator.c             |   3 +-
 drivers/regulator/max8973-regulator.c              |   2 +-
 drivers/regulator/qcom-rpmh-regulator.c            |  37 ++
 drivers/regulator/qcom_smd-regulator.c             |   4 +-
 drivers/regulator/rpi-panel-attiny-regulator.c     | 291 ++++++++++--
 drivers/regulator/rt5190a-regulator.c              | 513 +++++++++++++++++++++
 drivers/regulator/sc2731-regulator.c               |   2 +-
 drivers/regulator/ti-abb-regulator.c               |   6 +-
 drivers/regulator/tps6286x-regulator.c             | 159 +++++++
 drivers/regulator/vctrl-regulator.c                |   5 +-
 drivers/regulator/virtual.c                        |  41 +-
 drivers/regulator/wm8350-regulator.c               |   2 +-
 drivers/spi/spi-geni-qcom.c                        |   7 +-
 .../regulator/richtek,rt5190a-regulator.h          |  15 +
 include/dt-bindings/regulator/ti,tps62864.h        |   9 +
 24 files changed, 1362 insertions(+), 115 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt5190a-regulator.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/ti,tps62360.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/ti,tps62864.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/tps62360-regulator.txt
 create mode 100644 drivers/regulator/rt5190a-regulator.c
 create mode 100644 drivers/regulator/tps6286x-regulator.c
 create mode 100644 include/dt-bindings/regulator/richtek,rt5190a-regulator.h
 create mode 100644 include/dt-bindings/regulator/ti,tps62864.h
