Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA23530F37
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236002AbiEWNNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 09:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235959AbiEWNMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 09:12:36 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E642BB2C
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:12:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D11ECCE136A
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 13:12:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B844CC385A9;
        Mon, 23 May 2022 13:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653311551;
        bh=0fw8Lio2R1KT24divy6cchQMAkg5Ovz0dNaSYiBu9H0=;
        h=From:To:Cc:Subject:Date:From;
        b=eNLX/fkTLhC/5eE9Sk91gBQsbDiQOUbZXwLN/TwqM/85LeiT991xO6OgGyBiROfGx
         V+wQJJCU3vP2dhZ/ccML/vVpKNTzmG+Ktob+TP3b4QxfVv7pvthL8UYNPTF35ahSy0
         oW09EHTbzyQyeJeXmTfo+DAr0te+Lsy5a06zOOs4p2nYUQ6gx8bi4Iw6ztFae+YBXV
         WP3NQUYWb4HRR4fBHgsCWVGXMpanSNsJoAPxKZ8U3+X/b39mi5qneGALvsv6wCMXYD
         3sLgYPwxmbLxiBXy8WpjfAlMUO+1zvQz03y86EGoxjYXGgiBIEzErdeNshHoyRbp3L
         UUka4Mko88lIA==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator updates for v5.19
Date:   Mon, 23 May 2022 14:12:19 +0100
Message-Id: <20220523131230.B844CC385A9@smtp.kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit dfd2b37edf7ef469574ef7f36e3a1905ac9ead62:

  regulator: dt-bindings: Revise the rt5190a buck/ldo description (2022-04-22 12:37:22 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.19

for you to fetch changes up to a5b8e4a5ceec0ab6453176bc7f5eceafa78bf8a9:

  Merge remote-tracking branch 'regulator/for-5.19' into regulator-next (2022-05-17 16:59:05 +0100)

----------------------------------------------------------------
regulator: Updates for v5.19

This is mostly a drivers update including a couple of new drivers but we
do have some fixes and improvements to the core as well.

 - Make sure we don't log spuriously about uncontrollable regulators.
 - Don't use delays when we should use sleeps for regulators with
   larger ramp times.
 - Support for MediaTek MT6358 and MT6366, Richtek RT5759 and Silicon
   Mitus SM5703.

----------------------------------------------------------------
Andy Shevchenko (1):
      regulator: rpi-panel-attiny: Get rid of duplicate of_node assignment

Brian Norris (2):
      regulator: core: Rename _regulator_enable_delay()
      regulator: core: Sleep (not delay) in set_voltage()

ChiYuan Huang (2):
      regulator: rt5759: Add support for Richtek RT5759 DCDC converter
      regulator: Add binding for Richtek RT5759 DCDC converter

Johnson Wang (4):
      regulator: mt6366: Add support for MT6366 regulator
      regulator: Add BUCK and LDO document for MT6358 and MT6366
      regulator: Add BUCK and LDO document for MT6358 and MT6366
      regulator: mt6366: Add support for MT6366 regulator

Konrad Dybcio (1):
      regulator: qcom_smd: Fix up PM8950 regulator configuration

Krzysztof Kozlowski (7):
      regulator: dt-bindings: richtek,rt4801: minor comments adjustments
      regulator: dt-bindings: qcom,rpmh: document h and k ID
      regulator: dt-bindings: richtek,rt4801: use existing ena_gpiod feature
      regulator: richtek,rt4801: parse GPIOs per regulator
      regulator: dt-bindings: qcom,rpmh: update maintainers
      regulator: dt-bindings: qcom,rpmh: document supplies per variant
      regulator: dt-bindings: qcom,rpmh: document vdd-l7-bob-supply on PMR735A

Kunihiko Hayashi (2):
      regulator: uniphier: Clean up clocks, resets, and their names using compatible string
      regulator: uniphier: Use unevaluatedProperties

Mark Brown (7):
      regulator: fixed: Remove print on allocation failure
      regulator: Flag uncontrollable regulators as always_on
      regulator: Add support for MediaTek PMIC MT6366
      Add support for MediaTek PMIC MT6366
      regulator Add Richtek RT5759 buck converter support
      regulator: dt-bindings: qcom,rpmh: minor cleanups and extend supplies
      Merge remote-tracking branch 'regulator/for-5.19' into regulator-next

Markuss Broks (3):
      dt-bindings: regulator: Add bindings for Silicon Mitus SM5703 regulators
      regulator: sm5703-regulator: Add regulators support for SM5703 MFD
      regulator: sm5703: Correct reference to the common regulator schema

Miaoqian Lin (2):
      regulator: pfuze100: Fix refcount leak in pfuze_parse_regulators_dt
      regulator: scmi: Fix refcount leak in scmi_regulator_probe

Minghao Chi (1):
      regulator: stm32-vrefbuf: using pm_runtime_resume_and_get instead of pm_runtime_get_sync

Nícolas F. R. A. Prado (1):
      regulator: mt6315: Enforce regulator-compatible, not name

Per-Daniel Olsson (2):
      regulator: Add property for I2C level shifter
      regulator: pca9450: Make I2C Level Translator configurable

Rickard x Andersson (3):
      regulator: Add property for WDOG_B warm reset
      regulator: pca9450: Make warm reset on WDOG_B assertion
      regulator: pca9450: Enable DVS control via PMIC_STBY_REQ

Wei Yongjun (1):
      regulator: da9121: Fix uninit-value in da9121_assign_chip_model()

Zev Weiss (2):
      regulator: core: Add error flags to sysfs attributes
      regulator: core: Fix enable_count imbalance with EXCLUSIVE_GET

 Documentation/ABI/testing/sysfs-class-regulator    |  81 +++++
 .../bindings/regulator/mt6315-regulator.yaml       |   2 +-
 .../bindings/regulator/mt6358-regulator.txt        |  22 +-
 .../bindings/regulator/nxp,pca9450-regulator.yaml  |  11 +
 .../bindings/regulator/qcom,rpmh-regulator.yaml    | 262 ++++++++++++++-
 .../regulator/richtek,rt4801-regulator.yaml        |  21 +-
 .../regulator/richtek,rt5759-regulator.yaml        |  90 +++++
 .../regulator/siliconmitus,sm5703-regulator.yaml   |  49 +++
 .../regulator/socionext,uniphier-regulator.yaml    |  57 +++-
 drivers/regulator/Kconfig                          |  17 +
 drivers/regulator/Makefile                         |   2 +
 drivers/regulator/core.c                           |  93 +++++-
 drivers/regulator/da9121-regulator.c               |   2 +
 drivers/regulator/fixed.c                          |   5 +-
 drivers/regulator/mt6358-regulator.c               | 213 +++++++++++-
 drivers/regulator/pca9450-regulator.c              |  27 +-
 drivers/regulator/pfuze100-regulator.c             |   2 +
 drivers/regulator/qcom_smd-regulator.c             |  35 +-
 drivers/regulator/rpi-panel-attiny-regulator.c     |   1 -
 drivers/regulator/rt4801-regulator.c               |  49 ++-
 drivers/regulator/rt5759-regulator.c               | 369 +++++++++++++++++++++
 drivers/regulator/scmi-regulator.c                 |   2 +-
 drivers/regulator/sm5703-regulator.c               | 167 ++++++++++
 drivers/regulator/stm32-vrefbuf.c                  |  30 +-
 include/linux/regulator/mt6358-regulator.h         |  45 +++
 include/linux/regulator/pca9450.h                  |   7 +
 26 files changed, 1538 insertions(+), 123 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt5759-regulator.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml
 create mode 100644 drivers/regulator/rt5759-regulator.c
 create mode 100644 drivers/regulator/sm5703-regulator.c
