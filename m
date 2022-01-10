Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36AF48A1D3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 22:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343901AbiAJVXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 16:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241601AbiAJVXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 16:23:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A99C06173F;
        Mon, 10 Jan 2022 13:23:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B89061411;
        Mon, 10 Jan 2022 21:23:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3265AC36AE3;
        Mon, 10 Jan 2022 21:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641849792;
        bh=T9STf5hUbuB72JEkabZ1MTPiweQMf+1BwcjOmv6V1bc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HoL751Cw9VmnYLk760NDJxU3pkRbkUHgUXybd56l0VVq/KLDM5r4QI+hBZoMmftuC
         noQLxy8wRCeeUceikQkLHA35zCX1PrBS7tZhYcyksF4I/jRPusWkReN3+5ljiiQOjn
         eSiNr4zm9t4skSBpYGpm5fSYDVgFcA9LF8n3PX6MkvoXolPZPuioPhrBI65i4YJJJa
         3bfhMWthqt6AK43hyM00issEvIPfCuXWQRjzZqbIyK82BwQmlTHg1K4Dz8FmBVoGDQ
         VDSCt8OLUdE6krLryBTSjmV5gxFE6Pe3e807cjN7M26ZN0Pte4Kpm213H0b9HHzImR
         6Ld68IJQ8xaSQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7BE9240714; Mon, 10 Jan 2022 18:23:09 -0300 (-03)
Date:   Mon, 10 Jan 2022 18:23:09 -0300
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
Subject: Re: [PATCH v3 06/48] perf cpumap: Switch cpu_map__build_map to cpu
 function
Message-ID: <Ydyjvcma/wMTPwbn@kernel.org>
References: <20211230072030.302559-1-irogers@google.com>
 <20211230072030.302559-8-irogers@google.com>
 <YdybPJKjqx6zb28/@kernel.org>
 <YdyfCN1/JWJtJHTO@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdyfCN1/JWJtJHTO@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 10, 2022 at 06:03:04PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Jan 10, 2022 at 05:46:52PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Wed, Dec 29, 2021 at 11:19:48PM -0800, Ian Rogers escreveu:
> > > Avoid error prone cpu_map + idx variant. Remove now unused functions.
> > 
> > At this point we need to remove the now unused perf_env__get_cpu(), and
> > then deal with the fallout in the following patches that needlessly
> > modify this unused function.
> > 
> > Doing that now.
> 
> Done, force pushed to tmp.perf/perf_cpu, now it is going again thru the
> build containers, a better start now:
> 
> [perfbuilder@five ~]$ export BUILD_TARBALL=http://192.168.100.2/perf/perf-5.16.0.tar.xz
> [perfbuilder@five ~]$ time dm
>    1    95.61 almalinux:8                   : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4) , clang version 12.0.1 (Red Hat 12.0.1-4.module_el8.5.0+1025+93159d6c)
>    2    56.18 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0 , clang version 3.8.0 (tags/RELEASE_380/final)
>    3: alpine:3.5
> 

So far so good:

[perfbuilder@five ~]$ export BUILD_TARBALL=http://192.168.100.2/perf/perf-5.16.0.tar.xz
[perfbuilder@five ~]$ time dm
   1    95.61 almalinux:8                   : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4) , clang version 12.0.1 (Red Hat 12.0.1-4.module_el8.5.0+1025+93159d6c)
   2    56.18 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0 , clang version 3.8.0 (tags/RELEASE_380/final)
   3    54.98 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822 , clang version 3.8.1 (tags/RELEASE_381/final)
   4    57.69 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0 , clang version 4.0.0 (tags/RELEASE_400/final)
   5    63.62 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
   6    64.52 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
   7    66.54 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
   8    91.91 alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
   9   104.93 alpine:3.11                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 9.0.0 (https://git.alpinelinux.org/aports f7f0d2c2b8bcd6a5843401a9a702029556492689) (based on LLVM 9.0.0)
  10   107.97 alpine:3.12                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 10.0.0 (https://gitlab.alpinelinux.org/alpine/aports.git 7445adce501f8473efdb93b17b5eaf2f1445ed4c)
  11   115.98 alpine:3.13                   : Ok   gcc (Alpine 10.2.1_pre1) 10.2.1 20201203 , Alpine clang version 10.0.1
  12   101.73 alpine:3.14                   : Ok   gcc (Alpine 10.3.1_git20210424) 10.3.1 20210424 , Alpine clang version 11.1.0
  13   103.35 alpine:3.15                   : Ok   gcc (Alpine 10.3.1_git20211027) 10.3.1 20211027 , Alpine clang version 12.0.1
  14   104.43 alpine:edge                   : Ok   gcc (Alpine 11.2.1_git20211128) 11.2.1 20211128 , Alpine clang version 12.0.1
  15    51.06 alt:p8                        : Ok   x86_64-alt-linux-gcc (GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1) , clang version 3.8.0 (tags/RELEASE_380/final)

Building with:

build_perf_gcc() {
	set -o xtrace
	make $EXTRA_MAKE_ARGS ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE EXTRA_CFLAGS="$EXTRA_CFLAGS" -C tools/perf O=/tmp/build/perf || exit 1
	rm -rf /tmp/build/perf ; mkdir /tmp/build/perf
	make $EXTRA_MAKE_ARGS ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE EXTRA_CFLAGS="$EXTRA_CFLAGS" NO_LIBELF=1 -C tools/perf O=/tmp/build/perf || exit 1
	rm -rf /tmp/build/perf ; mkdir /tmp/build/perf
	make $EXTRA_MAKE_ARGS ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE EXTRA_CFLAGS="$EXTRA_CFLAGS" NO_LIBBPF=1 -C tools/perf O=/tmp/build/perf || exit 1
	if [ -d /usr/include/traceevent/ ] ; then
		make $EXTRA_MAKE_ARGS ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE EXTRA_CFLAGS="$EXTRA_CFLAGS" LIBTRACEEVENT_DYNAMIC=1 -C tools/perf O=/tmp/build/perf || exit 1
	fi
	set +o xtrace
}

build_perf_clang() {
	set -o xtrace

	if [ ! $NO_BUILD_BPF_SKEL ] ; then
		rm -rf /tmp/build/perf ; mkdir /tmp/build/perf
		make $EXTRA_MAKE_ARGS ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE EXTRA_CFLAGS="$EXTRA_CFLAGS" BUILD_BPF_SKEL=1 -C tools/perf O=/tmp/build/perf || exit 1
	fi

	rm -rf /tmp/build/perf ; mkdir /tmp/build/perf
	make $EXTRA_MAKE_ARGS ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE EXTRA_CFLAGS="$EXTRA_CFLAGS" -C tools/perf O=/tmp/build/perf CC=clang || exit 1
	rm -rf /tmp/build/perf ; mkdir /tmp/build/perf
	make $EXTRA_MAKE_ARGS ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE EXTRA_CFLAGS="$EXTRA_CFLAGS" NO_LIBELF=1 -C tools/perf O=/tmp/build/perf CC=clang || exit 1
	rm -rf /tmp/build/perf ; mkdir /tmp/build/perf
	make $EXTRA_MAKE_ARGS ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE EXTRA_CFLAGS="$EXTRA_CFLAGS" NO_LIBBPF=1 -C tools/perf O=/tmp/build/perf CC=clang || exit 1
	rm -rf /tmp/build/perf ; mkdir /tmp/build/perf
	make $EXTRA_MAKE_ARGS ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE EXTRA_CFLAGS="$EXTRA_CFLAGS" LIBCLANGLLVM=1 -C tools/perf O=/tmp/build/perf CC=clang || exit 1
	rm -rf /tmp/build/perf ; mkdir /tmp/build/perf
	make $EXTRA_MAKE_ARGS ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE EXTRA_CFLAGS="$EXTRA_CFLAGS" LIBCLANGLLVM=1 -C tools/perf O=/tmp/build/perf || exit 1
	if [ -d /usr/include/traceevent/ ] ; then
		make $EXTRA_MAKE_ARGS ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE EXTRA_CFLAGS="$EXTRA_CFLAGS" LIBTRACEEVENT_DYNAMIC=1 -C tools/perf O=/tmp/build/perf || exit 1
	fi
	set +o xtrace
}
