Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AB54AB2FE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 01:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243159AbiBGAvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 19:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiBGAvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 19:51:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30711C06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 16:51:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3793B80EF6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 00:51:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADF2C340E9;
        Mon,  7 Feb 2022 00:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644195077;
        bh=CneIiPA+3Do76bXDt6QMh5eZOVdMR+SpRS/3Qgp6rlQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bcxqonbTYvUBOIkRbrPIf58g0HXkOdDh1Dv1X4eq4UJrguaYnohWFE7T1JgpUXD1C
         QG0owt0D1aqzIU63n7x+XtCbiqsV4McXX4H2sbTphLaKQoDzh4PNWfSv4P0ZVu0HrC
         s6STZaMfTpcBvlwTx7zQhjZqtXEYfpHe2VtyYqEBsjtcjhyGSvoZRfooqXU3OoMAcu
         Ki0ioFKewIGa4+n7KmLbGFK+YejKGEehxZzUplYKjEK61cYJyIzpe+xx2ba/4I1chj
         shRqVRXkqsZ96Fwy18FHgPJXWt0MxTA8pv99jZy1seJlztVTvX9N6JhlXH21ejbqtN
         ibOpKZZG4LI8Q==
Date:   Sun, 6 Feb 2022 17:51:13 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: Re: ld.lld: error: undefined symbol: socfpga_reset_init
Message-ID: <YgBtAdhl8dZVTAV+@dev-arch.archlinux-ax161>
References: <202202050539.Mtk9I4Ef-lkp@intel.com>
 <67f432e2-1bfd-29dc-f2ed-051b47ef0844@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67f432e2-1bfd-29dc-f2ed-051b47ef0844@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Sun, Feb 06, 2022 at 12:55:57PM +0100, Krzysztof Kozlowski wrote:
> On 04/02/2022 22:12, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   dcb85f85fa6f142aae1fe86f399d4503d49f2b60
> > commit: 4483397b03536506535d611b0cb28a81a69e8edf ARM: socfpga: drop ARCH_SOCFPGA
> > date:   11 months ago
> > config: arm-socfpga_defconfig (https://download.01.org/0day-ci/archive/20220205/202202050539.Mtk9I4Ef-lkp@intel.com/config)
> > compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a73e4ce6a59b01f0e37037761c1e6889d539d233)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install arm cross compiling tool for clang build
> >         # apt-get install binutils-arm-linux-gnueabi
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4483397b03536506535d611b0cb28a81a69e8edf
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout 4483397b03536506535d611b0cb28a81a69e8edf
> >         # save the config file to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> >>> ld.lld: error: undefined symbol: socfpga_reset_init
> >    >>> referenced by socfpga.c
> >    >>>               socfpga.o:(socfpga_init_irq) in archive arch/arm/mach-socfpga/built-in.a
> >    >>> referenced by socfpga.c
> >    >>>               socfpga.o:(socfpga_arria10_init_irq) in archive arch/arm/mach-socfpga/built-in.a
> > 
> 
> This looks like a false positive. On the socfpga defconfig arm build,
> the socfpga_reset_init() (drivers/reset/reset-socfpga.c) is built.
> 
> I also could not reproduce it with GCC.

I can reproduce this error with the configuration that the bot provides
at both 4483397b03536506535d611b0cb28a81a69e8edf and v5.17-rc3, even
with GCC:

$ curl -LSso .config https://download.01.org/0day-ci/archive/20220205/202202050539.Mtk9I4Ef-lkp@intel.com/config

$ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- olddefconfig all
...
arm-linux-gnueabi-ld: arch/arm/mach-socfpga/socfpga.o: in function `socfpga_init_irq':
socfpga.c:(.init.text+0x104): undefined reference to `socfpga_reset_init'
...

Whether or not this reproduces with the in-tree socfpga_defconfig, I am
not sure.

Cheers,
Nathan
