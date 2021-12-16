Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB62477E1A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241541AbhLPVG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:06:27 -0500
Received: from mga01.intel.com ([192.55.52.88]:63243 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231656AbhLPVG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:06:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639688786; x=1671224786;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qFbQSudabPxmnP54k4ksYMpla7q7UpjMq/8TvBCKsxk=;
  b=SMOb6PAhMNWbMKtKPDilWDFwAJN6aR8BWX8mAKJZFozUWcVE/8Wkb1pz
   2G0ewlZ+JpPTeaGqmY4lajQLkXNPAF+L5Wk1F6bN76bi33eeHYD6c+y8a
   WujceDtlHvbq64DkGTuSbEiF43FdE6BWBl8bGvlue0bOWHl9hpdweOGqi
   LZ9n2JvuCZfXQaKltTA4JzsVI+551aHHXK9KOOB23YxuwOWBP/LGmP5z3
   G5S2KXw6sN3TfhFwTLbsnelGQ7a7IOahBAjiBDhAg0GoUvcQczXUncQdw
   Wd/hvGf0nDlW3B18Zv2G1tQcMh6UEUT3PKhLmhiz06/UpPjKCBHPBP4Jx
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="263769295"
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="263769295"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 13:06:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="568699916"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 16 Dec 2021 13:06:22 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxxxG-0003om-4s; Thu, 16 Dec 2021 21:06:22 +0000
Date:   Fri, 17 Dec 2021 05:05:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     kbuild-all@lists.01.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH 2/2] mm: reimplement si_mem_available()
Message-ID: <202112170401.UyUM1wQ5-lkp@intel.com>
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
config: arc-randconfig-r043-20211216 (https://download.01.org/0day-ci/archive/20211217/202112170401.UyUM1wQ5-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/7980664f23d619d15a3931fe1ab7d1dbafad7c88
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Qi-Zheng/add-MemAvailable-to-per-node-meminfo/20211216-204828
        git checkout 7980664f23d619d15a3931fe1ab7d1dbafad7c88
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arc-elf-ld: mm/page_alloc.o: in function `si_mem_available':
>> (.text+0x8248): undefined reference to `si_meminfo_node'
>> arc-elf-ld: (.text+0x8248): undefined reference to `si_meminfo_node'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
