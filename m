Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05616468B1A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 14:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbhLENm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 08:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234166AbhLENm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 08:42:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65C4C061714;
        Sun,  5 Dec 2021 05:38:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B53FB80E53;
        Sun,  5 Dec 2021 13:38:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC07C341C1;
        Sun,  5 Dec 2021 13:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638711537;
        bh=rL3+aR2pLGypRZ5zyDsirzZcIuK6tXeJK440jo4YPUY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KCo3MKBUA9nnNvzCixDkeDTat9we8nid5F1n7McheFUbY0hqMlCDPugRb7aE7M3hx
         aMMVDOQjP2IAy5k9BFjCNvwnDAYN60pq2bp6HwXj+eDZcEZTS22CQNwNfBZFzLZQru
         4Pt2CPt1GDo6mSOwB0JO1yvBxkDBlHaGxiDP1xI2afz+C8YVVzyVfumC9RJ30F54nE
         igLa33DiBl2Y2DupnO2ziwSIGcOaAcsY2R42X2aOsSNc2fZo3bwKKUDetbTSojmJlK
         p8iRq4qGcHDVJbJVLLKxe1Gft9iqAMDED8QYwx4EtNrkfVKPQa/lFF/lpTWm8F+/VF
         LLYzFk6nbwd8w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 98A5840002; Sun,  5 Dec 2021 10:38:53 -0300 (-03)
Date:   Sun, 5 Dec 2021 10:38:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: Building perf with BUILD_BPF_SKEL=1 by default
Message-ID: <YazA7cQv1d0O5Qiw@kernel.org>
References: <YaoXUrLUZt1scVb0@kernel.org>
 <CF175681-8101-43D1-ABDB-449E644BE986@fb.com>
 <Yay5Yjnj7LUodupy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yay5Yjnj7LUodupy@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Dec 05, 2021 at 10:06:42AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Dec 03, 2021 at 07:32:34PM +0000, Song Liu escreveu:
> > 
> > 
> > > On Dec 3, 2021, at 5:10 AM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > 
> > > Hi Song,
> > > 
> > > 	So I'm changing all my containers to build with BUILD_BPF_SKEL=1
> > > to then make this the default, so far older containers fail either
> > > because the clang available is too old, so I've added a NO_BUILD_BPF_SKEL=1
> > > env var to disable that in those containers and then there is this other
> > > case where clang is recent enough but:
> > > 
> > >    util/bpf_skel/bperf_leader.bpf.c:13:20: error: use of undeclared identifier 'BPF_F_PRESERVE_ELEMS'
> > >            __uint(map_flags, BPF_F_PRESERVE_ELEMS);
> > > 
> > > Because the system's /usr/include/linux/bpf.h doesn't have that
> > > BPF_F_PRESERVE_ELEMS enum entry.
> > > 
> > > These are enums to make them available via BTF, but then I can't use
> > > the:
> > > 
> > > #ifdef BPF_F_PRESERVE_ELEMS
> > > #define BPF_F_PRESERVE_ELEMS (1U << 11)
> > > #endif
> > > 
> > > approach.
> > > 
> > > But then we _have_ it in the tools/include/uapi/linux/bpf.h we ship:
> > > 
> > > $ grep BPF_F_PRESERVE_ELEMS tools/include/uapi/linux/bpf.h
> > > 	BPF_F_PRESERVE_ELEMS	= (1U << 11),
> > > $
> > > 
> > > so we need to switch to using it somehow, this way we can build in more
> > > systems and make bperf and other BPF enabled features.
> > > 
> > > From a quick look I couldn't find where to add
> > > $(sourcedir)/tools/include/uapi/ to the include path used to build
> > > util/bpf_skel/bperf_leader.bpf.c, should be easy, can you take a look?
> > > 
> > > Thanks,
> > > 
> > > - Arnaldo
> > 
> > I think the following should fix it
> 
> I'm trying this now and tentatively sticking a Signed-off-by: you to it,
> ok?

Fixed these as well (debian:11, debian:experimental, some recent
ubuntus):

In file included from util/bpf_skel/bperf_follower.bpf.c:3:
In file included from /usr/include/linux/bpf.h:11:
In file included from /usr/include/linux/types.hutil/bpf_skel/bperf_leader.bpf.c::5In file included from :3util/bpf_skel/bpf_prog_profiler.bpf.c10:
::In file included from 3 /usr/include/linux/bpf.h:
:In file included from 11/usr/include/linux/bpf.h:
fatal error:: 11/usr/include/linux/types.h:
:'asm/types.h' file not found5:/usr/include/linux/types.h10
::5 :10: fatal errorfatal error: : 'asm/types.h' file not found'asm/types.h' file not found#include <asm/types.h>


         ^~~~~~~~~~~~~
#include <asm/types.h>#include <asm/types.h>

         ^~~~~~~~~~~~~         ^~~~~~~~~~~~~

1 error generated.
1 error generated.
1 error generated.
make[2]: *** [Makefile.perf:1072: /tmp/build/perf/util/bpf_skel/.tmp/bperf_follower.bpf.o] Error 1

