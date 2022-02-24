Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4EF4C2CBC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 14:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbiBXNIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 08:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234813AbiBXNIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 08:08:43 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD5A230E50;
        Thu, 24 Feb 2022 05:08:11 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id ED93245F22;
        Thu, 24 Feb 2022 13:08:05 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 0/7] irqchip/apple-aic: Add support for AICv2
Date:   Thu, 24 Feb 2022 22:07:34 +0900
Message-Id: <20220224130741.63924-1-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Changes since v1:
- Split off the DT binding
- Changed fast-ipi codepath selection to use a static key for performance
- Added fix for PCI driver to support the new 4-cell IRQ form
- Minor style / review feedback fixes

Hector Martin (7):
  PCI: apple: Change MSI handling to handle 4-cell AIC fwspec form
  dt-bindings: interrupt-controller: apple,aic2: New binding for AICv2
  irqchip/apple-aic: Add Fast IPI support
  irqchip/apple-aic: Switch to irq_domain_create_tree and sparse hwirqs
  irqchip/apple-aic: Dynamically compute register offsets
  irqchip/apple-aic: Support multiple dies
  irqchip/apple-aic: Add support for AICv2

 .../interrupt-controller/apple,aic2.yaml      |  99 ++++
 MAINTAINERS                                   |   2 +-
 drivers/irqchip/irq-apple-aic.c               | 432 +++++++++++++++---
 drivers/pci/controller/pcie-apple.c           |   2 +-
 4 files changed, 458 insertions(+), 77 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml

-- 
2.33.0

