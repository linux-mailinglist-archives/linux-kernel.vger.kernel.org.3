Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED4059133A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 17:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237707AbiHLPo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 11:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbiHLPo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 11:44:56 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0031A14033;
        Fri, 12 Aug 2022 08:44:53 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 05F8F240005;
        Fri, 12 Aug 2022 15:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1660319092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=lZZtxYz1Cc+N1tGcnhkF8Otamt97G4kK1n7rfV4yOKE=;
        b=GccBA4QJL3GBTAJATV/HNkN8QDxv39YfpFjnDs5ZvRPU3hPriecH6m7iilNauuCTkRKWjC
        lNgopn93m+3ZVXquGDlixuBCwkGesPWxFTCKJKMqX322pqijsrl5Sp2Zvt6af60MpWlJoV
        mkFXQB3nDBFurHu3RzviqI2XGuvil+RNTp+p/aeJLv63t93CMgwqWz0ySjzJD3W8Qs6gRs
        0yylKisfgEHCLWiFXSr9dJeBg35F1ER6Y4tFW4SEMRIr0aENeRUf24uDZcMu1nxmZ1yPy4
        TNTDVfHr5F5HUduK3yNsSek6Xgpq1G7KyGh2Jjr7iBiiL/cnjHfQdZdGJW7E4A==
Date:   Fri, 12 Aug 2022 17:44:51 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RTC for 6.0
Message-ID: <YvZ1cz2TBIuyZ0md@mail.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the RTC subsystem pull request for 6.0. There is a know add/add
merge conflict in MAINTAINERS that is easy to solve.

Three new drivers this cycle are making the bulk of the changes.

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-6.0

for you to fetch changes up to 03c4cd6f89e074a51e289eb9129ac646f0f2bd29:

  rtc: spear: set range max (2022-08-09 00:56:41 +0200)

----------------------------------------------------------------
RTC for 6.0

New drivers:
 - Microchip PolarFire
 - Nuvoton NCT3018Y
 - TI K3 RTC

Subsystem:
 - Replace flush_scheduled_work() with flush_work()
 - Remove deprecated ida_simple_get()/ida_simple_remove() calls

Drivers:
 - use simple i2c probe where possible
 - sun6i: add R329 support
 - zynqmp: add calibration support
 - vr41xx: remove unused driver

----------------------------------------------------------------
Ahmad Fatoum (3):
      rtc: rv8803: factor out existing register initialization to function
      rtc: rv8803: initialize registers on post-probe voltage loss
      rtc: rv8803: re-initialize all Epson RX8803 registers on voltage loss

Alexander Stein (1):
      dt-bindings: rtc: nxp,pcf85063: Convert to DT schema

Alexandre Belloni (1):
      rtc: zynqmp: initialize fract_tick

Allen-KH Cheng (1):
      dt-bindings: rtc: mediatek: add mt6358 and mt6366 compatible

Conor Dooley (2):
      rtc: Add driver for Microchip PolarFire SoC
      MAINTAINERS: add PolarFire SoC's RTC

Icenowy Zheng (1):
      rtc: sun6i: add support for R329 RTC

Mateusz Jończyk (1):
      rtc: mc146818-lib: reduce RTC_UIP polling period

Mathew McBride (1):
      rtc: rx8025: fix 12/24 hour mode detection on RX-8035

Mia Lin (2):
      dt-bindings: rtc: nuvoton: add NCT3018Y Real Time Clock
      rtc: Add NCT3018Y real time clock driver

Nishanth Menon (2):
      dt-bindings: rtc: Add TI K3 RTC description
      rtc: Introduce ti-k3-rtc

Quentin Schulz (1):
      rtc: isl1208: do not advertise update interrupt feature if no interrupt specified

Rafael J. Wysocki (1):
      rtc: rtc-cmos: Do not check ACPI_FADT_LOW_POWER_S0

Rob Herring (1):
      dt-bindings: rtc: microcrystal,rv3032: Add missing type to 'trickle-voltage-millivolt'

Satya Priya (1):
      dt-bindings: rtc: qcom-pm8xxx-rtc: Update the maintainers section

Srinivas Neeli (3):
      dt-bindings: rtc: zynqmp: Add clock information
      rtc: zynqmp: Updated calibration value
      rtc: zynqmp: Add calibration set and get support

Stephen Kitt (1):
      rtc: use simple i2c probe

Tetsuo Handa (2):
      rtc: Replace flush_scheduled_work() with flush_work().
      rtc: Remove unused rtc_dev_exit().

Thomas Bogendoerfer (1):
      rtc: vr41xx: remove driver

Tom Rix (1):
      rtc: mpfs: remove 'pending' variable from mpfs_rtc_wakeup_irq_handler()

Uwe Kleine-König (1):
      rtc: cros-ec: Only warn once in .remove() about notifier_chain problems

Yang Yingliang (1):
      rtc: rv8803: fix missing unlock on error in rv8803_set_time()

Zeng Jingxiang (1):
      rtc: spear: set range max

keliu (1):
      rtc: Directly use ida_alloc()/free()

 .../bindings/rtc/microcrystal,rv3032.yaml          |   1 +
 .../devicetree/bindings/rtc/nuvoton,nct3018y.yaml  |  45 ++
 .../devicetree/bindings/rtc/nxp,pcf85063.txt       |  32 -
 .../devicetree/bindings/rtc/nxp,pcf85063.yaml      |  92 +++
 .../devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml   |   2 +-
 .../devicetree/bindings/rtc/rtc-mt6397.txt         |   2 +
 .../devicetree/bindings/rtc/ti,k3-rtc.yaml         |  62 ++
 .../devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml   |  12 +-
 MAINTAINERS                                        |   3 +
 drivers/rtc/Kconfig                                |  41 +-
 drivers/rtc/Makefile                               |   4 +-
 drivers/rtc/class.c                                |   6 +-
 drivers/rtc/dev.c                                  |   8 +-
 drivers/rtc/rtc-ab-b5ze-s3.c                       |   5 +-
 drivers/rtc/rtc-ab-eoz9.c                          |   5 +-
 drivers/rtc/rtc-bq32k.c                            |   5 +-
 drivers/rtc/rtc-cmos.c                             |   3 -
 drivers/rtc/rtc-core.h                             |   5 -
 drivers/rtc/rtc-cros-ec.c                          |   4 +-
 drivers/rtc/rtc-ds1374.c                           |   5 +-
 drivers/rtc/rtc-ds1672.c                           |   5 +-
 drivers/rtc/rtc-ds3232.c                           |   5 +-
 drivers/rtc/rtc-em3027.c                           |   5 +-
 drivers/rtc/rtc-fm3130.c                           |   5 +-
 drivers/rtc/rtc-hym8563.c                          |   5 +-
 drivers/rtc/rtc-isl12022.c                         |   5 +-
 drivers/rtc/rtc-isl1208.c                          |  10 +-
 drivers/rtc/rtc-max6900.c                          |   5 +-
 drivers/rtc/rtc-mc146818-lib.c                     |   8 +-
 drivers/rtc/rtc-mpfs.c                             | 323 ++++++++++
 drivers/rtc/rtc-nct3018y.c                         | 553 +++++++++++++++++
 drivers/rtc/rtc-pcf8523.c                          |   5 +-
 drivers/rtc/rtc-pcf85363.c                         |   5 +-
 drivers/rtc/rtc-pcf8563.c                          |   5 +-
 drivers/rtc/rtc-pcf8583.c                          |   5 +-
 drivers/rtc/rtc-rv3029c2.c                         |   5 +-
 drivers/rtc/rtc-rv8803.c                           |  98 ++-
 drivers/rtc/rtc-rx6110.c                           |   5 +-
 drivers/rtc/rtc-rx8025.c                           |  22 +-
 drivers/rtc/rtc-rx8581.c                           |   5 +-
 drivers/rtc/rtc-s35390a.c                          |   5 +-
 drivers/rtc/rtc-sd3078.c                           |   5 +-
 drivers/rtc/rtc-spear.c                            |   2 +-
 drivers/rtc/rtc-sun6i.c                            |   2 +
 drivers/rtc/rtc-ti-k3.c                            | 680 +++++++++++++++++++++
 drivers/rtc/rtc-vr41xx.c                           | 363 -----------
 drivers/rtc/rtc-x1205.c                            |   5 +-
 drivers/rtc/rtc-zynqmp.c                           | 115 +++-
 48 files changed, 2063 insertions(+), 540 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
 delete mode 100644 Documentation/devicetree/bindings/rtc/nxp,pcf85063.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/nxp,pcf85063.yaml
 create mode 100644 Documentation/devicetree/bindings/rtc/ti,k3-rtc.yaml
 create mode 100644 drivers/rtc/rtc-mpfs.c
 create mode 100644 drivers/rtc/rtc-nct3018y.c
 create mode 100644 drivers/rtc/rtc-ti-k3.c
 delete mode 100644 drivers/rtc/rtc-vr41xx.c

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
