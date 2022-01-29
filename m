Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE2C4A31CD
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 21:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348567AbiA2UXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 15:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234289AbiA2UXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 15:23:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77398C061714
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 12:23:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 770A660A66
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 20:23:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B013C340E5;
        Sat, 29 Jan 2022 20:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643487781;
        bh=ibfNrnDd+VmWeyoly0lQUrC025/BUGr3gbVTET9B04U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fay9tk8OjFXVk8vdBucFW8q9Lae+bmmvVnF+NZk2vUuCFrD1LhEIZ+xhKsX/cmjBw
         byAdYx7nhRN2gpaSNxhehoU6ddWrV/7C2K6bm6YAVygo9VGhlKYjEzMrjcelsIU4oN
         BefZ0+fqcC+pwugYwINovryHY3EBFY+0/K9vC/2ClF4V4kvPTdLb2J5xibyhp4HX17
         MRTPWKZG2wOZw/DEeYB20W77WnJfMXea2zz6/7Jix67Yl0Y590atXG3y6h6IM+irbB
         YI8MTa/BDGqcN91XQPLybQgd8yVc2l6yJydPx5HzDb57DBzuRCdU7FUmEM3xjczwJa
         v91eGA2cnfY0w==
Date:   Sat, 29 Jan 2022 13:22:57 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     "Justin M. Forbes" <jforbes@fedoraproject.org>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        "Jason A. Donenfeld" <zx2c4@kernel.org>
Subject: Re: arch/arm/lib/xor-neon.c:30:2: warning: This code requires at
 least version 4.6 of GCC
Message-ID: <YfWiIZ9QZuWRTYRy@dev-arch.archlinux-ax161>
References: <202201291408.Pkylyt75-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202201291408.Pkylyt75-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2022 at 03:02:58PM +0800, kernel test robot wrote:
> Hi Justin,
> 
> First bad commit (maybe != root cause):

Yeah, this commit definitely does not introduce this warning, it has
been one of our longest tracked warnings.

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   169387e2aa291a4e3cb856053730fe99d6cec06f
> commit: e56e18985596617ae426ed5997fb2e737cffb58b lib/crypto: add prompts back to crypto libraries
> date:   11 days ago
> config: arm-randconfig-r004-20220128 (https://download.01.org/0day-ci/archive/20220129/202201291408.Pkylyt75-lkp@intel.com/config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 33b45ee44b1f32ffdbc995e6fec806271b4b3ba4)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e56e18985596617ae426ed5997fb2e737cffb58b
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout e56e18985596617ae426ed5997fb2e737cffb58b
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> arch/arm/lib/xor-neon.c:30:2: warning: This code requires at least version 4.6 of GCC [-W#warnings]
>    #warning This code requires at least version 4.6 of GCC
>     ^
>    1 warning generated.

https://github.com/ClangBuiltLinux/linux/issues/496

https://lore.kernel.org/r/20220127081227.2430-3-ardb@kernel.org/

Cheers,
Nathan
