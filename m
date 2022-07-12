Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342C7570F16
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 02:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbiGLAvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 20:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiGLAve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 20:51:34 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB8225EA2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:51:34 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id r6so3443490plg.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZIiHxradpyRYFVkHEHYMXg9bXCfFv6LWZEN40HiW4gw=;
        b=NmuqzOIDXIPbnxeJIKJZ7D1X0LQMhceO9hImK61h5ksZl9HNStwLP8CbgGDK75G5hf
         usVlZbdXLc4PtKvCpWXNwMIzA4Un2ZNuqphOa95znjKkYSDcyO5p/hECMkG8ufCIsWVX
         1z3bJs24eHIGnA+8hcBgjQI+2rdQ+A/OBmPJ4NPtZ38defj1NPpk7GK1kA/x4GG/4FqT
         xv03YVXVcvFj5HjYWvI9z/Z9FFBWoTvrhA9veFG+xTC09mbNp8EA5VcESd/NDm967klY
         Tr2hmX6QVsGXM1yb9Ek5sOszIQIzrxzWwDE4WUN4JRbaEUiiw9PIv/TTwgqP2aZd8VQS
         wDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZIiHxradpyRYFVkHEHYMXg9bXCfFv6LWZEN40HiW4gw=;
        b=lb4RyHy+cRl3wctVaiJ3oMGL60JXovzQkwtJ4e1hfVc9uNyI9f8m/v1uMAnavsao1i
         mZ9nZdgnQ8iI2FR1A3rUwWJRutW42X3GF7MCdWf6EsA9+dEdmeU8XFGcR/1zMTpPO/dz
         UlvMwBLpGxvBgsa4O5fP4Mck1LAHZV94P0uHt4udGXKuT+6hmsXwtQrZPVrc1c0r6P/M
         BVRkGYB2LdChGwNeZo+seWT8ox3YF/FvTlZ3jqwWkGx6CuN3o1MK6QFe1kzvaUBpQ1Ls
         Yx9Y9fDQETCsvHAZjlLJH4ANh/eojMlM37MH0AVHbsJw5emAhpY2LUG+fNBtRQwLD/hc
         BxBA==
X-Gm-Message-State: AJIora+YqvvBYNV4xlamPuP4bzpguEbHUW7Lf/uNleKjH4xQPUZ+RfEf
        7Tgw+r5XK0DYRaSymRGXeAA9DA==
X-Google-Smtp-Source: AGRyM1uqvogoFlL80/Fy8YMtQFJlzbnLA0POR6/8bfGpezSoVCdf+NDuikCEb28kNbZDLEO5E1R/hQ==
X-Received: by 2002:a17:90b:3e8a:b0:1f0:4157:daf8 with SMTP id rj10-20020a17090b3e8a00b001f04157daf8mr1183521pjb.222.1657587093474;
        Mon, 11 Jul 2022 17:51:33 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id v2-20020a626102000000b00529a0667ff9sm5370309pfb.126.2022.07.11.17.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 17:51:33 -0700 (PDT)
Date:   Tue, 12 Jul 2022 00:51:29 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Kai Huang <kai.huang@intel.com>
Cc:     Martin Fernandez <martin.fernandez@eclypsium.com>,
        linux-kernel@vger.kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, mingo@redhat.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        daniel.gutson@eclypsium.com, hughsient@gmail.com,
        alex.bazhaniuk@eclypsium.com
Subject: Re: [PATCH v2] x86/cpuinfo: Clear X86_FEATURE_TME if TME/MKTME is
 disabled by BIOS
Message-ID: <YszFkTZ7RtXS1rd7@google.com>
References: <20220704142250.1512726-1-martin.fernandez@eclypsium.com>
 <8d2a3175be8a3aff1d3fc535dd9ab6217cfe1e66.camel@intel.com>
 <CAKgze5azQG1mnOASbpcrs9jTejdXGkXYmezz9bTKuWQoZp5EFg@mail.gmail.com>
 <YsxZKGxVUY61zPEt@google.com>
 <ba321fad38d5f96a240f1e88a11943cea16bb4dd.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba321fad38d5f96a240f1e88a11943cea16bb4dd.camel@intel.com>
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

On Tue, Jul 12, 2022, Kai Huang wrote:
> On Mon, 2022-07-11 at 17:08 +0000, Sean Christopherson wrote:
> > On Tue, Jul 05, 2022, Martin Fernandez wrote:
> > > On 7/5/22, Kai Huang <kai.huang@intel.com> wrote:
> > > > On Mon, 2022-07-04 at 11:22 -0300, Martin Fernandez wrote:
> > > > > Changelog since v1
> > > > > 
> > > > > Clear the flag not only for BSP but for every cpu in the system.
> > 
> > ...
> > 
> > > > > ---
> > > > >  arch/x86/kernel/cpu/intel.c | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > > 
> > > > > diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> > > > > index fd5dead8371c..17f23e23f911 100644
> > > > > --- a/arch/x86/kernel/cpu/intel.c
> > > > > +++ b/arch/x86/kernel/cpu/intel.c
> > > > > @@ -570,6 +570,7 @@ static void detect_tme(struct cpuinfo_x86 *c)
> > > > > 
> > > > >  	if (!TME_ACTIVATE_LOCKED(tme_activate) ||
> > > > > !TME_ACTIVATE_ENABLED(tme_activate)) {
> > > > >  		pr_info_once("x86/tme: not enabled by BIOS\n");
> > > > > +		clear_cpu_cap(c, X86_FEATURE_TME);
> > 
> > This misses the case where the TME_ACTIVATE_KEYID_BITS() is zero.  AFAICT, that's
> > allowed, i.e. won't #GP on WRMSR.  TME_ACTIVATE_KEYID_BITS() can't be non-zero if
> > TME_ACTIVATE_ENABLED() is false, but the reverse is allowed.
> 
> But this logic applies to "whether MKTME is enabled",  but not "TME is enabled",
> right?

Ah, right, duh.

> > IMO, this entire function needs to be reworked to have a cohesive strategy for
> > enumerting TME; not just enumerating to userspace, but internal to the kernel as
> > well.
> > 
> > E.g. forcing "mktme_status = MKTME_DISABLED" on an AP is nonsensical.  If an AP's
> > basic MKTME enabling doesn't align with the BSP (activate, algorithm, and keyid0
> > bypass settings match), then there's no way an AP is going to reach detect_tme().
> > Any discrepancy in encryption for keyid0 will cause the AP will read garbage on
> > wakeup, and barring a miracle, will triple fault and never call in.
> > 
> > Conversely, if basic enabling matches but something else mismatches, e.g. an AP
> > was configured with fewer keys, then forcing "mktme_status = MKTME_DISABLED" may
> > be misleading as MKTME may be fully enabled and in use for keyid0, it just won't
> > be used for keyid!=0.  But that's a moot point because as is, the kernel _never_
> > uses keyid!=0.
> > 
> > And this code is also bogus.  Just because the kernel doesn't know the encryption
> > algorithm doesn't magically turn off encryption for keyid0.  Again, mktme_status
> > confuses "memory is encrypted" with "MKTME is theoretically usable for keyid!=0".
> > 
> > 	tme_crypto_algs = TME_ACTIVATE_CRYPTO_ALGS(tme_activate);
> > 	if (!(tme_crypto_algs & TME_ACTIVATE_CRYPTO_AES_XTS_128)) {
> > 		pr_err("x86/mktme: No known encryption algorithm is supported: %#llx\n",
> > 				tme_crypto_algs);
> > 		mktme_status = MKTME_DISABLED;
> > 	}
> > 
> > The mktme_status variable seems completely pointless.  It's not used anywhere
> > except to detect that CPU0 vs. APs.
> 
> I think your above saying makes sense, but this is a different topic and should
> be in a separate patch IMHO.

Yeah, definitely need multiple patches.

> This patch basically tries to fix the issue that TME flag isn't cleared when TME
> is disabled by BIOS.  And fir this purpose, the code change in this patch looks
> reasonable to me.  Unless I am mistaken, detect_tme() will be called for all
> cpus if TME is supported in CPUID but isn't enabled by BIOS (either LOCKED or
> ENABLED bit isn't set).

But this patch doesn't handle the bypass bit, which _does_ effectively disable
TME when set.  E.g. the MKTME spec says:

 Software must inspect the Hardware Encryption Enable (bit 1) and TME Encryption
 Bypass Enable (bit 31) to determine if TME encryption is enabled.
