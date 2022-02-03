Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5F94A88C6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 17:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352322AbiBCQmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 11:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242144AbiBCQmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 11:42:21 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A450FC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 08:42:21 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id bu18so7203839lfb.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 08:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TEnKaGyVyQkOFv86BGFdUaYcL2GFvNnW7hN2KEruDew=;
        b=grC3bvFeikR1GGnP0dho4BggbbkOZfYnaJt9+zAyZ/RQfW5VdsQiT2016hIQ5G3AGM
         xrCitEfI+ZJzunjQEy4F3zQMFO1N9lzFCrqSa09iYw1MMpHnKkbtdv9ETOB6F7g09gQ7
         GnrwFpbLlsfL2+UcEc77VlodWZb9w25lUZVXRp24gsP29H6hDkqa5B+ggx2ulaxcBHpv
         Lkty28j1qW1cMmI3mjSzAhGAFJBmzYk2XNHg+rplQO6m0Sup/5MKKTMlO7kxNHu8fqme
         0WcGB9KyElPu3py9GEe4xvgBuno20U+p6wLldVU5rntCIeOtXJQ0ktz0YyacSQuaVnr/
         /mKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TEnKaGyVyQkOFv86BGFdUaYcL2GFvNnW7hN2KEruDew=;
        b=n99UWFHkCo76O8xfQb2MHkpaY9XttDeEyHXEMQ/QA8LSaMStFJIeO72jEW5XQfdpVv
         xAM10bo0W8WmMNTpj01vEThfi7qJ4TB85HegG1yCNiWi7Mo9wSxJS9ZqcQzWXpw+VnGs
         HLj+Ch5RsT3aeZOtyYG2Ybq9PkyKitCGamFqRolvbN34O1TLLjgKpqG+I5y9wdUDQ4p9
         B/+sIauJeKLpXJioFLhNE28/zAcw3IyynhPOwPQl5NMJeojiybL7a8i+02AqbE4DAmmb
         YQ/o5nH3pDhuqhj0SHBTS/ALgUkqNa12ivupO8Ya40M3Kbhvn1z8/4jHNKXnjw+Zmd8y
         1ovw==
X-Gm-Message-State: AOAM532bTEb3BYiA7AdcbSAc/sKvr8/2aUg/DkdzXZH0N4yR+eHenNpN
        KTh/qdRzDaj08WPLid1E5aPGmHXGodvR0w==
X-Google-Smtp-Source: ABdhPJyy5zhjDGSvRFjn3HcQt2P+REVFZs06AjWLTFp18nPFmUzcz5iOTA79p3ULKaE5b0n83SUaew==
X-Received: by 2002:a05:6512:21b:: with SMTP id a27mr25929750lfo.302.1643906539761;
        Thu, 03 Feb 2022 08:42:19 -0800 (PST)
Received: from localhost ([146.66.199.134])
        by smtp.gmail.com with ESMTPSA id y22sm3334155lji.129.2022.02.03.08.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 08:42:19 -0800 (PST)
Date:   Thu, 3 Feb 2022 19:42:18 +0300
From:   Azat Khuzhin <a3at.mail@gmail.com>
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Chris Kennelly <ckennelly@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Song Liu <songliubraving@fb.com>,
        David Rientjes <rientjes@google.com>,
        Ian Rogers <irogers@google.com>,
        Hugh Dickins <hughd@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Fangrui Song <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] fs/binfmt_elf: use ELF_ET_DYN_BASE for PIE (ET_DYN with
 INTERP) binaries
Message-ID: <20220203164218.six6nfyzsi2wnoay@carbon.azat>
References: <20220131201716.5198-1-a3at.mail@gmail.com>
 <CAMe9rOqoPy6jsWrodnc41M4+b2onwkfbfr=pZ9qRWzOU2Uisgg@mail.gmail.com>
 <20220201061832.yatgwglxvi7ho4yr@carbon.azat>
 <CAMe9rOptn2vpY90yY3HuGmmMdj4Hpaba2PRhp4d033XBDgL_5w@mail.gmail.com>
 <20220201132807.m7xtogotjlg54pzl@carbon.azat>
 <CAMe9rOpkHm7juB6f_z+osG28dGxe=4SSVN+8SHsxatVnwGQ5xA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMe9rOpkHm7juB6f_z+osG28dGxe=4SSVN+8SHsxatVnwGQ5xA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 05:39:57AM -0800, H.J. Lu wrote:
> On Tue, Feb 1, 2022 at 5:28 AM Azat Khuzhin <a3at.mail@gmail.com> wrote:
> >
> > On Tue, Feb 01, 2022 at 05:15:38AM -0800, H.J. Lu wrote:
> > > On Mon, Jan 31, 2022 at 10:18 PM Azat Khuzhin <a3at.mail@gmail.com> wrote:
> > > >
> > > > On Mon, Jan 31, 2022 at 01:30:38PM -0800, H.J. Lu wrote:
> > > > > On Mon, Jan 31, 2022 at 12:17 PM Azat Khuzhin <a3at.mail@gmail.com> wrote:
> > > > > >
> > > > > > Since 9630f0d60fec ELF_ET_DYN_BASE is not used as a load_bias anymore
> > > > > > and this breaks PIE binaries, since after this change data segment
> > > > > > became too nearby the stack:
> > > > > >
> > > > > > Before 9630f0d60fec:
> > > > > >
> > > > > >     $ strace -febrk /tmp/test-stack |& head
> > > > > >     brk(NULL)                               = 0x555555559000
> > > > > >     $ /tmp/test-stack
> > > > > >     bottom_of_stack = 0x7fffffffc5c0
> > > > > >     recursion depth: 1 (stack diff: 32)
> > > > > >     ...
> > > > > >     recursion depth: 7690 (stack diff: 8365664)
> > > > > >     Segmentation fault (core dumped)
> > > > > >
> > > > > > After 9630f0d60fec:
> > > > > >
> > > > > >     $ strace -ebrk /tmp/test-stack  |& head
> > > > > >     brk(NULL)                               = 0x7ffff7fff000
> > > > > >
> > > > > >     $ /tmp/test-stack
> > > > > >     bottom_of_stack = 0x7fffffffc640
> > > > > >     recursion depth: 1 (stack diff: 32)
> > > > > >     ...
> > > > > >     recursion depth: 146 (stack diff: 157792)
> > > > > >     Segmentation fault (core dumped)
> > > > > >
> > > > > > Found this during compiling with clang, that started to randomly
> > > > > > SIGSEGV when it eats some heap.
> > > > >
> > > > > How do I reproduce it on x86-64?
> > > >
> > > > It fails for me for pretty big C++ unit, so I don't have a simple
> > > > reproducer with clang, but the attached reproducer below should show the
> > > > problem.
> > >
> > > The reproducer doesn't fail for me under 5.17-rc2 on Fedora 35/x86-64
> > > with 32GB RAM.  Did you turn off PF_RANDOMIZE?
> >
> > Oh, yep, forgot to mention that I have kernel.randomize_va_space=0.
> 
> PIE with interpreter and PIE with alignment > ELF_MIN_ALIGN
> should always be loaded from ELF_ET_DYN_BASE.  Otherwise,
> either PIE is loaded at an address which is too low or isn't properly
> aligned.

So, this is what this patch does, right?
Any news on this patch?
