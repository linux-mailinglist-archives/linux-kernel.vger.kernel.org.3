Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B9F4EE3F3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 00:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242404AbiCaWXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 18:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbiCaWXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 18:23:46 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80FB247C19;
        Thu, 31 Mar 2022 15:21:54 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 30633100002;
        Thu, 31 Mar 2022 22:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1648765309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9BpVqjZGTnV49SHC+Qsp/9gpkouodEw1HwhW2Ckg0Ec=;
        b=kIriPuh1iWn87eT/gex+u7BxEob1o8JgAgaiuWYpzlULmbalZUhfnKc+ZfRrRIxkC0JjEK
        YoBKRO8M60ajS6KyY4B5sobdEQXxMpyz6fRYOP/Ivp1Vq78GMOihdLM6MxpOTbFvctgJ5e
        TBzoOP7J35LsU1H4Xnxvw7O5wb2r2DnLjkOz8FZsBphG1kvw9zY89Lju1Ltk7QN1S8CFsl
        ZWAk/e1NuXmmWFMdrR90MyFDncwHNjCY8eszimWp5ri3ad3AMKPRipt+FsBN2F7o4b3Ei9
        JCLifiEr1fm1xRx7nOVrSb+GWfALgIWX/WnfZsbjl9tPX8RVX2v2dobXExDtKQ==
Date:   Fri, 1 Apr 2022 00:21:48 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RTC for 5.18
Message-ID: <YkYpfK5ubwafd+Rw@mail.local>
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

Here is the RTC subsystem pull request for 5.18. The bulk of the patches
are about replacing the uie_unsupported strcut rtc_device member by a
feature bit.

I also carry patches for the clk subsystem as they have the proper acks.

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-5.18

for you to fetch changes up to 915593a7a663b2ad08b895a5f3ba8b19d89d4ebf:

  rtc: check if __rtc_read_time was successful (2022-03-29 22:45:50 +0200)

----------------------------------------------------------------
RTC for 5.18

Subsystem:
 - remove uie_unsupported, all users have been converted to clear
   RTC_FEATURE_UPDATE_INTERRUPT and provide a reason
 - RTCs with an alarm with a resolution of a minute are now letting the core
   handle rounding down the alarm time
 - fix use-after-free on device removal

New driver:
 - OP-TEE RTC PTA

Drivers:
 - sun6i: Add H616 support
 - cmos: Fix the AltCentury for AMD platforms
 - spear: set range

----------------------------------------------------------------
Alexandre Belloni (31):
      dt-bindings: rtc: at91: rename rtt bindings file
      rtc: ds1685: switch to RTC_FEATURE_UPDATE_INTERRUPT
      rtc: ds1685: drop no_irq
      rtc: ds1307: switch to RTC_FEATURE_UPDATE_INTERRUPT
      rtc: mpc5121: let the core handle the alarm resolution
      rtc: mpc5121: switch to RTC_FEATURE_UPDATE_INTERRUPT
      rtc: m41t80: switch to RTC_FEATURE_UPDATE_INTERRUPT
      rtc: opal: switch to RTC_FEATURE_UPDATE_INTERRUPT
      rtc: pcf2123: switch to RTC_FEATURE_UPDATE_INTERRUPT
      rtc: pcf2123: set RTC_FEATURE_ALARM_RES_MINUTE
      rtc: pcf2127: switch to RTC_FEATURE_UPDATE_INTERRUPT
      rtc: pcf2127: set RTC_FEATURE_ALARM_RES_2S
      rtc: pcf85063: switch to RTC_FEATURE_UPDATE_INTERRUPT
      rtc: pcf85063: set RTC_FEATURE_ALARM_RES_2S
      rtc: pcf8523: switch to RTC_FEATURE_UPDATE_INTERRUPT
      rtc: pcf8523: let the core handle the alarm resolution
      rtc: pcf8563: let the core handle the alarm resolution
      rtc: pcf8563: switch to RTC_FEATURE_UPDATE_INTERRUPT
      rtc: spear: switch to devm_rtc_allocate_device
      rtc: spear: set range
      rtc: spear: drop uie_unsupported
      rtc: spear: fix spear_rtc_read_time
      rtc: add new RTC_FEATURE_ALARM_WAKEUP_ONLY feature
      rtc: efi: switch to devm_rtc_allocate_device
      rtc: efi: switch to RTC_FEATURE_UPDATE_INTERRUPT
      rtc: hym8563: switch to devm_rtc_allocate_device
      rtc: hym8563: let the core handle the alarm resolution
      rtc: hym8563: switch to RTC_FEATURE_UPDATE_INTERRUPT
      rtc: xgene: stop using uie_unsupported
      rtc: remove uie_unsupported
      clk: sunxi-ng: sun6i-rtc: include clk/sunxi-ng.h

Ali Pouladi (1):
      rtc: pl031: fix rtc features null pointer dereference

Andre Przywara (4):
      rtc: sun6i: Fix time overflow handling
      rtc: sun6i: Add support for linear day storage
      rtc: sun6i: Add support for broken-down alarm registers
      rtc: sun6i: Add Allwinner H616 support

Clément Léger (1):
      rtc: optee: add RTC driver for OP-TEE RTC PTA

Hugo Villeneuve (2):
      rtc: pcf2127: use IRQ flags obtained from device tree if available
      rtc: pcf2127: fix bug when reading alarm registers

Jiasheng Jiang (1):
      rtc: wm8350: Handle error for wm8350_register_irq

Loic Poulain (2):
      rtc: pm8xxx: Attach wake irq to device
      rtc: pm8xxx: Return -ENODEV if set_time disallowed

Mario Limonciello (1):
      rtc: mc146818-lib: Fix the AltCentury for AMD platforms

Mateusz Jończyk (1):
      rtc: mc146818-lib: fix locking in mc146818_set_time

Miaoqian Lin (1):
      rtc: gamecube: Fix refcount leak in gamecube_rtc_read_offset_from_sram

Samuel Holland (6):
      dt-bindings: rtc: sun6i: Clean up repetition
      dt-bindings: rtc: sun6i: Add H616, R329, and D1 support
      rtc: sun6i: Enable the bus clock when provided
      clk: sunxi-ng: mux: Allow muxes to have keys
      clk: sunxi-ng: Add support for the sun6i RTC clocks
      clk: sunxi-ng: sun6i-rtc: Add support for H6

Sergiu Moga (2):
      dt-bindings: rtc: convert at91sam9 bindings to json-schema
      dt-bindings: rtc: at91: Add SAMA7G5 compatible strings list

Tom Rix (1):
      rtc: check if __rtc_read_time was successful

Victor Erminpour (1):
      rtc: pcf8523: Fix GCC 12 warning

Vincent Whitchurch (1):
      rtc: fix use-after-free on device removal

 .../bindings/rtc/allwinner,sun6i-a31-rtc.yaml      |  84 ++++-
 .../devicetree/bindings/rtc/atmel,at91sam9-rtc.txt |  25 --
 .../bindings/rtc/atmel,at91sam9260-rtt.yaml        |  69 ++++
 MAINTAINERS                                        |   6 +
 drivers/clk/sunxi-ng/Kconfig                       |   5 +
 drivers/clk/sunxi-ng/Makefile                      |   2 +
 drivers/clk/sunxi-ng/ccu-sun6i-rtc.c               | 395 +++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun6i-rtc.h               |  15 +
 drivers/clk/sunxi-ng/ccu_common.h                  |   1 +
 drivers/clk/sunxi-ng/ccu_mux.c                     |   7 +
 drivers/rtc/Kconfig                                |  10 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/class.c                                |  12 +-
 drivers/rtc/interface.c                            |   7 +-
 drivers/rtc/rtc-ds1307.c                           |   2 +-
 drivers/rtc/rtc-ds1685.c                           |  16 +-
 drivers/rtc/rtc-efi.c                              |  10 +-
 drivers/rtc/rtc-gamecube.c                         |   1 +
 drivers/rtc/rtc-hym8563.c                          |  34 +-
 drivers/rtc/rtc-m41t80.c                           |   6 +-
 drivers/rtc/rtc-mc146818-lib.c                     |  22 +-
 drivers/rtc/rtc-mpc5121.c                          |  17 +-
 drivers/rtc/rtc-opal.c                             |   2 +-
 drivers/rtc/rtc-optee.c                            | 362 +++++++++++++++++++
 drivers/rtc/rtc-pcf2123.c                          |   3 +-
 drivers/rtc/rtc-pcf2127.c                          |  19 +-
 drivers/rtc/rtc-pcf85063.c                         |   3 +-
 drivers/rtc/rtc-pcf8523.c                          |  15 +-
 drivers/rtc/rtc-pcf8563.c                          |  16 +-
 drivers/rtc/rtc-pl031.c                            |   6 +-
 drivers/rtc/rtc-pm8xxx.c                           |  33 +-
 drivers/rtc/rtc-spear.c                            |  25 +-
 drivers/rtc/rtc-sun6i.c                            | 184 ++++++----
 drivers/rtc/rtc-wm8350.c                           |  11 +-
 drivers/rtc/rtc-xgene.c                            |   2 -
 include/dt-bindings/clock/sun6i-rtc.h              |  10 +
 include/linux/clk/sunxi-ng.h                       |   2 +
 include/linux/mc146818rtc.h                        |   2 +
 include/linux/rtc.h                                |   2 -
 include/linux/rtc/ds1685.h                         |   1 -
 include/uapi/linux/rtc.h                           |   3 +-
 41 files changed, 1205 insertions(+), 243 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun6i-rtc.h
 create mode 100644 drivers/rtc/rtc-optee.c
 create mode 100644 include/dt-bindings/clock/sun6i-rtc.h

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
