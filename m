Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4639B4993A9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 21:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386076AbiAXUfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 15:35:04 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54004 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379803AbiAXUMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 15:12:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 282ADB8122F;
        Mon, 24 Jan 2022 20:12:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08D0C340E5;
        Mon, 24 Jan 2022 20:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643055157;
        bh=k0CllSwHGT9rmu0vbmh6ZFyrg4eZL+tcUYKDcHtokck=;
        h=From:To:Cc:Subject:Date:From;
        b=dNcpJpuDfTr0anHF7o9ez44+ZKDOzR0fLPRNpho2K1oab5DBhRYRfBAc6az2gqR/q
         yqBlb2F8vQm2ouqWzNXAiGjSzGHMn9P/UNjciQfP0AbUlUSxDo+Ct22sUUwQTapzgy
         mZmycrfM6FwCwz9z1v9dhCpeOlFga3SFqB5O5GLj9PgOxLdlgdvjMWP4TIaj8l7/mW
         KY0vuvF/9gqTndnmN3otmJfKLQCl++f/uhabvctNv7pB/qlgULecZ2oRE2chdhnAvC
         I1Gbt61Rm4ZFhAOFbOjmwondBqnRbUN+vtslPw/fV9Nq8xYwGNikic7hSd/mUASbcq
         xZQRzx/juvUNQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nC5hb-002Y3f-LZ; Mon, 24 Jan 2022 20:12:35 +0000
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
Subject: [PATCH v4 00/10] drivers/perf: CPU PMU driver for Apple M1
Date:   Mon, 24 Jan 2022 20:12:21 +0000
Message-Id: <20220124201231.298961-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, will@kernel.org, marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io, robh+dt@kernel.org, tglx@linutronix.de, dougallj@gmail.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
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
 .../interrupt-controller/apple,aic.yaml       |  29 +
 arch/arm64/boot/dts/apple/t8103.dtsi          |  24 +
 arch/arm64/include/asm/apple_m1_pmu.h         |  64 ++
 drivers/irqchip/irq-apple-aic.c               |  94 ++-
 drivers/perf/Kconfig                          |   7 +
 drivers/perf/Makefile                         |   1 +
 drivers/perf/apple_m1_cpu_pmu.c               | 584 ++++++++++++++++++
 drivers/perf/arm_pmu.c                        |   2 +
 .../interrupt-controller/apple-aic.h          |   2 +
 include/linux/perf/arm_pmu.h                  |   2 +
 11 files changed, 789 insertions(+), 22 deletions(-)
 create mode 100644 arch/arm64/include/asm/apple_m1_pmu.h
 create mode 100644 drivers/perf/apple_m1_cpu_pmu.c

-- 
2.30.2

