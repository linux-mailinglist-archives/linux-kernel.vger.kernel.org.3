Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35595471A91
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 15:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhLLOKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 09:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhLLOKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 09:10:54 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE8CC061714
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 06:10:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6F9A6CE0B63
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 14:10:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49277C341C6;
        Sun, 12 Dec 2021 14:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639318250;
        bh=b4nkLHcIwF58+Gz31lAfigiWtdjAmgXyrA4hFGlsPQU=;
        h=Date:From:To:Cc:Subject:From;
        b=2DuS3vtweRia/JR/LFsGuUjl/aJXWNREzBYmWhrUa7XDoPC9MQRbRG7HskjxYbcmS
         bl22EaEhQWyFrpTXIxdNkPsw7EFjyoqnnJxuBcxYAQbiB38r/KZGaCBOO6FrZHR9GT
         qMtV0mpdlQ+a8qRSayiCwefCQ0rZ7o8EwNdcvQF0=
Date:   Sun, 12 Dec 2021 15:10:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.16-rc5
Message-ID: <YbYC6DvAa2m9Hg0i@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d58071a8a76d779eedab38033ae4c821c30295a5:

  Linux 5.16-rc3 (2021-11-28 14:09:19 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.16-rc5

for you to fetch changes up to cab2d3fd6866e089b5c50db09dece131f85bfebd:

  bus: mhi: core: Add support for forced PM resume (2021-12-09 18:47:05 +0100)

----------------------------------------------------------------
Char/misc driver fixes for 5.16-rc5

Here are a bunch of small char/misc and other driver subsystem fixes for
5.16-rc5

Included in here are:
	- iio driver fixes for reported problems.
	- phy driver fixes for a number of reported problems.
	- mhi resume bugfix for broken hardware
	- nvmem driver fix
	- rtsx driver fix for irq issues
	- fastrpc packet parsing fix

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alyssa Ross (1):
      iio: trigger: stm32-timer: fix MODULE_ALIAS

Amelie Delaunay (1):
      phy: stm32: fix st,slow-hs-slew-rate with st,decrease-hs-slew-rate

Dan Carpenter (1):
      phy: HiSilicon: Fix copy and paste bug in error handling

Evgeny Boger (1):
      iio: adc: axp20x_adc: fix charging current reporting on AXP22x

Fabrice Gasnier (1):
      iio: adc: stm32: fix a current leak by resetting pcsel before disabling vdda

Greg Kroah-Hartman (2):
      Merge tag 'phy-fixes-5.16' of git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy into char-misc-next
      Merge tag 'iio-fixes-for-5.16b' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next

Gwendal Grignou (1):
      iio: at91-sama5d2: Fix incorrect sign extension

Jeya R (1):
      misc: fastrpc: fix improper packet size calculation

Kai-Heng Feng (1):
      misc: rtsx: Avoid mangling IRQ during runtime PM

Kister Genesis Jimenez (1):
      iio: gyro: adxrs290: fix data signedness

Lars-Peter Clausen (8):
      iio: ltr501: Don't return error code in trigger handler
      iio: kxsd9: Don't return error code in trigger handler
      iio: stk3310: Don't return error code in interrupt handler
      iio: mma8452: Fix trigger reference couting
      iio: trigger: Fix reference counting
      iio: dln2: Check return value of devm_iio_trigger_register()
      iio: itg3200: Call iio_trigger_notify_done() on error
      iio: ad7768-1: Call iio_trigger_notify_done() on error

Liam Beguin (1):
      dt-bindings: phy: zynqmp-psgtr: fix USB phy name

Loic Poulain (1):
      bus: mhi: core: Add support for forced PM resume

Lukas Bulwahn (1):
      iio: imx8qxp-adc: fix dependency to the intended ARCH_MXC config

Noralf Trønnes (1):
      iio: dln2-adc: Fix lockdep complaint

Olivier Moysan (1):
      iio: adc: stm32: fix null pointer on defer_probe error

Ralph Siemsen (1):
      nvmem: eeprom: at25: fix FRAM byte_len

Randy Dunlap (1):
      phy: ti: report 2 non-kernel-doc comments

Slark Xiao (1):
      bus: mhi: pci_generic: Fix device recovery failed issue

Srinivas Kandagatla (1):
      MAINTAINERS: add maintainer for Qualcomm FastRPC driver

Vinod Koul (6):
      phy: mvebu-cp110-utmi: Fix kernel-doc warns
      phy: qualcomm: qmp: Add missing struct documentation
      phy: qualcomm: usb-hsic: Fix the kernel-doc warn
      phy: ti: tusb1210: Fix the kernel-doc warn
      phy: qualcomm: ipq806x-usb: Fix kernel-doc style
      phy: ti: omap-usb2: Fix the kernel-doc style

Yang Yingliang (1):
      iio: accel: kxcjk-1013: Fix possible memory leak in probe and remove

 .../devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml |  2 +-
 MAINTAINERS                                        |  9 +++++
 drivers/bus/mhi/core/pm.c                          | 21 ++++++++++--
 drivers/bus/mhi/pci_generic.c                      |  2 +-
 drivers/iio/accel/kxcjk-1013.c                     |  5 ++-
 drivers/iio/accel/kxsd9.c                          |  6 ++--
 drivers/iio/accel/mma8452.c                        |  2 +-
 drivers/iio/adc/Kconfig                            |  2 +-
 drivers/iio/adc/ad7768-1.c                         |  2 +-
 drivers/iio/adc/at91-sama5d2_adc.c                 |  3 +-
 drivers/iio/adc/axp20x_adc.c                       | 18 ++--------
 drivers/iio/adc/dln2-adc.c                         | 21 +++++++-----
 drivers/iio/adc/stm32-adc.c                        |  3 +-
 drivers/iio/gyro/adxrs290.c                        |  5 +--
 drivers/iio/gyro/itg3200_buffer.c                  |  2 +-
 drivers/iio/industrialio-trigger.c                 |  1 -
 drivers/iio/light/ltr501.c                         |  2 +-
 drivers/iio/light/stk3310.c                        |  6 ++--
 drivers/iio/trigger/stm32-timer-trigger.c          |  2 +-
 drivers/misc/cardreader/rtsx_pcr.c                 |  4 ---
 drivers/misc/eeprom/at25.c                         | 38 ++++++++++------------
 drivers/misc/fastrpc.c                             | 10 +++---
 drivers/net/wireless/ath/ath11k/mhi.c              |  6 +++-
 drivers/phy/hisilicon/phy-hi3670-pcie.c            |  4 +--
 drivers/phy/marvell/phy-mvebu-cp110-utmi.c         |  4 +--
 drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c        | 26 ++++++++-------
 drivers/phy/qualcomm/phy-qcom-qmp.c                |  3 ++
 drivers/phy/qualcomm/phy-qcom-usb-hsic.c           |  2 +-
 drivers/phy/st/phy-stm32-usbphyc.c                 |  2 +-
 drivers/phy/ti/phy-am654-serdes.c                  |  2 +-
 drivers/phy/ti/phy-j721e-wiz.c                     |  2 +-
 drivers/phy/ti/phy-omap-usb2.c                     |  6 ++--
 drivers/phy/ti/phy-tusb1210.c                      |  2 +-
 include/linux/mhi.h                                | 13 ++++++++
 34 files changed, 136 insertions(+), 102 deletions(-)
