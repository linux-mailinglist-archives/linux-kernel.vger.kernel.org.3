Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8316D4AF6A1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236985AbiBIQ1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236894AbiBIQ00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:26:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850EDC05CB8E;
        Wed,  9 Feb 2022 08:26:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A7ABB822D1;
        Wed,  9 Feb 2022 16:26:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE65C340EE;
        Wed,  9 Feb 2022 16:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644423978;
        bh=MRbUczyI2MxyyUekUmARNowdQaSt4+OAXAfxdGF+cjw=;
        h=From:To:Cc:Subject:Date:From;
        b=cZWJh6dWKuwLXww8rTdHjvBoqL6fV44lWmMne0IA4lJ9ivhcV761mwmhF2zJeG3h+
         aCa9LVm1bc1N1QtoSbRIvj8cBmI6KGARumsTJogeiLuU3Kkc2wthaoCIp/M/SSDJUi
         svmEVR0mpCvx9ukLWZY468fX54ZGuXIRRPtKQ/QYFP6AmUhf8curB/pW2sbAHkVl3C
         76Cgmw5jZy6WZPN0sdn3iN0YLm6EIJUVOMyUv7589U8Uw1yQmsIzbvxtmseZl0oi5I
         XoBu+UeQOZNJdTBjd/Y/OaJN0QR7vVI//e4IrMYY5ErWLoF0OIKPz5EidhgBBakjdK
         iGiBfFigYhU/w==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nHpnL-006fgT-Sd; Wed, 09 Feb 2022 16:26:15 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        kernel-team@android.com
Subject: [PATCH 00/10] irqchip: Prevent drivers abusing irq_chip::name
Date:   Wed,  9 Feb 2022 16:25:57 +0000
Message-Id: <20220209162607.1118325-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl, matthias.bgg@gmail.com, grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org, tony@atomide.com, tglx@linutronix.de, vz@mleia.com, andrew@lunn.ch, gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, kernel@esmil.dk, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another common abuse in irqchip drivers (and derivatives) is to place
a string representing the underlying device in the irq_chip::name
field that gets displayed in /proc/interrupts while this should only
be an indication of the "type" of interrupt controller.

Not only this is pretty pointless (with hierarchical domains, you only
see the top chip), but it also gets in the way of making the irq_chip
structure const. For debug, we have a whole infrastructure that does
everything you can imagine (and stuff you don't want to).

We can't remove this name as it is visible from userspace and there is
a whole collection of CI scripts that parse /proc/interrupts for good
(and mostly bad) reasons. The solution is to use the irq_print_chip()
callback and to let it output whatever string is necessary.

Having done that, we can cleanup a few irqchip drivers and make their
irq_chip structure const (which requires touching a handful of core
functions). Whilst we're at it, we do the same for a couple of gpio
drivers.

This series relies on the one posted at [1].

Thanks,

	M.

[1] https://lore.kernel.org/r/20220201120310.878267-1-maz@kernel.org

Marc Zyngier (10):
  irqdomain: Let irq_domain_set_{info,hwirq_and_chip} take a const
    irq_chip
  genirq: Allow irq_chip registration functions to take a const irq_chip
  irqchip/gic: Switch to dynamic chip name output
  irqchip/lpc32xx: Switch to dynamic chip name output
  irqchip/mvebu-pic: Switch to dynamic chip name output
  irqchip/ts4800: Switch to dynamic chip name output
  irqchip/versatile-fpga: Switch to dynamic chip name output
  gpio: mt7621: Switch to dynamic chip name output
  gpio: omap: Switch to dynamic chip name output
  pinctrl: starfive: Switch to dynamic chip name output

 drivers/gpio/gpio-mt7621.c             |  12 ++-
 drivers/gpio/gpio-omap.c               |  28 ++++---
 drivers/irqchip/irq-ftintc010.c        |   1 -
 drivers/irqchip/irq-gic.c              | 102 +++++++++++++------------
 drivers/irqchip/irq-lpc32xx.c          |  34 ++++++---
 drivers/irqchip/irq-mvebu-pic.c        |  28 ++++---
 drivers/irqchip/irq-ts4800.c           |  25 ++++--
 drivers/irqchip/irq-versatile-fpga.c   |  46 ++++++-----
 drivers/pinctrl/pinctrl-starfive.c     |  11 ++-
 include/linux/irq.h                    |   7 +-
 include/linux/irqchip/versatile-fpga.h |  14 ----
 include/linux/irqdomain.h              |   5 +-
 kernel/irq/chip.c                      |   9 +--
 kernel/irq/irqdomain.c                 |   7 +-
 14 files changed, 189 insertions(+), 140 deletions(-)
 delete mode 100644 include/linux/irqchip/versatile-fpga.h

-- 
2.30.2

