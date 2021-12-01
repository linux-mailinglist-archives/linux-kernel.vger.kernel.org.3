Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66470464F12
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 14:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349699AbhLANxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 08:53:19 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46928 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349638AbhLANwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 08:52:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A38A8B81F42;
        Wed,  1 Dec 2021 13:49:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C52C53FCC;
        Wed,  1 Dec 2021 13:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638366560;
        bh=HEReuV7gswevA5y2LP1YzSmPqDGDjaqY08h/BUth7yc=;
        h=From:To:Cc:Subject:Date:From;
        b=sn3HlZrIbJXw0GUCQniF/Wtcq1/mL42xv7j9bVX3/lGN3mEHkTcUhlYA3h4DDgBa6
         dKWPr91dX0yCzXdshKbfM8MCM6Ve9R9amyNn1jC4XcqQLLRYwjHSLtrVKUEjzZyGHf
         GQx2T3cj40jTY8kaMst+mRWMhpZQHyr8tZm2sAcWXoiOoscUBndAWumXSCwl4CrNCo
         TE438krE7bvZMhUMBGnHzbnEdPH4ESwjqQO9A7MMRBtHuuJgew39glz19zaZh+Lc2E
         vp1OBDpTcCM6/rZhxC+qaxOuVeejjxrlrgaCPJ5BOyRLKX1QL2kBlcpXstkHAzy/vk
         rKmbeiB2x8nYQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1msPz4-0098G7-50; Wed, 01 Dec 2021 13:49:18 +0000
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
Subject: [PATCH v2 0/8] drivers/perf: CPU PMU driver for Apple M1
Date:   Wed,  1 Dec 2021 13:49:01 +0000
Message-Id: <20211201134909.390490-1-maz@kernel.org>
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

* From v1 [1]:
  - Added a few comments clarifying the event mapping to counters
  - Spelling fixes
  - Collected Acks from Rob

[1] https://lore.kernel.org/r/20211113115429.4027571-1-maz@kernel.org

Marc Zyngier (8):
  dt-bindings: arm-pmu: Document Apple PMU compatible strings
  dt-bindings: apple,aic: Add CPU PMU per-cpu pseudo-interrupts
  irqchip/apple-aic: Add cpumasks for E and P cores
  irqchip/apple-aic: Wire PMU interrupts
  irqchip/apple-aic: Move PMU-specific registers to their own include
    file
  arm64: apple: t8301: Add PMU nodes
  drivers/perf: arm_pmu: Handle 47 bit counters
  drivers/perf: Add Apple icestorm/firestorm CPU PMU driver

 .../devicetree/bindings/arm/pmu.yaml          |   2 +
 .../interrupt-controller/apple,aic.yaml       |   2 +
 arch/arm64/boot/dts/apple/t8103.dtsi          |  12 +
 arch/arm64/include/asm/apple_m1_pmu.h         |  64 ++
 drivers/irqchip/irq-apple-aic.c               |  59 +-
 drivers/perf/Kconfig                          |   7 +
 drivers/perf/Makefile                         |   1 +
 drivers/perf/apple_m1_cpu_pmu.c               | 637 ++++++++++++++++++
 drivers/perf/arm_pmu.c                        |   2 +
 .../interrupt-controller/apple-aic.h          |   2 +
 include/linux/perf/arm_pmu.h                  |   2 +
 11 files changed, 768 insertions(+), 22 deletions(-)
 create mode 100644 arch/arm64/include/asm/apple_m1_pmu.h
 create mode 100644 drivers/perf/apple_m1_cpu_pmu.c

-- 
2.30.2

