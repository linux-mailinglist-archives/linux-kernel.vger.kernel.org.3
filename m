Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD75E58BA83
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 12:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbiHGKCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 06:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiHGKCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 06:02:33 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B5EDF59
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 03:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659866551; x=1691402551;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IuIdGOacDOjX/TgR8fpp9vCWnE+6zB8HHER3QqfM7cA=;
  b=B7Puxis3KbdMPMArS0pp3aXByPdIJ2QglKOMYAAxkMglWfSHakEtJJag
   vQ93axup+WlmYHrndJGWQATBsafKnSYUKz+FImrbxhb/vHg3bYKiUOdJ/
   +5bBi8tmlwOPK8HS184eUtpPRujvKsKTJPwOqoZx9/YvJdn77lUNiUiO9
   Gfs1z/oiWpHbnTP27TOJjOWN/2RQzMyIA+xHY5/cQFnr4r4ZAAwahswmK
   J06BUZ9lMm/jp9GCcjJ9Al6aPlo+W2Su0pziRg/qBlx5BDVpsmnRicIke
   zJztY6BhHQ0Jig5kUIbJpKN8W+3PJGjgJDfOT2MSiFlJdMJFGjWarlvzw
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="270201326"
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="270201326"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 03:02:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="746314996"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 07 Aug 2022 03:02:29 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKd76-000LD3-2V;
        Sun, 07 Aug 2022 10:02:28 +0000
Date:   Sun, 7 Aug 2022 18:02:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     cgel.zte@gmail.com, akpm@linux-foundation.org, hannes@cmpxchg.org
Cc:     kbuild-all@lists.01.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yang Yang <yang.yang29@zte.com.cn>,
        CGEL ZTE <cgel.zte@gmail.com>
Subject: Re: [PATCH] mm/vmscan: define macros for refaults in struct lruvec
Message-ID: <202208071759.nIRUnjYn-lkp@intel.com>
References: <20220802071012.1648335-1-yang.yang29@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802071012.1648335-1-yang.yang29@zte.com.cn>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/cgel-zte-gmail-com/mm-vmscan-define-macros-for-refaults-in-struct-lruvec/20220802-151054
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220807/202208071759.nIRUnjYn-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/cb852a4d1456d03ec22ce56b90e321d14c853bb7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review cgel-zte-gmail-com/mm-vmscan-define-macros-for-refaults-in-struct-lruvec/20220802-151054
        git checkout cb852a4d1456d03ec22ce56b90e321d14c853bb7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/swait.h:5,
                    from include/linux/completion.h:12,
                    from fs/nfs/delegation.c:10:
   fs/nfs/delegation.c: In function 'nfs_inode_set_delegation':
>> include/linux/nfs_fs.h:623:58: error: 'NFSDBG_1' undeclared (first use in this function); did you mean 'NFSDBG_ALL'?
     623 | #  define ifdebug(fac)          if (unlikely(nfs_debug & NFSDBG_##fac))
         |                                                          ^~~~~~~
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/sunrpc/debug.h:39:9: note: in expansion of macro 'ifdebug'
      39 |         ifdebug(fac)                                                    \
         |         ^~~~~~~
   fs/nfs/delegation.c:476:17: note: in expansion of macro 'dfprintk'
     476 |                 dfprintk(FILE, "%s: server %s handed out "
         |                 ^~~~~~~~
   include/linux/nfs_fs.h:623:58: note: each undeclared identifier is reported only once for each function it appears in
     623 | #  define ifdebug(fac)          if (unlikely(nfs_debug & NFSDBG_##fac))
         |                                                          ^~~~~~~
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/sunrpc/debug.h:39:9: note: in expansion of macro 'ifdebug'
      39 |         ifdebug(fac)                                                    \
         |         ^~~~~~~
   fs/nfs/delegation.c:476:17: note: in expansion of macro 'dfprintk'
     476 |                 dfprintk(FILE, "%s: server %s handed out "
         |                 ^~~~~~~~
--
   In file included from include/linux/export.h:33,
                    from include/linux/linkage.h:7,
                    from arch/x86/include/asm/cache.h:5,
                    from include/linux/cache.h:6,
                    from include/linux/time.h:5,
                    from include/linux/compat.h:10,
                    from fs/nfs/dir.c:21:
   fs/nfs/dir.c: In function 'nfs_opendir':
>> include/linux/nfs_fs.h:623:58: error: 'NFSDBG_1' undeclared (first use in this function); did you mean 'NFSDBG_ALL'?
     623 | #  define ifdebug(fac)          if (unlikely(nfs_debug & NFSDBG_##fac))
         |                                                          ^~~~~~~
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/sunrpc/debug.h:39:9: note: in expansion of macro 'ifdebug'
      39 |         ifdebug(fac)                                                    \
         |         ^~~~~~~
   fs/nfs/dir.c:116:9: note: in expansion of macro 'dfprintk'
     116 |         dfprintk(FILE, "NFS: open dir(%pD2)\n", filp);
         |         ^~~~~~~~
   include/linux/nfs_fs.h:623:58: note: each undeclared identifier is reported only once for each function it appears in
     623 | #  define ifdebug(fac)          if (unlikely(nfs_debug & NFSDBG_##fac))
         |                                                          ^~~~~~~
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/sunrpc/debug.h:39:9: note: in expansion of macro 'ifdebug'
      39 |         ifdebug(fac)                                                    \
         |         ^~~~~~~
   fs/nfs/dir.c:116:9: note: in expansion of macro 'dfprintk'
     116 |         dfprintk(FILE, "NFS: open dir(%pD2)\n", filp);
         |         ^~~~~~~~
   fs/nfs/dir.c: In function 'nfs_readdir':
>> include/linux/nfs_fs.h:623:58: error: 'NFSDBG_1' undeclared (first use in this function); did you mean 'NFSDBG_ALL'?
     623 | #  define ifdebug(fac)          if (unlikely(nfs_debug & NFSDBG_##fac))
         |                                                          ^~~~~~~
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/sunrpc/debug.h:39:9: note: in expansion of macro 'ifdebug'
      39 |         ifdebug(fac)                                                    \
         |         ^~~~~~~
   fs/nfs/dir.c:1220:9: note: in expansion of macro 'dfprintk'
    1220 |         dfprintk(FILE, "NFS: readdir(%pD2) starting at cookie %llu\n",
         |         ^~~~~~~~
   fs/nfs/dir.c: In function 'nfs_llseek_dir':
>> include/linux/nfs_fs.h:623:58: error: 'NFSDBG_1' undeclared (first use in this function); did you mean 'NFSDBG_ALL'?
     623 | #  define ifdebug(fac)          if (unlikely(nfs_debug & NFSDBG_##fac))
         |                                                          ^~~~~~~
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/sunrpc/debug.h:39:9: note: in expansion of macro 'ifdebug'
      39 |         ifdebug(fac)                                                    \
         |         ^~~~~~~
   fs/nfs/dir.c:1316:9: note: in expansion of macro 'dfprintk'
    1316 |         dfprintk(FILE, "NFS: llseek dir(%pD2, %lld, %d)\n",
         |         ^~~~~~~~
   fs/nfs/dir.c: In function 'nfs_fsync_dir':
>> include/linux/nfs_fs.h:623:58: error: 'NFSDBG_1' undeclared (first use in this function); did you mean 'NFSDBG_ALL'?
     623 | #  define ifdebug(fac)          if (unlikely(nfs_debug & NFSDBG_##fac))
         |                                                          ^~~~~~~
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/sunrpc/debug.h:39:9: note: in expansion of macro 'ifdebug'
      39 |         ifdebug(fac)                                                    \
         |         ^~~~~~~
   fs/nfs/dir.c:1360:9: note: in expansion of macro 'dfprintk'
    1360 |         dfprintk(FILE, "NFS: fsync dir(%pD2) datasync %d\n", filp, datasync);
         |         ^~~~~~~~
--
   In file included from arch/x86/include/asm/current.h:5,
                    from include/linux/sched.h:12,
                    from fs/nfs/direct.c:43:
   fs/nfs/direct.c: In function 'nfs_file_direct_read':
>> include/linux/nfs_fs.h:623:58: error: 'NFSDBG_1' undeclared (first use in this function); did you mean 'NFSDBG_ALL'?
     623 | #  define ifdebug(fac)          if (unlikely(nfs_debug & NFSDBG_##fac))
         |                                                          ^~~~~~~
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/sunrpc/debug.h:39:9: note: in expansion of macro 'ifdebug'
      39 |         ifdebug(fac)                                                    \
         |         ^~~~~~~
   fs/nfs/direct.c:453:9: note: in expansion of macro 'dfprintk'
     453 |         dfprintk(FILE, "NFS: direct read(%pD2, %zd@%Ld)\n",
         |         ^~~~~~~~
   include/linux/nfs_fs.h:623:58: note: each undeclared identifier is reported only once for each function it appears in
     623 | #  define ifdebug(fac)          if (unlikely(nfs_debug & NFSDBG_##fac))
         |                                                          ^~~~~~~
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/sunrpc/debug.h:39:9: note: in expansion of macro 'ifdebug'
      39 |         ifdebug(fac)                                                    \
         |         ^~~~~~~
   fs/nfs/direct.c:453:9: note: in expansion of macro 'dfprintk'
     453 |         dfprintk(FILE, "NFS: direct read(%pD2, %zd@%Ld)\n",
         |         ^~~~~~~~
   fs/nfs/direct.c: In function 'nfs_file_direct_write':
>> include/linux/nfs_fs.h:623:58: error: 'NFSDBG_1' undeclared (first use in this function); did you mean 'NFSDBG_ALL'?
     623 | #  define ifdebug(fac)          if (unlikely(nfs_debug & NFSDBG_##fac))
         |                                                          ^~~~~~~
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/sunrpc/debug.h:39:9: note: in expansion of macro 'ifdebug'
      39 |         ifdebug(fac)                                                    \
         |         ^~~~~~~
   fs/nfs/direct.c:909:9: note: in expansion of macro 'dfprintk'
     909 |         dfprintk(FILE, "NFS: direct write(%pD2, %zd@%Ld)\n",
         |         ^~~~~~~~


vim +623 include/linux/nfs_fs.h

^1da177e4c3f41 Linus Torvalds 2005-04-16  619  
4dc2eaecd4cf06 Benny Halevy   2006-12-20  620  
^1da177e4c3f41 Linus Torvalds 2005-04-16  621  # undef ifdebug
^1da177e4c3f41 Linus Torvalds 2005-04-16  622  # ifdef NFS_DEBUG
^1da177e4c3f41 Linus Torvalds 2005-04-16 @623  #  define ifdebug(fac)		if (unlikely(nfs_debug & NFSDBG_##fac))

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
