Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7695547FE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352680AbiFVJmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 05:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiFVJml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:42:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A1639B90;
        Wed, 22 Jun 2022 02:42:39 -0700 (PDT)
Date:   Wed, 22 Jun 2022 09:42:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655890957;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=io8/PY4wsMsORkfLOYHpgOs3qLMv7ZBkKSxQmXu8GFU=;
        b=WB1B4VvlocQ+VWbwv9/0uMHvoXS0MSYWbKjhfNEYtK8cQfOzMj0iS55yc3XHeupt4xWv1g
        oBiEu0QYy+0MLK4eSWAcApYAlj11KsfmE2xPZy7anWKX5r4RSZw668CAf8ElLqDACPm26r
        t7J9w75MBkX1FfRnjKtYF44gxYTL2mXTIC41Njgsu3ccrr240D78opoVXjFxrSP9gMj5TY
        0CT02CuGENtOL/o6GxsA1tHj+4uJ42A/FTopXEq3aVX2mRf/7aFT/X8dBELbg7vRUv7WV4
        bQn21sCwWTLvKt1SPkeIIlFip+XZhebnIo+fyOLwY7aMd9KZ6SqPnKs+NYxquQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655890957;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=io8/PY4wsMsORkfLOYHpgOs3qLMv7ZBkKSxQmXu8GFU=;
        b=t0n0bBOicDHOAAv50nCiKLaOv6ExUPGmJ408s16AVEZ3PcrDPCOJo4EV5Ul4FSkHtKVq3r
        zA9rrtVIThtoh3Ag==
From:   "tip-bot2 for Shreenidhi Shedi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/vmware] x86/vmware: Use BIT() macro for shifting
Cc:     Shreenidhi Shedi <sshedi@vmware.com>, Borislav Petkov <bp@suse.de>,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220601101820.535031-1-sshedi@vmware.com>
References: <20220601101820.535031-1-sshedi@vmware.com>
MIME-Version: 1.0
Message-ID: <165589095635.4207.5855422927608587338.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/vmware branch of tip:

Commit-ID:     4745ca43104b422354f06dc814d3f13661f217af
Gitweb:        https://git.kernel.org/tip/4745ca43104b422354f06dc814d3f13661f217af
Author:        Shreenidhi Shedi <sshedi@vmware.com>
AuthorDate:    Wed, 01 Jun 2022 15:48:20 +05:30
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 22 Jun 2022 11:23:14 +02:00

x86/vmware: Use BIT() macro for shifting

VMWARE_CMD_VCPU_RESERVED is bit 31 and that would mean undefined
behavior when shifting an int but the kernel is built with
-fno-strict-overflow which will wrap around using two's complement.

Use the BIT() macro to improve readability and avoid any potential
overflow confusion because it uses an unsigned long.

  [ bp: Clarify commit message. ]

Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
Link: https://lore.kernel.org/r/20220601101820.535031-1-sshedi@vmware.com
---
 arch/x86/kernel/cpu/vmware.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index c04b933..02039ec 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -476,8 +476,8 @@ static bool __init vmware_legacy_x2apic_available(void)
 {
 	uint32_t eax, ebx, ecx, edx;
 	VMWARE_CMD(GETVCPU_INFO, eax, ebx, ecx, edx);
-	return (eax & (1 << VMWARE_CMD_VCPU_RESERVED)) == 0 &&
-	       (eax & (1 << VMWARE_CMD_LEGACY_X2APIC)) != 0;
+	return !(eax & BIT(VMWARE_CMD_VCPU_RESERVED)) &&
+		(eax & BIT(VMWARE_CMD_LEGACY_X2APIC));
 }
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
