Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DEF4A7CE6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 01:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348553AbiBCAcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 19:32:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48984 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240845AbiBCAcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 19:32:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643848335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zUdnXofhKruqRwtlFGwryx43vYxPzya/LNjocML+0+4=;
        b=a3dZ1XBCf0Ee3Hq3PADlfCF/IHX6rsetN1Kil6uLvEeRKSFliF7/By9hgLdk0ZsTkiGy37
        I1KQnMGfGynKshGczNY7atTKNvC/DjLKVAJ9x3cmcuWMvfeN4+BZs0SkW5THbqsdTZm4/f
        30/1cGWgxns5sUYNWwZ2rhcc9utbEhQ=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-490-hxJaVCutMQKPdmJkqdlnDg-1; Wed, 02 Feb 2022 19:32:14 -0500
X-MC-Unique: hxJaVCutMQKPdmJkqdlnDg-1
Received: by mail-oi1-f198.google.com with SMTP id bf12-20020a056808190c00b002cf68d61ccfso519174oib.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 16:32:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zUdnXofhKruqRwtlFGwryx43vYxPzya/LNjocML+0+4=;
        b=z6hQec2tBduTNDOqYVjONDMQVvAW1spYZCWyxmhr9ZFlw7n6TdgZgW7sIY3l2XY1LA
         VaHV3K8cBQ1eKgMm34pNFgfmi+OKKaSld/ngGyk+pqa8lS2QqDFpTXfva/wXggOlrJcn
         +tq8xoKo4VnQOhRDIubpyOVoG6TUujwdhklnhF77rvNnSAMXC2JZtnBplWtycC1Gj8dN
         3IGoU6rdQRdRFlMTFapD6YpylsPibG5HptC/TIyYTYGH0Xh+g56phe30DllIOPku+T/A
         zPcpq4MN0miFRkdCI9eaTRAFQXPB8IEOi6bw73g13Bm1KPVMcfo65GuWJA6hAo2r3GX9
         OiMA==
X-Gm-Message-State: AOAM530sWY+QxpgjZk8t0BVJD4rwjuB13UMBmmtKI0MPgQwskQDuEjhZ
        31fA6TGq0tjyhoLlID22LSgLlZw01LcW4ggBqLH78cCCH9aI5h60m0QpOVwttpHpYS8DwTWzB3f
        lJOmdD5GOvsWHzQ8EG6sCO0y8
X-Received: by 2002:a9d:4c0f:: with SMTP id l15mr17825678otf.104.1643848333778;
        Wed, 02 Feb 2022 16:32:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJydyjQmPX/pQcaicMIoXeG/UE0kQrS4V8fjExNsAsiXRxSdFmnfZUj9t8iLE/CCHgTkimQZPQ==
X-Received: by 2002:a9d:4c0f:: with SMTP id l15mr17825658otf.104.1643848333510;
        Wed, 02 Feb 2022 16:32:13 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id f21sm15999172otq.4.2022.02.02.16.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 16:32:12 -0800 (PST)
Date:   Wed, 2 Feb 2022 16:32:09 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, dave.hansen@intel.com, luto@kernel.org,
        peterz@infradead.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        david@redhat.com, hpa@zytor.com, jgross@suse.com,
        jmattson@google.com, joro@8bytes.org, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 01/29] x86/tdx: Detect running as a TDX guest in early
 boot
Message-ID: <20220203003209.bi6i4llc4jeouuh6@treble>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-2-kirill.shutemov@linux.intel.com>
 <87fsp2z8p8.ffs@tglx>
 <20220201231459.2doc4iaibmuua4qk@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220201231459.2doc4iaibmuua4qk@black.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 02:14:59AM +0300, Kirill A. Shutemov wrote:
> On Tue, Feb 01, 2022 at 08:29:55PM +0100, Thomas Gleixner wrote:
> > Kirill,
> > 
> > On Mon, Jan 24 2022 at 18:01, Kirill A. Shutemov wrote:
> > 
> > Just a nitpick...
> > 
> > > +static bool tdx_guest_detected __ro_after_init;
> > > +
> > > +bool is_tdx_guest(void)
> > > +{
> > > +	return tdx_guest_detected;
> > > +}
> > > +
> > > +void __init tdx_early_init(void)
> > > +{
> > > +	u32 eax, sig[3];
> > > +
> > > +	cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax, &sig[0], &sig[2],  &sig[1]);
> > > +
> > > +	if (memcmp(TDX_IDENT, sig, 12))
> > > +		return;
> > > +
> > > +	tdx_guest_detected = true;
> > > +
> > > +	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
> > 
> > So with that we have two ways to detect a TDX guest:
> > 
> >    - tdx_guest_detected
> > 
> >    - X86_FEATURE_TDX_GUEST
> > 
> > Shouldn't X86_FEATURE_TDX_GUEST be good enough?
> 
> Right. We have only 3 callers of is_tdx_guest() in cc_platform.c
> I will replace them with cpu_feature_enabled(X86_FEATURE_TDX_GUEST).

I had the same review comment before.  I was told that cc_platform_has()
was called before caps have been set up properly, so caps can't be
relied upon this early.

I'm not really convinced that's true.  Yes, early_identify_cpu() --
which runs after tdx_early_init() -- clears all boot_cpu_data's
capability bits to zero [*].

But shortly after that, early_identify_cpu() restores any "forced" caps
with a call to get_cpu_cap() -> apply_forced_caps().

So as far as I can tell, while it's subtle, it should work.  However, it
should be tested carefully ;-)


[ *] The memset() of boot_cpu_data seems unnecessary since it should
     already be cleared by the compiler when it gets placed in the
     .data..read_mostly section.

-- 
Josh

