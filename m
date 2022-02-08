Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16EE4AD9E1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358154AbiBHN35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356765AbiBHN3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 08:29:39 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D57C03C1B8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 05:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644326858; x=1675862858;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E0fRGxEtVkvT2lzqv/+khnEIYsQeeeV/q/5k7RPHcpo=;
  b=UE1OT6burG/wUDAwTL1dCrX1fF6JvK7P8bG9m9xq2+hedYWNcr9fm6Gv
   0pVWtTl+k3pj8a7m981lHHDQuxC2zyvTaUvUMKBuKX9bBfiEJMEc8Sag7
   FlGfXalgiyQn/wkqNoyyHyQ/R9l1yKw+p+uYYN1A1f3flHLnD7qsvKTVF
   0Z7zfZ7DSFoYVVCtPr8VV4rKTZkSqX8FfVpnp7QFej4ue1Sdu8R5dSCGj
   e1y7lO7iqUc+UFRY+VkpeDNHzDentJLVseHKLaS5cRa4a8Chno8N4kdYB
   da5xopDHDgDajmzmLG8GMl4M3gN328HbeIRBed7epIKWRe6yLPctBQfWq
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="228914040"
X-IronPort-AV: E=Sophos;i="5.88,352,1635231600"; 
   d="scan'208";a="228914040"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 05:27:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,352,1635231600"; 
   d="scan'208";a="484810419"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Feb 2022 05:27:36 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHQWt-0000Ez-NO; Tue, 08 Feb 2022 13:27:35 +0000
Date:   Tue, 8 Feb 2022 21:27:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guixin Liu <kanie@linux.alibaba.com>, gregkh@linuxfoundation.org
Cc:     kbuild-all@lists.01.org, xiaoguang.wang@linux.alibaba.com,
        xlpang@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uio: Replace mutex info_lock with percpu_ref to improve
 performance
Message-ID: <202202082111.R18zUEHK-lkp@intel.com>
References: <1644304760-11862-1-git-send-email-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644304760-11862-1-git-send-email-kanie@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guixin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on v5.17-rc3 next-20220208]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Guixin-Liu/uio-Replace-mutex-info_lock-with-percpu_ref-to-improve-performance/20220208-152119
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git b86f32951d173b43d1db8de883473fc53dc3c772
config: parisc-randconfig-s032-20220208 (https://download.01.org/0day-ci/archive/20220208/202202082111.R18zUEHK-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/271c7d04f21a7c880e9dfb056eca51835576833d
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Guixin-Liu/uio-Replace-mutex-info_lock-with-percpu_ref-to-improve-performance/20220208-152119
        git checkout 271c7d04f21a7c880e9dfb056eca51835576833d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=parisc SHELL=/bin/bash drivers/uio/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/uio/uio.c:564:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __poll_t @@     got int @@
   drivers/uio/uio.c:564:24: sparse:     expected restricted __poll_t
   drivers/uio/uio.c:564:24: sparse:     got int
   drivers/uio/uio.c:567:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __poll_t [usertype] ret @@     got int @@
   drivers/uio/uio.c:567:21: sparse:     expected restricted __poll_t [usertype] ret
   drivers/uio/uio.c:567:21: sparse:     got int
>> drivers/uio/uio.c:699:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted vm_fault_t @@     got int @@
   drivers/uio/uio.c:699:24: sparse:     expected restricted vm_fault_t
   drivers/uio/uio.c:699:24: sparse:     got int

vim +564 drivers/uio/uio.c

   556	
   557	static __poll_t uio_poll(struct file *filep, poll_table *wait)
   558	{
   559		struct uio_listener *listener = filep->private_data;
   560		struct uio_device *idev = listener->dev;
   561		__poll_t ret = 0;
   562	
   563		if (!percpu_ref_tryget_live(&idev->info_ref))
 > 564			return -EINVAL;
   565	
   566		if (!idev->info || !idev->info->irq)
   567			ret = -EIO;
   568		percpu_ref_put(&idev->info_ref);
   569	
   570		if (ret)
   571			return ret;
   572	
   573		poll_wait(filep, &idev->wait, wait);
   574		if (listener->event_count != atomic_read(&idev->event))
   575			return EPOLLIN | EPOLLRDNORM;
   576		return 0;
   577	}
   578	
   579	static ssize_t uio_read(struct file *filep, char __user *buf,
   580				size_t count, loff_t *ppos)
   581	{
   582		struct uio_listener *listener = filep->private_data;
   583		struct uio_device *idev = listener->dev;
   584		DECLARE_WAITQUEUE(wait, current);
   585		ssize_t retval = 0;
   586		s32 event_count;
   587	
   588		if (count != sizeof(s32))
   589			return -EINVAL;
   590	
   591		add_wait_queue(&idev->wait, &wait);
   592	
   593		do {
   594			if (!percpu_ref_tryget_live(&idev->info_ref)) {
   595				retval = -EINVAL;
   596				break;
   597			}
   598	
   599			if (!idev->info || !idev->info->irq) {
   600				retval = -EIO;
   601				percpu_ref_put(&idev->info_ref);
   602				break;
   603			}
   604			percpu_ref_put(&idev->info_ref);
   605	
   606			set_current_state(TASK_INTERRUPTIBLE);
   607	
   608			event_count = atomic_read(&idev->event);
   609			if (event_count != listener->event_count) {
   610				__set_current_state(TASK_RUNNING);
   611				if (copy_to_user(buf, &event_count, count))
   612					retval = -EFAULT;
   613				else {
   614					listener->event_count = event_count;
   615					retval = count;
   616				}
   617				break;
   618			}
   619	
   620			if (filep->f_flags & O_NONBLOCK) {
   621				retval = -EAGAIN;
   622				break;
   623			}
   624	
   625			if (signal_pending(current)) {
   626				retval = -ERESTARTSYS;
   627				break;
   628			}
   629			schedule();
   630		} while (1);
   631	
   632		__set_current_state(TASK_RUNNING);
   633		remove_wait_queue(&idev->wait, &wait);
   634	
   635		return retval;
   636	}
   637	
   638	static ssize_t uio_write(struct file *filep, const char __user *buf,
   639				size_t count, loff_t *ppos)
   640	{
   641		struct uio_listener *listener = filep->private_data;
   642		struct uio_device *idev = listener->dev;
   643		ssize_t retval;
   644		s32 irq_on;
   645	
   646		if (count != sizeof(s32))
   647			return -EINVAL;
   648	
   649		if (copy_from_user(&irq_on, buf, count))
   650			return -EFAULT;
   651	
   652		if (!percpu_ref_tryget_live(&idev->info_ref))
   653			return -EINVAL;
   654	
   655		if (!idev->info) {
   656			retval = -EINVAL;
   657			goto out;
   658		}
   659	
   660		if (!idev->info->irq) {
   661			retval = -EIO;
   662			goto out;
   663		}
   664	
   665		if (!idev->info->irqcontrol) {
   666			retval = -ENOSYS;
   667			goto out;
   668		}
   669	
   670		retval = idev->info->irqcontrol(idev->info, irq_on);
   671	
   672	out:
   673		percpu_ref_put(&idev->info_ref);
   674		return retval ? retval : sizeof(s32);
   675	}
   676	
   677	static int uio_find_mem_index(struct vm_area_struct *vma)
   678	{
   679		struct uio_device *idev = vma->vm_private_data;
   680	
   681		if (vma->vm_pgoff < MAX_UIO_MAPS) {
   682			if (idev->info->mem[vma->vm_pgoff].size == 0)
   683				return -1;
   684			return (int)vma->vm_pgoff;
   685		}
   686		return -1;
   687	}
   688	
   689	static vm_fault_t uio_vma_fault(struct vm_fault *vmf)
   690	{
   691		struct uio_device *idev = vmf->vma->vm_private_data;
   692		struct page *page;
   693		unsigned long offset;
   694		void *addr;
   695		vm_fault_t ret = 0;
   696		int mi;
   697	
   698		if (!percpu_ref_tryget_live(&idev->info_ref))
 > 699			return -EINVAL;
   700	
   701		if (!idev->info) {
   702			ret = VM_FAULT_SIGBUS;
   703			goto out;
   704		}
   705	
   706		mi = uio_find_mem_index(vmf->vma);
   707		if (mi < 0) {
   708			ret = VM_FAULT_SIGBUS;
   709			goto out;
   710		}
   711	
   712		/*
   713		 * We need to subtract mi because userspace uses offset = N*PAGE_SIZE
   714		 * to use mem[N].
   715		 */
   716		offset = (vmf->pgoff - mi) << PAGE_SHIFT;
   717	
   718		addr = (void *)(unsigned long)idev->info->mem[mi].addr + offset;
   719		if (idev->info->mem[mi].memtype == UIO_MEM_LOGICAL)
   720			page = virt_to_page(addr);
   721		else
   722			page = vmalloc_to_page(addr);
   723		get_page(page);
   724		vmf->page = page;
   725	
   726	out:
   727		percpu_ref_put(&idev->info_ref);
   728		return ret;
   729	}
   730	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
