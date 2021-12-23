Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7FF47DF1A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 07:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346635AbhLWGiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 01:38:16 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41516 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbhLWGiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 01:38:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8A72B81F80
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 06:38:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B06C36AE9;
        Thu, 23 Dec 2021 06:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640241493;
        bh=Ub50vK+rElrjdRxLT/1Zl4FMduzSdrzpDb5jQvhlPEs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ogXTUBbJ8qvXn1omyYi1Iqf2cHzkb7r2Sk94cmpri5/AhSOPTQTtIjDwKXuC4gXhh
         vtjHYqM8SiJVLXYDQ9bhZGYiXOLLDftT3p13cOaWIS+289AoMI+WArWYWlc/5uQu1C
         2dBVnxw5h6jCeRUHPElVDuTFpNNP8mPffDNE6j3wlurRWRS1gDJtZA/hF0o5FUJzGL
         VL0rBjDh3LMTaBtvXM30F/GX1gZyH3W82KApq0JAORp1xHAR/tiVw3hpSw2tBHNDUo
         OOSqlns1dUyy22Q/A3GsRwUePuQWlShi4muYG7UtUVcjOUGyXfT/kgx7LshbAuRTj6
         t0mAJaEYlLOWA==
Date:   Thu, 23 Dec 2021 15:38:08 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        H Peter Anvin <hpa@zytor.com>, chang.seok.bae@intel.com
Subject: Re: [PATCH 0/6] x86/insn: Add instructions to instruction decoder
Message-Id: <20211223153808.cddab56b114e5ddf755bd2d0@kernel.org>
In-Reply-To: <20211202095029.2165714-1-adrian.hunter@intel.com>
References: <20211202095029.2165714-1-adrian.hunter@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry, I missed this series.

On Thu,  2 Dec 2021 11:50:23 +0200
Adrian Hunter <adrian.hunter@intel.com> wrote:

> Hi
> 
> Here are patches to bring the kernel and tools x86 instruction decoder
> more up to date.
> 
> x86 instruction decoder is used for both kernel instructions and user space
> instructions (e.g. uprobes, perf tools Intel PT), so it is good to update
> it with new instructions.

Hmm, I thought perf used objdump for that purpose internally.
Anyway, this series looks good to me. I'm a bit surprised that the
insn decoder can actually support those instructions only changing
X86_EVEX_M() macro :-)

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> 
> 
> Adrian Hunter (6):
>       perf tests: Add AMX instructions to x86 instruction decoder test
>       x86/insn: Add AMX instructions to x86 instruction decoder
>       perf tests: Add misc instructions to x86 instruction decoder test
>       x86/insn: Add misc instructions to x86 instruction decoder
>       perf tests: Add AVX512-FP16 instructions to x86 instruction decoder test
>       x86/insn: Add AVX512-FP16 instructions to x86 instruction decoder
> 
>  arch/x86/include/asm/insn.h                  |    2 +-
>  arch/x86/lib/x86-opcode-map.txt              |  111 +-
>  tools/arch/x86/include/asm/insn.h            |    2 +-
>  tools/arch/x86/lib/x86-opcode-map.txt        |  111 +-
>  tools/perf/arch/x86/tests/insn-x86-dat-32.c  |  918 +++++++++++++++++
>  tools/perf/arch/x86/tests/insn-x86-dat-64.c  | 1426 ++++++++++++++++++++++++++
>  tools/perf/arch/x86/tests/insn-x86-dat-src.c | 1189 +++++++++++++++++++++
>  7 files changed, 3731 insertions(+), 28 deletions(-)
> 
> 
> Regards
> Adrian


-- 
Masami Hiramatsu <mhiramat@kernel.org>
