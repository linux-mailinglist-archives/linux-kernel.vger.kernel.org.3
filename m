Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F437484C9A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 03:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235926AbiAEC4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 21:56:50 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:31069 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiAEC4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 21:56:49 -0500
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JTDZ85B39z1DKRp;
        Wed,  5 Jan 2022 10:53:20 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 5 Jan 2022 10:56:47 +0800
Received: from [10.67.109.79] (10.67.109.79) by dggpemm500017.china.huawei.com
 (7.185.36.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 5 Jan
 2022 10:56:46 +0800
Message-ID: <8ad8db22-e9af-7e0a-2e39-da99a4a0539a@huawei.com>
Date:   Wed, 5 Jan 2022 10:56:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] powerpc/perf: fix ppc64 perf probe add events failed
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <Jianlin.Lv@arm.com>,
        <ravi.bangoria@linux.ibm.com>, <yao.jin@linux.intel.com>,
        <yangjihong1@huawei.com>, <mpe@ellerman.id.au>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <qiuxi1@huawei.com>, <wangbing6@huawei.com>
References: <20211228111338.218602-1-chenzechuan1@huawei.com>
 <YdG9CSk9ayoVmBhz@kernel.org>
From:   chenzechuan <chenzechuan1@huawei.com>
In-Reply-To: <YdG9CSk9ayoVmBhz@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.79]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/1/2 22:56, Arnaldo Carvalho de Melo 写道:
> Em Tue, Dec 28, 2021 at 07:13:38PM +0800, Zechuan Chen escreveu:
>> Because of commit bf794bf52a80 ("powerpc/kprobes: Fix kallsyms lookup
>> across powerpc ABIv1 and ABIv2"), in ppc64 ABIv1, our perf command
>> eliminates the need to use the prefix "." at the symbol name. But when
>> the command "perf probe -a schedule" is executed on ppc64 ABIv1, it
>> obtains two symbol address information through /proc/kallsyms, for example:
>>
>> cat /proc/kallsyms | grep -w schedule
>> c000000000657020 T .schedule
>> c000000000d4fdb8 D schedule
>>
>> The symbol "D schedule" is not a function symbol, and perf will print:
>> "p:probe/schedule _text+13958584"Failed to write event: Invalid argument
>>
>> Therefore, when searching symbols from map and adding probe point for
>> them, a symbol type check is added. If the type of symbol is not a
>> function, skip it.
>>
>> Fixes: bf794bf52a80 ("powerpc/kprobes: Fix kallsyms lookup across powerpc ABIv1 and ABIv2")
>>
>> Signed-off-by: Zechuan Chen <chenzechuan1@huawei.com>
>> ---
>>   tools/perf/util/probe-event.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
>> index b2a02c9ab8ea..a834918a0a0d 100644
>> --- a/tools/perf/util/probe-event.c
>> +++ b/tools/perf/util/probe-event.c
>> @@ -3083,6 +3083,9 @@ static int find_probe_trace_events_from_map(struct perf_probe_event *pev,
>>   	for (j = 0; j < num_matched_functions; j++) {
>>   		sym = syms[j];
>>   
>> +		if (sym->type != STT_FUNC)
>> +			continue;
>> +
> Humm, shouldn't this be handled by find_probe_functions(), i.e. it
> shoudn't return data symbols, right? Otherwise other places using this
> function may malfunction as well?
>
> Naveen? Masami?
>
> - Arnaldo

Re：Thanks for your review. You are right.
     1. Only function symbols should be returned here, not function descriptors.
        I've moved the modification into function "find_probe_functions()",
        and the new patch is added at the end of this email. I've re-tested it on my environment.
        Please review it again, thanks.

     2. Function find_probe_functions only use in "perf probe".
        Malfunction exist for all export functions, another example:

     cat /proc/kallsyms | grep -w sys_fork
     c000000000058100 T .sys_fork
     c000000000d485e0 D sys_fork

     perf probe -a sys_fork -v
     No kprobe blacklist support, ignored
     Looking at the vmlinux_path (8 entries long)
     symsrc__init: cannot get elf header.
     Could not open debuginfo. Try to use symbols.
     Looking at the vmlinux_path (8 entries long)
     symsrc__init: cannot get elf header.
     Using /proc/kcore for kernel data
     Using /proc/kallsyms for symbols
     Opening /sys/kernel/tracing//kprobe_events write=1
     Opening /sys/kernel/tracing//README write=0
     Writing event: p:probe/sys_fork _text+360704
     Writing event: p:probe/sys_fork _text+13927904
     Failed to write event: Invalid argument
       Error: Failed to add events. Reason: Invalid argument (Code: -22)

>>   		/* There can be duplicated symbols in the map */
>>   		for (i = 0; i < j; i++)
>>   			if (sym->start == syms[i]->start) {
>> -- 
>> 2.12.3
> .

 From 8d8f5de99d16e6aa8179ecbc33c0692fc887e2af Mon Sep 17 00:00:00 2001
From: Zechuan Chen <chenzechuan1@huawei.com>
Date: Mon, 27 Dec 2021 09:55:11 +0800
Subject: [PATCH] powerpc/perf: fix ppc64 perf probe add events failed

Because of commit bf794bf52a80 ("powerpc/kprobes: Fix kallsyms lookup
across powerpc ABIv1 and ABIv2"), in ppc64 ABIv1, our perf command
eliminates the need to use the prefix "." at the symbol name. But when
the command "perf probe -a schedule" is executed on ppc64 ABIv1, it
obtains two symbol address information through /proc/kallsyms, for example:

cat /proc/kallsyms | grep -w schedule
c000000000657020 T .schedule
c000000000d4fdb8 D schedule

The symbol "D schedule" is not a function symbol, and perf will print:
"p:probe/schedule _text+13958584"Failed to write event: Invalid argument

Therefore, when searching symbols from map and adding probe point for
them, a symbol type check is added. If the type of symbol is not a
function, skip it.

Fixes: bf794bf52a80 ("powerpc/kprobes: Fix kallsyms lookup across 
powerpc ABIv1 and ABIv2")

Signed-off-by: Zechuan Chen <chenzechuan1@huawei.com>
---
  tools/perf/util/probe-event.c | 3 +++
  1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index b2a02c9ab8ea..4bd6f438d73c 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2959,6 +2959,9 @@ static int find_probe_functions(struct map *map, 
char *name,
                 cut_version = false;

         map__for_each_symbol(map, sym, tmp) {
+               if (sym->type != STT_FUNC)
+                       continue;
+
                 norm = arch__normalize_symbol_name(sym->name);
                 if (!norm)
                         continue;
--
2.12.3

