Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15F44899F4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbiAJN3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbiAJN3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 08:29:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20107C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 05:29:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADE8B611D3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 13:29:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6D8C36AE5;
        Mon, 10 Jan 2022 13:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641821370;
        bh=9VN3SiHK73vMwCPJsAB277KgUmZzxkpolOPoEUOzmiU=;
        h=From:To:Cc:Subject:Date:From;
        b=t2ZQmGvnGxJj7msvTSlw/3LFA1Ua8aY30+xa3shBmFoHhENlOqaKD7f+UduP1i3/E
         ARU4r2muRcPEe+7Q/8LT6S/Mi57FyvxTAy8CYHYayCss7aR/9dSbICpCe9a8n8mjOu
         4dMkoDHeeUZwfaKEFjilm1UiBeOqOzeLEqA9DBPunXKuBj4f4XX2zQVuV/zj1htWhQ
         +ITRhHMiTwwpSAhcHKMc4af8dmsMHw90Q735Vh8mNkjE5oopDqm+t7C3K80B8VRoo/
         Cvo+I1kzTiRZ7WVKIv+Td7pAhKF3Ykcgcu9zDeAVqh/Lxvg52oXgR78+arP/+bv86u
         XtoVNOC4M7bdQ==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator updates for v5.17
Date:   Mon, 10 Jan 2022 13:29:13 +0000
Message-Id: <20220110132929.8B6D8C36AE5@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.17

for you to fetch changes up to bfff546aae50ae68ed395bf0e0848188d27b0ba3:

  regulator: Add MAX20086-MAX20089 driver (2022-01-07 13:36:35 +0000)

----------------------------------------------------------------
regulator: Updates for v5.17

This has been a fairly quiet release for the regulator API, the main
thing has been the addition of helpers for interrupt handling from Matti
Vaittinen. We do also have support for quite a few new devices and
included in here is a platform/x86 patch series for Intel INT3472 ACPI
devices which this is a dependency for the TPS68470 driver.

 - Helpers for trivial interrupt notifications, making it easier for
   drivers to handle error interrupts.
 - Support for Dialog DA914x, Maxim MAX2008x, Qualcomm PM8826, PMG1100,
   and PM8450 and TI TPS68470

----------------------------------------------------------------
Adam Ward (4):
      regulator: da9121: Prevent current limit change when enabled
      regulator: da9121: Add DA914x support
      regulator: da9121: Remove erroneous compatible from binding
      regulator: da9121: Add DA914x binding info

Dominik Kobinski (2):
      dt-bindings: regulator: qcom: spmi-regulator: Document pm8226 compatible
      regulator: qcom_spmi: Add pm8226 regulators

Hans de Goede (10):
      ACPI: delay enumeration of devices with a _DEP pointing to an INT3472 device
      i2c: acpi: Use acpi_dev_ready_for_enumeration() helper
      i2c: acpi: Add i2c_acpi_new_device_by_fwnode() function
      platform_data: Add linux/platform_data/tps68470.h file
      platform/x86: int3472: Split into 2 drivers
      platform/x86: int3472: Add get_sensor_adev_and_name() helper
      platform/x86: int3472: Pass tps68470_clk_platform_data to the tps68470-regulator MFD-cell
      platform/x86: int3472: Pass tps68470_regulator_platform_data to the tps68470-regulator MFD-cell
      platform/x86: int3472: Deal with probe ordering issues
      regulator: Introduce tps68470-regulator driver

Konrad Dybcio (1):
      regulator: qcom_smd: Align probe function with rpmh-regulator

Laurent Pinchart (1):
      dt-bindings: regulators: Add bindings for Maxim MAX20086-MAX20089

Marijn Suijten (1):
      regulator: qcom-labibb: OCP interrupts are not a failure while disabled

Mark Brown (1):
      Merge tag 'platform-drivers-x86-int3472-1' of git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86 into regulator-5.17

Matti Vaittinen (8):
      regulator: rohm-regulator: add helper for restricted voltage setting
      regulator: bd718x7: Use rohm generic restricted voltage setting
      regulator: Add units to limit documentation
      regulator: rohm-generic: iniline stub function
      regulator: Drop unnecessary struct member
      regulator: Add regulator_err2notif() helper
      regulator: irq_helper: Provide helper for trivial IRQ notifications
      regulator: rohm-generic: remove unused dummies

Minghao Chi (2):
      drivers/regulator: remove redundant ret variable
      regulator: remove redundant ret variable

Rob Herring (1):
      regulator: dt-bindings: samsung,s5m8767: Move fixed string BUCK9 to 'properties'

Satya Priya (2):
      dt-bindings: regulator: Add compatible for pmg1110
      regulator: qcom-rpmh: Add PMG1110 regulators

Thierry Reding (2):
      regulator: maxim,max8973: Document interrupts property
      regulator: Fix type of regulator-coupled-max-spread property

Uwe Kleine-König (1):
      regulator: da9121: Emit only one error message in .remove()

Vinod Koul (2):
      regulator: qcom,rpmh: Add compatible for PM8450
      regulator: qcom-rpmh: Add support for PM8450 regulators

Watson Chow (1):
      regulator: Add MAX20086-MAX20089 driver

Yanteng Si (1):
      regulator: fix bullet lists of regulator_ops comment

 .../devicetree/bindings/regulator/dlg,da9121.yaml  |  76 +++--
 .../bindings/regulator/maxim,max20086.yaml         | 106 +++++++
 .../bindings/regulator/maxim,max8973.yaml          |   3 +
 .../bindings/regulator/qcom,rpmh-regulator.yaml    |   3 +
 .../bindings/regulator/qcom,spmi-regulator.txt     |   1 +
 .../devicetree/bindings/regulator/regulator.yaml   |   2 +-
 .../bindings/regulator/samsung,s5m8767.yaml        |   3 +-
 MAINTAINERS                                        |   7 +
 drivers/acpi/scan.c                                |  37 ++-
 drivers/i2c/i2c-core-acpi.c                        |  22 +-
 drivers/platform/x86/intel/int3472/Makefile        |   9 +-
 ...472_clk_and_regulator.c => clk_and_regulator.c} |   2 +-
 drivers/platform/x86/intel/int3472/common.c        |  82 +++++
 .../{intel_skl_int3472_common.h => common.h}       |   6 +-
 .../{intel_skl_int3472_discrete.c => discrete.c}   |  51 ++--
 .../x86/intel/int3472/intel_skl_int3472_common.c   | 106 -------
 .../{intel_skl_int3472_tps68470.c => tps68470.c}   |  92 +++++-
 drivers/platform/x86/intel/int3472/tps68470.h      |  25 ++
 .../x86/intel/int3472/tps68470_board_data.c        | 145 +++++++++
 drivers/regulator/Kconfig                          |  19 +-
 drivers/regulator/Makefile                         |   2 +
 drivers/regulator/bd718x7-regulator.c              |  29 +-
 drivers/regulator/da9121-regulator.c               | 117 +++++++-
 drivers/regulator/da9121-regulator.h               |  21 +-
 drivers/regulator/irq_helpers.c                    |  41 ++-
 drivers/regulator/max20086-regulator.c             | 332 +++++++++++++++++++++
 drivers/regulator/mt6380-regulator.c               |   6 +-
 drivers/regulator/qcom-labibb-regulator.c          |   2 +-
 drivers/regulator/qcom-rpmh-regulator.c            |  27 ++
 drivers/regulator/qcom_smd-regulator.c             | 100 +++++--
 drivers/regulator/qcom_spmi-regulator.c            |  39 +++
 drivers/regulator/rohm-regulator.c                 |  16 +
 drivers/regulator/tps68470-regulator.c             | 201 +++++++++++++
 drivers/regulator/twl-regulator.c                  |  10 +-
 include/acpi/acpi_bus.h                            |   5 +-
 include/linux/i2c.h                                |  17 +-
 include/linux/mfd/rohm-generic.h                   |  10 +-
 include/linux/platform_data/tps68470.h             |  35 +++
 include/linux/regulator/driver.h                   |  67 ++++-
 39 files changed, 1581 insertions(+), 293 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max20086.yaml
 rename drivers/platform/x86/intel/int3472/{intel_skl_int3472_clk_and_regulator.c => clk_and_regulator.c} (99%)
 create mode 100644 drivers/platform/x86/intel/int3472/common.c
 rename drivers/platform/x86/intel/int3472/{intel_skl_int3472_common.h => common.h} (94%)
 rename drivers/platform/x86/intel/int3472/{intel_skl_int3472_discrete.c => discrete.c} (91%)
 delete mode 100644 drivers/platform/x86/intel/int3472/intel_skl_int3472_common.c
 rename drivers/platform/x86/intel/int3472/{intel_skl_int3472_tps68470.c => tps68470.c} (56%)
 create mode 100644 drivers/platform/x86/intel/int3472/tps68470.h
 create mode 100644 drivers/platform/x86/intel/int3472/tps68470_board_data.c
 create mode 100644 drivers/regulator/max20086-regulator.c
 create mode 100644 drivers/regulator/tps68470-regulator.c
 create mode 100644 include/linux/platform_data/tps68470.h
