Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1EF846830A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 07:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243904AbhLDHBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 02:01:10 -0500
Received: from mga02.intel.com ([134.134.136.20]:26720 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243085AbhLDHBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 02:01:07 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="224351909"
X-IronPort-AV: E=Sophos;i="5.87,286,1631602800"; 
   d="scan'208";a="224351909"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 22:57:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,286,1631602800"; 
   d="scan'208";a="513589867"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 03 Dec 2021 22:57:40 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtOzM-000Icq-6S; Sat, 04 Dec 2021 06:57:40 +0000
Date:   Sat, 4 Dec 2021 14:57:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arnd-playground:randconfig-5.16-min 150/191]
 drivers/video/fbdev/core/fb_device.c:88:39: sparse: sparse: incorrect type
 in argument 2 (different address spaces)
Message-ID: <202112041429.98MqQ9EC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git randconfig-5.16-min
head:   7a16665b8fd19f170c0c15f1432c90e4750183f2
commit: afe2d6eb5b95934595688e04a31c657cce11c01b [150/191] fbdev: move chrdev code into fb_device.c
config: nios2-randconfig-s032-20211203 (https://download.01.org/0day-ci/archive/20211204/202112041429.98MqQ9EC-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/commit/?id=afe2d6eb5b95934595688e04a31c657cce11c01b
        git remote add arnd-playground https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
        git fetch --no-tags arnd-playground randconfig-5.16-min
        git checkout afe2d6eb5b95934595688e04a31c657cce11c01b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=nios2 SHELL=/bin/bash drivers/video/fbdev/core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/video/fbdev/core/fb_device.c:88:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *s @@     got unsigned char [noderef] [usertype] __iomem *[assigned] src @@
   drivers/video/fbdev/core/fb_device.c:88:39: sparse:     expected void const *s
   drivers/video/fbdev/core/fb_device.c:88:39: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] src
>> drivers/video/fbdev/core/fb_device.c:165:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *d @@     got unsigned char [noderef] [usertype] __iomem *[assigned] dst @@
   drivers/video/fbdev/core/fb_device.c:165:32: sparse:     expected void *d
   drivers/video/fbdev/core/fb_device.c:165:32: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] dst

vim +88 drivers/video/fbdev/core/fb_device.c

    41	
    42	static ssize_t
    43	fb_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
    44	{
    45		unsigned long p = *ppos;
    46		struct fb_info *info = file_fb_info(file);
    47		u8 *buffer, *dst;
    48		u8 __iomem *src;
    49		int c, cnt = 0, err = 0;
    50		unsigned long total_size;
    51	
    52		if (!info || ! info->screen_base)
    53			return -ENODEV;
    54	
    55		if (info->state != FBINFO_STATE_RUNNING)
    56			return -EPERM;
    57	
    58		if (info->fbops->fb_read)
    59			return info->fbops->fb_read(info, buf, count, ppos);
    60	
    61		total_size = info->screen_size;
    62	
    63		if (total_size == 0)
    64			total_size = info->fix.smem_len;
    65	
    66		if (p >= total_size)
    67			return 0;
    68	
    69		if (count >= total_size)
    70			count = total_size;
    71	
    72		if (count + p > total_size)
    73			count = total_size - p;
    74	
    75		buffer = kmalloc((count > PAGE_SIZE) ? PAGE_SIZE : count,
    76				 GFP_KERNEL);
    77		if (!buffer)
    78			return -ENOMEM;
    79	
    80		src = (u8 __iomem *) (info->screen_base + p);
    81	
    82		if (info->fbops->fb_sync)
    83			info->fbops->fb_sync(info);
    84	
    85		while (count) {
    86			c  = (count > PAGE_SIZE) ? PAGE_SIZE : count;
    87			dst = buffer;
  > 88			fb_memcpy_fromfb(dst, src, c);
    89			dst += c;
    90			src += c;
    91	
    92			if (copy_to_user(buf, buffer, c)) {
    93				err = -EFAULT;
    94				break;
    95			}
    96			*ppos += c;
    97			buf += c;
    98			cnt += c;
    99			count -= c;
   100		}
   101	
   102		kfree(buffer);
   103	
   104		return (err) ? err : cnt;
   105	}
   106	
   107	static ssize_t
   108	fb_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
   109	{
   110		unsigned long p = *ppos;
   111		struct fb_info *info = file_fb_info(file);
   112		u8 *buffer, *src;
   113		u8 __iomem *dst;
   114		int c, cnt = 0, err = 0;
   115		unsigned long total_size;
   116	
   117		if (!info || !info->screen_base)
   118			return -ENODEV;
   119	
   120		if (info->state != FBINFO_STATE_RUNNING)
   121			return -EPERM;
   122	
   123		if (info->fbops->fb_write)
   124			return info->fbops->fb_write(info, buf, count, ppos);
   125	
   126		total_size = info->screen_size;
   127	
   128		if (total_size == 0)
   129			total_size = info->fix.smem_len;
   130	
   131		if (p > total_size)
   132			return -EFBIG;
   133	
   134		if (count > total_size) {
   135			err = -EFBIG;
   136			count = total_size;
   137		}
   138	
   139		if (count + p > total_size) {
   140			if (!err)
   141				err = -ENOSPC;
   142	
   143			count = total_size - p;
   144		}
   145	
   146		buffer = kmalloc((count > PAGE_SIZE) ? PAGE_SIZE : count,
   147				 GFP_KERNEL);
   148		if (!buffer)
   149			return -ENOMEM;
   150	
   151		dst = (u8 __iomem *) (info->screen_base + p);
   152	
   153		if (info->fbops->fb_sync)
   154			info->fbops->fb_sync(info);
   155	
   156		while (count) {
   157			c = (count > PAGE_SIZE) ? PAGE_SIZE : count;
   158			src = buffer;
   159	
   160			if (copy_from_user(src, buf, c)) {
   161				err = -EFAULT;
   162				break;
   163			}
   164	
 > 165			fb_memcpy_tofb(dst, src, c);
   166			dst += c;
   167			src += c;
   168			*ppos += c;
   169			buf += c;
   170			cnt += c;
   171			count -= c;
   172		}
   173	
   174		kfree(buffer);
   175	
   176		return (cnt) ? cnt : err;
   177	}
   178	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
