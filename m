Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC62463591
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 14:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241132AbhK3NjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 08:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240824AbhK3Niy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 08:38:54 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F53C061574;
        Tue, 30 Nov 2021 05:35:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5A983CE19E4;
        Tue, 30 Nov 2021 13:35:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0A6C53FCD;
        Tue, 30 Nov 2021 13:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638279331;
        bh=ZbYLOHwzBNV66bp8ROGzwP/TR4kHipcxNWlYHuOAOmc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MaSxuMrmNxsGhqI3WRNG8WdL5yDQ5Js63JL9Sqp6vghKZNVX5G8E5dC3s+je1XJvS
         DOEl+qFtu6iHJF1SwBYo+/cIz4ySOWWmPwEqgNmCc5pzQn+Ro0Iz5g+vMDNzXPRFHF
         /wct65DWgyjHgust84PDyAXq+PsLHbQMNrw/paU7YBeUFaOEyMBWPFERhf4GaANXDr
         6nq3ckmqeUelKR0zIXWMpsLSVyfNCBKgRKvAIffR6GlEmYZI7qY8tYSZUG+6MFThuS
         cdBjPH57iDu3pX+/rFnL4f4g4mvvnliirekmL3CXeeSxclw7BBRR/PFVvd5QNKaHsk
         gN7JQ5Pe/AfTQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C14C640866; Fri, 26 Nov 2021 15:51:55 -0300 (-03)
Date:   Fri, 26 Nov 2021 15:51:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [FYI][PATCH 1/1] tools headers UAPI: Sync powerpc syscall table
 file changed by new futex_waitv syscall
Message-ID: <YaEsy1PwzN/vPJAO@kernel.org>
References: <YZ/1OU9mJuyS2HMa@kernel.org>
 <308BB8D5-95DF-40EF-9155-CEAC0422BBD4@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <308BB8D5-95DF-40EF-9155-CEAC0422BBD4@linux.vnet.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 26, 2021 at 03:19:32PM +0530, Athira Rajeev escreveu:
> 
> 
> > On 26-Nov-2021, at 2:12 AM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > 
> > To pick the changes in this cset:
> > 
> >  a0eb2da92b715d0c ("futex: Wireup futex_waitv syscall")
> > 
> > That add support for this new syscall in tools such as 'perf trace'.
> > 
> > For instance, this is now possible (adapted from the x86_64 test output):
> > 
> >  # perf trace -e futex_waitv
> >  ^C#
> >  # perf trace -v -e futex_waitv
> >  event qualifier tracepoint filter: (common_pid != 807333 && common_pid != 3564) && (id == 449)
> >  ^C#
> >  # perf trace -v -e futex* --max-events 10
> >  event qualifier tracepoint filter: (common_pid != 812168 && common_pid != 3564) && (id == 221 || id == 449)
> >  mmap size 528384B
> >           ? (         ): Timer/219310  ... [continued]: futex())                                            = -1 ETIMEDOUT (Connection timed out)
> >       0.012 ( 0.002 ms): Timer/219310 futex(uaddr: 0x7fd0b152d3c8, op: WAKE|PRIVATE_FLAG, val: 1)           = 0
> >       0.024 ( 0.060 ms): Timer/219310 futex(uaddr: 0x7fd0b152d420, op: WAIT_BITSET|PRIVATE_FLAG, utime: 0x7fd0b1657840, val3: MATCH_ANY) = 0
> >       0.086 ( 0.001 ms): Timer/219310 futex(uaddr: 0x7fd0b152d3c8, op: WAKE|PRIVATE_FLAG, val: 1)           = 0
> >       0.088 (         ): Timer/219310 futex(uaddr: 0x7fd0b152d424, op: WAIT_BITSET|PRIVATE_FLAG, utime: 0x7fd0b1657840, val3: MATCH_ANY) ...
> >       0.075 ( 0.005 ms): Web Content/219299 futex(uaddr: 0x7fd0b152d420, op: WAKE|PRIVATE_FLAG, val: 1)     = 1
> >       0.169 ( 0.004 ms): Web Content/219299 futex(uaddr: 0x7fd0b152d424, op: WAKE|PRIVATE_FLAG, val: 1)     = 1
> >       0.088 ( 0.089 ms): Timer/219310  ... [continued]: futex())                                            = 0
> >       0.179 ( 0.001 ms): Timer/219310 futex(uaddr: 0x7fd0b152d3c8, op: WAKE|PRIVATE_FLAG, val: 1)           = 0
> >       0.181 (         ): Timer/219310 futex(uaddr: 0x7fd0b152d420, op: WAIT_BITSET|PRIVATE_FLAG, utime: 0x7fd0b1657840, val3: MATCH_ANY) ...
> >  #
> > 
> > That is the filter expression attached to the raw_syscalls:sys_{enter,exit}
> > tracepoints.
> > 
> >  $ grep futex tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
> >  221	32	futex				sys_futex_time32
> >  221	64	futex				sys_futex
> >  221	spu	futex				sys_futex
> >  422	32	futex_time64			sys_futex			sys_futex
> >  449	common  futex_waitv                     sys_futex_waitv
> >  $
> > 
> 
> Hi Arnaldo,
> 
> I checked this in powerpc by using :
> perf trace -v -e futex_waitv 
> And also using functional selftest from 'tools/testing/selftests/futex/functional/futex_waitv’, to make sure ‘futex_waitv’ comes in the perf trace result.
> 
> Just a minor suggestion change. Below warning mentioned in this patch is for s390. But I verified that this patch fixes the perf build warning in powerpc also. So would be good to put the warning logs for powerpc:

I'll fix that. Thanks for pointing it out!
 
> Warning: Kernel ABI header at 'tools/perf/arch/powerpc/entry/syscalls/syscall.tbl' differs from latest version at 'arch/powerpc/kernel/syscalls/syscall.tbl'
> diff -u tools/perf/arch/powerpc/entry/syscalls/syscall.tbl arch/powerpc/kernel/syscalls/syscall.tbl
> 
> Reviewed-and-Tested-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

Thanks, tags collected!

- Arnaldo
 
> Thanks
> Athira
> 
> > This addresses this perf build warnings:
> > 
> >  Warning: Kernel ABI header at 'tools/perf/arch/s390/entry/syscalls/syscall.tbl' differs from latest version at 'arch/s390/kernel/syscalls/syscall.tbl'
> >  diff -u tools/perf/arch/s390/entry/syscalls/syscall.tbl arch/s390/kernel/syscalls/syscall.tbl
> > 
> > Cc: AndrÃ© Almeida <andrealmeid@collabora.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> > tools/perf/arch/powerpc/entry/syscalls/syscall.tbl | 1 +
> > 1 file changed, 1 insertion(+)
> > 
> > diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
> > index 7bef917cc84e6499..15109af9d0754d5f 100644
> > --- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
> > +++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
> > @@ -528,3 +528,4 @@
> > 446	common	landlock_restrict_self		sys_landlock_restrict_self
> > # 447 reserved for memfd_secret
> > 448	common	process_mrelease		sys_process_mrelease
> > +449	common  futex_waitv                     sys_futex_waitv
> > -- 
> > 2.31.1
> > 
> > 

-- 

- Arnaldo
