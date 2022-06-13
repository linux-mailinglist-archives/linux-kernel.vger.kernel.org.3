Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E1254834C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 11:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238848AbiFMJcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbiFMJcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:32:02 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECCB18B0A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 02:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655112720; x=1686648720;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hr64nq78b3DhYXBFaO31QJuhfJABxC8jmGW5U+Ds5e4=;
  b=NmNph2kGoj0BA5V19OQ3asbpC61oohiX1z1zfY2efmgQgKfQKHiQuv/a
   N4QmGAzd6A66WPjMMZcAf9OduCaEoq8Tx6dV+RAnEDFred031fAhGFOvG
   13FK4vPYB4Z/5Mn2iUl2FYoBdvRBbZjOPXrLvLoY0OiuAu50iWsV1mGDv
   aHa+REDB+Tfv81jV0QILhSzbIGFFo1ndKsConal3d0rll7iHIPif6cQct
   vPXaISY6DqTvd8Zw1883jF1Wg4fCM6YjGH7yzDhZzRAH1ZUSlEJLzrL6N
   Uc7RvcMRbf2+OoDUpZCKBafuVrujNurCohoQ2IU9rdXNaG61UOtFkb+Eo
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10376"; a="277004017"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="277004017"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 02:32:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="535030145"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 13 Jun 2022 02:31:58 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0gQP-000KgF-OC;
        Mon, 13 Jun 2022 09:31:57 +0000
Date:   Mon, 13 Jun 2022 17:31:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     kbuild-all@lists.01.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/2] mm/mmap: Drop generic protection_map[] array
Message-ID: <202206131716.tDWk9rLs-lkp@intel.com>
References: <20220613053354.553579-3-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613053354.553579-3-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Anshuman-Khandual/mm-mmap-Drop-__SXXX-__PXXX-macros-from-across-platforms/20220613-133456
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
config: riscv-randconfig-r042-20220613 (https://download.01.org/0day-ci/archive/20220613/202206131716.tDWk9rLs-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/696f81b49f7b6316f652d795da4c0008efef4487
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Anshuman-Khandual/mm-mmap-Drop-__SXXX-__PXXX-macros-from-across-platforms/20220613-133456
        git checkout 696f81b49f7b6316f652d795da4c0008efef4487
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/mm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/riscv/mm/init.c:1224:59: error: 'PAGE_NONE' undeclared here (not in a function); did you mean 'SIGEV_NONE'?
    1224 |         [VM_NONE]                                       = PAGE_NONE,
         |                                                           ^~~~~~~~~
         |                                                           SIGEV_NONE
>> arch/riscv/mm/init.c:1225:59: error: 'PAGE_READ' undeclared here (not in a function); did you mean 'MAY_READ'?
    1225 |         [VM_READ]                                       = PAGE_READ,
         |                                                           ^~~~~~~~~
         |                                                           MAY_READ
>> arch/riscv/mm/init.c:1226:59: error: 'PAGE_COPY' undeclared here (not in a function)
    1226 |         [VM_WRITE]                                      = PAGE_COPY,
         |                                                           ^~~~~~~~~
>> arch/riscv/mm/init.c:1228:59: error: 'PAGE_EXEC' undeclared here (not in a function); did you mean 'TASK_EXEC'?
    1228 |         [VM_EXEC]                                       = PAGE_EXEC,
         |                                                           ^~~~~~~~~
         |                                                           TASK_EXEC
>> arch/riscv/mm/init.c:1229:59: error: 'PAGE_READ_EXEC' undeclared here (not in a function); did you mean 'PAGE_KERNEL_EXEC'?
    1229 |         [VM_EXEC | VM_READ]                             = PAGE_READ_EXEC,
         |                                                           ^~~~~~~~~~~~~~
         |                                                           PAGE_KERNEL_EXEC
>> arch/riscv/mm/init.c:1230:59: error: 'PAGE_COPY_EXEC' undeclared here (not in a function); did you mean 'PAGE_KERNEL_EXEC'?
    1230 |         [VM_EXEC | VM_WRITE]                            = PAGE_COPY_EXEC,
         |                                                           ^~~~~~~~~~~~~~
         |                                                           PAGE_KERNEL_EXEC
>> arch/riscv/mm/init.c:1231:59: error: 'PAGE_COPY_READ_EXEC' undeclared here (not in a function)
    1231 |         [VM_EXEC | VM_WRITE | VM_READ]                  = PAGE_COPY_READ_EXEC,
         |                                                           ^~~~~~~~~~~~~~~~~~~
>> arch/riscv/mm/init.c:1238:59: error: 'PAGE_SHARED_EXEC' undeclared here (not in a function); did you mean 'PAGE_SHARED'?
    1238 |         [VM_SHARED | VM_EXEC | VM_WRITE]                = PAGE_SHARED_EXEC,
         |                                                           ^~~~~~~~~~~~~~~~
         |                                                           PAGE_SHARED


vim +1224 arch/riscv/mm/init.c

  1222	
  1223	pgprot_t protection_map[16] __ro_after_init = {
> 1224		[VM_NONE]					= PAGE_NONE,
> 1225		[VM_READ]					= PAGE_READ,
> 1226		[VM_WRITE]					= PAGE_COPY,
  1227		[VM_WRITE | VM_READ]				= PAGE_COPY,
> 1228		[VM_EXEC]					= PAGE_EXEC,
> 1229		[VM_EXEC | VM_READ]				= PAGE_READ_EXEC,
> 1230		[VM_EXEC | VM_WRITE]				= PAGE_COPY_EXEC,
> 1231		[VM_EXEC | VM_WRITE | VM_READ]			= PAGE_COPY_READ_EXEC,
  1232		[VM_SHARED]					= PAGE_NONE,
  1233		[VM_SHARED | VM_READ]				= PAGE_READ,
  1234		[VM_SHARED | VM_WRITE]				= PAGE_SHARED,
  1235		[VM_SHARED | VM_WRITE | VM_READ]		= PAGE_SHARED,
  1236		[VM_SHARED | VM_EXEC]				= PAGE_EXEC,
  1237		[VM_SHARED | VM_EXEC | VM_READ]			= PAGE_READ_EXEC,
> 1238		[VM_SHARED | VM_EXEC | VM_WRITE]		= PAGE_SHARED_EXEC,

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
