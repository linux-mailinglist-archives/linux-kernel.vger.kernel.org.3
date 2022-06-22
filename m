Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1485543CF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 10:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352758AbiFVHZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 03:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242604AbiFVHZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 03:25:42 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8213937009
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 00:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655882741; x=1687418741;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8fyiOEj6UXqgECBF8WA2TpvzXotNKsxOEFLSCQo4M8I=;
  b=M59hpnol7i9/iLSXhreD3BuI2Q65liZMkyKxH90nVhJjgqG0eqq0FNOw
   9O5dNXtrZiDuhZtFF2UeIW8oGByXjw25w16wEtygB7h5jHHR+J0T4cIp1
   f6u31E3F6eyzkDCVnIDMHOIYia3kTqoKx6A5CYykzhd74/tCQOS065+nN
   nBFtYw/HDkKHnIo/NjMbPFHXsV4T2XAnNK+4iXFvq55NTPtOPcuP3YvqW
   I0lyGPBALVkzaVdeyHnuU0/gzBVLyQ78BP3UCxjDWCZF4k2/rdOGPfzOI
   uKauJ9DHlstDtAOcx1gGgRhUgibE+iFcQoUawU8nnXgDwrh/XmX4nH7ih
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="281071382"
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="281071382"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 00:25:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="655519227"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 22 Jun 2022 00:25:37 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3uk5-0000zR-6F;
        Wed, 22 Jun 2022 07:25:37 +0000
Date:   Wed, 22 Jun 2022 15:24:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [alobakin:bitops 7/8] include/linux/bitmap.h:447:22: warning:
 'possible_idx[0]' is used uninitialized
Message-ID: <202206221502.VUxmhVnV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/alobakin/linux bitops
head:   53dc46e3f72d9b77c9c4ec23a3261d452b3bd67a
commit: 37c8723a2d98c5edce8fb5e9c2e7b8e2d9b4291c [7/8] bitmap: don't assume compiler evaluates small mem*() builtins calls
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220622/202206221502.VUxmhVnV-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/alobakin/linux/commit/37c8723a2d98c5edce8fb5e9c2e7b8e2d9b4291c
        git remote add alobakin https://github.com/alobakin/linux
        git fetch --no-tags alobakin bitops
        git checkout 37c8723a2d98c5edce8fb5e9c2e7b8e2d9b4291c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/net/ethernet/intel/ice/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/cpumask.h:12,
                    from arch/x86/include/asm/cpumask.h:5,
                    from arch/x86/include/asm/msr.h:11,
                    from arch/x86/include/asm/processor.h:22,
                    from arch/x86/include/asm/timex.h:5,
                    from include/linux/timex.h:67,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from drivers/net/ethernet/intel/ice/ice.h:10,
                    from drivers/net/ethernet/intel/ice/ice_lib.h:7,
                    from drivers/net/ethernet/intel/ice/ice_switch.c:4:
   drivers/net/ethernet/intel/ice/ice_switch.c: In function 'ice_find_free_recp_res_idx.constprop':
>> include/linux/bitmap.h:447:22: warning: 'possible_idx[0]' is used uninitialized [-Wuninitialized]
     447 |                 *map |= GENMASK(start + nbits - 1, start);
         |                      ^~
   In file included from drivers/net/ethernet/intel/ice/ice.h:7,
                    from drivers/net/ethernet/intel/ice/ice_lib.h:7,
                    from drivers/net/ethernet/intel/ice/ice_switch.c:4:
   drivers/net/ethernet/intel/ice/ice_switch.c:4929:24: note: 'possible_idx[0]' was declared here
    4929 |         DECLARE_BITMAP(possible_idx, ICE_MAX_FV_WORDS);
         |                        ^~~~~~~~~~~~
   include/linux/types.h:11:23: note: in definition of macro 'DECLARE_BITMAP'
      11 |         unsigned long name[BITS_TO_LONGS(bits)]
         |                       ^~~~


vim +447 include/linux/bitmap.h

   440	
   441	static __always_inline void bitmap_set(unsigned long *map, unsigned int start,
   442			unsigned int nbits)
   443	{
   444		if (__builtin_constant_p(nbits) && nbits == 1)
   445			__set_bit(start, map);
   446		else if (small_const_nbits(start + nbits))
 > 447			*map |= GENMASK(start + nbits - 1, start);
   448		else if (__builtin_constant_p(start & BITMAP_MEM_MASK) &&
   449			 IS_ALIGNED(start, BITMAP_MEM_ALIGNMENT) &&
   450			 __builtin_constant_p(nbits & BITMAP_MEM_MASK) &&
   451			 IS_ALIGNED(nbits, BITMAP_MEM_ALIGNMENT))
   452			memset((char *)map + start / 8, 0xff, nbits / 8);
   453		else
   454			__bitmap_set(map, start, nbits);
   455	}
   456	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
