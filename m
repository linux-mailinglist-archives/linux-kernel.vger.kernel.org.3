Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D98E484BBB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 01:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236750AbiAEAaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 19:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbiAEAax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 19:30:53 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340C9C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 16:30:52 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id i31so85275093lfv.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 16:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pGn8mwWk9uFwVH9e4BklaIBK8QVpJDJCTI25vnyWF88=;
        b=W/Y6SsiyTwKDnreLyzcOc74AOcq4l5zMNgG6d/tR+L1hY3tg/R37MN4MB1zyzzKurP
         J6tKLC1QURxJrM6Q/XFWwLYxtwDp2t/RtApiYsiwlAYmBBnQaZY0gafJwhnNGfZLobF+
         NL1PpSyY2ICmofuY7AvVt2bAZ876cvlt9q/AtCSLv7EeszaHRwqYJ6Br71hJwaK5wuS4
         f4yiIKwHrNv0JiYkK3Dhl6VFzREDNy+2MRQxaB2qaeJz5ep0OcNPw2Rf5Ky0j5DJhNtu
         noD4oJzHEbViH1dlo3oLogZBp/Ugk21FHHxSSPEkueVih8gbUw9BK7qp4yCwB9kvY3y+
         Ab4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pGn8mwWk9uFwVH9e4BklaIBK8QVpJDJCTI25vnyWF88=;
        b=kMyZqOrQOdEANQ03sv9Rx4KhBB6M9uUFjUsRjb+h2kkuskuzltp/Sb/LQJPdkMCqDj
         W3Lx08XhxU1jPVeAEiNmGEqNl1a1srKg3VQkoVr4aey3CQSWZ8UkCNU4uLQF+vOEs+q8
         m8jQuUIGeR7gB9R24t9wIAiwXchSIqIt8oEXpsLdQZ4N1T6dLUFtjViPFNnGXqxQKGfX
         +K1/zYu35jfql8Hl+PjnjOZD1tlo+bdzoLgmuzFynTdYVBQ4Du0Gun+lF1OKqDivGBB2
         z7k6Rc7zuWn2aV/CEWucmA+KvuPBavm5+VMnsJO4EbIzAGLKynH6cp0rtrgaM2lXJN7l
         b9uQ==
X-Gm-Message-State: AOAM530Y9TZ+iAx+t/T3T3eadW2coqVCU7GfW3a3H98Oz3lFp19J3qZd
        50CDbV3OG73X6OZwmEJnKLdOpQ==
X-Google-Smtp-Source: ABdhPJyluQBOx8lnlXExv7zkOndN0b/9ZpokfXexflY7JYGRQNKBdMqXFXqfCGlyUbD3Ck6RvSOhgA==
X-Received: by 2002:ac2:52a3:: with SMTP id r3mr45430778lfm.580.1641342650509;
        Tue, 04 Jan 2022 16:30:50 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id b3sm4063894lfp.48.2022.01.04.16.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 16:30:49 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id B59B7103147; Wed,  5 Jan 2022 03:31:08 +0300 (+03)
Date:   Wed, 5 Jan 2022 03:31:08 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, tglx@linutronix.de,
        mingo@redhat.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/26] x86/tdx: Make pages shared in ioremap()
Message-ID: <20220105003108.mr7zyd5oyaaxmnmv@box.shutemov.name>
References: <YcTlhp1PUfrMOelI@zn.tnic>
 <20211224110300.7zj3nc5nbbv7jobp@black.fi.intel.com>
 <33914dc1-37e8-f0bb-6468-71c3b5f4169d@amd.com>
 <20220103141705.6hqflhwykqmtfim6@black.fi.intel.com>
 <YdMIWAT42el4D6wJ@zn.tnic>
 <20220103151516.pfcz2pap5l7r2rzv@box.shutemov.name>
 <b4b54116-1cd7-468a-0889-d497268cbfb2@intel.com>
 <20220103181059.ui5eloufw5gsojcb@box.shutemov.name>
 <20220104191424.oly2gqm4ltzj5wo3@box.shutemov.name>
 <0e0c38e2-67ad-1f51-c44b-d3c3d505e40a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e0c38e2-67ad-1f51-c44b-d3c3d505e40a@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 12:36:06PM -0800, Dave Hansen wrote:
> On 1/4/22 11:14 AM, Kirill A. Shutemov wrote:
> > I see two possible options (I hate both): leave it defined in per-arch
> > <asm/pgtable.h> or move it to <linux/mm.h> next to user in
> > io_remap_pfn_range().
> 
> Could we do an asm-generic/pgprot.h that was basically just:
> 
> 	typedef struct { unsigned long pgprot; } pgprot_t;
> 
> That would cover probably 80% of the of the architectures.  The rest of
> them could define an actual asm/pgprot.h.

A file per typedef looks like an overkill.

Maybe <asm-generic/types.h> that included from <asm/types.h> would be
easier to justify. Some archs already have <asm/types.h>

Although, it is not as simple as your patches. See below.

> 
> It doesn't seem to be *that* much work, although it is a bit of a shame
> that pgtable-types.h doesn't fix this already.  I've attached something
> that compiles on s390 (representing a random non-x86 architecture) and x86.



> diff -puN arch/sparc/include/asm/page_32.h~pgprot-generic arch/sparc/include/asm/page_32.h
> --- a/arch/sparc/include/asm/page_32.h~pgprot-generic	2022-01-04 12:00:31.651180536 -0800
> +++ b/arch/sparc/include/asm/page_32.h	2022-01-04 12:00:31.659180446 -0800
> @@ -10,6 +10,7 @@
>  #define _SPARC_PAGE_H
>  
>  #include <linux/const.h>
> +#include <asm-generic/pgprot.h>
>  
>  #define PAGE_SHIFT   12
>  #define PAGE_SIZE    (_AC(1, UL) << PAGE_SHIFT)
> @@ -57,7 +58,6 @@ typedef struct { unsigned long iopte; }
>  typedef struct { unsigned long pmd; } pmd_t;
>  typedef struct { unsigned long pgd; } pgd_t;
>  typedef struct { unsigned long ctxd; } ctxd_t;
> -typedef struct { unsigned long pgprot; } pgprot_t;
>  typedef struct { unsigned long iopgprot; } iopgprot_t;
>  
>  #define pte_val(x)	((x).pte)
> @@ -85,7 +85,6 @@ typedef unsigned long iopte_t;
>  typedef unsigned long pmd_t;
>  typedef unsigned long pgd_t;
>  typedef unsigned long ctxd_t;
> -typedef unsigned long pgprot_t;
>  typedef unsigned long iopgprot_t;
>  
>  #define pte_val(x)	(x)

Any arch that use STRICT_MM_TYPECHECKS hacks will get broken if compiled
without the define (as sparc by default).

It's fixable with more crunch (and more build bugs). I think we can use
approach from posix_types.h where asm-generic version defines the type if
it was not defined by the arch code.

Is it the way to go we want?

-- 
 Kirill A. Shutemov
