Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2782B5725AF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 21:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbiGLTip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 15:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiGLTi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 15:38:26 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8EEE6824
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 12:14:13 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id y141so8285615pfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 12:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xuWmcBMTjC8J3F+i1RfZo97szIRUbRwfm0F557uSCV4=;
        b=HMbuuvtt7t68C3il0oZaxQz26bo2jXB2x3BjFpSw6tEO3q/vx/WLfoQUVwrJkvQ+7y
         jpRJnAIFxsr/p25yxB7wkZC63Pgh+PxhyYOyQy67uby2pg6ynLg1CdbTRCdSP6Ckivbg
         uivfNNb7YfnpsaArUyJ5JlhsQ/J6KSxqOBObcVeFwO+O4ylCcML25WprQe4325gbw9pz
         x2QwohpkSC/1j8D+Opb1py4Yg9ub/ctoq5+lG0g8PyPKKNoDXz6QX+PUyCr7UxZS3Ks9
         koMEJ9d/Y0ykDgS/cd/+EsozOv5z3zJuZIVshr9mnCgYskglMOjaHS2OAlxHDG+ZIHJY
         XTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xuWmcBMTjC8J3F+i1RfZo97szIRUbRwfm0F557uSCV4=;
        b=AQ3c90VrrVsnD0TDaQPkX/j+zEJpyL2xE3asbvbe01M/UaTdUsYSEVe7583FJ5Q/QA
         34cZi7hxJnT0XFNnHmBMO3RIKd9JJnPcHX9myA8PFG7zle+/7roFh/Uq3rx7tcWlCy18
         kLhzwuRJaoSl71jZMIizhPXoFRSdv9oGZyL56zmI2MWpqxV17iFJxRK3XfHuoty26wd5
         lwl6ZjQjMMOfBUrbLJ0X4ZepuuaU0dDJngWhm+Lg8/VokVkcw5xNwwvFQARSrEPttRVG
         dml7cy/PHeXXsaF33ZeYNhkb/r80JCBTHrUYkd45BApO2/Tqmt3TsehgiHZpXkEZ73/H
         Ekyg==
X-Gm-Message-State: AJIora+hbRjWAOPeBjub16n4CUjWcOb4GOJC2kHPxHFjcFvtkWd/Yt3E
        HnDQl6bsXjUGar+GLYsMwomLWw==
X-Google-Smtp-Source: AGRyM1uqfBx022fz7nqU4wDIf38Fzirhb/VqazpXBUb+wbc/xRaYF8RJzThp5zfIokeXLMiwD3UkEQ==
X-Received: by 2002:a63:7204:0:b0:40c:9dc6:57f1 with SMTP id n4-20020a637204000000b0040c9dc657f1mr21841464pgc.153.1657653252638;
        Tue, 12 Jul 2022 12:14:12 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id s19-20020a656453000000b00411acdb1625sm6453536pgv.92.2022.07.12.12.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 12:14:11 -0700 (PDT)
Date:   Tue, 12 Jul 2022 19:14:08 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Martin Fernandez <martin.fernandez@eclypsium.com>
Cc:     Kai Huang <kai.huang@intel.com>, linux-kernel@vger.kernel.org,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        mingo@redhat.com, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com
Subject: Re: [PATCH v2] x86/cpuinfo: Clear X86_FEATURE_TME if TME/MKTME is
 disabled by BIOS
Message-ID: <Ys3IACV0fuK/vwCq@google.com>
References: <20220704142250.1512726-1-martin.fernandez@eclypsium.com>
 <8d2a3175be8a3aff1d3fc535dd9ab6217cfe1e66.camel@intel.com>
 <CAKgze5azQG1mnOASbpcrs9jTejdXGkXYmezz9bTKuWQoZp5EFg@mail.gmail.com>
 <YsxZKGxVUY61zPEt@google.com>
 <ba321fad38d5f96a240f1e88a11943cea16bb4dd.camel@intel.com>
 <YszFkTZ7RtXS1rd7@google.com>
 <07ff13d590cf290a14232fb113ff4183a6fa352d.camel@intel.com>
 <CAKgze5bzeakLTMEADKiweL3fnrcVzd6K9oJzo7wWDxuriUfgvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgze5bzeakLTMEADKiweL3fnrcVzd6K9oJzo7wWDxuriUfgvA@mail.gmail.com>
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

On Tue, Jul 12, 2022, Martin Fernandez wrote:
> On 7/11/22, Kai Huang <kai.huang@intel.com> wrote:
> >
> >>
> >> > This patch basically tries to fix the issue that TME flag isn't cleared
> >> > when TME
> >> > is disabled by BIOS.  And fir this purpose, the code change in this
> >> > patch looks
> >> > reasonable to me.  Unless I am mistaken, detect_tme() will be called for
> >> > all
> >> > cpus if TME is supported in CPUID but isn't enabled by BIOS (either
> >> > LOCKED or
> >> > ENABLED bit isn't set).
> >>
> >> But this patch doesn't handle the bypass bit, which _does_ effectively
> >> disable
> >> TME when set.  E.g. the MKTME spec says:
> >>
> >>  Software must inspect the Hardware Encryption Enable (bit 1) and TME
> >> Encryption
> >>  Bypass Enable (bit 31) to determine if TME encryption is enabled.
> >
> > Yeah so my original reply said:
> >
> > "But perhaps it's arguable whether we can also clear TME flag in this
> > case."
> >
> > And I only gave my Acked-by.
> >
> > It completely depends on the purpose of this patch, or what does this patch
> > claim to do.  If it only claims to clear TME bit if BIOS doesn't enable it,
> > then
> > looks fine to me.  If it wants to achieve "clear TME feature flag if
> > encryption
> > isn't active", then yes you are right.
> >
> > But as I said perhaps "whether we should clear TME flag when bypass is
> > enabled"
> > is arguable.  After all, what does TME flag in /proc/cpuinfo imply?
> >
> 
> What we want with this patch is to check whether some kind of memory
> encryption is active. Right now we are doing it by checking the "tme
> active in BIOS" log, so we are not checking the bypass.
> 
> Can you change this bypass bit at runtime? ie, does it make sense to
> check it only once at boot time?

No, the MSR has write-once behavior.  The LOCK bit is set on the first succesful
WRMSR (or amusingly, on the first SMI).

> If no, then maybe it's ok to check that bit in detect_tme and consider
> it for cpuinfo,
> 
> If it can change, then probably it's ok to leave this patch as is, and
> for our use case maybe we can add a sysfs file that reads that msr.
