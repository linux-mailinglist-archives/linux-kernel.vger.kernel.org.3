Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0274B3B8E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 14:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236267AbiBMNXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 08:23:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiBMNXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 08:23:02 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE65C5EDCD
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 05:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644758576; x=1676294576;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GxJrhfVBCz/H7O2TphSoB4u7Dd6xcn05k7n/7dSPWCk=;
  b=cxOOvjRbUxUdre71WxA0kBS1rKAI1pIkuPkPVtXgh+RKrtvuL44vtTnX
   x/gJhn2jkUaZmvy5UMvKohVYZ05Hm7/rC1G4mUj63Dthw6kxFttvfCAC3
   FzgsKgEgzIwhqf1UFGi/f2d7ElnSuomDpE7OkMagNJRigNeSU49raIJM/
   fTz/dlbJudzGi3E1/jZJfPqOCxdF+Wv83NdnkqybaNpuHUL+zy1ouVlZt
   +k1C2QP3Co2ndxrIQ+O2ne62LDPEw78q5Tn4CaheP++DO4mvAODIMU9p6
   CV0JLj6yDtASpkhrSaZ/SrLmk0q0PPpZGr4mLDOEmPHJ+KLSj7dKekZEh
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10256"; a="248779238"
X-IronPort-AV: E=Sophos;i="5.88,365,1635231600"; 
   d="scan'208";a="248779238"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 05:22:56 -0800
X-IronPort-AV: E=Sophos;i="5.88,365,1635231600"; 
   d="scan'208";a="679947929"
Received: from rli9-dbox.sh.intel.com (HELO rli9-dbox) ([10.239.159.142])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 05:22:54 -0800
Date:   Sun, 13 Feb 2022 21:21:40 +0800
From:   Philip Li <philip.li@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>
Subject: Re: [kbuild-all] Re: include/linux/build_bug.h:78:41: error: static
 assertion failed: "offsetof(struct page, compound_head) == offsetof(struct
 folio, lru)"
Message-ID: <YgkF5GakbMb2CU6k@rli9-dbox>
References: <202202131828.VxAopBqR-lkp@intel.com>
 <Ygj3Wop0i5Ld0gXu@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ygj3Wop0i5Ld0gXu@casper.infradead.org>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2022 at 12:19:38PM +0000, Matthew Wilcox wrote:
> On Sun, Feb 13, 2022 at 07:00:16PM +0800, kernel test robot wrote:
> > config: parisc-randconfig-r004-20220213 (https://download.01.org/0day-ci/archive/20220213/202202131828.VxAopBqR-lkp@intel.com/config)
> > compiler: hppa64-linux-gcc (GCC) 11.2.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7b230db3b8d373219f88a3d25c8fbbf12cc7f233
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout 7b230db3b8d373219f88a3d25c8fbbf12cc7f233
> >         # save the config file to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc prepare
> 
> There's something weird going on here.
> 
> If I just download & install gcc-11-hppa64-linux-gnu from Debian, this
> config file builds just fine.
> 
> If I invoke make.cross as you have it here, I see the same error you
> report.

Sorry for the confusion here, we recently updated the way to build parisc
64 bit in the right way. But the change to make.cross (for reproducer) is
still under review.

We will double check this report and update make.cross to provide update
to you.

> 
> Adding 'V=1' to this, shows:
>   sh ../scripts/atomic/check-atomics.sh
>   /home/willy/0day/gcc-9.3.0-nolibc/hppa-linux/bin/hppa-linux-gcc [...]
> 
> which is weird, right?  It's not hppa64, and it's not gcc-11.2.  So my
> suspicion here is that there's some bug in your tooling which is reporting
> a bogus error.  You're probably better situated to debug this further
> than I am.
> 
> Oh, and I checked, in case the filename was confusing me:
> $ /home/willy/0day/gcc-9.3.0-nolibc/hppa-linux/bin/hppa-linux-gcc -v
> Using built-in specs.
> COLLECT_GCC=/home/willy/0day/gcc-9.3.0-nolibc/hppa-linux/bin/hppa-linux-gcc
> COLLECT_LTO_WRAPPER=/home/willy/0day/gcc-9.3.0-nolibc/hppa-linux/bin/../libexec/gcc/hppa-linux/9.3.0/lto-wrapper
> Target: hppa-linux
> Configured with: /tmp/build-crosstools-xh/gcc/gcc-9.3.0/configure --target=hppa-linux --enable-targets=all --prefix=/tmp/build-crosstools-xh/cross --enable-languages=c --without-headers --disable-bootstrap --disable-nls --disable-threads --disable-shared --disable-libmudflap --disable-libssp --disable-libgomp --disable-decimal-float --disable-libquadmath --disable-libatomic --disable-libcc1 --disable-libmpx --enable-checking=release
> Thread model: single
> gcc version 9.3.0 (GCC)
> 
> So it really is a 32-bit hppa build, and it really is gcc 9.3, not 11.2.
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
