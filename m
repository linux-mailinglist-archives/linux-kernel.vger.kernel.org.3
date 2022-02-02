Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771A44A6A70
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 04:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243961AbiBBDJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 22:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiBBDJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 22:09:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F828C061714;
        Tue,  1 Feb 2022 19:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EBTvOJMgshLVKwRgaVv9TzsaPaVgbHvo5Y3tNNYYxos=; b=ppMUasTQ2NFIVratM9ikS7NFj/
        UkF8HogTa6VyMQMaEkP3bez5gB08f3r8SAmGcIbndR+fN69hG3SqQcJnbJHslsRzfKDcWLXQ187YN
        Rsy6gusydbbXGtokmGO6Gkkvd+Ze+GY01eaRfpoyX6s2CzMehJ8/xUj989/9lLoBwIHKVp3VolRTv
        Ers/GM9tExG8EFYQ4ibYH7M5zLKjMZ/Gkqvqh5FdSbV5N2icoX5ljSE2BZnOT/dbz+iMqY2S8OZbW
        wScNVRn9WViPuV5wwf5Ldq/7igZRlSjwOPR2D8AeU0do+8arbHlI0SeUoK0fPtQLNvtVjuAwwt3cF
        8lHH00rA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nF61L-00E3f0-EG; Wed, 02 Feb 2022 03:09:23 +0000
Date:   Tue, 1 Feb 2022 19:09:23 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>, bas smit <bas@baslab.org>,
        =?utf-8?B?VG9tw6HFoQ==?= Glozar <tglozar@gmail.com>,
        Ast-x64 <Ast-x64@protonmail.com>,
        Viktor Malik <viktor.malik@gmail.com>,
        Daniel Xu <dxu@dxuuu.xyz>, Jiri Olsa <jolsa@kernel.org>
Cc:     jeyu@kernel.org, masahiroy@kernel.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: Re: [PING PATCH v7] kallsyms: new /proc/kallmodsyms with builtin
 modules
Message-ID: <Yfn145FyE3PDBEad@bombadil.infradead.org>
References: <20211216201919.234994-1-nick.alcock@oracle.com>
 <Yd8CDJA0dy0VaXrB@bombadil.infradead.org>
 <878rvk7uv2.fsf@esperi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878rvk7uv2.fsf@esperi.org.uk>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC'ing bfptrace folks for feedback.

I'm pretty reluctant to merge any of this unless we have wide community
desire to see this. I'm not quite seeing that yet.

On Wed, Jan 12, 2022 at 04:59:45PM +0000, Nick Alcock wrote:
> On 12 Jan 2022, Luis Chamberlain stated:
> 
> > On Thu, Dec 16, 2021 at 08:19:12PM +0000, Nick Alcock wrote:
> >> /proc/kallsyms is very useful for tracers and other tools that need to
> >> map kernel symbols to addresses.
> >> 
> >> It would be useful
> >
> > It took me digging on archives to see to *who* this is useful to.
> > The short answer seeme to be dtrace. Can you work on getting use
> > of this for something (I don't know, maybe kernelshark?) that does
> > not taint the kernel? Last I checked using dtrace on linux taints the
> > kernel.
> 
> It hasn't tainted the kernel for at least four years :) v1 (with a
> kernel module) has been GPLv2 since 2017; v2 is pure-BPF and has no
> DTrace-specific kernel modules,

I google for dtrace LInux and I end up here:

https://www.oracle.com/linux/downloads/linux-dtrace.html

It then has documentation dating back to year 2020, and I can't
apt-get install any of these "dtrace-utils" or anything with dtrace.

How do I get running with dtrace on debian? Typically this is a flag
it has some funky license. You metioned dtrace is GPLv2 since 2017, does
the same apply to the pure-BPF stuff?

Note I see a bpftrace effort, can that be made to use your changes?
At *least* I can install that on a regular distro. And it notes
"The bpftrace language is inspired by awk and C, and predecessor tracers
such as DTrace and SystemTap."

I see on that page it says:

Note that DTrace requires the Unbreakable Enterprise Kernel (UEK)
release 5 or higher. 

> just using some new things we have to
> add to the kernel, most of which seem plausibly useful to others too
> (kallmodsyms, waitfd pro tem until pidfd supports ptracers, and CTF).

All sounds nice, but I'd like to give this all a spin, but I can't
find anything remotely close to anything sensible to try it out.
I don't want to run any Oracle kernel. I want to run things upstream.

> This is not a DTrace-specific feature in any case: all my submissions
> have noted that it seems likely to be useful to anyone who wants a
> stable reference to modules that doesn't change whenever the kernel
> config changes, which probably means most tracers with support for
> kernel modules which implement anything like a programming language.

Great! But I'd like things to have tools

> > Without valid upstream users I see no need to add more complexity to the
> > kernel. And complexity added by tainting modules or not upstream modules
> 
> We don't need any of those any more :) Even CTF is now generated by GCC
> (once GCC 12 is released) and deduplicated by GNU ld: the CTF patch will
> be only a few hundred lines long once GCC 12 is out and I drop the
> DWARF->CTF translator.

Great!

> > Without a valid non-taining user being made very clear with a value-add,
> > I will have to ignore this.
> 
> I hope this gives you a reason to not ignore it! Have some links:
> 
> DTrace v1 (maintenance mode, fairly hefty GPL kernel module, UPL
> userspace; fully-functional including fbt, kernel side will shrink):
> 
>   https://github.com/oracle/dtrace-linux-kernel v1/5.15
>   https://github.com/oracle/dtrace-utils 1.x-branch-dev
> 
> DTrace v2 based on BPF, in progress, some features still missing (UPL
> userspace and a few GPL kernel patches, including this one: needs a BPF
> cross-compiler, which is a new GCC 12 target):
> 
>   https://github.com/oracle/dtrace-linux-kernel v2/5.14.9
>   https://github.com/oracle/dtrace-utils 2.0-branch

The "The Universal Permissive License (UPL)"? Really ? Anyway it seems
to be at least GPL compatible. I'm curios why no distro has picked up
any of this work?

I don't see much traction based on what you have said on dtrace
on anything other than Oracle Linux stuff, it would be nice if bpftrace
folks were excited about your changes and we had support for that
there.

> (I'm going to respin all of these kernel branches against 5.17-rc once
> the merge window closes, and bring the things both kernel trees have in
> common into sync. I'll drop you a line once that's done.)

Nice.

> Config-wise both of these need kernels with CONFIG_KALLMODSYMS,
> CONFIG_WAITFD and CONFIG_CTF turned on, and a kernel built with a 'make
> ctf' done after 'make', and the kernel source tree available when DTrace
> proper is built.

Thanks for the heads up.

  Luis
