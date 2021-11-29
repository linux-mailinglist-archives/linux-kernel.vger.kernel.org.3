Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6AF460FB7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 09:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242860AbhK2IGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 03:06:32 -0500
Received: from mga07.intel.com ([134.134.136.100]:14933 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240881AbhK2IEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 03:04:23 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10182"; a="299311917"
X-IronPort-AV: E=Sophos;i="5.87,272,1631602800"; 
   d="scan'208";a="299311917"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 00:01:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,272,1631602800"; 
   d="scan'208";a="746122628"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 29 Nov 2021 00:01:01 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mrbau-000Bhw-LV; Mon, 29 Nov 2021 08:01:00 +0000
Date:   Mon, 29 Nov 2021 16:00:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeya R <jeyr@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        srinivas.kandagatla@linaro.org
Cc:     kbuild-all@lists.01.org, Jeya R <jeyr@codeaurora.org>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        fastrpc.upstream@qti.qualcomm.com
Subject: Re: [PATCH 1/2] misc: fastrpc: Add fdlist implementation
Message-ID: <202111291535.1s3d27nD-lkp@intel.com>
References: <1638163720-23123-2-git-send-email-jeyr@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638163720-23123-2-git-send-email-jeyr@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeya,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on v5.16-rc3 next-20211126]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jeya-R/Add-DMA-handle-implementation/20211129-133228
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git cd455ebb748c4e198c8158e5d61b3034bf10f22b
config: microblaze-randconfig-r031-20211128 (https://download.01.org/0day-ci/archive/20211129/202111291535.1s3d27nD-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/fda521c79abfc2f40115cb53cffb3a3886e8a2f9
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jeya-R/Add-DMA-handle-implementation/20211129-133228
        git checkout fda521c79abfc2f40115cb53cffb3a3886e8a2f9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=microblaze SHELL=/bin/bash drivers/misc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/misc/fastrpc.c: In function 'fastrpc_put_args':
>> drivers/misc/fastrpc.c:923:39: error: 'fl' undeclared (first use in this function); did you mean 'fd'?
     923 |                 if (!fastrpc_map_find(fl, (int)fdlist[i], &mmap))
         |                                       ^~
         |                                       fd
   drivers/misc/fastrpc.c:923:39: note: each undeclared identifier is reported only once for each function it appears in


vim +923 drivers/misc/fastrpc.c

   886	
   887	static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
   888				    u32 kernel)
   889	{
   890		struct fastrpc_remote_arg *rpra = ctx->rpra;
   891		struct fastrpc_map *mmap = NULL;
   892		struct fastrpc_invoke_buf *list;
   893		struct fastrpc_phy_page *pages;
   894		u64 *fdlist;
   895		int i, inbufs, outbufs, handles;
   896	
   897		inbufs = REMOTE_SCALARS_INBUFS(ctx->sc);
   898		outbufs = REMOTE_SCALARS_OUTBUFS(ctx->sc);
   899		handles = REMOTE_SCALARS_INHANDLES(ctx->sc) + REMOTE_SCALARS_OUTHANDLES(ctx->sc);
   900		list = ctx->buf->virt + ctx->nscalars * sizeof(*rpra);
   901		pages = ctx->buf->virt + ctx->nscalars * (sizeof(*list) +
   902			sizeof(*rpra));
   903		fdlist = (uint64_t *)(pages + inbufs + outbufs + handles);
   904	
   905		for (i = inbufs; i < ctx->nbufs; ++i) {
   906			if (!ctx->maps[i]) {
   907				void *src = (void *)(uintptr_t)rpra[i].pv;
   908				void *dst = (void *)(uintptr_t)ctx->args[i].ptr;
   909				u64 len = rpra[i].len;
   910	
   911				if (!kernel) {
   912					if (copy_to_user((void __user *)dst, src, len))
   913						return -EFAULT;
   914				} else {
   915					memcpy(dst, src, len);
   916				}
   917			}
   918		}
   919	
   920		for (i = 0; i < FASTRPC_MAX_FDLIST; i++) {
   921			if (!fdlist[i])
   922				break;
 > 923			if (!fastrpc_map_find(fl, (int)fdlist[i], &mmap))
   924				fastrpc_map_put(mmap);
   925		}
   926	
   927		return 0;
   928	}
   929	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
