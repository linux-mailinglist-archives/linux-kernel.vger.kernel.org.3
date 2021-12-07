Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA12446B266
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 06:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbhLGFfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 00:35:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:26499 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232346AbhLGFfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 00:35:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638855110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e4ghYP9B13gGvmZuLKDuOchy2naysfKvbuf3lUvYkHc=;
        b=ILiCplrXUFLPc9DWwvemnd0a7H8UajIsai+WDTBPSFqVOugb7C9EGBpKD6/g293lrKu3db
        0+AS4lCMlDed30cFg8udqjK6CY2qt7tOggyaYKTypCVVaMHk3kWEdgS06mbFkVF2vegMZI
        RNXhAIDla1xuLJWGGXx04X13+BUA4hM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-357-qGVdLM59PaexWRcmhI7TSA-1; Tue, 07 Dec 2021 00:31:49 -0500
X-MC-Unique: qGVdLM59PaexWRcmhI7TSA-1
Received: by mail-qv1-f70.google.com with SMTP id e14-20020a0562140d8e00b003bace92a1feso15584282qve.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 21:31:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e4ghYP9B13gGvmZuLKDuOchy2naysfKvbuf3lUvYkHc=;
        b=n6P97t0ZaKGzWB4fuATKtUMhZs031v7tsspqBsfTTZ5v7ajCzlMtaZId3iCnmFrVF6
         kRUGllj1ckJ+t8C0MHaFw+uJt4euh9Vreoj2zW8IKiwPcYwNc4+Yq2o6yx3dbKU6RPKp
         RBzBtz+wGEDTPp9rTRDTmeGghdneRWjHNvggRzQEQk1rlwG1qe0xg9zDfwr6kAVtItoY
         zlbs+0g2/oFzSvQ2ECZm0rAIQ/420DwbffCdl5IOgBqMOMdTyY1vUcc/hk7AJqRlW+Sa
         ZrlT39maAWzCfXehBr+LkO33VmAftif7qUPqqdB3U7NgsIzMyYJyRvN/j1vQqKDolp6H
         VHMA==
X-Gm-Message-State: AOAM532d+LnMPOYOz6uap6uAK0i99QyefTSondYOq7/Hj2GI5ZqaCmOa
        GEqAyxQX9BuIJ71e9EJ5eOPYUbUWSLqOCGwIV0frKYhR/6DdiHeAKW4UjiuY0CnCqnETMQ6EToP
        C6SUXo4OlrJ7mye7WVX9OpGME
X-Received: by 2002:ac8:5b51:: with SMTP id n17mr19545784qtw.182.1638855108534;
        Mon, 06 Dec 2021 21:31:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz454uO8EitNs/c6PtV9eniUKNKiTCgR5+N8W4WMPq1f0ryP+2pFiwPH4C3lFPQ4hkn9zJMiQ==
X-Received: by 2002:ac8:5b51:: with SMTP id n17mr19545750qtw.182.1638855108304;
        Mon, 06 Dec 2021 21:31:48 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id s12sm8814877qtk.61.2021.12.06.21.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 21:31:47 -0800 (PST)
Date:   Mon, 6 Dec 2021 21:31:42 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        linux-hardening@vger.kernel.org, X86 ML <x86@kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Tony Luck <tony.luck@intel.com>,
        Bruce Schlobohm <bruce.schlobohm@intel.com>,
        Jessica Yu <jeyu@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        live-patching@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v8 07/14] kallsyms: Hide layout
Message-ID: <20211207053142.d4xvkqs57zob2v2i@treble>
References: <20211202223214.72888-1-alexandr.lobakin@intel.com>
 <20211202223214.72888-8-alexandr.lobakin@intel.com>
 <Yanqz7o4IH5MkDp8@hirez.programming.kicks-ass.net>
 <CAMj1kXFLJcfUqEoz0NAb49=XJG=5LAwEPSwCQ-y7sN31C1U6AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXFLJcfUqEoz0NAb49=XJG=5LAwEPSwCQ-y7sN31C1U6AQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 11:03:35AM +0100, Ard Biesheuvel wrote:
> On Fri, 3 Dec 2021 at 11:01, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Dec 02, 2021 at 11:32:07PM +0100, Alexander Lobakin wrote:
> > > From: Kristen Carlson Accardi <kristen@linux.intel.com>
> > >
> > > This patch makes /proc/kallsyms display in a random order, rather
> > > than sorted by address in order to hide the newly randomized address
> > > layout.
> >
> > Is there a reason to not always do this? That is, why are we keeping two
> > copies of this code around? Less code is more better etc..
> 
> +1.
> 
> IIRC I made the exact same point when this patch was sent out by
> Kristen a while ago.

Yes.  Alexander, I'd recommend going back to the review comments from
Kristen's last posting, they may have been missed.

-- 
Josh

