Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB7A4EDAEA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 15:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236438AbiCaNyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 09:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiCaNyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 09:54:23 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE1B216A6E
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 06:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648734756; x=1680270756;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Cea9BIXvxQfSFyXleL4Gt1pWuuhgt62Aif3PCu7C/tw=;
  b=C4wIXz+vbMjVff8IaIJabk8kvlDw8C8yRnPlj+FlIiUt9iJ9pfJOaQZO
   hGY3CboG86KQGHZ1KRlcZucBNmtYXlg/wxNYErLFVhZNM/shX5+Ea07f0
   ZMxKAxGmZrrhaY4r3K9NM9m94xEw8Q8BPiM02/5pRZ2ttXzb90CE1a5e5
   TBe9HBG3fxDaqzmMdQmvuXulSjxZkt4YPDfRuqyr84m9fnPiN9ZNs09wA
   Ber0qDBhmZhRkgeheAY918CC1glNpw/2FUmqydG+MgoUoydHm50WlWCS6
   lhLz4vj4b0+oELHd3qRKM5cT3QqPA6r91amgQtfPkO/QclEaniYT3ZX/l
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="239768066"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="239768066"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 06:52:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="720471387"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 31 Mar 2022 06:52:32 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZvDz-0000JM-Bt;
        Thu, 31 Mar 2022 13:52:31 +0000
Date:   Thu, 31 Mar 2022 21:51:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alistair Francis <alistair.francis@opensource.wdc.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, atishp@rivosinc.com,
        anup@brainfault.org, guoren@kernel.org, alistair23@gmail.com,
        linux-kernel@vger.kernel.org,
        Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v3] riscv: Ensure only ASIDLEN is used for sfence.vma
Message-ID: <202203312110.VamttjhO-lkp@intel.com>
References: <20220331055906.3552337-1-alistair.francis@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331055906.3552337-1-alistair.francis@opensource.wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alistair,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.17 next-20220331]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Alistair-Francis/riscv-Ensure-only-ASIDLEN-is-used-for-sfence-vma/20220331-140116
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 787af64d05cd528aac9ad16752d11bb1c6061bb9
config: riscv-randconfig-c006-20220331 (https://download.01.org/0day-ci/archive/20220331/202203312110.VamttjhO-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 881350a92d821d4f8e4fa648443ed1d17e251188)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/162147030f410152d028af446a7383e3c9410f55
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Alistair-Francis/riscv-Ensure-only-ASIDLEN-is-used-for-sfence-vma/20220331-140116
        git checkout 162147030f410152d028af446a7383e3c9410f55
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/riscv/mm/context.c:307:39: error: no member named 'id' in 'mm_context_t'
           return atomic_long_read(&mm->context.id) & asid_mask;
                                    ~~~~~~~~~~~ ^
>> arch/riscv/mm/context.c:307:45: error: use of undeclared identifier 'asid_mask'
           return atomic_long_read(&mm->context.id) & asid_mask;
                                                      ^
   2 errors generated.


vim +307 arch/riscv/mm/context.c

   304	
   305	unsigned long get_mm_asid(struct mm_struct *mm)
   306	{
 > 307		return atomic_long_read(&mm->context.id) & asid_mask;
   308	}
   309	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
