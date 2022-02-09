Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73154AF8FA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 19:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238637AbiBISF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 13:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238664AbiBISFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 13:05:55 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A7FC05CB8A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 10:05:57 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d187so5612769pfa.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 10:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cLKRoZKI4DKqnlTpSUuiPfKYmbbblSbQTVtpGt2hOnI=;
        b=fg5mBfIO6Vmm49SxuTT0koEmgvh+HMrBCznuu+MWsGESFDGvWVtd5PIpDSq9DwZM+n
         fcpiG1DhKB77jCXR7mMjE7jSo2sXAXGkBQcaGOfg9Ba6/2lKIxj3b6Q/2V3kQafiFcrn
         R+XqNrKZY9x/dLCaBzi6QTIRBJ9VEKgWlsfWIZCr1ol4IARVu9gGzx1Augkxr1BwSVxe
         NcW2tp73+8KY9VveaDGQBridg/26eGjTnveKmLPKTI++fz+eZdoAhCNFde5JhDl80RAd
         ftpH/k0VdjUlBF7Cp9eQIi7NZoV0ppui574MmmnUWucwsp2mv0DA+DK8xv3rkRcRRY74
         JIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cLKRoZKI4DKqnlTpSUuiPfKYmbbblSbQTVtpGt2hOnI=;
        b=40gFGseoM59g22AwXMFwF6ls9S9ea6+5MQlkwoKpLFusS/J2YChHSWUIuormgnEuRZ
         u5QPkSpobznpNmDR4kD+kNEL08RdiCp3Gjrd19gPd9LAz8dvhXnjl+7IBKbXiJ/2+zGk
         2cQCv4Klw8FVUy/i9RsNg4l23fVvZvaBqemX1G+zcKIi/xT4AzL9Y9nkN161Kjg3isMc
         pnuBsXhhhgJ2oxc/4laE/ZEZYG+ZQv8GdMEtNBd+dKxm89BidT1RZ2bPMsTq521Nzqt6
         RgkTUGRKwfI+TlUHqUOQwZ+CK0sqore+s3B7Uv/FoWkIoEbAN710THaI3vCIT12p6MNi
         dJ+A==
X-Gm-Message-State: AOAM531Bl86ecskwE2FUIqHCXUTMFQipGbL9pha0NhDN0Ulr0I0bzhDd
        8JymXMyIdM82A8zyAy6571Zi1g==
X-Google-Smtp-Source: ABdhPJwpI/L6rbiGhLckNIoByaFKGEzzVQZHGW9SUEbExOizaOg+SPFwwfRYBBmSIEoB3i+2JFnK9g==
X-Received: by 2002:a05:6a00:22d1:: with SMTP id f17mr3509456pfj.13.1644429956839;
        Wed, 09 Feb 2022 10:05:56 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id e13sm3783813pfv.3.2022.02.09.10.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 10:05:56 -0800 (PST)
Date:   Wed, 9 Feb 2022 18:05:52 +0000
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
Message-ID: <YgQCgCx0R+RvFkyE@google.com>
References: <YfVU01dBD36H0EIv@zn.tnic>
 <20220129223021.29417-1-kirill.shutemov@linux.intel.com>
 <874k5iz3ih.ffs@tglx>
 <20220202124830.yd4vkmy56j67tyz4@black.fi.intel.com>
 <875ypxur1n.ffs@tglx>
 <20220204165539.oqw7bj3ri4hzjiy6@black.fi.intel.com>
 <YgGioxo4hnJBJUgT@google.com>
 <20220209143407.by4s2h4zybfbvlhv@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209143407.by4s2h4zybfbvlhv@black.fi.intel.com>
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

On Wed, Feb 09, 2022, Kirill A. Shutemov wrote:
> On Mon, Feb 07, 2022 at 10:52:19PM +0000, Sean Christopherson wrote:
> .Lskip_sti:
> 	tdcall
> 
> 	/*
> 	 * TDVMCALL leaf does not suppose to fail. If it fails something
> 	 * is horribly wrong with TDX module. Stop the world.
> 	 */
> 	test %rax, %rax
> 	je .Lsuccess
> 	ud2

If the ud2 or call to an external "do panic" helper is out-of-line, then the happy
path avoids a taken branch.  Not a big deal, but it's also trivial to do.

> .Lsuccess:
> 	/* TDVMCALL leaf return code is in R10 */
> 	movq %r10, %rax
> 
> 	/* Copy hypercall result registers to arg struct if needed */
> 	testq $TDX_HCALL_HAS_OUTPUT, %rsi
> 	jz .Lout
> 
> 	movq %r10, TDX_HYPERCALL_r10(%rdi)
> 	movq %r11, TDX_HYPERCALL_r11(%rdi)
> 	movq %r12, TDX_HYPERCALL_r12(%rdi)
> 	movq %r13, TDX_HYPERCALL_r13(%rdi)
> 	movq %r14, TDX_HYPERCALL_r14(%rdi)
> 	movq %r15, TDX_HYPERCALL_r15(%rdi)
> .Lout:
> 	/*
> 	 * Zero out registers exposed to the VMM to avoid
> 	 * speculative execution with VMM-controlled values.
> 	 * This needs to include all registers present in
> 	 * TDVMCALL_EXPOSE_REGS_MASK (except R12-R15).
> 	 * R12-R15 context will be restored.

This comment block should use the "full" 80 chars.

> 	 */
> 	xor %r10d, %r10d
> 	xor %r11d, %r11d
> 
> 	/* Restore callee-saved GPRs as mandated by the x86_64 ABI */
> 	pop %r12
> 	pop %r13
> 	pop %r14
> 	pop %r15
> 
> 	FRAME_END
> 
> 	retq
> SYM_FUNC_END(__tdx_hypercall)
> -- 
>  Kirill A. Shutemov
