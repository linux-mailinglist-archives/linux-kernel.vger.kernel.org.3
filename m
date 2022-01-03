Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC92483459
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 16:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbiACPkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 10:40:05 -0500
Received: from mga04.intel.com ([192.55.52.120]:58028 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232717AbiACPkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 10:40:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641224404; x=1672760404;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=qXCyLqVDNwxH8Zr1q5G6Jk/cwa0kQx/JhvfRtQx9Sno=;
  b=Z31eh82ZtK4psFXaSOdicNfBLWgqAxNC/GyQIpStHE8Aj+qFWx2h4E7T
   8A4shs9U/JvCXeMEKb7CupX9s7o4/jv33NBeOFxhNxCIa6iEgGOD03M5q
   HWd+fddGXli6RCLXy8KzrDCIV2WdmIo1FqxKOFtmP28APWYOGBOvf0GeO
   wrnCI3+n4f+7LSdRHT98lKMBq/rsVX/6b9zw5sOgVckCpJLwS63Wb1rlW
   ScBzfod0pqZSB/i44+dm58r5KFZ3eYntzxzxTZbHIsqJILN4/7OBnK6L9
   UJHxBY6nd73zfi9VJjChLg+BF/t1US9/BLN3dja+5TwzZQXpMBx7EviJA
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10215"; a="240900368"
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="240900368"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 07:40:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="610790443"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.92]) ([10.237.72.92])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Jan 2022 07:40:00 -0800
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
 <c5737eb6-383b-13ea-20d1-af597c69a21d@intel.com>
 <YdMOiFDdEny4Jicc@kernel.org> <YdMP5vmU+uqMz04d@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <c7ac518e-82fb-eb51-7778-5e9b1aaed9a9@intel.com>
Date:   Mon, 3 Jan 2022 17:40:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YdMP5vmU+uqMz04d@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2022 17:01, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jan 03, 2022 at 11:56:08AM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Mon, Jan 03, 2022 at 10:13:24AM +0200, Adrian Hunter escreveu:
>>> On 23/12/2021 08:38, Masami Hiramatsu wrote:
>>>> Hi,
>>>>
>>>> Sorry, I missed this series.
>>>>
>>>> On Thu,  2 Dec 2021 11:50:23 +0200
>>>> Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>
>>>>> Hi
>>>>>
>>>>> Here are patches to bring the kernel and tools x86 instruction decoder
>>>>> more up to date.
>>>>>
>>>>> x86 instruction decoder is used for both kernel instructions and user space
>>>>> instructions (e.g. uprobes, perf tools Intel PT), so it is good to update
>>>>> it with new instructions.
>>>>
>>>> Hmm, I thought perf used objdump for that purpose internally.
>>>> Anyway, this series looks good to me. I'm a bit surprised that the
>>>> insn decoder can actually support those instructions only changing
>>>> X86_EVEX_M() macro :-)
>>>>
>>>> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
>>>>
>>>> Thank you!
>>>
>>> Thanks!
>>>
>>> Arnaldo, could you consider taking these patches?
>>
>> I can pick the tools/ bits, the arch/x86/ should go via PeterZ, right?
>> Peter?
> 
> I tried applying the whole shebang and got:
> 
> ⬢[acme@toolbox perf]$ git am ./20211202_adrian_hunter_x86_insn_add_instructions_to_instruction_decoder.mbx
> Applying: perf tests: Add AMX instructions to x86 instruction decoder test
> Applying: x86/insn: Add AMX instructions to x86 instruction decoder
> Applying: perf tests: Add misc instructions to x86 instruction decoder test
> Applying: x86/insn: Add misc instructions to x86 instruction decoder
> Applying: perf tests: Add AVX512-FP16 instructions to x86 instruction decoder test
> Applying: x86/insn: Add AVX512-FP16 instructions to x86 instruction decoder
> error: patch failed: arch/x86/lib/x86-opcode-map.txt:896
> error: arch/x86/lib/x86-opcode-map.txt: patch does not apply
> Patch failed at 0006 x86/insn: Add AVX512-FP16 instructions to x86 instruction decoder
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> ⬢[acme@toolbox perf]$
> 
> So since this needs rebasing, could you please split it into two
> patchsets, one for tools/ and another for arch and send two batches?
> This way I'll pick the tools/ one, the x86 maintainers the other bits.
> 
> Otherwise the x86 maintainers would have to test if the tools/ bits
> works as expected, etc.

It seems not to be happening for me.  What tree/branch is it?
