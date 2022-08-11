Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982B05906D6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 21:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbiHKTJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 15:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiHKTJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 15:09:05 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC398A1A5E;
        Thu, 11 Aug 2022 12:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660244944; x=1691780944;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MSJBbF/M9HYaTdCscRR7v5/d3Esdu4eDRtn+bYyVNcQ=;
  b=U62qP/1S4HlOaanXNjnBgWIcxR2JaG6JU2Iz3iRzaIvqxXgC0cFclLUy
   Nx2maykMr/Q73HMZyAlD11nPr+QScnTjP6Xm+sX83z66POVvccQpHDnKV
   zLt0D0gFAQ8ndpK0qU17fATxbDQq/iE2XOIuSagZ662glVkPJ7vukFrRZ
   AeFT7VdN4cWn/ePWdZlziIsSlva+vxmH2SIp/EVz8XSotO6+kSi+6P52E
   dhMNY5fNs17QzMvZeXRgy+rjB1AfmNcGZlQTNDZkp6yWa9f2prKo8hqMI
   Tr9vlbBQWU4W8Bgxkc97D1bUBK52FMFF2zN1gLdFzCywkM9I7PJsKMTyl
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="291440918"
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="291440918"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 12:09:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="638634331"
Received: from lkp-server02.sh.intel.com (HELO cfab306db114) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 11 Aug 2022 12:09:02 -0700
Received: from kbuild by cfab306db114 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMDYE-0000Yd-0l;
        Thu, 11 Aug 2022 19:09:02 +0000
Date:   Fri, 12 Aug 2022 03:08:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hongchen Zhang <zhanghongchen@loongson.cn>,
        Jens Axboe <axboe@kernel.dk>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hongchen Zhang <zhanghongchen@loongson.cn>
Subject: Re: [PATCH] blk-wbt: do not throttle swap write on processes other
 than kswapd
Message-ID: <202208120245.VvjRBGkd-lkp@intel.com>
References: <1660217545-10697-1-git-send-email-zhanghongchen@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1660217545-10697-1-git-send-email-zhanghongchen@loongson.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hongchen,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on linus/master v5.19 next-20220811]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hongchen-Zhang/blk-wbt-do-not-throttle-swap-write-on-processes-other-than-kswapd/20220811-193652
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: arm-randconfig-r001-20220811 (https://download.01.org/0day-ci/archive/20220812/202208120245.VvjRBGkd-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/a3ed95d0b72fa83c2ad007bee31d928fad40e70d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Hongchen-Zhang/blk-wbt-do-not-throttle-swap-write-on-processes-other-than-kswapd/20220811-193652
        git checkout a3ed95d0b72fa83c2ad007bee31d928fad40e70d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> block/blk-wbt.c:558:26: error: use of undeclared identifier 'end_swap_bio_write'
                       (bio->bi_end_io != end_swap_bio_write))
                                          ^
   1 error generated.


vim +/end_swap_bio_write +558 block/blk-wbt.c

   542	
   543	static enum wbt_flags bio_to_wbt_flags(struct rq_wb *rwb, struct bio *bio)
   544	{
   545		enum wbt_flags flags = 0;
   546	
   547		if (!rwb_enabled(rwb))
   548			return 0;
   549	
   550		if (bio_op(bio) == REQ_OP_READ) {
   551			flags = WBT_READ;
   552		} else if (wbt_should_throttle(bio)) {
   553			if (current_is_kswapd())
   554				flags |= WBT_KSWAPD;
   555			if (bio_op(bio) == REQ_OP_DISCARD)
   556				flags |= WBT_DISCARD;
   557			if (current_is_kswapd() ||
 > 558			    (bio->bi_end_io != end_swap_bio_write))
   559				flags |= WBT_TRACKED;
   560		}
   561		return flags;
   562	}
   563	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
