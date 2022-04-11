Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118B34FC53A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 21:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349691AbiDKTnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 15:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbiDKTnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 15:43:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66647205EB;
        Mon, 11 Apr 2022 12:40:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22A5BB817AA;
        Mon, 11 Apr 2022 19:40:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73455C385A6;
        Mon, 11 Apr 2022 19:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649706053;
        bh=AAe7VENFlNRV97ftvKBoz9pzHBOWQt+AmSLXbo397uc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RqJZbEOL0hke4a2uZ9heYUBogZKj7un4DgEqP7zAsyrg5LinDehxQJQZu6YgAmulQ
         3LB6CEh53+Ge4IeGEjppoitRfwq9l0OyI2sRhRfionobQh/IIkQve9JqPifmAfCR/E
         yVXfPNXaAt+BzD6Ca9VvtgetPKt0J1tRmMMyMfeNm4LGBvu6VtrmwzBr419jss7akL
         xEL/K1/PaCpRs2dDXePL036Ap55UlLroUpUeV5+vabOhPVdnzFj4bkxFQbvFp+BOje
         P6+R4adAxRiHpOn7hmq/H2hEC3fuZdWcMoOwyrdILzNCw4EnSNSFXDVQrMcWF4i+iS
         i368QDm+hbZ0w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 12B1F40407; Mon, 11 Apr 2022 16:40:50 -0300 (-03)
Date:   Mon, 11 Apr 2022 16:40:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Eric Lin <eric.lin@sifive.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
        iii@linux.ibm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        paul.walmsley@sifive.com
Subject: Re: [PATCH v2 1/1] perf jitdump: Add riscv64 support.
Message-ID: <YlSEQrbnbwNt7hNv@kernel.org>
References: <20220411105438.21366-1-eric.lin@sifive.com>
 <20220411105438.21366-2-eric.lin@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411105438.21366-2-eric.lin@sifive.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 11, 2022 at 06:54:38PM +0800, Eric Lin escreveu:
> This patch enable perf jitdump for riscv64 and it tested with V8 on qemu rv64.
> 
> Qemu rv64:
> $ perf record -e cpu-clock -c 1000 -g -k mono ./d8_rv64 --perf-prof --no-write-protect-code-memory test.js
> $ perf inject -j -i perf.data -o perf.data.jitted
> $ perf report -i perf.data.jitted

Thanks, applied.

- Arnaldo

 
> Output:
>  To display the perf.data header info, please use --header/--header-only options.
> 
>  Total Lost Samples: 0
> 
>  Samples: 87K of event 'cpu-clock'
>  Event count (approx.): 87974000
> 
>  Children      Self  Command          Shared Object                Symbol
> 
> ....
>      0.28%     0.06%  d8_rv64          d8_rv64                      [.] _ZN2v88i
> nternal6WasmJs7InstallEPNS0_7IsolateEb
>      0.28%     0.00%  d8_rv64          d8_rv64                      [.] _ZN2v88i
> nternal10ParserBaseINS0_6ParserEE22ParseLogicalExpressionEv
>      0.28%     0.03%  d8_rv64          jitted-112-76.so             [.] Builtin:
> InterpreterEntryTrampoline
>      0.12%     0.00%  d8_rv64          d8_rv64                      [.] _ZN2v88i
> nternal19ContextDeserializer11DeserializeEPNS0_7IsolateENS0_6HandleINS0_13JSGlob
> alProxyEEENS_33DeserializeInternalFieldsCallbackE
>      0.12%     0.01%  d8_rv64          jitted-112-651.so            [.] Builtin:
> CEntry_Return1_DontSaveFPRegs_ArgvOnStack_NoBuiltinExit
> ....
> 
> Signed-off-by: Eric Lin <eric.lin@sifive.com>
> ---
>  tools/perf/arch/riscv/Makefile | 1 +
>  tools/perf/util/genelf.h       | 3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/tools/perf/arch/riscv/Makefile b/tools/perf/arch/riscv/Makefile
> index 1aa9dd772489..a8d25d005207 100644
> --- a/tools/perf/arch/riscv/Makefile
> +++ b/tools/perf/arch/riscv/Makefile
> @@ -2,3 +2,4 @@ ifndef NO_DWARF
>  PERF_HAVE_DWARF_REGS := 1
>  endif
>  PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
> +PERF_HAVE_JITDUMP := 1
> diff --git a/tools/perf/util/genelf.h b/tools/perf/util/genelf.h
> index 3db3293213a9..ae138afe6c56 100644
> --- a/tools/perf/util/genelf.h
> +++ b/tools/perf/util/genelf.h
> @@ -38,6 +38,9 @@ int jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_ent
>  #elif defined(__s390x__)
>  #define GEN_ELF_ARCH	EM_S390
>  #define GEN_ELF_CLASS	ELFCLASS64
> +#elif defined(__riscv) && __riscv_xlen == 64
> +#define GEN_ELF_ARCH	EM_RISCV
> +#define GEN_ELF_CLASS	ELFCLASS64
>  #else
>  #error "unsupported architecture"
>  #endif
> -- 
> 2.35.1

-- 

- Arnaldo
