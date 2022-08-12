Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FF45913F8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 18:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236532AbiHLQhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 12:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiHLQhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 12:37:51 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E970492F7D
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 09:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660322270; x=1691858270;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/dzpJIgS93EYpfAA9mCXa3iE1jUztbDyfSdrEPy+a0Y=;
  b=ATHJ7H69y3GpCz9oEEErORlLKC5hHj0NCZWKKXG3YsdmfODgP8MhlihX
   U7+VvR/vLepDkYLI2o2FGi/SDhtUM23Kdde+k6Dg4pS/JoPKFKdv1gDlj
   fnKYoPziccFbMSJ5OjKw1nnjPtQicK0Jk5ieAA8ZsGcPJzi0tQc644RMe
   lUMb8roFsAcCprX2q54eNgugT+jYkGzYgypwIPRvKv2s/cUb2ughndqjV
   uBE/d2vmRwVeqi1RUnS3/QI2+TPyRRw5EtgW2enXa3ao/RN7mctNxeu+D
   ar0GRwz4km3aYPMJWyIXKTqigfKBZrT0jLANJPduJW9wmtMH1JMD3CESw
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="290382922"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="290382922"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 09:37:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="609305555"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 12 Aug 2022 09:37:49 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMXfQ-0000kh-2g;
        Fri, 12 Aug 2022 16:37:48 +0000
Date:   Sat, 13 Aug 2022 00:36:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kbusch:io_uring/dma-register-v2 7/8] io_uring/io_uring.c:3791:45:
 error: passing argument 2 of 'file_dma_map' from incompatible pointer type
Message-ID: <202208130039.jwwRVomj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git io_uring/dma-register-v2
head:   c86a9580d33ff9bf90c685f452b66b929f1dc5fe
commit: ba3ab9f0c82ae764b7da4cb7e8df548439b2ec72 [7/8] io_uring: add support for dma pre-mapping
config: sh-randconfig-c043-20220811 (https://download.01.org/0day-ci/archive/20220813/202208130039.jwwRVomj-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git/commit/?id=ba3ab9f0c82ae764b7da4cb7e8df548439b2ec72
        git remote add kbusch https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git
        git fetch --no-tags kbusch io_uring/dma-register-v2
        git checkout ba3ab9f0c82ae764b7da4cb7e8df548439b2ec72
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/uapi/linux/aio_abi.h:31,
                    from include/linux/syscalls.h:77,
                    from io_uring/io_uring.c:45:
   include/linux/fs.h:3610:60: warning: 'struct bio_vec' declared inside parameter list will not be visible outside of this definition or declaration
    3610 | static inline void *file_dma_map(struct file *file, struct bio_vec *bvec,
         |                                                            ^~~~~~~
   io_uring/io_uring.c: In function '__io_submit_flush_completions':
   io_uring/io_uring.c:1183:40: warning: variable 'prev' set but not used [-Wunused-but-set-variable]
    1183 |         struct io_wq_work_node *node, *prev;
         |                                        ^~~~
   io_uring/io_uring.c: In function 'io_register_map_buffers':
>> io_uring/io_uring.c:3791:45: error: passing argument 2 of 'file_dma_map' from incompatible pointer type [-Werror=incompatible-pointer-types]
    3791 |                 tag = file_dma_map(file, imu->bvec, imu->nr_bvecs);
         |                                          ~~~^~~~~~
         |                                             |
         |                                             struct bio_vec *
   include/linux/fs.h:3610:69: note: expected 'struct bio_vec *' but argument is of type 'struct bio_vec *'
    3610 | static inline void *file_dma_map(struct file *file, struct bio_vec *bvec,
         |                                                     ~~~~~~~~~~~~~~~~^~~~
   cc1: some warnings being treated as errors


vim +/file_dma_map +3791 io_uring/io_uring.c

  3758	
  3759	static int io_register_map_buffers(struct io_ring_ctx *ctx, void __user *arg)
  3760	{
  3761		struct io_uring_map_buffers map;
  3762		struct io_fixed_file *file_slot;
  3763		struct file *file;
  3764		int ret, i;
  3765	
  3766		if (!capable(CAP_SYS_ADMIN))
  3767			return -EPERM;
  3768	
  3769		ret = get_map_range(ctx, &map, arg);
  3770		if (ret < 0)
  3771			return ret;
  3772	
  3773		file_slot = io_fixed_file_slot(&ctx->file_table,
  3774				array_index_nospec(map.fd, ctx->nr_user_files));
  3775		if (!file_slot->file_ptr)
  3776			return -EBADF;
  3777	
  3778		file = io_file_from_fixed(file_slot);
  3779		if (!(file->f_flags & O_DIRECT))
  3780			return -EOPNOTSUPP;
  3781	
  3782		for (i = map.buf_start; i < map.buf_end; i++) {
  3783			struct io_mapped_ubuf *imu = ctx->user_bufs[i];
  3784			void *tag;
  3785	
  3786			if (imu->dma_tag) {
  3787				ret = -EBUSY;
  3788				goto err;
  3789			}
  3790	
> 3791			tag = file_dma_map(file, imu->bvec, imu->nr_bvecs);
  3792			if (IS_ERR(tag)) {
  3793				ret = PTR_ERR(tag);
  3794				goto err;
  3795			}
  3796	
  3797			imu->dma_tag = tag;
  3798			imu->dma_file = file;
  3799		}
  3800	
  3801		return 0;
  3802	err:
  3803		while (--i >= map.buf_start) {
  3804			struct io_mapped_ubuf *imu = ctx->user_bufs[i];
  3805	
  3806			io_dma_unmap(imu);
  3807		}
  3808		return ret;
  3809	}
  3810	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
