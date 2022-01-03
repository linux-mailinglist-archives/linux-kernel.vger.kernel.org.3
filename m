Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D06E482EEF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 09:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbiACINa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 03:13:30 -0500
Received: from mga02.intel.com ([134.134.136.20]:63286 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232105AbiACIN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 03:13:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641197609; x=1672733609;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ZZCWb0XiWXEAsImjHyIkC1Uo5lepp0D+B41XGAD7mgY=;
  b=SXLu3Ah3W/RUvWyqx3ISCHu+OGEQdo4cEYWEXV28xMNHJmCSLta2zKKW
   0/zO85LSJGd3560IV2PABYrhdr7lWH6da0qGngZ5+gA0qqXzMBMTHwvWb
   k32QW4HHH4bM8FwHBovM9MULkV+Qp0b9AJYdKg2+zyWmq1acI0CYY4iub
   +r6JjTSo+baJIq8E/JE2odmd7v1iR249MUDa2QgyGNspjtbWaM5KTOzNj
   0zRYuTWj6mlFY6jaRbgsJKBRVLI2bk2j/+GtDFsUs7V7leEuu5Vol9KJ4
   PFfnZIuhG46j6ZlCD85MsoPn5wmm1zZ+qqSmT0jr48DIuJU8uxs3vJjra
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10215"; a="229339620"
X-IronPort-AV: E=Sophos;i="5.88,257,1635231600"; 
   d="scan'208";a="229339620"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 00:13:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,257,1635231600"; 
   d="scan'208";a="525477700"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.92]) ([10.237.72.92])
  by orsmga008.jf.intel.com with ESMTP; 03 Jan 2022 00:13:25 -0800
Subject: Re: [PATCH 0/6] x86/insn: Add instructions to instruction decoder
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        H Peter Anvin <hpa@zytor.com>, chang.seok.bae@intel.com,
        Masami Hiramatsu <mhiramat@kernel.org>
References: <20211202095029.2165714-1-adrian.hunter@intel.com>
 <20211223153808.cddab56b114e5ddf755bd2d0@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <c5737eb6-383b-13ea-20d1-af597c69a21d@intel.com>
Date:   Mon, 3 Jan 2022 10:13:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211223153808.cddab56b114e5ddf755bd2d0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/12/2021 08:38, Masami Hiramatsu wrote:
> Hi,
> 
> Sorry, I missed this series.
> 
> On Thu,  2 Dec 2021 11:50:23 +0200
> Adrian Hunter <adrian.hunter@intel.com> wrote:
> 
>> Hi
>>
>> Here are patches to bring the kernel and tools x86 instruction decoder
>> more up to date.
>>
>> x86 instruction decoder is used for both kernel instructions and user space
>> instructions (e.g. uprobes, perf tools Intel PT), so it is good to update
>> it with new instructions.
> 
> Hmm, I thought perf used objdump for that purpose internally.
> Anyway, this series looks good to me. I'm a bit surprised that the
> insn decoder can actually support those instructions only changing
> X86_EVEX_M() macro :-)
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Thank you!

Thanks!

Arnaldo, could you consider taking these patches?

> 
>>
>>
>> Adrian Hunter (6):
>>       perf tests: Add AMX instructions to x86 instruction decoder test
>>       x86/insn: Add AMX instructions to x86 instruction decoder
>>       perf tests: Add misc instructions to x86 instruction decoder test
>>       x86/insn: Add misc instructions to x86 instruction decoder
>>       perf tests: Add AVX512-FP16 instructions to x86 instruction decoder test
>>       x86/insn: Add AVX512-FP16 instructions to x86 instruction decoder
>>
>>  arch/x86/include/asm/insn.h                  |    2 +-
>>  arch/x86/lib/x86-opcode-map.txt              |  111 +-
>>  tools/arch/x86/include/asm/insn.h            |    2 +-
>>  tools/arch/x86/lib/x86-opcode-map.txt        |  111 +-
>>  tools/perf/arch/x86/tests/insn-x86-dat-32.c  |  918 +++++++++++++++++
>>  tools/perf/arch/x86/tests/insn-x86-dat-64.c  | 1426 ++++++++++++++++++++++++++
>>  tools/perf/arch/x86/tests/insn-x86-dat-src.c | 1189 +++++++++++++++++++++
>>  7 files changed, 3731 insertions(+), 28 deletions(-)
>>
>>
>> Regards
>> Adrian
> 
> 

