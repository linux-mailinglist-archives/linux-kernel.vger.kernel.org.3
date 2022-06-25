Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9AE55AB17
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 16:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbiFYOmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 10:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbiFYOmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 10:42:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CC93888
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 07:42:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A5F761479
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 14:42:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E0CC3411C;
        Sat, 25 Jun 2022 14:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656168156;
        bh=ongBppDZRVt74/IiSF9YDkj9uiqgPwkA0VINPVGpGK8=;
        h=Date:From:To:Cc:Subject:From;
        b=Rz6fGJFR32EbqJ8DPB6YCsGd3RUy/li+cYEs4JSpoDAznb2jU1yuRqu5ncHBAQd0h
         60bh8pfBkCy0rJsE/CfAGAnq1ngktL+5i9y1zz6MHe8y98NnjBC8PVzlyUokAh+Lo0
         1SlM+ZQA5rZ208ejl5IoAdsJMIVNPM9Ljef1H6j8=
Date:   Sat, 25 Jun 2022 16:42:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] IIO driver fixes 5.19-rc4
Message-ID: <Yrce2fjrifRMqjBb@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a111daf0c53ae91e71fd2bfe7497862d14132e3e:

  Linux 5.19-rc3 (2022-06-19 15:06:47 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.19-rc4

for you to fetch changes up to 315f7e15c261167ea71c1a4cce2a18ca30e990ea:

  Merge tag 'iio-fixes-for-5.19a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next (2022-06-20 09:49:52 +0200)

----------------------------------------------------------------
IIO driver fixes for 5.19-rc4

Here are a set of IIO driver fixes for 5.19-rc4.  Jonathan said it best
in his pull request to me, so I'll just quote it here below, as that's
the only changes we have right now for the char-misc driver tree:

    1st set of IIO fixes for the 5.19 cycle.

    Most of these have been in next for a long time. Unfortunately there
    was one stray patch in the branch (wasn't a fix), so I've just rebased
    to remove that.

    * testing
      - Fix a missing MODULE_LICENSE() warning by restricting possible build
        configs.
    * Various drivers
      - Fix ordering of iio_get_trigger() being called before
        iio_trigger_register()
    * adi,admv1014
      - Fix dubious x & !y warning.
    * adi,axi-adc
      - Fix missing of_node_put() in error and normal paths.
    * aspeed,adc
      - Add missing of_node_put()
    * fsl,mma8452
      - Fix broken probing from device tree.
      - Drop check on return value of i2c write to device to cause reset as
        ACK will be missing (device reset before sending it).
    * fsl,vf610
      - Fix documentation of in_conversion_mode ABI.
    * iio-trig-sysfs
      - Ensure irq work has finished before freeing the trigger.
    * invensense,mpu3050
     - Disable regulators in error path.
    * invensense,icm42600
      - Fix collision of enum value of 0 with error path where 0 is no match.
    * renesas,rzg2l_Adc
      - Add missing fwnode_handle_put() in error path.
    * rescale
      - Fix a boolean logic bug for detection of raw + scale affecting an
        obscure corner case.
    * semtech,sx9324
      - Check return value of read of pin_defs
    * st,stm32-adc:
      - Fix interaction across ADC instances for some supported devices.
      - Drop false spurious IRQ messages.
      - Fix calibration value handling.  If we can't calibrate don't expose the
        vref_int channel.
      - Fix maximum clock rate for stm32pm15x
    * ti,ads131e08
      - Add missing fwnode_handle_put() in error paths.
    * xilinx,ams
      - Fix variable checked for error from platform_get_irq()
    * x-powers,axp288
      - Overide TS_PIN bias current for boards where it is not correctly
        initialized.
    * yamaha,yas530
      - Fix inverted check on calibration data being all zeros.

All of these have been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Aashish Sharma (1):
      iio:proximity:sx9324: Check ret value of device_property_read_u32_array()

Antoniu Miclaus (1):
      iio: freq: admv1014: Fix warning about dubious x & !y and improve readability

Baruch Siach (1):
      iio: adc: vf610: fix conversion mode sysfs node name

Dmitry Rokosov (5):
      iio:accel:bma180: rearrange iio trigger get and register
      iio:accel:kxcjk-1013: rearrange iio trigger get and register
      iio:accel:mxc4005: rearrange iio trigger get and register
      iio:chemical:ccs811: rearrange iio trigger get and register
      iio:humidity:hts221: rearrange iio trigger get and register

Greg Kroah-Hartman (1):
      Merge tag 'iio-fixes-for-5.19a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next

Haibo Chen (2):
      iio: mma8452: fix probe fail when device tree compatible is used.
      iio: accel: mma8452: ignore the return value of reset operation

Hans de Goede (1):
      iio: adc: axp288: Override TS pin bias current for some models

Jean-Baptiste Maneyrol (1):
      iio: imu: inv_icm42600: Fix broken icm42600 (chip id 0 value)

Jialin Zhang (2):
      iio: adc: rzg2l_adc: add missing fwnode_handle_put() in rzg2l_adc_parse_properties()
      iio: adc: ti-ads131e08: add missing fwnode_handle_put() in ads131e08_alloc_channels()

Liam Beguin (1):
      iio: test: fix missing MODULE_LICENSE for IIO_RESCALE=m

Linus Walleij (2):
      iio: magnetometer: yas530: Fix memchr_inv() misuse
      iio: afe: rescale: Fix boolean logic bug

Lv Ruyi (1):
      iio: adc: xilinx-ams: fix return error variable

Miaoqian Lin (2):
      iio: adc: aspeed: Fix refcount leak in aspeed_adc_set_trim_data
      iio: adc: adi-axi-adc: Fix refcount leak in adi_axi_adc_attach_client

Olivier Moysan (2):
      iio: adc: stm32: fix vrefint wrong calibration value handling
      iio: adc: stm32: fix maximum clock rate for stm32mp15x

Vincent Whitchurch (1):
      iio: trigger: sysfs: fix use-after-free on remove

Yannick Brosseau (2):
      iio: adc: stm32: Fix ADCs iteration in irq handler
      iio: adc: stm32: Fix IRQs on STM32F4 by removing custom spurious IRQs message

Zheyu Ma (1):
      iio: gyro: mpu3050: Fix the error handling in mpu3050_power_up()

 Documentation/ABI/testing/sysfs-bus-iio-vf610    |  2 +-
 drivers/iio/accel/bma180.c                       |  3 +-
 drivers/iio/accel/kxcjk-1013.c                   |  4 +--
 drivers/iio/accel/mma8452.c                      | 22 +++++++++-----
 drivers/iio/accel/mxc4005.c                      |  4 +--
 drivers/iio/adc/adi-axi-adc.c                    |  3 ++
 drivers/iio/adc/aspeed_adc.c                     |  1 +
 drivers/iio/adc/axp288_adc.c                     |  8 +++++
 drivers/iio/adc/rzg2l_adc.c                      |  8 +++--
 drivers/iio/adc/stm32-adc-core.c                 |  9 ++++--
 drivers/iio/adc/stm32-adc.c                      | 37 +++++++++++-------------
 drivers/iio/adc/ti-ads131e08.c                   | 10 +++++--
 drivers/iio/adc/xilinx-ams.c                     |  2 +-
 drivers/iio/afe/iio-rescale.c                    |  2 +-
 drivers/iio/chemical/ccs811.c                    |  4 +--
 drivers/iio/frequency/admv1014.c                 |  6 ++--
 drivers/iio/gyro/mpu3050-core.c                  |  1 +
 drivers/iio/humidity/hts221_buffer.c             |  5 +++-
 drivers/iio/imu/inv_icm42600/inv_icm42600.h      |  1 +
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c |  2 +-
 drivers/iio/magnetometer/yamaha-yas530.c         |  2 +-
 drivers/iio/proximity/sx9324.c                   |  3 ++
 drivers/iio/test/Kconfig                         |  2 +-
 drivers/iio/test/Makefile                        |  2 +-
 drivers/iio/trigger/iio-trig-sysfs.c             |  1 +
 25 files changed, 92 insertions(+), 52 deletions(-)
