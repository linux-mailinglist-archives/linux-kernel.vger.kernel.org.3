Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54DE5472A29
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237214AbhLMKeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241308AbhLMKd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:33:29 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6580C08E847
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 02:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AAExEzQbLpYiB3/BVAzhS2Vhv9GIq4Z8LdHsWdtwfiE=; b=Rr/MaptYzC9AFVQ+oHsJtDRxfb
        /N24KCjXIFDpRpbUeicrvZLyoXNzU/cYgMaGMyZMVvKIe1zeTHHBdy38pQ9+9v6w1uiWYPgwvHBM8
        y3O9GxiIihSSYvoSU69XQGdKNbO3w/3xRfWAQrlo08vwh+EflZtXmDulrCdlRZz2f5cUpUSumIZsN
        nHfXPuU9xSYAIIs8pr0jndfPFK8DiFcCn27QkKemWeHUzwtH52fUPccw1r5MQcHVo0NVrU+nyBuIm
        EtcvQhc7uy5rmLpCp+MYGBdAmhxs0WAYpQ2io6ZIKiXs8zxEznwcxK0zptBDnq1inK178p6ojxIDb
        BXCqEtKA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwiFB-0016l1-UH; Mon, 13 Dec 2021 10:07:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DAABA3001C0;
        Mon, 13 Dec 2021 11:07:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C553320163AEE; Mon, 13 Dec 2021 11:07:40 +0100 (CET)
Date:   Mon, 13 Dec 2021 11:07:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        mark.rutland@arm.com, dvyukov@google.com, seanjc@google.com,
        pbonzini@redhat.com, mbenes@suse.cz
Subject: Re: [PATCH v2 16/23] x86,vmx: Provide asm-goto-output vmread
Message-ID: <YbcbbGW2GcMx6KpD@hirez.programming.kicks-ass.net>
References: <20211110100102.250793167@infradead.org>
 <20211110101325.840433319@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110101325.840433319@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a version that doesn't make clang ICE..

Paolo, since this doesn't really depend on the .fixup removal series,
feel free to collect it in the kvm tree or somesuch.

---
Subject: x86/vmx: Provide asm-goto-output vmread
From: Peter Zijlstra <peterz@infradead.org>
Date: Wed, 10 Nov 2021 11:01:18 +0100

Use asm-goto-output for smaller fast path code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/kvm/vmx/vmx_ops.h |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

--- a/arch/x86/kvm/vmx/vmx_ops.h
+++ b/arch/x86/kvm/vmx/vmx_ops.h
@@ -71,6 +71,31 @@ static __always_inline unsigned long __v
 {
 	unsigned long value;
 
+#ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
+
+	asm_volatile_goto("1: vmread %[field], %[output]\n\t"
+			  "jna %l[do_fail]\n\t"
+
+			  _ASM_EXTABLE(1b, %l[do_exception])
+
+			  : [output] "=r" (value)
+			  : [field] "r" (field)
+			  : "cc"
+			  : do_fail, do_exception);
+
+	return value;
+
+do_fail:
+	WARN_ONCE(1, "kvm: vmread failed: field=%lx\n", field);
+	pr_warn_ratelimited("kvm: vmread failed: field=%lx\n", field);
+	return 0;
+
+do_exception:
+	kvm_spurious_fault();
+	return 0;
+
+#else /* !CONFIG_CC_HAS_ASM_GOTO_OUTPUT */
+
 	asm volatile("1: vmread %2, %1\n\t"
 		     ".byte 0x3e\n\t" /* branch taken hint */
 		     "ja 3f\n\t"
@@ -99,6 +124,8 @@ static __always_inline unsigned long __v
 
 		     : ASM_CALL_CONSTRAINT, "=&r"(value) : "r"(field) : "cc");
 	return value;
+
+#endif /* CONFIG_CC_HAS_ASM_GOTO_OUTPUT */
 }
 
 static __always_inline u16 vmcs_read16(unsigned long field)

