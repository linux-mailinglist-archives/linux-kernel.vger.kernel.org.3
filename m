Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBDD4858AC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 19:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243198AbiAESwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 13:52:53 -0500
Received: from mga05.intel.com ([192.55.52.43]:8433 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230295AbiAESww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 13:52:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641408772; x=1672944772;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gZ4McMNBubaISdcARvxEAF7emVTEAQL3hWd/uJYrtSs=;
  b=U951IN4R6v1WEMd8Z4Ek+iC0eOfX2kKJQmqCm8M0hNldZwuhKuWkhCqN
   EdOIXPgkMMTTqY0Hs57sklX0hGS3dMGS77F51LctXeTTeKRuuV99rZkeN
   udEKU8Fzes21NFxwlXavSQ1xuKo65JvLO6KfNB3hkkxF3y9y/p7B5slsX
   f9Yb9r8R38VWJIHY+cMhy8Iz0ZBFFm7QF3EwOGbHSz6mz8cpJbfaV1wcv
   ejyVxNjUxBfXviBj7Pa2E/9IseaN317lzxqzTJgNha+mhKTxWPnv/C9J9
   FUNpDup2guSYoRr1Xt6UqPOeOcTZZUF2Rp6qbkz+QhvnozP47nStmXXFz
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="328862088"
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="328862088"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 10:52:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="574485584"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 05 Jan 2022 10:52:49 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5BOz-000Gxg-7K; Wed, 05 Jan 2022 18:52:49 +0000
Date:   Thu, 6 Jan 2022 02:51:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Charan Teja Reddy <quic_charante@quicinc.com>, hughd@google.com,
        akpm@linux-foundation.org, willy@infradead.org, vbabka@suse.cz,
        rientjes@google.com, mhocko@suse.com, surenb@google.com,
        shakeelb@google.com, linux-mm@kvack.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED for
 shmem
Message-ID: <202201060232.K03lKwTH-lkp@intel.com>
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
config: nds32-allnoconfig (https://download.01.org/0day-ci/archive/20220106/202201060232.K03lKwTH-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/6bdb2636187d2f6cb78d6cdc05f2b7e0b79c750a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Charan-Teja-Reddy/mm-shmem-implement-POSIX_FADV_-WILL-DONT-NEED-for-shmem/20220105-230604
        git checkout 6bdb2636187d2f6cb78d6cdc05f2b7e0b79c750a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> mm/shmem.c:4000:27: error: 'shmem_fadvise' undeclared here (not in a function); did you mean 'shmem_file'?
    4000 |         .fadvise        = shmem_fadvise,
         |                           ^~~~~~~~~~~~~
         |                           shmem_file


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
