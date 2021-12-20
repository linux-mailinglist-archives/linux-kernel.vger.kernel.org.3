Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5E047AACF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 15:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbhLTOAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 09:00:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48230 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbhLTOAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 09:00:48 -0500
Date:   Mon, 20 Dec 2021 14:00:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1640008847;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=4NUQQSVwxddAYWUDoOtrc+IdNXMpYwNUDekEgjVNrV8=;
        b=zqGwdBa0CxZAwR6p7zepz9uVwdlWWH4qsTb2Sk0wUcg8/WSw3NDXaLxLuiESaJoiT2dsHb
        F0rsXrK4ifRGivdyinPOPP9LjxqDHR82enTyXtd7jZD8/pLSqpQGplriicbT6n96nSB8+P
        M5msQyqRfEhektpb+uTg925PWQcDNr+7/5QJ/xlwFl0cq3cEADoRFmqamkx9ujmFp1te/Z
        V1Nt9Vlb2FJz3SjVsgekXlUY15nw5VtuwpTmX6KlVgd/+OJFOopB1530iw3cvJZU9Ufkhr
        t8DypKfFDogv8S0rGvyrn6eww6m6ea9MHwhcALHsdrQgQOTmSRsX6bvhPtdISg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1640008847;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=4NUQQSVwxddAYWUDoOtrc+IdNXMpYwNUDekEgjVNrV8=;
        b=3zeCT4WMbrK1Uorlb4tNFhXxaq2QOqp431h/t2/7z/ONCqH1sBbniq600WRtiw7Zjd8iaN
        sS8ZHmxCs4jbwYBQ==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] KVM: arm64: Drop unused workaround_flags
 vcpu field
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <164000884613.23020.16840133765876356033.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     142ff9bddbde757674c7081ffc238cfcffa1859b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/142ff9bddbde757674c7081ffc238cfcffa1859b
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 08 Dec 2021 14:46:41 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 08 Dec 2021 14:54:07 

KVM: arm64: Drop unused workaround_flags vcpu field

workaround_flags is a leftover from our earlier Spectre-v4 workaround
implementation, and now serves no purpose.

Get rid of the field and the corresponding asm-offset definition.

Fixes: 29e8910a566a ("KVM: arm64: Simplify handling of ARCH_WORKAROUND_2")
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h | 3 ---
 arch/arm64/kernel/asm-offsets.c   | 1 -
 2 files changed, 4 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 2a5f7f3..3811d19 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -298,9 +298,6 @@ struct kvm_vcpu_arch {
 	/* Exception Information */
 	struct kvm_vcpu_fault_info fault;
 
-	/* State of various workarounds, see kvm_asm.h for bit assignment */
-	u64 workaround_flags;
-
 	/* Miscellaneous vcpu state flags */
 	u64 flags;
 
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 6d0c3af..1197e76 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -111,7 +111,6 @@ int main(void)
 #ifdef CONFIG_KVM
   DEFINE(VCPU_CONTEXT,		offsetof(struct kvm_vcpu, arch.ctxt));
   DEFINE(VCPU_FAULT_DISR,	offsetof(struct kvm_vcpu, arch.fault.disr_el1));
-  DEFINE(VCPU_WORKAROUND_FLAGS,	offsetof(struct kvm_vcpu, arch.workaround_flags));
   DEFINE(VCPU_HCR_EL2,		offsetof(struct kvm_vcpu, arch.hcr_el2));
   DEFINE(CPU_USER_PT_REGS,	offsetof(struct kvm_cpu_context, regs));
   DEFINE(CPU_RGSR_EL1,		offsetof(struct kvm_cpu_context, sys_regs[RGSR_EL1]));
