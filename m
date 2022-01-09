Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2244889F3
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 15:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235817AbiAIOyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 09:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiAIOys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 09:54:48 -0500
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23668C06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 06:54:48 -0800 (PST)
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eafe:c901:f20a:f473:2021:45ec])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 1452D28EE21;
        Sun,  9 Jan 2022 15:54:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1641740085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JCmaQRKSZjVh8qf7YMricNcWiGHV0VuLqoFVkRALbTc=;
        b=A2xNYHj43Prbmacm7zTC4VFLYFRIU+OpXeV0ZKgC565cCTnwsRliHON6+ncsxjDaEL8Ivh
        VhXtA98ksMLBBakVG4Q6fdyYl2eqNo6JYCBzhkoip2WOfh5T9R+6LDAzVoRlItHnkiwXjY
        9Jxg3ALc3p6fcSVScrJAxZvyszwjt2VGnXJcPu7naZnPm/kinociGlBjI5DBwH3fPlzf51
        PU3hKZTMQz8Xr6suwpOd0PsVDdIqVffVhAAVRsQpN1AT6QGtpImBP1uJpt4eJyD/eixWKZ
        Z8fDkmIZQvNng/n5CoyJidCcJmj/XjQpag+YRzAnY0ODShHKbtpS9ChqiiTIeg==
From:   Sander Vanheule <sander@svanheule.net>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Birger Koblitz <mail@birger-koblitz.de>,
        Bert Vermeulen <bert@biot.com>,
        John Crispin <john@phrozen.org>,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v3 0/6] Rework realtek-rtl IRQ driver
Date:   Sun,  9 Jan 2022 15:54:31 +0100
Message-Id: <cover.1641739718.git.sander@svanheule.net>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After seeing some use, and with more devices tested, the current implementation
for the Realtek SoC interrupt controller was found to contain a few flaws.

The driver requires the following fixes:
- irq_domain_ops::map should map the virq, not the hwirq
- routing has an off-by-one error. Routing values (1..6) correspond to MIPS CAUSEF(2..7)

The following improvements should also be made:
- Use N real cascaded interrupts with an interrupt-specific mask of child irq lines.
  Otherwise a high-priority interrupt may cause a low-priority interrupt to be
  handled first.
- Get rid of assumed routing to parent interrupts of the original implementation.

Changes since v2 (RFC):
Link: https://lore.kernel.org/all/cover.1640548009.git.sander@svanheule.net/

- Define new, two-part compatibles for devicetree bindings. The existing format
  is kept for the old one-part compatible, but deprecated. New compatibles will
  require a different way of specifying parent interrupts and interrupt routing.
- Add change to handle all pending SoC interrupts in one go.

Changes since v1 (RFC):
Link: https://lore.kernel.org/all/cover.1640261161.git.sander@svanheule.net/

- Split some of the changes to limit the patch scope to one issue.
- Dropped some small (spurious or unneeded) changes
- Instead of dropping/replacing interrupt-map, the last patches now provide an
  implementation that amends the current situtation.

Sander Vanheule (6):
  irqchip/realtek-rtl: map control data to virq
  irqchip/realtek-rtl: fix off-by-one in routing
  irqchip/realtek-rtl: clear all pending interrupts
  dt-bindings: interrupt-controller: realtek,rtl-intc: require parents
  irqchip/realtek-rtl: use parent interrupts
  irqchip/realtek-rtl: use per-parent domains

 .../realtek,rtl-intc.yaml                     |  78 ++++--
 drivers/irqchip/irq-realtek-rtl.c             | 235 ++++++++++++------
 2 files changed, 222 insertions(+), 91 deletions(-)

-- 
2.33.1

