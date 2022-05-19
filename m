Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EC752DAA7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 18:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241952AbiESQxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 12:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235521AbiESQxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 12:53:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208D96621C
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 09:53:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5D01B8248A
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:53:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8228BC34113;
        Thu, 19 May 2022 16:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652979195;
        bh=8SdDd4kNQpyn84GIJ8vMSihPjeysWqIkbaHFXzu18FA=;
        h=From:To:Cc:Subject:Date:From;
        b=LgScP7CPdMYuB4N2LCz/HHNm8MhOc44KsuTzkvYT9b/0MX4DYocmPY/vJ2OtPEwY0
         NyCnUKtunH/1Z2ghC9XLtVUG87mM6ouU+IvmLWSwgi8jF/l8k0d8g73M9zf9I1XjOA
         tL+4rYcNG3Fwfn58FA2L8ogbiQ6IkNAbiZ39J+uL2mL0OfUO25FL7X1XYFQR6IL4kd
         eBTllPrmnNN5qNv/IEtn2WZni0jhfgCUX5viDJPTqh5VHgw/9bXq+GCmaYgPdTuOlw
         JimzHCeI7XH6fZ3UXJxE9s44t7g+9DqCO7lK6nFZN3keidDJMhlqIYuWavYg9zVY2M
         r+CAw/OlA2nKQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nrjOj-00CURl-3m; Thu, 19 May 2022 17:53:13 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Guo Ren <guoren@kernel.org>, Haowen Bai <baihaowen@meizu.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Nathan Rossi <nathan.rossi@digi.com>,
        Oliver Upton <oupton@google.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <treding@nvidia.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] irqchip updates for 5.19
Date:   Thu, 19 May 2022 17:53:08 +0100
Message-Id: <20220519165308.998315-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tglx@linutronix.de, andrew@lunn.ch, andy.shevchenko@gmail.com, ardb@kernel.org, brgl@bgdev.pl, daniel.thompson@linaro.org, f.fainelli@gmail.com, guoren@kernel.org, baihaowen@meizu.com, jernej.skrabec@gmail.com, lkp@intel.com, krzk+dt@kernel.org, l.stach@pengutronix.de, mark.rutland@arm.com, jcmvbkbc@gmail.com, nathan.rossi@digi.com, oupton@google.com, pali@kernel.org, robh+dt@kernel.org, robin.murphy@arm.com, samuel@sholland.org, treding@nvidia.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Here are the irqchip (and related) updates for 5.19. The most visible
change is the gpiolib rework to allow for immutable irq_chip
structures. Hopefully, people will take the hint and fix their drivers
so that we can get rid off the flag quickly enough (there is already a
large number of patches on the list on the subject).

The rest is a trickle of GICv3 changes and a bunch of minor fixes all
over the shop.

Please pull,

	M.

The following changes since commit b2d229d4ddb17db541098b83524d901257e93845:

  Linux 5.18-rc3 (2022-04-17 13:57:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-5.19

for you to fetch changes up to 492449ae4f0ad96948c3e029ca00736a7f1b3d77:

  Merge branch irq/gic-v3-nmi-fixes-5.19 into irq/irqchip-next (2022-05-17 10:37:06 +0100)

----------------------------------------------------------------
irqchip updates for 5.19:

- Add new infrastructure to stop gpiolib from rewriting irq_chip
  structures behind our back. Convert a few of them, but this will
  obviously be a long effort.

- A bunch of GICv3 improvements, such as using MMIO-based invalidations
  when possible, and reducing the amount of polling we perform when
  reconfiguring interrupts.

- Another set of GICv3 improvements for the Pseudo-NMI functionality,
  with a nice cleanup making it easy to reason about the various
  states we can be in when an NMI fires.

- The usual bunch of misc fixes and minor improvements.

----------------------------------------------------------------
Daniel Thompson (1):
      irqchip/exiu: Fix acknowledgment of edge triggered interrupts

Florian Fainelli (1):
      irqchip/gic: Improved warning about incorrect type

Haowen Bai (1):
      irqchip/csky: Return true/false (not 1/0) from bool functions

Krzysztof Kozlowski (2):
      irqchip/aspeed-i2c-ic: Fix irq_of_parse_and_map() return value
      irqchip/aspeed-scu-ic: Fix irq_of_parse_and_map() return value

Lucas Stach (2):
      irqchip/imx-irqsteer: Constify irq_chip struct
      irqchip/imx-irqsteer: Add runtime PM support

Marc Zyngier (18):
      gpio: Don't fiddle with irqchips marked as immutable
      gpio: Expose the gpiochip_irq_re[ql]res helpers
      gpio: Add helpers to ease the transition towards immutable irq_chip
      gpio: tegra186: Make the irqchip immutable
      gpio: pl061: Make the irqchip immutable
      pinctrl: apple-gpio: Make the irqchip immutable
      pinctrl: msmgpio: Make the irqchip immutable
      pinctrl: amd: Make the irqchip immutable
      gpio: Update TODO to mention immutable irq_chip structures
      Documentation: Update the recommended pattern for GPIO irqchips
      Merge branch irq/gpio-immutable into irq/irqchip-next
      irqchip/gic-v3: Exposes bit values for GICR_CTLR.{IR, CES}
      irqchip/gic-v3: Detect LPI invalidation MMIO registers
      irqchip/gic-v3: Relax polling of GIC{R,D}_CTLR.RWP
      dt-bindings: interrupt-controller: arm,gic-v3: Make the v2 compat requirements explicit
      Merge branch irq/gic-v3-5.19 into irq/irqchip-next
      Merge branch irq/misc-5.19 into irq/irqchip-next
      Merge branch irq/gic-v3-nmi-fixes-5.19 into irq/irqchip-next

Mark Rutland (3):
      irqchip/gic-v3: Ensure pseudo-NMIs have an ISB between ack and handling
      irqchip/gic-v3: Refactor ISB + EOIR at ack time
      irqchip/gic-v3: Fix priority mask handling

Max Filippov (1):
      irqchip/xtensa-mx: Fix initial IRQ affinity in non-SMP setup

Nathan Rossi (1):
      irqchip/armada-370-xp: Enable MSI affinity configuration

Pali Rohár (1):
      irqchip/armada-370-xp: Do not touch Performance Counter Overflow on A375, A38x, A39x

Robin Murphy (1):
      irqchip/gic-v3: Claim iomem resources

Samuel Holland (2):
      irqchip/sun6i-r: Use NULL for chip_data
      irqchip: Add Kconfig symbols for sunxi drivers

 .../bindings/interrupt-controller/arm,gic-v3.yaml  |   8 +-
 Documentation/driver-api/gpio/driver.rst           | 175 +++++++++++---
 arch/arm/include/asm/arch_gicv3.h                  |   7 +-
 arch/arm/mach-sunxi/Kconfig                        |  12 +-
 arch/arm64/Kconfig.platforms                       |   6 +-
 arch/arm64/include/asm/arch_gicv3.h                |   6 -
 drivers/gpio/TODO                                  |  19 ++
 drivers/gpio/gpio-pl061.c                          |  32 ++-
 drivers/gpio/gpio-tegra186.c                       |  32 ++-
 drivers/gpio/gpiolib.c                             |  13 +-
 drivers/irqchip/Kconfig                            |  12 +
 drivers/irqchip/Makefile                           |   6 +-
 drivers/irqchip/irq-armada-370-xp.c                |  56 +++--
 drivers/irqchip/irq-aspeed-i2c-ic.c                |   4 +-
 drivers/irqchip/irq-aspeed-scu-ic.c                |   4 +-
 drivers/irqchip/irq-csky-apb-intc.c                |   4 +-
 drivers/irqchip/irq-gic-v3.c                       | 256 +++++++++++++--------
 drivers/irqchip/irq-gic.c                          |   6 +-
 drivers/irqchip/irq-imx-irqsteer.c                 |  16 +-
 drivers/irqchip/irq-sni-exiu.c                     |  25 +-
 drivers/irqchip/irq-sun6i-r.c                      |   6 +-
 drivers/irqchip/irq-xtensa-mx.c                    |  18 +-
 drivers/pinctrl/pinctrl-amd.c                      |  11 +-
 drivers/pinctrl/pinctrl-apple-gpio.c               |  29 +--
 drivers/pinctrl/qcom/pinctrl-msm.c                 |  53 +++--
 include/linux/gpio/driver.h                        |  16 ++
 include/linux/irq.h                                |   2 +
 include/linux/irqchip/arm-gic-v3.h                 |   2 +
 kernel/irq/debugfs.c                               |   1 +
 29 files changed, 597 insertions(+), 240 deletions(-)
