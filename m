Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F325AD70B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 18:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237198AbiIEQCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 12:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236344AbiIEQCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 12:02:31 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99FA4AD5D;
        Mon,  5 Sep 2022 09:02:29 -0700 (PDT)
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 285G2GMb015407;
        Tue, 6 Sep 2022 01:02:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 285G2GMb015407
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662393737;
        bh=AXX+q4cSSF44b3H1EkqtDdmN+QPCNlmjjiXXce2p9MQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QWotCvp8/JtSYftB+faoLCc7Kgv04UtuH/wn+Z7r1Y4lQysb6fzzlSMLVWuAQaSGt
         LhN7SQDxMPtvZ3V4TgMmcHkMi8hvyXGYBshsVfS6DA5Ykf8i1wOMvWUMCASVahYC4r
         F7U7QgY9m4eWSeEV55eh30aoEG3KsELPORHRcgoNOT84CjVtKVSKzteen16YalcAA9
         COE6mWvCX7DlWYP4HRvtIITNqEXRzcm+Q9Oqf2MDGOClbDUN4IiYB2hXLBqifm9sW4
         Qw2ohB+GTyZHfcncJblV2+QX9T7lTZZp59zDyXECTmmglGIOxZN3r8Lfcq6Lgkdu71
         2RwXSmQ6ZEl7g==
X-Nifty-SrcIP: [209.85.160.44]
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-11eab59db71so22235725fac.11;
        Mon, 05 Sep 2022 09:02:17 -0700 (PDT)
X-Gm-Message-State: ACgBeo1YSmJjMGko0SKQIRCFSd1by2jjSYMsb+JDY+dXym2aPTS0jSkV
        +Xk5LTDFUEh9Sx7XaqPk1BSc9Q77uVjZOsQVEqU=
X-Google-Smtp-Source: AA6agR65jnyCeKkMdJOxL7lqKg65Nmc1Fk9Jacn1YzGFOihFta0f01is88Mb4DWZDkEyFMPeSgDZ7yIpdlbP+jGA+FY=
X-Received: by 2002:a05:6870:f626:b0:10d:a798:f3aa with SMTP id
 ek38-20020a056870f62600b0010da798f3aamr9453327oab.194.1662393736259; Mon, 05
 Sep 2022 09:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220905083619.672091-2-masahiroy@kernel.org> <202209052329.sY4Fx2fi-lkp@intel.com>
In-Reply-To: <202209052329.sY4Fx2fi-lkp@intel.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 6 Sep 2022 01:01:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNASF62o3iRq+tFr=j88dsWxo6YjJ3_mYiAP4pX3DcQpP9A@mail.gmail.com>
Message-ID: <CAK7LNASF62o3iRq+tFr=j88dsWxo6YjJ3_mYiAP4pX3DcQpP9A@mail.gmail.com>
Subject: Re: [PATCH 2/2] kbuild: move -Wundef from KBUILD_CFLAGS to KBUILD_CPPFLAGS
To:     kernel test robot <lkp@intel.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        kbuild-all@lists.01.org, Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 6, 2022 at 12:49 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Masahiro,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on masahiroy-kbuild/for-next]
> [also build test WARNING on linus/master v6.0-rc4]
> [cannot apply to next-20220901]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Masahiro-Yamada/kb=
uild-move-Werror-from-KBUILD_CFLAGS-to-KBUILD_CPPFLAGS/20220905-164209
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-k=
build.git for-next
> config: riscv-randconfig-r042-20220905 (https://download.01.org/0day-ci/a=
rchive/20220905/202209052329.sY4Fx2fi-lkp@intel.com/config)
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c55b=
41d5199d2394dd6cdb8f52180d8b81d809d4)
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install riscv cross compiling tool for clang build
>         # apt-get install binutils-riscv64-linux-gnu
>         # https://github.com/intel-lab-lkp/linux/commit/2f8ee1865d7d00ad2=
7460d94056c7752cad8481f
>         git remote add linux-review https://github.com/intel-lab-lkp/linu=
x
>         git fetch --no-tags linux-review Masahiro-Yamada/kbuild-move-Werr=
or-from-KBUILD_CFLAGS-to-KBUILD_CPPFLAGS/20220905-164209
>         git checkout 2f8ee1865d7d00ad27460d94056c7752cad8481f
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=
=3D1 O=3Dbuild_dir ARCH=3Driscv SHELL=3D/bin/bash arch/riscv/
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> arch/riscv/kernel/head.S:329:5: warning: 'CONFIG_RISCV_BOOT_SPINWAIT' =
is not defined, evaluates to 0 [-Wundef]
>    #if CONFIG_RISCV_BOOT_SPINWAIT
>        ^
>    1 warning generated.
>



Hmm, it looks like my patch started to uncover a couple of coding mistakes.






=E3=80=80#if CONFIG_RISCV_BOOT_SPINWAIT
          -->

  #ifdef CONFIG_RISCV_BOOT_SPINWAIT


(CONFIG_RISCV_BOOT_SPINWAIT is a bool option)





--=20
Best Regards
Masahiro Yamada
