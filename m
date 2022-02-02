Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62724A7812
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 19:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346705AbiBBSiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 13:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbiBBSiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 13:38:00 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A90C061714;
        Wed,  2 Feb 2022 10:38:00 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id j23so445733edp.5;
        Wed, 02 Feb 2022 10:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+Q/41PiLBQXzmyn5VtEH2Nyw/2Ag4csRH1/mB6NORos=;
        b=ak7ORdFapMtapxfrIVLT+R0Of6b9+Tsea3svTwDFS+bot/lKFf1iWWJlZrelkA5V6S
         ufv0QsARCjb75LgFiydAIaz8hjEHV2i5Twx/wpPpjFcbv8OhX3nCxw+X2k9WxRXA4q2V
         Dbx9kODU2zGp5hVPpdtQOA0RaBNXgEGhLWRo9GzLHTECHFGJZiAMQcDCMZmdl4irvqlW
         e7kB0aoUeb1V1AgAMi9ijuoJYMo898qP0JZ+GWtyrGvCa/Z2dhPbglMoNodqtVhUOJXu
         egCmbGb3hseoysZLyQecUjGxMfVaIBsn6vh+HOs9K9vj51bbYxLBEaIq9Y8a/GrHMcuS
         HoZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+Q/41PiLBQXzmyn5VtEH2Nyw/2Ag4csRH1/mB6NORos=;
        b=Mp/d06XKEkW6elpxjiQ7MzhoCED6pSlOSwKWORSlfR2NUltLUzN6MFGokbDO2t5gTF
         FpSf/pgmCXhMSMIJB5/llkYE0P7kbCHhmb4egx/qclXtncTseJjVe9l5XpblTY2P+0aU
         qj+Z5YHASpjzW2PorRBeI+kqThJvErs3mJF0UJD87OlUxnaL6pO5LWGOG2vm1c038Rrp
         hvwC2N9SQQ9WLWQKg9V71m/pUiA8v9VDNzjwZAG2vwD2mC2pvj/xgY6d3b2NVcwACewV
         ug5n2ehFM+1xHKE+8bR+5Os8wjqyTGdpu3pyy50JFLUJ/EfcBJQgB7K5HDcUJkXweZXK
         W5WQ==
X-Gm-Message-State: AOAM530aoAo0mbqbj4GksAsU8U3J5kh6kpSXVdaHk0fpE7dZnbU8yZUC
        Hc82WidzqLHL3tqPYPeBP0U=
X-Google-Smtp-Source: ABdhPJyeTIGpdkaFxcw/oEgRxs3A0lKv/tFdjAOCRH3+xV5fxECw2BwqgD/E0CFEqYZPCp7In5cmlg==
X-Received: by 2002:aa7:c0d4:: with SMTP id j20mr31430342edp.319.1643827078924;
        Wed, 02 Feb 2022 10:37:58 -0800 (PST)
Received: from krava ([2a00:102a:400e:b6b3:b3d3:940b:f27f:5400])
        by smtp.gmail.com with ESMTPSA id lo15sm15941787ejb.28.2022.02.02.10.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 10:37:58 -0800 (PST)
Date:   Wed, 2 Feb 2022 19:37:54 +0100
From:   Jiri Olsa <olsajiri@gmail.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Nick Alcock <nick.alcock@oracle.com>, bas smit <bas@baslab.org>,
        =?utf-8?B?VG9tw6HFoQ==?= Glozar <tglozar@gmail.com>,
        Ast-x64 <Ast-x64@protonmail.com>,
        Viktor Malik <viktor.malik@gmail.com>,
        Daniel Xu <dxu@dxuuu.xyz>, Jiri Olsa <jolsa@kernel.org>,
        jeyu@kernel.org, masahiroy@kernel.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com, Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PING PATCH v7] kallsyms: new /proc/kallmodsyms with builtin
 modules
Message-ID: <YfrO2b4G/qMTHzQG@krava>
References: <20211216201919.234994-1-nick.alcock@oracle.com>
 <Yd8CDJA0dy0VaXrB@bombadil.infradead.org>
 <878rvk7uv2.fsf@esperi.org.uk>
 <Yfn145FyE3PDBEad@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yfn145FyE3PDBEad@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

adding few more folks that might interested in this

On Tue, Feb 01, 2022 at 07:09:23PM -0800, Luis Chamberlain wrote:
> CC'ing bfptrace folks for feedback.
> 
> I'm pretty reluctant to merge any of this unless we have wide community
> desire to see this. I'm not quite seeing that yet.
> 
> On Wed, Jan 12, 2022 at 04:59:45PM +0000, Nick Alcock wrote:
> > On 12 Jan 2022, Luis Chamberlain stated:
> > 
> > > On Thu, Dec 16, 2021 at 08:19:12PM +0000, Nick Alcock wrote:
> > >> /proc/kallsyms is very useful for tracers and other tools that need to
> > >> map kernel symbols to addresses.
> > >> 
> > >> It would be useful
> > >
> > > It took me digging on archives to see to *who* this is useful to.
> > > The short answer seeme to be dtrace. Can you work on getting use
> > > of this for something (I don't know, maybe kernelshark?) that does
> > > not taint the kernel? Last I checked using dtrace on linux taints the
> > > kernel.
> > 
> > It hasn't tainted the kernel for at least four years :) v1 (with a
> > kernel module) has been GPLv2 since 2017; v2 is pure-BPF and has no
> > DTrace-specific kernel modules,
> 
> I google for dtrace LInux and I end up here:
> 
> https://www.oracle.com/linux/downloads/linux-dtrace.html
> 
> It then has documentation dating back to year 2020, and I can't
> apt-get install any of these "dtrace-utils" or anything with dtrace.
> 
> How do I get running with dtrace on debian? Typically this is a flag
> it has some funky license. You metioned dtrace is GPLv2 since 2017, does
> the same apply to the pure-BPF stuff?
> 
> Note I see a bpftrace effort, can that be made to use your changes?
> At *least* I can install that on a regular distro. And it notes
> "The bpftrace language is inspired by awk and C, and predecessor tracers
> such as DTrace and SystemTap."
> 
> I see on that page it says:
> 
> Note that DTrace requires the Unbreakable Enterprise Kernel (UEK)
> release 5 or higher. 
> 
> > just using some new things we have to
> > add to the kernel, most of which seem plausibly useful to others too
> > (kallmodsyms, waitfd pro tem until pidfd supports ptracers, and CTF).
> 
> All sounds nice, but I'd like to give this all a spin, but I can't
> find anything remotely close to anything sensible to try it out.
> I don't want to run any Oracle kernel. I want to run things upstream.
> 
> > This is not a DTrace-specific feature in any case: all my submissions
> > have noted that it seems likely to be useful to anyone who wants a
> > stable reference to modules that doesn't change whenever the kernel
> > config changes, which probably means most tracers with support for
> > kernel modules which implement anything like a programming language.
> 
> Great! But I'd like things to have tools
> 
> > > Without valid upstream users I see no need to add more complexity to the
> > > kernel. And complexity added by tainting modules or not upstream modules
> > 
> > We don't need any of those any more :) Even CTF is now generated by GCC
> > (once GCC 12 is released) and deduplicated by GNU ld: the CTF patch will
> > be only a few hundred lines long once GCC 12 is out and I drop the
> > DWARF->CTF translator.
> 
> Great!
> 
> > > Without a valid non-taining user being made very clear with a value-add,
> > > I will have to ignore this.
> > 
> > I hope this gives you a reason to not ignore it! Have some links:
> > 
> > DTrace v1 (maintenance mode, fairly hefty GPL kernel module, UPL
> > userspace; fully-functional including fbt, kernel side will shrink):
> > 
> >   https://github.com/oracle/dtrace-linux-kernel v1/5.15
> >   https://github.com/oracle/dtrace-utils 1.x-branch-dev
> > 
> > DTrace v2 based on BPF, in progress, some features still missing (UPL
> > userspace and a few GPL kernel patches, including this one: needs a BPF
> > cross-compiler, which is a new GCC 12 target):
> > 
> >   https://github.com/oracle/dtrace-linux-kernel v2/5.14.9
> >   https://github.com/oracle/dtrace-utils 2.0-branch
> 
> The "The Universal Permissive License (UPL)"? Really ? Anyway it seems
> to be at least GPL compatible. I'm curios why no distro has picked up
> any of this work?
> 
> I don't see much traction based on what you have said on dtrace
> on anything other than Oracle Linux stuff, it would be nice if bpftrace
> folks were excited about your changes and we had support for that
> there.
> 
> > (I'm going to respin all of these kernel branches against 5.17-rc once
> > the merge window closes, and bring the things both kernel trees have in
> > common into sync. I'll drop you a line once that's done.)
> 
> Nice.
> 
> > Config-wise both of these need kernels with CONFIG_KALLMODSYMS,
> > CONFIG_WAITFD and CONFIG_CTF turned on, and a kernel built with a 'make
> > ctf' done after 'make', and the kernel source tree available when DTrace
> > proper is built.
> 
> Thanks for the heads up.
> 
>   Luis
