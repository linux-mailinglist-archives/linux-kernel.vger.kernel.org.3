Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFBA5B1F94
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiIHNsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbiIHNsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:48:51 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B95BED99E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 06:48:50 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-3321c2a8d4cso165430307b3.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 06:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=PrAW4wlGAMpC6dhne2p4JlSpdkZ+T0pQJSO4IRDJw/M=;
        b=a5V303Grb1g6aa5PgMU+1/uY4uV2n3uOGiPp76bKJ9bWe3LdiMpqRBpPZo+c/uNnWq
         K7ZfRZJS2lZWvmNNV0kI5GFGc5h/b/xvkqoVKy+t9ViefUqkXJxdmrSwwbRyS02bdg+r
         tU5wRW4XERHfPrif6/firZHorfdjp3DEyYBhp/KZj4Hi1Lvsfdt90h5sM6qgSP6ht6Xu
         4fN7L8vDAiYFG1+fTKKbogWRmCTkzMHKbK6j0Yj9Hut7K2y4L+YQxwT/E1WEN+habGT/
         i1rM5BbJl+DCQsKghDS3VegCGhKf8NCy/zYzyEeu0k2MYI66YkJwXyI4rQp1Z3NwwDYN
         fs3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=PrAW4wlGAMpC6dhne2p4JlSpdkZ+T0pQJSO4IRDJw/M=;
        b=cPZq5n7Qp57MKcbE6YuQon53xpuvCyitEjNP7zUo9X5okbymOX0fHE1Pm/KSOibY6e
         QePdwrjSEc0yeL4Qg2xWpf/BQlabap+sk4Rze98e56LymxkIk0E6KYGbe/Qb4rfTvjO7
         uc77lCUkdSEFNfJiLOsQpr9xQ3LGLu/l2Yf1OEH7z18u1fYLndE2wAaGcskMFrxB5rnL
         NAW0q8suPGidyDqJ5D70ddlJ47PICLyPH9GCBfCU4pubtFnbivGbBpkPHhgVBzL/LPI7
         GrO6RLrmjkpjYgFxqE6yio1m4xMU2GLs4W3XtHKMWOF5TEHrkyXzMBf8y7FbDZBm/yIx
         o5hA==
X-Gm-Message-State: ACgBeo3plDHF2ZN2zMaboSSvDhQtna1x6faXZscqidNLomWE+e15XxmW
        EeQZI5K6DEcrqSvM60hUzta5/UMw0jTa5xpsaPw9Qw==
X-Google-Smtp-Source: AA6agR5xKhbQw6oS6dDgQ+QgiFx+Piom7aCOd/755e8364yFiN8jf83N80N4aalNlJ+GmPBIfkCIg2Fx3l/i9T6y0Vw=
X-Received: by 2002:a0d:d607:0:b0:348:a519:fbb7 with SMTP id
 y7-20020a0dd607000000b00348a519fbb7mr1674379ywd.255.1662644929486; Thu, 08
 Sep 2022 06:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <202209082025.QtFc63hS-lkp@intel.com>
In-Reply-To: <202209082025.QtFc63hS-lkp@intel.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 8 Sep 2022 15:48:13 +0200
Message-ID: <CANpmjNN=Q_Ccr6Z9_1H2pz-yzFSiAD9ncx7efP=WkroBMtSedw@mail.gmail.com>
Subject: Re: ld.lld: error: undefined symbol: __tsan_memcpy
To:     kernel test robot <lkp@intel.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is being fixed:
https://lore.kernel.org/all/20220907173903.2268161-1-elver@google.com/T/#u

This is an extremely fresh version of Clang, which has no release yet.
So the report is not urgent.

On Thu, 8 Sept 2022 at 14:33, kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   0066f1b0e27556381402db3ff31f85d2a2265858
> commit: dd03762ab608e058c8f390ad9cf667e490089796 arm64: Enable KCSAN
> date:   9 months ago
> config: arm64-randconfig-r031-20220908
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c55b41d5199d2394dd6cdb8f52180d8b81d809d4)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dd03762ab608e058c8f390ad9cf667e490089796
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout dd03762ab608e058c8f390ad9cf667e490089796
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
> >> ld.lld: error: undefined symbol: __tsan_memcpy
>    >>> referenced by main.c
>    >>>               main.o:(do_one_initcall) in archive init/built-in.a
>    >>> referenced by main.c
>    >>>               main.o:(setup_command_line) in archive init/built-in.a
>    >>> referenced by initramfs.c
>    >>>               initramfs.o:(panic_show_mem) in archive init/built-in.a
>    >>> referenced 4283 more times
> --
> >> ld.lld: error: undefined symbol: __tsan_memset
>    >>> referenced by main.c
>    >>>               main.o:(init_setup) in archive init/built-in.a
>    >>> referenced by main.c
>    >>>               main.o:(rdinit_setup) in archive init/built-in.a
>    >>> referenced by do_mounts_rd.c
>    >>>               do_mounts_rd.o:(identify_ramdisk_image) in archive init/built-in.a
>    >>> referenced 6155 more times
> --
> >> ld.lld: error: undefined symbol: __tsan_memmove
>    >>> referenced by main.c
>    >>>               main.o:(repair_env_string) in archive init/built-in.a
>    >>> referenced by range.c
>    >>>               range.o:(add_range_with_merge) in archive kernel/built-in.a
>    >>> referenced by printk.c
>    >>>               printk/printk.o:(vprintk_store) in archive kernel/built-in.a
>    >>> referenced 252 more times
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
