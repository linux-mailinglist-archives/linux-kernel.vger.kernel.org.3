Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42C2474AD8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 19:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236993AbhLNS1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 13:27:20 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38036 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbhLNS1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 13:27:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D95C2B81C21;
        Tue, 14 Dec 2021 18:27:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89EEEC34600;
        Tue, 14 Dec 2021 18:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639506420;
        bh=lWR5fG4CldO/Ezt4piZ1qkap5oqim5OBn0f7PejxEvs=;
        h=From:To:Cc:Subject:Date:From;
        b=h0GxdvjV3q/hUnz0d1qPrYRSlgof+ueA4qt2kGrkPGPAjzlrqvnnQW53rvCaYR68B
         OTa3j1wE8eURTD4QhIYVXeZQRxS5B85inB+pgMRTPX+x/+qfGM4o92jYZ/OxyvqpjC
         CCUJ1xiEiOkUeCY8uMAXl6cu5vd9BJ9WzUVpbv367fhqe7fcfoVIQdsbWOn3L1j+me
         Ua6BsBENRuoW/AnEBOEvjbHHlq1oeQUcCDUysKYCX/z/Lk1WfelEaLBHhGS0ZWsN6B
         agFevwFnL6bw9u8zEFAVinp//cmK/2iCInlzPlyEzXGSyOclgS4iM3fUg8NLwRCNFr
         qhLhtdpVFNazQ==
Received: from cfbb000407.r.cam.camfibre.uk ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mxCVu-00C7Tq-9O; Tue, 14 Dec 2021 18:26:58 +0000
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
Subject: [PATCH v3 00/10] drivers/perf: CPU PMU driver for Apple M1
Date:   Tue, 14 Dec 2021 18:26:24 +0000
Message-Id: <20211214182634.727330-1-maz@kernel.org>
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

My hope is that this driver will help people to explore the event
space and propose possible interpretations for these events using
reproducible test cases.

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

Marc Zyngier (10):
  dt-bindings: arm-pmu: Document Apple PMU compatible strings
  dt-bindings: apple,aic: Add CPU PMU per-cpu pseudo-interrupts
  dt-bindings: apple,aic: Add affinity description for per-cpu
    pseudo-interrupts
  irqchip/apple-aic: Parse FIQ affinities from device-tree
  irqchip/apple-aic: Wire PMU interrupts
  arm64: dts: apple: Add t8103 PMU interrupt affinities
  arm64: dts: apple: Add t8301 PMU nodes
  irqchip/apple-aic: Move PMU-specific registers to their own include
    file
  drivers/perf: arm_pmu: Handle 47 bit counters
  drivers/perf: Add Apple icestorm/firestorm CPU PMU driver

 .../devicetree/bindings/arm/pmu.yaml          |   2 +
 .../interrupt-controller/apple,aic.yaml       |  28 +
 arch/arm64/boot/dts/apple/t8103.dtsi          |  24 +
 arch/arm64/include/asm/apple_m1_pmu.h         |  64 ++
 drivers/irqchip/irq-apple-aic.c               |  95 ++-
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

