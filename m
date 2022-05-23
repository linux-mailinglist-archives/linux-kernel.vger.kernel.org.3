Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70594530D9C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbiEWKal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 06:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234089AbiEWKa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 06:30:27 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37A014B85F;
        Mon, 23 May 2022 03:30:21 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nt5K1-0001dy-01; Mon, 23 May 2022 12:29:57 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 663AEC0311; Mon, 23 May 2022 11:40:05 +0200 (CEST)
Date:   Mon, 23 May 2022 11:40:05 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Rewrite `csum_tcpudp_nofold' in plain C
Message-ID: <20220523094005.GB6296@alpha.franken.de>
References: <alpine.DEB.2.21.2205222035380.52080@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2205222035380.52080@angie.orcam.me.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 22, 2022 at 09:48:14PM +0100, Maciej W. Rozycki wrote:
> Recent commit 198688edbf77 ("MIPS: Fix inline asm input/output type 
> mismatch in checksum.h used with Clang") introduced a code size and 
> performance regression with 64-bit code emitted for `csum_tcpudp_nofold' 
> by GCC, caused by a redundant truncation operation produced due to a 
> data type change made to the variable associated with the inline 
> assembly's output operand.
> 
> The intent previously expressed here with operands and constraints for 
> optimal code was to have the output operand share a register with one 
> inputs, both of a different integer type each.  This is perfectly valid 
> with the MIPS psABI where a register can hold integer data of different 
> types and the assembly code used here makes data stored in the output 
> register match the data type used with the output operand, however it 
> has turned out impossible to express this arrangement in source code 
> such as to satisfy LLVM, apparently due to the compiler's internal 
> limitations.
> 
> There is nothing peculiar about the inline assembly `csum_tcpudp_nofold' 
> includes however, though it does choose assembly instructions carefully.
> 
> Rewrite this piece of assembly in plain C then, using corresponding C 
> language operations, making GCC produce the same assembly instructions, 
> possibly shuffled, in the general case and sometimes actually fewer of 
> them where an input is constant, because the compiler does not have to 
> reload it to a register (operand constraints could be adjusted for that, 
> but the plain C approach is cleaner anyway).
> 
> Example code size changes are as follows, for a 32-bit configuration:
> 
>       text       data        bss      total filename
>    5920480    1347236     126592    7394308 vmlinux-old
>    5920480    1347236     126592    7394308 vmlinux-now
>    5919728    1347236     126592    7393556 vmlinux-c
> 
> and for a 64-bit configuration:
> 
>       text       data        bss      total filename
>    6024112    1790828     225728    8040668 vmlinux-old
>    6024128    1790828     225728    8040684 vmlinux-now
>    6023760    1790828     225728    8040316 vmlinux-c
> 
> respectively, where "old" is with the commit referred reverted, "now" is 
> with no change, and "c" is with this change applied.
> 
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> ---
> Hi,
> 
>  I have visually inspected code produced and verified this change to boot 
> with TCP networking performing just fine, both with a 32-bit and a 64-bit 
> configuration.  Sadly with the little endianness only, because in the 
> course of this verification I have discovered the core card of my Malta 
> board bit the dust a few days ago, apparently in a permanent manner, and I 
> have no other big-endian MIPS system available here to try.
> 
>  The only difference between the two endiannesses is the left-shift 
> operation on (proto + len) however, which doesn't happen for big-endian 
> configurations, so the little endianness should in principle provide 
> enough coverage.
> 
>  Also I'm leaving it to LLVM folks to verify, however this is plain C, so 
> it is expected to just work.
> 
>  Please apply.
> 
>   Maciej
> ---
>  arch/mips/include/asm/checksum.h |   71 ++++++++++++++++++---------------------

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
