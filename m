Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5002647B1A8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 17:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239750AbhLTQxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 11:53:38 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35792 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbhLTQxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 11:53:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C95B8B80FAE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 16:53:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE7F3C36AEB;
        Mon, 20 Dec 2021 16:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640019215;
        bh=3tng0c+exoWLRMJhgUUBf8iWK6eeHHSOlliF3Y22w8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RQ8wMoXleAc54QXgk6aG90sPteIpAjI4Sclqch1tFNhfql2CkHysTEp9+R+oPStu2
         bV2EyQ/peBQeUuVJ1+kqM5iA0qE1nOKPtOGvglygUEwUMc47Qi5S50Qyarh0VlPI6q
         jHOJl3ph7/Rho44asibCYenHnd73IVnNnC6dXIsAcUx890C0OWjoRVGZa2i6Hdyb0J
         Jfnp6u2c/hm0cQifluxyoHKSAvEO+FHPyAzVkdYNCrqIwjo4RxP2m5moSzCYVzXD4A
         LmGcRa4IRR93xvjNFKzZYK/5tRXkA9uKRa3m8NNwUhLit3a6mVpJQbeX3L/IkJMDfD
         /ZhcWy+ocgY1Q==
Date:   Mon, 20 Dec 2021 09:53:30 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Long Li <longli@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [hyperv:hyperv-next 4/5] drivers/hv/vmbus_drv.c:2082:29:
 warning: shift count >= width of type
Message-ID: <YcC1CobR/n0tJhdV@archlinux-ax161>
References: <202112181827.o3X7GmHz-lkp@intel.com>
 <20211219122937.7zi3etrcl6rpob3t@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211219122937.7zi3etrcl6rpob3t@liuwe-devbox-debian-v2>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

On Sun, Dec 19, 2021 at 12:29:37PM +0000, Wei Liu wrote:
> On Sat, Dec 18, 2021 at 06:20:43PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git hyperv-next
> > head:   19fd7ca00201c0525452dcf5a490e4b01674ef4c
> > commit: 6327882f7b4a476ea902de4bee5657f1028d6859 [4/5] scsi: storvsc: Add Isolation VM support for storvsc driver
> > config: x86_64-randconfig-a013-20211216 (https://download.01.org/0day-ci/archive/20211218/202112181827.o3X7GmHz-lkp@intel.com/config)
> > compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 4c9e31a4814592bbda7153833e46728dc7b21100)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/commit/?id=6327882f7b4a476ea902de4bee5657f1028d6859
> >         git remote add hyperv https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
> >         git fetch --no-tags hyperv hyperv-next
> >         git checkout 6327882f7b4a476ea902de4bee5657f1028d6859
> >         # save the config file to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/hv/
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > >> drivers/hv/vmbus_drv.c:2082:29: warning: shift count >= width of type [-Wshift-count-overflow]
> >    static u64 vmbus_dma_mask = DMA_BIT_MASK(64);
> >                                ^~~~~~~~~~~~~~~~
> >    include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
> >    #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
> >                                                         ^ ~~~
> 
> I don't think there is anything wrong with the code. When n is 64 the
> problematic expression is not evaluated.

Yes, unfortunately, this is an outstanding bug in clang where it does
not properly build a control flow graph for expressions at a global
scope:

https://github.com/ClangBuiltLinux/linux/issues/92

We should absolutely fix that but it has not come up too often so other
fires have been prioritized. Now that -Werror is a thing, that issue's
priority should probably be upgraded, as this warning will break
allmodconfig for clang.

If you were feeling generous, just changing that to ~0ULL directly would
solve the warning but I get that it is less documentation that way.

Cheers,
Nathan
