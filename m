Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0B356AECF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 01:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236826AbiGGXCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 19:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236867AbiGGXCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 19:02:17 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F6967598
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 16:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657234932; x=1688770932;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3byBZehLtKcDOmjsnhhmWfxIRWZEBDCHys/67WVncWE=;
  b=I2ZxuBMrR7ySOWn8tbBM9xPQyNpbHvYQZjDJeGuovpNgeLeaGO3DIA5N
   td2DhaCQcQxG2UJvqEUuplgW34c3MnwgV/iMZ9ujeazJSNnQU8Sq5zkwV
   ZpgZNRKW+Yj4aZK+X0Hn54CnI4ZUZZbaHAgmZt2/rb9r4qs2r6njV4JMS
   +tbi8lzMcHirTXiNzqusgjtVFxWDW4wlgKKsTuElQuAPPH3Pio3HNYtxe
   00T9HmqOyL9Sisb5pXCezJm0v0K8cxN92jTeb0yozw/KH8ERlxjjH/rp0
   TY/vJTRu4TPsW97iwaW/qZpQZsBhmj8JT7rkLgdm+LLVCYwQb1QMav+XK
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="282891997"
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="282891997"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 16:02:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="543990636"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 07 Jul 2022 16:02:09 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9aVc-000MZv-R3;
        Thu, 07 Jul 2022 23:02:08 +0000
Date:   Fri, 8 Jul 2022 07:01:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
        jasowang@redhat.com, xiaodong.liu@intel.com,
        maxime.coquelin@redhat.com, stefanha@redhat.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] vduse: Support registering userspace memory for
 IOTLB
Message-ID: <202207080640.p8q3NqHB-lkp@intel.com>
References: <20220706050503.171-6-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706050503.171-6-xieyongji@bytedance.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xie,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.19-rc5 next-20220707]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xie-Yongji/VDUSE-Support-registering-userspace-memory-as-bounce-buffer/20220706-130802
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git e35e5b6f695d241ffb1d223207da58a1fbcdff4b
config: hexagon-randconfig-r005-20220707 (https://download.01.org/0day-ci/archive/20220708/202207080640.p8q3NqHB-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 66ae1d60bb278793fd651cece264699d522bab84)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9be699264e4fede9c3be913b2d1003c260d9fa05
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Xie-Yongji/VDUSE-Support-registering-userspace-memory-as-bounce-buffer/20220706-130802
        git checkout 9be699264e4fede9c3be913b2d1003c260d9fa05
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/vdpa/vdpa_user/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> drivers/vdpa/vdpa_user/vduse_dev.c:949:2: error: call to undeclared function 'vfree'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           vfree(dev->iotlb_mem->pages);
           ^
>> drivers/vdpa/vdpa_user/vduse_dev.c:978:14: error: call to undeclared function '__vmalloc'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           page_list = __vmalloc(array_size(npages, sizeof(struct page *)),
                       ^
   drivers/vdpa/vdpa_user/vduse_dev.c:978:14: note: did you mean '__kmalloc'?
   include/linux/slab.h:434:7: note: '__kmalloc' declared here
   void *__kmalloc(size_t size, gfp_t flags) __assume_kmalloc_alignment __alloc_size(1);
         ^
>> drivers/vdpa/vdpa_user/vduse_dev.c:978:12: warning: incompatible integer to pointer conversion assigning to 'struct page **' from 'int' [-Wint-conversion]
           page_list = __vmalloc(array_size(npages, sizeof(struct page *)),
                     ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/vdpa/vdpa_user/vduse_dev.c:1018:3: error: call to undeclared function 'vfree'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   vfree(page_list);
                   ^
   drivers/vdpa/vdpa_user/vduse_dev.c:1654:51: warning: shift count >= width of type [-Wshift-count-overflow]
           ret = dma_set_mask_and_coherent(&vdev->vdpa.dev, DMA_BIT_MASK(64));
                                                            ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^ ~~~
   2 warnings and 3 errors generated.


vim +/vfree +949 drivers/vdpa/vdpa_user/vduse_dev.c

   929	
   930	static int vduse_dev_dereg_iotlb_mem(struct vduse_dev *dev,
   931					     u64 iova, u64 size)
   932	{
   933		int ret;
   934	
   935		mutex_lock(&dev->mem_lock);
   936		ret = -ENOENT;
   937		if (!dev->iotlb_mem)
   938			goto unlock;
   939	
   940		ret = -EINVAL;
   941		if (dev->iotlb_mem->iova != iova || size != dev->domain->bounce_size)
   942			goto unlock;
   943	
   944		vduse_domain_remove_user_bounce_pages(dev->domain);
   945		unpin_user_pages_dirty_lock(dev->iotlb_mem->pages,
   946					    dev->iotlb_mem->npages, true);
   947		atomic64_sub(dev->iotlb_mem->npages, &dev->iotlb_mem->mm->pinned_vm);
   948		mmdrop(dev->iotlb_mem->mm);
 > 949		vfree(dev->iotlb_mem->pages);
   950		kfree(dev->iotlb_mem);
   951		dev->iotlb_mem = NULL;
   952		ret = 0;
   953	unlock:
   954		mutex_unlock(&dev->mem_lock);
   955		return ret;
   956	}
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
