Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C85B497183
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 13:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236342AbiAWMmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 07:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbiAWMme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 07:42:34 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28227C06173B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 04:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Sg6z/rpvEyqSVZeO10t9Tkl5j1ljD3oRNlpBgyr2ooI=; b=V+h+Yi7G1dzQhMn2Aisq3AMJAW
        yBg4cj+ByfzfO18RzLTC4XL/SHYX8g39hC2ldvelreErZanbGljjZOqFhJrzad6ftbmnqUFw3iyex
        9N392tvblJ0AUtnCMsDtnB1bIBcEyfDpO8VYrYvXzW+qXktfWAuZxMbvGljZFnabSAYinnvciiULf
        VCNzuRnsbIQWUf/DPqqrsUgsUy6733JT0FDfO6nPLCBaF00y2a6LKhS+xaQSg1G0J/Bc7JSvI45oH
        /hTQuDTneUS3Gdb97+ZmMkuuH6W2bmgTPMpzMTYQ5kQvYEAM2HsriP2/i8o7tNZFTlhN5g4zy4jEn
        04h9LkLg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBcCL-002wCU-8A; Sun, 23 Jan 2022 12:42:21 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B04BA98624A; Sun, 23 Jan 2022 13:42:19 +0100 (CET)
Date:   Sun, 23 Jan 2022 13:42:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     dwmw@amazon.co.uk, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86,kvm/xen: Remove superfluous .fixup usage
Message-ID: <20220123124219.GH20638@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Commit 14243b387137 ("KVM: x86/xen: Add KVM_IRQ_ROUTING_XEN_EVTCHN and
event channel delivery") adds superfluous .fixup usage after the whole
.fixup section was removed in commit e5eefda5aa51 ("x86: Remove .fixup
section").

Fixes: 14243b387137 ("KVM: x86/xen: Add KVM_IRQ_ROUTING_XEN_EVTCHN and event channel delivery")
Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kvm/xen.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 0e3f7d6e9fd7..bad57535fad0 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -316,10 +316,7 @@ int __kvm_xen_has_interrupt(struct kvm_vcpu *v)
 				     "\tnotq %0\n"
 				     "\t" LOCK_PREFIX "andq %0, %2\n"
 				     "2:\n"
-				     "\t.section .fixup,\"ax\"\n"
-				     "3:\tjmp\t2b\n"
-				     "\t.previous\n"
-				     _ASM_EXTABLE_UA(1b, 3b)
+				     _ASM_EXTABLE_UA(1b, 2b)
 				     : "=r" (evtchn_pending_sel),
 				       "+m" (vi->evtchn_pending_sel),
 				       "+m" (v->arch.xen.evtchn_pending_sel)
@@ -335,10 +332,7 @@ int __kvm_xen_has_interrupt(struct kvm_vcpu *v)
 				     "\tnotl %0\n"
 				     "\t" LOCK_PREFIX "andl %0, %2\n"
 				     "2:\n"
-				     "\t.section .fixup,\"ax\"\n"
-				     "3:\tjmp\t2b\n"
-				     "\t.previous\n"
-				     _ASM_EXTABLE_UA(1b, 3b)
+				     _ASM_EXTABLE_UA(1b, 2b)
 				     : "=r" (evtchn_pending_sel32),
 				       "+m" (vi->evtchn_pending_sel),
 				       "+m" (v->arch.xen.evtchn_pending_sel)
