Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8420A4AB6A7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 09:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244821AbiBGIbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 03:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351414AbiBGIUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 03:20:15 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204F8C043187
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 00:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644222014; x=1675758014;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=uoj/+xyWbelWZ9ulQvNBy6w91OTQSNoie7PPE2lMYh0=;
  b=drcymJwa8XUAinJthzoxSlrdjbKL0BluXhNWDVuoXyDv+rLdCMIR42Im
   XJxZVOAkP6kHU4Yhh03CnZRa12/3NXomsYJllYrp/irwgXELM0Qb7CQGh
   33pYhDwzehxbG1gUCYxHyH0jCVsL8GXGc3VtI8UD1y7d5NFfqEWZEJce2
   asmI66BUvT957d8SMZhht/1p+EnQTMFnDW4DYXlRDQuM1QQE0oLf4csld
   XHRLClXz1ItQUS60u38vff2PmmudrXb4aHeTxd/KQFzg4J6SIpMgECak0
   2azOqc9aQPuLlifo7ApMk0kCJ16zW7cBNHoaqtqm0oPXitrdZrWCqcYBM
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="335073697"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="335073697"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 00:20:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="632378272"
Received: from lkp-server01.sh.intel.com (HELO 9dd77a123018) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 07 Feb 2022 00:20:11 -0800
Received: from kbuild by 9dd77a123018 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nGzFr-0000H6-3R; Mon, 07 Feb 2022 08:20:11 +0000
Date:   Mon, 7 Feb 2022 16:19:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leonardo Araujo <leonardo.aa88@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Leonardo Araujo <leonardo.aa88@gmail.com>
Subject: Re: [PATCH] Staging : android: Struct file_operations should be const
Message-ID: <202202071653.db3wZIpH-lkp@intel.com>
References: <20220207031711.13644-1-leonardo.aa88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220207031711.13644-1-leonardo.aa88@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leonardo,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on staging/staging-testing]
[also build test ERROR on linux/master linus/master v5.17-rc3 next-20220204]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Leonardo-Araujo/Staging-android-Struct-file_operations-should-be-const/20220207-140301
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git 74e69e95f13f91c57c9322c7754a85a0e13e9b90
config: s390-randconfig-r044-20220207 (https://download.01.org/0day-ci/archive/20220207/202202071653.db3wZIpH-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/64cb13193a6a834c5cc3118068cf0ea5670bae8d
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Leonardo-Araujo/Staging-android-Struct-file_operations-should-be-const/20220207-140301
        git checkout 64cb13193a6a834c5cc3118068cf0ea5670bae8d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash drivers/staging/android/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/staging/android/ashmem.c: In function 'ashmem_mmap':
>> drivers/staging/android/ashmem.c:431:37: error: assignment of read-only variable 'vmfile_fops'
     431 |                         vmfile_fops = *vmfile->f_op;
         |                                     ^
>> drivers/staging/android/ashmem.c:432:42: error: assignment of member 'mmap' in read-only object
     432 |                         vmfile_fops.mmap = ashmem_vmfile_mmap;
         |                                          ^
>> drivers/staging/android/ashmem.c:433:55: error: assignment of member 'get_unmapped_area' in read-only object
     433 |                         vmfile_fops.get_unmapped_area =
         |                                                       ^


vim +/vmfile_fops +431 drivers/staging/android/ashmem.c

6d67b0290b4b84 Suren Baghdasaryan 2020-01-27  377  
11980c2ac4ccfa Robert Love        2011-12-20  378  static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
11980c2ac4ccfa Robert Love        2011-12-20  379  {
64cb13193a6a83 Leonardo Araujo    2022-02-07  380  	static const struct file_operations vmfile_fops;
11980c2ac4ccfa Robert Love        2011-12-20  381  	struct ashmem_area *asma = file->private_data;
11980c2ac4ccfa Robert Love        2011-12-20  382  	int ret = 0;
11980c2ac4ccfa Robert Love        2011-12-20  383  
11980c2ac4ccfa Robert Love        2011-12-20  384  	mutex_lock(&ashmem_mutex);
11980c2ac4ccfa Robert Love        2011-12-20  385  
11980c2ac4ccfa Robert Love        2011-12-20  386  	/* user needs to SET_SIZE before mapping */
59848d6aded59a Alistair Strachan  2018-06-19  387  	if (!asma->size) {
11980c2ac4ccfa Robert Love        2011-12-20  388  		ret = -EINVAL;
11980c2ac4ccfa Robert Love        2011-12-20  389  		goto out;
11980c2ac4ccfa Robert Love        2011-12-20  390  	}
11980c2ac4ccfa Robert Love        2011-12-20  391  
8632c614565d0c Alistair Strachan  2018-06-19  392  	/* requested mapping size larger than object size */
8632c614565d0c Alistair Strachan  2018-06-19  393  	if (vma->vm_end - vma->vm_start > PAGE_ALIGN(asma->size)) {
11980c2ac4ccfa Robert Love        2011-12-20  394  		ret = -EINVAL;
11980c2ac4ccfa Robert Love        2011-12-20  395  		goto out;
11980c2ac4ccfa Robert Love        2011-12-20  396  	}
11980c2ac4ccfa Robert Love        2011-12-20  397  
11980c2ac4ccfa Robert Love        2011-12-20  398  	/* requested protection bits must match our allowed protection mask */
59848d6aded59a Alistair Strachan  2018-06-19  399  	if ((vma->vm_flags & ~calc_vm_prot_bits(asma->prot_mask, 0)) &
59848d6aded59a Alistair Strachan  2018-06-19  400  	    calc_vm_prot_bits(PROT_MASK, 0)) {
11980c2ac4ccfa Robert Love        2011-12-20  401  		ret = -EPERM;
11980c2ac4ccfa Robert Love        2011-12-20  402  		goto out;
11980c2ac4ccfa Robert Love        2011-12-20  403  	}
56f76fc68492af Arve Hj�nnev�g     2011-12-20  404  	vma->vm_flags &= ~calc_vm_may_flags(~asma->prot_mask);
11980c2ac4ccfa Robert Love        2011-12-20  405  
11980c2ac4ccfa Robert Love        2011-12-20  406  	if (!asma->file) {
11980c2ac4ccfa Robert Love        2011-12-20  407  		char *name = ASHMEM_NAME_DEF;
11980c2ac4ccfa Robert Love        2011-12-20  408  		struct file *vmfile;
3e338d3c95c735 Suren Baghdasaryan 2020-07-30  409  		struct inode *inode;
11980c2ac4ccfa Robert Love        2011-12-20  410  
11980c2ac4ccfa Robert Love        2011-12-20  411  		if (asma->name[ASHMEM_NAME_PREFIX_LEN] != '\0')
11980c2ac4ccfa Robert Love        2011-12-20  412  			name = asma->name;
11980c2ac4ccfa Robert Love        2011-12-20  413  
11980c2ac4ccfa Robert Love        2011-12-20  414  		/* ... and allocate the backing shmem file */
11980c2ac4ccfa Robert Love        2011-12-20  415  		vmfile = shmem_file_setup(name, asma->size, vma->vm_flags);
7f44cb0ba88b40 Viresh Kumar       2015-07-31  416  		if (IS_ERR(vmfile)) {
11980c2ac4ccfa Robert Love        2011-12-20  417  			ret = PTR_ERR(vmfile);
11980c2ac4ccfa Robert Love        2011-12-20  418  			goto out;
11980c2ac4ccfa Robert Love        2011-12-20  419  		}
97fbfef6bd5978 Shuxiao Zhang      2017-04-06  420  		vmfile->f_mode |= FMODE_LSEEK;
3e338d3c95c735 Suren Baghdasaryan 2020-07-30  421  		inode = file_inode(vmfile);
3e338d3c95c735 Suren Baghdasaryan 2020-07-30  422  		lockdep_set_class(&inode->i_rwsem, &backing_shmem_inode_class);
11980c2ac4ccfa Robert Love        2011-12-20  423  		asma->file = vmfile;
6d67b0290b4b84 Suren Baghdasaryan 2020-01-27  424  		/*
6d67b0290b4b84 Suren Baghdasaryan 2020-01-27  425  		 * override mmap operation of the vmfile so that it can't be
6d67b0290b4b84 Suren Baghdasaryan 2020-01-27  426  		 * remapped which would lead to creation of a new vma with no
6d67b0290b4b84 Suren Baghdasaryan 2020-01-27  427  		 * asma permission checks. Have to override get_unmapped_area
6d67b0290b4b84 Suren Baghdasaryan 2020-01-27  428  		 * as well to prevent VM_BUG_ON check for f_ops modification.
6d67b0290b4b84 Suren Baghdasaryan 2020-01-27  429  		 */
6d67b0290b4b84 Suren Baghdasaryan 2020-01-27  430  		if (!vmfile_fops.mmap) {
6d67b0290b4b84 Suren Baghdasaryan 2020-01-27 @431  			vmfile_fops = *vmfile->f_op;
6d67b0290b4b84 Suren Baghdasaryan 2020-01-27 @432  			vmfile_fops.mmap = ashmem_vmfile_mmap;
6d67b0290b4b84 Suren Baghdasaryan 2020-01-27 @433  			vmfile_fops.get_unmapped_area =
6d67b0290b4b84 Suren Baghdasaryan 2020-01-27  434  					ashmem_vmfile_get_unmapped_area;
6d67b0290b4b84 Suren Baghdasaryan 2020-01-27  435  		}
6d67b0290b4b84 Suren Baghdasaryan 2020-01-27  436  		vmfile->f_op = &vmfile_fops;
11980c2ac4ccfa Robert Love        2011-12-20  437  	}
11980c2ac4ccfa Robert Love        2011-12-20  438  	get_file(asma->file);
11980c2ac4ccfa Robert Love        2011-12-20  439  
11980c2ac4ccfa Robert Love        2011-12-20  440  	/*
11980c2ac4ccfa Robert Love        2011-12-20  441  	 * XXX - Reworked to use shmem_zero_setup() instead of
11980c2ac4ccfa Robert Love        2011-12-20  442  	 * shmem_set_file while we're in staging. -jstultz
11980c2ac4ccfa Robert Love        2011-12-20  443  	 */
11980c2ac4ccfa Robert Love        2011-12-20  444  	if (vma->vm_flags & VM_SHARED) {
11980c2ac4ccfa Robert Love        2011-12-20  445  		ret = shmem_zero_setup(vma);
11980c2ac4ccfa Robert Love        2011-12-20  446  		if (ret) {
11980c2ac4ccfa Robert Love        2011-12-20  447  			fput(asma->file);
11980c2ac4ccfa Robert Love        2011-12-20  448  			goto out;
11980c2ac4ccfa Robert Love        2011-12-20  449  		}
44960f2a7b63e2 John Stultz        2018-07-31  450  	} else {
44960f2a7b63e2 John Stultz        2018-07-31  451  		vma_set_anonymous(vma);
11980c2ac4ccfa Robert Love        2011-12-20  452  	}
11980c2ac4ccfa Robert Love        2011-12-20  453  
295992fb815e79 Christian K�nig    2020-09-14  454  	vma_set_file(vma, asma->file);
295992fb815e79 Christian K�nig    2020-09-14  455  	/* XXX: merge this with the get_file() above if possible */
295992fb815e79 Christian K�nig    2020-09-14  456  	fput(asma->file);
11980c2ac4ccfa Robert Love        2011-12-20  457  
11980c2ac4ccfa Robert Love        2011-12-20  458  out:
11980c2ac4ccfa Robert Love        2011-12-20  459  	mutex_unlock(&ashmem_mutex);
11980c2ac4ccfa Robert Love        2011-12-20  460  	return ret;
11980c2ac4ccfa Robert Love        2011-12-20  461  }
11980c2ac4ccfa Robert Love        2011-12-20  462  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
