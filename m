Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2540750C12C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 23:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiDVViY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 17:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiDVViO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 17:38:14 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829A91E3DF3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650659989; x=1682195989;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CPrMsqPBc4d+/2ELT/59dZdNya95D7ohcRstQplIP1w=;
  b=OmjFPCf3qyFFDC0Xb8AwCAHuogKUc2gXFX9OAsxP7fPDApkLy1BSxbBx
   q1oQmYcUlgCAtsi7YMnG5WUqBcuwFatfnwESr+xomSWbxvbQr3STYAKCW
   2BLUDcOniIxzNq1Cr4gMOgTOBz1EBB+qf4u1FSRu6ftcsqhV6ASzxC/oo
   HZNWSDKM+HLoyIhahfOSQ8cX07eG6uTrHZ33xCr4MpgrTEcKOL4ZNO/dd
   exrWncZUcdfZ6cHseAOVwXEQivE3F4SDVyQWenke9hUX22LgOeTYRpZ6l
   KxyA3mtYnrMVFDYiUsjVAS1l5sqC3h2smqfP0GcDhi7WWnkEqWo5eXhQU
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="325188982"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="325188982"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 10:25:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="806077611"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 22 Apr 2022 10:25:52 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhx2W-000AOU-7j;
        Fri, 22 Apr 2022 17:25:52 +0000
Date:   Sat, 23 Apr 2022 01:25:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matteo Croce <mcroce@microsoft.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: [esmil:visionfive 2/54] mm/kasan/shadow.c:63:7: warning: no previous
 prototype for 'memcpy'
Message-ID: <202204230129.dHHHV3FB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   68fe13e37af4c8331cdd40841353c9725cb65925
commit: 359a031f0505e46e0274570b6e015984f45da29b [2/54] riscv: optimized memcpy
config: riscv-randconfig-c003-20220422 (https://download.01.org/0day-ci/archive/20220423/202204230129.dHHHV3FB-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/esmil/linux/commit/359a031f0505e46e0274570b6e015984f45da29b
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout 359a031f0505e46e0274570b6e015984f45da29b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash mm/kasan/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> mm/kasan/shadow.c:63:7: warning: no previous prototype for 'memcpy' [-Wmissing-prototypes]
      63 | void *memcpy(void *dest, const void *src, size_t len)
         |       ^~~~~~


vim +/memcpy +63 mm/kasan/shadow.c

bb359dbcb70085 Andrey Konovalov 2020-12-22  61  
bb359dbcb70085 Andrey Konovalov 2020-12-22  62  #undef memcpy
bb359dbcb70085 Andrey Konovalov 2020-12-22 @63  void *memcpy(void *dest, const void *src, size_t len)
bb359dbcb70085 Andrey Konovalov 2020-12-22  64  {
f00748bfa0246c Andrey Konovalov 2021-02-24  65  	if (!kasan_check_range((unsigned long)src, len, false, _RET_IP_) ||
f00748bfa0246c Andrey Konovalov 2021-02-24  66  	    !kasan_check_range((unsigned long)dest, len, true, _RET_IP_))
bb359dbcb70085 Andrey Konovalov 2020-12-22  67  		return NULL;
bb359dbcb70085 Andrey Konovalov 2020-12-22  68  
bb359dbcb70085 Andrey Konovalov 2020-12-22  69  	return __memcpy(dest, src, len);
bb359dbcb70085 Andrey Konovalov 2020-12-22  70  }
bb359dbcb70085 Andrey Konovalov 2020-12-22  71  

:::::: The code at line 63 was first introduced by commit
:::::: bb359dbcb70085a63e8bdbf14837a900750f0cf7 kasan: split out shadow.c from common.c

:::::: TO: Andrey Konovalov <andreyknvl@google.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
