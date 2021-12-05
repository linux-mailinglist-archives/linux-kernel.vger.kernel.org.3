Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282FA468C29
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 17:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235985AbhLEQvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 11:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235974AbhLEQvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 11:51:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF975C061714
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 08:47:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0BF060FB8
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 16:47:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F13FC00446;
        Sun,  5 Dec 2021 16:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638722865;
        bh=+yfuxGHH/boxA3z0YtHX/paskrhQqphVNrDTnwKt5Y8=;
        h=From:To:Cc:Subject:Date:From;
        b=IKgMGzv5qvH3xLHa3u5o+CiOufkgh5mGky50EcTLsHG8/hjK0gsxZAV7WuOKcsQ1x
         CiEbTeby1vsyhJA7m7jBwVZnedAPmWZ/I2mw8VXonLtX5uY0OneC2CIBbiWZk9sXDA
         aVQ2clxID2TNiIxe5IUrtbaPTsMtqgIFIrzbE1KiPMi6znviLjmHXvUIR/u0gmMD67
         +vpeuzM1CJUKPJPzZsETB3Az+GthMIRowPPbLnUOY6Y3uCAYK3EAs+A1sEn6XQ3oSD
         DO070Hp5K8EQHRm3cbfY555qiHPhdhEkk72BYGppMgH0IZ3GsuKX/oYAEnXwNELmxY
         dyTfZz35i61+w==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mtufu-00A02h-Sl; Sun, 05 Dec 2021 16:47:42 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Billy Tsai <billy_tsai@aspeedtech.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Joel Stanley <joel@jms.id.au>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] irqchip fixes for 5.16, take #2
Date:   Sun,  5 Dec 2021 16:47:21 +0000
Message-Id: <20211205164721.541659-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tglx@linutronix.de, billy_tsai@aspeedtech.com, geert+renesas@glider.be, joel@jms.id.au, pali@kernel.org, vladimir.murzin@arm.com, linux-kernel@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas,

Here's another set of irqchip fixes for 5.16. The main ones are the
MSI allocation fixes for an old Marvell system, another for the Aspeed
SCU driver acking interrupts the wrong way, and one for the ARM NVIC
having the wrong offset of one of the registers.

Please pull,

	M.

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-fixes-5.16-2

for you to fetch changes up to c5e0cbe2858d278a27d5b3fe31890aea5be064c4:

  irqchip: nvic: Fix offset for Interrupt Priority Offsets (2021-12-02 09:27:06 +0000)

----------------------------------------------------------------
irqchip fixes for Linux 5.16, take #2

- Fix Armada-370-XP Multi-MSi allocation to be aligned on the allocation
  size, as required by the PCI spec

- Fix aspeed-scu interrupt acknowledgement by directly writing to the
  register instead of a read-modify-write sequence

- Use standard bitfirl helpers in the MIPS GIC driver instead of custom
  constructs

- Fix the NVIC driver IPR register offset

----------------------------------------------------------------
Billy Tsai (1):
      irqchip/aspeed-scu: Replace update_bits with write_bits.

Geert Uytterhoeven (1):
      irqchip/mips-gic: Use bitfield helpers

Pali Rohár (2):
      irqchip/armada-370-xp: Fix return value of armada_370_xp_msi_alloc()
      irqchip/armada-370-xp: Fix support for Multi-MSI interrupts

Vladimir Murzin (1):
      irqchip: nvic: Fix offset for Interrupt Priority Offsets

 drivers/irqchip/irq-armada-370-xp.c | 16 ++++++----------
 drivers/irqchip/irq-aspeed-scu-ic.c |  4 ++--
 drivers/irqchip/irq-mips-gic.c      |  4 ++--
 drivers/irqchip/irq-nvic.c          |  2 +-
 4 files changed, 11 insertions(+), 15 deletions(-)
