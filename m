Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838A451F1D9
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 23:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbiEHVq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 17:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbiEHVq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 17:46:26 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7954DFAB
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 14:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652046152; x=1683582152;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gAfLF8CFVZ/vW71EH8Bx4/JhmuMGckhfC5tTLQ3bB00=;
  b=LHc+iJ+R8rddNCqN6XFaandleajEuRT43p4ziCart/SHHwTopnjQi0BT
   Gd4RJD79Njgnf/bPZz9ecMAGBgLXf+RGN6CaRNIb1FBTAK/4OfhHJx7Q4
   UHK1H6pygd2c2ZnrYsCgFzOGRFxStLOKZddkTut2cVKsEB9uAvkOp2R2W
   oZfYsrYDi18gAP7AMRYoH6PdTJ2whZSJ64CCKUXFx/ZhXe+nqDRaURR+0
   VpPGFglal4S3RcqgvSdxc9atsh+2FhXiGsaasY0GiCPvBMqeqNcUUcWeT
   Lr3V/UlV3yp7gGp0KcVNAdeboZYUO8ID3FH9adbwhmACrQZI67gMKv+2b
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="266477399"
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="266477399"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2022 14:42:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="539528989"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 May 2022 14:42:30 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nnofd-000FrT-Na;
        Sun, 08 May 2022 21:42:29 +0000
Date:   Mon, 9 May 2022 05:41:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:axboe/linux-block/fastpoll-mshot 97/98]
 fs/io_uring.c:4743:11: warning: variable 'ret' is uninitialized when used
 here
Message-ID: <202205090529.AQs5GOej-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/fastpoll-mshot
head:   883f288d64ca56518398dfa59bbdbfae1215ec03
commit: 8e0d731f259198aac32de79f7059d34b94fc0fb3 [97/98] io_uring: allow allocated fixed files for openat/openat2
config: riscv-buildonly-randconfig-r005-20220508 (https://download.01.org/0day-ci/archive/20220509/202205090529.AQs5GOej-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a385645b470e2d3a1534aae618ea56b31177639f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/8e0d731f259198aac32de79f7059d34b94fc0fb3
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/fastpoll-mshot
        git checkout 8e0d731f259198aac32de79f7059d34b94fc0fb3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/io_uring.c:4743:11: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
                           return ret;
                                  ^~~
   fs/io_uring.c:4736:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   fs/io_uring.c:6174:2: error: call to undeclared function '__io_poll_clean'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           __io_poll_clean(req);
           ^
   fs/io_uring.c:6174:2: note: did you mean '__io_fill_cqe'?
   fs/io_uring.c:2166:20: note: '__io_fill_cqe' declared here
   static inline bool __io_fill_cqe(struct io_ring_ctx *ctx, u64 user_data,
                      ^
   1 warning and 1 error generated.


vim +/ret +4743 fs/io_uring.c

  4730	
  4731	static int io_fixed_file_install(struct io_kiocb *req, unsigned int issue_flags,
  4732					 struct file *file, unsigned int file_slot)
  4733	{
  4734		int alloc_slot = file_slot == UINT_MAX;
  4735		struct io_ring_ctx *ctx = req->ctx;
  4736		int ret;
  4737	
  4738		if (alloc_slot) {
  4739			io_ring_submit_lock(ctx, issue_flags);
  4740			file_slot = io_file_bitmap_get(ctx);
  4741			if (unlikely(file_slot < 0)) {
  4742				io_ring_submit_unlock(ctx, issue_flags);
> 4743				return ret;
  4744			}
  4745		}
  4746	
  4747		ret = io_install_fixed_file(req, file, issue_flags, file_slot);
  4748		if (alloc_slot) {
  4749			io_ring_submit_unlock(ctx, issue_flags);
  4750			return file_slot;
  4751		}
  4752	
  4753		return ret;
  4754	}
  4755	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
