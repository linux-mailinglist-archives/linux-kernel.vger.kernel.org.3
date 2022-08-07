Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCB258B8F0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 03:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbiHGBiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 21:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiHGBiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 21:38:18 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0376CE20
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 18:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659836297; x=1691372297;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YySptm9eHwLOULKxhkT5qY8blC2abY0x9RnAb49Vm64=;
  b=HFxKdcczwInDHqUuyTFTOKszrTE2wfyBMkMxdDjUBUXZupbV9CTYRUQT
   aFVQlC+2t39WRKJzOzUkMt7+ovI43xZLgvF4H5757LhdKZ3/4gJKium3n
   JpbIV3DQi/vy7c3es3v+vdbfy7FHVmQYp3g8enLcIq42PMWTB9TjJp/US
   Ho7Zu7g3lXC8qsL9nGRxzjLDflLsHub+YrVJ5MlXDM2XzefuZOyLgjmD3
   FXkSSsdKX+WEgTbTlmhT2MKW5YYxhqYIKihxHd1b93OnafZguiD5vCWKx
   sFesrSfamlVuqZWFH2DPsFvf/nBONu1C8L29w4j1lOPFzOXonCnB9z6gg
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="270788371"
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="270788371"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 18:38:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="931636923"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 06 Aug 2022 18:38:15 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKVF9-000KqP-0n;
        Sun, 07 Aug 2022 01:38:15 +0000
Date:   Sun, 7 Aug 2022 09:37:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [ammarfaizi2-block:tglx/devel/depthtracking 57/59] <inline
 asm>:24:23: error: expected register here
Message-ID: <202208070914.tWhVc55X-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block tglx/devel/depthtracking
head:   b518e558c49324fa002255761d2a7324ba31f7b5
commit: cb5c190267562764025e25c3e726ae511003b0a0 [57/59] x86/ftrace: Make it call depth tracking aware
config: x86_64-randconfig-a002-20220801 (https://download.01.org/0day-ci/archive/20220807/202208070914.tWhVc55X-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 52cd00cabf479aa7eb6dbb063b7ba41ea57bce9e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/cb5c190267562764025e25c3e726ae511003b0a0
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block tglx/devel/depthtracking
        git checkout cb5c190267562764025e25c3e726ae511003b0a0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> <inline asm>:24:23: error: expected register here
           sarq $5, PER_CPU_VAR(pcpu_hot + 16);
                                ^
   1 error generated.
--
>> <inline asm>:24:23: error: expected register here
           sarq $5, PER_CPU_VAR(pcpu_hot + 16);
                                ^
   <inline asm>:56:23: error: expected register here
           sarq $5, PER_CPU_VAR(pcpu_hot + 16);
                                ^
   2 errors generated.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
