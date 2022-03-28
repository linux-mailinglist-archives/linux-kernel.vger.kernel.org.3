Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A75C4E8DCA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 08:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbiC1GKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 02:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbiC1GKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 02:10:14 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0F712A90;
        Sun, 27 Mar 2022 23:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648447714; x=1679983714;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WFbDWCNdUy2Ivv0kvBXfSNEZrOxB9nLU2zCZyPEr3nU=;
  b=Bx4yNQIvvGNerUl7sQdLq9yGZ30BtpluaYlfRfDOZPzilldeWDlM4/fs
   FeQIYyBJGh9c9PL26nJJZPJKbEiDhNYzWxwl4B1Orv/4mEVzPf5FGK8d6
   40js2JuAZCwaTatGI11pOgmJtsbfiXsMxx4r0qHO12TR52z3NzE6W2x8b
   lK+c6PFNfQH+4OWCpFsozs4Fh3lIaqVYpMJykPhOsaLqO9vVZjVA0O5TZ
   Whkh6R6KXj36PfDJkr7R/JScTgwPP/je0YQNwA8pl+bqPyGsNuYOx9nOv
   w6Dzb92T1AosgJ4XlwjjGX/4QyOPzVDXsNMXJ0WqHdQ8UXc4KcpoKCM7R
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10299"; a="256495907"
X-IronPort-AV: E=Sophos;i="5.90,216,1643702400"; 
   d="scan'208";a="256495907"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2022 23:08:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,216,1643702400"; 
   d="scan'208";a="718978739"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 27 Mar 2022 23:08:30 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYiYI-0001lW-4P; Mon, 28 Mar 2022 06:08:30 +0000
Date:   Mon, 28 Mar 2022 14:08:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Haowen Bai <baihaowen@meizu.com>, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com
Cc:     kbuild-all@lists.01.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Haowen Bai <baihaowen@meizu.com>
Subject: Re: [PATCH] s390: Simplify the calculation of variables
Message-ID: <202203281418.KxPHz4Ek-lkp@intel.com>
References: <1648434982-28862-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1648434982-28862-1-git-send-email-baihaowen@meizu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Haowen,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on s390/features]
[also build test ERROR on v5.17 next-20220325]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Haowen-Bai/s390-Simplify-the-calculation-of-variables/20220328-103807
base:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
config: s390-randconfig-r044-20220327 (https://download.01.org/0day-ci/archive/20220328/202203281418.KxPHz4Ek-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7356660d5a4a5dc70f5e18b63125c43d218885f3
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Haowen-Bai/s390-Simplify-the-calculation-of-variables/20220328-103807
        git checkout 7356660d5a4a5dc70f5e18b63125c43d218885f3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash drivers/iio/accel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/s390/include/asm/cio.h:18,
                    from arch/s390/include/asm/chpid.h:10,
                    from arch/s390/include/asm/sclp.h:20,
                    from arch/s390/include/asm/pci.h:12,
                    from include/linux/pci.h:1901,
                    from arch/s390/include/asm/hw_irq.h:6,
                    from include/linux/irq.h:592,
                    from include/linux/iio/trigger.h:6,
                    from drivers/iio/accel/adxl355_core.c:14:
   arch/s390/include/asm/scsw.h: In function 'scsw_tm_is_valid_pno':
>> arch/s390/include/asm/scsw.h:695:54: error: expected ';' before '}' token
     695 |                (scsw->tm.actl & SCSW_ACTL_SUSPENDED))
         |                                                      ^
         |                                                      ;
     696 | }
         | ~                                                     
--
   In file included from arch/s390/include/asm/cio.h:18,
                    from arch/s390/include/asm/chpid.h:10,
                    from arch/s390/include/asm/sclp.h:20,
                    from arch/s390/include/asm/pci.h:12,
                    from include/linux/pci.h:1901,
                    from arch/s390/include/asm/hw_irq.h:6,
                    from include/linux/irq.h:592,
                    from include/linux/iio/trigger.h:6,
                    from drivers/iio/accel/kxcjk-1013.c:21:
   arch/s390/include/asm/scsw.h: In function 'scsw_tm_is_valid_pno':
>> arch/s390/include/asm/scsw.h:695:54: error: expected ';' before '}' token
     695 |                (scsw->tm.actl & SCSW_ACTL_SUSPENDED))
         |                                                      ^
         |                                                      ;
     696 | }
         | ~                                                     
   At top level:
   drivers/iio/accel/kxcjk-1013.c:1709:36: warning: 'kx_acpi_match' defined but not used [-Wunused-const-variable=]
    1709 | static const struct acpi_device_id kx_acpi_match[] = {
         |                                    ^~~~~~~~~~~~~
--
   In file included from arch/s390/include/asm/cio.h:18,
                    from arch/s390/include/asm/chpid.h:10,
                    from arch/s390/include/asm/sclp.h:20,
                    from arch/s390/include/asm/pci.h:12,
                    from include/linux/pci.h:1901,
                    from arch/s390/include/asm/hw_irq.h:6,
                    from include/linux/irq.h:592,
                    from include/linux/iio/trigger.h:6,
                    from drivers/iio/accel/mxc4005.c:14:
   arch/s390/include/asm/scsw.h: In function 'scsw_tm_is_valid_pno':
>> arch/s390/include/asm/scsw.h:695:54: error: expected ';' before '}' token
     695 |                (scsw->tm.actl & SCSW_ACTL_SUSPENDED))
         |                                                      ^
         |                                                      ;
     696 | }
         | ~                                                     
   At top level:
   drivers/iio/accel/mxc4005.c:473:36: warning: 'mxc4005_acpi_match' defined but not used [-Wunused-const-variable=]
     473 | static const struct acpi_device_id mxc4005_acpi_match[] = {
         |                                    ^~~~~~~~~~~~~~~~~~
--
   In file included from arch/s390/include/asm/cio.h:18,
                    from arch/s390/include/asm/chpid.h:10,
                    from arch/s390/include/asm/sclp.h:20,
                    from arch/s390/include/asm/pci.h:12,
                    from include/linux/pci.h:1901,
                    from arch/s390/include/asm/hw_irq.h:6,
                    from include/linux/irq.h:592,
                    from include/linux/iio/trigger.h:6,
                    from drivers/iio/accel/stk8ba50.c:18:
   arch/s390/include/asm/scsw.h: In function 'scsw_tm_is_valid_pno':
>> arch/s390/include/asm/scsw.h:695:54: error: expected ';' before '}' token
     695 |                (scsw->tm.actl & SCSW_ACTL_SUSPENDED))
         |                                                      ^
         |                                                      ;
     696 | }
         | ~                                                     
   At top level:
   drivers/iio/accel/stk8ba50.c:539:36: warning: 'stk8ba50_acpi_id' defined but not used [-Wunused-const-variable=]
     539 | static const struct acpi_device_id stk8ba50_acpi_id[] = {
         |                                    ^~~~~~~~~~~~~~~~


vim +695 arch/s390/include/asm/scsw.h

   682	
   683	/**
   684	 * scsw_tm_is_valid_pno - check pno field validity
   685	 * @scsw: pointer to scsw
   686	 *
   687	 * Return non-zero if the pno field of the specified transport mode scsw is
   688	 * valid, zero otherwise.
   689	 */
   690	static inline int scsw_tm_is_valid_pno(union scsw *scsw)
   691	{
   692		return (scsw->tm.fctl != 0) &&
   693		       (scsw->tm.stctl & SCSW_STCTL_STATUS_PEND) &&
   694		       (!(scsw->tm.stctl & SCSW_STCTL_INTER_STATUS) ||
 > 695		       (scsw->tm.actl & SCSW_ACTL_SUSPENDED))
   696	}
   697	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
