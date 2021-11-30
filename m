Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F69463DEE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 19:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245542AbhK3Sm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 13:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbhK3Sm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 13:42:28 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F34C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:39:08 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id x6so90355488edr.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NDV7wbnsOut3zZJWCYtjzebltC2CtkBItML8cZiYM7w=;
        b=XXUM330YnSumSwRMKxyBqSskM0KGfFpE3IRKNemxHJjM3p2zoTJChMKgmdmMXLZuor
         UgenUrAiM5KCATc/c80pi36jRxI7YI6HuCcaUaZRjuMQ66rJr/ZdDdEKgqdNEbTi0Alb
         SJcLCuEagKrnbOQaTKd9qy2aFvEF1HfbewJsucWgM54T75kq2B+zcF178+XUNiaXIFRw
         4Vkzuyy7RW15WJ25gn13CL+pmSp+nWqhZ915h28RelAy2ZhYeCOIKd6ADEcEyb2m792a
         s2YPS0MRvGE2LzHqcvFIEIFGse0wAwt35BqdGrK3ZfxQUga1z0WmsxnOVpVLtHkN7oVD
         wWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NDV7wbnsOut3zZJWCYtjzebltC2CtkBItML8cZiYM7w=;
        b=OTbEgTxXdB9hwRdfhQPiDDD92C/kF0CSPvwwrec8Nh/+ID6u7SsJIiE+N8BG5oLAsp
         b7hnDKCvcLWu2uhmEHHnl0Fd6KZW9e37t06+j8Aqmfjl9ayrslC4R/5xz+TfUzPj5Irk
         BfG+P+E/W/S91DWJKfoSFC2WoHEDWaV4xD+b8KbkoYm6essIGVdgQzrHfiZCMeI+VrN7
         itcMCvObYOLB6Hpc2vDDEHb3M+vt26hMsdlAQ/+IwFBL3wNMdGJgDrSwLFbykicuEkNZ
         LL+BMESM+8vRKQWxgAWs3JvF3i1rI3Ka/OlgAfhaIv8VQm3ldbYv9HVjnPz7c2XoTs/p
         fmgw==
X-Gm-Message-State: AOAM530RXwOTTkaXi89I4K6t80KA5+yavBaMoFB4VpFyVMKuKhJ7ZXUu
        MrV2AgT/5R/u/WnCqoSALDieQpZwtzTV9UgDrIaV
X-Google-Smtp-Source: ABdhPJy1AdO0bCV2BiODMmFfpRrcD3ys8MgfZkMFGwYMmeNienGCD8ifZxMpPX11S+oqZKuFMBi1YH+9qLz1Xy2azbM=
X-Received: by 2002:a05:6402:268d:: with SMTP id w13mr992416edd.257.1638297546881;
 Tue, 30 Nov 2021 10:39:06 -0800 (PST)
MIME-Version: 1.0
References: <0d5b12183d5176dd702d29ad94c39c384e51c78f.1638208156.git.christophe.leroy@csgroup.eu>
 <202111300652.0yDBNvyJ-lkp@intel.com> <e7b67ca6-8cd1-da3c-c0f3-e05f7e592828@csgroup.eu>
 <87a6hlq408.fsf@mpe.ellerman.id.au> <YaZqs2tPxMzhgkAW@archlinux-ax161>
In-Reply-To: <YaZqs2tPxMzhgkAW@archlinux-ax161>
From:   Bill Wendling <morbo@google.com>
Date:   Tue, 30 Nov 2021 10:38:55 -0800
Message-ID: <CAGG=3QX4k6MZ1qkT+sVAroJeBpbZBnOJauM_uJsu2uV1vnVObQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] powerpc/inst: Optimise copy_inst_from_kernel_nofault()
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        kernel test robot <lkp@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 10:17 AM Nathan Chancellor <nathan@kernel.org> wrot=
e:
>
> On Tue, Nov 30, 2021 at 10:25:43PM +1100, Michael Ellerman wrote:
> > Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> > > Le 29/11/2021 =C3=A0 23:55, kernel test robot a =C3=A9crit :
> > >> Hi Christophe,
> > >>
> > >> I love your patch! Perhaps something to improve:
> > >>
> > >> [auto build test WARNING on powerpc/next]
> > >> [also build test WARNING on v5.16-rc3 next-20211129]
> > >> [If your patch is applied to the wrong git tree, kindly drop us a no=
te.
> > >> And when submitting patch, we suggest to use '--base' as documented =
in
> > >> https://git-scm.com/docs/git-format-patch]
> > >>
> > >> url:    https://github.com/0day-ci/linux/commits/Christophe-Leroy/po=
werpc-inst-Refactor-___get_user_instr/20211130-015346
> > >> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linu=
x.git next
> > >> config: powerpc-randconfig-r023-20211129 (https://download.01.org/0d=
ay-ci/archive/20211130/202111300652.0yDBNvyJ-lkp@intel.com/config)
> > >> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project=
 df08b2fe8b35cb63dfb3b49738a3494b9b4e6f8e)
> > >> reproduce (this is a W=3D1 build):
> > >>          wget https://raw.githubusercontent.com/intel/lkp-tests/mast=
er/sbin/make.cross -O ~/bin/make.cross
> > >>          chmod +x ~/bin/make.cross
> > >>          # install powerpc cross compiling tool for clang build
> > >>          # apt-get install binutils-powerpc-linux-gnu
> > >>          # https://github.com/0day-ci/linux/commit/fb7bff30cc0efc7e4=
df1b48bb69de1f325eee826
> > >>          git remote add linux-review https://github.com/0day-ci/linu=
x
> > >>          git fetch --no-tags linux-review Christophe-Leroy/powerpc-i=
nst-Refactor-___get_user_instr/20211130-015346
> > >>          git checkout fb7bff30cc0efc7e4df1b48bb69de1f325eee826
> > >>          # save the config file to linux build tree
> > >>          mkdir build_dir
> > >>          COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cr=
oss W=3D1 O=3Dbuild_dir ARCH=3Dpowerpc prepare
> > >>
> > >> If you fix the issue, kindly add following tag as appropriate
> > >> Reported-by: kernel test robot <lkp@intel.com>
> > >>
> > >> All warnings (new ones prefixed by >>):
> > >>
> > >>     In file included from arch/powerpc/kernel/asm-offsets.c:71:
> > >>     In file included from arch/powerpc/kernel/../xmon/xmon_bpts.h:7:
> > >>>> arch/powerpc/include/asm/inst.h:165:20: warning: variable 'val' is=
 uninitialized when used here [-Wuninitialized]
> > >>                     *inst =3D ppc_inst(val);
> > >>                                      ^~~
> > >>     arch/powerpc/include/asm/inst.h:53:22: note: expanded from macro=
 'ppc_inst'
> > >>     #define ppc_inst(x) (x)
> > >>                          ^
> > >>     arch/powerpc/include/asm/inst.h:155:18: note: initialize the var=
iable 'val' to silence this warning
> > >>             unsigned int val, suffix;
> > >>                             ^
> > >>                              =3D 0
> > >
> > > I can't understand what's wrong here.
> > >
> > > We have
> > >
> > >     __get_kernel_nofault(&val, src, u32, Efault);
> > >     if (IS_ENABLED(CONFIG_PPC64) && get_op(val) =3D=3D OP_PREFIX) {
> > >             __get_kernel_nofault(&suffix, src + 1, u32, Efault);
> > >             *inst =3D ppc_inst_prefix(val, suffix);
> > >     } else {
> > >             *inst =3D ppc_inst(val);
> > >     }
> > >
> > > With
> > >
> > > #define __get_kernel_nofault(dst, src, type, err_label)              =
       \
> > >     __get_user_size_goto(*((type *)(dst)),                          \
> > >             (__force type __user *)(src), sizeof(type), err_label)
> > >
> > >
> > > And
> > >
> > > #define __get_user_size_goto(x, ptr, size, label)                    =
       \
> > > do {                                                                 =
               \
> > >     BUILD_BUG_ON(size > sizeof(x));                                  =
       \
> > >     switch (size) {                                                  =
       \
> > >     case 1: __get_user_asm_goto(x, (u8 __user *)ptr, label, "lbz"); b=
reak;  \
> > >     case 2: __get_user_asm_goto(x, (u16 __user *)ptr, label, "lhz"); =
break; \
> > >     case 4: __get_user_asm_goto(x, (u32 __user *)ptr, label, "lwz"); =
break; \
> > >     case 8: __get_user_asm2_goto(x, (u64 __user *)ptr, label);  break=
;      \
> > >     default: x =3D 0; BUILD_BUG();                                   =
         \
> > >     }                                                                =
       \
> > > } while (0)
> > >
> > > And
> > >
> > > #define __get_user_asm_goto(x, addr, label, op)                     \
> > >     asm_volatile_goto(                                      \
> > >             "1:     "op"%U1%X1 %0, %1       # get_user\n"   \
> > >             EX_TABLE(1b, %l2)                               \
> > >             : "=3Dr" (x)                                      \
> > >             : "m<>" (*addr)                         \
> > >             :                                               \
> > >             : label)
> > >
> > >
> > > I see no possibility, no alternative path where val wouldn't be set. =
The
> > > asm clearly has *addr as an output param so it is always set.
> >
> > I guess clang can't convince itself of that?
>
> A simplified reproducer:
>
> $ cat test.c
> static inline int copy_inst_from_kernel_nofault(unsigned int *inst,
>                                                 unsigned int *src)
> {
>         unsigned int val;
>
>         asm goto("1: lwz %U1%X1 %0, %1   # get_user\n"
>                  ".section __ex_table,\"a\";"
>                  ".balign 4;"
>                  ".long (1b) - . ;"
>                  ".long (%l2) - . ;"
>                  ".previous"
>                  : "=3Dr" (*(unsigned int *)(&val))
>                  : "m<>" (*(unsigned int *)(src))
>                  :
>                  : Efault);
>
>         *inst =3D val;
>         return 0;
>
> Efault:
>         return -14; /* -EFAULT */
> }
>
> $ clang --target=3Dpowerpc-linux-gnu -Wuninitialized -fsyntax-only test.c
> test.c:17:10: warning: variable 'val' is uninitialized when used here [-W=
uninitialized]
>         *inst =3D val;
>                 ^~~
> test.c:4:18: note: initialize the variable 'val' to silence this warning
>         unsigned int val;
>                         ^
>                          =3D 0
> 1 warning generated.
>
> It certainly looks like there is something wrong with how clang is
> tracking the initialization of the variable because it looks to me like
> val is only used in the fallthrough path, which happens after it is
> initialized via lwz.  Perhaps something is wrong with the logic of
> https://reviews.llvm.org/D71314?  I've added Bill to CC (LLVM issues are
> being migrated from Bugzilla to GitHub Issues right now so I cannot file
> this upstream at the moment).
>
If I remove the casts of "val" the warning doesn't appear. I suspect
that when I wrote that patch I forgot to remove those when checking.
#include "Captain_Picard_facepalm.h"

I'll look into it.

-bw
