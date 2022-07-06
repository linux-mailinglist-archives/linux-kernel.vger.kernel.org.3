Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A09567E37
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 08:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiGFGJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 02:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiGFGJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 02:09:32 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A139913D41
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 23:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657087771; x=1688623771;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vfVvdl9ASxQWmG60XIANcl9T9rHLFX37LENtdBu4h/Q=;
  b=f4N9TIG3awVbD2Q9WOMCjhjSPpKiwyadD+PDA7NVGeX6YEVQR8qa8y42
   u909zHi30IGAoF9X5MaT59k1vmw/yIM6kVtu7gFpGQV6ZdzOP/Sy8kWFp
   24n8tAVmBXOHdCcsNBWK4oF44SvadkLGV6U3we3yfy8GdTlFZvh9jyPGC
   QykG8ST3BJAUGORf0e5WUPW7wmpvrmXxTdJrmyO6ePA4EjRVT+jECPHxP
   jbHgKKxvhESRxsEP3Q42GZwjFxx3l6MwcVywr2bTCfNQMYAcmPyJZC/2r
   U85TXnFOa5EeEWL27FaVRh9vCESyTHcQlwLERxRM/v/slaVE4zgsfoJdL
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="281205874"
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="281205874"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 23:09:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="735441197"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 05 Jul 2022 23:09:29 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8yE4-000K8N-Hj;
        Wed, 06 Jul 2022 06:09:28 +0000
Date:   Wed, 6 Jul 2022 14:08:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
        jasowang@redhat.com, xiaodong.liu@intel.com,
        maxime.coquelin@redhat.com, stefanha@redhat.com
Cc:     kbuild-all@lists.01.org, songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] vduse: Support registering userspace memory for
 IOTLB
Message-ID: <202207061418.mTlO0yqK-lkp@intel.com>
References: <20220706050503.171-6-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706050503.171-6-xieyongji@bytedance.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xie,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.19-rc5 next-20220705]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Xie-Yongji/VDUSE-Support-registering-userspace-memory-as-bounce-buffer/20220706-130802
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git e35e5b6f695d241ffb1d223207da58a1fbcdff4b
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220706/202207061418.mTlO0yqK-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9be699264e4fede9c3be913b2d1003c260d9fa05
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Xie-Yongji/VDUSE-Support-registering-userspace-memory-as-bounce-buffer/20220706-130802
        git checkout 9be699264e4fede9c3be913b2d1003c260d9fa05
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/vdpa/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/vdpa/vdpa_user/vduse_dev.c: In function 'vduse_dev_dereg_iotlb_mem':
   drivers/vdpa/vdpa_user/vduse_dev.c:949:9: error: implicit declaration of function 'vfree'; did you mean 'kvfree'? [-Werror=implicit-function-declaration]
     949 |         vfree(dev->iotlb_mem->pages);
         |         ^~~~~
         |         kvfree
   drivers/vdpa/vdpa_user/vduse_dev.c: In function 'vduse_dev_reg_iotlb_mem':
   drivers/vdpa/vdpa_user/vduse_dev.c:978:21: error: implicit declaration of function '__vmalloc'; did you mean '__kmalloc'? [-Werror=implicit-function-declaration]
     978 |         page_list = __vmalloc(array_size(npages, sizeof(struct page *)),
         |                     ^~~~~~~~~
         |                     __kmalloc
>> drivers/vdpa/vdpa_user/vduse_dev.c:978:19: warning: assignment to 'struct page **' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     978 |         page_list = __vmalloc(array_size(npages, sizeof(struct page *)),
         |                   ^
   cc1: some warnings being treated as errors


vim +978 drivers/vdpa/vdpa_user/vduse_dev.c

   957	
   958	static int vduse_dev_reg_iotlb_mem(struct vduse_dev *dev,
   959					   u64 iova, u64 uaddr, u64 size)
   960	{
   961		struct page **page_list = NULL;
   962		struct vduse_iotlb_mem *mem = NULL;
   963		long pinned = 0;
   964		unsigned long npages, lock_limit;
   965		int ret;
   966	
   967		if (size != dev->domain->bounce_size ||
   968		    iova != 0 || uaddr & ~PAGE_MASK)
   969			return -EINVAL;
   970	
   971		mutex_lock(&dev->mem_lock);
   972		ret = -EEXIST;
   973		if (dev->iotlb_mem)
   974			goto unlock;
   975	
   976		ret = -ENOMEM;
   977		npages = size >> PAGE_SHIFT;
 > 978		page_list = __vmalloc(array_size(npages, sizeof(struct page *)),
   979				      GFP_KERNEL_ACCOUNT);
   980		mem = kzalloc(sizeof(*mem), GFP_KERNEL);
   981		if (!page_list || !mem)
   982			goto unlock;
   983	
   984		mmap_read_lock(current->mm);
   985	
   986		lock_limit = PFN_DOWN(rlimit(RLIMIT_MEMLOCK));
   987		if (npages + atomic64_read(&current->mm->pinned_vm) > lock_limit)
   988			goto out;
   989	
   990		pinned = pin_user_pages(uaddr, npages, FOLL_LONGTERM | FOLL_WRITE,
   991					page_list, NULL);
   992		if (pinned != npages) {
   993			ret = pinned < 0 ? pinned : -ENOMEM;
   994			goto out;
   995		}
   996	
   997		ret = vduse_domain_add_user_bounce_pages(dev->domain,
   998							 page_list, pinned);
   999		if (ret)
  1000			goto out;
  1001	
  1002		atomic64_add(npages, &current->mm->pinned_vm);
  1003	
  1004		mem->pages = page_list;
  1005		mem->npages = pinned;
  1006		mem->iova = iova;
  1007		mem->mm = current->mm;
  1008		mmgrab(current->mm);
  1009	
  1010		dev->iotlb_mem = mem;
  1011	out:
  1012		if (ret && pinned > 0)
  1013			unpin_user_pages(page_list, pinned);
  1014	
  1015		mmap_read_unlock(current->mm);
  1016	unlock:
  1017		if (ret) {
  1018			vfree(page_list);
  1019			kfree(mem);
  1020		}
  1021		mutex_unlock(&dev->mem_lock);
  1022		return ret;
  1023	}
  1024	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
