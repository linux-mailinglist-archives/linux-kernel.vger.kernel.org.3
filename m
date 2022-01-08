Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6A84883AC
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 14:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbiAHNIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 08:08:14 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49014 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiAHNIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 08:08:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A768560EEE
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 13:08:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBDEC36AE5;
        Sat,  8 Jan 2022 13:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641647292;
        bh=7OHpchT7gk+z3F1vBeNXwLcb+MmcdrX9sR5fbNLCURk=;
        h=From:To:Cc:Subject:Date:From;
        b=e+vjMGzARMo77LRWvyX0ezlb5VrGxQgYZA6C5G7TMMxou7HFEdJT6gm0G4qehEe+a
         f292hfOIE2Jwul3ZmB1IO2ioSIzrtl0bSCtzKO2ZFdCupwDfbt5D/tsiGurJFK1bH2
         B+Qt4swILwHO/ZpohdkLeD2L5d6PhgDvYoh/k7H94/VWLtgd2A6HlQ8J7v7EghgcUz
         0V5J4WF00ajvJEMYboB/SSpgxyawp8DMoHTI7o02Xy1ofzqKq7ntlviwWf6zm7vJ2Y
         OBmkCkmhW6G/EgxIt6a4qPD5ozxXeBeawrpSvIqSj2jJeP8rtbzBGxguvZWUD7ICba
         CDki1Z70XYwdw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1n6BS5-00Gl2q-Sh; Sat, 08 Jan 2022 13:08:10 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Herve Codina <herve.codina@bootlin.com>,
        Jay Chen <jkchen@linux.alibaba.com>,
        Kees Cook <keescook@chromium.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] irqchip updates for 5.17
Date:   Sat,  8 Jan 2022 13:08:07 +0000
Message-Id: <20220108130807.4109738-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tglx@linutronix.de, arnd@arndb.de, geert+renesas@glider.be, herve.codina@bootlin.com, jkchen@linux.alibaba.com, keescook@chromium.org, prabhakar.mahadev-lad.rj@bp.renesas.com, linus.walleij@linaro.org, lorenzo.pieralisi@arm.com, l.stach@pengutronix.de, peng.fan@nxp.com, valentin.schneider@arm.com, viresh.kumar@linaro.org, wangxiang@cdjrlc.com, linux-kernel@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

This is the smallest set of irqchip updates ever. Not due to a lack of
activity, but mostly that the stuff that is in flight doesn't seem to
be quire ready. Given the size of the upcoming MSI changes, this is
probably for the best.

Anyway, not much here, apart from Valentin's Kexec+RT GICv3 ITS fix
and another one for GICv4.1. The rest is a boring mix of small scale
updates and cleanups.

Please pull,

	M.

The following changes since commit 0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1:

  Linux 5.16-rc4 (2021-12-05 14:08:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-5.17

for you to fetch changes up to cd448b24c621b2b676b4fa50a4ab4e9e9da114e2:

  Merge branch irq/misc-5.17 into irq/irqchip-next (2021-12-20 14:00:47 +0000)

----------------------------------------------------------------
irqchip updates for 5.17

- Fix GICv3 redistributor table reservation with RT across kexec

- Fix GICv4.1 redistributor view of the VPE table across kexec

- Add support for extra interrupts on spear-shirq

- Make obtaining some interrupts optional for the Renesas drivers

- Various cleanups and bug fixes

----------------------------------------------------------------
Herve Codina (1):
      irqchip/spear-shirq: Add support for IRQ 0..6

Kees Cook (1):
      irqchip/ingenic-tcu: Use correctly sized arguments for bit field

Lad Prabhakar (2):
      irqchip/renesas-irqc: Use platform_get_irq_optional() to get the interrupt
      irqchip/renesas-intc-irqpin: Use platform_get_irq_optional() to get the interrupt

Marc Zyngier (3):
      Merge branch irq/its-kexec-rt into irq/irqchip-next
      irqchip/gic-v4: Disable redistributors' view of the VPE table at boot time
      Merge branch irq/misc-5.17 into irq/irqchip-next

Peng Fan (1):
      irqchip/imx-gpcv2: Mark imx_gpcv2_instance with __ro_after_init

Valentin Schneider (3):
      irqchip/gic-v3-its: Give the percpu rdist struct its own flags field
      irqchip/gic-v3-its: Postpone LPI pending table freeing and memreserve
      irqchip/gic-v3-its: Limit memreserve cpuhp state lifetime

Xiang wangx (1):
      irqchip/gic-v2m: Add const to of_device_id

 drivers/irqchip/irq-gic-v2m.c             |  2 +-
 drivers/irqchip/irq-gic-v3-its.c          | 82 ++++++++++++++++++++++++++++---
 drivers/irqchip/irq-gic-v3.c              | 17 +++++++
 drivers/irqchip/irq-imx-gpcv2.c           |  2 +-
 drivers/irqchip/irq-ingenic-tcu.c         |  4 +-
 drivers/irqchip/irq-renesas-intc-irqpin.c |  9 ++--
 drivers/irqchip/irq-renesas-irqc.c        |  9 ++--
 drivers/irqchip/spear-shirq.c             |  2 +
 include/linux/irqchip/arm-gic-v3.h        |  4 +-
 9 files changed, 112 insertions(+), 19 deletions(-)
