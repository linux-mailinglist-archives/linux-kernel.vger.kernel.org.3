Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E46486079
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 07:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbiAFGHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 01:07:12 -0500
Received: from mga07.intel.com ([134.134.136.100]:19763 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229560AbiAFGHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 01:07:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641449232; x=1672985232;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TavuDjlr6ehK951KTTK7qs2mHQh60DUn8Pis0q2fbio=;
  b=IyF6opBv4wxA3IyUfhSh5rTjG61aQM0BsVy+wrfiGKvWcc29d9Fc/cmU
   dxPDJqJzF26eFF1jBkhs5yJwf/egoTo+DJuwkXnRzXPqpeGF/rOoITJ+E
   8nmRg/+HstpzyDX/2+IhgoBKy7prVzZazox+Oy+c2Qa9xTHbDlzgOs5KU
   nom2QeGYm/dYMoICdX402a6ihHnH6WxCABfP8Ofqzg2pL4wavHpxsHAWX
   u3+Ow701hI3cXWpSwJJ8Rd41UPHXq7jHBnSxu7pgSRiWLrEMfLqGn/6DI
   T/+1S39A7n2lfWkvMYQYRF8YWQpulRylOYOVXeCo9fIxu1pN/CQ24U7TH
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="305951829"
X-IronPort-AV: E=Sophos;i="5.88,266,1635231600"; 
   d="scan'208";a="305951829"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 22:07:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,266,1635231600"; 
   d="scan'208";a="611725351"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Jan 2022 22:07:07 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5LvX-000HOj-7V; Thu, 06 Jan 2022 06:07:07 +0000
Date:   Thu, 6 Jan 2022 14:06:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Charan Teja Reddy <quic_charante@quicinc.com>, hughd@google.com,
        akpm@linux-foundation.org, willy@infradead.org, vbabka@suse.cz,
        rientjes@google.com, mhocko@suse.com, surenb@google.com,
        shakeelb@google.com, linux-mm@kvack.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED for
 shmem
Message-ID: <202201061353.4vrJlOAk-lkp@intel.com>
References: <1641395025-7922-1-git-send-email-quic_charante@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1641395025-7922-1-git-send-email-quic_charante@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on hnaz-mm/master]

url:    https://github.com/0day-ci/linux/commits/Charan-Teja-Reddy/mm-shmem-implement-POSIX_FADV_-WILL-DONT-NEED-for-shmem/20220105-230604
base:   https://github.com/hnaz/linux-mm master
config: hexagon-randconfig-r013-20220105 (https://download.01.org/0day-ci/archive/20220106/202201061353.4vrJlOAk-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d5b6e30ed3acad794dd0aec400e617daffc6cc3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/6bdb2636187d2f6cb78d6cdc05f2b7e0b79c750a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Charan-Teja-Reddy/mm-shmem-implement-POSIX_FADV_-WILL-DONT-NEED-for-shmem/20220105-230604
        git checkout 6bdb2636187d2f6cb78d6cdc05f2b7e0b79c750a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> mm/shmem.c:4000:13: error: use of undeclared identifier 'shmem_fadvise'; did you mean 'shmem_file'?
           .fadvise        = shmem_fadvise,
                             ^~~~~~~~~~~~~
                             shmem_file
   include/linux/shmem_fs.h:118:20: note: 'shmem_file' declared here
   static inline bool shmem_file(struct file *file)
                      ^
>> mm/shmem.c:4000:13: error: incompatible function pointer types initializing 'int (*)(struct file *, loff_t, loff_t, int)' (aka 'int (*)(struct file *, long long, long long, int)') with an expression of type 'bool (struct file *)' (aka '_Bool (struct file *)') [-Werror,-Wincompatible-function-pointer-types]
           .fadvise        = shmem_fadvise,
                             ^~~~~~~~~~~~~
   2 errors generated.


vim +4000 mm/shmem.c

  3987	
  3988	static const struct file_operations shmem_file_operations = {
  3989		.mmap		= shmem_mmap,
  3990		.get_unmapped_area = shmem_get_unmapped_area,
  3991	#ifdef CONFIG_TMPFS
  3992		.llseek		= shmem_file_llseek,
  3993		.read_iter	= shmem_file_read_iter,
  3994		.write_iter	= generic_file_write_iter,
  3995		.fsync		= noop_fsync,
  3996		.splice_read	= generic_file_splice_read,
  3997		.splice_write	= iter_file_splice_write,
  3998		.fallocate	= shmem_fallocate,
  3999	#endif
> 4000		.fadvise	= shmem_fadvise,
  4001	};
  4002	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
