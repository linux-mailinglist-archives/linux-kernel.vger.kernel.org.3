Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F86747AB14
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 15:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbhLTOM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 09:12:29 -0500
Received: from mga18.intel.com ([134.134.136.126]:25239 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233240AbhLTOM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 09:12:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640009548; x=1671545548;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5lfjwnzMCeNU5IlDDY2uRKlfRFO78fDP0a/50Y6zblE=;
  b=ng+vh875LAKx6aJX5rE3yVMZhx+2XzzYUlxcqcXWDkkOz8eYYQzz6+1o
   xPClaRqwbF3kJREFutjxiEQFdGjfh1L8rYn+GDEbmutnAzECCo2cjNuOs
   TZMNpi0OJU01r8r35ifzjGYiByQfNz69mnSFdNAwhH475q1qdWDLGROWA
   JjQ8hX6VrYJ0tPuSHxh98XXg9L8Nv6Kud1Wqs8PSpiNWmDgPkt8oU8DCF
   78ki2ovzHQNadDEpDW5z+NxHukc7mQPqQFWt0XYC9JFaCmOt1ZPg/aFeb
   278Ie15fxyyv89F+stpDXfAc0q4C/HQPfo0RgcgVC0+jKJsaE+pa13/jR
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10203"; a="227027309"
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="227027309"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 06:07:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="757299796"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 20 Dec 2021 06:07:08 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzJJj-0007pg-OR; Mon, 20 Dec 2021 14:07:07 +0000
Date:   Mon, 20 Dec 2021 22:06:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>, kraxel@redhat.com,
        sumit.semwal@linaro.org, christian.koenig@amd.com
Cc:     kbuild-all@lists.01.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: Re: [PATCH] udmabuf: put dmabuf in case of get fd failed
Message-ID: <202112202101.tVpymGaH-lkp@intel.com>
References: <20211220054333.3041893-1-xianting.tian@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220054333.3041893-1-xianting.tian@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xianting,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.16-rc6 next-20211217]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Xianting-Tian/udmabuf-put-dmabuf-in-case-of-get-fd-failed/20211220-134433
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git a7904a538933c525096ca2ccde1e60d0ee62c08e
config: arc-randconfig-r043-20211220 (https://download.01.org/0day-ci/archive/20211220/202112202101.tVpymGaH-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/322781a4da9de4a3057afd933108d23ca7f5282e
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Xianting-Tian/udmabuf-put-dmabuf-in-case-of-get-fd-failed/20211220-134433
        git checkout 322781a4da9de4a3057afd933108d23ca7f5282e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/dma-buf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers/dma-buf/udmabuf.c: In function 'udmabuf_create':
>> drivers/dma-buf/udmabuf.c:292:13: error: invalid storage class for function 'udmabuf_ioctl_create'
     292 | static long udmabuf_ioctl_create(struct file *filp, unsigned long arg)
         |             ^~~~~~~~~~~~~~~~~~~~
>> drivers/dma-buf/udmabuf.c:292:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     292 | static long udmabuf_ioctl_create(struct file *filp, unsigned long arg)
         | ^~~~~~
>> drivers/dma-buf/udmabuf.c:311:13: error: invalid storage class for function 'udmabuf_ioctl_create_list'
     311 | static long udmabuf_ioctl_create_list(struct file *filp, unsigned long arg)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/dma-buf/udmabuf.c:332:13: error: invalid storage class for function 'udmabuf_ioctl'
     332 | static long udmabuf_ioctl(struct file *filp, unsigned int ioctl,
         |             ^~~~~~~~~~~~~
>> drivers/dma-buf/udmabuf.c:353:27: error: initializer element is not constant
     353 |         .unlocked_ioctl = udmabuf_ioctl,
         |                           ^~~~~~~~~~~~~
   drivers/dma-buf/udmabuf.c:353:27: note: (near initialization for 'udmabuf_fops.unlocked_ioctl')
>> drivers/dma-buf/udmabuf.c:365:19: error: invalid storage class for function 'udmabuf_dev_init'
     365 | static int __init udmabuf_dev_init(void)
         |                   ^~~~~~~~~~~~~~~~
>> drivers/dma-buf/udmabuf.c:370:20: error: invalid storage class for function 'udmabuf_dev_exit'
     370 | static void __exit udmabuf_dev_exit(void)
         |                    ^~~~~~~~~~~~~~~~
   In file included from include/linux/cred.h:12,
                    from drivers/dma-buf/udmabuf.c:2:
   drivers/dma-buf/udmabuf.c:375:13: error: initializer element is not constant
     375 | module_init(udmabuf_dev_init)
         |             ^~~~~~~~~~~~~~~~
   include/linux/init.h:250:55: note: in definition of macro '____define_initcall'
     250 |                 __attribute__((__section__(__sec))) = fn;
         |                                                       ^~
   include/linux/init.h:260:9: note: in expansion of macro '__unique_initcall'
     260 |         __unique_initcall(fn, id, __sec, __initcall_id(fn))
         |         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:262:35: note: in expansion of macro '___define_initcall'
     262 | #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/init.h:291:41: note: in expansion of macro '__define_initcall'
     291 | #define device_initcall(fn)             __define_initcall(fn, 6)
         |                                         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:296:24: note: in expansion of macro 'device_initcall'
     296 | #define __initcall(fn) device_initcall(fn)
         |                        ^~~~~~~~~~~~~~~
   include/linux/module.h:88:25: note: in expansion of macro '__initcall'
      88 | #define module_init(x)  __initcall(x);
         |                         ^~~~~~~~~~
   drivers/dma-buf/udmabuf.c:375:1: note: in expansion of macro 'module_init'
     375 | module_init(udmabuf_dev_init)
         | ^~~~~~~~~~~
   drivers/dma-buf/udmabuf.c:376:13: error: initializer element is not constant
     376 | module_exit(udmabuf_dev_exit)
         |             ^~~~~~~~~~~~~~~~
   include/linux/init.h:299:57: note: in definition of macro '__exitcall'
     299 |         static exitcall_t __exitcall_##fn __exit_call = fn
         |                                                         ^~
   drivers/dma-buf/udmabuf.c:376:1: note: in expansion of macro 'module_exit'
     376 | module_exit(udmabuf_dev_exit)
         | ^~~~~~~~~~~
>> include/linux/init.h:299:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     299 |         static exitcall_t __exitcall_##fn __exit_call = fn
         |         ^~~~~~
   include/linux/module.h:100:25: note: in expansion of macro '__exitcall'
     100 | #define module_exit(x)  __exitcall(x);
         |                         ^~~~~~~~~~
   drivers/dma-buf/udmabuf.c:376:1: note: in expansion of macro 'module_exit'
     376 | module_exit(udmabuf_dev_exit)
         | ^~~~~~~~~~~
>> drivers/dma-buf/udmabuf.c:379:1: error: expected declaration or statement at end of input
     379 | MODULE_LICENSE("GPL v2");
         | ^~~~~~~~~~~~~~


vim +/udmabuf_ioctl_create +292 drivers/dma-buf/udmabuf.c

fbb0de795078190 Gerd Hoffmann          2018-08-27  291  
fbb0de795078190 Gerd Hoffmann          2018-08-27 @292  static long udmabuf_ioctl_create(struct file *filp, unsigned long arg)
fbb0de795078190 Gerd Hoffmann          2018-08-27  293  {
fbb0de795078190 Gerd Hoffmann          2018-08-27  294  	struct udmabuf_create create;
fbb0de795078190 Gerd Hoffmann          2018-08-27  295  	struct udmabuf_create_list head;
fbb0de795078190 Gerd Hoffmann          2018-08-27  296  	struct udmabuf_create_item list;
fbb0de795078190 Gerd Hoffmann          2018-08-27  297  
fbb0de795078190 Gerd Hoffmann          2018-08-27  298  	if (copy_from_user(&create, (void __user *)arg,
33f35429fc49c09 Gerd Hoffmann          2018-09-11  299  			   sizeof(create)))
fbb0de795078190 Gerd Hoffmann          2018-08-27  300  		return -EFAULT;
fbb0de795078190 Gerd Hoffmann          2018-08-27  301  
fbb0de795078190 Gerd Hoffmann          2018-08-27  302  	head.flags  = create.flags;
fbb0de795078190 Gerd Hoffmann          2018-08-27  303  	head.count  = 1;
fbb0de795078190 Gerd Hoffmann          2018-08-27  304  	list.memfd  = create.memfd;
fbb0de795078190 Gerd Hoffmann          2018-08-27  305  	list.offset = create.offset;
fbb0de795078190 Gerd Hoffmann          2018-08-27  306  	list.size   = create.size;
fbb0de795078190 Gerd Hoffmann          2018-08-27  307  
c1bbed668997268 Gurchetan Singh        2019-12-02  308  	return udmabuf_create(filp->private_data, &head, &list);
fbb0de795078190 Gerd Hoffmann          2018-08-27  309  }
fbb0de795078190 Gerd Hoffmann          2018-08-27  310  
fbb0de795078190 Gerd Hoffmann          2018-08-27 @311  static long udmabuf_ioctl_create_list(struct file *filp, unsigned long arg)
fbb0de795078190 Gerd Hoffmann          2018-08-27  312  {
fbb0de795078190 Gerd Hoffmann          2018-08-27  313  	struct udmabuf_create_list head;
fbb0de795078190 Gerd Hoffmann          2018-08-27  314  	struct udmabuf_create_item *list;
fbb0de795078190 Gerd Hoffmann          2018-08-27  315  	int ret = -EINVAL;
fbb0de795078190 Gerd Hoffmann          2018-08-27  316  	u32 lsize;
fbb0de795078190 Gerd Hoffmann          2018-08-27  317  
fbb0de795078190 Gerd Hoffmann          2018-08-27  318  	if (copy_from_user(&head, (void __user *)arg, sizeof(head)))
fbb0de795078190 Gerd Hoffmann          2018-08-27  319  		return -EFAULT;
dc4716d75154b36 Gerd Hoffmann          2018-09-11  320  	if (head.count > list_limit)
fbb0de795078190 Gerd Hoffmann          2018-08-27  321  		return -EINVAL;
fbb0de795078190 Gerd Hoffmann          2018-08-27  322  	lsize = sizeof(struct udmabuf_create_item) * head.count;
fbb0de795078190 Gerd Hoffmann          2018-08-27  323  	list = memdup_user((void __user *)(arg + sizeof(head)), lsize);
fbb0de795078190 Gerd Hoffmann          2018-08-27  324  	if (IS_ERR(list))
fbb0de795078190 Gerd Hoffmann          2018-08-27  325  		return PTR_ERR(list);
fbb0de795078190 Gerd Hoffmann          2018-08-27  326  
c1bbed668997268 Gurchetan Singh        2019-12-02  327  	ret = udmabuf_create(filp->private_data, &head, list);
fbb0de795078190 Gerd Hoffmann          2018-08-27  328  	kfree(list);
fbb0de795078190 Gerd Hoffmann          2018-08-27  329  	return ret;
fbb0de795078190 Gerd Hoffmann          2018-08-27  330  }
fbb0de795078190 Gerd Hoffmann          2018-08-27  331  
fbb0de795078190 Gerd Hoffmann          2018-08-27 @332  static long udmabuf_ioctl(struct file *filp, unsigned int ioctl,
fbb0de795078190 Gerd Hoffmann          2018-08-27  333  			  unsigned long arg)
fbb0de795078190 Gerd Hoffmann          2018-08-27  334  {
fbb0de795078190 Gerd Hoffmann          2018-08-27  335  	long ret;
fbb0de795078190 Gerd Hoffmann          2018-08-27  336  
fbb0de795078190 Gerd Hoffmann          2018-08-27  337  	switch (ioctl) {
fbb0de795078190 Gerd Hoffmann          2018-08-27  338  	case UDMABUF_CREATE:
fbb0de795078190 Gerd Hoffmann          2018-08-27  339  		ret = udmabuf_ioctl_create(filp, arg);
fbb0de795078190 Gerd Hoffmann          2018-08-27  340  		break;
fbb0de795078190 Gerd Hoffmann          2018-08-27  341  	case UDMABUF_CREATE_LIST:
fbb0de795078190 Gerd Hoffmann          2018-08-27  342  		ret = udmabuf_ioctl_create_list(filp, arg);
fbb0de795078190 Gerd Hoffmann          2018-08-27  343  		break;
fbb0de795078190 Gerd Hoffmann          2018-08-27  344  	default:
52499d9cdd88784 Gerd Hoffmann          2018-09-11  345  		ret = -ENOTTY;
fbb0de795078190 Gerd Hoffmann          2018-08-27  346  		break;
fbb0de795078190 Gerd Hoffmann          2018-08-27  347  	}
fbb0de795078190 Gerd Hoffmann          2018-08-27  348  	return ret;
fbb0de795078190 Gerd Hoffmann          2018-08-27  349  }
fbb0de795078190 Gerd Hoffmann          2018-08-27  350  
fbb0de795078190 Gerd Hoffmann          2018-08-27  351  static const struct file_operations udmabuf_fops = {
fbb0de795078190 Gerd Hoffmann          2018-08-27  352  	.owner		= THIS_MODULE,
fbb0de795078190 Gerd Hoffmann          2018-08-27 @353  	.unlocked_ioctl = udmabuf_ioctl,
d4a197f4047e01d Kristian H. Kristensen 2020-09-03  354  #ifdef CONFIG_COMPAT
d4a197f4047e01d Kristian H. Kristensen 2020-09-03  355  	.compat_ioctl   = udmabuf_ioctl,
d4a197f4047e01d Kristian H. Kristensen 2020-09-03  356  #endif
fbb0de795078190 Gerd Hoffmann          2018-08-27  357  };
fbb0de795078190 Gerd Hoffmann          2018-08-27  358  
fbb0de795078190 Gerd Hoffmann          2018-08-27  359  static struct miscdevice udmabuf_misc = {
fbb0de795078190 Gerd Hoffmann          2018-08-27  360  	.minor          = MISC_DYNAMIC_MINOR,
fbb0de795078190 Gerd Hoffmann          2018-08-27  361  	.name           = "udmabuf",
fbb0de795078190 Gerd Hoffmann          2018-08-27  362  	.fops           = &udmabuf_fops,
fbb0de795078190 Gerd Hoffmann          2018-08-27  363  };
fbb0de795078190 Gerd Hoffmann          2018-08-27  364  
fbb0de795078190 Gerd Hoffmann          2018-08-27 @365  static int __init udmabuf_dev_init(void)
fbb0de795078190 Gerd Hoffmann          2018-08-27  366  {
fbb0de795078190 Gerd Hoffmann          2018-08-27  367  	return misc_register(&udmabuf_misc);
fbb0de795078190 Gerd Hoffmann          2018-08-27  368  }
fbb0de795078190 Gerd Hoffmann          2018-08-27  369  
fbb0de795078190 Gerd Hoffmann          2018-08-27 @370  static void __exit udmabuf_dev_exit(void)
fbb0de795078190 Gerd Hoffmann          2018-08-27  371  {
fbb0de795078190 Gerd Hoffmann          2018-08-27  372  	misc_deregister(&udmabuf_misc);
fbb0de795078190 Gerd Hoffmann          2018-08-27  373  }
fbb0de795078190 Gerd Hoffmann          2018-08-27  374  
fbb0de795078190 Gerd Hoffmann          2018-08-27  375  module_init(udmabuf_dev_init)
fbb0de795078190 Gerd Hoffmann          2018-08-27  376  module_exit(udmabuf_dev_exit)
fbb0de795078190 Gerd Hoffmann          2018-08-27  377  
fbb0de795078190 Gerd Hoffmann          2018-08-27  378  MODULE_AUTHOR("Gerd Hoffmann <kraxel@redhat.com>");
fbb0de795078190 Gerd Hoffmann          2018-08-27 @379  MODULE_LICENSE("GPL v2");

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
