Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79C74ED737
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 11:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbiCaJrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 05:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234270AbiCaJrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 05:47:47 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264843E5F2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 02:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648719960; x=1680255960;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nzqSovEaB1+9yVRKn8HXLbqr/ZdlhWVFtpWNH7LPBF4=;
  b=e8RKvLaeQO7/VmpTDNyUZxB64Z6kYda4hqogxKSAysAjI/bIxMTtvYAW
   orZnefymLeeuCxS09cFehpsVNQGXlYxxYRnI8o3bZEmLPJsOtHWOB4vB2
   yatvaPtIVL20i+Dtktzg9YVtKmVM9881QK7DLxIG83lglGI3g5vKOneLI
   daS1TSNKD5GtZw/4al+HmCiCBqNoL7DBWoufPcaEc3m2SBzxAnSCRIBJ6
   PNQRgJBmJAaGisfSdl8EiHvPOEU+GfZi5QSqhCgwRFXQpfB2kCREl07JN
   Hyhp5Ht06xOCE24ZszTg3Q6el5s/riKlUaEnByf3UMBRYRRwutJBX0Svi
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="259760270"
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="259760270"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 02:45:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="503675581"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 31 Mar 2022 02:45:56 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZrNL-00008e-He;
        Thu, 31 Mar 2022 09:45:55 +0000
Date:   Thu, 31 Mar 2022 17:45:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alistair Francis <alistair.francis@opensource.wdc.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     kbuild-all@lists.01.org, atishp@rivosinc.com, anup@brainfault.org,
        guoren@kernel.org, alistair23@gmail.com,
        linux-kernel@vger.kernel.org,
        Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v3] riscv: Ensure only ASIDLEN is used for sfence.vma
Message-ID: <202203311731.xi8xw0gy-lkp@intel.com>
References: <20220331055906.3552337-1-alistair.francis@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331055906.3552337-1-alistair.francis@opensource.wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
config: riscv-nommu_k210_defconfig (https://download.01.org/0day-ci/archive/20220331/202203311731.xi8xw0gy-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/162147030f410152d028af446a7383e3c9410f55
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Alistair-Francis/riscv-Ensure-only-ASIDLEN-is-used-for-sfence-vma/20220331-140116
        git checkout 162147030f410152d028af446a7383e3c9410f55
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/riscv/mm/context.c: In function 'get_mm_asid':
>> arch/riscv/mm/context.c:307:45: error: 'mm_context_t' has no member named 'id'
     307 |         return atomic_long_read(&mm->context.id) & asid_mask;
         |                                             ^
>> arch/riscv/mm/context.c:307:52: error: 'asid_mask' undeclared (first use in this function); did you mean 'pid_task'?
     307 |         return atomic_long_read(&mm->context.id) & asid_mask;
         |                                                    ^~~~~~~~~
         |                                                    pid_task
   arch/riscv/mm/context.c:307:52: note: each undeclared identifier is reported only once for each function it appears in
   arch/riscv/mm/context.c:308:1: error: control reaches end of non-void function [-Werror=return-type]
     308 | }
         | ^
   cc1: some warnings being treated as errors


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
