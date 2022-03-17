Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DAB4DBBEA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 01:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354206AbiCQAuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 20:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235950AbiCQAuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 20:50:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB271A3A4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 17:48:56 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647478135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E+I2OaTMS7yIBdpG2ZjhPVOzcWitmDk5Sz3Ki56Qk9c=;
        b=CCn9/qBit4a8Gzo3WK6I/8fHd/DuILEyz09ecA2i49PpVtIQdLNFDLbYiET2cXlRUU9Abf
        A4Uw0UCwRT03+XgtN6VKihzkK3Kt1FH3TfY54PJ728YSsJPzFV6kd5mEhqvGAfi/aO9xem
        2t0ohZmqcd4rbKNv60jjvPF0UXarO+c1xJrId4sltFC0gm1C1G2yL5NTapg+Wv+n4G9XxS
        GpgSeXnJDWPRovxC7NE4y4YDyej8S3kRPt7UV2zVy1zSeDHGrbGsMlrs8aMPv6UhyOm0F+
        EIx0mcS+/uWDX/9XeP66P/n+oNvoJ8pOk2TG306YY4AyUzGKQGO1EPx6TkxaeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647478135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E+I2OaTMS7yIBdpG2ZjhPVOzcWitmDk5Sz3Ki56Qk9c=;
        b=gzkIHjRH6o8WZ8ZChDRDFNX+8SRLEXXSYIKteRAqckvuGy3+22otFFEHMYSm4T0pk6Vstd
        M0ABuiKzbDUbm0DA==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCHv6 07/30] x86/traps: Add #VE support for TDX guest
In-Reply-To: <20220316020856.24435-8-kirill.shutemov@linux.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-8-kirill.shutemov@linux.intel.com>
Date:   Thu, 17 Mar 2022 01:48:54 +0100
Message-ID: <877d8t2ykp.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16 2022 at 05:08, Kirill A. Shutemov wrote:
> +void tdx_get_ve_info(struct ve_info *ve)
> +{
> +	struct tdx_module_output out;
> +
> +	/*
> +	 * Called during #VE handling to retrieve the #VE info from the
> +	 * TDX module.
> +	 *
> +	 * This should called done early in #VE handling.  A "nested"


... has to be called early ..

> +	 * #VE which occurs before this will raise a #DF and is not
> +	 * recoverable.
> +	 */
> +	tdx_module_call(TDX_GET_VEINFO, 0, 0, 0, 0, &out);
> +
> +	/* Interrupts and NMIs can be delivered again. */

Please put a new line between this comment and the code below because
they are completely unrelated. Also interrupts cannot be delivered here
because this code runs with interrupts disabled ...

And I rather have this comment above the tdx_module_call() invocation:

	 * recoverable.
         *
         * <Useful comment about VE info and NMIs>

When I reviewed this last time, Sean provided a very concise comment for
this.

         */
         tdx_module_call(...);
         
         /* Transfer the output parameters */

> +	ve->exit_reason = out.rcx;
        ....

Hmm?

> +/*
> + * Virtualization Exceptions (#VE) are delivered to TDX guests due to
> + * specific guest actions which may happen in either user space or the
> + * kernel:
> + *
> + *  * Specific instructions (WBINVD, for example)
> + *  * Specific MSR accesses
> + *  * Specific CPUID leaf accesses
> + *  * Access to specific guest physical addresses
> + *
> + * In the settings that Linux will run in, virtualization exceptions are
> + * never generated on accesses to normal, TD-private memory that has been
> + * accepted.
> + *
> + * Syscall entry code has a critical window where the kernel stack is not
> + * yet set up. Any exception in this window leads to hard to debug issues
> + * and can be exploited for privilege escalation. Exceptions in the NMI
> + * entry code also cause issues. Returning from the exception handler with
> + * IRET will re-enable NMIs and nested NMI will corrupt the NMI stack.
> + *
> + * For these reasons, the kernel avoids #VEs during the syscall gap and
> + * the NMI entry code. Entry code paths do not access TD-shared memory,
> + * MMIO regions, use #VE triggering MSRs, instructions, or CPUID leaves
> + * that might generate #VE.

I asked that before:

  "How is that enforced or validated? What checks for a violation of that
   assumption?"

This is still exactly the same comment which is based on testing which
did not yet explode in your face, right?

So what's the point of this blurb? Create expectations which are not
accountable?

The point is that any #VE in such a code path is fatal and you better
come up with some reasonable explanation why this is not the case in
those code pathes and how a potential violation of that assumption might
be detected especially in rarely used corner cases. If such a violation
is not detectable by audit, CI, static code analysis or whatever then
document the consequences instead of pretending that the problem does
not exist and the kernel is perfect today and forever.

Thanks,

        tglx
