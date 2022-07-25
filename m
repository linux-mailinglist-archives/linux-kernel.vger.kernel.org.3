Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788F257F833
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 04:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbiGYCM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 22:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiGYCMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 22:12:55 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533D3F59D
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 19:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658715174; x=1690251174;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=J/0nExjUwS+y/8SNBhXGqNjhjg5I/y73xdQHb03ycIw=;
  b=gJq7pb3N+xAyivxh264Yb/aaT2jTExWAvrKgxqTXqhVPQjyi+1ahgGyX
   P/v/JZ0WTaPsSZ25H6XhAbBx/08lTa1CVVEu3S+SXDJw8Klq0r+fmbHx+
   Fk4+x/69RsyMTOL9TKKDZs6c4emzBNBQkU3jfJc2jnwvM2eFX6BReVBgP
   i3uWiMak+KHap4y1onK8mYLBsnkK+9BDmnF3RglWLnSyDRrHRx/K8UrQb
   JKbtzXnAe2kgBmr/NBecVPHoqji6dzdDPlFWdeE/SXxImuzVEvrFB95oR
   a6sA3+ZzYJAZ3lTKCqGlRU1tyzgjgy1MWch2KgSB3P9KxzUJIZiR5Py3R
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="267984988"
X-IronPort-AV: E=Sophos;i="5.93,191,1654585200"; 
   d="scan'208";a="267984988"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 19:12:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,191,1654585200"; 
   d="scan'208";a="657971723"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 24 Jul 2022 19:12:52 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFnaW-0004dB-00;
        Mon, 25 Jul 2022 02:12:52 +0000
Date:   Mon, 25 Jul 2022 10:12:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: net/ipv4/ip_sockglue.c:838:7: warning: taking address of packed
 member 'gf_group' of class or structure 'compat_group_filter::(anonymous
 union)::(anonymous)' may result in an unaligned pointer value
Message-ID: <202207251043.l8Cq3k4Z-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e0dccc3b76fb35bb257b4118367a883073d7390e
commit: db243b796439c0caba47865564d8acd18a301d18 net/ipv4/ipv6: Replace one-element arraya with flexible-array members
date:   12 months ago
config: arm-colibri_pxa300_defconfig (https://download.01.org/0day-ci/archive/20220725/202207251043.l8Cq3k4Z-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 12fbd2d377e396ad61bce56d71c98a1eb1bebfa9)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=db243b796439c0caba47865564d8acd18a301d18
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout db243b796439c0caba47865564d8acd18a301d18
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash net/ipv4/ net/ipv6/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/ipv4/ip_sockglue.c:838:7: warning: taking address of packed member 'gf_group' of class or structure 'compat_group_filter::(anonymous union)::(anonymous)' may result in an unaligned pointer value [-Waddress-of-packed-member]
                                    &gf32->gf_group, gf32->gf_slist_flex);
                                     ^~~~~~~~~~~~~~
>> net/ipv4/ip_sockglue.c:1509:29: warning: taking address of packed member 'gf_fmode' of class or structure 'compat_group_filter::(anonymous union)::(anonymous)' may result in an unaligned pointer value [-Waddress-of-packed-member]
               put_user(gf.gf_fmode, &p->gf_fmode) ||
                                      ^~~~~~~~~~~
   arch/arm/include/asm/uaccess.h:406:26: note: expanded from macro 'put_user'
           __put_user_switch((x), (ptr), __pu_err, __put_user_check);      \
                                   ^~~
   arch/arm/include/asm/uaccess.h:388:22: note: expanded from macro '__put_user_switch'
                   const __typeof__(*(ptr)) __user *__pu_ptr = (ptr);      \
                                      ^~~
>> net/ipv4/ip_sockglue.c:1509:29: warning: taking address of packed member 'gf_fmode' of class or structure 'compat_group_filter::(anonymous union)::(anonymous)' may result in an unaligned pointer value [-Waddress-of-packed-member]
               put_user(gf.gf_fmode, &p->gf_fmode) ||
                                      ^~~~~~~~~~~
   arch/arm/include/asm/uaccess.h:406:26: note: expanded from macro 'put_user'
           __put_user_switch((x), (ptr), __pu_err, __put_user_check);      \
                                   ^~~
   arch/arm/include/asm/uaccess.h:389:16: note: expanded from macro '__put_user_switch'
                   __typeof__(*(ptr)) __pu_val = (x);                      \
                                ^~~
>> net/ipv4/ip_sockglue.c:1509:29: warning: taking address of packed member 'gf_fmode' of class or structure 'compat_group_filter::(anonymous union)::(anonymous)' may result in an unaligned pointer value [-Waddress-of-packed-member]
               put_user(gf.gf_fmode, &p->gf_fmode) ||
                                      ^~~~~~~~~~~
   arch/arm/include/asm/uaccess.h:406:26: note: expanded from macro 'put_user'
           __put_user_switch((x), (ptr), __pu_err, __put_user_check);      \
                                   ^~~
   arch/arm/include/asm/uaccess.h:393:20: note: expanded from macro '__put_user_switch'
                   switch (sizeof(*(ptr))) {                               \
                                    ^~~
>> net/ipv4/ip_sockglue.c:1510:30: warning: taking address of packed member 'gf_numsrc' of class or structure 'compat_group_filter::(anonymous union)::(anonymous)' may result in an unaligned pointer value [-Waddress-of-packed-member]
               put_user(gf.gf_numsrc, &p->gf_numsrc))
                                       ^~~~~~~~~~~~
   arch/arm/include/asm/uaccess.h:406:26: note: expanded from macro 'put_user'
           __put_user_switch((x), (ptr), __pu_err, __put_user_check);      \
                                   ^~~
   arch/arm/include/asm/uaccess.h:388:22: note: expanded from macro '__put_user_switch'
                   const __typeof__(*(ptr)) __user *__pu_ptr = (ptr);      \
                                      ^~~
>> net/ipv4/ip_sockglue.c:1510:30: warning: taking address of packed member 'gf_numsrc' of class or structure 'compat_group_filter::(anonymous union)::(anonymous)' may result in an unaligned pointer value [-Waddress-of-packed-member]
               put_user(gf.gf_numsrc, &p->gf_numsrc))
                                       ^~~~~~~~~~~~
   arch/arm/include/asm/uaccess.h:406:26: note: expanded from macro 'put_user'
           __put_user_switch((x), (ptr), __pu_err, __put_user_check);      \
                                   ^~~
   arch/arm/include/asm/uaccess.h:389:16: note: expanded from macro '__put_user_switch'
                   __typeof__(*(ptr)) __pu_val = (x);                      \
                                ^~~
>> net/ipv4/ip_sockglue.c:1510:30: warning: taking address of packed member 'gf_numsrc' of class or structure 'compat_group_filter::(anonymous union)::(anonymous)' may result in an unaligned pointer value [-Waddress-of-packed-member]
               put_user(gf.gf_numsrc, &p->gf_numsrc))
                                       ^~~~~~~~~~~~
   arch/arm/include/asm/uaccess.h:406:26: note: expanded from macro 'put_user'
           __put_user_switch((x), (ptr), __pu_err, __put_user_check);      \
                                   ^~~
   arch/arm/include/asm/uaccess.h:393:20: note: expanded from macro '__put_user_switch'
                   switch (sizeof(*(ptr))) {                               \
                                    ^~~
   7 warnings generated.
--
>> net/ipv6/ipv6_sockglue.c:1111:29: warning: taking address of packed member 'gf_fmode' of class or structure 'compat_group_filter::(anonymous union)::(anonymous)' may result in an unaligned pointer value [-Waddress-of-packed-member]
               put_user(gf.gf_fmode, &p->gf_fmode) ||
                                      ^~~~~~~~~~~
   arch/arm/include/asm/uaccess.h:406:26: note: expanded from macro 'put_user'
           __put_user_switch((x), (ptr), __pu_err, __put_user_check);      \
                                   ^~~
   arch/arm/include/asm/uaccess.h:388:22: note: expanded from macro '__put_user_switch'
                   const __typeof__(*(ptr)) __user *__pu_ptr = (ptr);      \
                                      ^~~
>> net/ipv6/ipv6_sockglue.c:1111:29: warning: taking address of packed member 'gf_fmode' of class or structure 'compat_group_filter::(anonymous union)::(anonymous)' may result in an unaligned pointer value [-Waddress-of-packed-member]
               put_user(gf.gf_fmode, &p->gf_fmode) ||
                                      ^~~~~~~~~~~
   arch/arm/include/asm/uaccess.h:406:26: note: expanded from macro 'put_user'
           __put_user_switch((x), (ptr), __pu_err, __put_user_check);      \
                                   ^~~
   arch/arm/include/asm/uaccess.h:389:16: note: expanded from macro '__put_user_switch'
                   __typeof__(*(ptr)) __pu_val = (x);                      \
                                ^~~
>> net/ipv6/ipv6_sockglue.c:1111:29: warning: taking address of packed member 'gf_fmode' of class or structure 'compat_group_filter::(anonymous union)::(anonymous)' may result in an unaligned pointer value [-Waddress-of-packed-member]
               put_user(gf.gf_fmode, &p->gf_fmode) ||
                                      ^~~~~~~~~~~
   arch/arm/include/asm/uaccess.h:406:26: note: expanded from macro 'put_user'
           __put_user_switch((x), (ptr), __pu_err, __put_user_check);      \
                                   ^~~
   arch/arm/include/asm/uaccess.h:393:20: note: expanded from macro '__put_user_switch'
                   switch (sizeof(*(ptr))) {                               \
                                    ^~~
>> net/ipv6/ipv6_sockglue.c:1112:30: warning: taking address of packed member 'gf_numsrc' of class or structure 'compat_group_filter::(anonymous union)::(anonymous)' may result in an unaligned pointer value [-Waddress-of-packed-member]
               put_user(gf.gf_numsrc, &p->gf_numsrc))
                                       ^~~~~~~~~~~~
   arch/arm/include/asm/uaccess.h:406:26: note: expanded from macro 'put_user'
           __put_user_switch((x), (ptr), __pu_err, __put_user_check);      \
                                   ^~~
   arch/arm/include/asm/uaccess.h:388:22: note: expanded from macro '__put_user_switch'
                   const __typeof__(*(ptr)) __user *__pu_ptr = (ptr);      \
                                      ^~~
>> net/ipv6/ipv6_sockglue.c:1112:30: warning: taking address of packed member 'gf_numsrc' of class or structure 'compat_group_filter::(anonymous union)::(anonymous)' may result in an unaligned pointer value [-Waddress-of-packed-member]
               put_user(gf.gf_numsrc, &p->gf_numsrc))
                                       ^~~~~~~~~~~~
   arch/arm/include/asm/uaccess.h:406:26: note: expanded from macro 'put_user'
           __put_user_switch((x), (ptr), __pu_err, __put_user_check);      \
                                   ^~~
   arch/arm/include/asm/uaccess.h:389:16: note: expanded from macro '__put_user_switch'
                   __typeof__(*(ptr)) __pu_val = (x);                      \
                                ^~~
>> net/ipv6/ipv6_sockglue.c:1112:30: warning: taking address of packed member 'gf_numsrc' of class or structure 'compat_group_filter::(anonymous union)::(anonymous)' may result in an unaligned pointer value [-Waddress-of-packed-member]
               put_user(gf.gf_numsrc, &p->gf_numsrc))
                                       ^~~~~~~~~~~~
   arch/arm/include/asm/uaccess.h:406:26: note: expanded from macro 'put_user'
           __put_user_switch((x), (ptr), __pu_err, __put_user_check);      \
                                   ^~~
   arch/arm/include/asm/uaccess.h:393:20: note: expanded from macro '__put_user_switch'
                   switch (sizeof(*(ptr))) {                               \
                                    ^~~
   6 warnings generated.


vim +838 net/ipv4/ip_sockglue.c

   799	
   800	static int compat_ip_set_mcast_msfilter(struct sock *sk, sockptr_t optval,
   801			int optlen)
   802	{
   803		const int size0 = offsetof(struct compat_group_filter, gf_slist_flex);
   804		struct compat_group_filter *gf32;
   805		unsigned int n;
   806		void *p;
   807		int err;
   808	
   809		if (optlen < size0)
   810			return -EINVAL;
   811		if (optlen > sysctl_optmem_max - 4)
   812			return -ENOBUFS;
   813	
   814		p = kmalloc(optlen + 4, GFP_KERNEL);
   815		if (!p)
   816			return -ENOMEM;
   817		gf32 = p + 4; /* we want ->gf_group and ->gf_slist_flex aligned */
   818	
   819		err = -EFAULT;
   820		if (copy_from_sockptr(gf32, optval, optlen))
   821			goto out_free_gsf;
   822	
   823		/* numsrc >= (4G-140)/128 overflow in 32 bits */
   824		n = gf32->gf_numsrc;
   825		err = -ENOBUFS;
   826		if (n >= 0x1ffffff)
   827			goto out_free_gsf;
   828	
   829		err = -EINVAL;
   830		if (offsetof(struct compat_group_filter, gf_slist_flex[n]) > optlen)
   831			goto out_free_gsf;
   832	
   833		/* numsrc >= (4G-140)/128 overflow in 32 bits */
   834		err = -ENOBUFS;
   835		if (n > sock_net(sk)->ipv4.sysctl_igmp_max_msf)
   836			goto out_free_gsf;
   837		err = set_mcast_msfilter(sk, gf32->gf_interface, n, gf32->gf_fmode,
 > 838					 &gf32->gf_group, gf32->gf_slist_flex);
   839	out_free_gsf:
   840		kfree(p);
   841		return err;
   842	}
   843	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
