Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF0D4C2158
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 02:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiBXBwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 20:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiBXBwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 20:52:06 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86E19859D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 17:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645667497; x=1677203497;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hZWLPCYNGiVPzsLZkTZ96T3RnmwJ70/10VJhY6/sgh4=;
  b=NdeIj6GgCw+sha2BK6tUtfEJJRrR5cDjoSak6BbAj27cloPQpxaAn2R3
   vmBcTtc0IvoSEEHq4vJs3P7xloLlY2fCsWTdkLe/rDDHgTKInC895u8tq
   uI06w0zkUv9hhzAIzdkSsCn5hnFw4cMPsPoSwRMwy5+ApQxMMKNgCZ2yP
   SYLX+j28zOzMe4yxSz28UVBwvV4Py0hgvEnqHDH08hpf/pksDUnaHdnWn
   BADU7le5/0jx+dqrKw8D0dLXAFZ3rFRdpdxnwNVcaA2UP+yGtWsfEbnlS
   dDG3iGpdJ5EpU0tdPvqgA5Fsdc12mYIvH4cLcDmJ31agRJjreAATV3XfV
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="312838965"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="312838965"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 17:17:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="707264279"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 23 Feb 2022 17:17:55 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nN2lW-00023h-BR; Thu, 24 Feb 2022 01:17:54 +0000
Date:   Thu, 24 Feb 2022 09:17:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:axboe/linux-block/m1/2022-02-19 399/552]
 arch/arm/kernel/entry-armv.S:252: undefined reference to
 `generic_handle_arch_irq'
Message-ID: <202202240931.CLo0U5H1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

First bad commit (maybe != root cause):

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/m1/2022-02-19
head:   b781e0ccdc0c9a931571d15db09d45b7258b9905
commit: 479e353d1823d7efddab1262e4333417d88a3b32 [399/552] Merge branch 'akpm-current/current'
config: arm-randconfig-r021-20220223 (https://download.01.org/0day-ci/archive/20220224/202202240931.CLo0U5H1-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/479e353d1823d7efddab1262e4333417d88a3b32
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/m1/2022-02-19
        git checkout 479e353d1823d7efddab1262e4333417d88a3b32
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: arch/arm/kernel/entry-armv.o: in function `__irq_svc':
>> arch/arm/kernel/entry-armv.S:252: undefined reference to `generic_handle_arch_irq'
   arm-linux-gnueabi-ld: arch/arm/kernel/entry-armv.o: in function `__irq_usr':
   arch/arm/kernel/entry-armv.S:479: undefined reference to `generic_handle_arch_irq'


vim +252 arch/arm/kernel/entry-armv.S

^1da177e4c3f41 Linus Torvalds 2005-04-16  248  
^1da177e4c3f41 Linus Torvalds 2005-04-16  249  	.align	5
^1da177e4c3f41 Linus Torvalds 2005-04-16  250  __irq_svc:
ccea7a19e54349 Russell King   2005-05-31  251  	svc_entry
d4664b6c987f80 Ard Biesheuvel 2021-10-05 @252  	irq_handler from_user=0
1613cc1119ecdb Russell King   2011-06-25  253  

:::::: The code at line 252 was first introduced by commit
:::::: d4664b6c987f80338407889c1e3f3abe7e16be94 ARM: implement IRQ stacks

:::::: TO: Ard Biesheuvel <ardb@kernel.org>
:::::: CC: Ard Biesheuvel <ardb@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
