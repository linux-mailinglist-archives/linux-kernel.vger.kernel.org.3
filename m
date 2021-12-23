Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085D747E2F6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 13:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243433AbhLWMI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 07:08:58 -0500
Received: from polaris.svanheule.net ([84.16.241.116]:41714 "EHLO
        polaris.svanheule.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348139AbhLWMIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 07:08:53 -0500
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eafe:c901:29a7:866a:cac1:4c27])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id D357A2866B1;
        Thu, 23 Dec 2021 13:08:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1640261329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Hl6ypLPIKtG4YO1pAlD2rvC3FP6Mfp96O+5pKt7o0eI=;
        b=prG+DHqSQYtmeS49JJutfglTKW7hOecvoXSaJkX7o+8Deq+xQPSCkvqDEQ846U64S3aQhh
        UAyuogqW7vnN9U2FD6BHCOCcKP1Ai61ICLZSNDxyUXtGeTa/wrhTGDJbSYzT3SMVCeYfcq
        xxzsDW9tHxI0CYWCN1YFIFB952hlXyyv17gQ1ppssTzMap4TVBzlPYpBrPtbM0M/pdNRET
        UYt9uIGlbVNPcjj79WITi/FJ5q9XcA8KkPAPC5nHb14gEMVJlH0dnQWKrCaBs78Q4yy/q9
        P2HsZHkdeeWX+rf0/KmHVqr4AZxh8uT1VfMD2gP4TMWiwB8OlMJIY2I7f2sqSw==
From:   Sander Vanheule <sander@svanheule.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Birger Koblitz <mail@birger-koblitz.de>,
        Bert Vermeulen <bert@biot.com>,
        John Crispin <john@phrozen.org>, linux-kernel@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>
Subject: [RFC PATCH v1 0/4] Rework realtek-rtl IRQ driver
Date:   Thu, 23 Dec 2021 13:08:30 +0100
Message-Id: <cover.1640261161.git.sander@svanheule.net>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After seeing some use and with more devices tested, the current implementation
for the Realtek SoC interrupt controller was found to contain a few flaws.

The driver requires the following fixes:
- irq_domain_ops::map should map the virq, not the hwirq
- routing has an off-by-one error. Values (1..6) correspond to MIPS CAUSEF(2..7)

The following improvements should also be made:
- Use N real cascaded interrupts with an interrupt-specific mask of child irq lines.
  Otherwise a high-priority interrupt may cause a low-priority interrupt to be
  handled first.
- Get rid of custom interrupt-map interpretation, replace by realtek,interrupt-routing.

These patches are some initial changes, and since is this my first real work on
an interrupt driver, I'm submitting this as an RFC first. Please see the notes
on the patches for some extra remarks.

I've also currently opted to stay with cascased interrupts, as I'm not
sure if (and how) this should be implemented as a hierarchical
controller.

Best,
Sander

Sander Vanheule (4):
  irqchip: realtek-rtl: map control data to virq
  irqchip: realtek-rtl: use per-parent irq handling
  dt-bindings: interrupt-controller: realtek,rtl-intc: replace irq
    mapping
  irqchip: realtek-rtl: replace custom interrupt-map

 .../realtek,rtl-intc.yaml                     |  49 +++--
 drivers/irqchip/irq-realtek-rtl.c             | 202 +++++++++++-------
 2 files changed, 163 insertions(+), 88 deletions(-)

-- 
2.33.1

