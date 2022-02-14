Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E684B5BAB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiBNUxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 15:53:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiBNUxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 15:53:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC33192F32;
        Mon, 14 Feb 2022 12:52:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55B22B81676;
        Mon, 14 Feb 2022 19:45:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE8CCC340E9;
        Mon, 14 Feb 2022 19:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644867955;
        bh=4cKu19CUQjjP0ctay0xc/Jduy9kkgqnkY9pQd62QArE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KCADrosyMNCwkao6AFfBCZhGg4c1Z/2yQdqXzDh5BumNhXkVnuZCl8ehECJRTJk/+
         ZcArc0VlJNrY3IeqrlMNjDFUJGHkagJzqlboUR5+Fwg1ZoufMIudgaqFmJJM8TloYN
         mbA7mgLfynKiiseJYURbmghxWDmeBDlWGD8M0KQs/dI3Zx29o1+Nepg8aLYPMvYJ4m
         V/gq+0AsGrHYQMklCBGeGpRJ5zcG5A90o1gSuNA6kT/x/lOpm0aZFx+bQx3RhrO0wI
         VKbRgHQzyemnleetBAHLbzJEyq8J/BFlubmyau4VHqxRPj0vGjz7+SnPiwFQd7W/KY
         kPrUG3q862C8g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F0CF6400FE; Mon, 14 Feb 2022 16:45:51 -0300 (-03)
Date:   Mon, 14 Feb 2022 16:45:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hao Luo <haoluo@google.com>, eranian@google.com
Subject: Re: [PATCH v3 05/22] perf maps: Use a pointer for kmaps
Message-ID: <Ygqxb4R5arsW2yiD@kernel.org>
References: <20220211103415.2737789-1-irogers@google.com>
 <20220211103415.2737789-6-irogers@google.com>
 <Ygabd1q3G1x19LU3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ygabd1q3G1x19LU3@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 11, 2022 at 02:23:03PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Feb 11, 2022 at 02:33:58AM -0800, Ian Rogers escreveu:
> > struct maps is reference counted, using a pointer is more idiomatic.
> 
> So, I tried to apply this after adding this to the cset comming log to
> make sure reviewers know that this is just a clarifying comming, no code
> change:
> 
> Committer notes:
> 
> Definition of machine__kernel_maps(machine), the replacement of &machine->kmaps
> 
> static inline
> struct maps *machine__kernel_maps(struct machine *machine)
> {
>         return machine->kmaps;
> }
> 
> but then when building on a f34 system I got:
> 
>   CC      /tmp/build/perf/bench/inject-buildid.o
> In file included from /var/home/acme/git/perf/tools/perf/util/build-id.h:10,
>                  from /var/home/acme/git/perf/tools/perf/util/dso.h:13,
>                  from tests/vmlinux-kallsyms.c:8:
> In function ‘machine__kernel_maps’,
>     inlined from ‘test__vmlinux_matches_kallsyms’ at tests/vmlinux-kallsyms.c:122:22:
> /var/home/acme/git/perf/tools/perf/util/machine.h:86:23: error: ‘vmlinux.kmaps’ is used uninitialized [-Werror=uninitialized]
>    86 |         return machine->kmaps;
>       |                ~~~~~~~^~~~~~~
> tests/vmlinux-kallsyms.c: In function ‘test__vmlinux_matches_kallsyms’:
> tests/vmlinux-kallsyms.c:121:34: note: ‘vmlinux’ declared here
>   121 |         struct machine kallsyms, vmlinux;
>       |                                  ^~~~~~~
> cc1: all warnings being treated as errors
> make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/tests/vmlinux-kallsyms.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
>   CC      /tmp/build/perf/util/config.o
>   CC      /tmp/build/perf/arch/x86/util/archinsn.o
>   CC      /tmp/build/perf/arch/x86/util/intel-pt.o
>   CC      /tmp/build/perf/arch/x86/util/intel-bts.o
>   CC      /tmp/build/perf/util/db-export.o
>   CC      /tmp/build/perf/util/event.o
> make[3]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:139: tests] Error 2
> make[3]: *** Waiting for unfinished jobs....
> 
> Can you please  take a look at that?

I'm applying this on top:

diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 84bf5f64006560f5..93dee542a177ed1d 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -119,7 +119,7 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 	struct symbol *sym;
 	struct map *kallsyms_map, *vmlinux_map, *map;
 	struct machine kallsyms, vmlinux;
-	struct maps *maps = machine__kernel_maps(&vmlinux);
+	struct maps *maps;
 	u64 mem_start, mem_end;
 	bool header_printed;
 
@@ -132,6 +132,8 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 	machine__init(&kallsyms, "", HOST_KERNEL_ID);
 	machine__init(&vmlinux, "", HOST_KERNEL_ID);
 
+	maps = machine__kernel_maps(&vmlinux);
+
 	/*
 	 * Step 2:
 	 *
