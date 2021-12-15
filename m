Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2791A47669B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 00:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbhLOXhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 18:37:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25626 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232096AbhLOXhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 18:37:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639611460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=04jNZgp70CbIHqw1bBu+3Ht66p4hbqCn8siNHvk+/hE=;
        b=CW3FNdGzrpNpaO+V10ARXMUjRfCpVeQZp+BzrwnRDU2ZBWSyrqUW/36WxcuLfFhl5ZEK7d
        iTkG69mDqZ1xtkN2WBfZmJiYJLX90yH94+KpAmvspfyHOUPf+CY3L3/Q9KvgTVmvRBEkvq
        36BFbHbeVFwsuR8ibZywRtbQC0Nl6zw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-672-qPmgeB_5Mm-P-v2lI7ZEsQ-1; Wed, 15 Dec 2021 18:37:38 -0500
X-MC-Unique: qPmgeB_5Mm-P-v2lI7ZEsQ-1
Received: by mail-qk1-f198.google.com with SMTP id v13-20020a05620a440d00b00468380f4407so20094476qkp.17
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 15:37:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=04jNZgp70CbIHqw1bBu+3Ht66p4hbqCn8siNHvk+/hE=;
        b=taV9yC9BnhDbT5+GAqDS8c9vU1t21mg+qDrCQzag2O0bDpclRRILS6n5NUl53Gk6WI
         RA549ZtAW4SeS+z1t3+sawOz6T9mA9wKtqW4aBeXsC66reS0bCSXzgq4FpV+JAEmSdzL
         1NySJZ3D7Hn9IqvLIwXTEevpODpeaDx3yplhP2Rub8J7P5jKZyWv/R0wn682im4BbzwA
         Mfse4z0CmRLyKLbwZvptYV7Fdb4XD4PjsRffSIhcOAfGH/BjN9ow0NdovsX7GZqvbk93
         3uLr7//S95UC3JpCiGYzIzUAD89jIpOC0xyi68SZVC7ktIVojRVl6BPE/vM/ZCr7YKUk
         rBIA==
X-Gm-Message-State: AOAM533uQaq5vSXF66/caBWhqBeEL64pmH9+XOHiUAXhL2gqnQwilg0J
        wSdWa3r2KHAN4pO1VMiS7hfMOgFG+hOPfn8e3i2S4mXscoMlqUni2B7np4hKBqVIsToKmz0NGuO
        4ZBDWICVoN+NolK43DCkB6+sw
X-Received: by 2002:ac8:5dcf:: with SMTP id e15mr14919324qtx.567.1639611458196;
        Wed, 15 Dec 2021 15:37:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwZL8H5FA6Hvt7iakAB0/gkXK1Cmbk4tA+RaFPRzxv3sEtNfh6C0Z8mN1VHFaEIgUgaDTWIhQ==
X-Received: by 2002:ac8:5dcf:: with SMTP id e15mr14919308qtx.567.1639611457976;
        Wed, 15 Dec 2021 15:37:37 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id a3sm2736969qtx.59.2021.12.15.15.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 15:37:37 -0800 (PST)
Date:   Wed, 15 Dec 2021 15:37:32 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, knsathya@kernel.org, pbonzini@redhat.com,
        sdeep@vmware.com, seanjc@google.com, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/26] x86/tdx: Extend the cc_platform_has() API to
 support TDX guests
Message-ID: <20211215233732.vwbctymrgt3esa5w@treble>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-3-kirill.shutemov@linux.intel.com>
 <20211215231904.rpakxlrp64zmxhhg@treble>
 <20211215233517.4cpiqqvlvxgd3qek@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211215233517.4cpiqqvlvxgd3qek@black.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 02:35:17AM +0300, Kirill A. Shutemov wrote:
> On Wed, Dec 15, 2021 at 03:19:04PM -0800, Josh Poimboeuf wrote:
> > On Tue, Dec 14, 2021 at 06:02:40PM +0300, Kirill A. Shutemov wrote:
> > > --- a/arch/x86/kernel/Makefile
> > > +++ b/arch/x86/kernel/Makefile
> > > @@ -22,6 +22,7 @@ CFLAGS_REMOVE_early_printk.o = -pg
> > >  CFLAGS_REMOVE_head64.o = -pg
> > >  CFLAGS_REMOVE_sev.o = -pg
> > >  CFLAGS_REMOVE_cc_platform.o = -pg
> > > +CFLAGS_REMOVE_tdx.o = -pg
> > >  endif
> > >  
> > >  KASAN_SANITIZE_head$(BITS).o				:= n
> > > @@ -31,6 +32,7 @@ KASAN_SANITIZE_stacktrace.o				:= n
> > >  KASAN_SANITIZE_paravirt.o				:= n
> > >  KASAN_SANITIZE_sev.o					:= n
> > >  KASAN_SANITIZE_cc_platform.o				:= n
> > > +KASAN_SANITIZE_tdx.o					:= n
> > >  
> > >  # With some compiler versions the generated code results in boot hangs, caused
> > >  # by several compilation units. To be safe, disable all instrumentation.
> > > @@ -50,6 +52,7 @@ KCOV_INSTRUMENT		:= n
> > >  
> > >  CFLAGS_head$(BITS).o	+= -fno-stack-protector
> > >  CFLAGS_cc_platform.o	+= -fno-stack-protector
> > > +CFLAGS_tdx.o		+= -fno-stack-protector
> > >  
> > >  CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
> > 
> > Don't these Makefile changes belong in patch 1, which adds tdx.c?
> 
> Removing of the instrumentation is required because is_tdx_guest() is
> called from cc_platform_has().
> 
> Commit message tries to communicate this:
> 
> 	Since is_tdx_guest() function (through cc_platform_has() API) is used in
> 	the early boot code, disable the instrumentation flags and function
> 	tracer. This is similar to AMD SEV and cc_platform.c.

Ah, that's what I get for skimming the patch description.

-- 
Josh

