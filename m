Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DA34C17E5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 16:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242508AbiBWP6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 10:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiBWP6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 10:58:19 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF208AB463;
        Wed, 23 Feb 2022 07:57:50 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nMu1U-00073R-00; Wed, 23 Feb 2022 16:57:48 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 03722C2761; Wed, 23 Feb 2022 16:03:50 +0100 (CET)
Date:   Wed, 23 Feb 2022 16:03:50 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Juxin Gao <gaojuxin@loongson.cn>, linux-mips@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] MIPS: Modernize READ_IMPLIES_EXEC
Message-ID: <20220223150350.GA15128@alpha.franken.de>
References: <20210901194208.2420671-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901194208.2420671-1-keescook@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 12:42:08PM -0700, Kees Cook wrote:
> I'm doing some thread necromancy of
> https://lore.kernel.org/lkml/202007081624.82FA0CC1EA@keescook/
> 
> x86, arm64, and arm32 adjusted their READ_IMPLIES_EXEC logic to better
> align with the safer defaults and the interactions with other mappings,
> which I illustrated with this comment on x86:
> 
> /*
>  * An executable for which elf_read_implies_exec() returns TRUE will
>  * have the READ_IMPLIES_EXEC personality flag set automatically.
>  *
>  * The decision process for determining the results are:
>  *
>  *                 CPU: | lacks NX*  | has NX, ia32     | has NX, x86_64 |
>  * ELF:                 |            |                  |                |
>  * ---------------------|------------|------------------|----------------|
>  * missing PT_GNU_STACK | exec-all   | exec-all         | exec-none      |
>  * PT_GNU_STACK == RWX  | exec-stack | exec-stack       | exec-stack     |
>  * PT_GNU_STACK == RW   | exec-none  | exec-none        | exec-none      |
>  *
>  *  exec-all  : all PROT_READ user mappings are executable, except when
>  *              backed by files on a noexec-filesystem.
>  *  exec-none : only PROT_EXEC user mappings are executable.
>  *  exec-stack: only the stack and PROT_EXEC user mappings are
>  *  executable.
>  *
>  *  *this column has no architectural effect: NX markings are ignored by
>  *   hardware, but may have behavioral effects when "wants X" collides with
>  *   "cannot be X" constraints in memory permission flags, as in
>  *   https://lkml.kernel.org/r/20190418055759.GA3155@mellanox.com
>  *
>  */
> 
> For MIPS, the "lacks NX" above is the "!cpu_has_rixi" check. On x86,
> we decided that the READ_IMPLIES_EXEC flag needed to reflect the
> expectations, not the architectural behavior due to bad interactions
> as noted above, as always returning "1" on non-NX hardware breaks
> some mappings.
> 
> The other part of the issue is "what does the MIPS toolchain do for
> PT_GNU_STACK?" The answer seems to be "by default, include PT_GNU_STACK,
> but mark it executable" (likely due to concerns over non-NX hardware):
> 
> $ mipsel-linux-gnu-gcc -o hello_world hello_world.c
> $ llvm-readelf -lW hellow_world | grep GNU_STACK
>   GNU_STACK      0x000000 0x00000000 0x00000000 0x00000 0x00000 RWE 0x10
> 
> Given that older hardware doesn't support non-executable memory, it
> seems safe to make the "PT_GNU_STACK is absent" logic mean "assume
> non-executable", but this might break very old software running on
> modern MIPS. This situation matches the ia32-on-x86_64 logic x86
> uses (which assumes needing READ_IMPLIES_EXEC in that situation). But
> modern toolchains on modern MIPS hardware should follow a safer default
> (assume NX stack).
> 
> A follow-up to this change would be to switch the MIPS toolchain to emit
> a non-executable PT_GNU_STACK, as this seems to be unneeded.
> 
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
> Cc: Xuefeng Li <lixuefeng@loongson.cn>
> Cc: Juxin Gao <gaojuxin@loongson.cn>
> Cc: linux-mips@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/mips/kernel/elf.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/mips/kernel/elf.c b/arch/mips/kernel/elf.c
> index 7b045d2a0b51..5582a4ca1e9e 100644
> --- a/arch/mips/kernel/elf.c
> +++ b/arch/mips/kernel/elf.c
> @@ -328,16 +328,10 @@ void mips_set_personality_nan(struct arch_elf_state *state)
>  
>  int mips_elf_read_implies_exec(void *elf_ex, int exstack)
>  {
> -	if (exstack != EXSTACK_DISABLE_X) {
> -		/* The binary doesn't request a non-executable stack */
> -		return 1;
> -	}
> -
> -	if (!cpu_has_rixi) {
> -		/* The CPU doesn't support non-executable memory */
> -		return 1;
> -	}
> -
> -	return 0;
> +	/*
> +	 * Set READ_IMPLIES_EXEC only on non-NX systems that
> +	 * do not request a specific state via PT_GNU_STACK.
> +	 */
> +	return (!cpu_has_rixi && exstack == EXSTACK_DEFAULT);
>  }
>  EXPORT_SYMBOL(mips_elf_read_implies_exec);
> -- 
> 2.30.2

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
