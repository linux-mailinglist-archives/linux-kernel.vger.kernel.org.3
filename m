Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E5451ACA3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377114AbiEDSYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377491AbiEDSYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:24:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50695A147A
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 10:48:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B899FB827A5
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 17:48:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0657C385A5;
        Wed,  4 May 2022 17:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651686529;
        bh=e8wlpzu01p00GXxLrMBw1AHGF6QBSQftauK15PaYFC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gC2b/3IjDBS6efhvpKAC0TilIdXJzbZRO8OhUUqPEvXsO6EMbXH8BGOm4RjB9zep8
         to7WYxb1RsLgb3yWZ4AS3bDWRGfWF9OukK5Daur7tSIy5sPpTI8P6j5hcu7RHxZchE
         /VrrvbSkirO0gEba/eippVNc9QPjDhJgvMyh16eAJReI5K4iYu/ckCvo3YgUDVmGj9
         ngktJHd1+E0jdIbzDkoDErhs5s2V9MFdg0Et6WgFPwnetSQNxFnFeysOw0LPdsJyyG
         NDJExB7hIGD1Xv+SdVG9cnSgy59soykRsHDqUqW5SOikgt1MrdcFxfoUSFf1BwgTvQ
         b3KcdE/bWryZA==
Date:   Wed, 4 May 2022 10:48:47 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Leonardo Bras <leobras@redhat.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: ld.lld: error: inline assembly requires more registers than
 available at line 523
Message-ID: <YnK8f7cqMoHxSi0C@dev-arch.thelio-3990X>
References: <202205020637.JVJo3blw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202205020637.JVJo3blw-lkp@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 06:29:38AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   672c0c5173427e6b3e2a9bbb7be51ceeec78093a
> commit: ba1f77c546966c12d86220d078e5838dcaeab348 x86/kvm: Fix compilation warning in non-x86_64 builds
> date:   2 months ago
> config: i386-randconfig-a012-20220502 (https://download.01.org/0day-ci/archive/20220502/202205020637.JVJo3blw-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 09325d36061e42b495d1f4c7e933e260eac260ed)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ba1f77c546966c12d86220d078e5838dcaeab348
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout ba1f77c546966c12d86220d078e5838dcaeab348
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> ld.lld: error: inline assembly requires more registers than available at line 523
> >> ld.lld: error: inline assembly requires more registers than available at line 523
> 

I don't think this bisection result is correct; this error is visible at
v5.17-rc3, which this commit is based on. This is likely the same root
cause as https://github.com/ClangBuiltLinux/linux/issues/1589, just with
LTO. I'll reduce something down and comment there if it turns out to be
different.

Cheers,
Nathan
