Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22C1495747
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 01:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348125AbiAUARu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 19:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348093AbiAUARk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 19:17:40 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862E0C061574;
        Thu, 20 Jan 2022 16:17:39 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id AD0CE100005;
        Fri, 21 Jan 2022 00:17:37 +0000 (UTC)
Date:   Fri, 21 Jan 2022 01:17:37 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RTC changes for 5.17
Message-ID: <Yen7oaDXAbd4tFOD@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the RTC subsystem pull request for v5.17.

Two new drivers this cycle and a significant rework of the CMOS driver
make the bulk of the changes.
I also carry powerpc changes with the agreement of Michael.

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-5.17

for you to fetch changes up to 5ceee540fdc7f1d65ca6e2b1b193ce5aa95ab99c:

  rtc: sunplus: fix return value in sp_rtc_probe() (2022-01-16 23:50:34 +0100)

----------------------------------------------------------------
RTC for 5.17

New driver:
 - Sunplus SP7021 RTC
 - Nintendo GameCube, Wii and Wii U RTC

Drivers:
 - cmos: refactor UIP handling and presence check, fix century
 - rs5c372: offset correction support, report low voltage
 - rv8803: Epson RX8804 support

----------------------------------------------------------------
Alexandre Belloni (1):
      rtc: da9063: switch to RTC_FEATURE_UPDATE_INTERRUPT

Camel Guo (3):
      rtc: rs5c372: Add RTC_VL_READ, RTC_VL_CLR ioctls
      rtc: rs5c372: add offset correction support
      rtc: rs5c372: fix incorrect oscillation value on r2221tl

Dan Carpenter (2):
      rtc: mc146818-lib: fix signedness bug in mc146818_get_time()
      rtc: gamecube: Fix an IS_ERR() vs NULL check

David Heidelberg (1):
      dt-bindings: rtc: qcom-pm8xxx-rtc: update register numbers

Emmanuel Gil Peyrot (5):
      rtc: gamecube: Add a RTC driver for the GameCube, Wii and Wii U
      rtc: gamecube: Report low battery as invalid data
      powerpc: wii.dts: Expose HW_SRNPROT on this platform
      powerpc: gamecube_defconfig: Enable the RTC driver
      powerpc: wii_defconfig: Enable the RTC driver

Fabio Estevam (2):
      dt/bindings: rtc: rx8900: Add an entry for RX8804
      rtc: rv8803: Add support for the Epson RX8804 RTC

Hugo Villeneuve (1):
      rtc: pcf2127: Fix typo in comment

Kees Cook (1):
      rtc: Move variable into switch case statement

Lad Prabhakar (1):
      rtc: ftrtc010: Use platform_get_irq() to get the interrupt

Laurence de Bruxelles (1):
      rtc: pxa: fix null pointer dereference

Marc Ferland (1):
      rtc: pcf85063: add i2c_device_id name matching support

Mateusz Jończyk (9):
      rtc: cmos: take rtc_lock while reading from CMOS
      rtc: mc146818-lib: change return values of mc146818_get_time()
      rtc: Check return value from mc146818_get_time()
      rtc: mc146818-lib: fix RTC presence check
      rtc: mc146818-lib: extract mc146818_avoid_UIP
      rtc: mc146818-lib: refactor mc146818_get_time
      rtc: mc146818-lib: refactor mc146818_does_rtc_work
      rtc: cmos: avoid UIP when reading alarm time
      rtc: cmos: avoid UIP when writing alarm time

Nikita Shubin (1):
      rtc: da9063: add as wakeup source

Riwen Lu (1):
      rtc: cmos: Evaluate century appropriate

Vincent Shih (2):
      rtc: Add driver for RTC in Sunplus SP7021
      dt-bindings: rtc: Add Sunplus RTC json-schema

Yang Yingliang (1):
      rtc: sunplus: fix return value in sp_rtc_probe()

 .../devicetree/bindings/rtc/epson,rx8900.yaml      |   1 +
 .../devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml   |   9 +-
 .../bindings/rtc/sunplus,sp7021-rtc.yaml           |  56 +++
 MAINTAINERS                                        |   7 +
 arch/alpha/kernel/rtc.c                            |   7 +-
 arch/powerpc/boot/dts/wii.dts                      |   5 +
 arch/powerpc/configs/gamecube_defconfig            |   2 +-
 arch/powerpc/configs/wii_defconfig                 |   2 +-
 arch/x86/kernel/hpet.c                             |   8 +-
 drivers/base/power/trace.c                         |   6 +-
 drivers/rtc/Kconfig                                |  24 ++
 drivers/rtc/Makefile                               |   2 +
 drivers/rtc/dev.c                                  |   6 +-
 drivers/rtc/rtc-cmos.c                             | 201 +++++++----
 drivers/rtc/rtc-da9063.c                           |  16 +-
 drivers/rtc/rtc-ftrtc010.c                         |   8 +-
 drivers/rtc/rtc-gamecube.c                         | 377 +++++++++++++++++++++
 drivers/rtc/rtc-mc146818-lib.c                     | 182 ++++++----
 drivers/rtc/rtc-pcf2127.c                          |   2 +-
 drivers/rtc/rtc-pcf85063.c                         |  97 ++++--
 drivers/rtc/rtc-pxa.c                              |   4 +
 drivers/rtc/rtc-rs5c372.c                          | 185 +++++++++-
 drivers/rtc/rtc-rv8803.c                           |   6 +
 drivers/rtc/rtc-sunplus.c                          | 362 ++++++++++++++++++++
 include/linux/mc146818rtc.h                        |   6 +-
 25 files changed, 1390 insertions(+), 191 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/sunplus,sp7021-rtc.yaml
 create mode 100644 drivers/rtc/rtc-gamecube.c
 create mode 100644 drivers/rtc/rtc-sunplus.c

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
