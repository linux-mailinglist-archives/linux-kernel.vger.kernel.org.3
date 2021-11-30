Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3865B4643A2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345438AbhK3X41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:56:27 -0500
Received: from mga17.intel.com ([192.55.52.151]:51008 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230058AbhK3X4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:56:21 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="217036654"
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="217036654"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 15:53:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="477314559"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 30 Nov 2021 15:52:55 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1msCve-000DvS-Fp; Tue, 30 Nov 2021 23:52:54 +0000
Date:   Wed, 1 Dec 2021 07:52:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeya R <jeyr@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        srinivas.kandagatla@linaro.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Jeya R <jeyr@codeaurora.org>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, fastrpc.upstream@qti.qualcomm.com,
        bkumar@qti.qualcomm.com, ekangupt@qti.qualcomm.com,
        jeyr@qti.qualcomm.com
Subject: Re: [PATCH 1/2] misc: fastrpc: Add fdlist implementation
Message-ID: <202112010754.IfnGCvD7-lkp@intel.com>
References: <1638277072-6459-3-git-send-email-jeyr@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638277072-6459-3-git-send-email-jeyr@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeya,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on v5.16-rc3 next-20211130]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jeya-R/misc-fastrpc-Add-fdlist-implementation/20211130-215833
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 5d331b5922551637c586cdf5fdc1778910fc937f
config: hexagon-randconfig-r045-20211129 (https://download.01.org/0day-ci/archive/20211201/202112010754.IfnGCvD7-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 25eb7fa01d7ebbe67648ea03841cda55b4239ab2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/d9eaed76074c94c9751c3a587ef2409fa7ce153e
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jeya-R/misc-fastrpc-Add-fdlist-implementation/20211130-215833
        git checkout d9eaed76074c94c9751c3a587ef2409fa7ce153e
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
