Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DA54ACC53
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 23:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245237AbiBGWw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 17:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiBGWwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 17:52:25 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460C7C061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 14:52:25 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id y17so12291696plg.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 14:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O3kFa6bwXC/abDoIkd2VtviKDlMn3G2JcvbcBKX5XTg=;
        b=i34HOD1OWgot5JZ3TpwiylBM/ML4gpQcuIBA9Pf2wQQfvsqTTRSV2pbutcSiWobGmP
         ixmsFVyAB3glonu5FP9RQS6UjcmWPNyu0om3qAvyTqsdpQ+42G236Yb/O5fS+tKgyIwC
         Ml2rUyJ2sdEdLNgXcBd2Xdecqg1wA1rmsZPCsFR1OFEb8k291c38Kc02RZ1jmllNuGZl
         DfMnG/GLZgyPCdFloP1Nfjj/3OSjTnWJT7s+l6ac3Ynv0yljo9KYhkLsHRj064CYH+a7
         JP7564Cwy25WpAnnCnIFbfA/MCueq/uxNnPxcttNHnyCB+YB46g+cvBfKXGfA2RfUBdW
         kTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O3kFa6bwXC/abDoIkd2VtviKDlMn3G2JcvbcBKX5XTg=;
        b=2fLa6Afn+ulcDASmp9/z7AnL4CXPUr8YHUcuOhbWJKDa2o3ePpM7+eae8aEbzAInOg
         TQCXO0pVPWRaEPtq52kfr5wE7mrJ10chXawPfWmmaLgSlfDcI2+k9JCit/7O3jvtRQg0
         /LaS0dLxopmQbp4otefEB7dWvxqGHO0gy7dXygVtKes2b+DpkMWWM4qiqQv38FxZNCca
         hJLDX5KqA2CCncGWiH7OG08K01O4Bzx5xXkDGLjdF+G8u6VcVWhUg0IAAwNijqkmawgA
         8ZP+RF1Hih5UjLoZiFvlj9QbD+FaZ8qdNq1M4pqf81+Htr23GTuUwHMCSws/O9cerz3g
         5jEA==
X-Gm-Message-State: AOAM531LW74gtMnJ93S/wdljsRG8q/X2pKfzORyoBQv/Uymc3GsAA8aC
        1s8FtNXC3tNIGG1Od58lJP+h5w==
X-Google-Smtp-Source: ABdhPJyHSByWR+KsJ7yuX04GoP4ekxlQFMv554a8vowsYGz1hVlZBdXEOE+UVN8KNE80J/+LjCM9QA==
X-Received: by 2002:a17:902:a9c2:: with SMTP id b2mr1755615plr.168.1644274344509;
        Mon, 07 Feb 2022 14:52:24 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id q2sm13838043pfj.94.2022.02.07.14.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 14:52:23 -0800 (PST)
Date:   Mon, 7 Feb 2022 22:52:19 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, bp@alien8.de,
        aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        dave.hansen@intel.com, david@redhat.com, hpa@zytor.com,
        jgross@suse.com, jmattson@google.com, joro@8bytes.org,
        jpoimboe@redhat.com, knsathya@kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, sdeep@vmware.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org
Subject: Re: [PATCHv2.1 05/29] x86/tdx: Add HLT support for TDX guests
Message-ID: <YgGioxo4hnJBJUgT@google.com>
References: <YfVU01dBD36H0EIv@zn.tnic>
 <20220129223021.29417-1-kirill.shutemov@linux.intel.com>
 <874k5iz3ih.ffs@tglx>
 <20220202124830.yd4vkmy56j67tyz4@black.fi.intel.com>
 <875ypxur1n.ffs@tglx>
 <20220204165539.oqw7bj3ri4hzjiy6@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204165539.oqw7bj3ri4hzjiy6@black.fi.intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022, Kirill A. Shutemov wrote:
> > > Looks dubious to me, I donno. I worry about possible conflicts with the
> > > spec in the future.
> > 
> > The spec should have a reserved space for such things :)

Heh, the problem is someone has to deal with munging the two things together.
E.g. if there's a EXIT_REASON_SAFE_HLT then the hypervisor would need a handler
that's identical to EXIT_REASON_HLT, except with guest.EFLAGS.IF forced to '1'.
The guest gets the short end of the stick because EXIT_REASON_HLT is already an
established VM-Exit reason.

> > But you might think about having a in/out struct similar to the module
> > call or just an array of u64.
> > 
> > and the signature would become:
> > 
> > __tdx_hypercall(u64 op, u64 flags, struct inout *args)
> > __tdx_hypercall(u64 op, u64 flags, u64 *args)
> > 
> > and have flag bits:
> > 
> >     HCALL_ISSUE_STI
> >     HCALL_HAS_OUTPUT
> > 
> > Hmm?
> 
> We have two distinct cases: standard hypercalls (defined in GHCI) and KVM
> hypercalls. In the first case R10 is 0 (indicating standard TDVMCALL) and
> R11 defines the operation. For KVM hypercalls R10 encodes the operation
> (KVM hypercalls indexed from 1) and R11 is the first argument. So we
> cannot get away with simple "RDI is op" interface.
> 
> And we need to return two values: RAX indicates if TDCALL itself was
> successful and R10 is result of the hypercall. So we cannot easily get
> away without output struct. HCALL_HAS_OUTPUT is not needed.

But __tdx_hypercall() should never fail TDCALL.  The TDX spec even says:

  RAX TDCALL instruction return code. Always returns Intel TDX_SUCCESS (0).

IIRC, the original PoC went straight to a ud2 if tdcall failed.  Why not do
something similar?  That would get rid of the bajillion instances of:

	if (__tdx_hypercall(...))
		panic("Hypercall fn %llu failed (Buggy TDX module!)\n", fn);

E.g.

diff --git a/arch/x86/kernel/tdcall.S b/arch/x86/kernel/tdcall.S
index fde628791100..04284f0c198e 100644
--- a/arch/x86/kernel/tdcall.S
+++ b/arch/x86/kernel/tdcall.S
@@ -170,8 +170,10 @@ SYM_FUNC_START(__tdx_hypercall)
 .Lskip_sti:
        tdcall

+       test %rax, %rax,
+       jnz .Lerror
+
        /* Copy hypercall result registers to arg struct: */
-       movq %r10, TDX_HYPERCALL_r10(%rdi)
        movq %r11, TDX_HYPERCALL_r11(%rdi)
        movq %r12, TDX_HYPERCALL_r12(%rdi)
        movq %r13, TDX_HYPERCALL_r13(%rdi)
@@ -194,7 +196,13 @@ SYM_FUNC_START(__tdx_hypercall)
        pop %r14
        pop %r15

-       FRAME_END
+       FRAME_END
+
+       movq %r10, %rax
+       retq
+
+.Lerror:
+       <move stuff into correct registers if necessary>
+       call tdx_hypercall_error

-       retq
 SYM_FUNC_END(__tdx_hypercall)
