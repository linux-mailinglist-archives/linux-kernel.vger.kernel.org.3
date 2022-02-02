Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EFB4A6F1B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 11:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbiBBKqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 05:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbiBBKqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 05:46:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7502CC061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 02:46:21 -0800 (PST)
Date:   Wed, 02 Feb 2022 10:46:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643798778;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=spmioq/DvRD9SjqstyVhDvpbJBBDNB3IdHCwD7XgX0w=;
        b=spqa/T1xdyOgDZFRF84tR9Y4kh2OELrkTJucZcgwSluj1YJZeeGAaTC2+2Q8LAwwKHo/+l
        +a4BFNoLChBwQZeG7L8wGTw+s6e45epF45970uQiwmn9WF2UEOi29VCcpcGVmI9w4cNYGw
        fmo8pj2eJVRVa9dkR5PPptY7kWOsb/afyKTZ/mxyQYW75dAjgQ+89rcHeZpowcCMhNrvnM
        VYvi/KIn7m2HWjOtX5VTYoElLrhX1vQEFAEEmf7FxflQJy/HhVCfIS1bc9Cqf5nzG3rt7P
        hXoA7/4R0y4KnR6E0EHXkiaPW9UQpGWiKmot+opGHxzBeJD4ad0dasl0rcLW/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643798778;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=spmioq/DvRD9SjqstyVhDvpbJBBDNB3IdHCwD7XgX0w=;
        b=xOrTs/+ANNqBOQMINODsaHAsPU0n/Fv6Jt3FtfkV6MvcgrFuEGEzYesuhNhXw+EIsxxCbO
        ygHnntGekeAbN5DQ==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/gic-v3-its: Skip HP notifier
 when no ITS is registered
Cc:     Steev Klimaszewski <steev@kali.org>, Marc Zyngier <maz@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        tglx@linutronix.de
In-Reply-To: <20220202103454.2480465-1-maz@kernel.org>
References: <20220202103454.2480465-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <164379877697.16921.16506772484261500072.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     eba1e44beef88aa722f07755f79f604cd5d92290
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/eba1e44beef88aa722f07755f79f604cd5d92290
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 02 Feb 2022 10:34:54 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 02 Feb 2022 10:43:10 

irqchip/gic-v3-its: Skip HP notifier when no ITS is registered

We have some systems out there that have both LPI support and an
ITS, but that don't expose the ITS in their firmware tables
(either because it is broken or because they run under a hypervisor
that hides it...).

Is such a configuration, we still register the HP notifier to free
the allocated tables if needed, resulting in a warning as there is
no memory to free (nothing was allocated the first place).

Fix it by keying the HP notifier on the presence of at least one
sucessfully probed ITS.

Fixes: d23bc2bc1d63 ("irqchip/gic-v3-its: Postpone LPI pending table freeing and memreserve")
Reported-by: Steev Klimaszewski <steev@kali.org>
Tested-by: Steev Klimaszewski <steev@kali.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lore.kernel.org/r/20220202103454.2480465-1-maz@kernel.org
---
 drivers/irqchip/irq-gic-v3-its.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 9e93ff2..cd77297 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -5517,6 +5517,9 @@ int __init its_lpi_memreserve_init(void)
 	if (!efi_enabled(EFI_CONFIG_TABLES))
 		return 0;
 
+	if (list_empty(&its_nodes))
+		return 0;
+
 	gic_rdists->cpuhp_memreserve_state = CPUHP_INVALID;
 	state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
 				  "irqchip/arm/gicv3/memreserve:online",
