Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E13460F80
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 08:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240843AbhK2HqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 02:46:21 -0500
Received: from mga05.intel.com ([192.55.52.43]:29841 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229777AbhK2HoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 02:44:20 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10182"; a="322146940"
X-IronPort-AV: E=Sophos;i="5.87,272,1631602800"; 
   d="scan'208";a="322146940"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2021 23:41:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,272,1631602800"; 
   d="scan'208";a="539890262"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 28 Nov 2021 23:41:00 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mrbHY-000Bgp-5H; Mon, 29 Nov 2021 07:41:00 +0000
Date:   Mon, 29 Nov 2021 15:40:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeya R <jeyr@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        srinivas.kandagatla@linaro.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Jeya R <jeyr@codeaurora.org>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, fastrpc.upstream@qti.qualcomm.com
Subject: Re: [PATCH 1/2] misc: fastrpc: Add fdlist implementation
Message-ID: <202111291504.10gwO8AE-lkp@intel.com>
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
config: hexagon-randconfig-r045-20211129 (https://download.01.org/0day-ci/archive/20211129/202111291504.10gwO8AE-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project df08b2fe8b35cb63dfb3b49738a3494b9b4e6f8e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/fda521c79abfc2f40115cb53cffb3a3886e8a2f9
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jeya-R/Add-DMA-handle-implementation/20211129-133228
        git checkout fda521c79abfc2f40115cb53cffb3a3886e8a2f9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/misc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/misc/fastrpc.c:923:25: error: use of undeclared identifier 'fl'
                   if (!fastrpc_map_find(fl, (int)fdlist[i], &mmap))
                                         ^
   1 error generated.


vim +/fl +923 drivers/misc/fastrpc.c

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
