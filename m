Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB72536F7F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 06:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiE2E3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 00:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiE2E3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 00:29:35 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712F1B2240;
        Sat, 28 May 2022 21:29:34 -0700 (PDT)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 24T4TEqc026866;
        Sun, 29 May 2022 13:29:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 24T4TEqc026866
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653798555;
        bh=G/i1dwVBb3QQsD9CFilTnjlTJDW4bryVPOXgitbHRzQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XCyrl0g2GSOY2F6zfUOdjIZRvtSjkiMaWol30nf8GKmiDWxLsfI0zyrSKyH9oB2t0
         GSe7tHhP8Syakdkh/AuPMUnS6Txck8tr1wJG5si05KD2dj3Gf4ODtIPl3wSUs3MIWc
         0Ndf2j3Y8L0FBCcig65cdzelEHc9Pj9xUmlM0e1uWWUWUVMx0bPKwEzR17/mircllF
         ZrrpxMvNP7hG5xLkYWq4dr6ct0sEwh3XAlpxA1HPBFaTMsSixFQx9S3vcad9BPD/A9
         jkrWc1mNpO0n7AoGJ0QDf3CH3leM7kjanz9wJqlSganYri0mTimSOayyPsIf007Xze
         X3olbDAhyM/vw==
X-Nifty-SrcIP: [209.85.216.51]
Received: by mail-pj1-f51.google.com with SMTP id qe5-20020a17090b4f8500b001e26126abccso5035159pjb.0;
        Sat, 28 May 2022 21:29:15 -0700 (PDT)
X-Gm-Message-State: AOAM530aoStgg+rSCYGgKkHhOz7uwPbNAgCupvWjDQGS+rAD5nhIGZCd
        Q1kznnO582BsQ4GaQYBFSs17X2DGn39MXaEqdy8=
X-Google-Smtp-Source: ABdhPJzNxHqxq69yNjBbxRveFRTwLx+8EEISbWq1N9bsPU/YNURXqavj/Dvr0ngQWN5AtBu4wR2ivtVeklv4ITjHQzU=
X-Received: by 2002:a17:902:9887:b0:151:6e1c:7082 with SMTP id
 s7-20020a170902988700b001516e1c7082mr49302906plp.162.1653798554247; Sat, 28
 May 2022 21:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220513113930.10488-1-masahiroy@kernel.org> <20220513113930.10488-2-masahiroy@kernel.org>
 <20220528224745.GA2501857@roeck-us.net>
In-Reply-To: <20220528224745.GA2501857@roeck-us.net>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 29 May 2022 13:27:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQU1oROfoWGqX37OZu=XkbYGBFu2eNHtwcWLEyvMtM11A@mail.gmail.com>
Message-ID: <CAK7LNAQU1oROfoWGqX37OZu=XkbYGBFu2eNHtwcWLEyvMtM11A@mail.gmail.com>
Subject: Re: [PATCH v6 01/10] modpost: extract symbol versions from *.cmd files
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-modules <linux-modules@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 29, 2022 at 7:47 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Hi,
>
> On Fri, May 13, 2022 at 08:39:21PM +0900, Masahiro Yamada wrote:
> > Currently, CONFIG_MODVERSIONS needs extra link to embed the symbol
> > versions into ELF objects. Then, modpost extracts the version CRCs
> > from them.
> >
> [ ... ]
> > This commit changes modpost to extract CRCs from *.cmd files instead of
> > from ELF objects.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
> > Tested-by: Nathan Chancellor <nathan@kernel.org>
> > Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
>
> This patch results in
>
> ._muldi3_di.o.cmd: No such file or directory
>
> when building parisc64:defconfig, and
>
> ._divsi3.o.cmd: No such file or directory
>
> when building csky:allmodconfig.
>
> Reverting this patch (and the subsequent kbuild patches to avoid
> conflicts) fixes the problem for both architectures. In case it
> helps, the complete build log when rebuilding an image for csky
> is as follows.



Thank you for the report!

This commit has been in the tree for a while
but I did not get this kind of report from the 0-day bot.

The wide test coverage from your system is very helpful.
I just submitted a fix.

Thank you.









> #
> # No change to .config
> #
>   HOSTCC  scripts/mod/modpost.o
>   HOSTLD  scripts/mod/modpost
>   CALL    scripts/atomic/check-atomics.sh
>   CALL    scripts/checksyscalls.sh
>   CHK     include/generated/compile.h
>   SO2S    arch/csky/kernel/vdso/vdso-syms.S
>   AS      arch/csky/kernel/vdso/vdso-syms.o
>   AR      arch/csky/kernel/vdso/built-in.a
>   AR      arch/csky/kernel/built-in.a
>   CHK     kernel/kheaders_data.tar.xz
>   GEN     .version
>   CHK     include/generated/compile.h
>   UPD     include/generated/compile.h
>   CC      init/version.o
>   AR      init/built-in.a
>   LD      vmlinux.o
>   MODPOST vmlinux.symvers
> ._divsi3.o.cmd: No such file or directory
> make[1]: *** [scripts/Makefile.modpost:59: vmlinux.symvers] Error 1
> make: *** [Makefile:1159: vmlinux] Error 2
>
> This was seen with gcc 11.2 and 11.3.
>
> Guenter
>
> ---
> bisect on mainline:
>
> # bad: [9d004b2f4fea97cde123e7f1939b80e77bf2e695] Merge tag 'cxl-for-5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl
> # good: [4b0986a3613c92f4ec1bdc7f60ec66fea135991f] Linux 5.18
> git bisect start 'HEAD' 'v5.18'
> # good: [86c87bea6b42100c67418af690919c44de6ede6e] Merge tag 'devicetree-for-5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
> git bisect good 86c87bea6b42100c67418af690919c44de6ede6e
> # good: [c011dd537ffe47462051930413fed07dbdc80313] Merge tag 'arm-soc-5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> git bisect good c011dd537ffe47462051930413fed07dbdc80313
> # bad: [df202b452fe6c6d6f1351bad485e2367ef1e644e] Merge tag 'kbuild-v5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild
> git bisect bad df202b452fe6c6d6f1351bad485e2367ef1e644e
> # good: [d4dcdc53c492a7b9fa9031cb85e238b21208ada2] Merge tag 'qcom-arm64-for-5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into arm/dt
> git bisect good d4dcdc53c492a7b9fa9031cb85e238b21208ada2
> # good: [ae862183285cbb2ef9032770d98ffa9becffe9d5] Merge tag 'arm-dt-5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> git bisect good ae862183285cbb2ef9032770d98ffa9becffe9d5
> # good: [cc3c470ae4ad758b8ddad825ab199f7eaa8b0a9e] Merge tag 'arm-drivers-5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> git bisect good cc3c470ae4ad758b8ddad825ab199f7eaa8b0a9e
> # good: [ecf0aa5317b0ad6bb015128a5b763c954fd58708] Merge tag 'arm-multiplatform-5.19-1' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> git bisect good ecf0aa5317b0ad6bb015128a5b763c954fd58708
> # good: [4484054816cab940fc2fde23fa989174fec889d0] modpost: use doubly linked list for dump_lists
> git bisect good 4484054816cab940fc2fde23fa989174fec889d0
> # good: [16477cdfefdb494235a675cc80563d736991d833] Merge tag 'asm-generic-5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic
> git bisect good 16477cdfefdb494235a675cc80563d736991d833
> # good: [a44abaca0e196cfeef2374ed663b97daa1ad112a] modpost: move *.mod.c generation to write_mod_c_files()
> git bisect good a44abaca0e196cfeef2374ed663b97daa1ad112a
> # good: [69c4cc99bbcbf3ef2e1901b569954e9226180840] modpost: add sym_find_with_module() helper
> git bisect good 69c4cc99bbcbf3ef2e1901b569954e9226180840
> # bad: [7b4537199a4a8480b8c3ba37a2d44765ce76cd9b] kbuild: link symbol CRCs at final link, removing CONFIG_MODULE_REL_CRCS
> git bisect bad 7b4537199a4a8480b8c3ba37a2d44765ce76cd9b
> # bad: [f292d875d0dc700b3af0bef04c5abc1dc7b3b62c] modpost: extract symbol versions from *.cmd files
> git bisect bad f292d875d0dc700b3af0bef04c5abc1dc7b3b62c
> # first bad commit: [f292d875d0dc700b3af0bef04c5abc1dc7b3b62c] modpost: extract symbol versions from *.cmd files
>
> ---
> bisect on kbuild-5.19:
>
> # bad: [5ce2176b81f77366bd02c27509b83049f0020544] genksyms: adjust the output format to modpost
> # good: [3123109284176b1532874591f7c81f3837bbdc17] Linux 5.18-rc1
> git bisect start 'HEAD' 'v5.18-rc1'
> # good: [70ddb48db4aaddd3c2a7d8802463e15b21ce8525] modpost: move struct namespace_list to modpost.c
> git bisect good 70ddb48db4aaddd3c2a7d8802463e15b21ce8525
> # good: [e76cc48d8e6df5d949284132981db73d2dd8c6b5] modpost: make sym_add_exported() always allocate a new symbol
> git bisect good e76cc48d8e6df5d949284132981db73d2dd8c6b5
> # good: [78e9e56af3858bf2c52c065daa6c8bee0d72048c] kbuild: record symbol versions in *.cmd files
> git bisect good 78e9e56af3858bf2c52c065daa6c8bee0d72048c
> # good: [69c4cc99bbcbf3ef2e1901b569954e9226180840] modpost: add sym_find_with_module() helper
> git bisect good 69c4cc99bbcbf3ef2e1901b569954e9226180840
> # bad: [7b4537199a4a8480b8c3ba37a2d44765ce76cd9b] kbuild: link symbol CRCs at final link, removing CONFIG_MODULE_REL_CRCS
> git bisect bad 7b4537199a4a8480b8c3ba37a2d44765ce76cd9b
> # bad: [f292d875d0dc700b3af0bef04c5abc1dc7b3b62c] modpost: extract symbol versions from *.cmd files
> git bisect bad f292d875d0dc700b3af0bef04c5abc1dc7b3b62c
> # first bad commit: [f292d875d0dc700b3af0bef04c5abc1dc7b3b62c] modpost: extract symbol versions from *.cmd files



--
Best Regards
Masahiro Yamada
