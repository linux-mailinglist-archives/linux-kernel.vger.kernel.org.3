Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C2749AF0B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 10:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1454352AbiAYI7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 03:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1453978AbiAYI4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 03:56:52 -0500
Received: from forward500j.mail.yandex.net (forward500j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5664AC058CB3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 00:01:25 -0800 (PST)
Received: from vla1-d53b4f396d89.qloud-c.yandex.net (vla1-d53b4f396d89.qloud-c.yandex.net [IPv6:2a02:6b8:c0d:b8c:0:640:d53b:4f39])
        by forward500j.mail.yandex.net (Yandex) with ESMTP id 748156CB6689;
        Tue, 25 Jan 2022 11:01:08 +0300 (MSK)
Received: from vla1-62318bfe5573.qloud-c.yandex.net (vla1-62318bfe5573.qloud-c.yandex.net [2a02:6b8:c0d:3819:0:640:6231:8bfe])
        by vla1-d53b4f396d89.qloud-c.yandex.net (mxback/Yandex) with ESMTP id pNAwKE7dnK-17d8u1YQ;
        Tue, 25 Jan 2022 11:01:08 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1643097668;
        bh=q9aiavGIEsjbNTguZm0W5pY728tsRKPQNL57qb/RJnA=;
        h=In-Reply-To:Subject:To:From:References:Date:Message-ID:Cc;
        b=FcSm1notg3awy/NpOlZDklhUfmE4arK/fI6+B9/ury8N/qa7hpcSzj1jJGVSfeCLT
         syMQDpKguyReiAdhZpVjwp4KEMJRHu4XaZdpqXHQ9YS2zJBPef9BHcirc4sKVcmWQK
         7ZBq+XmpKRNQ3x5x7xmd87n9vKAKAGFfF0JBDcbI=
Authentication-Results: vla1-d53b4f396d89.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by vla1-62318bfe5573.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id yIWdB9Nobz-17IiQ4Sd;
        Tue, 25 Jan 2022 11:01:07 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 2
Date:   Tue, 25 Jan 2022 11:01:06 +0300
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        kernel test robot <yujie.liu@intel.com>,
        Nathan Huckleberry <nhuck@google.com>,
        Philip Li <philip.li@intel.com>
Subject: Re: arch/arm/mach-ep93xx/clock.c:154:2: warning: Use of memory
 after it is freed [clang-analyzer-unix.Malloc]
Message-ID: <20220125110106.7043f846@redslave.neermore.group>
In-Reply-To: <CAKwvOd=NVZs7bfz-OTnhPmk4xZfmJq6zQzJaEtaX4AO0N7Pi9A@mail.gmail.com>
References: <202201200359.lTk9zHg4-lkp@intel.com>
        <39230575-13ea-7384-71bc-2aac1fa2edb8@intel.com>
        <CAKwvOd=NVZs7bfz-OTnhPmk4xZfmJq6zQzJaEtaX4AO0N7Pi9A@mail.gmail.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nick,

On Mon, 24 Jan 2022 13:50:02 -0800
Nick Desaulniers <ndesaulniers@google.com> wrote:

> On Wed, Jan 19, 2022 at 5:46 PM kernel test robot
> <yujie.liu@intel.com> wrote:
> >
> > tree:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > master head:   1d1df41c5a33359a00e919d54eaebfb789711fdc commit:
> > 9645ccc7bd7a16cd73c3be9dee70cd702b03be37 ep93xx: clock: convert
> > in-place to COMMON_CLK date:   3 months ago config:
> > arm-randconfig-c002-20220118
> > (https://download.01.org/0day-ci/archive/20220120/202201200359.lTk9zHg4-lkp@intel.com/config)
> > compiler: clang version 14.0.0
> > (https://github.com/llvm/llvm-project
> > 5f782d25a742302d25ef3c8b84b54f7483c2deb9) reproduce (this is a W=1
> > build): wget
> > https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> > -O ~/bin/make.cross chmod +x ~/bin/make.cross # install arm cross
> > compiling tool for clang build # apt-get install
> > binutils-arm-linux-gnueabi #
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9645ccc7bd7a16cd73c3be9dee70cd702b03be37
> > git remote add linus
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > git fetch --no-tags linus master git checkout
> > 9645ccc7bd7a16cd73c3be9dee70cd702b03be37 # save the config file to
> > linux build tree COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang
> > make.cross ARCH=arm clang-analyzer  
> 
> Hey! This check finally caught something that looks legit! Cool to see
> 0day bot running clang-analyzer, too!
> Nikita, can you PTAL?

Of course, i thought Alexander Sverdlin - already took care of it, he
is really fast and fires patches before i even realize what happens.

Alexander have you already taken care of it ? If not it's my turn to
clear my own mess.

> 
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> >
> > clang-analyzer warnings: (new ones prefixed by >>)
> >  
> >  >> arch/arm/mach-ep93xx/clock.c:154:2: warning: Use of memory
> >  >> after it is freed [clang-analyzer-unix.Malloc]  
> >             return &psc->hw;
> >             ^
> >     arch/arm/mach-ep93xx/clock.c:151:2: note: Taking true branch
> >             if (IS_ERR(clk))
> >             ^
> >     arch/arm/mach-ep93xx/clock.c:152:3: note: Memory is released
> >                     kfree(psc);
> >                     ^~~~~~~~~~
> >     arch/arm/mach-ep93xx/clock.c:154:2: note: Use of memory after
> > it is freed return &psc->hw;
> >             ^      ~~~~~~~~  
> >  >> arch/arm/mach-ep93xx/clock.c:484:2: warning: Value stored to
> >  >> 'hw' is never read [clang-analyzer-deadcode.DeadStores]  
> >             hw = clk_hw_register_fixed_factor(NULL, "uart",
> > "xtali", 0, 1, clk_uart_div); ^
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >  
> >  >> arch/arm/mach-ep93xx/clock.c:612:2: warning: Value stored to
> >  >> 'hw' is never read [clang-analyzer-deadcode.DeadStores]  
> >             hw = clk_hw_register_fixed_factor(NULL, "usb_clk",
> > "pll2", 0, 1, clk_usb_div); ^
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > vim +154 arch/arm/mach-ep93xx/clock.c
> >
> > ff05c0330b9880 Hartley Sweeten 2009-05-07  125
> > 9645ccc7bd7a16 Nikita Shubin   2021-10-18  126  static struct
> > clk_hw *ep93xx_clk_register_gate(const char *name, 9645ccc7bd7a16
> > Nikita Shubin   2021-10-18  127
> >  const char *parent_name, 9645ccc7bd7a16 Nikita Shubin   2021-10-18
> >  128                                      void __iomem *reg,
> > 9645ccc7bd7a16 Nikita Shubin   2021-10-18  129
> >                 u8 bit_idx) 9645ccc7bd7a16 Nikita Shubin
> > 2021-10-18  130  { 9645ccc7bd7a16 Nikita Shubin   2021-10-18  131
> >        struct clk_init_data init; 9645ccc7bd7a16 Nikita Shubin
> > 2021-10-18  132          struct clk_psc *psc; 9645ccc7bd7a16 Nikita
> > Shubin   2021-10-18  133          struct clk *clk; 9645ccc7bd7a16
> > Nikita Shubin   2021-10-18  134 9645ccc7bd7a16 Nikita Shubin
> > 2021-10-18  135          psc = kzalloc(sizeof(*psc), GFP_KERNEL);
> > 9645ccc7bd7a16 Nikita Shubin   2021-10-18  136          if (!psc)
> > 9645ccc7bd7a16 Nikita Shubin   2021-10-18  137
> > return ERR_PTR(-ENOMEM); 9645ccc7bd7a16 Nikita Shubin   2021-10-18
> > 138 9645ccc7bd7a16 Nikita Shubin   2021-10-18  139
> > init.name = name; 9645ccc7bd7a16 Nikita Shubin   2021-10-18  140
> >       init.ops = &clk_ep93xx_gate_ops; 9645ccc7bd7a16 Nikita Shubin
> >   2021-10-18  141          init.flags = CLK_SET_RATE_PARENT;
> > 9645ccc7bd7a16 Nikita Shubin   2021-10-18  142
> > init.parent_names = (parent_name ? &parent_name : NULL);
> > 9645ccc7bd7a16 Nikita Shubin   2021-10-18  143
> > init.num_parents = (parent_name ? 1 : 0); 9645ccc7bd7a16 Nikita
> > Shubin   2021-10-18  144 9645ccc7bd7a16 Nikita Shubin   2021-10-18
> > 145          psc->reg = reg; 9645ccc7bd7a16 Nikita Shubin
> > 2021-10-18  146          psc->bit_idx = bit_idx; 9645ccc7bd7a16
> > Nikita Shubin   2021-10-18  147          psc->hw.init = &init;
> > 9645ccc7bd7a16 Nikita Shubin   2021-10-18  148          psc->lock =
> > &clk_lock; 9645ccc7bd7a16 Nikita Shubin   2021-10-18  149
> > 9645ccc7bd7a16 Nikita Shubin   2021-10-18  150          clk =
> > clk_register(NULL, &psc->hw); 9645ccc7bd7a16 Nikita Shubin
> > 2021-10-18  151          if (IS_ERR(clk)) 9645ccc7bd7a16 Nikita
> > Shubin   2021-10-18  152                  kfree(psc);  
> 
> probably should `return ERR_CAST(clk);` ?
> 
> > 9645ccc7bd7a16 Nikita Shubin   2021-10-18  153
> > 9645ccc7bd7a16 Nikita Shubin   2021-10-18 @154          return
> > &psc->hw; ff05c0330b9880 Hartley Sweeten 2009-05-07  155  }
> > ff05c0330b9880 Hartley Sweeten 2009-05-07  156
> >
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> >  
> 
> 

