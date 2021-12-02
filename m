Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9EB46607C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 10:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356532AbhLBJgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 04:36:22 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46900 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356506AbhLBJgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 04:36:19 -0500
Date:   Thu, 02 Dec 2021 09:32:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638437574;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6rwErkVosZtUc3I0ITRNjB0OZXBO2CCfXQ6WaE07+H4=;
        b=0BCYhm3yisQerqinRceudQN6jQZk67eYYrdgHTDXRBRnP8jfBk0TTGbwgLy+Sd7wBY6rZa
        7RHlOn3S/14yjGItRBHwxCa4+SJkWkC1uRBDJE72F7wsHBYL7BkCuZxdRJJu+Tq6m5Nl1/
        VB/hsQIvZ7RxXqN/aH8KFuh/LNVIwKflMz39DVBXn5RcPM4GwY4Qc/p+5OiEu1Ub8znze1
        FTtP3BOBV60vO6DNY8kj5MddsDGcXw12jsN4Zb+ldqcT+hAB+LR3wlOLEG6kjDNMe+miES
        dyBwcHyBwcv2L7A1b1XxAH/YPRQ0Ax9uKkMSUC/ahj3EooeQPflUjsrv+wT16Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638437574;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6rwErkVosZtUc3I0ITRNjB0OZXBO2CCfXQ6WaE07+H4=;
        b=ig0EkFd00C7qUfc+c2EVMu+EL3Y77GeC6TGkCbiNapUlLY5BhRV/ZOPLExpS11hfOsefdH
        kflDqRWlLDjw4EBw==
From:   "irqchip-bot for Vladimir Murzin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip: nvic: Fix offset for Interrupt
 Priority Offsets
Cc:     Vladimir Murzin <vladimir.murzin@arm.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20211201110259.84857-1-vladimir.murzin@arm.com>
References: <20211201110259.84857-1-vladimir.murzin@arm.com>
MIME-Version: 1.0
Message-ID: <163843757368.11128.398935944159085891.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     c5e0cbe2858d278a27d5b3fe31890aea5be064c4
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/c5e0cbe2858d278a27d5b3fe31890aea5be064c4
Author:        Vladimir Murzin <vladimir.murzin@arm.com>
AuthorDate:    Wed, 01 Dec 2021 11:02:58 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 02 Dec 2021 09:27:06 

irqchip: nvic: Fix offset for Interrupt Priority Offsets

According to ARM(v7M) ARM Interrupt Priority Offsets located at
0xE000E400-0xE000E5EC, while 0xE000E300-0xE000E33C covers read-only
Interrupt Active Bit Registers

Fixes: 292ec080491d ("irqchip: Add support for ARMv7-M NVIC")
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211201110259.84857-1-vladimir.murzin@arm.com
---
 drivers/irqchip/irq-nvic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-nvic.c b/drivers/irqchip/irq-nvic.c
index 63bac3f..ba4759b 100644
--- a/drivers/irqchip/irq-nvic.c
+++ b/drivers/irqchip/irq-nvic.c
@@ -26,7 +26,7 @@
 
 #define NVIC_ISER		0x000
 #define NVIC_ICER		0x080
-#define NVIC_IPR		0x300
+#define NVIC_IPR		0x400
 
 #define NVIC_MAX_BANKS		16
 /*
