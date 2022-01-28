Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D9149FFB6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 18:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347163AbiA1RmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 12:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiA1RmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 12:42:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22270C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 09:42:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5A9B61B1D
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 17:42:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E281C340E0;
        Fri, 28 Jan 2022 17:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643391742;
        bh=Wz2gWXR3q1JSidKJ1sQ03/w/JCqeehltvieo00CPzEE=;
        h=From:To:Cc:Subject:Date:From;
        b=DfW4YqoEJYg5WkrAgCCp2XQUUxYxmuXhu2qj23+mzgulfqSFIyGAjXlswe8PjBTqe
         R0YnISGSVnn1E51W4DDRqr+hQttqvZ+jaiaE6GO5ic0TxrmqlY45M36E9A3d/n0OU4
         t+W2UA0xk8+hh5dqQCA4mkoYM01FeOwSunr7+TYBbv8NYUcmrmgWpOzT/MjDMoGUU8
         57qORgK58jV5cri0TwYdgJH/trinwhWgqa7YIfu95Zs/+/Sy7WFtHHAob1TJZ02lX2
         iaUDfVuDo0IA+nYUu9EgOTJRQRdVhfOwFDO22eJyjewAet0VzXdq9Wqr8O/xsTgroB
         JFHm6LUhVkOhw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nDVGN-003sjO-Mz; Fri, 28 Jan 2022 17:42:19 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Anup Patel <anup@brainfault.org>, Ard Biesheuvel <ardb@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hector Martin <marcan@marcan.st>,
        Jay Chen <jkchen@linux.alibaba.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Sander Vanheule <sander@svanheule.net>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] irqchip fixes for 5.17, take #1
Date:   Fri, 28 Jan 2022 17:42:17 +0000
Message-Id: <20220128174217.517041-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tglx@linutronix.de, anup@brainfault.org, ardb@kernel.org, christophe.jaillet@wanadoo.fr, geert@linux-m68k.org, geert+renesas@glider.be, marcan@marcan.st, jkchen@linux.alibaba.com, kieran.bingham+renesas@ideasonboard.com, lorenzo.pieralisi@arm.com, robh@kernel.org, sander@svanheule.net, valentin.schneider@arm.com, linux-kernel@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Here's a small collection of fixes for 5.17. Nothing stands out, only
the usual cleanups, DT updates and small-scale bug fixes.

Please pull,

	M.

The following changes since commit cd448b24c621b2b676b4fa50a4ab4e9e9da114e2:

  Merge branch irq/misc-5.17 into irq/irqchip-next (2021-12-20 14:00:47 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-fixes-5.17-1

for you to fetch changes up to c89e5eb7dcf1519e5e084ee82e0d29d4e751ddb7:

  dt-bindings: interrupt-controller: sifive,plic: Group interrupt tuples (2022-01-28 17:27:26 +0000)

----------------------------------------------------------------
irqchip fixes for 5.17, take #1

- Drop an unused private data field in the AIC driver

- Various fixes to the realtek-rtl driver

- Make the GICv3 ITS driver compile again in !SMP configurations

- Force reset of the GICv3 ITSs at probe time to avoid issues during kexec

- Yet another kfree/bitmap_free conversion

- Various DT updates (Renesas, SiFive)

----------------------------------------------------------------
Ard Biesheuvel (1):
      irqchip/gic-v3-its: Fix build for !SMP

Christophe JAILLET (1):
      irqchip/loongson-pch-ms: Use bitmap_free() to free bitmap

Geert Uytterhoeven (3):
      dt-bindings: irqchip: renesas-irqc: Add R-Car V3U support
      dt-bindings: interrupt-controller: sifive,plic: Fix number of interrupts
      dt-bindings: interrupt-controller: sifive,plic: Group interrupt tuples

Marc Zyngier (2):
      irqchip/apple-aic: Drop unused ipi_hwirq field
      irqchip/gic-v3-its: Reset each ITS's BASERn register before probe

Sander Vanheule (3):
      irqchip/realtek-rtl: Map control data to virq
      irqchip/realtek-rtl: Fix off-by-one in routing
      irqchip/realtek-rtl: Service all pending interrupts

 .../interrupt-controller/renesas,irqc.yaml         |   1 +
 .../interrupt-controller/sifive,plic-1.0.0.yaml    |  12 +-
 drivers/irqchip/irq-apple-aic.c                    |   1 -
 drivers/irqchip/irq-gic-v3-its.c                   | 123 +++++++++++++++++----
 drivers/irqchip/irq-loongson-pch-msi.c             |   2 +-
 drivers/irqchip/irq-realtek-rtl.c                  |  18 ++-
 6 files changed, 121 insertions(+), 36 deletions(-)
