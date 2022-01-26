Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6FD49D344
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 21:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiAZUOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 15:14:23 -0500
Received: from mga06.intel.com ([134.134.136.31]:63939 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230151AbiAZUOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 15:14:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643228059; x=1674764059;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mavm4/Rqr/SQTDR2DDQ0rtPEdvZEj19x4XFo/LQMLKY=;
  b=n1fC0bAoKugfloHOGYXYIEw++HIHtTjlUScKfFMqD7+OI2t1KrEdQEMk
   pqnBoCtlfoxVzU5yU5YGPMxL04E12ijbnl9PBzx+aUlBa7BzEcCGdBoiM
   Y7mxqOhsywIzIFusRqSnJ08bGWdGv8Q1VyE8O7hq/V1bzi74Bbf7D9ftw
   B7d5mYVeVJYnDeYYZiI863Rykx5ig2BLss7Cto044LV1z9zh89E7CLb62
   Um6lBbaGH72H3h4RW4JxeYKfkrLAWuJ3Oi/TK5mdQW6WroV5lkOPKwYjB
   nY2oJMwGhRMortVyLlyDdkjXdZybyXDsBp2WhaPAOr3gaPo8Hy+mYujdk
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="307356907"
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="307356907"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 12:14:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="563521333"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 26 Jan 2022 12:14:16 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCogJ-000Lc7-E9; Wed, 26 Jan 2022 20:14:15 +0000
Date:   Thu, 27 Jan 2022 04:13:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        robh+dt@kernel.org, gregkh@linuxfoundation.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        devicetree@vger.kernel.org, ekangupt@qti.qualcomm.com,
        bkumar@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        srini@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org,
        Vamsi Krishna Gattupalli <quic_vgattupa@quicinc.com>
Subject: Re: [PATCH v3 11/12] misc: fastrpc: Add dma handle implementation
Message-ID: <202201270440.GvskN5kg-lkp@intel.com>
References: <20220126135304.16340-12-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126135304.16340-12-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on robh/for-next linux/master linus/master v5.17-rc1 next-20220125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Srinivas-Kandagatla/misc-fastrpc-Add-missing-DSP-FastRPC-features/20220126-215705
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 515a2f507491e7c3818e74ef4f4e088c1fecb190
config: hexagon-randconfig-r041-20220124 (https://download.01.org/0day-ci/archive/20220127/202201270440.GvskN5kg-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 2a1b7aa016c0f4b5598806205bdfbab1ea2d92c4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/70d5973b9373ab26b6a1ed520ee07b71c7bdba63
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Srinivas-Kandagatla/misc-fastrpc-Add-missing-DSP-FastRPC-features/20220126-215705
        git checkout 70d5973b9373ab26b6a1ed520ee07b71c7bdba63
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/misc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/misc/fastrpc.c:1862:13: warning: stack frame size (1256) exceeds limit (1024) in 'fastrpc_device_ioctl' [-Wframe-larger-than]
   static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
               ^
   1 warning generated.


vim +/fastrpc_device_ioctl +1862 drivers/misc/fastrpc.c

b1c0b7969aa4918 Jeya R              2022-01-26  1861  
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08 @1862  static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  1863  				 unsigned long arg)
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  1864  {
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  1865  	struct fastrpc_user *fl = (struct fastrpc_user *)file->private_data;
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  1866  	char __user *argp = (char __user *)arg;
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  1867  	int err;
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  1868  
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  1869  	switch (cmd) {
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  1870  	case FASTRPC_IOCTL_INVOKE:
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  1871  		err = fastrpc_invoke(fl, argp);
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  1872  		break;
d73f71c7c6ee158 Srinivas Kandagatla 2019-02-08  1873  	case FASTRPC_IOCTL_INIT_ATTACH:
6010d9befc8df89 Jonathan Marek      2020-09-08  1874  		err = fastrpc_init_attach(fl, AUDIO_PD);
6010d9befc8df89 Jonathan Marek      2020-09-08  1875  		break;
6010d9befc8df89 Jonathan Marek      2020-09-08  1876  	case FASTRPC_IOCTL_INIT_ATTACH_SNS:
6010d9befc8df89 Jonathan Marek      2020-09-08  1877  		err = fastrpc_init_attach(fl, SENSORS_PD);
d73f71c7c6ee158 Srinivas Kandagatla 2019-02-08  1878  		break;
d73f71c7c6ee158 Srinivas Kandagatla 2019-02-08  1879  	case FASTRPC_IOCTL_INIT_CREATE:
d73f71c7c6ee158 Srinivas Kandagatla 2019-02-08  1880  		err = fastrpc_init_create_process(fl, argp);
d73f71c7c6ee158 Srinivas Kandagatla 2019-02-08  1881  		break;
6cffd79504ce040 Srinivas Kandagatla 2019-02-08  1882  	case FASTRPC_IOCTL_ALLOC_DMA_BUFF:
6cffd79504ce040 Srinivas Kandagatla 2019-02-08  1883  		err = fastrpc_dmabuf_alloc(fl, argp);
6cffd79504ce040 Srinivas Kandagatla 2019-02-08  1884  		break;
2419e55e532de14 Jorge Ramirez-Ortiz 2019-10-09  1885  	case FASTRPC_IOCTL_MMAP:
2419e55e532de14 Jorge Ramirez-Ortiz 2019-10-09  1886  		err = fastrpc_req_mmap(fl, argp);
2419e55e532de14 Jorge Ramirez-Ortiz 2019-10-09  1887  		break;
2419e55e532de14 Jorge Ramirez-Ortiz 2019-10-09  1888  	case FASTRPC_IOCTL_MUNMAP:
2419e55e532de14 Jorge Ramirez-Ortiz 2019-10-09  1889  		err = fastrpc_req_munmap(fl, argp);
2419e55e532de14 Jorge Ramirez-Ortiz 2019-10-09  1890  		break;
b1c0b7969aa4918 Jeya R              2022-01-26  1891  	case FASTRPC_IOCTL_MEM_MAP:
b1c0b7969aa4918 Jeya R              2022-01-26  1892  		err = fastrpc_req_mem_map(fl, argp);
b1c0b7969aa4918 Jeya R              2022-01-26  1893  		break;
b1c0b7969aa4918 Jeya R              2022-01-26  1894  	case FASTRPC_IOCTL_MEM_UNMAP:
b1c0b7969aa4918 Jeya R              2022-01-26  1895  		err = fastrpc_req_mem_unmap(fl, argp);
b1c0b7969aa4918 Jeya R              2022-01-26  1896  		break;
a22465bb4904fac Jeya R              2022-01-26  1897  	case FASTRPC_IOCTL_GET_DSP_INFO:
a22465bb4904fac Jeya R              2022-01-26  1898  		err = fastrpc_get_dsp_info(fl, argp);
a22465bb4904fac Jeya R              2022-01-26  1899  		break;
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  1900  	default:
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  1901  		err = -ENOTTY;
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  1902  		break;
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  1903  	}
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  1904  
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  1905  	return err;
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  1906  }
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  1907  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
