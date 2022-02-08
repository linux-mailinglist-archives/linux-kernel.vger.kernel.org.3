Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6374AE19A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385566AbiBHS5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353465AbiBHS5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:57:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DE2C0613CB;
        Tue,  8 Feb 2022 10:57:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1575A613F8;
        Tue,  8 Feb 2022 18:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68983C004E1;
        Tue,  8 Feb 2022 18:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644346624;
        bh=JI4DEvYaY6EOL+Uro39kJ5nMr68u1NR9D7nmYx+BQCA=;
        h=From:To:Cc:Subject:Date:From;
        b=YdhcaZfap181gsTUJQKhQwRXtE/rFTSeZAMQXZuB5IOmbJntWIPHvZHA32n2L2Dqq
         VTqBugrj41q61o1KIII5r/Qgrq56TgOOXSzuCHXCujZhbGpzuBgYXKh+QXBIuUpw1e
         UThiDdpvlT/ownHTGOdKSvdciCRNTDeHDHRGMJPeE7SXCsVpFLpLdOzIhysQ5nNwV7
         VeMgLa1xYdqVIv/JEdkEPV3ZEIWP4m5paZ5ZHyf0QlTwuSApkSjesF50qFZwGzPbBN
         RjMK+ZAnXD1paCF0uu3V7f6bYZ4ngvjpwWCw6aMV7H7uUnQ/fldt1JjNULjYiT3kkc
         n6D0EjKaD+8bw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nHVfh-006MEi-V5; Tue, 08 Feb 2022 18:57:02 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dougall <dougallj@gmail.com>, kernel-team@android.com
Subject: [PATCH v5 00/10] drivers/perf: CPU PMU driver for Apple M1
Date:   Tue,  8 Feb 2022 18:55:54 +0000
Message-Id: <20220208185604.1097957-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, will@kernel.org, marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io, robh+dt@kernel.org, tglx@linutronix.de, dougallj@gmail.com, kernel-team@android.com
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

The M1 SoC embeds a per-CPU PMU that has a very different programming
interface compared to the architected PMUv3 that is normally present
on standard implementations.

This small series adds a driver for this HW by leveraging the arm_pmu
infrastructure, resulting in a rather simple driver.

Of course, we know next to nothing about the actual events this PMU
counts, aside from CPU cycles and instructions. Everything else is
undocumented (though as Dougall pointed out, someone could extract the
relevant information from a macOS install if they wanted -- I don't).
I'm looking at allowing the perf userspace tool to load the event
descriptions at runtime, which would probably help.

* From v4 [4]:
  - More DT binding tweaks
  - Collected RB from Rob
  - Rebased on 5.17-rc3

* From v3 [3]:
  - DT binding fixes
  - Typo fixes (and probably more added)
  - Rebased on 5.17-rc1

* From v2 [2]:
  - Reworked the way the FIQ virtual affinity is exposed (now coming
    from the DT instead of being internal to the irqchip driver)
  - Dropped the locking from the PMU driver after Mark's review
  - Required the exclude_guest flag to be set, as the PMU doesn't seem
    to be able to count guest events, at least by default
  - Dropped the counter-stop on interrupt and instead stop the whole
    PMU on interrupt
  - Dropped the kernel taint, as I couldn't find a good way to do that
    on first use
  - Collected RBs from Hector

* From v1 [1]:
  - Added a few comments clarifying the event mapping to counters
  - Spelling fixes
  - Collected Acks from Rob

[1] https://lore.kernel.org/r/20211113115429.4027571-1-maz@kernel.org
[2] https://lore.kernel.org/r/20211201134909.390490-1-maz@kernel.org
[3] https://lore.kernel.org/r/20211214182634.727330-1-maz@kernel.org
[4] https://lore.kernel.org/r/20220124201231.298961-1-maz@kernel.org

Marc Zyngier (10):
  dt-bindings: arm-pmu: Document Apple PMU compatible strings
  dt-bindings: apple,aic: Add CPU PMU per-cpu pseudo-interrupts
  dt-bindings: apple,aic: Add affinity description for per-cpu
    pseudo-interrupts
  irqchip/apple-aic: Parse FIQ affinities from device-tree
  irqchip/apple-aic: Wire PMU interrupts
  arm64: dts: apple: Add t8103 PMU interrupt affinities
  arm64: dts: apple: Add t8303 PMU nodes
  irqchip/apple-aic: Move PMU-specific registers to their own include
    file
  drivers/perf: arm_pmu: Handle 47 bit counters
  drivers/perf: Add Apple icestorm/firestorm CPU PMU driver

 .../devicetree/bindings/arm/pmu.yaml          |   2 +
 .../interrupt-controller/apple,aic.yaml       |  31 +
 arch/arm64/boot/dts/apple/t8103.dtsi          |  24 +
 arch/arm64/include/asm/apple_m1_pmu.h         |  64 ++
 drivers/irqchip/irq-apple-aic.c               |  94 ++-
 drivers/perf/Kconfig                          |   7 +
 drivers/perf/Makefile                         |   1 +
 drivers/perf/apple_m1_cpu_pmu.c               | 584 ++++++++++++++++++
 drivers/perf/arm_pmu.c                        |   2 +
 .../interrupt-controller/apple-aic.h          |   2 +
 include/linux/perf/arm_pmu.h                  |   2 +
 11 files changed, 791 insertions(+), 22 deletions(-)
 create mode 100644 arch/arm64/include/asm/apple_m1_pmu.h
 create mode 100644 drivers/perf/apple_m1_cpu_pmu.c

-- 
2.30.2

