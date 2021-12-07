Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A30D46B9F6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 12:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235679AbhLGLWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 06:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbhLGLWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 06:22:40 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0E8C061748
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 03:19:10 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J7d964jVBz4xgY;
        Tue,  7 Dec 2021 22:19:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1638875948;
        bh=0XMPFg1uyLXcByQa57fLF55p79RM8131PNd2ix+ygg8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=bllKWJBbZ5SepP/QI5nePCofpeapO/yXsQh3GdA7T6GRyQ3YwRoz3HU4W+hOxciuP
         L/KZUi1UGwNjzHgWKO/BZi+TrLa+fHALGKEhRquvGlNUCcmf3V8JcVWzJseXUOtpne
         Dl0rzR7bbVJQ9LqxFSSFUjMfCv2xVYZ2c0GmWBfNhxShRobl9qNl/CyahVxIm58HOU
         cseXlKGcij6ojOLG1BvahU7GSonXbaxGvS45H5X/huhIjlwYGllxSHR2lVddIGoTz+
         JXbKM6QBH1BBDnsgpLMY9yrwkLRey1sHjMGJ+TdeGCehP1D3ZhOJDEC9ylUEQP+rB7
         tb+WksYYkS3yg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nathan Chancellor <nathan@kernel.org>
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
In-Reply-To: <Ya7ntJ0ehZPy6HKA@archlinux-ax161>
References: <0d5b12183d5176dd702d29ad94c39c384e51c78f.1638208156.git.christophe.leroy@csgroup.eu>
 <202111300652.0yDBNvyJ-lkp@intel.com>
 <e7b67ca6-8cd1-da3c-c0f3-e05f7e592828@csgroup.eu>
 <87a6hlq408.fsf@mpe.ellerman.id.au> <YaZqs2tPxMzhgkAW@archlinux-ax161>
 <CAGG=3QX4k6MZ1qkT+sVAroJeBpbZBnOJauM_uJsu2uV1vnVObQ@mail.gmail.com>
 <CAGG=3QVQ9bwWWyKDN3_C2B0v7H6iZ4ZpNybXGCqbzwWrPjuPrg@mail.gmail.com>
 <87o85tnkzt.fsf@mpe.ellerman.id.au> <Ya7ntJ0ehZPy6HKA@archlinux-ax161>
Date:   Tue, 07 Dec 2021 22:19:05 +1100
Message-ID: <87lf0woe6u.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Chancellor <nathan@kernel.org> writes:
> On Tue, Dec 07, 2021 at 02:37:26PM +1100, Michael Ellerman wrote:
>> Bill Wendling <morbo@google.com> writes:
>> > On Tue, Nov 30, 2021 at 10:38 AM Bill Wendling <morbo@google.com> wrot=
e:
>> >> On Tue, Nov 30, 2021 at 10:17 AM Nathan Chancellor <nathan@kernel.org=
> wrote:
>> >> > On Tue, Nov 30, 2021 at 10:25:43PM +1100, Michael Ellerman wrote:
>> >> > > Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>> >> > > > Le 29/11/2021 =C3=A0 23:55, kernel test robot a =C3=A9crit :
>> ...
>> >> > > >> All warnings (new ones prefixed by >>):
>> >> > > >>
>> >> > > >>     In file included from arch/powerpc/kernel/asm-offsets.c:71:
>> >> > > >>     In file included from arch/powerpc/kernel/../xmon/xmon_bpt=
s.h:7:
>> >> > > >>>> arch/powerpc/include/asm/inst.h:165:20: warning: variable 'v=
al' is uninitialized when used here [-Wuninitialized]
>> >> > > >>                     *inst =3D ppc_inst(val);
>> >> > > >>                                      ^~~
>> >> > > >>     arch/powerpc/include/asm/inst.h:53:22: note: expanded from=
 macro 'ppc_inst'
>> >> > > >>     #define ppc_inst(x) (x)
>> >> > > >>                          ^
>> >> > > >>     arch/powerpc/include/asm/inst.h:155:18: note: initialize t=
he variable 'val' to silence this warning
>> >> > > >>             unsigned int val, suffix;
>> >> > > >>                             ^
>> >> > > >>                              =3D 0
>> >> > > >
>> >> > > > I can't understand what's wrong here.
>> ...
>> >> > > >
>> >> > > > I see no possibility, no alternative path where val wouldn't be=
 set. The
>> >> > > > asm clearly has *addr as an output param so it is always set.
>> >> > >
>> >> > > I guess clang can't convince itself of that?
>> ...
>> >> >
>> >> > It certainly looks like there is something wrong with how clang is
>> >> > tracking the initialization of the variable because it looks to me =
like
>> >> > val is only used in the fallthrough path, which happens after it is
>> >> > initialized via lwz.  Perhaps something is wrong with the logic of
>> >> > https://reviews.llvm.org/D71314?  I've added Bill to CC (LLVM issue=
s are
>> >> > being migrated from Bugzilla to GitHub Issues right now so I cannot=
 file
>> >> > this upstream at the moment).
>> >> >
>> >> If I remove the casts of "val" the warning doesn't appear. I suspect
>> >> that when I wrote that patch I forgot to remove those when checking.
>> >> #include "Captain_Picard_facepalm.h"
>> >>
>> >> I'll look into it.
>> >>
>> > Small retraction. It's the "*(<cast>)&val" that's the issue. (I.e. the=
 "*&")
>>=20
>> I guess for now I'll just squash this in as a workaround?
>>=20
>>=20
>> diff --git a/arch/powerpc/include/asm/inst.h b/arch/powerpc/include/asm/=
inst.h
>> index 631436f3f5c3..5b591c51fec9 100644
>> --- a/arch/powerpc/include/asm/inst.h
>> +++ b/arch/powerpc/include/asm/inst.h
>> @@ -157,6 +157,9 @@ static inline int copy_inst_from_kernel_nofault(ppc_=
inst_t *inst, u32 *src)
>>  	if (unlikely(!is_kernel_addr((unsigned long)src)))
>>  		return -ERANGE;
>
> Could we add a version check to this and a link to our bug tracker:
>
> /* https://github.com/ClangBuiltLinux/linux/issues/1521 */
> #if defined(CONFIG_CC_IS_CLANG) && CONFIG_CLANG_VERSION < 140000

Yep, thanks I'll use that.

cheers
