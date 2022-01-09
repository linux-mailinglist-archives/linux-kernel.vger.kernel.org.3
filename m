Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989254889F6
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 15:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235848AbiAIOyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 09:54:55 -0500
Received: from polaris.svanheule.net ([84.16.241.116]:58434 "EHLO
        polaris.svanheule.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235821AbiAIOyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 09:54:51 -0500
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eafe:c901:f20a:f473:2021:45ec])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 6AC8228EE26;
        Sun,  9 Jan 2022 15:54:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1641740089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OMbIcvvI3IPuNYN8evQvKri6MZuBKmRYkZMVWhpSDAE=;
        b=S7jRTa+1CSDVpJcouFz9VjmlXtRouU6rbqQOMr9OTi3sDgUE9BkGv0eggwDYIv+PaTituB
        CmtArYLh6rCKYWkmzqVROGuomPLeXRyWbnnKUFTTHtoCTXYif6UOtfAMkK0z2HT0Sz8suG
        fDeko40Jmw1ohh428btqevKNFmV0dT0vxZSVHO/uTdzyvPEAd8siv2wACaDkX+c9tCF7SQ
        3B7vrliSQrSLq2GW1vUI1gzKAixGGsrlbG1R8GwmDlLlztd5lgLe4SFeD+2M5YwlRlOTcl
        +6LukC9qT2YGNy6r4I0vhVCGtX8c99snc1DTD5CGds2X0llWEwkPMvkGmuXBTA==
From:   Sander Vanheule <sander@svanheule.net>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Birger Koblitz <mail@birger-koblitz.de>,
        Bert Vermeulen <bert@biot.com>,
        John Crispin <john@phrozen.org>,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v3 3/6] irqchip/realtek-rtl: clear all pending interrupts
Date:   Sun,  9 Jan 2022 15:54:34 +0100
Message-Id: <5082ad3cb8b4eedf55075561b93eff6570299fe1.1641739718.git.sander@svanheule.net>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1641739718.git.sander@svanheule.net>
References: <cover.1641739718.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of only servicing the lowest pending interrupt line, make sure
all pending SoC interrupts are serviced before exiting the chained
handler. This adds a small overhead if only one interrupt is pending,
but should prevent rapid re-triggering of the handler.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 drivers/irqchip/irq-realtek-rtl.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-realtek-rtl.c b/drivers/irqchip/irq-realtek-rtl.c
index 568614edd88f..50a56820c99b 100644
--- a/drivers/irqchip/irq-realtek-rtl.c
+++ b/drivers/irqchip/irq-realtek-rtl.c
@@ -76,16 +76,20 @@ static void realtek_irq_dispatch(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct irq_domain *domain;
-	unsigned int pending;
+	unsigned long pending;
+	unsigned int soc_int;
 
 	chained_irq_enter(chip, desc);
 	pending = readl(REG(RTL_ICTL_GIMR)) & readl(REG(RTL_ICTL_GISR));
+
 	if (unlikely(!pending)) {
 		spurious_interrupt();
 		goto out;
 	}
+
 	domain = irq_desc_get_handler_data(desc);
-	generic_handle_domain_irq(domain, __ffs(pending));
+	for_each_set_bit(soc_int, &pending, 32)
+		generic_handle_domain_irq(domain, soc_int);
 
 out:
 	chained_irq_exit(chip, desc);
-- 
2.33.1

