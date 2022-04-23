Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C849D50C5C9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 02:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbiDWArm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 20:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiDWAr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 20:47:26 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E84B4BB9B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 17:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650674671; x=1682210671;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qrUcYVmj8OlszewQvc3xo561SuN5UTMTfVRFshSERqY=;
  b=ScPkx0w9ghUj8aIEZD6LdRHXQ60foslqLyMsGuE1H7jHMFjO9tdSTWrA
   x0RL+GJVZamae2soIlUHpHD0P/B6Mp/Xm+wm7z1gmY7B0blnH8EcU28Jm
   Lr25LasTVmZZ7uR8OUCxXzRc1sYMJZoXFGALrxtEkaG0TKImHuI0Bz4mi
   h9RKoxXYj4ukNNoalmv8uE4VnvDI4qzBbR0RO+gkiTDSEtg3HQbvulfV/
   OKII5VrrkZhcUPSJDgV+hEX+R//uch7OTS736nmKpY/niB7OcmlPAiPt9
   4R4dyTDPEtA7Udh44GJQDi5g6757PfL2USrzoOhT9XVFZf3e45Qm3rhdC
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="246727903"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="246727903"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 17:44:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="511801301"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 22 Apr 2022 17:44:29 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ni3sy-000Aju-R8;
        Sat, 23 Apr 2022 00:44:28 +0000
Date:   Sat, 23 Apr 2022 08:44:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [norov:gup 45/48] include/linux/bitmap.h:259:9: warning: 'memcpy'
 forming offset [20, 23] is out of the bounds [0, 20]
Message-ID: <202204230819.d6pbriaa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/norov/linux gup
head:   c96226d23c745b114dc041e0d8d0c272b280c71a
commit: f1cbd19c47bf73d532ff30571601c7ede57d5f82 [45/48] lib: add bitmap_{from,to}_arr64
config: csky-randconfig-r021-20220422 (https://download.01.org/0day-ci/archive/20220423/202204230819.d6pbriaa-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/norov/linux/commit/f1cbd19c47bf73d532ff30571601c7ede57d5f82
        git remote add norov https://github.com/norov/linux
        git fetch --no-tags norov gup
        git checkout f1cbd19c47bf73d532ff30571601c7ede57d5f82
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash net/bluetooth/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/mutex.h:17,
                    from include/linux/rfkill.h:35,
                    from net/bluetooth/hci_core.c:29:
   In function 'bitmap_copy',
       inlined from 'bitmap_copy_clear_tail' at include/linux/bitmap.h:268:2,
       inlined from 'bitmap_from_u64' at include/linux/bitmap.h:622:2,
       inlined from 'hci_bdaddr_list_add_with_flags' at net/bluetooth/hci_core.c:2156:2:
>> include/linux/bitmap.h:259:9: warning: 'memcpy' forming offset [20, 23] is out of the bounds [0, 20] [-Warray-bounds]
     259 |         memcpy(dst, src, len);
         |         ^~~~~~~~~~~~~~~~~~~~~


vim +/memcpy +259 include/linux/bitmap.h

^1da177e4c3f41 Linus Torvalds   2005-04-16  254  
^1da177e4c3f41 Linus Torvalds   2005-04-16  255  static inline void bitmap_copy(unsigned long *dst, const unsigned long *src,
8b4daad52fee77 Rasmus Villemoes 2015-02-12  256  			unsigned int nbits)
^1da177e4c3f41 Linus Torvalds   2005-04-16  257  {
8b4daad52fee77 Rasmus Villemoes 2015-02-12  258  	unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
^1da177e4c3f41 Linus Torvalds   2005-04-16 @259  	memcpy(dst, src, len);
^1da177e4c3f41 Linus Torvalds   2005-04-16  260  }
^1da177e4c3f41 Linus Torvalds   2005-04-16  261  

:::::: The code at line 259 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
