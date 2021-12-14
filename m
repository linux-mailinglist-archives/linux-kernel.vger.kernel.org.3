Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9DE474B17
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 19:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237095AbhLNSlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 13:41:35 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:43298 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbhLNSle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 13:41:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 621CECE0494
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 18:41:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33447C34600;
        Tue, 14 Dec 2021 18:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639507291;
        bh=Lm/tT7fRE229vkUkryx0iiaG7TEWf4gIZp4cgRrskN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZzwfYXCfcXQJISn378p8zpFZRx21maaKTC5rSiqdJlL9YhEGSZmx4jYbjBBhOFiC4
         2K0a9T7ysMCq09XbYHOCz3QgxvmJD0DbTa/YIWaYaYtdGzquS9VB4hMBpea+XhbBj/
         jKOCuTHP/UMVUQMMywT9ZU3byKra/tb5FFnetE3tzXw97kB62KosKHx0M7ZqTyLieT
         gYbGpPCxYdSDyA1AvgMbMEWzfpvPNbam2YAtMDYkUk1EKudItHQXEUsCcmOqkqV7Fd
         TH/zmK1mb5ky9eNgXUEkVwCsU/ZEN7QLq3C+8lZZ9L0otLu0hfGbwb76eXdy5HaIwQ
         TJ/11yrLe9t7Q==
Date:   Tue, 14 Dec 2021 11:41:27 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Jason Wang <wangborong@cdjrlc.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: drivers/pinctrl/bcm/pinctrl-bcm2835.c:412:14: warning: variable
 'group' is used uninitialized whenever 'for' loop exits because its
 condition is false
Message-ID: <YbjlV4HdWI8WUcAR@archlinux-ax161>
References: <202112142208.QW0tVv0m-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202112142208.QW0tVv0m-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 10:44:28PM +0800, kernel test robot wrote:
> Hi Jason,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   5472f14a37421d1bca3dddf33cabd3bd6dbefbbc
> commit: 29d45a642d4ea8de7e89b57f856046df7c3b219f pinctrl: bcm2835: Replace BUG with BUG_ON
> date:   5 months ago
> config: mips-randconfig-c004-20211214 (https://download.01.org/0day-ci/archive/20211214/202112142208.QW0tVv0m-lkp@intel.com/config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project b6a2ddb6c8ac29412b1361810972e15221fa021c)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install mips cross compiling tool for clang build
>         # apt-get install binutils-mips-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=29d45a642d4ea8de7e89b57f856046df7c3b219f
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 29d45a642d4ea8de7e89b57f856046df7c3b219f
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/pinctrl/bcm/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/pinctrl/bcm/pinctrl-bcm2835.c:412:14: warning: variable 'group' is used uninitialized whenever 'for' loop exits because its condition is false [-Wsometimes-uninitialized]
>            for (i = 0; i < BCM2835_NUM_IRQS; i++) {
>                        ^~~~~~~~~~~~~~~~~~~~
>    drivers/pinctrl/bcm/pinctrl-bcm2835.c:423:10: note: uninitialized use occurs here
>            switch (group) {
>                    ^~~~~
>    drivers/pinctrl/bcm/pinctrl-bcm2835.c:412:14: note: remove the condition if it is always true
>            for (i = 0; i < BCM2835_NUM_IRQS; i++) {
>                        ^~~~~~~~~~~~~~~~~~~~
>    drivers/pinctrl/bcm/pinctrl-bcm2835.c:409:11: note: initialize the variable 'group' to silence this warning
>            int group;
>                     ^
>                      = 0
>    1 warning generated.

It seems like MIP's __BUG_ON() makes it harder for clang to figure out
that 'i == BCM2835_NUM_IRQS' will make the kernel panic, which is the
only way that the loop exits because the condition is false.

I am not really sure of a way to fix this other than just reverting that
change or changing the BUG_ON() to WARN_ON().

Cheers,
Nathan
