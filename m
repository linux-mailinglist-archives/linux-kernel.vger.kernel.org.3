Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F02464238
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238724AbhK3XZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:25:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36734 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238708AbhK3XZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:25:36 -0500
Date:   Tue, 30 Nov 2021 23:22:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638314535;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ZBmoWZVnk+ILyGM7O8mqRLZIQlSzQlW5lwR98gLVrI=;
        b=aiNsLbHCdCxpSWvSLoNeYGQI6eAGU8T2poefHV0VaLrWOl32010DmNZTlZJlaqtCvmnhbX
        e0Y7Hxmh/bse6sqNeYEwO+IkbdTI0xITZh5wJQzthQoZPGlrffAD2b+BTesmU8h3iDOTuI
        sChGYAvAhAGCgeDEHtrSKsX/7mVzfxfX4yucf1T8daoG5xqNK82bJ2rb1u5rJQS1f33vrh
        HwqN8KJlWVfFD40cEA/L+oaJ7Jz4K/RTCmKWioMwFYV9AKFiPgbs2CLPRmxQgj8T1aA8jO
        Ibg9RsY4Oz3IvRHM52j4adIXe76BgN1WMifNOFYdagkcI02pI6AToKc1hYHo7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638314535;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ZBmoWZVnk+ILyGM7O8mqRLZIQlSzQlW5lwR98gLVrI=;
        b=oroCeU2JWmrTRbkGsoG6u1ntiNO3D1tCv94IZ0028QW+FBrvLeKE5F14SXXRgtOPaNu4Gq
        2ZErzRbJuPAgE5Bg==
From:   "tip-bot2 for Rikard Falkeborn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/generic_chip: Constify irq_generic_chip_ops
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20211130214043.1257585-1-rikard.falkeborn@gmail.com>
References: <20211130214043.1257585-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Message-ID: <163831453383.11128.13771515013638622121.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     4946f15e8c334840bf277a0bf924371eae120fcd
Gitweb:        https://git.kernel.org/tip/4946f15e8c334840bf277a0bf924371eae120fcd
Author:        Rikard Falkeborn <rikard.falkeborn@gmail.com>
AuthorDate:    Tue, 30 Nov 2021 22:40:43 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 01 Dec 2021 00:15:07 +01:00

genirq/generic_chip: Constify irq_generic_chip_ops

The only usage of irq_generic_chip_ops is to pass its address to
irq_domain_add_linear() which takes a pointer to const struct
irq_domain_ops. Make it const to allow the compiler to put it in
read-only memory.

[ tglx: Fixed subject prefix ]

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20211130214043.1257585-1-rikard.falkeborn@gmail.com

---
 include/linux/irqdomain.h | 2 +-
 kernel/irq/generic-chip.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 553da48..d476405 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -131,7 +131,7 @@ struct irq_domain_ops {
 #endif
 };
 
-extern struct irq_domain_ops irq_generic_chip_ops;
+extern const struct irq_domain_ops irq_generic_chip_ops;
 
 struct irq_domain_chip_generic;
 
diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index 6f29bf4..f0862eb 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -451,7 +451,7 @@ static void irq_unmap_generic_chip(struct irq_domain *d, unsigned int virq)
 
 }
 
-struct irq_domain_ops irq_generic_chip_ops = {
+const struct irq_domain_ops irq_generic_chip_ops = {
 	.map	= irq_map_generic_chip,
 	.unmap  = irq_unmap_generic_chip,
 	.xlate	= irq_domain_xlate_onetwocell,
