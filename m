Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E533746614C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 11:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354862AbhLBKTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 05:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241111AbhLBKTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 05:19:30 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75288C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 02:16:08 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso1874083wmr.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 02:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=dvo4KVBG0Lx2iX6zR/VCV2kL5rEaU3wC7t8V2k80olI=;
        b=nJiPFMW95wKn+lLyNIbdyV0kzUALgFXwHNktAjmi5lyAE4mWJaIvMCBE2GEaqNIW1t
         QcNaptb0ibXK/CnaBjgx7/Ix9I93ouNXn/eYEOnWwzLrldYiI2NfHaNjAQTtwwBQ1oTs
         43Br/8/GjYexyD/bD5G3lb7o9GL8NZ6s2ongOX3pPgmxzKosorTHlhuBXsWCBQ/29Jq3
         99um6aUQser1CjL5t+mhY3yn5Ohz+mf7ILcxnYL/12bbVBJ2mcj4IEsngEeseSlSDirr
         IeqHU4gPQbZb0bv3vYDx9PYqTDAsKqI5GyMd8xlVLHIFNSXePUoP/gOTlVtkLpjpGWto
         XqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dvo4KVBG0Lx2iX6zR/VCV2kL5rEaU3wC7t8V2k80olI=;
        b=rFhCVCOW4TB+XgY3NpEne5fBFHL9lO8f9sOPgr1MvHZXZOA3m+tgnwRDVqyL7sshiC
         OVhiiLyG4ane5dwqdiaCuEyEkjOPt5oabq5K5MbcYkUgToUUsH0mfqv+TH07rjzN7Les
         jVIohDzVgN0yyetbC89vgNfRFDfBmha+qoMhfiC5I9dfeyHkmnNz2Aidc0UaZ7kxcJcA
         UrL+OjaIcSJoVHYK1au0OvtniYb1vuB2WHkM7wtrH6KozHlVGGjLbpakUUzz0jJOdsGL
         Yh4tiosbEaZ3Udwn8jQQicaSgpOJef//6YknkLiFGtXTRRK6EFB1cDZMOAaFOp6Ol1GA
         YTCA==
X-Gm-Message-State: AOAM533Eo0gtg7sHUVMVCHAEo2WYeeF4NwI6Ix8v2AKSUM+3VFe0GoLt
        s2iW8koNPON8rL9AnHzyI87xvQ==
X-Google-Smtp-Source: ABdhPJz4n47DOmobBdHwetvrGEaEhLW0CXYatFsUwhbNPwmG2nRlsMqF8YKokqeHziiPkR4XjFTv/Q==
X-Received: by 2002:a1c:770e:: with SMTP id t14mr5077846wmi.173.1638440166839;
        Thu, 02 Dec 2021 02:16:06 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:ddd6:f3c9:b2f0:82f3])
        by smtp.gmail.com with ESMTPSA id m20sm1850035wmq.11.2021.12.02.02.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 02:16:06 -0800 (PST)
Date:   Thu, 2 Dec 2021 11:15:59 +0100
From:   Marco Elver <elver@google.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        joey.gouly@arm.com
Subject: Re: [PATCH v2] arm64: Enable KCSAN
Message-ID: <Yaic31SbYFJ4zAl0@elver.google.com>
References: <20211129145732.27000-1-wangkefeng.wang@huawei.com>
 <YadiUPpJ0gADbiHQ@FVFF77S0Q05N>
 <811af0bc-0c99-37f6-a39a-095418b10661@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <811af0bc-0c99-37f6-a39a-095418b10661@huawei.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 09:35AM +0800, Kefeng Wang wrote:
> 
> On 2021/12/1 19:53, Mark Rutland wrote:
> > Hi Kefeng,
> > 
> > On Mon, Nov 29, 2021 at 10:57:32PM +0800, Kefeng Wang wrote:
> > > This patch enables KCSAN for arm64, with updates to build rules
> > > to not use KCSAN for several incompatible compilation units.
> > > 
> > > Resent GCC version(at least GCC10) made outline-atomics as the
> > > default option(unlike Clang), which will cause linker errors
> > > for kernel/kcsan/core.o.
> > > 
> > > Disables the out-of-line atomics by no-outline-atomics to fix
> > > the linker errors.
> > > 
> > > Tested selftest and kcsan_test(built with GCC11 and Clang 13),
> > > and all passed.
> > Nice!
> > 
> > I think there are a few additional bits and pieces we'll need:
> > 
> > * Prior to clang 12.0.0, KCSAN would produce warnings with BTI, as I found in:
> > 
> >    https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?h=arm64/kcsan&id=2d67c39ae4f619ca94d9790e09186e77922fa826
> > 
> >    Since BTI is in defconfig, I think arm64's Kconfig should require a minimum
> >    of clang 12.0.0 to enable KCSAN.
> 
> I don't have different clang version to test,  when check KCSAN,
> 
> commit eb32f9f990d9 ("kcsan: Improve some Kconfig comments") saids,
> 
> 
>     The compiler instruments plain compound read-write operations
>     differently (++, --, +=, -=, |=, &=, etc.), which allows KCSAN to
>     distinguish them from other plain accesses. This is currently
>     supported by Clang 12 or later.
> 
> Should we add a  "depends on CLANG_VERSION >= 120000"

KCSAN works just fine with Clang 11. Clang 12 merely improves some
instrumentation, which is what this comment is about.

What Mark meant is that there's a specific issue with arm64 and BTI that
is fixed by Clang 12. Therefore, arm64's Kconfig will have to do

	select HAVE_ARCH_KCSAN if CC_IS_GCC || CLANG_VERSION >= 120000

> > 
> > * In the past clang did not have an attribute to suppress tsan instrumenation
> >    and would instrument noinstr regions. I'm not sure when clang gained the
> >    relevant attribute to supress this, but we will need to depend on this
> >    existing, either based on the clang version or with a test for the attribute.
> > 
> >    (If we're lucky, clang 12.0.0 is sufficient, and we solve BTI and this in one
> >    go).
> > 
> >    I *think* GCC always had an attribute, but I'm not certain.
> > 
> >    Marco, is there an existing dependency somewhere for this to work on x86? I
> >    thought there was an objtool pass to NOP this out, but I couldn't find it in
> >    mainline. If x86 is implicitly depending on a sufficiently recent version of
> >    clang, we add something to the common KCSAN Kconfig for ARCH_WANTS_NO_INSTR?
> > 
> > * There are some latent issues with some code (e.g. alternatives, patching, insn)
> >    code being instrumentable even though this is unsound, and depending on
> >    compiler choices this can happen to be fine or can result in boot-time
> >    failures (I saw lockups when I started trying to add KCSAN for arm64).
> > 
> >    While this isn't just a KCSAN problem, fixing that requires some fairly
> >    significant rework to a bunch of code, and until that's done we're on very
> >    shaky ground. So I'd like to make KCSAN depend on EXPERT for now.
> > 
> >    I had an initial stab at fixing some of that, e.g.
> > 
> >    https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/patching/rework
> >    Joey has started looking into this too.
> 
> Thanks for your information,  I don't know about this. As your say, we could
> add a depend on EXPERT
> 
> for now and more explanation into changlog.

So what I gather arm64's final select line may look like:

	select HAVE_ARCH_KCSAN if EXPERT && (CC_IS_GCC || CLANG_VERSION >= 120000)

> > 
> > * When I last tested, for simple boots I would get frequent KCSAN splats for a
> >    few common issues, and those drowned out all other reports.
> > 
> >    One case was manipulation of thread_info::flags, which Thomas Gleixner has
> >    queued some fixes at:
> > 
> >    https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=core/entry
> >    There were some other common failures, e.g. accesses to task_struct::on_cpu,
> >    and I hadn't had the chance to investigate/fix those, beyond a (likely
> >    unsound) hack:
> > 
> >    https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?h=arm64/kcsan&id=4fe9d6c2ef85257d80291086e4514eaaebd3504e
> > 
> >    It would be good if we could identify the most frequent problems (e.g. those
> >    that will occur when just booting) before we enable this generally, to avoid
> >    everyone racing to report/fix those as soon as we enable the feature.
> > 
> >    When you tested, did KCSAN flag anything beyond the selftests?
> 
> Yes, there are some KCSAN reports, but this is not only exist on arm64, I
> saw  owner->on_cpu warning
> 
> on x86 too, eg, we also hack to disable it via data_race.
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 7 PID: 2530 Comm: syz-executor.11 Not tainted 5.10.0+ #113
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.104/01/2014
> ==================================================================
> BUG: KCSAN: data-race in rwsem_spin_on_owner+0xf4/0x180
> 
> race at unknown origin, with read to 0xffff9767d3becfac of 4 bytes by task 18119 on cpu 0:
>  rwsem_spin_on_owner+0xf4/0x180
>  rwsem_optimistic_spin+0x48/0x480
>  rwsem_down_read_slowpath+0x4a0/0x670
>  down_read+0x69/0x190
>  process_vm_rw+0x41e/0x840
>  __x64_sys_process_vm_writev+0x76/0x90
>  do_syscall_64+0x37/0x50
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9

I think fixing data races is not a pre-requisite for arch-enablement.
Some are slowly being addressed (and others aren't -- syzbot has a list
of >200 data races that I try to moderate and fix some or forward those
that I think will get fixed). I expect the most frequent issues will be
the same on arm64 as they are on x86.

I actually have a "fix" for the data race in rwsem_spin_on_owner, that
also shows where the other racing access comes from... which reminds me:
https://lkml.kernel.org/r/20211202101238.33546-1-elver@google.com

Thanks,
-- Marco
