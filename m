Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D892348504F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 10:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239047AbiAEJp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 04:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiAEJpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 04:45:55 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD75C061761
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 01:45:54 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id q8so49267591ljp.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 01:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m2dmWhXik/U4SGJxPR+hpy5ElrZ2heFLJksoWt01r30=;
        b=RJSwHhSqfttUvklQOR/LK7vkmxvpmdFAcDnTVdEWkiTcTVuOVAPkZZOW+pEERtytre
         DNpixvqYh4wNgFXDosGAEyD6xAsJU3P8t16gaQxtTphuyrmzjjynozwBmoTJ+jZPK3m7
         g/fD+f1wXjIK2PiGvh5ulh/Ya7rKd5+iPQfMmYon8DYanQMh2CGOLwpenBaEEMTVGvrp
         vsXTylQeQRkcV6WwZFqrZnXXzrAGttnG1ltdjBsLtfEQeL5qfhdH0vUbfhlVDtOOAaaM
         LcEg/xDjLbGgwO6UoSGYNP+TzSO/FD/nBCLv4i9Ry84G0Q3JHcUvvcYPlw9b+HPmvr58
         TX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m2dmWhXik/U4SGJxPR+hpy5ElrZ2heFLJksoWt01r30=;
        b=dP1PDxGUOCvLbGTRJU7jgbiQ2upGJ5NTZjk2JDsmUOi9RMUySLOrFhTyirHkxkCzVt
         YAyCem3bkjafN/tvA6tbwgt2nFwI/mhb5mUn8wP4rJltk/aUEmbx+Kw9VU7EvTIGQ8NS
         h+eEq6fWjxvgQ8zWwlFb7kpOLtODh0DLM9dwZIx0E4xAKXjVBjcevFvCv8ftCHlNhtIy
         0PaCShoPn9elToPcJUy2drvGIjXMp0bhIyYnm18m8rF64sSEpnyvZ7FKn8KBjmTLLOBW
         Cxpr20j9Gh6ioAH9ytSGk5Etu7xXE0HCuVc6CfeTOPpZyrXsM5ntJfmzsvJNberGRFcm
         6Y9w==
X-Gm-Message-State: AOAM533Kn0QdOAnHJoQBYvniktuNt5SELkJWwc5wFXhM2CtnvypdskHH
        OSpaAVbhqKPBydfejEqLGccDgw==
X-Google-Smtp-Source: ABdhPJxBqnszFA+50s0l6Us/n0U+kj7hlfE6NXUUWeG9xLlnW3p/P0LMp7yQH8F23/7YGg6koKO3UQ==
X-Received: by 2002:a2e:a58e:: with SMTP id m14mr31201325ljp.172.1641375953030;
        Wed, 05 Jan 2022 01:45:53 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id a23sm4137164lfm.235.2022.01.05.01.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 01:45:52 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 3BB3E10425A; Wed,  5 Jan 2022 12:46:11 +0300 (+03)
Date:   Wed, 5 Jan 2022 12:46:11 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>,
        "David S. Miller" <davem@davemloft.net>
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
Message-ID: <20220105094611.kugiarylwjjjttkc@box.shutemov.name>
References: <YdMIWAT42el4D6wJ@zn.tnic>
 <20220103151516.pfcz2pap5l7r2rzv@box.shutemov.name>
 <b4b54116-1cd7-468a-0889-d497268cbfb2@intel.com>
 <20220103181059.ui5eloufw5gsojcb@box.shutemov.name>
 <20220104191424.oly2gqm4ltzj5wo3@box.shutemov.name>
 <0e0c38e2-67ad-1f51-c44b-d3c3d505e40a@intel.com>
 <20220105003108.mr7zyd5oyaaxmnmv@box.shutemov.name>
 <50dfa0db-fcd1-3c54-d982-237d2c9df431@intel.com>
 <20220105005720.zdtgwenqwqmuyxvi@box.shutemov.name>
 <4dc7d5e6-5b35-31ae-b5e9-7c77ed42383b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dc7d5e6-5b35-31ae-b5e9-7c77ed42383b@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 05:38:25PM -0800, Dave Hansen wrote:
> On 1/4/22 4:57 PM, Kirill A. Shutemov wrote:
> >> My read of STRICT_MM_TYPECHECKS was that "typedef unsigned long
> >> pgprot_t" produces better code, but "typedef struct { unsigned long
> >> pgprot; } pgprot_t;" produces better type checking.
> > Apart from pgprot_t, __pgprot() and pgrot_val() helpers are defined
> > differently depending on STRICT_MM_TYPECHECKS.
> > 
> >> I just compiled these patches on sparc with no issues.
> > Hm. I can't see how
> > 
> > #define pgprot_val(x)	(x)
> > 
> > can work to access value for the pgprot_t defined as a struct.
> 
> Oh, I must just be compiling with the strict type checks on all the
> time.  I do really wonder if these are useful these days or if the hacks
> were for ancient compilers.
> 
> In any case, this would be pretty easy to fix by just removing the
> !STRICT_MM_TYPECHECKS pgprot_val() and defning the STRICT_MM_TYPECHECKS
> universally.

There's comment in 32-bit Sparc as a reason for STRICT_MM_TYPECHECKS not
to be used:

/* passing structs on the Sparc slow us down tremendously... */

The comment came from before git times, so I don't know if it still has a
merit or newer compilers can deal with it better.

bloat-o-meter shows not trivial difference:

Total: Before=5342261, After=5344025, chg +0.03%

but I'm not sure if it translates into performance loss.

David, does the comment still relevant?

-- 
 Kirill A. Shutemov
