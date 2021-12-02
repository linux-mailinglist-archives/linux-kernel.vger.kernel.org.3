Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B66466251
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357343AbhLBLbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:31:04 -0500
Received: from foss.arm.com ([217.140.110.172]:33858 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357329AbhLBLbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:31:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BBA61435;
        Thu,  2 Dec 2021 03:27:40 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 545ED3F7D7;
        Thu,  2 Dec 2021 03:27:39 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     andreyknvl@gmail.com, catalin.marinas@arm.com, dvyukov@google.com,
        glider@google.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, ryabinin.a.a@gmail.com, will@kernel.org
Subject: [PATCH 2/3] arm64: mm: use die_kernel_fault() in do_mem_abort()
Date:   Thu,  2 Dec 2021 11:27:30 +0000
Message-Id: <20211202112731.3346975-3-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211202112731.3346975-1-mark.rutland@arm.com>
References: <20211202112731.3346975-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we take an unhandled fault from EL1, either:

a) The xFSC handler calls die_kernel_fault() directly. In this case,
   die_kernel_fault() calls:

   pr_alert(..., msg, addr);
   mem_abort_decode(esr);
   show_pte(addr);
   die();
   bust_spinlocks(0);
   do_exit(SIGKILL);

b) The xFSC handler returns to do_mem_abort(), indicating failure. In
   this case, do_mem_abort() calls:

   pr_alert(..., addr);
   mem_abort_decode(esr);
   show_pte(addr);
   arm64_notify_die() {
     die();
   }

This inconstency is unfortunatem, and in theory in case (b) registered
notifiers can prevent us from terminating the faulting thread by
returning NOTIFY_STOP, whereupon we'll end up returning from the fault,
replaying, and almost certainly get stuck in a livelock spewing errors
into dmesg. We don't expect notifers to fix things up, since we dump
state to dmesg before invoking them, so it would be more sensible to
consistently terminate the thread in this case.

This patch has do_mem_abort() call die_kernel_fault() for unhandled
faults taken from EL1. Where we would previously have logged a messafe
of the form:

| Unhandled fault at ${ADDR}

... we will now log a message of the form:

| Unable to handle kernel ${FAULT_NAME} at virtual address ${ADDR}

... and we will consistently terminate the thread from which the fault
was taken.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/mm/fault.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 9ae24e3b72be..b7b9caa41bc7 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -813,11 +813,8 @@ void do_mem_abort(unsigned long far, unsigned int esr, struct pt_regs *regs)
 	if (!inf->fn(far, esr, regs))
 		return;
 
-	if (!user_mode(regs)) {
-		pr_alert("Unhandled fault at 0x%016lx\n", addr);
-		mem_abort_decode(esr);
-		show_pte(addr);
-	}
+	if (!user_mode(regs))
+		die_kernel_fault(inf->name, addr, esr, regs);
 
 	/*
 	 * At this point we have an unrecognized fault type whose tag bits may
-- 
2.30.2

