Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173C65477AE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 23:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbiFKVVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 17:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiFKVVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 17:21:46 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1B056391
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 14:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654982505; x=1686518505;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jAoJwbluCgt/kSBjQvcAdIJUWzr781/aoGpszolGa4k=;
  b=UD51h//eqFb+Is03isJkOL6c5P7FSfyUXuOSEP0MBqt8x5B3jupDbKDF
   SAwXS3TsePhm3U4+Ru7jMvJPHP76O0qIDFrw09ojIPAH9IjSyWCm4eL22
   8aVohfoBeZtJxcyKCs5onI5/mfbcuBHXoRqgr32FXbwtaktHRZWMeTp2k
   6hmjSYqxT3mi6uAU637Ns7lBboC76Pi7MxNBthoOmnM8EGh6HixT8jGGH
   lAbuRUwlBkfombR8PK83aAJdebqlBxUcqNnA5hiv1CYNFE7kz6OBcmZSi
   Nqjxh10cED9nZBbSGUsHaBaa+E8Emt0nDI54h8YopiwCgSxFt0qz5Svk9
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10375"; a="276719152"
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="276719152"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2022 14:21:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="616956844"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 11 Jun 2022 14:21:44 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o08YB-000JJe-DE;
        Sat, 11 Jun 2022 21:21:43 +0000
Date:   Sun, 12 Jun 2022 05:21:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: WARNING: modpost: vmlinux.o(.text.unlikely+0x24dc): Section mismatch
 in reference from the function find_next_bit() to the variable
 .init.rodata:__setup_str_initcall_blacklist
Message-ID: <202206120501.LD90ONuZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0678afa6055d14799c1dc1eee47c8025eba56cab
commit: 2c523550b9924f98299414253d8a1fef7c60ef2d lib/bitmap: add test for bitmap_{from,to}_arr64
date:   8 days ago
config: xtensa-randconfig-r001-20220612 (https://download.01.org/0day-ci/archive/20220612/202206120501.LD90ONuZ-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2c523550b9924f98299414253d8a1fef7c60ef2d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 2c523550b9924f98299414253d8a1fef7c60ef2d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

<< WARNING: modpost: vmlinux.o(.text.unlikely+0x24b0): Section mismatch in reference from the function bitmap_equal() to the variable .init.rodata:__setup_str_initcall_blacklist
>> WARNING: modpost: vmlinux.o(.text.unlikely+0x24dc): Section mismatch in reference from the function find_next_bit() to the variable .init.rodata:__setup_str_initcall_blacklist
The function find_next_bit() references
the variable __initconst __setup_str_initcall_blacklist.
This is often because find_next_bit lacks a __initconst
annotation or the annotation of __setup_str_initcall_blacklist is wrong.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
