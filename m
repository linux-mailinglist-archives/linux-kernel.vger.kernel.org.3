Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3379545F70
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 10:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347962AbiFJIjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 04:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348111AbiFJIib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:38:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA533CFD7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:36:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFBDD60DD7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 08:36:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25CCCC34114;
        Fri, 10 Jun 2022 08:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654850194;
        bh=8CLQrzdA+jFP6P5OBG66y3p/sqqVmwPEF7Q/2guufxU=;
        h=From:To:Cc:Subject:Date:From;
        b=MMjJZGrfefP2xJhWnbP/E7Js2pkTJTeQDzsznxcmX3o1PmR+g9yrDzt6x5oznH9Lm
         mkq64HriJCAxQpplf70uLyvBG6cwTiYdG+ddWYhR+8XIqlqTm0zFwSU3sL5wjTYXaT
         EtV2aBUDJG9UdWh5+5K5m4ZXj7Qi1lSL6BptihCO5NEZKVJgsIzA+y1TRS8Ps19fEF
         rKw0NztXzE4mYbWMPyIbszqIfKPRDAEWztULG1ZT1m4S5chTmp1My2KRGRcRUGBnPl
         pKh5aRxzgWbW5SjGZnN3CTzkLJ+r6hxak26WhXu/CfDZ9FMt2d+gIEmRLXqjxbI5f8
         2GSMaiVby3sAg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nza87-00H5Gi-Og; Fri, 10 Jun 2022 09:36:31 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jamie Iles <jamie@jamieiles.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Liu Ying <victor.liu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Miaoqian Lin <linmq006@gmail.com>,
        Michal Simek <michal.simek@amd.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: [GIT PULL] irqchip fixes for 5.19, take #1
Date:   Fri, 10 Jun 2022 09:36:28 +0100
Message-Id: <20220610083628.1205136-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tglx@linutronix.de, jamie@jamieiles.com, jiaxun.yang@flygoat.com, hayashi.kunihiko@socionext.com, victor.liu@nxp.com, l.stach@pengutronix.de, linmq006@gmail.com, michal.simek@amd.com, robh@kernel.org, linux-kernel@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Here's a small set of fixes for 5.19.

The only really notable change is a fix for chained interrupts, which
were never calling into the runtime PM subsystem. Depending on the
probing order, you could end-up with configuring an irqchip that
wasn't switched on.

The rest is a small stack of of_node refcounting fixes, config
updates, fixing MIPS after the loongarch merge, and the obligaroty DT
update for one irqchip.

Please pull,

	M.

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-fixes-5.19-1

for you to fetch changes up to 6fac824f40987a54a08dfbcc36145869d02e45b1:

  irqchip/loongson-liointc: Use architecture register to get coreid (2022-06-10 08:57:19 +0100)

----------------------------------------------------------------
irqchip/genirq fixes for 5.19, take #1

- Invoke runtime PM for chained interrupts, aligning the behaviour
  with that of 'normal' interrupts

- A flurry of of_node refcounting fixes

- A fix for the recently merged loongarch that broke UP MIPS

- A configuration fix for the Xilinx interrupt controller

- Yet another new compat string for the Uniphier interrupt controller

----------------------------------------------------------------
Jamie Iles (1):
      irqchip/xilinx: Remove microblaze+zynq dependency

Jiaxun Yang (1):
      irqchip/loongson-liointc: Use architecture register to get coreid

Kunihiko Hayashi (2):
      dt-bindings: interrupt-controller/uniphier-aidet: Add bindings for NX1 SoC
      irqchip/uniphier-aidet: Add compatible string for NX1 SoC

Marc Zyngier (1):
      genirq: PM: Use runtime PM for chained interrupts

Miaoqian Lin (6):
      irqchip/gic/realview: Fix refcount leak in realview_gic_of_init
      irqchip/apple-aic: Fix refcount leak in build_fiq_affinity
      irqchip/apple-aic: Fix refcount leak in aic_of_ic_init
      irqchip/gic-v3: Fix error handling in gic_populate_ppi_partitions
      irqchip/gic-v3: Fix refcount leak in gic_populate_ppi_partitions
      irqchip/realtek-rtl: Fix refcount leak in map_interrupts

 .../bindings/interrupt-controller/socionext,uniphier-aidet.yaml   | 1 +
 drivers/irqchip/Kconfig                                           | 2 +-
 drivers/irqchip/irq-apple-aic.c                                   | 2 ++
 drivers/irqchip/irq-gic-realview.c                                | 1 +
 drivers/irqchip/irq-gic-v3.c                                      | 7 +++++--
 drivers/irqchip/irq-loongson-liointc.c                            | 8 +++++++-
 drivers/irqchip/irq-realtek-rtl.c                                 | 2 +-
 drivers/irqchip/irq-uniphier-aidet.c                              | 1 +
 kernel/irq/chip.c                                                 | 5 ++++-
 9 files changed, 23 insertions(+), 6 deletions(-)
