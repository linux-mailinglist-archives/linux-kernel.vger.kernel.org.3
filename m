Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7264A5BC5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 13:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237617AbiBAMEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 07:04:00 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52568 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237545AbiBAMD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 07:03:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2569614EA;
        Tue,  1 Feb 2022 12:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC1DC340EB;
        Tue,  1 Feb 2022 12:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643717010;
        bh=9Vi/dbHpmTpkL5NZYzRvz2xVSV/Pl1bMaDSOJ1lpwzM=;
        h=From:To:Cc:Subject:Date:From;
        b=NAt8A4exqO2aK1xkPhHTTUnlqYyTFwAK+Tzvkc9oond8tRZ899vciTg9EDrzQiskk
         V08V+CeCYgRR99iFh8xLU8UflT88l8mOMSrtY8BY0BDtDRCCm9yq0wXGltZIB7Yrwe
         bTNvW4jpX2mdcj3kF/H18xkmgpXppRKQZpnFfgk50u30NiInsAiaMDewgw11LrkJ/I
         G9pIYXfZ7bWpYaAo2n1q0y3ByDjnRs0OTD8mx5VOoFlGwcfZqCPZTZ1AsfgbeqqLaA
         rvm6vr/NHu8wjosLdOCXsydHQUXOpwzteOFRh2JL74vfUo0Sh5sMdc772iwyu5Qo4K
         LZhf0rV38x5vg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nErse-004d46-Es; Tue, 01 Feb 2022 12:03:28 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: [PATCH 00/12] genirq: Move irqchip runtime PM over to irq domain
Date:   Tue,  1 Feb 2022 12:02:58 +0000
Message-Id: <20220201120310.878267-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl, matthias.bgg@gmail.com, grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org, tglx@linutronix.de, shawnguo@kernel.org, s.hauer@pengutronix.de, avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com, kernel@esmil.dk
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our irq_chip data structure currently suffers from two problems:

(1) the 'name' field is often dynamically populated with a reference
    to the underlying HW (DT node dame, for example)

(2) the 'parent_device' which is used to implement runtime PM is also
    dynamically populated

(3) there is at least one instance of a subsystem messing with the
    internals of irq_chip structures (gpiochip_set_irq_hooks is
    what I know about)

These things mean that although the primary use of irq_chip is to only
contain function pointers and other *static* information, the above
two fields result in these structures being copied in a number of
drivers. Eventually, it would be much better if the various drivers
would use irq_chip as an 'ops' data structure (potentially made
read-only), and keep the dynamic information somewhere more suitable.

For (2) we already have the irqdomain structure that is designed to
deal with the context in which interrupts are used, and it makes sense
to move the 'parent_device' field over to this structure. This is what
this small series is doing, with some minor cleanup on the way.

(1) and (3) will be dealt in separate series (and I don't have a good
solution for (3) yet).

Thanks,

	M.

Marc Zyngier (12):
  genirq: Allow the PM device to originate from irq domain
  irqchip/gic: Move PM device over to irq domain
  irqchip/renesas-intc-gpio: Move PM device over to irq domain
  irqchip/renesas-irqc: Move PM device over to irq domain
  irqchip/imx-intmux: Move PM device over to irq domain
  gpio: mt7621: Kill parent_device usage
  gpio: omap: Move PM device over to irq domain
  gpio: rcar: Move PM device over to irq domain
  gpio: tpmx86: Move PM device over to irq domain
  pinctrl: npcm: Fix broken references to chip->parent_device
  pinctrl: starfive: Move PM device over to irq domain
  genirq: Kill irq_chip::parent_device

 drivers/gpio/gpio-mt7621.c                |  1 -
 drivers/gpio/gpio-omap.c                  |  7 ++++---
 drivers/gpio/gpio-rcar.c                  |  2 +-
 drivers/gpio/gpio-tqmx86.c                |  3 ++-
 drivers/irqchip/irq-gic.c                 | 12 +++++------
 drivers/irqchip/irq-imx-intmux.c          |  8 +++-----
 drivers/irqchip/irq-renesas-intc-irqpin.c |  3 ++-
 drivers/irqchip/irq-renesas-irqc.c        |  3 ++-
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c | 25 +++++++++++------------
 drivers/pinctrl/pinctrl-starfive.c        |  3 ++-
 include/linux/irq.h                       |  2 --
 include/linux/irqdomain.h                 | 10 +++++++++
 kernel/irq/chip.c                         | 20 +++++++++++++-----
 13 files changed, 59 insertions(+), 40 deletions(-)

-- 
2.30.2

