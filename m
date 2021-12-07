Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2786646B1FD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 05:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236295AbhLGEwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 23:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236289AbhLGEwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 23:52:31 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1DEC061354
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 20:49:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1AB08CE19C1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 04:49:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BF7C341C3;
        Tue,  7 Dec 2021 04:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638852538;
        bh=kWUuj+zOg/J02GtTQgtuWReq1jyPVZsr2EvNQ5UNSHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RbQ3ZQHALMekthGD2NZcluVBv3lEnakzWAdlJnF5qWF29VlNcYtdEw7H2wkkY+pRC
         JkLeNqvcujhOIiMjFFEktBOpyRk44ayhVRRCfyeiyDwHjTINSINNeRrdlHffISLn81
         fCT/0J3X3C/FWksXbgcNJdRL1cvfnZxt2lA2sWhltmnpMeRVNIG+iaJEQ17BWeQxUa
         MCBIgdfE3Y42+LgFyKEJOHmpLezftQeQy9QYH09ZJLBDrI6tewkO5+UP6UoOSyioRz
         akcipFJEuzvHo8HOZS380dYgS/Mwui83HW6miCZdBvvDybrNUBkgwG6uGzb1peuID3
         /bbGD9YmsmRwg==
Date:   Mon, 6 Dec 2021 21:48:52 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Bill Wendling <morbo@google.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        kernel test robot <lkp@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] powerpc/inst: Optimise
 copy_inst_from_kernel_nofault()
Message-ID: <Ya7ntJ0ehZPy6HKA@archlinux-ax161>
References: <0d5b12183d5176dd702d29ad94c39c384e51c78f.1638208156.git.christophe.leroy@csgroup.eu>
 <202111300652.0yDBNvyJ-lkp@intel.com>
 <e7b67ca6-8cd1-da3c-c0f3-e05f7e592828@csgroup.eu>
 <87a6hlq408.fsf@mpe.ellerman.id.au>
 <YaZqs2tPxMzhgkAW@archlinux-ax161>
 <CAGG=3QX4k6MZ1qkT+sVAroJeBpbZBnOJauM_uJsu2uV1vnVObQ@mail.gmail.com>
 <CAGG=3QVQ9bwWWyKDN3_C2B0v7H6iZ4ZpNybXGCqbzwWrPjuPrg@mail.gmail.com>
 <87o85tnkzt.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o85tnkzt.fsf@mpe.ellerman.id.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 02:37:26PM +1100, Michael Ellerman wrote:
> Bill Wendling <morbo@google.com> writes:
> > On Tue, Nov 30, 2021 at 10:38 AM Bill Wendling <morbo@google.com> wrote:
> >> On Tue, Nov 30, 2021 at 10:17 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >> > On Tue, Nov 30, 2021 at 10:25:43PM +1100, Michael Ellerman wrote:
> >> > > Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> >> > > > Le 29/11/2021 à 23:55, kernel test robot a écrit :
> ...
> >> > > >> All warnings (new ones prefixed by >>):
> >> > > >>
> >> > > >>     In file included from arch/powerpc/kernel/asm-offsets.c:71:
> >> > > >>     In file included from arch/powerpc/kernel/../xmon/xmon_bpts.h:7:
> >> > > >>>> arch/powerpc/include/asm/inst.h:165:20: warning: variable 'val' is uninitialized when used here [-Wuninitialized]
> >> > > >>                     *inst = ppc_inst(val);
> >> > > >>                                      ^~~
> >> > > >>     arch/powerpc/include/asm/inst.h:53:22: note: expanded from macro 'ppc_inst'
> >> > > >>     #define ppc_inst(x) (x)
> >> > > >>                          ^
> >> > > >>     arch/powerpc/include/asm/inst.h:155:18: note: initialize the variable 'val' to silence this warning
> >> > > >>             unsigned int val, suffix;
> >> > > >>                             ^
> >> > > >>                              = 0
> >> > > >
> >> > > > I can't understand what's wrong here.
> ...
> >> > > >
> >> > > > I see no possibility, no alternative path where val wouldn't be set. The
> >> > > > asm clearly has *addr as an output param so it is always set.
> >> > >
> >> > > I guess clang can't convince itself of that?
> ...
> >> >
> >> > It certainly looks like there is something wrong with how clang is
> >> > tracking the initialization of the variable because it looks to me like
> >> > val is only used in the fallthrough path, which happens after it is
> >> > initialized via lwz.  Perhaps something is wrong with the logic of
> >> > https://reviews.llvm.org/D71314?  I've added Bill to CC (LLVM issues are
> >> > being migrated from Bugzilla to GitHub Issues right now so I cannot file
> >> > this upstream at the moment).
> >> >
> >> If I remove the casts of "val" the warning doesn't appear. I suspect
> >> that when I wrote that patch I forgot to remove those when checking.
> >> #include "Captain_Picard_facepalm.h"
> >>
> >> I'll look into it.
> >>
> > Small retraction. It's the "*(<cast>)&val" that's the issue. (I.e. the "*&")
> 
> I guess for now I'll just squash this in as a workaround?
> 
> 
> diff --git a/arch/powerpc/include/asm/inst.h b/arch/powerpc/include/asm/inst.h
> index 631436f3f5c3..5b591c51fec9 100644
> --- a/arch/powerpc/include/asm/inst.h
> +++ b/arch/powerpc/include/asm/inst.h
> @@ -157,6 +157,9 @@ static inline int copy_inst_from_kernel_nofault(ppc_inst_t *inst, u32 *src)
>  	if (unlikely(!is_kernel_addr((unsigned long)src)))
>  		return -ERANGE;

Could we add a version check to this and a link to our bug tracker:

/* https://github.com/ClangBuiltLinux/linux/issues/1521 */
#if defined(CONFIG_CC_IS_CLANG) && CONFIG_CLANG_VERSION < 140000

> +#ifdef CONFIG_CC_IS_CLANG
> +	val = suffix = 0;
> +#endif
>  	__get_kernel_nofault(&val, src, u32, Efault);
>  	if (IS_ENABLED(CONFIG_PPC64) && get_op(val) == OP_PREFIX) {
>  		__get_kernel_nofault(&suffix, src + 1, u32, Efault);
> 
> 
> 
> cheers
