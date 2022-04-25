Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED7050E4EB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243091AbiDYP67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243089AbiDYP6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:58:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE86C3D487
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 08:55:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D4C1B818A9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 15:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F74C385A4;
        Mon, 25 Apr 2022 15:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650902140;
        bh=ZW82ZLMbhdXSy8UotfQV6E6jNOl+p7+/+EOiVUC+rF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oWKy/UZGQWW/XrYnC4BpASPtoFJ41o0ES40ise3BoWQQECDs0pei+PfcT8BfBYQ1l
         ZX9tUANUnAygrpfRUigYf5VjSrszMir6eRzeb1os5HwVNg32fxWcREIfafzd4D+QVY
         YBcLINEr1FKxahg3zVwMnnxfwdI7/amRvdIwsDbg=
Date:   Mon, 25 Apr 2022 17:55:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: Re: [stable:linux-5.10.y 2705/5321] WARNING: modpost:
 vmlinux.o(.text+0x8cc4): Section mismatch in reference from the function
 __arm_ioremap_pfn_caller() to the function
 .meminit.text:memblock_is_map_memory()
Message-ID: <YmbEempwznDkAJ84@kroah.com>
References: <202204220723.zOZ7gZGT-lkp@intel.com>
 <YmKGohqgR21F1zpX@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmKGohqgR21F1zpX@linux.ibm.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 01:42:42PM +0300, Mike Rapoport wrote:
> On Fri, Apr 22, 2022 at 07:37:19AM +0800, kernel test robot wrote:
> > Hi Mike,
> > 
> > FYI, the error/warning still remains.
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
> > head:   1052f9bce62982023737a95b7ff1ad26a5149af6
> > commit: 8dd559d53b3b2de960ca1ec1359f5a9b4a12e181 [2705/5321] arm: ioremap: don't abuse pfn_valid() to check if pfn is in RAM
> > config: arm-hackkit_defconfig (https://download.01.org/0day-ci/archive/20220422/202204220723.zOZ7gZGT-lkp@intel.com/config)
> > compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5bd87350a5ae429baf8f373cb226a57b62f87280)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install arm cross compiling tool for clang build
> >         # apt-get install binutils-arm-linux-gnueabi
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=8dd559d53b3b2de960ca1ec1359f5a9b4a12e181
> >         git remote add stable https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
> >         git fetch --no-tags stable linux-5.10.y
> >         git checkout 8dd559d53b3b2de960ca1ec1359f5a9b4a12e181
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All warnings (new ones prefixed by >>, old ones prefixed by <<):
> > 
> > >> WARNING: modpost: vmlinux.o(.text+0x8cc4): Section mismatch in reference from the function __arm_ioremap_pfn_caller() to the function .meminit.text:memblock_is_map_memory()
> > The function __arm_ioremap_pfn_caller() references
> > the function __meminit memblock_is_map_memory().
> > This is often because __arm_ioremap_pfn_caller lacks a __meminit
> > annotation or the annotation of memblock_is_map_memory is wrong.
> 
> In 5.10 the hackkit defconfig does not select ARCH_KEEP_MEMBLOCK which is
> required for memblock_is_map_memory() to function after boot.
> 
> In upstream kernels ARCH_KEEP_MEMBLOCK is always selected by ARM after
> commit 5e545df3292f ("arm: remove CONFIG_ARCH_HAS_HOLES_MEMORYMODEL")
> 
> So the fix would be either to backport 5e545df3292f or unconditionally
> select ARCH_KEEP_MEMBLOCK on ARM in 5.10.
> 
> (the same applies to 5.4)
> 
> Greg, what is your preference?

I'll defer to you all, but normally I prefer whatever is in Linus's
tree.

thanks,

greg k-h
