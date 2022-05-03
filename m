Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E63D518012
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 10:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbiECIxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 04:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbiECIxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 04:53:04 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6338F27B37
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 01:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651567772; x=1683103772;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DmzcaiLRqqiyo8PYpg9kyWYjjUJjoZ8e2OsQMfbGjZM=;
  b=OpfUUp0O9e4f3uRBdQT14SaB0pxBc7PLO90p51We2bMvdMpm++UiI+E8
   wQHoslAbZgClp86K/FIrVO+bHo8YVVQuBfhVgob1qVhd6ROXvua4kzudL
   lGGFR62raHvIHodb4Wi+stBcABYWOwS0yObD1KyvuYA17knTnXKcvxGMW
   uF4e/u9IRpU4lXMvLLaqQ73AjnmeezKnPJfnDWsLamgsJvuEuReDw7G0r
   IcDLwH/1V+zvWlkK+j4/Htep3zgCVtgmvIgkbbVk1qJo8jrwwU6Vb2U5h
   iHWrLZi1t5xvHlpg9OTja1FaGWGsQ08I+6AwSUjkS9h1PEKmu6QjYk6TO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="267588789"
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="267588789"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 01:49:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="888298048"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 03 May 2022 01:49:29 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nloDp-000AJ2-3P;
        Tue, 03 May 2022 08:49:29 +0000
Date:   Tue, 3 May 2022 16:48:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        John Dias <joaodias@google.com>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH] mm: fix is_pinnable_page against on cma page
Message-ID: <202205031644.EtLKbqIX-lkp@intel.com>
References: <20220502173558.2510641-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502173558.2510641-1-minchan@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Minchan,

I love your patch! Perhaps something to improve:

[auto build test WARNING on hnaz-mm/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Minchan-Kim/mm-fix-is_pinnable_page-against-on-cma-page/20220503-013733
base:   https://github.com/hnaz/linux-mm master
config: hexagon-randconfig-r034-20220501 (https://download.01.org/0day-ci/archive/20220503/202205031644.EtLKbqIX-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 363b3a645a1e30011cc8da624f13dac5fd915628)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/1b8636710c31d44310f1d344e337c207562b851d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Minchan-Kim/mm-fix-is_pinnable_page-against-on-cma-page/20220503-013733
        git checkout 1b8636710c31d44310f1d344e337c207562b851d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from fs/statfs.c:2:
   In file included from include/linux/syscalls.h:88:
   In file included from include/trace/syscall.h:7:
   In file included from include/linux/trace_events.h:6:
   In file included from include/linux/ring_buffer.h:5:
   include/linux/mm.h:1630:47: error: use of undeclared identifier 'MIGRATE_CMA'; did you mean 'MIGRATE_SYNC'?
           return !(is_zone_movable_page(page) || mt == MIGRATE_CMA ||
                                                        ^~~~~~~~~~~
                                                        MIGRATE_SYNC
   include/linux/migrate_mode.h:18:2: note: 'MIGRATE_SYNC' declared here
           MIGRATE_SYNC,
           ^
   In file included from fs/statfs.c:2:
   In file included from include/linux/syscalls.h:88:
   In file included from include/trace/syscall.h:7:
   In file included from include/linux/trace_events.h:6:
   In file included from include/linux/ring_buffer.h:5:
   include/linux/mm.h:1631:9: error: use of undeclared identifier 'MIGRATE_ISOLATE'; did you mean 'MIGRATE_MOVABLE'?
                   mt == MIGRATE_ISOLATE || is_zero_pfn(page_to_pfn(page)));
                         ^~~~~~~~~~~~~~~
                         MIGRATE_MOVABLE
   include/linux/mmzone.h:44:2: note: 'MIGRATE_MOVABLE' declared here
           MIGRATE_MOVABLE,
           ^
>> fs/statfs.c:131:3: warning: 'memcpy' will always overflow; destination buffer has size 64, but size argument is 88 [-Wfortify-source]
                   memcpy(&buf, st, sizeof(*st));
                   ^
   1 warning and 2 errors generated.


vim +/memcpy +131 fs/statfs.c

c8b91accfa1059 Al Viro 2011-03-12  125  
c8b91accfa1059 Al Viro 2011-03-12  126  static int do_statfs_native(struct kstatfs *st, struct statfs __user *p)
c8b91accfa1059 Al Viro 2011-03-12  127  {
c8b91accfa1059 Al Viro 2011-03-12  128  	struct statfs buf;
7ed1ee6118ae77 Al Viro 2010-03-23  129  
c8b91accfa1059 Al Viro 2011-03-12  130  	if (sizeof(buf) == sizeof(*st))
c8b91accfa1059 Al Viro 2011-03-12 @131  		memcpy(&buf, st, sizeof(*st));
7ed1ee6118ae77 Al Viro 2010-03-23  132  	else {
c8b91accfa1059 Al Viro 2011-03-12  133  		if (sizeof buf.f_blocks == 4) {
c8b91accfa1059 Al Viro 2011-03-12  134  			if ((st->f_blocks | st->f_bfree | st->f_bavail |
c8b91accfa1059 Al Viro 2011-03-12  135  			     st->f_bsize | st->f_frsize) &
7ed1ee6118ae77 Al Viro 2010-03-23  136  			    0xffffffff00000000ULL)
7ed1ee6118ae77 Al Viro 2010-03-23  137  				return -EOVERFLOW;
7ed1ee6118ae77 Al Viro 2010-03-23  138  			/*
7ed1ee6118ae77 Al Viro 2010-03-23  139  			 * f_files and f_ffree may be -1; it's okay to stuff
7ed1ee6118ae77 Al Viro 2010-03-23  140  			 * that into 32 bits
7ed1ee6118ae77 Al Viro 2010-03-23  141  			 */
c8b91accfa1059 Al Viro 2011-03-12  142  			if (st->f_files != -1 &&
c8b91accfa1059 Al Viro 2011-03-12  143  			    (st->f_files & 0xffffffff00000000ULL))
7ed1ee6118ae77 Al Viro 2010-03-23  144  				return -EOVERFLOW;
c8b91accfa1059 Al Viro 2011-03-12  145  			if (st->f_ffree != -1 &&
c8b91accfa1059 Al Viro 2011-03-12  146  			    (st->f_ffree & 0xffffffff00000000ULL))
7ed1ee6118ae77 Al Viro 2010-03-23  147  				return -EOVERFLOW;
7ed1ee6118ae77 Al Viro 2010-03-23  148  		}
7ed1ee6118ae77 Al Viro 2010-03-23  149  
c8b91accfa1059 Al Viro 2011-03-12  150  		buf.f_type = st->f_type;
c8b91accfa1059 Al Viro 2011-03-12  151  		buf.f_bsize = st->f_bsize;
c8b91accfa1059 Al Viro 2011-03-12  152  		buf.f_blocks = st->f_blocks;
c8b91accfa1059 Al Viro 2011-03-12  153  		buf.f_bfree = st->f_bfree;
c8b91accfa1059 Al Viro 2011-03-12  154  		buf.f_bavail = st->f_bavail;
c8b91accfa1059 Al Viro 2011-03-12  155  		buf.f_files = st->f_files;
c8b91accfa1059 Al Viro 2011-03-12  156  		buf.f_ffree = st->f_ffree;
c8b91accfa1059 Al Viro 2011-03-12  157  		buf.f_fsid = st->f_fsid;
c8b91accfa1059 Al Viro 2011-03-12  158  		buf.f_namelen = st->f_namelen;
c8b91accfa1059 Al Viro 2011-03-12  159  		buf.f_frsize = st->f_frsize;
c8b91accfa1059 Al Viro 2011-03-12  160  		buf.f_flags = st->f_flags;
c8b91accfa1059 Al Viro 2011-03-12  161  		memset(buf.f_spare, 0, sizeof(buf.f_spare));
c8b91accfa1059 Al Viro 2011-03-12  162  	}
c8b91accfa1059 Al Viro 2011-03-12  163  	if (copy_to_user(p, &buf, sizeof(buf)))
c8b91accfa1059 Al Viro 2011-03-12  164  		return -EFAULT;
7ed1ee6118ae77 Al Viro 2010-03-23  165  	return 0;
7ed1ee6118ae77 Al Viro 2010-03-23  166  }
7ed1ee6118ae77 Al Viro 2010-03-23  167  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
