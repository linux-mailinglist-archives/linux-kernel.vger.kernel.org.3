Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D9D477B6D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 19:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240637AbhLPSWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 13:22:21 -0500
Received: from mga01.intel.com ([192.55.52.88]:47300 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231292AbhLPSWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 13:22:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639678940; x=1671214940;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MYJpTqX2I4GceJxtDJQl5ErgAnA0jLMi39Gzet3l17U=;
  b=GDHqPeM3lXiwkS/llCeRyitL+j730Wps7HhY30jQMAcc4KSzP1menptf
   NdUccQphEV9+Nh6djWTmuBQupJIyM7cZggA7LLE3iICDACjTlzgpXrysu
   p/Nct+8pYjPnIWeOVtmrz5zf0NdOydgoH2TTGTuxYhEwDiI2bWL1jFetY
   YjK289FAE3Q2Rw0SC0D29ahKDe01Nl3X/s83maXhsJpLkrOyqvLFG3r1A
   lhLk/OqRRb1U8mpdHAEjoeTaunerTlRIlfVQtAwRdg9gGLNCQ8cLF/RCZ
   6p2csH3HoYtRV8iWgALPUlwphhSYcZ1IzoNTIDMgxyIM4ueg+RceXF2aC
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="263731681"
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="263731681"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 10:22:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="611627864"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 16 Dec 2021 10:22:17 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxvOT-0003e7-6I; Thu, 16 Dec 2021 18:22:17 +0000
Date:   Fri, 17 Dec 2021 02:21:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH 2/2] mm: reimplement si_mem_available()
Message-ID: <202112170216.SkyvfZzv-lkp@intel.com>
References: <20211216124655.32247-3-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216124655.32247-3-zhengqi.arch@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on hnaz-mm/master]
[also build test ERROR on driver-core/driver-core-testing linux/master linus/master v5.16-rc5 next-20211215]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Qi-Zheng/add-MemAvailable-to-per-node-meminfo/20211216-204828
base:   https://github.com/hnaz/linux-mm master
config: hexagon-randconfig-r045-20211216 (https://download.01.org/0day-ci/archive/20211217/202112170216.SkyvfZzv-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project dd245bab9fbb364faa1581e4f92ba3119a872fba)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/7980664f23d619d15a3931fe1ab7d1dbafad7c88
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Qi-Zheng/add-MemAvailable-to-per-node-meminfo/20211216-204828
        git checkout 7980664f23d619d15a3931fe1ab7d1dbafad7c88
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: si_meminfo_node
   >>> referenced by page_alloc.c
   >>>               page_alloc.o:(si_mem_available) in archive mm/built-in.a
   >>> referenced by page_alloc.c
   >>>               page_alloc.o:(si_mem_available) in archive mm/built-in.a

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
