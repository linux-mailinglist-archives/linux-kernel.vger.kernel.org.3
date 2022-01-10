Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7C148A0CE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 21:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343509AbiAJURb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 15:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343495AbiAJURa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 15:17:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8297FC06173F;
        Mon, 10 Jan 2022 12:17:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24CF2B817DF;
        Mon, 10 Jan 2022 20:17:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89667C36AE3;
        Mon, 10 Jan 2022 20:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641845847;
        bh=haEY0C1SN2sxYLnvN4gWAdwA9uqWggl6S7CaFqcIWFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VlhwpIkNWseAn6Wy80qEd1vQTL8VMytbrdkQ5dLzRkI2p9QspnUgncvdr0mUI0HLY
         RbMi+cK5rHm7U3Ui3jb3DvxFSz98sxQNqXL+/x+W3ocXg/OBPe6lsXDq5+MtmG6Lxq
         Wrp1d2ZYTQ1sr7SVbAA97RKnJxwjKe9/ANzpPb2WOS7OFHEtVCX6i1IDKAF8BtJSJ5
         g+JDqewpi41rsv9E40evlH895LtuMJAiYS1G4cx55l0W1tq78R21qsvGFs4MEP7D0o
         AnhUmbO4gakIzehySI0I0Xdx/FkWvG1OjiZjAaVW8glq71c0tfwYTehcjB2nyVg08t
         FiJRby06bqkNA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7B0D140714; Mon, 10 Jan 2022 17:17:25 -0300 (-03)
Date:   Mon, 10 Jan 2022 17:17:25 -0300
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
Message-ID: <YdyUVSHs/OLZ9Ntm@kernel.org>
References: <20220105061351.120843-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220105061351.120843-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 04, 2022 at 10:13:03PM -0800, Ian Rogers escreveu:
> Perf cpu map has various functions where a cpumap and index are passed
> in order to load the cpu. A problem with this is that the wrong index
> may be passed for the cpumap, causing problems like aggregation on the
> wrong CPU:
> https://lore.kernel.org/lkml/20211204023409.969668-1-irogers@google.com/
> 
> This patch set refactors the cpu map API, reducing it and explicitly
> passing the cpu (rather than the pair) to functions that need
> it. Comments are added at the same time. Changes modify the same
> file/function more than once as refactoring and fixes are broken apart
> for the sake of bisection.
> 
> v2. Incorproates fixes suggested Jiri Olsa, rewrites the evlist CPU
>     iterator in part in a way suggested by Riccardo Mancini. The new
>     fixes start at patch 23. The final change was suggested by John
>     Garry to make the CPUs have their own struct wrapper.
> 
> v3. Incorporates fixes suggested by Namhyung Kim.
> 
> v4. Rebases and incorporates fixes suggested by Jiri Olsa.

Did fixes in places where BUILD_BPF_SKEL=1 was failing, now, at the end
of the series:

⬢[acme@toolbox perf]$ git log --oneline -1 ; time make -C tools/perf build-test
462aafa8fcbdc78f (HEAD -> perf/core) perf cpumap: Give CPUs their own type
make: Entering directory '/var/home/acme/git/perf/tools/perf'
- tarpkg: ./tests/perf-targz-src-pkg .
                 make_static: cd . && make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 -j32  DESTDIR=/tmp/tmp.lFrqVcqiRY
              make_with_gtk2: cd . && make GTK2=1 -j32  DESTDIR=/tmp/tmp.KvHmTqUGmD
- /var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP: cd . && make FEATURE_DUMP_COPY=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP  feature-dump
cd . && make FEATURE_DUMP_COPY=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP feature-dump
            make_no_libelf_O: cd . && make NO_LIBELF=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.xz3LYy7WpA DESTDIR=/tmp/tmp.zVjIMpvQMM
      make_no_libbpf_DEBUG_O: cd . && make NO_LIBBPF=1 DEBUG=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.0gxAOSjb1j DESTDIR=/tmp/tmp.kYTk1WjWWz
          make_no_libaudit_O: cd . && make NO_LIBAUDIT=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.6hArTG9Dth DESTDIR=/tmp/tmp.hCNdYeDRCr
         make_no_backtrace_O: cd . && make NO_BACKTRACE=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.VtoPI58z3t DESTDIR=/tmp/tmp.SYyBBMSHSL
         make_no_libcrypto_O: cd . && make NO_LIBCRYPTO=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.SO1qtxJwvE DESTDIR=/tmp/tmp.AqrPw1oZfx
       make_with_clangllvm_O: cd . && make LIBCLANGLLVM=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.G9KVEaDv2B DESTDIR=/tmp/tmp.6CSqj0wPqJ
       make_with_coresight_O: cd . && make CORESIGHT=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.PnVTJNHy1E DESTDIR=/tmp/tmp.k7Arerg778
         make_no_libpython_O: cd . && make NO_LIBPYTHON=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.cKjvFagVL3 DESTDIR=/tmp/tmp.aCaD0hbP3O
               make_no_sdt_O: cd . && make NO_SDT=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.EKoWnoZtl4 DESTDIR=/tmp/tmp.1gGYetcptB
       make_libbpf_dynamic_O: cd . && make LIBBPF_DYNAMIC=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.Nked5O10EK DESTDIR=/tmp/tmp.eo6YAEOfZO
              make_minimal_O: cd . && make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1 NO_SYSCALL_TABLE=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.Z6dSqYBXfU DESTDIR=/tmp/tmp.Y4iRu634of
 make_install_prefix_slash_O: cd . && make install prefix=/tmp/krava/ FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.BgipDyNu70 DESTDIR=/tmp/tmp.pOwrdDYBqf
     make_util_pmu_bison_o_O: cd . && make util/pmu-bison.o FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.XeO82Ajmv6 DESTDIR=/tmp/tmp.dxQKNNBM6W
              make_install_O: cd . && make install FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.KuCyqzLwnA DESTDIR=/tmp/tmp.KYvqoiOKzW
       make_install_prefix_O: cd . && make install prefix=/tmp/krava FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.rJNNPELdri DESTDIR=/tmp/tmp.g52i9CcmnU
          make_install_bin_O: cd . && make install-bin FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.i118vbQuo0 DESTDIR=/tmp/tmp.90tKcjOWD8
               make_perf_o_O: cd . && make perf.o FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.kEZMTvh3wf DESTDIR=/tmp/tmp.JYvQLdkPsp
             make_no_slang_O: cd . && make NO_SLANG=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.WDNGH0DpdW DESTDIR=/tmp/tmp.Zfa804wClJ
                make_no_ui_O: cd . && make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.P4nTBNqkP4 DESTDIR=/tmp/tmp.iCLqOyrh4o
              make_no_newt_O: cd . && make NO_NEWT=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.EdjjHoqODV DESTDIR=/tmp/tmp.jKfYRizWtm
         make_with_libpfm4_O: cd . && make LIBPFM4=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.r3hPAOgfId DESTDIR=/tmp/tmp.GvMmEZUc2B
          make_no_demangle_O: cd . && make NO_DEMANGLE=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.wG9f40LzG3 DESTDIR=/tmp/tmp.i76sPjSg1m
         make_no_libunwind_O: cd . && make NO_LIBUNWIND=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.SmFfmmB9KQ DESTDIR=/tmp/tmp.9tjMdCWMxG
            make_no_libbpf_O: cd . && make NO_LIBBPF=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.7jH21oP9n7 DESTDIR=/tmp/tmp.taUqTgY37S
       make_no_syscall_tbl_O: cd . && make NO_SYSCALL_TABLE=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.L2v7vi1AQl DESTDIR=/tmp/tmp.wHEA4jEpw9
           make_no_libnuma_O: cd . && make NO_LIBNUMA=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.9N5pQYuRbO DESTDIR=/tmp/tmp.B0Yptb7xP6
           make_util_map_o_O: cd . && make util/map.o FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.B8oe4jnWwB DESTDIR=/tmp/tmp.m0APlsli14
      make_with_babeltrace_O: cd . && make LIBBABELTRACE=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.3G1kLTJLJx DESTDIR=/tmp/tmp.ahuDENSMsz
                make_debug_O: cd . && make DEBUG=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.KpsvOj0KHD DESTDIR=/tmp/tmp.f2Yv9Lrorg
           make_no_libperl_O: cd . && make NO_LIBPERL=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.7tIufwAi4O DESTDIR=/tmp/tmp.vcBv7UYjuw
         make_no_libbionic_O: cd . && make NO_LIBBIONIC=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.HCJA7xCDxq DESTDIR=/tmp/tmp.us5CDSPqyO
                 make_pure_O: cd . && make FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.eg2wCpydvg DESTDIR=/tmp/tmp.MmD1xESO2A
                  make_doc_O: cd . && make doc FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.TqkyGrzRut DESTDIR=/tmp/tmp.ap34IVxoM9
           make_no_scripts_O: cd . && make NO_LIBPYTHON=1 NO_LIBPERL=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.pRWHKzpPhv DESTDIR=/tmp/tmp.dUNhAp2rLt
            make_clean_all_O: cd . && make clean all FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.YnzNLLk9ID DESTDIR=/tmp/tmp.7kXr5obkmA
make_no_libdw_dwarf_unwind_O: cd . && make NO_LIBDW_DWARF_UNWIND=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.GzZCxuYLwR DESTDIR=/tmp/tmp.n3YS9a9DcU
                 make_help_O: cd . && make help FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.t7QwWVHsod DESTDIR=/tmp/tmp.NG5uSWCZzi
          make_no_auxtrace_O: cd . && make NO_AUXTRACE=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.wiDZkJzs8R DESTDIR=/tmp/tmp.ITtPlX0usX
              make_no_gtk2_O: cd . && make NO_GTK2=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.xd1x5QIckJ DESTDIR=/tmp/tmp.f6KzsHHkZH
                 make_tags_O: cd . && make tags FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.e8oSaBuFUb DESTDIR=/tmp/tmp.4czd6ovlSB
OK
make: Leaving directory '/var/home/acme/git/perf/tools/perf'

real	4m29.388s
user	59m6.060s
sys	12m19.581s
⬢[acme@toolbox perf]$

alias m='perf stat -e cycles:u,instructions:u make -k BUILD_BPF_SKEL=1 CORESIGHT=1 PYTHON=python3 O=/tmp/build/perf -C tools/perf install-bin && git status && perf test python'

So 'perf test python' is done after every build, no problems with that
as well.

I'm now making it go thru the container builds.

- Arnaldo


