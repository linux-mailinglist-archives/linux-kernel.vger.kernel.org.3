Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105B04833DB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 16:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbiACPCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 10:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbiACPCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 10:02:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBC7C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 07:02:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B432C61123
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 15:02:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75DEC36AEB;
        Mon,  3 Jan 2022 15:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641222121;
        bh=/KVtOXrT0KKAcOM0b7+6nsBiEimhMvwwJncp/6a6I/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XzTf9ts/Kkd2In+W++nVF/36nwLEcgxH/2ovO7VP9XIb3DEKfnvMQNhtCeDNOddSL
         LFsrooTLKWbZyBkR3leGWpi3uX+btEIboVi1IRRlHvGuBUAl3WbEWlhAxeCF9H0ukM
         LoMmpb9JxYoaUmUDncVHn7CdQ43XX+voA+Xky9od5sWYduiNIlHc0hwP0wX9O82pg2
         sWFJXH8jqcAf1aRP7uaLuQFFezQwfLRD3e6d8sO5SZOvME981qDp5/M4eV6urn2WJm
         qtwuE3jjkZAlnQZrzOSg01CccJ1iTnFQxC7r/NJcsiJrm7qty0UguUYHsMiXbWHflJ
         H6QDI9OVYSJOA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DAB6340B92; Mon,  3 Jan 2022 12:01:58 -0300 (-03)
Date:   Mon, 3 Jan 2022 12:01:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        H Peter Anvin <hpa@zytor.com>, chang.seok.bae@intel.com,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 0/6] x86/insn: Add instructions to instruction decoder
Message-ID: <YdMP5vmU+uqMz04d@kernel.org>
References: <20211202095029.2165714-1-adrian.hunter@intel.com>
 <20211223153808.cddab56b114e5ddf755bd2d0@kernel.org>
 <c5737eb6-383b-13ea-20d1-af597c69a21d@intel.com>
 <YdMOiFDdEny4Jicc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YdMOiFDdEny4Jicc@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 03, 2022 at 11:56:08AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Jan 03, 2022 at 10:13:24AM +0200, Adrian Hunter escreveu:
> > On 23/12/2021 08:38, Masami Hiramatsu wrote:
> > > Hi,
> > > 
> > > Sorry, I missed this series.
> > > 
> > > On Thu,  2 Dec 2021 11:50:23 +0200
> > > Adrian Hunter <adrian.hunter@intel.com> wrote:
> > > 
> > >> Hi
> > >>
> > >> Here are patches to bring the kernel and tools x86 instruction decoder
> > >> more up to date.
> > >>
> > >> x86 instruction decoder is used for both kernel instructions and user space
> > >> instructions (e.g. uprobes, perf tools Intel PT), so it is good to update
> > >> it with new instructions.
> > > 
> > > Hmm, I thought perf used objdump for that purpose internally.
> > > Anyway, this series looks good to me. I'm a bit surprised that the
> > > insn decoder can actually support those instructions only changing
> > > X86_EVEX_M() macro :-)
> > > 
> > > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > 
> > > Thank you!
> > 
> > Thanks!
> > 
> > Arnaldo, could you consider taking these patches?
> 
> I can pick the tools/ bits, the arch/x86/ should go via PeterZ, right?
> Peter?

I tried applying the whole shebang and got:

⬢[acme@toolbox perf]$ git am ./20211202_adrian_hunter_x86_insn_add_instructions_to_instruction_decoder.mbx
Applying: perf tests: Add AMX instructions to x86 instruction decoder test
Applying: x86/insn: Add AMX instructions to x86 instruction decoder
Applying: perf tests: Add misc instructions to x86 instruction decoder test
Applying: x86/insn: Add misc instructions to x86 instruction decoder
Applying: perf tests: Add AVX512-FP16 instructions to x86 instruction decoder test
Applying: x86/insn: Add AVX512-FP16 instructions to x86 instruction decoder
error: patch failed: arch/x86/lib/x86-opcode-map.txt:896
error: arch/x86/lib/x86-opcode-map.txt: patch does not apply
Patch failed at 0006 x86/insn: Add AVX512-FP16 instructions to x86 instruction decoder
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
⬢[acme@toolbox perf]$

So since this needs rebasing, could you please split it into two
patchsets, one for tools/ and another for arch and send two batches?
This way I'll pick the tools/ one, the x86 maintainers the other bits.

Otherwise the x86 maintainers would have to test if the tools/ bits
works as expected, etc.

- Arnaldo
