Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A70A463681
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237533AbhK3OWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:22:18 -0500
Received: from foss.arm.com ([217.140.110.172]:39380 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233520AbhK3OWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:22:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A49C1063;
        Tue, 30 Nov 2021 06:18:57 -0800 (PST)
Received: from [10.57.35.239] (unknown [10.57.35.239])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43AED3F5A1;
        Tue, 30 Nov 2021 06:18:56 -0800 (PST)
Subject: Re: [FYI][PATCH 1/1] tools build: Remove needless libpython-version
 feature check that breaks test-all fast path
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        =?UTF-8?Q?Jaroslav_=c5=a0karvada?= <jskarvad@redhat.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
References: <YaYmeeC6CS2b8OSz@kernel.org>
From:   James Clark <james.clark@arm.com>
Message-ID: <4df4b76a-fbb5-89d8-fbef-fa844d8c1d3b@arm.com>
Date:   Tue, 30 Nov 2021 14:18:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YaYmeeC6CS2b8OSz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/11/2021 13:26, Arnaldo Carvalho de Melo wrote:
> Since 66dfdff03d196e51 ("perf tools: Add Python 3 support") we don't use
> the tools/build/feature/test-libpython-version.c version in any Makefile
> feature check:
> 
>   $ find tools/ -type f | xargs grep feature-libpython-version
>   $
> 
> The only place where this was used was removed in 66dfdff03d196e51:
> 
>   -        ifneq ($(feature-libpython-version), 1)
>   -          $(warning Python 3 is not yet supported; please set)
>   -          $(warning PYTHON and/or PYTHON_CONFIG appropriately.)
>   -          $(warning If you also have Python 2 installed, then)
>   -          $(warning try something like:)
>   -          $(warning $(and ,))
>   -          $(warning $(and ,)  make PYTHON=python2)
>   -          $(warning $(and ,))
>   -          $(warning Otherwise, disable Python support entirely:)
>   -          $(warning $(and ,))
>   -          $(warning $(and ,)  make NO_LIBPYTHON=1)
>   -          $(warning $(and ,))
>   -          $(error   $(and ,))
>   -        else
>   -          LDFLAGS += $(PYTHON_EMBED_LDFLAGS)
>   -          EXTLIBS += $(PYTHON_EMBED_LIBADD)
>   -          LANG_BINDINGS += $(obj-perf)python/perf.so
>   -          $(call detected,CONFIG_LIBPYTHON)
>   -        endif
> 
> And nowadays we either build with PYTHON=python3 or just install the
> python3 devel packages and perf will build against it.

I just tried this and found a combo that doesn't work and fails with this
error (unrelated to this change): 

  Makefile.config:812: No 'python-config' tool was found: disables Python support - please install python-devel/python-dev

The combo is when the python2 runtime is installed, but the python3 devtools
are installed. I didn't realise this when I added the python 3 autodetection,
I only fixed the issue for a system that was solely python3.

Do you think I should fix this? Currently the workaround is PYTHON=python3,
maybe it's enough of an edge case that it's ok?


> 
> But the leftover feature-libpython-version check made the fast path
> feature detection to break in all cases except when python2 devel files
> were installed:
> 
>   $ rpm -qa | grep python.*devel
>   python3-devel-3.9.7-1.fc34.x86_64
>   $ rm -rf /tmp/build/perf ; mkdir -p /tmp/build/perf ;
>   $ make -C tools/perf O=/tmp/build/perf install-bin
>   make: Entering directory '/var/home/acme/git/perf/tools/perf'
>     BUILD:   Doing 'make -j32' parallel build
>     HOSTCC  /tmp/build/perf/fixdep.o
>   <SNIP>
>   $ cat /tmp/build/perf/feature/test-all.make.output
>   In file included from test-all.c:18:
>   test-libpython-version.c:5:10: error: #error
>       5 |         #error
>         |          ^~~~~
>   $ ldd ~/bin/perf | grep python
> 	libpython3.9.so.1.0 => /lib64/libpython3.9.so.1.0 (0x00007fda6dbcf000)
>   $
> 
> As python3 is the norm these days, fix this by just removing the unused
> feature-libpython-version feature check, making the test-all fast path
> to work with the common case.
> 
> With this:
> 
>   $ rm -rf /tmp/build/perf ; mkdir -p /tmp/build/perf ;
>   $ make -C tools/perf O=/tmp/build/perf install-bin |& head
>   make: Entering directory '/var/home/acme/git/perf/tools/perf'
>     BUILD:   Doing 'make -j32' parallel build
>     HOSTCC  /tmp/build/perf/fixdep.o
>     HOSTLD  /tmp/build/perf/fixdep-in.o
>     LINK    /tmp/build/perf/fixdep
> 
>   Auto-detecting system features:
>   ...                         dwarf: [ on  ]
>   ...            dwarf_getlocations: [ on  ]
>   ...                         glibc: [ on  ]
>   $ ldd ~/bin/perf | grep python
> 	libpython3.9.so.1.0 => /lib64/libpython3.9.so.1.0 (0x00007f58800b0000)
>   $ cat /tmp/build/perf/feature/test-all.make.output
>   $
> 
> Fixes: 66dfdff03d196e51 ("perf tools: Add Python 3 support")
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jaroslav Škarvada <jskarvad@redhat.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/build/Makefile.feature                 |  1 -
>  tools/build/feature/Makefile                 |  4 ----
>  tools/build/feature/test-all.c               |  5 -----
>  tools/build/feature/test-libpython-version.c | 11 -----------
>  tools/perf/Makefile.config                   |  2 --
>  5 files changed, 23 deletions(-)
>  delete mode 100644 tools/build/feature/test-libpython-version.c
> 


Reviewed-by: James Clark <james.clark@arm.com>
