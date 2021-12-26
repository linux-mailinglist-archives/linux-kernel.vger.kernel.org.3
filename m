Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1262647F8B6
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 21:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhLZUCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 15:02:39 -0500
Received: from polaris.svanheule.net ([84.16.241.116]:57486 "EHLO
        polaris.svanheule.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbhLZT7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 14:59:34 -0500
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eafe:c901:201f:9f28:b747:b33a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id CF168288171;
        Sun, 26 Dec 2021 20:59:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1640548773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QUmx4dd1SARWNIqiWhqXcm+6Jt7xxc3tv7h3TCH5oBw=;
        b=ZaQ40kZJPre3Wt3B2VjhcvnR5uaBiisV5eUkkQHZ4ArAdx+suzJ6NQjTXcrXIVZfKUibOG
        QnrsWjJPQCuIFHWdEohKC3ckh/41R1rTEv9rvr66znOhHhjg+aCCeCyO+P4Cg98aAc+mAv
        4rmb0dijq1Dvyiqc173gbu5VOD5F6E/02hfOZtDzxJdu55HT8yULOyhrRONn+dXsXmW68T
        8UVujmul6Sq7mfzaXvOBxsqtf4f2+/PJTVPR0+31EeRlqpsMKi+xU4o8/hoOPscr/cXrIK
        p+SVsDW7u5nuxXkdQV/T0LxOuoI0C/8/apzoqfwyZjx3CTtDLlYBaZKDUsZ8NA==
From:   Sander Vanheule <sander@svanheule.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Birger Koblitz <mail@birger-koblitz.de>,
        Bert Vermeulen <bert@biot.com>,
        John Crispin <john@phrozen.org>, linux-kernel@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>
Subject: [RFC PATCH v2 0/5] Rework realtek-rtl IRQ driver
Date:   Sun, 26 Dec 2021 20:59:23 +0100
Message-Id: <cover.1640548009.git.sander@svanheule.net>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After seeing some use, and with more devices tested, the current
implementation for the Realtek SoC interrupt controller was found to
contain a few flaws.

The driver requires the following fixes:
- irq_domain_ops::map should map the virq, not the hwirq (patch 1)
- routing has an off-by-one error. Routing values (1..6) correspond to
  MIPS CAUSEF(2..7) (patch 2)

The following improvements should also be made:
- Use N real cascaded interrupts with an interrupt-specific mask of
  child irq lines. Otherwise a high-priority interrupt may cause a
  low-priority interrupt to be handled first. (patch 3)
- Get rid of assumed routing to parent interrupts of the original
  implementation (patch 4, 5)

Changes since v1:
Link: https://lore.kernel.org/all/cover.1640261161.git.sander@svanheule.net/

Still an RFC. Mainly since I don't like the open coding in the last
patch, but also since I still have a question about the chained IRQ
handlers.

- Split some of the changes to limit the patch scope to one issue.
- Dropped some small (spurious or unneeded) changes
- Instead of dropping/replacing interrupt-map, the last patches now
  provide an implementation that amends the current situtation.

Sander Vanheule (5):
  irqchip/realtek-rtl: map control data to virq
  irqchip/realtek-rtl: fix off-by-one in routing
  irqchip/realtek-rtl: use per-parent irq handling
  dt-bindings: interrupt-controller: realtek,rtl-intc: map output lines
  irqchip/realtek-rtl: add explicit output routing

 .../realtek,rtl-intc.yaml                     |  38 ++-
 drivers/irqchip/irq-realtek-rtl.c             | 232 ++++++++++++++----
 2 files changed, 218 insertions(+), 52 deletions(-)

-- 
2.33.1

