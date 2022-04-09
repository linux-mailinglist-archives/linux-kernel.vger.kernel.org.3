Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD324FA922
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 17:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239000AbiDIPHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 11:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiDIPHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 11:07:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138DB35866;
        Sat,  9 Apr 2022 08:05:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD4B2B80025;
        Sat,  9 Apr 2022 15:05:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0DAC385A4;
        Sat,  9 Apr 2022 15:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649516722;
        bh=3be73TMrg54OghDV9TLyvzEzdbPlioR/qzV9oy5L1IA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bg3rUg6lx6E8XKHkNGW5ZHLhbjp7hp1Ywi5NadDxAi+hwW2MYz52DjTjOg5L08PGY
         8k+B9TeLKJKvj1lHXMr5DwxNRtQhH9UUu/IE82cpVqC+9NjzL0vfk1Fm8NDCr96JO7
         yb2T+w8wYzKbxceLN7g94iBk8ApOrulimKJX4z3nxUJsUfC78NIO5kSdmJUCfAtcF5
         H6ONvedDxi7HlVLO+gFxulZp5+F1f0gciZqSuB+pR8QzdsB+enI478ydBRvJ/1UPL6
         3bQD0zpgKGvjCopJEQyHQDv8v0fGKK+rxvXe6Y6V6zQ8FwMA80bV93it+AoTh0P+S9
         CN/0Y8EMEUUew==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CA50D40407; Sat,  9 Apr 2022 12:05:18 -0300 (-03)
Date:   Sat, 9 Apr 2022 12:05:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Eric Lin <eric.lin@sifive.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
        iii@linux.ibm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        paul.walmsley@sifive.com, greentime.hu@sifive.com
Subject: Re: [PATCH 1/1] perf jitdump: Add riscv64 support.
Message-ID: <YlGgro3TupbOEnJC@kernel.org>
References: <20220406142606.18464-1-eric.lin@sifive.com>
 <20220406142606.18464-2-eric.lin@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406142606.18464-2-eric.lin@sifive.com>
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

Em Wed, Apr 06, 2022 at 10:26:06PM +0800, Eric Lin escreveu:
> Signed-off-by: Eric Lin <eric.lin@sifive.com>

Can you plese provide some series of commands demonstrating the usage of
this functionality on riscv?

A dump, for instance.

- Arnaldo

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
