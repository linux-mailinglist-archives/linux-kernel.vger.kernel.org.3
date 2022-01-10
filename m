Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C42948A104
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 21:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240901AbiAJUkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 15:40:17 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51978 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbiAJUkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 15:40:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41155613FB;
        Mon, 10 Jan 2022 20:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42007C36AE9;
        Mon, 10 Jan 2022 20:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641847215;
        bh=ro5xsmEILXWocoDEG6VPR6STDDelI7xJq86J/uL7BeQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T7UVksXPngSWgjTlByduKhZQdJZ9J/0CmasW0YdNk3JC6D4Oq1GWnX8VOX8CXYVLk
         7Ox9LgQnBO4OjhHcPjBIy3pFbCOvVmMhmm1jkmiC586qOstXF440zR8gfi2H6dOAkV
         8P0Ut2lxpBl6N9O40aa25mdRGPH/l0JNbIXxnKsqJ6pyh0uC/ohgm8NFtOvc7Qpcg7
         +5l+1OzJPmtYU47DXF3CkVy/7GqO/tOv/iTimP19Qnw264jXmiCkVpJggsqJDjs6c4
         +WOk58W1zvlBNm9dmlgXvldAtFO3bk8WHAhy5S8wEc34y8fMGPv2bE3qpad5bube35
         WZQoxVAEDHDsg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 070B440714; Mon, 10 Jan 2022 17:40:11 -0300 (-03)
Date:   Mon, 10 Jan 2022 17:40:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, zhengjun.xing@intel.com,
        eranian@google.com
Subject: Re: [PATCH v4 00/48] Refactor perf cpumap
Message-ID: <YdyZq4dHjhJrxOHb@kernel.org>
References: <20220105061351.120843-1-irogers@google.com>
 <YdyUVSHs/OLZ9Ntm@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YdyUVSHs/OLZ9Ntm@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 10, 2022 at 05:17:25PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Jan 04, 2022 at 10:13:03PM -0800, Ian Rogers escreveu:
> > Perf cpu map has various functions where a cpumap and index are passed
> > in order to load the cpu. A problem with this is that the wrong index
> > may be passed for the cpumap, causing problems like aggregation on the
> > wrong CPU:
> > https://lore.kernel.org/lkml/20211204023409.969668-1-irogers@google.com/
> > 
> > This patch set refactors the cpu map API, reducing it and explicitly
> > passing the cpu (rather than the pair) to functions that need
> > it. Comments are added at the same time. Changes modify the same
> > file/function more than once as refactoring and fixes are broken apart
> > for the sake of bisection.
> > 
> > v2. Incorproates fixes suggested Jiri Olsa, rewrites the evlist CPU
> >     iterator in part in a way suggested by Riccardo Mancini. The new
> >     fixes start at patch 23. The final change was suggested by John
> >     Garry to make the CPUs have their own struct wrapper.
> > 
> > v3. Incorporates fixes suggested by Namhyung Kim.
> > 
> > v4. Rebases and incorporates fixes suggested by Jiri Olsa.
> 
> Did fixes in places where BUILD_BPF_SKEL=1 was failing, now, at the end
> of the series:
> 
> ⬢[acme@toolbox perf]$ git log --oneline -1 ; time make -C tools/perf build-test
> 462aafa8fcbdc78f (HEAD -> perf/core) perf cpumap: Give CPUs their own type
> make: Entering directory '/var/home/acme/git/perf/tools/perf'
> - tarpkg: ./tests/perf-targz-src-pkg .
>                  make_static: cd . && make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 -j32  DESTDIR=/tmp/tmp.lFrqVcqiRY
>               make_with_gtk2: cd . && make GTK2=1 -j32  DESTDIR=/tmp/tmp.KvHmTqUGmD
> - /var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP: cd . && make FEATURE_DUMP_COPY=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP  feature-dump
> cd . && make FEATURE_DUMP_COPY=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP feature-dump
>             make_no_libelf_O: cd . && make NO_LIBELF=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.xz3LYy7WpA DESTDIR=/tmp/tmp.zVjIMpvQMM
>       make_no_libbpf_DEBUG_O: cd . && make NO_LIBBPF=1 DEBUG=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.0gxAOSjb1j DESTDIR=/tmp/tmp.kYTk1WjWWz
>           make_no_libaudit_O: cd . && make NO_LIBAUDIT=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.6hArTG9Dth DESTDIR=/tmp/tmp.hCNdYeDRCr
>          make_no_backtrace_O: cd . && make NO_BACKTRACE=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.VtoPI58z3t DESTDIR=/tmp/tmp.SYyBBMSHSL
>          make_no_libcrypto_O: cd . && make NO_LIBCRYPTO=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.SO1qtxJwvE DESTDIR=/tmp/tmp.AqrPw1oZfx
>        make_with_clangllvm_O: cd . && make LIBCLANGLLVM=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.G9KVEaDv2B DESTDIR=/tmp/tmp.6CSqj0wPqJ
>        make_with_coresight_O: cd . && make CORESIGHT=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.PnVTJNHy1E DESTDIR=/tmp/tmp.k7Arerg778
>          make_no_libpython_O: cd . && make NO_LIBPYTHON=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.cKjvFagVL3 DESTDIR=/tmp/tmp.aCaD0hbP3O
>                make_no_sdt_O: cd . && make NO_SDT=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.EKoWnoZtl4 DESTDIR=/tmp/tmp.1gGYetcptB
>        make_libbpf_dynamic_O: cd . && make LIBBPF_DYNAMIC=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.Nked5O10EK DESTDIR=/tmp/tmp.eo6YAEOfZO
>               make_minimal_O: cd . && make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1 NO_SYSCALL_TABLE=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.Z6dSqYBXfU DESTDIR=/tmp/tmp.Y4iRu634of
>  make_install_prefix_slash_O: cd . && make install prefix=/tmp/krava/ FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.BgipDyNu70 DESTDIR=/tmp/tmp.pOwrdDYBqf
>      make_util_pmu_bison_o_O: cd . && make util/pmu-bison.o FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.XeO82Ajmv6 DESTDIR=/tmp/tmp.dxQKNNBM6W
>               make_install_O: cd . && make install FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.KuCyqzLwnA DESTDIR=/tmp/tmp.KYvqoiOKzW
>        make_install_prefix_O: cd . && make install prefix=/tmp/krava FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.rJNNPELdri DESTDIR=/tmp/tmp.g52i9CcmnU
>           make_install_bin_O: cd . && make install-bin FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.i118vbQuo0 DESTDIR=/tmp/tmp.90tKcjOWD8
>                make_perf_o_O: cd . && make perf.o FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.kEZMTvh3wf DESTDIR=/tmp/tmp.JYvQLdkPsp
>              make_no_slang_O: cd . && make NO_SLANG=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.WDNGH0DpdW DESTDIR=/tmp/tmp.Zfa804wClJ
>                 make_no_ui_O: cd . && make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.P4nTBNqkP4 DESTDIR=/tmp/tmp.iCLqOyrh4o
>               make_no_newt_O: cd . && make NO_NEWT=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.EdjjHoqODV DESTDIR=/tmp/tmp.jKfYRizWtm
>          make_with_libpfm4_O: cd . && make LIBPFM4=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.r3hPAOgfId DESTDIR=/tmp/tmp.GvMmEZUc2B
>           make_no_demangle_O: cd . && make NO_DEMANGLE=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.wG9f40LzG3 DESTDIR=/tmp/tmp.i76sPjSg1m
>          make_no_libunwind_O: cd . && make NO_LIBUNWIND=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.SmFfmmB9KQ DESTDIR=/tmp/tmp.9tjMdCWMxG
>             make_no_libbpf_O: cd . && make NO_LIBBPF=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.7jH21oP9n7 DESTDIR=/tmp/tmp.taUqTgY37S
>        make_no_syscall_tbl_O: cd . && make NO_SYSCALL_TABLE=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.L2v7vi1AQl DESTDIR=/tmp/tmp.wHEA4jEpw9
>            make_no_libnuma_O: cd . && make NO_LIBNUMA=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.9N5pQYuRbO DESTDIR=/tmp/tmp.B0Yptb7xP6
>            make_util_map_o_O: cd . && make util/map.o FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.B8oe4jnWwB DESTDIR=/tmp/tmp.m0APlsli14
>       make_with_babeltrace_O: cd . && make LIBBABELTRACE=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.3G1kLTJLJx DESTDIR=/tmp/tmp.ahuDENSMsz
>                 make_debug_O: cd . && make DEBUG=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.KpsvOj0KHD DESTDIR=/tmp/tmp.f2Yv9Lrorg
>            make_no_libperl_O: cd . && make NO_LIBPERL=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.7tIufwAi4O DESTDIR=/tmp/tmp.vcBv7UYjuw
>          make_no_libbionic_O: cd . && make NO_LIBBIONIC=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.HCJA7xCDxq DESTDIR=/tmp/tmp.us5CDSPqyO
>                  make_pure_O: cd . && make FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.eg2wCpydvg DESTDIR=/tmp/tmp.MmD1xESO2A
>                   make_doc_O: cd . && make doc FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.TqkyGrzRut DESTDIR=/tmp/tmp.ap34IVxoM9
>            make_no_scripts_O: cd . && make NO_LIBPYTHON=1 NO_LIBPERL=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.pRWHKzpPhv DESTDIR=/tmp/tmp.dUNhAp2rLt
>             make_clean_all_O: cd . && make clean all FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.YnzNLLk9ID DESTDIR=/tmp/tmp.7kXr5obkmA
> make_no_libdw_dwarf_unwind_O: cd . && make NO_LIBDW_DWARF_UNWIND=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.GzZCxuYLwR DESTDIR=/tmp/tmp.n3YS9a9DcU
>                  make_help_O: cd . && make help FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.t7QwWVHsod DESTDIR=/tmp/tmp.NG5uSWCZzi
>           make_no_auxtrace_O: cd . && make NO_AUXTRACE=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.wiDZkJzs8R DESTDIR=/tmp/tmp.ITtPlX0usX
>               make_no_gtk2_O: cd . && make NO_GTK2=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.xd1x5QIckJ DESTDIR=/tmp/tmp.f6KzsHHkZH
>                  make_tags_O: cd . && make tags FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.e8oSaBuFUb DESTDIR=/tmp/tmp.4czd6ovlSB
> OK
> make: Leaving directory '/var/home/acme/git/perf/tools/perf'
> 
> real	4m29.388s
> user	59m6.060s
> sys	12m19.581s
> ⬢[acme@toolbox perf]$
> 
> alias m='perf stat -e cycles:u,instructions:u make -k BUILD_BPF_SKEL=1 CORESIGHT=1 PYTHON=python3 O=/tmp/build/perf -C tools/perf install-bin && git status && perf test python'
> 
> So 'perf test python' is done after every build, no problems with that
> as well.
> 
> I'm now making it go thru the container builds.

Not a good start, checking:

[perfbuilder@five ~]$ time dm
   1    50.25 almalinux:8                   : FAIL clang version 12.0.1 (Red Hat 12.0.1-4.module_el8.5.0+1025+93159d6c)
    builtin-stat.c:1499:31: error: unused function 'perf_env__get_cpu' [-Werror,-Wunused-function]
    static inline struct perf_cpu perf_env__get_cpu(void *data, struct perf_cpu_map *map, int idx)
                                  ^
    1 error generated.
   2    54.14 alpine:3.4                    : FAIL clang version 3.8.0 (tags/RELEASE_380/final)
    builtin-stat.c:1499:31: error: unused function 'perf_env__get_cpu' [-Werror,-Wunused-function]
    static inline struct perf_cpu perf_env__get_cpu(void *data, struct perf_cpu_map *map, int idx)
                                  ^
    1 error generated.
   3    39.78 alpine:3.5                    : FAIL clang version 3.8.1 (tags/RELEASE_381/final)
    builtin-stat.c:1499:31: error: unused function 'perf_env__get_cpu' [-Werror,-Wunused-function]
    static inline struct perf_cpu perf_env__get_cpu(void *data, struct perf_cpu_map *map, int idx)
                                  ^
    1 error generated.
   4    82.52 alpine:3.6                    : FAIL clang version 4.0.0 (tags/RELEASE_400/final)
    builtin-stat.c:1499:31: error: unused function 'perf_env__get_cpu' [-Werror,-Wunused-function]
    static inline struct perf_cpu perf_env__get_cpu(void *data, struct perf_cpu_map *map, int idx)
                                  ^
    1 error generated.
   5   113.61 alpine:3.7                    : FAIL gcc version 6.4.0 (Alpine 6.4.0)
    builtin-stat.c:1499:31: error: unused function 'perf_env__get_cpu' [-Werror,-Wunused-function]
    static inline struct perf_cpu perf_env__get_cpu(void *data, struct perf_cpu_map *map, int idx)
                                  ^
    1 error generated.
   6   119.02 alpine:3.8                    : FAIL gcc version 6.4.0 (Alpine 6.4.0)
    builtin-stat.c:1499:31: error: unused function 'perf_env__get_cpu' [-Werror,-Wunused-function]
    static inline struct perf_cpu perf_env__get_cpu(void *data, struct perf_cpu_map *map, int idx)
                                  ^
    1 error generated.
   7    64.55 alpine:3.9                    : FAIL gcc version 8.3.0 (Alpine 8.3.0)
    builtin-stat.c:1499:31: error: unused function 'perf_env__get_cpu' [-Werror,-Wunused-function]
    static inline struct perf_cpu perf_env__get_cpu(void *data, struct perf_cpu_map *map, int idx)
                                  ^
    1 error generated.
   8: alpine:3.10
