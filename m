Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56685585C95
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 01:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236218AbiG3XBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 19:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236128AbiG3XBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 19:01:54 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046EB14038
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 16:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659222111; x=1690758111;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T8Gwb5eXQuxPfUXYvnUcxftAQQomSRR24x3wrRDUKSU=;
  b=hw4yZnk8VEZFO39mIH7y8qQReJGFhxrNNWW2MFqGILiscpzTj2TkU+vF
   IFkUPjNkmD1SXQHnY1FiCMvZlW7VaghLCy3owYaJ0HyFjhRAZ13yKkthY
   +tuOYnvOO5pIw57R1Ie1Xlz5hoiiSAlkoU8UT1e2G34F/ggeC753Yn/P2
   Ijtt0b3VzscVg+WRI7kpo+EqFLEAmnZB3v2d4TkZNObFSrv0yPekRSdYc
   YDSq/z+QBG0c6q77wxLpsIfzoAep9diXlZj2PGWScvDisnX/xpv4zOyKu
   8j5FfIbDhU4Yc1VbFWeTzlnSXr2Dc5NCuk9UEmrEznBnTcuF5HRN06KvR
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="269333511"
X-IronPort-AV: E=Sophos;i="5.93,205,1654585200"; 
   d="scan'208";a="269333511"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 16:01:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,205,1654585200"; 
   d="scan'208";a="601641594"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 30 Jul 2022 16:01:50 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHvSv-000DPr-2J;
        Sat, 30 Jul 2022 23:01:49 +0000
Date:   Sun, 31 Jul 2022 07:01:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dma-buf: Add ioctl to query mmap info
Message-ID: <202207310607.RX5r6WRK-lkp@intel.com>
References: <20220729170744.1301044-2-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729170744.1301044-2-robdclark@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.19-rc8]
[cannot apply to drm-misc/drm-misc-next drm/drm-next drm-exynos/exynos-drm-next drm-intel/for-linux-next drm-tip/drm-tip next-20220728]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rob-Clark/dma-buf-map-info-support/20220730-010844
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 6e2c0490769ef8a95b61304389116ccc85c53e12
config: hexagon-randconfig-r032-20220729 (https://download.01.org/0day-ci/archive/20220731/202207310607.RX5r6WRK-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 52cd00cabf479aa7eb6dbb063b7ba41ea57bce9e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/203f14a73a179d6c5fbfa4813e45fde2a9ae9860
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Rob-Clark/dma-buf-map-info-support/20220730-010844
        git checkout 203f14a73a179d6c5fbfa4813e45fde2a9ae9860
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/dma-buf/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/dma-buf/dma-buf.c:346:19: error: passing 'const void  btf_type_tag(user)*' (aka 'const void *') to parameter of type 'void  btf_type_tag(user)*' (aka 'void *') discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           if (copy_to_user(uarg, &arg, sizeof(arg)))
                            ^~~~
   include/linux/uaccess.h:157:27: note: passing argument to parameter 'to' here
   copy_to_user(void __user *to, const void *from, unsigned long n)
                             ^
   1 error generated.


vim +346 drivers/dma-buf/dma-buf.c

   328	
   329	static long dma_buf_info(struct dma_buf *dmabuf, const void __user *uarg)
   330	{
   331		struct dma_buf_info arg;
   332	
   333		if (copy_from_user(&arg, uarg, sizeof(arg)))
   334			return -EFAULT;
   335	
   336		switch (arg.param) {
   337		case DMA_BUF_INFO_VM_PROT:
   338			if (!dmabuf->ops->mmap_info)
   339				return -ENOSYS;
   340			arg.value = dmabuf->ops->mmap_info(dmabuf);
   341			break;
   342		default:
   343			return -EINVAL;
   344		}
   345	
 > 346		if (copy_to_user(uarg, &arg, sizeof(arg)))
   347			return -EFAULT;
   348	
   349		return 0;
   350	}
   351	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
