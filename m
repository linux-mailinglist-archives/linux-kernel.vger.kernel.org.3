Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0823D48BAEF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 23:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243698AbiAKWsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 17:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiAKWsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 17:48:35 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CED3C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 14:48:35 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id r16-20020a17090a0ad000b001b276aa3aabso8215430pje.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 14:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kRh0KmEC8nqxVLtpCaTLHurm3e7u3dpl262Fuin05WE=;
        b=lE+RzzYJyeEH2oenRhTopX0euye5+arj0LzRfgogHAlAdfSrKtvBrkRCz3qmKSmWMf
         9poPw5rl4payrFi6NyNSnsQtNg7Gq9dktjt0lg6teCbN71rlnEQ9FZs8zivc9sQrBanq
         JvjUAc6hQfrYm4bCoTd7Al5S+87Y8sNwGVBOIMuBejmycZHiKYrEvDoxuJaIke25un41
         EwdyqTQQix5I65HExnatk8iJJTZ+6ujEuGlgACr8wQzFFzuHM6hRSWlR2lcv6YJBFzy3
         fEBKASNz2lIipd/Ho/mVeld/AUmzq1LT83/vE5TWMq7ow0fFV2StJ7zxQmFk/CWSNwZp
         1EnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kRh0KmEC8nqxVLtpCaTLHurm3e7u3dpl262Fuin05WE=;
        b=OQdyWPl3TsxCeFgH+mXJx9qIav8zmWcDXg8YEUj/r/qKVb78sZBOcgIch24phJT89k
         PThqNVk19rycC9PjWe9GOS23QKrzA17kX/hs4buOIlaJKbVQAu7D3WWbPFBKz416t24j
         UXyeLL3GH11FVhl9gxVD3UOa5ikPF5FoXlqCZqS6bGtdgaTqCUwaGR7guRY9bnpjUtA0
         rIl9aK6WCJl4/yTUjl2VlbeNPkZskB6WBG8X9TFtUa9PxUZBN1hXzq16Rvynz9JXV1a3
         Wc343rjZR04h6yntPG7g3O8tJiLdMPsgvLERDVpbSUWu33+9XzUcheTSHARWzrb7nAhP
         I5vw==
X-Gm-Message-State: AOAM533/F4x48bSrVe4fgbedydf0of40ZX9vzcUKwXOVcp1NSGEYupKk
        9gWlUVFQotZrVPTsjnyNrAq38Q==
X-Google-Smtp-Source: ABdhPJwB0GI4JShk3x77Qj8KLVUZcZH2dNh6ZKRkuyHAEwPk6kmsb3+UeZlOsm4nsiA+3gmfKH4LuA==
X-Received: by 2002:a63:9d46:: with SMTP id i67mr5820104pgd.441.1641941314951;
        Tue, 11 Jan 2022 14:48:34 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 24sm341247pgv.60.2022.01.11.14.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 14:48:34 -0800 (PST)
Date:   Tue, 11 Jan 2022 22:48:30 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Borislav Petkov <bp@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>
Subject: Re: [GIT PULL] x86/cpu for v5.17
Message-ID: <Yd4JPvLiGioBFh0C@google.com>
References: <YdwVl0H54fmUIux0@zn.tnic>
 <CAHk-=wh+UbGrgH4CzKSoTYGPidyv5isiLMxJKAqnV3NFTiRdaQ@mail.gmail.com>
 <Ydx8fUCotPI++UEW@zn.tnic>
 <265db742-0539-a66f-ff00-2b18cb2add88@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <265db742-0539-a66f-ff00-2b18cb2add88@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022, Dave Hansen wrote:
> On 1/10/22 10:35, Borislav Petkov wrote:
> > > 
> > > Not a big deal, I just thought I'd mention it since I reacted to it.
> > > And we don't seem to have those vendor checks in any of the other code
> > > that uses MSR_CSTAR (just grepping for that and seeing it mentioned in
> > > kvm code etc)
> > Right, the only point for doing the vendor check I see here is, well,
> > because it is Intel who doesn't have CSTAR, let's check for Intel. But
> > yeah, we do avoid the vendor checks if it can be helped.
> > 
> > We can do a synthetic X86_FEATURE flag but that would be a waste. So the
> > _safe thing and keep the comment sounds optimal to me.
> > 
> > I can whip up a patch ontop if people agree.
> 
> There are four basic options here for TDX:
> 
> 1. Paper over the #VE in the #VE handler itself
> 2. Do a check for TDX at the wrmsr(MSR_CSTAR) site
> 3. Do a check for X86_VENDOR_INTEL at the wrmsr(MSR_CSTAR) site
> 4. Use wrmsr*_safe() and rely on #VE -> fixup_exception()
> 
> TDX originally did #1, passed over #2 and settled on #3 because of a
> comment:
> 
> 	It's an obvious optimization (avoiding the WRMSR with a
> 	conditional) without TDX because the write is pointless
> 	independent of TDX." [1]
> 
> I think doing wrmsr*_safe() is OK.  But, on TDX systems, it will end up
> taking a weird route:
> 
>       WRMSR -> #VE -> hypercall -> ve_raise_fault() -> fixup_exception()
> 
> instead of the "normal" _safe route which goes:
> 
>       WRMSR -> #GP -> ... -> fixup_exception()
> 
> So, we should probably make sure wrmsr*_safe() is fine on TDX before we
> subject ourselves to any additional churn.  Kirill, can you test that out?

wrmsr*_safe() isn't, uh, safe.  The issue is that the #VE -> hypercall will expose
information about the guest kernel's layout (address of a kernel symbol) to the
untrusted hypervisor, and in theory could be used to attack the guest.  Whether
or not the kernel's layout is all that valuable of a secret is debatable, but it's
hard to argue that the kernel should knowingly expose such information to the host.

Most VMMs probably won't even signal failure on the hypercall, i.e. the kernel will
never do fixup_exception(), the real motivation is to avoid the hypercall.

The argument against papering over the fault in the #VE handler is that there's
exactly one wrmsr(MSR_CSTAR) in the entire kernel, i.e. it's a wash from a code
perspective, and avoiding the wrmsr entirely will allow the #VE handler to WARN
if something else in the kernel ends up writing MSR_CSTAR.
