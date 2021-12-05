Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE64468AF4
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 14:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbhLENKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 08:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbhLENKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 08:10:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29E2C061714;
        Sun,  5 Dec 2021 05:06:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AEFD60F50;
        Sun,  5 Dec 2021 13:06:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F637C341C1;
        Sun,  5 Dec 2021 13:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638709605;
        bh=Acngvl9GAxv9Qw1oess40U2Ddn77HI6sPJ8K4U9I7E8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gvpr9MMaho9ENhmR8tHbkiCfzuG5QoIP82Ygja0cjVkb65J/yfzmQz5RP3qCbfUEM
         qnV4sj8uSEW59x2vcHCuWpNZf+dLajcPueDnZ1yqo5fsgi2mmweWvM0wJB1P3+P3PI
         ji+w4GiXN8+pVlwGmw6eljIzLoRDW724EjJuz9SKa2lmyW6XXO19Z3QJvWinQps6yT
         9N/MWZ+0oApkrc7sN6xHyxPXPMx1qg5S5RMCAqv03VCtqga1W+GQgoVlQrhKNleDLk
         jo/o1qjjmQOAQOG1hGZmgB4p2ySkpyPQqe2ryiAQVHhzA3FudgAur8oeanVsTsznPS
         aNASmUH+K1Ayg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5EC6140002; Sun,  5 Dec 2021 10:06:42 -0300 (-03)
Date:   Sun, 5 Dec 2021 10:06:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: Building perf with BUILD_BPF_SKEL=1 by default
Message-ID: <Yay5Yjnj7LUodupy@kernel.org>
References: <YaoXUrLUZt1scVb0@kernel.org>
 <CF175681-8101-43D1-ABDB-449E644BE986@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CF175681-8101-43D1-ABDB-449E644BE986@fb.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 03, 2021 at 07:32:34PM +0000, Song Liu escreveu:
> 
> 
> > On Dec 3, 2021, at 5:10 AM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > 
> > Hi Song,
> > 
> > 	So I'm changing all my containers to build with BUILD_BPF_SKEL=1
> > to then make this the default, so far older containers fail either
> > because the clang available is too old, so I've added a NO_BUILD_BPF_SKEL=1
> > env var to disable that in those containers and then there is this other
> > case where clang is recent enough but:
> > 
> >    util/bpf_skel/bperf_leader.bpf.c:13:20: error: use of undeclared identifier 'BPF_F_PRESERVE_ELEMS'
> >            __uint(map_flags, BPF_F_PRESERVE_ELEMS);
> > 
> > Because the system's /usr/include/linux/bpf.h doesn't have that
> > BPF_F_PRESERVE_ELEMS enum entry.
> > 
> > These are enums to make them available via BTF, but then I can't use
> > the:
> > 
> > #ifdef BPF_F_PRESERVE_ELEMS
> > #define BPF_F_PRESERVE_ELEMS (1U << 11)
> > #endif
> > 
> > approach.
> > 
> > But then we _have_ it in the tools/include/uapi/linux/bpf.h we ship:
> > 
> > $ grep BPF_F_PRESERVE_ELEMS tools/include/uapi/linux/bpf.h
> > 	BPF_F_PRESERVE_ELEMS	= (1U << 11),
> > $
> > 
> > so we need to switch to using it somehow, this way we can build in more
> > systems and make bperf and other BPF enabled features.
> > 
> > From a quick look I couldn't find where to add
> > $(sourcedir)/tools/include/uapi/ to the include path used to build
> > util/bpf_skel/bperf_leader.bpf.c, should be easy, can you take a look?
> > 
> > Thanks,
> > 
> > - Arnaldo
> 
> I think the following should fix it

I'm trying this now and tentatively sticking a Signed-off-by: you to it,
ok?

- Arnaldo
 
> Thanks,
> Song
> 
> 
> diff --git i/tools/perf/util/bpf_skel/bperf_follower.bpf.c w/tools/perf/util/bpf_skel/bperf_follower.bpf.c
> index b8fa3cb2da230..4a6acfde14937 100644
> --- i/tools/perf/util/bpf_skel/bperf_follower.bpf.c
> +++ w/tools/perf/util/bpf_skel/bperf_follower.bpf.c
> @@ -1,7 +1,6 @@
>  // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  // Copyright (c) 2021 Facebook
> -#include <linux/bpf.h>
> -#include <linux/perf_event.h>
> +#include "vmlinux.h"
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
>  #include "bperf.h"
> diff --git i/tools/perf/util/bpf_skel/bperf_leader.bpf.c w/tools/perf/util/bpf_skel/bperf_leader.bpf.c
> index 4f70d1459e86c..40d962b058634 100644
> --- i/tools/perf/util/bpf_skel/bperf_leader.bpf.c
> +++ w/tools/perf/util/bpf_skel/bperf_leader.bpf.c
> @@ -1,7 +1,6 @@
>  // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  // Copyright (c) 2021 Facebook
> -#include <linux/bpf.h>
> -#include <linux/perf_event.h>
> +#include "vmlinux.h"
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
>  #include "bperf.h"
> diff --git i/tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c w/tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c
> index ab12b4c4ece21..97037d3b3d9fa 100644
> --- i/tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c
> +++ w/tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  // Copyright (c) 2020 Facebook
> -#include <linux/bpf.h>
> +#include "vmlinux.h"
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
> 

-- 

- Arnaldo
