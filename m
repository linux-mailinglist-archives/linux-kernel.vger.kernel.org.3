Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAE546E17C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 05:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbhLIEgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 23:36:53 -0500
Received: from marcansoft.com ([212.63.210.85]:54098 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231847AbhLIEgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 23:36:51 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 98D9E41E64;
        Thu,  9 Dec 2021 04:33:13 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 0/6] irqchip/apple-aic: Add support for AICv2
Date:   Thu,  9 Dec 2021 13:32:43 +0900
Message-Id: <20211209043249.65474-1-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

In the t6000/t6001 (M1 Pro / Max) SoCs, Apple introduced a new version
of their interrupt controller. This is a significant departure from
AICv1 and seems designed to better scale to larger chips. This series
adds support for it to the existing AIC driver.

Gone are CPU affinities; instead there seems to be some kind of
"automagic" dispatch to willing CPU cores, and cores can also opt-out
via an IMP-DEF sysreg (!). Right now the bootloader just sets up all
cores to accept IRQs, and we ignore all this and let the magic
algorithm pick a CPU to accept the IRQ. In the future, we might start
making use of these finer-grained capabilities for e.g. better
real-time guarantees (CPUs running RT threads might opt out of IRQs).

Legacy IPI support is also gone, so this implements Fast IPI support.
Fast IPIs are implemented entirely in the CPU core complexes, using
FIQs and IMP-DEF sysregs. This is also supported on t8103/M1, so we
enable it there too, but we keep the legacy AIC IPI codepath in case
it is useful for backporting to older chips.

This also adds support for multi-die AIC2 controllers. While no
multi-die products exist yet, the AIC2 in t600x is built to support
up to 2 dies, and it's pretty clear how it works, so let's implement
it. If we're lucky, when multi-die products roll around, this will
let us support them with only DT changes. In order to support the
extra die dimension, this introduces a 4-argument IRQ phandle form
(3-argument is always supported and just implies die 0).

All register offsets are computed based on capability register values,
which should allow forward-compatibility with future AIC2 variants...
except for one. For some inexplicable reason, the number of actually
implemented die register sets is nowhere to be found (t600x has 2,
but claims 1 die in use and 8 dies max, neither of which is what we
need), and this is necessary to compute the event register offset,
which is page-aligned after the die register sets. We have no choice
but to stick this offset in the device tree... which is the same thing
Apple do in their ADT.

Hector Martin (6):
  dt-bindings: interrupt-controller: apple,aic: Add apple,aic2 support
  irqchip/apple-aic: Add Fast IPI support
  irqchip/apple-aic: Switch to irq_domain_create_tree and sparse hwirqs
  irqchip/apple-aic: Dynamically compute register offsets
  irqchip/apple-aic: Support multiple dies
  irqchip/apple-aic: Add support for AICv2

 .../interrupt-controller/apple,aic.yaml       |  62 ++-
 drivers/irqchip/irq-apple-aic.c               | 419 ++++++++++++++----
 2 files changed, 393 insertions(+), 88 deletions(-)

-- 
2.33.0

