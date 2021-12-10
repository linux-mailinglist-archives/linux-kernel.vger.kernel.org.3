Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7864701B4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 14:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241895AbhLJNjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 08:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238651AbhLJNjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 08:39:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3877C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 05:35:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA8BEB827EC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 13:35:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8903CC00446;
        Fri, 10 Dec 2021 13:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639143337;
        bh=VhvC0brUwGyRh/apvs6b8MerVzCShEtLhUr5tRJNjKU=;
        h=From:To:Cc:Subject:Date:From;
        b=Wq8RJhfOBLkT4Bx+OhWlJjSPzm4tbqIBmsNd90uaASNEtwWt1JnAFQ9wCPRVXVC59
         dFg08oB5spkx7PgchjUqEJkfvj1v5ZkP5VkGdnWSdY4tTwYwMDjsj3/G4gyq3q3xMj
         AZItZ4mODwe5+2U5RbYBhEYUx3w2pC4r84OAiGFkNJuLFCZqjdbx4cFDINP7dBGHF0
         0ifObGEWGpoQyRMaJT9dy6lXIlRvyNvIh+Y6mlcQPoxdOsYvrv8SpIWBr1WS2QJEc9
         l2jzUwuaoWHY4+0Ir9gdWkE5OBpUMI0Hqpy1F9wpok8ZzXssAVxDJ/KNaVFSRe6Z6m
         VosL6kTKAg+MQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mvg3j-00BGRz-Ge; Fri, 10 Dec 2021 13:35:35 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Billy Tsai <billy_tsai@aspeedtech.com>,
        Donghyeok Kim <dthex5d@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hector Martin <marcan@marcan.st>,
        Joel Stanley <joel@jms.id.au>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Wudi Wang <wangwudi@hisilicon.com>,
        Ye Guojin <ye.guojin@zte.com.cn>, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: [GIT PULL] irqchip fixes for 5.16, take #2
Date:   Fri, 10 Dec 2021 13:35:16 +0000
Message-Id: <20211210133516.664497-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tglx@linutronix.de, billy_tsai@aspeedtech.com, dthex5d@gmail.com, f.fainelli@gmail.com, geert+renesas@glider.be, marcan@marcan.st, joel@jms.id.au, pali@kernel.org, zhangshaokun@hisilicon.com, vladimir.murzin@arm.com, wangwudi@hisilicon.com, ye.guojin@zte.com.cn, linux-kernel@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Here's another set of irqchip fixes for 5.16. The main ones are the
MSI allocation fixes for an old Marvell system, another for the Aspeed
SCU driver acking interrupts the wrong way, and one for the ARM NVIC
having the wrong offset of one of the registers.

We also gained a fix for the GICv3 ITS INVALL command, as well as some
more tidying up (bcm7180-l2, Apple AIC).

Please pull,

	M.

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-fixes-5.16-2

for you to fetch changes up to c3fbab7767c53397d7b849799474f5a27cf306e6:

  irqchip/irq-bcm7120-l2: Add put_device() after of_find_device_by_node() (2021-12-10 13:23:13 +0000)

----------------------------------------------------------------
irqchip fixes for Linux 5.16, take #2

- Fix Armada-370-XP Multi-MSi allocation to be aligned on the allocation
  size, as required by the PCI spec

- Fix aspeed-scu interrupt acknowledgement by directly writing to the
  register instead of a read-modify-write sequence

- Use standard bitfirl helpers in the MIPS GIC driver instead of custom
  constructs

- Fix the NVIC driver IPR register offset

- Correctly drop the reference of the device node in the irq-bcm7120-l2
  driver

- Fix the GICv3 ITS INVALL command by issueing a following SYNC command

- Add a missing __init attribute to the init function of the Apple AIC
  driver

----------------------------------------------------------------
Billy Tsai (1):
      irqchip/aspeed-scu: Replace update_bits with write_bits.

Donghyeok Kim (1):
      irqchip/apple-aic: Mark aic_init_smp() as __init

Geert Uytterhoeven (1):
      irqchip/mips-gic: Use bitfield helpers

Pali Rohár (2):
      irqchip/armada-370-xp: Fix return value of armada_370_xp_msi_alloc()
      irqchip/armada-370-xp: Fix support for Multi-MSI interrupts

Vladimir Murzin (1):
      irqchip: nvic: Fix offset for Interrupt Priority Offsets

Wudi Wang (1):
      irqchip/irq-gic-v3-its.c: Force synchronisation when issuing INVALL

Ye Guojin (1):
      irqchip/irq-bcm7120-l2: Add put_device() after of_find_device_by_node()

 drivers/irqchip/irq-apple-aic.c     |  2 +-
 drivers/irqchip/irq-armada-370-xp.c | 16 ++++++----------
 drivers/irqchip/irq-aspeed-scu-ic.c |  4 ++--
 drivers/irqchip/irq-bcm7120-l2.c    |  1 +
 drivers/irqchip/irq-gic-v3-its.c    |  2 +-
 drivers/irqchip/irq-mips-gic.c      |  4 ++--
 drivers/irqchip/irq-nvic.c          |  2 +-
 7 files changed, 14 insertions(+), 17 deletions(-)
