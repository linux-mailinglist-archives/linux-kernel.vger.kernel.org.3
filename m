Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC5D49A7F1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1315476AbiAYCx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 21:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387506AbiAYAE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 19:04:59 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D223DC10FB1A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 13:50:16 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id n8so12407223lfq.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 13:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OGMPavFiygsyRUvP6iJHreifdhTfnFs8KzTgqM4LQXE=;
        b=hHNFgGgpW1yZ1w3yidJ34MJlAwrfsR1lTv2j8pjJOimmG76AEX2nqrZgl12L1c2EjT
         pUXl5fJZL52pNzq6q9l2kdXzPi1VwipLre4QSLIvXamsR28pncmewCxcyiyy/6snPrcw
         MwZCDsjudVnfJyWF7UtVsZGai9O0RQi1zC7aH8CLCfHHcuJojcS/pXSWLJyDFybg6mV9
         qW91v9PSr7mwaE8Y9WsVwjEp6SJz/l/3Zp+eKu5XGzD6r4RS1yZvmiHhoenEqJvfLJAR
         BoWPA5dvK0QDl6tg0qrC/8YSBCha1070ecMkBJokjd1b1X7uetupIvFBhoPYhlw9JEjn
         hbbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OGMPavFiygsyRUvP6iJHreifdhTfnFs8KzTgqM4LQXE=;
        b=m9n6f+rA4vfAH1s3BWxrGwJZh+2vi0JaNVqUTPHHZSS4JM/f9+nVS8E+PrJJbGidPR
         QWsfmxQ7m03m0XLjgBgejymJT4TRfGaEx3G7Xxb5Pjo8Y29OFuIQHjdNHSTRja/mvd25
         Q29gBSsvCQlhTTDo42EvrgKQU+Zxt4C2WxnprGJ+hPSEr5oepIeaL28/iIqf28Lo0pOF
         N0dvCFjitQjrXTGARpqwFiMEbosAhiW55OUMwJ0afxzVt0w3qVnuUGan0XfcPJAammQK
         praIIenET/Si4PI9hsYGqyhjvf5NfjpcuCFD4PMdhaIyarFZsNiZBbbrFmI+bo2uP809
         rvnQ==
X-Gm-Message-State: AOAM532KHaHLDgznFfBcwH667DTKJFDlucR8EkR6vQiKFQEMtjG74xra
        JcbzDyPctu9jb0N5JI4V00GxuI3/jRTSUc/fOL+jnQ==
X-Google-Smtp-Source: ABdhPJzuUMYTwxoD6Be0fgMi8vjGomcIgc/33qufgHrwjBHGO7+ZPBh2d6fqFcJfjL6sG98DFQ8nsvt7hnR1jFZtn1E=
X-Received: by 2002:a19:ad02:: with SMTP id t2mr14282474lfc.82.1643061014920;
 Mon, 24 Jan 2022 13:50:14 -0800 (PST)
MIME-Version: 1.0
References: <202201200359.lTk9zHg4-lkp@intel.com> <39230575-13ea-7384-71bc-2aac1fa2edb8@intel.com>
In-Reply-To: <39230575-13ea-7384-71bc-2aac1fa2edb8@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 24 Jan 2022 13:50:02 -0800
Message-ID: <CAKwvOd=NVZs7bfz-OTnhPmk4xZfmJq6zQzJaEtaX4AO0N7Pi9A@mail.gmail.com>
Subject: Re: arch/arm/mach-ep93xx/clock.c:154:2: warning: Use of memory after
 it is freed [clang-analyzer-unix.Malloc]
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        kernel test robot <yujie.liu@intel.com>,
        Nathan Huckleberry <nhuck@google.com>,
        Philip Li <philip.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 5:46 PM kernel test robot <yujie.liu@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   1d1df41c5a33359a00e919d54eaebfb789711fdc
> commit: 9645ccc7bd7a16cd73c3be9dee70cd702b03be37 ep93xx: clock: convert in-place to COMMON_CLK
> date:   3 months ago
> config: arm-randconfig-c002-20220118 (https://download.01.org/0day-ci/archive/20220120/202201200359.lTk9zHg4-lkp@intel.com/config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5f782d25a742302d25ef3c8b84b54f7483c2deb9)
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # install arm cross compiling tool for clang build
>          # apt-get install binutils-arm-linux-gnueabi
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9645ccc7bd7a16cd73c3be9dee70cd702b03be37
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout 9645ccc7bd7a16cd73c3be9dee70cd702b03be37
>          # save the config file to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm clang-analyzer

Hey! This check finally caught something that looks legit! Cool to see
0day bot running clang-analyzer, too!
Nikita, can you PTAL?

>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
>
> clang-analyzer warnings: (new ones prefixed by >>)
>
>  >> arch/arm/mach-ep93xx/clock.c:154:2: warning: Use of memory after it is freed [clang-analyzer-unix.Malloc]
>             return &psc->hw;
>             ^
>     arch/arm/mach-ep93xx/clock.c:151:2: note: Taking true branch
>             if (IS_ERR(clk))
>             ^
>     arch/arm/mach-ep93xx/clock.c:152:3: note: Memory is released
>                     kfree(psc);
>                     ^~~~~~~~~~
>     arch/arm/mach-ep93xx/clock.c:154:2: note: Use of memory after it is freed
>             return &psc->hw;
>             ^      ~~~~~~~~
>  >> arch/arm/mach-ep93xx/clock.c:484:2: warning: Value stored to 'hw' is never read [clang-analyzer-deadcode.DeadStores]
>             hw = clk_hw_register_fixed_factor(NULL, "uart", "xtali", 0, 1, clk_uart_div);
>             ^    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  >> arch/arm/mach-ep93xx/clock.c:612:2: warning: Value stored to 'hw' is never read [clang-analyzer-deadcode.DeadStores]
>             hw = clk_hw_register_fixed_factor(NULL, "usb_clk", "pll2", 0, 1, clk_usb_div);
>             ^    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> vim +154 arch/arm/mach-ep93xx/clock.c
>
> ff05c0330b9880 Hartley Sweeten 2009-05-07  125
> 9645ccc7bd7a16 Nikita Shubin   2021-10-18  126  static struct clk_hw *ep93xx_clk_register_gate(const char *name,
> 9645ccc7bd7a16 Nikita Shubin   2021-10-18  127                                      const char *parent_name,
> 9645ccc7bd7a16 Nikita Shubin   2021-10-18  128                                      void __iomem *reg,
> 9645ccc7bd7a16 Nikita Shubin   2021-10-18  129                                      u8 bit_idx)
> 9645ccc7bd7a16 Nikita Shubin   2021-10-18  130  {
> 9645ccc7bd7a16 Nikita Shubin   2021-10-18  131          struct clk_init_data init;
> 9645ccc7bd7a16 Nikita Shubin   2021-10-18  132          struct clk_psc *psc;
> 9645ccc7bd7a16 Nikita Shubin   2021-10-18  133          struct clk *clk;
> 9645ccc7bd7a16 Nikita Shubin   2021-10-18  134
> 9645ccc7bd7a16 Nikita Shubin   2021-10-18  135          psc = kzalloc(sizeof(*psc), GFP_KERNEL);
> 9645ccc7bd7a16 Nikita Shubin   2021-10-18  136          if (!psc)
> 9645ccc7bd7a16 Nikita Shubin   2021-10-18  137                  return ERR_PTR(-ENOMEM);
> 9645ccc7bd7a16 Nikita Shubin   2021-10-18  138
> 9645ccc7bd7a16 Nikita Shubin   2021-10-18  139          init.name = name;
> 9645ccc7bd7a16 Nikita Shubin   2021-10-18  140          init.ops = &clk_ep93xx_gate_ops;
> 9645ccc7bd7a16 Nikita Shubin   2021-10-18  141          init.flags = CLK_SET_RATE_PARENT;
> 9645ccc7bd7a16 Nikita Shubin   2021-10-18  142          init.parent_names = (parent_name ? &parent_name : NULL);
> 9645ccc7bd7a16 Nikita Shubin   2021-10-18  143          init.num_parents = (parent_name ? 1 : 0);
> 9645ccc7bd7a16 Nikita Shubin   2021-10-18  144
> 9645ccc7bd7a16 Nikita Shubin   2021-10-18  145          psc->reg = reg;
> 9645ccc7bd7a16 Nikita Shubin   2021-10-18  146          psc->bit_idx = bit_idx;
> 9645ccc7bd7a16 Nikita Shubin   2021-10-18  147          psc->hw.init = &init;
> 9645ccc7bd7a16 Nikita Shubin   2021-10-18  148          psc->lock = &clk_lock;
> 9645ccc7bd7a16 Nikita Shubin   2021-10-18  149
> 9645ccc7bd7a16 Nikita Shubin   2021-10-18  150          clk = clk_register(NULL, &psc->hw);
> 9645ccc7bd7a16 Nikita Shubin   2021-10-18  151          if (IS_ERR(clk))
> 9645ccc7bd7a16 Nikita Shubin   2021-10-18  152                  kfree(psc);

probably should `return ERR_CAST(clk);` ?

> 9645ccc7bd7a16 Nikita Shubin   2021-10-18  153
> 9645ccc7bd7a16 Nikita Shubin   2021-10-18 @154          return &psc->hw;
> ff05c0330b9880 Hartley Sweeten 2009-05-07  155  }
> ff05c0330b9880 Hartley Sweeten 2009-05-07  156
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>


-- 
Thanks,
~Nick Desaulniers
