Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4CF461D10
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 18:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346623AbhK2Rx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 12:53:59 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55210 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242886AbhK2Rvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 12:51:49 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638208110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HQQjy4dkLt/JmWNRE3DSTun1F763Yscp+f1agVMIU0M=;
        b=x+ZvWIUB5RgVqsQxErKwZJf6B7zhxSMIezhrs6XEMo/JCSlQ4lp5+LmqWFthfwY2dDi2Bh
        mQ4Vz1HELXaEK0nsKTEKeKGRnfXaPC7KOGgf0lUBwfA3kgoox7DTi8nsyrg02Fmp+Z6GoU
        CKhALfmYYd2KGPGtj/ywwI9ndRybekuOj/qiiVPRGgoy0scb77tLZ7CEdPeulH01Ev+KFO
        yIoEWoeB1zeRNgby5Y6FX2uy2FEZDDrSA8P5Eo5uqn7xtpNf6yYaNY5qdkCXesXky5D8d2
        gjzTLOqpdeFJh/ewgnDGJDdqNL5n6Y2dMnumxdITONL3uVLqhVPa1Pbje1Je8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638208110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HQQjy4dkLt/JmWNRE3DSTun1F763Yscp+f1agVMIU0M=;
        b=VRcGwku4Fxbqqd36qZKk6DyiYXcd/N20Ubrgb2x9Lj04q4A4v3MCAFxbyBVWakY3Vrbv8h
        Iq57CskAe4XqMwCQ==
To:     linux-kernel@vger.kernel.org
Cc:     Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 10/11] x86/mm: Include spinlock_t definition in pgtable.
Date:   Mon, 29 Nov 2021 18:46:53 +0100
Message-Id: <20211129174654.668506-11-bigeasy@linutronix.de>
In-Reply-To: <20211129174654.668506-1-bigeasy@linutronix.de>
References: <20211129174654.668506-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This header file provides forward declartion for pgd_lock but does not
include the header defining its type. This works since the definition of
spinlock_t is usually included somehow via printk.

By trying to avoid recursive includes on PREEMPT_RT I avoided the loop
in printk and as a consequnce kernel/intel.c failed to compile due to
missing type definition.

Include the needed definition for spinlock_t.

Cc: x86@kernel.org
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/include/asm/pgtable.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 448cd01eb3ecb..a34430b7af4a3 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -22,6 +22,7 @@
 #define pgprot_decrypted(prot)	__pgprot(__sme_clr(pgprot_val(prot)))
=20
 #ifndef __ASSEMBLY__
+#include <linux/spinlock.h>
 #include <asm/x86_init.h>
 #include <asm/pkru.h>
 #include <asm/fpu/api.h>
--=20
2.34.0

