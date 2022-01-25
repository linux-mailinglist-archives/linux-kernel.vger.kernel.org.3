Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B19B549BDB1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 22:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbiAYVIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 16:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiAYVIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 16:08:16 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AFFC06173B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 13:08:15 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id y15so50915339lfa.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 13:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OtVi+gYr5oCIwwJwKXK7nC+D6H67RoRnu5vA+C+KQjU=;
        b=ORy1GpE5yyyX/QlkYWpXyJId6rvf2LfHBzHbOCJiF2SXqHj6F4Peh7o4T99D2OTD/Z
         y0phNqpTawIq5gULH7WmXKDyD6Reb+GN2vpVvtRONWOGdMUpvkGqFvZqFvyuSW9KHWXw
         /A0kah3l+dPNAhb+w0VXwSNG4usOzZ+VTJekaO6hqAINGgEAENzLKkiwE1ixOH0mY5Kc
         So4XUAffFAgvYNUdd13tXLrFSEVXQDFeXtewtmfiUcmbDQM/VFhe4meIX0O77KN4pwgP
         8qnzr5V9iaSvzRzGEprxgryBhmIaRXC8qri061Y7A4tocI5CvjOCagwH+iPlug7jMcmX
         IGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OtVi+gYr5oCIwwJwKXK7nC+D6H67RoRnu5vA+C+KQjU=;
        b=vPH8Z10MuQy/mVVqbfYNUvKucjGXIzAngkwq54yr+LrQitEibFK86vGa8PwqdcS/W0
         yQWg1DXa7TeuZLbbYk50kM8GnDD23nZ6SJ39TcoA+Ot4dvFInXT9kqIdNsxSBgq2hoUz
         axxQE4FQt4POR/SDV2zwe9nvQTn6n29RwW0YTzzq5keypqcQoN0mn/915wwY+wF8HDWD
         cTlTxMhwgZ9X8d7Qqjn6bPcDKyG8ZZ7tVa1OIwtCGs+TClguNC+2Q1ruPYpZng1iYs6D
         ZRTQd6HrQwgzGPw5hZoH5m30QTJA3J/Ch6nd3wMcOVaWbRL1342MTq9BmPpHN+0JQ/PO
         c4cA==
X-Gm-Message-State: AOAM530yDZ3VhfkOuiws7gYbin+zR8TkVwxCGSRVDDCFC+l4o+8H2iuH
        JQ5trlv/gKclAqS/YOiJouuLFtKmpTyYyjJtLzz9eg==
X-Google-Smtp-Source: ABdhPJznbOC+xbjAMLEJoiCkubVGUqVrMLQCXmf5ToVtfuzkmZuoMVYTtcoJwfKld9FAOGUHvv3rC2+SLZ+jOyM9rQo=
X-Received: by 2002:a05:6512:b0d:: with SMTP id w13mr18036399lfu.240.1643144894037;
 Tue, 25 Jan 2022 13:08:14 -0800 (PST)
MIME-Version: 1.0
References: <202201200359.lTk9zHg4-lkp@intel.com> <39230575-13ea-7384-71bc-2aac1fa2edb8@intel.com>
 <CAKwvOd=NVZs7bfz-OTnhPmk4xZfmJq6zQzJaEtaX4AO0N7Pi9A@mail.gmail.com> <20220125110106.7043f846@redslave.neermore.group>
In-Reply-To: <20220125110106.7043f846@redslave.neermore.group>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 25 Jan 2022 13:08:01 -0800
Message-ID: <CAKwvOdkq6zeB0E1gAKMhLAgoaf11EAoBtgP1aLDFNobkQUcvEw@mail.gmail.com>
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

On Tue, Jan 25, 2022 at 12:01 AM Nikita Shubin
<nikita.shubin@maquefel.me> wrote:
>
> Hello Nick,
>
> On Mon, 24 Jan 2022 13:50:02 -0800
> Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> > On Wed, Jan 19, 2022 at 5:46 PM kernel test robot
> > <yujie.liu@intel.com> wrote:
> > >
> > > tree:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > > master head:   1d1df41c5a33359a00e919d54eaebfb789711fdc commit:
> > > 9645ccc7bd7a16cd73c3be9dee70cd702b03be37 ep93xx: clock: convert
> > > in-place to COMMON_CLK date:   3 months ago config:
> > > arm-randconfig-c002-20220118
> > > (https://download.01.org/0day-ci/archive/20220120/202201200359.lTk9zHg4-lkp@intel.com/config)
> > > compiler: clang version 14.0.0
> > > (https://github.com/llvm/llvm-project
> > > 5f782d25a742302d25ef3c8b84b54f7483c2deb9) reproduce (this is a W=1
> > > build): wget
> > > https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> > > -O ~/bin/make.cross chmod +x ~/bin/make.cross # install arm cross
> > > compiling tool for clang build # apt-get install
> > > binutils-arm-linux-gnueabi #
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9645ccc7bd7a16cd73c3be9dee70cd702b03be37
> > > git remote add linus
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > > git fetch --no-tags linus master git checkout
> > > 9645ccc7bd7a16cd73c3be9dee70cd702b03be37 # save the config file to
> > > linux build tree COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang
> > > make.cross ARCH=arm clang-analyzer
> >
> > Hey! This check finally caught something that looks legit! Cool to see
> > 0day bot running clang-analyzer, too!
> > Nikita, can you PTAL?
>
> Of course, i thought Alexander Sverdlin - already took care of it, he
> is really fast and fires patches before i even realize what happens.
>
> Alexander have you already taken care of it ? If not it's my turn to
> clear my own mess.

Alexander sent me privately the link to:
https://lore.kernel.org/lkml/20220120133739.4170298-2-alexander.sverdlin@gmail.com/T/

>
> >
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > >
> > > clang-analyzer warnings: (new ones prefixed by >>)
> > >
> > >  >> arch/arm/mach-ep93xx/clock.c:154:2: warning: Use of memory
> > >  >> after it is freed [clang-analyzer-unix.Malloc]
> > >             return &psc->hw;
> > >             ^
> > >     arch/arm/mach-ep93xx/clock.c:151:2: note: Taking true branch
> > >             if (IS_ERR(clk))
> > >             ^
> > >     arch/arm/mach-ep93xx/clock.c:152:3: note: Memory is released
> > >                     kfree(psc);
> > >                     ^~~~~~~~~~
> > >     arch/arm/mach-ep93xx/clock.c:154:2: note: Use of memory after
> > > it is freed return &psc->hw;
> > >             ^      ~~~~~~~~
> > >  >> arch/arm/mach-ep93xx/clock.c:484:2: warning: Value stored to
> > >  >> 'hw' is never read [clang-analyzer-deadcode.DeadStores]
> > >             hw = clk_hw_register_fixed_factor(NULL, "uart",
> > > "xtali", 0, 1, clk_uart_div); ^
> > > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >
> > >  >> arch/arm/mach-ep93xx/clock.c:612:2: warning: Value stored to
> > >  >> 'hw' is never read [clang-analyzer-deadcode.DeadStores]
> > >             hw = clk_hw_register_fixed_factor(NULL, "usb_clk",
> > > "pll2", 0, 1, clk_usb_div); ^
> > > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >
> > > vim +154 arch/arm/mach-ep93xx/clock.c
> > >
> > > ff05c0330b9880 Hartley Sweeten 2009-05-07  125
> > > 9645ccc7bd7a16 Nikita Shubin   2021-10-18  126  static struct
> > > clk_hw *ep93xx_clk_register_gate(const char *name, 9645ccc7bd7a16
> > > Nikita Shubin   2021-10-18  127
> > >  const char *parent_name, 9645ccc7bd7a16 Nikita Shubin   2021-10-18
> > >  128                                      void __iomem *reg,
> > > 9645ccc7bd7a16 Nikita Shubin   2021-10-18  129
> > >                 u8 bit_idx) 9645ccc7bd7a16 Nikita Shubin
> > > 2021-10-18  130  { 9645ccc7bd7a16 Nikita Shubin   2021-10-18  131
> > >        struct clk_init_data init; 9645ccc7bd7a16 Nikita Shubin
> > > 2021-10-18  132          struct clk_psc *psc; 9645ccc7bd7a16 Nikita
> > > Shubin   2021-10-18  133          struct clk *clk; 9645ccc7bd7a16
> > > Nikita Shubin   2021-10-18  134 9645ccc7bd7a16 Nikita Shubin
> > > 2021-10-18  135          psc = kzalloc(sizeof(*psc), GFP_KERNEL);
> > > 9645ccc7bd7a16 Nikita Shubin   2021-10-18  136          if (!psc)
> > > 9645ccc7bd7a16 Nikita Shubin   2021-10-18  137
> > > return ERR_PTR(-ENOMEM); 9645ccc7bd7a16 Nikita Shubin   2021-10-18
> > > 138 9645ccc7bd7a16 Nikita Shubin   2021-10-18  139
> > > init.name = name; 9645ccc7bd7a16 Nikita Shubin   2021-10-18  140
> > >       init.ops = &clk_ep93xx_gate_ops; 9645ccc7bd7a16 Nikita Shubin
> > >   2021-10-18  141          init.flags = CLK_SET_RATE_PARENT;
> > > 9645ccc7bd7a16 Nikita Shubin   2021-10-18  142
> > > init.parent_names = (parent_name ? &parent_name : NULL);
> > > 9645ccc7bd7a16 Nikita Shubin   2021-10-18  143
> > > init.num_parents = (parent_name ? 1 : 0); 9645ccc7bd7a16 Nikita
> > > Shubin   2021-10-18  144 9645ccc7bd7a16 Nikita Shubin   2021-10-18
> > > 145          psc->reg = reg; 9645ccc7bd7a16 Nikita Shubin
> > > 2021-10-18  146          psc->bit_idx = bit_idx; 9645ccc7bd7a16
> > > Nikita Shubin   2021-10-18  147          psc->hw.init = &init;
> > > 9645ccc7bd7a16 Nikita Shubin   2021-10-18  148          psc->lock =
> > > &clk_lock; 9645ccc7bd7a16 Nikita Shubin   2021-10-18  149
> > > 9645ccc7bd7a16 Nikita Shubin   2021-10-18  150          clk =
> > > clk_register(NULL, &psc->hw); 9645ccc7bd7a16 Nikita Shubin
> > > 2021-10-18  151          if (IS_ERR(clk)) 9645ccc7bd7a16 Nikita
> > > Shubin   2021-10-18  152                  kfree(psc);
> >
> > probably should `return ERR_CAST(clk);` ?
> >
> > > 9645ccc7bd7a16 Nikita Shubin   2021-10-18  153
> > > 9645ccc7bd7a16 Nikita Shubin   2021-10-18 @154          return
> > > &psc->hw; ff05c0330b9880 Hartley Sweeten 2009-05-07  155  }
> > > ff05c0330b9880 Hartley Sweeten 2009-05-07  156
> > >
> > > ---
> > > 0-DAY CI Kernel Test Service, Intel Corporation
> > > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> > >
> >
> >
>


-- 
Thanks,
~Nick Desaulniers
