Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913D049CA1F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 13:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241555AbiAZMz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 07:55:57 -0500
Received: from mga11.intel.com ([192.55.52.93]:29530 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241540AbiAZMz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 07:55:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643201757; x=1674737757;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ioIPdkfJ+i121L7EaKQPCg44/2govewCK0oAfQs1+KI=;
  b=Rvupw7L7qPEghVBFbNDOHa2s9TXC9Fy5mKamR9qifjC4izdp3c3vSV2i
   WZGL8iZYTCe+qpisGV/Dt10t6Dk+mqDc7s6IuQGPllNtUD1VeCRVMBKVi
   NH2FmK6QsQaM6/t15inUjSVEBPlAwfi168RBWdyiFeT11QfeY74zdYBFC
   qazZDAN+RmhDYo+2B/YCjnQrdsKjei31oMdnytqe/ueOO2FMNQ1LaStH9
   23/8O1m9cLXOU4yNdn/xqo1ezpK6rTXZ0EUr70A31m393obX3/DP0RepV
   Mlr/r/TbTI9cuXY4rDwq28cJzF3ORTnZ/8ysGE7BvmOkx3bv75Vhcofw5
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="244141236"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="244141236"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 04:55:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="479873098"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 26 Jan 2022 04:55:55 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nChq6-000LEO-8z; Wed, 26 Jan 2022 12:55:54 +0000
Date:   Wed, 26 Jan 2022 20:55:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Ekstrand <jason@jlekstrand.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [mlankhorst:xe 57/165] drivers/gpu/drm/xe/xe_ggtt.c:49:2: error:
 implicit declaration of function 'writeq'; did you mean 'writel'?
Message-ID: <202201262033.KJ6X5rbX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://people.freedesktop.org/~mlankhorst/linux xe
head:   4bc3039b4403c76a13d58f7ac1f7c07dca6f88d8
commit: 0d5fc1553e186ef20954dcc179aab3f6a5bb2644 [57/165] Add support for the GGTT
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220126/202201262033.KJ6X5rbX-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        git remote add mlankhorst git://people.freedesktop.org/~mlankhorst/linux
        git fetch --no-tags mlankhorst xe
        git checkout 0d5fc1553e186ef20954dcc179aab3f6a5bb2644
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpu/drm/xe/xe_ggtt.c: In function 'xe_ggtt_set_pte':
>> drivers/gpu/drm/xe/xe_ggtt.c:49:2: error: implicit declaration of function 'writeq'; did you mean 'writel'? [-Werror=implicit-function-declaration]
      49 |  writeq(pte, &ggtt->gsm[addr >> GEN8_PTE_SHIFT]);
         |  ^~~~~~
         |  writel
   cc1: all warnings being treated as errors


vim +49 drivers/gpu/drm/xe/xe_ggtt.c

    43	
    44	static void xe_ggtt_set_pte(struct xe_ggtt *ggtt, uint64_t addr, uint64_t pte)
    45	{
    46		XE_BUG_ON(addr & GEN8_PTE_MASK);
    47		XE_BUG_ON(addr > ggtt->size);
    48	
  > 49		writeq(pte, &ggtt->gsm[addr >> GEN8_PTE_SHIFT]);
    50	}
    51	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
