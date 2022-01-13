Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F8648D275
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 07:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiAMGxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 01:53:03 -0500
Received: from mga05.intel.com ([192.55.52.43]:41348 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230110AbiAMGxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 01:53:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642056782; x=1673592782;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=yXR+RYuHNCX0ZwhyDKCjpNIia1mWy/y6asw3XkYxBVM=;
  b=D7rT00WixhhtPczCKayUpgIRqiaiaZkK+pUNjOBPuZGesEEJL8v4azEe
   Pr1DAFXLLxfIywX02VvO+X+Gtaj8J+z2DTtQFZHL2nhTuWUVG3ZXiSJ/d
   x1zhNU5ORho5gJgV6IZRB4EfLKPBkH3McvJARtoLjRZsoe25/QiWW6i7T
   pD0qB0WnAamzYL1TNK4EXI49AJI58KntS+8jr2GssJ4IjngHS3UxwdI2X
   81YLOAIH05wiPs2CHZgA6rIwJ/OETRqIdCZcN2QYQACwkOjVsgdwKp53C
   TdjFJSJlKd5MxAD7s1vYYHgbdVE3eoUSZiQ6cYOvM0AjzlDm0yYEo9qlZ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="330293359"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="330293359"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 22:53:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="529544506"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.92]) ([10.237.72.92])
  by orsmga008.jf.intel.com with ESMTP; 12 Jan 2022 22:52:59 -0800
Subject: Re: [PATCH 0/6] x86/insn: Add instructions to instruction decoder
To:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        H Peter Anvin <hpa@zytor.com>, chang.seok.bae@intel.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20211202095029.2165714-1-adrian.hunter@intel.com>
 <20211223153808.cddab56b114e5ddf755bd2d0@kernel.org>
 <c5737eb6-383b-13ea-20d1-af597c69a21d@intel.com>
 <YdMOiFDdEny4Jicc@kernel.org> <YdMP5vmU+uqMz04d@kernel.org>
 <c7ac518e-82fb-eb51-7778-5e9b1aaed9a9@intel.com>
 <YdM/A3pWcQi87DbT@kernel.org> <YdNArxYU25LfrS52@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <678169e0-de12-6a61-d0df-cd898b9377a9@intel.com>
Date:   Thu, 13 Jan 2022 08:52:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YdNArxYU25LfrS52@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2022 20:30, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jan 03, 2022 at 03:22:59PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Mon, Jan 03, 2022 at 05:40:00PM +0200, Adrian Hunter escreveu:
>>> On 03/01/2022 17:01, Arnaldo Carvalho de Melo wrote:
>>>> Em Mon, Jan 03, 2022 at 11:56:08AM -0300, Arnaldo Carvalho de Melo escreveu:
>>>> So since this needs rebasing, could you please split it into two
>>>> patchsets, one for tools/ and another for arch and send two batches?
>>>> This way I'll pick the tools/ one, the x86 maintainers the other bits.
> 
>>>> Otherwise the x86 maintainers would have to test if the tools/ bits
>>>> works as expected, etc.
> 
>>> It seems not to be happening for me.  What tree/branch is it?
> 
>> tmp.perf/core
> 
>> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=tmp.perf/core
> 
>> I merged torvalds/master today, but it should work as that file was last
>> changed looong ago:
> 
>> ⬢[acme@toolbox perf]$ git log arch/x86/lib/x86-opcode-map.txt | head
>> commit 5790921bc18b1eb5c0c61371e31114fd4c4b0154
>> Author: Yu-cheng Yu <yu-cheng.yu@intel.com>
>> Date:   Tue Feb 4 09:14:24 2020 -0800
>>
>>     x86/insn: Add Control-flow Enforcement (CET) instructions to the opcode map
>>
>>     Add the following CET instructions to the opcode map:
>>
>>     INCSSP:
>>         Increment Shadow Stack pointer (SSP).
>> ⬢[acme@toolbox perf]$
>>
>> Perhaps related to b4? I'll try updating it and retrying...
> 
> Now it should work:
> 
> ⬢[acme@toolbox perf]$ b4 am -ctsl --cc-trailers c7ac518e-82fb-eb51-7778-5e9b1aaed9a9@intel.com
> <SNIP>
> Cover: ./20211202_adrian_hunter_x86_insn_add_instructions_to_instruction_decoder.cover
>  Link: https://lore.kernel.org/r/20211202095029.2165714-1-adrian.hunter@intel.com
>  Base: applies clean to current tree
>        git checkout -b 20211202_adrian_hunter_intel_com HEAD
>        git am ./20211202_adrian_hunter_x86_insn_add_instructions_to_instruction_decoder.mbx
> ⬢[acme@toolbox perf]$
> 
> Lets see...
> 
> ⬢[acme@toolbox perf]$        git am ./20211202_adrian_hunter_x86_insn_add_instructions_to_instruction_decoder.mbx
> Applying: perf tests: Add AMX instructions to x86 instruction decoder test
> Applying: x86/insn: Add AMX instructions to x86 instruction decoder
> Applying: perf tests: Add misc instructions to x86 instruction decoder test
> Applying: x86/insn: Add misc instructions to x86 instruction decoder
> Applying: perf tests: Add AVX512-FP16 instructions to x86 instruction decoder test
> Applying: x86/insn: Add AVX512-FP16 instructions to x86 instruction decoder
> ⬢[acme@toolbox perf]$
> 
> Yeah, it works, builds and the 'perf test instr' test case succeeds, so
> if Peter or Borislav so wishes please process this patchkit as-is:
> 
> Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Peter or Borislav, could these patches be considered as a late inclusion for v5.17?
