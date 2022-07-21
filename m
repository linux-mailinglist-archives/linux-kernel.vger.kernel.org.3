Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9AFF57D3CC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 21:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiGUTGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 15:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGUTF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 15:05:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372A2140F4;
        Thu, 21 Jul 2022 12:05:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE3F9B82646;
        Thu, 21 Jul 2022 19:05:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF6FC3411E;
        Thu, 21 Jul 2022 19:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658430355;
        bh=/cYlqnnP2Keta3V+NNEZPfIrCOKOCQmj26TBYnq1Ej4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VrIHZzx6nWKSO9yerce/vXNXa/9EMhq3eYDNE98yPitgRQ9a9tMIGkwpNqeulBflD
         F/3yjGAudhhgvRB7ga6MA0ezF98T/CVPZGdHUGVotgnv1RvILRT7jIt1/Ho4XFKQvQ
         mzYnuXZjdLadU2LKTghsthJ1gF2+wGuSoUUqWiwQXXHe4Owm5V6fXEr/zWvDA+2gr7
         MEoEsrd+hEGtmNEANtY/ryQQ3f/tyCUQ3QygcNnyh/m0ZaObkDl/nQnKCkHBezfgrE
         2+QQTBXd8sE7Zk5cETus5RG55gZeDqYI/mxcGsUV1OxeEN0+LcYoPBDnRrGq3Oe2G3
         zTqc7tVthMW/A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A092D40374; Thu, 21 Jul 2022 16:05:52 -0300 (-03)
Date:   Thu, 21 Jul 2022 16:05:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH 3/6] perf lock: Add lock aggregation enum
Message-ID: <YtmjkCbvemjvlPBN@kernel.org>
References: <20220721043644.153718-1-namhyung@kernel.org>
 <20220721043644.153718-4-namhyung@kernel.org>
 <Ytmi4otIpXA+zNSx@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ytmi4otIpXA+zNSx@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jul 21, 2022 at 04:02:58PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Jul 20, 2022 at 09:36:41PM -0700, Namhyung Kim escreveu:
> > Introduce the aggr_mode variable to prepare the later code change.
> > The default is LOCK_AGGR_ADDR which aggregate the result for the lock
> > instances.  When -t/--threads option is given, it'd be set to
> > LOCK_AGGR_TASK.  The LOCK_AGGR_CALLER is for the contention analysis
> > and it'd aggregate the stat by comparing the callstacks.
> 
> builtin-lock.c: In function ‘report_lock_contention_end_event’:
> builtin-lock.c:1113:13: error: variable ‘key’ set but not used [-Werror=unused-but-set-variable]
>  1113 |         u64 key;
>       |             ^~~
> cc1: all warnings being treated as errors
> 
> 
> trying to fix

Please take a look at this:

builtin-lock.c: In function ‘report_lock_contention_end_event’:
builtin-lock.c:1113:13: error: variable ‘key’ set but not used [-Werror=unused-but-set-variable]
 1113 |         u64 key;
      |             ^~~
cc1: all warnings being treated as errors
make[3]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/builtin-lock.o] Error 1
make[2]: *** [Makefile.perf:660: /tmp/build/perf/perf-in.o] Error 2
make[1]: *** [Makefile.perf:240: sub-make] Error 2
make: *** [Makefile:113: install-bin] Error 2
make: Leaving directory '/var/home/acme/git/perf/tools/perf'

 Performance counter stats for 'make -k BUILD_BPF_SKEL=1 CORESIGHT=1 PYTHON=python3 O=/tmp/build/perf -C tools/perf install-bin':

     6,642,782,729      cycles:u
    12,246,940,928      instructions:u            #    1.84  insn per cycle

       2.513486078 seconds time elapsed

       1.649124000 seconds user
       1.272055000 seconds sys


⬢[acme@toolbox perf]$ gcc -v
Using built-in specs.
COLLECT_GCC=/usr/bin/gcc
COLLECT_LTO_WRAPPER=/usr/libexec/gcc/x86_64-redhat-linux/12/lto-wrapper
OFFLOAD_TARGET_NAMES=nvptx-none
OFFLOAD_TARGET_DEFAULT=1
Target: x86_64-redhat-linux
Configured with: ../configure --enable-bootstrap --enable-languages=c,c++,fortran,objc,obj-c++,ada,go,d,lto --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --with-bugurl=http://bugzilla.redhat.com/bugzilla --enable-shared --enable-threads=posix --enable-checking=release --enable-multilib --with-system-zlib --enable-__cxa_atexit --disable-libunwind-exceptions --enable-gnu-unique-object --enable-linker-build-id --with-gcc-major-version-only --enable-libstdcxx-backtrace --with-linker-hash-style=gnu --enable-plugin --enable-initfini-array --with-isl=/builddir/build/BUILD/gcc-12.1.1-20220507/obj-x86_64-redhat-linux/isl-install --enable-offload-targets=nvptx-none --without-cuda-driver --enable-offload-defaulted --enable-gnu-indirect-function --enable-cet --with-tune=generic --with-arch_32=i686 --build=x86_64-redhat-linux --with-build-config=bootstrap-lto --enable-link-serialization=1
Thread model: posix
Supported LTO compression algorithms: zlib zstd
gcc version 12.1.1 20220507 (Red Hat 12.1.1-1) (GCC)
⬢[acme@toolbox perf]$ cat /etc/fedora-release
Fedora release 36 (Thirty Six)
⬢[acme@toolbox perf]$
  
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/builtin-lock.c | 112 +++++++++++++++++++++++++++++++-------
> >  1 file changed, 93 insertions(+), 19 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> > index 1de459198b99..551bad905139 100644
> > --- a/tools/perf/builtin-lock.c
> > +++ b/tools/perf/builtin-lock.c
> > @@ -126,6 +126,12 @@ static struct rb_root		thread_stats;
> >  static bool combine_locks;
> >  static bool show_thread_stats;
> >  
> > +static enum {
> > +	LOCK_AGGR_ADDR,
> > +	LOCK_AGGR_TASK,
> > +	LOCK_AGGR_CALLER,
> > +} aggr_mode = LOCK_AGGR_ADDR;
> > +
> >  /*
> >   * CONTENTION_STACK_DEPTH
> >   * Number of stack trace entries to find callers
> > @@ -622,12 +628,22 @@ static int report_lock_acquire_event(struct evsel *evsel,
> >  	const char *name = evsel__strval(evsel, sample, "name");
> >  	u64 addr = evsel__intval(evsel, sample, "lockdep_addr");
> >  	int flag = evsel__intval(evsel, sample, "flags");
> > +	u64 key;
> >  
> > -	/* abuse ls->addr for tid */
> > -	if (show_thread_stats)
> > -		addr = sample->tid;
> > +	switch (aggr_mode) {
> > +	case LOCK_AGGR_ADDR:
> > +		key = addr;
> > +		break;
> > +	case LOCK_AGGR_TASK:
> > +		key = sample->tid;
> > +		break;
> > +	case LOCK_AGGR_CALLER:
> > +	default:
> > +		pr_err("Invalid aggregation mode: %d\n", aggr_mode);
> > +		return -EINVAL;
> > +	}
> >  
> > -	ls = lock_stat_findnew(addr, name, 0);
> > +	ls = lock_stat_findnew(key, name, 0);
> >  	if (!ls)
> >  		return -ENOMEM;
> >  
> > @@ -695,11 +711,22 @@ static int report_lock_acquired_event(struct evsel *evsel,
> >  	u64 contended_term;
> >  	const char *name = evsel__strval(evsel, sample, "name");
> >  	u64 addr = evsel__intval(evsel, sample, "lockdep_addr");
> > +	u64 key;
> >  
> > -	if (show_thread_stats)
> > -		addr = sample->tid;
> > +	switch (aggr_mode) {
> > +	case LOCK_AGGR_ADDR:
> > +		key = addr;
> > +		break;
> > +	case LOCK_AGGR_TASK:
> > +		key = sample->tid;
> > +		break;
> > +	case LOCK_AGGR_CALLER:
> > +	default:
> > +		pr_err("Invalid aggregation mode: %d\n", aggr_mode);
> > +		return -EINVAL;
> > +	}
> >  
> > -	ls = lock_stat_findnew(addr, name, 0);
> > +	ls = lock_stat_findnew(key, name, 0);
> >  	if (!ls)
> >  		return -ENOMEM;
> >  
> > @@ -757,11 +784,22 @@ static int report_lock_contended_event(struct evsel *evsel,
> >  	struct lock_seq_stat *seq;
> >  	const char *name = evsel__strval(evsel, sample, "name");
> >  	u64 addr = evsel__intval(evsel, sample, "lockdep_addr");
> > +	u64 key;
> >  
> > -	if (show_thread_stats)
> > -		addr = sample->tid;
> > +	switch (aggr_mode) {
> > +	case LOCK_AGGR_ADDR:
> > +		key = addr;
> > +		break;
> > +	case LOCK_AGGR_TASK:
> > +		key = sample->tid;
> > +		break;
> > +	case LOCK_AGGR_CALLER:
> > +	default:
> > +		pr_err("Invalid aggregation mode: %d\n", aggr_mode);
> > +		return -EINVAL;
> > +	}
> >  
> > -	ls = lock_stat_findnew(addr, name, 0);
> > +	ls = lock_stat_findnew(key, name, 0);
> >  	if (!ls)
> >  		return -ENOMEM;
> >  
> > @@ -812,11 +850,22 @@ static int report_lock_release_event(struct evsel *evsel,
> >  	struct lock_seq_stat *seq;
> >  	const char *name = evsel__strval(evsel, sample, "name");
> >  	u64 addr = evsel__intval(evsel, sample, "lockdep_addr");
> > +	u64 key;
> >  
> > -	if (show_thread_stats)
> > -		addr = sample->tid;
> > +	switch (aggr_mode) {
> > +	case LOCK_AGGR_ADDR:
> > +		key = addr;
> > +		break;
> > +	case LOCK_AGGR_TASK:
> > +		key = sample->tid;
> > +		break;
> > +	case LOCK_AGGR_CALLER:
> > +	default:
> > +		pr_err("Invalid aggregation mode: %d\n", aggr_mode);
> > +		return -EINVAL;
> > +	}
> >  
> > -	ls = lock_stat_findnew(addr, name, 0);
> > +	ls = lock_stat_findnew(key, name, 0);
> >  	if (!ls)
> >  		return -ENOMEM;
> >  
> > @@ -980,11 +1029,22 @@ static int report_lock_contention_begin_event(struct evsel *evsel,
> >  	struct thread_stat *ts;
> >  	struct lock_seq_stat *seq;
> >  	u64 addr = evsel__intval(evsel, sample, "lock_addr");
> > +	u64 key;
> >  
> > -	if (show_thread_stats)
> > -		addr = sample->tid;
> > +	switch (aggr_mode) {
> > +	case LOCK_AGGR_ADDR:
> > +		key = addr;
> > +		break;
> > +	case LOCK_AGGR_TASK:
> > +		key = sample->tid;
> > +		break;
> > +	case LOCK_AGGR_CALLER:
> > +	default:
> > +		pr_err("Invalid aggregation mode: %d\n", aggr_mode);
> > +		return -EINVAL;
> > +	}
> >  
> > -	ls = lock_stat_find(addr);
> > +	ls = lock_stat_find(key);
> >  	if (!ls) {
> >  		char buf[128];
> >  		const char *caller = buf;
> > @@ -993,7 +1053,7 @@ static int report_lock_contention_begin_event(struct evsel *evsel,
> >  		if (lock_contention_caller(evsel, sample, buf, sizeof(buf)) < 0)
> >  			caller = "Unknown";
> >  
> > -		ls = lock_stat_findnew(addr, caller, flags);
> > +		ls = lock_stat_findnew(key, caller, flags);
> >  		if (!ls)
> >  			return -ENOMEM;
> >  	}
> > @@ -1050,9 +1110,20 @@ static int report_lock_contention_end_event(struct evsel *evsel,
> >  	struct lock_seq_stat *seq;
> >  	u64 contended_term;
> >  	u64 addr = evsel__intval(evsel, sample, "lock_addr");
> > +	u64 key;
> >  
> > -	if (show_thread_stats)
> > -		addr = sample->tid;
> > +	switch (aggr_mode) {
> > +	case LOCK_AGGR_ADDR:
> > +		key = addr;
> > +		break;
> > +	case LOCK_AGGR_TASK:
> > +		key = sample->tid;
> > +		break;
> > +	case LOCK_AGGR_CALLER:
> > +	default:
> > +		pr_err("Invalid aggregation mode: %d\n", aggr_mode);
> > +		return -EINVAL;
> > +	}
> >  
> >  	ls = lock_stat_find(addr);
> >  	if (!ls)
> > @@ -1416,6 +1487,9 @@ static int __cmd_report(bool display_info)
> >  	if (select_key())
> >  		goto out_delete;
> >  
> > +	if (show_thread_stats)
> > +		aggr_mode = LOCK_AGGR_TASK;
> > +
> >  	err = perf_session__process_events(session);
> >  	if (err)
> >  		goto out_delete;
> > -- 
> > 2.37.0.170.g444d1eabd0-goog
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
