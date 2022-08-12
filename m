Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823C459111F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 14:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238862AbiHLM7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 08:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbiHLM70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 08:59:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15851A2853
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 05:59:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A419C617B6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 12:59:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10402C433C1;
        Fri, 12 Aug 2022 12:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660309165;
        bh=EJwUnM9j9t0PuddVynHwPMYp1s0y6nv9zcdvBJzjMF8=;
        h=From:To:Cc:Subject:Date:From;
        b=ieK8abTO+vn4VAzGIWvSnwUxJE8/hHRmJAPYTod2KTpzSQ9KLWjlsICyWbelYcyhS
         qrrvdw486Bb0LgM5Hc6cJnkgZhVnxBUJTM6BH7PzvGSd5VA35X7gD0XieWsM1sAj1Z
         gayE6odiknPQfK7WJHB7j/V27r2BInWHd9KzAxsaJmmrhTlsrRpiYeRDD3WBPVhDpE
         J2aCJjreU31p88aGLNSJBB5x+6yG05+nhm2f0zohJUtBmcq+mZWC4ozIfcO6wdrv+O
         HxVE6qGXlKsLFQ2j6W8Ln87/4JtyMb0kksO5J2j7MI0dBuBhvBLeLy8916E5BRXG5i
         9cF70DXIuZvLw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1oMUG2-002Ycb-HL;
        Fri, 12 Aug 2022 13:59:22 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Joerg Roedel <jroedel@suse.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] irqchip fixes for 6.0, take #1
Date:   Fri, 12 Aug 2022 13:59:10 +0100
Message-Id: <20220812125910.2227338-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tglx@linutronix.de, christophe.jaillet@wanadoo.fr, chenhuacai@loongson.cn, lvjianmin@loongson.cn, jroedel@suse.de, mikelley@microsoft.com, rdunlap@infradead.org, linux-kernel@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Here's a small set of minor fixes for 6.0: most of them are fixing the
LoongArch support that was recently merged, and the last fix addresses
a breakage introduced by the recent non-SMP irq affinity changes.

Please pull,

	M.

The following changes since commit 2bd1753e8c431fc7475c04ac8d14a4e9930f47f6:

  Merge branch irq/misc-5.20 into irq/irqchip-next (2022-07-25 09:45:34 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-fixes-6.0-1

for you to fetch changes up to a9084d888fbaaed65ded56f11d052cf8b04519a5:

  irqchip/loongson-liointc: Fix an error handling path in liointc_init() (2022-08-12 13:47:21 +0100)

----------------------------------------------------------------
irqchip fixes for 6.0, take #1

- A bunch of small fixes for the recently merged LoongArch drivers

- A leftover from the non-SMP IRQ affinity rework affecting
  the Hyper-V IOMMU code

----------------------------------------------------------------
Christophe JAILLET (1):
      irqchip/loongson-liointc: Fix an error handling path in liointc_init()

Huacai Chen (3):
      irqchip/loongson-eiointc: Fix irq affinity setting
      irqchip/loongson-eiointc: Fix a build warning
      irqchip/loongson-pch-pic: Move find_pch_pic() into CONFIG_ACPI

Marc Zyngier (1):
      irqchip/loongarch: Fix irq_domain_alloc_fwnode() abuse

Michael Kelley (1):
      iommu/hyper-v: Use helper instead of directly accessing affinity

 arch/loongarch/include/asm/irq.h       |  1 -
 drivers/iommu/hyperv-iommu.c           |  4 +---
 drivers/irqchip/irq-loongarch-cpu.c    |  2 +-
 drivers/irqchip/irq-loongson-eiointc.c | 13 +++++++----
 drivers/irqchip/irq-loongson-liointc.c |  4 ++--
 drivers/irqchip/irq-loongson-pch-msi.c |  2 +-
 drivers/irqchip/irq-loongson-pch-pic.c | 40 +++++++++++++++++-----------------
 7 files changed, 34 insertions(+), 32 deletions(-)
