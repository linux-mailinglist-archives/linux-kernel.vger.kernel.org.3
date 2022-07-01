Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655DB56346B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 15:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiGANfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 09:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGANfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 09:35:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1775E15FD8
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 06:35:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD530B818DF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 13:35:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E4FC3411E;
        Fri,  1 Jul 2022 13:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656682536;
        bh=ea6K3pTQyXz3luSTBcUsdGmrd/UJfdlEaIKBRM6wfRs=;
        h=From:To:Cc:Subject:Date:From;
        b=PPzEhyUW63VZry9s8gydtS7CB76QvSbkSy60jM9NWt0V48/yT7YEA+C0kYucE6ygt
         RzaQX7ciJKV49e1xjDQpYwAEmW/CymNA0q/FvuMOWDz9nBfnTEdN0xq3pciYS6fxFV
         QPIFAXzEq2pskBXUKDc2V2vVmTOxHP14lFUakavNmd0uC7ttADuoSF3iPKALdmrGzk
         KxZfgOd6PCyi7+Ica/pKQBvxaUI8VED09OpXC5TRqdgn9qwqUEOgB5P4k2gL0P8MJQ
         jBBzVZZDL2PfXuBp3Q61l+eJRWNbqPFghST6mt6oI/7R1ahkdNQKIqUMXn2bOeMLRa
         5Zn+RicnudBJg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1o7Go2-004b9k-5o;
        Fri, 01 Jul 2022 14:35:34 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Hector Martin <marcan@marcan.st>, Jamie Iles <jamie@jamieiles.com>,
        Matt Ranostay <mranostay@ti.com>,
        Michal Simek <michal.simek@amd.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] irqchip fixes for 5.19, take #2
Date:   Fri,  1 Jul 2022 14:35:31 +0100
Message-Id: <20220701133531.1545319-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tglx@linutronix.de, marcan@marcan.st, jamie@jamieiles.com, mranostay@ti.com, michal.simek@amd.com, robin.murphy@arm.com, weiyongjun1@huawei.com, linux-kernel@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Here's a tiny set of fixes for 5.19. Most of it is on the cosmetic
side of things, save for the GIC patch that fixes a regression on a
platform with pretty funky firmware tables...

Please pull,

	M.

The following changes since commit 6fac824f40987a54a08dfbcc36145869d02e45b1:

  irqchip/loongson-liointc: Use architecture register to get coreid (2022-06-10 08:57:19 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-fixes-5.19-2

for you to fetch changes up to 1357d2a65601bc0afb221672d5a8f1649063a141:

  irqchip/apple-aic: Make symbol 'use_fast_ipi' static (2022-07-01 14:26:13 +0100)

----------------------------------------------------------------
irqchip fixes for 5.19, take #2

- Gracefully handle failure to request MMIO resources in the GICv3 driver

- Make a static key static in the Apple AIC driver

- Fix the Xilinx intc driver dependency on OF_ADDRESS

----------------------------------------------------------------
Jamie Iles (1):
      irqchip/xilinx: Add explicit dependency on OF_ADDRESS

Robin Murphy (1):
      irqchip/gicv3: Handle resource request failure consistently

Wei Yongjun (1):
      irqchip/apple-aic: Make symbol 'use_fast_ipi' static

 drivers/irqchip/Kconfig         |  2 +-
 drivers/irqchip/irq-apple-aic.c |  2 +-
 drivers/irqchip/irq-gic-v3.c    | 41 +++++++++++++++++++++++++++++++----------
 3 files changed, 33 insertions(+), 12 deletions(-)
