Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB14B485E44
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 02:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344469AbiAFB4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 20:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344457AbiAFB4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 20:56:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74785C061245;
        Wed,  5 Jan 2022 17:56:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F4E161A24;
        Thu,  6 Jan 2022 01:56:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E938C36AE3;
        Thu,  6 Jan 2022 01:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641434207;
        bh=wAZAhYwocZjEHT8DxarYT4lHarDdUv1uzk//oJPIUvI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m1rj2vEu8/hsfnBoQjbtM0SnF2g0fGTIlAaEbz13Vc1Nf5EdcUpLRo7gvr14vMcF3
         Ev7KtNFJlfD9wg0eY/cB5dEyas//OBdnrTpmlltasrHGGwjaB3U9YQacYyr5cjDJlj
         QnckNKZy1vpny6CTZfNwY0Oc2Jsr++wpjIsXBipeAwK3llUNsJ3uf3t2ftorv08PGx
         4q1lCQYj+13t8ac+J2FGfRfv5w9SG6NnabYmNL1AEr9C3niyHMLjiaORS6wt7p3aFA
         3yiVrZMu0KYKjw7hi3Tvg2cPKeJY8dslXvKidHDo9M94G7OFXHODUdWVbIgZYm/Y2p
         K/EJ4kb3y/kqA==
Date:   Thu, 6 Jan 2022 10:56:39 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     chenzechuan <chenzechuan1@huawei.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        <peterz@infradead.org>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <Jianlin.Lv@arm.com>,
        <ravi.bangoria@linux.ibm.com>, <yao.jin@linux.intel.com>,
        <yangjihong1@huawei.com>, <mpe@ellerman.id.au>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <qiuxi1@huawei.com>, <wangbing6@huawei.com>
Subject: Re: [PATCH] powerpc/perf: fix ppc64 perf probe add events failed
Message-Id: <20220106105639.cd19b55545fad02140b9da07@kernel.org>
In-Reply-To: <8ad8db22-e9af-7e0a-2e39-da99a4a0539a@huawei.com>
References: <20211228111338.218602-1-chenzechuan1@huawei.com>
        <YdG9CSk9ayoVmBhz@kernel.org>
        <8ad8db22-e9af-7e0a-2e39-da99a4a0539a@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jan 2022 10:56:46 +0800
chenzechuan <chenzechuan1@huawei.com> wrote:

> 
> 在 2022/1/2 22:56, Arnaldo Carvalho de Melo 写道:
> > Em Tue, Dec 28, 2021 at 07:13:38PM +0800, Zechuan Chen escreveu:
> >> Because of commit bf794bf52a80 ("powerpc/kprobes: Fix kallsyms lookup
> >> across powerpc ABIv1 and ABIv2"), in ppc64 ABIv1, our perf command
> >> eliminates the need to use the prefix "." at the symbol name. But when
> >> the command "perf probe -a schedule" is executed on ppc64 ABIv1, it
> >> obtains two symbol address information through /proc/kallsyms, for example:
> >>
> >> cat /proc/kallsyms | grep -w schedule
> >> c000000000657020 T .schedule
> >> c000000000d4fdb8 D schedule
> >>
> >> The symbol "D schedule" is not a function symbol, and perf will print:
> >> "p:probe/schedule _text+13958584"Failed to write event: Invalid argument
> >>
> >> Therefore, when searching symbols from map and adding probe point for
> >> them, a symbol type check is added. If the type of symbol is not a
> >> function, skip it.
> >>
> >> Fixes: bf794bf52a80 ("powerpc/kprobes: Fix kallsyms lookup across powerpc ABIv1 and ABIv2")
> >>
> >> Signed-off-by: Zechuan Chen <chenzechuan1@huawei.com>
> >> ---
> >>   tools/perf/util/probe-event.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> >> index b2a02c9ab8ea..a834918a0a0d 100644
> >> --- a/tools/perf/util/probe-event.c
> >> +++ b/tools/perf/util/probe-event.c
> >> @@ -3083,6 +3083,9 @@ static int find_probe_trace_events_from_map(struct perf_probe_event *pev,
> >>   	for (j = 0; j < num_matched_functions; j++) {
> >>   		sym = syms[j];
> >>   
> >> +		if (sym->type != STT_FUNC)
> >> +			continue;
> >> +
> > Humm, shouldn't this be handled by find_probe_functions(), i.e. it
> > shoudn't return data symbols, right? Otherwise other places using this
> > function may malfunction as well?
> >
> > Naveen? Masami?
> >
> > - Arnaldo
> 
> Re：Thanks for your review. You are right.
>      1. Only function symbols should be returned here, not function descriptors.
>         I've moved the modification into function "find_probe_functions()",
>         and the new patch is added at the end of this email. I've re-tested it on my environment.
>         Please review it again, thanks.
> 
>      2. Function find_probe_functions only use in "perf probe".
>         Malfunction exist for all export functions, another example:
> 
>      cat /proc/kallsyms | grep -w sys_fork
>      c000000000058100 T .sys_fork
>      c000000000d485e0 D sys_fork
> 
>      perf probe -a sys_fork -v
>      No kprobe blacklist support, ignored
>      Looking at the vmlinux_path (8 entries long)
>      symsrc__init: cannot get elf header.
>      Could not open debuginfo. Try to use symbols.
>      Looking at the vmlinux_path (8 entries long)
>      symsrc__init: cannot get elf header.
>      Using /proc/kcore for kernel data
>      Using /proc/kallsyms for symbols
>      Opening /sys/kernel/tracing//kprobe_events write=1
>      Opening /sys/kernel/tracing//README write=0
>      Writing event: p:probe/sys_fork _text+360704
>      Writing event: p:probe/sys_fork _text+13927904
>      Failed to write event: Invalid argument
>        Error: Failed to add events. Reason: Invalid argument (Code: -22)
> 
> >>   		/* There can be duplicated symbols in the map */
> >>   		for (i = 0; i < j; i++)
> >>   			if (sym->start == syms[i]->start) {
> >> -- 
> >> 2.12.3
> > .
> 
>  From 8d8f5de99d16e6aa8179ecbc33c0692fc887e2af Mon Sep 17 00:00:00 2001
> From: Zechuan Chen <chenzechuan1@huawei.com>
> Date: Mon, 27 Dec 2021 09:55:11 +0800
> Subject: [PATCH] powerpc/perf: fix ppc64 perf probe add events failed
> 
> Because of commit bf794bf52a80 ("powerpc/kprobes: Fix kallsyms lookup
> across powerpc ABIv1 and ABIv2"), in ppc64 ABIv1, our perf command
> eliminates the need to use the prefix "." at the symbol name. But when
> the command "perf probe -a schedule" is executed on ppc64 ABIv1, it
> obtains two symbol address information through /proc/kallsyms, for example:
> 
> cat /proc/kallsyms | grep -w schedule
> c000000000657020 T .schedule
> c000000000d4fdb8 D schedule
> 
> The symbol "D schedule" is not a function symbol, and perf will print:
> "p:probe/schedule _text+13958584"Failed to write event: Invalid argument
> 
> Therefore, when searching symbols from map and adding probe point for
> them, a symbol type check is added. If the type of symbol is not a
> function, skip it.

OK, this looks good to me. I forgot to check the sym->type :(

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> 
> Fixes: bf794bf52a80 ("powerpc/kprobes: Fix kallsyms lookup across 
> powerpc ABIv1 and ABIv2")
> 
> Signed-off-by: Zechuan Chen <chenzechuan1@huawei.com>
> ---
>   tools/perf/util/probe-event.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index b2a02c9ab8ea..4bd6f438d73c 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -2959,6 +2959,9 @@ static int find_probe_functions(struct map *map, 
> char *name,
>                  cut_version = false;
> 
>          map__for_each_symbol(map, sym, tmp) {
> +               if (sym->type != STT_FUNC)
> +                       continue;
> +
>                  norm = arch__normalize_symbol_name(sym->name);
>                  if (!norm)
>                          continue;
> --
> 2.12.3
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
