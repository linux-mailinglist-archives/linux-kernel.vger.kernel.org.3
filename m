Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D545A11AC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 15:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242393AbiHYNPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 09:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242246AbiHYNPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 09:15:05 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB5957267;
        Thu, 25 Aug 2022 06:15:01 -0700 (PDT)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 27PDEjNH004065;
        Thu, 25 Aug 2022 22:14:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 27PDEjNH004065
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1661433286;
        bh=SJNmtkjdIkCl5hveS91ZyBASL+ugc4Xm8jPlARtsttc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NhCxbVHNsFRsvOuajERRZsxE3kvcmiH2Cp+j1UDpNJBhWs9NBXp/qfmZyeiyMMIC+
         aluIBHlUOcB2bX8wVrk7CvJKk2JDyiHG4akwXmfb7WE86efHkblbDF6ZcADUMsIWWT
         jN22hGsdMyj4YhtKAXigNoTVFRIqyylRovDOr7Y+++FYtZboMvFvCbL4t1hXx2xx9A
         KiJ/z7qYvnG4Y0ndrIHYnAYhdXUWrZJelUGUjWTqB/87ECjblU1yx/4kKKTSGfN0T1
         bsTa4zRxj40VvvTejrL8Xk1PpxRboGKr7wdK3Pp9YZsuJmHIOljAmNDxCwopLnTcn2
         FW/AnP6IGkGpw==
X-Nifty-SrcIP: [209.85.210.41]
Received: by mail-ot1-f41.google.com with SMTP id h9-20020a9d5549000000b0063727299bb4so13868712oti.9;
        Thu, 25 Aug 2022 06:14:45 -0700 (PDT)
X-Gm-Message-State: ACgBeo3O9LXQXbH00Oe57mK8FzSS+UipMHt47NbYSXCmbVtOJwwSCiYR
        T0VqF67rlyFUyqC8TkkpXlQeSiPHF1G2xRnSrTc=
X-Google-Smtp-Source: AA6agR7ZkJxTM3y3PB/xIrO0W28fx5DJGvSNCnLpwnNNby4Y+5I4tk9ot0W1eVhETrsf6kGoZHUq99z47zdMuaWZb3c=
X-Received: by 2002:a9d:4806:0:b0:637:cdca:f8d3 with SMTP id
 c6-20020a9d4806000000b00637cdcaf8d3mr1379359otf.225.1661433284587; Thu, 25
 Aug 2022 06:14:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220820165129.1147589-1-masahiroy@kernel.org> <874jy0lpy9.fsf@mpe.ellerman.id.au>
In-Reply-To: <874jy0lpy9.fsf@mpe.ellerman.id.au>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 25 Aug 2022 22:13:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ8ZQHYzoJTPxiRYBsdVXdYUt=bxyrag-d7UnwQ9r7q=w@mail.gmail.com>
Message-ID: <CAK7LNAQ8ZQHYzoJTPxiRYBsdVXdYUt=bxyrag-d7UnwQ9r7q=w@mail.gmail.com>
Subject: Re: [PATCH] powerpc: align syscall table for ppc32
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 4:53 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Masahiro Yamada <masahiroy@kernel.org> writes:
> > Christophe Leroy reported that commit 7b4537199a4a ("kbuild: link
> > symbol CRCs at final link,  removing CONFIG_MODULE_REL_CRCS") broke
> > mpc85xx_defconfig + CONFIG_RELOCATABLE=y.
> >
> >     LD      vmlinux
> >     SYSMAP  System.map
> >     SORTTAB vmlinux
> >     CHKREL  vmlinux
> >   WARNING: 451 bad relocations
> >   c0b312a9 R_PPC_UADDR32     .head.text-0x3ff9ed54
> >   c0b312ad R_PPC_UADDR32     .head.text-0x3ffac224
> >   c0b312b1 R_PPC_UADDR32     .head.text-0x3ffb09f4
> >   c0b312b5 R_PPC_UADDR32     .head.text-0x3fe184dc
> >   c0b312b9 R_PPC_UADDR32     .head.text-0x3fe183a8
> >       ...
> >
> > The compiler emits a bunch of R_PPC_UADDR32, which is not supported by
> > arch/powerpc/kernel/reloc_32.S.
> >
> > The reason is there exists an unaligned symbol.
> >
> >   $ powerpc-linux-gnu-nm -n vmlinux
> >     ...
> >   c0b31258 d spe_aligninfo
> >   c0b31298 d __func__.0
> >   c0b312a9 D sys_call_table
> >   c0b319b8 d __func__.0
> >
> > Commit 7b4537199a4a is not the root cause. Even before that, I can
> > reproduce the same issue for mpc85xx_defconfig + CONFIG_RELOCATABLE=y
> > + CONFIG_MODVERSIONS=n.
> >
> > It is just that nobody did not notice it because when CONFIG_MODVERSIONS



I wrote weird English (double negation)


nobody did not notice   --> nobody noticed



Please fix it if you have not yet.


Thank you.





> > is enabled, a __crc_* symbol inserted before sys_call_table was hiding
> > the unalignment issue.
> >
> > I checked the commit history, but I could not understand commit
> > 46b45b10f142 ("[POWERPC] Align the sys_call_table").
> >
> > It said 'Our _GLOBAL macro does a ".align 2" so the alignment is fine
> > for 32 bit'. I checked the _GLOBAL in include/asm-powerpc/ppc_asm.h
> > at that time. _GLOBAL specifies ".align 2" for ppc64, but no .align
> > for ppc32.
> >
> > Commit c857c43b34ec ("powerpc: Don't use a function descriptor for
> > system call table") removed _GLOBAL from the syscall table.
> >
> > Anyway, adding alignment to the syscall table for ppc32 fixes the issue.
> >
> > I am not giving Fixes tag because I do not know since when it has been
> > broken, but presumably it has been for a long while.
>
> Thanks.
>
> I trimmed the change log a bit just to say ~= it's been broken for ever,
> and added a Cc to stable.
>
> cheers






-- 
Best Regards
Masahiro Yamada
