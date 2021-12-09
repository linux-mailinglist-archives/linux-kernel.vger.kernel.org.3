Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC1246F3A0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 20:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhLITJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 14:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhLITJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 14:09:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3989C0617A1;
        Thu,  9 Dec 2021 11:06:12 -0800 (PST)
Date:   Thu, 09 Dec 2021 19:06:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639076770;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LHLjExnJ8A/pJiOteg5YBW4zxyqI04gSC0p6LU9eLjM=;
        b=ZtVpmgSlmpnjPt22iXrY/6NBYwsa3aVIW/BkLTYYJlWPExsT3UPkbnF7OU25QNCjbOIbs/
        eQPYhNXThkBNUGFUHQJqGjX6+cr7A1Hiv04aH6+jjt/IYtTl2q7BLS6l35TlY9UE6pfrF7
        yOPfcCr81XAnnkf+ECHBwzCJZ1rref5OtE71LCKlI/gc33+6b4fcNbfLmz26Qg6ULTIiwe
        3VviABKktCrWP7AXnBwMXJT6oiqr1EuDCZM5quXMZFsOy24HgXWAIfUda2Wx/TOokx9SNU
        M7Sw7jg5+4zycUf1DWEC5Fhvkbyge80LmBtDB3epAnaVPtyauOeOGLwYVqYRKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639076770;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LHLjExnJ8A/pJiOteg5YBW4zxyqI04gSC0p6LU9eLjM=;
        b=d75w5UF2Aa125TamWauC4G0Qd9IIUgA65MHxqOlpmHa1TuB1BinL1BohuwRJr1CxFgHm3e
        C7paSfB2ihO2uICw==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Include spinlock_t definition in pgtable.
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211102165224.wpz4zyhsvwccx5p3@linutronix.de>
References: <20211102165224.wpz4zyhsvwccx5p3@linutronix.de>
MIME-Version: 1.0
Message-ID: <163907676893.11128.2158876789554358211.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     35fa745286ac44ee26ed100c2bd2553368ad193b
Gitweb:        https://git.kernel.org/tip/35fa745286ac44ee26ed100c2bd2553368ad193b
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 02 Nov 2021 17:52:24 +01:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 09 Dec 2021 10:58:48 -08:00

x86/mm: Include spinlock_t definition in pgtable.

This header file provides forward declartion for pgd_lock but does not
include the header defining its type. This works since the definition of
spinlock_t is usually included somehow via printk.

By trying to avoid recursive includes on PREEMPT_RT I avoided the loop
in printk and as a consequnce kernel/intel.c failed to compile due to
missing type definition.

Include the needed definition for spinlock_t.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20211102165224.wpz4zyhsvwccx5p3@linutronix.de
---
 arch/x86/include/asm/pgtable.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 448cd01..a34430b 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -22,6 +22,7 @@
 #define pgprot_decrypted(prot)	__pgprot(__sme_clr(pgprot_val(prot)))
 
 #ifndef __ASSEMBLY__
+#include <linux/spinlock.h>
 #include <asm/x86_init.h>
 #include <asm/pkru.h>
 #include <asm/fpu/api.h>
