Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B784C8EB0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbiCAPP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbiCAPP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:15:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0A242A25
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 07:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UoBxcPGC3UAO5MoKCwirDsxB9KccL9ZfKlxrg2nU4Rg=; b=C30FD7qT/eqfxIdgghplm/arpg
        RuT7OMxztANsTbDvk6dTA8RY+S9lOhgTFUFRRYdPjPh3vAi454kjZttBJFjhWv5F8C0nbGQT7GSPf
        wDK48E7rKz8Jqf/BfQYXA8fvZ7MK4eRkr1thTXUZkEFn67W+9yerWkN8qpEpQ5kGzOg+e1kvJ7BWr
        AB+BdmTVKtOu0Nx9reHWWGpcyd/RH26j6l8L8MOmPlsSPsDzaKKxO0kc/O76lxqWRxUe04HoxagHD
        Hkdkvoe8AgyvK85mXJNbO70fD4hmpYztzmKipIjc1gb+4w/9RzZwqkw1yMZ4oSvJgF+Ok+Ac4M7DX
        lEjzXfyA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nP4D8-009h2Q-1Q; Tue, 01 Mar 2022 15:14:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 82B1C30018E;
        Tue,  1 Mar 2022 16:14:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 60C62302AEE61; Tue,  1 Mar 2022 16:14:42 +0100 (CET)
Date:   Tue, 1 Mar 2022 16:14:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "Poimboe, Josh" <jpoimboe@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "joao@overdrivepizza.com" <joao@overdrivepizza.com>,
        "Cooper, Andrew" <andrew.cooper3@citrix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>,
        "Milburn, Alyssa" <alyssa.milburn@intel.com>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>
Subject: Re: [PATCH v2 18/39] x86/ibt: Add IBT feature, MSR and #CP handling
Message-ID: <Yh44YsW8viBscBD0@hirez.programming.kicks-ass.net>
References: <20220224145138.952963315@infradead.org>
 <20220224151323.069205370@infradead.org>
 <eed8902f21ba9e5f93562432f6b5920137860a98.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eed8902f21ba9e5f93562432f6b5920137860a98.camel@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 07:59:15PM +0000, Edgecombe, Rick P wrote:
> On Thu, 2022-02-24 at 15:51 +0100, Peter Zijlstra wrote:
> > +__noendbr void cet_disable(void)
> > +{
> > +       if (cpu_feature_enabled(X86_FEATURE_IBT))
> > +               wrmsrl(MSR_IA32_S_CET, 0);
> > +}
> > +
> 
> Did this actually work? 

No idea,.. I don't generally have kexec clue.

> There are actually two problems with kexecing
> when CET is enabled. One is leaving the enforcement enabled when the
> new kernel can't handle it. The other is that CR4.CET and CR0.WP are
> tied together such that if you try to disable CR0.WP while CR4.CET is
> still set, it will #GP. CR0.WP gets unset during kexec/boot in the new
> kernel, so it blows up if you just disable IBT with the MSR and leave
> the CR4 bit set.
> 
> I was under the impression that this had been tested in the userspace
> series, but apparently not as I've just produced the CR0.WP issue. So
> it needs to be fixed in that series too. Userspace doesn't really need
> it pinned, so it should be easy.

So I see CR0 frobbing in identity_mapped and CR4 frobbing right after
it. Is there a reason to first do CR0 and then CR4 or can we flip them?
Otherwise we need to do CR4 twice.

(Also, whoever wrote that function with _5_ identically named labels in
it deserves something painful. Also, wth's up with that jmp 1f; 1:)

Something like so?

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 399f075ccdc4..5b65f6ec5ee6 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -114,6 +114,14 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	/* store the start address on the stack */
 	pushq   %rdx
 
+	/*
+	 * Clear X86_CR4_CET (if it was set) such that we can clear CR0_WP
+	 * below.
+	 */
+	movq	%cr4, %rax
+	andq	$~(X86_CR4_CET), %rax
+	movq	%rax, %cr4
+
 	/*
 	 * Set cr0 to a known state:
 	 *  - Paging enabled
