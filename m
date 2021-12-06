Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B5B46AC3E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 23:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357674AbhLFWkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 17:40:53 -0500
Received: from mga06.intel.com ([134.134.136.31]:58260 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350722AbhLFWkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 17:40:52 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="298221041"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="298221041"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 14:37:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="502313044"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 06 Dec 2021 14:37:21 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muMbo-000LoP-S5; Mon, 06 Dec 2021 22:37:20 +0000
Date:   Tue, 7 Dec 2021 06:36:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [intel-tdx:guest-upstream 5/35]
 drivers/acpi/acpica/hwesleep.c:108:39: warning: suggest braces around empty
 body in an 'if' statement
Message-ID: <202112070600.DOFbuLwf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-upstream
head:   16638db8a1f6e07592cdf4c9509ace54aa76dd82
commit: 3c56234d196f87e3c206b54958a834e997554017 [5/35] ACPICA: Do not flush cache for on entering S4 and S5
config: ia64-allyesconfig (https://download.01.org/0day-ci/archive/20211207/202112070600.DOFbuLwf-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/3c56234d196f87e3c206b54958a834e997554017
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-upstream
        git checkout 3c56234d196f87e3c206b54958a834e997554017
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/acpi/acpica/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/acpi/acpica/hwesleep.c: In function 'acpi_hw_extended_sleep':
>> drivers/acpi/acpica/hwesleep.c:108:39: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     108 |                 ACPI_FLUSH_CPU_CACHE();
         |                                       ^


vim +/if +108 drivers/acpi/acpica/hwesleep.c

709585765734e9 Bob Moore          2012-02-14   53  
709585765734e9 Bob Moore          2012-02-14   54  /*******************************************************************************
709585765734e9 Bob Moore          2012-02-14   55   *
709585765734e9 Bob Moore          2012-02-14   56   * FUNCTION:    acpi_hw_extended_sleep
709585765734e9 Bob Moore          2012-02-14   57   *
709585765734e9 Bob Moore          2012-02-14   58   * PARAMETERS:  sleep_state         - Which sleep state to enter
709585765734e9 Bob Moore          2012-02-14   59   *
709585765734e9 Bob Moore          2012-02-14   60   * RETURN:      Status
709585765734e9 Bob Moore          2012-02-14   61   *
709585765734e9 Bob Moore          2012-02-14   62   * DESCRIPTION: Enter a system sleep state via the extended FADT sleep
709585765734e9 Bob Moore          2012-02-14   63   *              registers (V5 FADT).
709585765734e9 Bob Moore          2012-02-14   64   *              THIS FUNCTION MUST BE CALLED WITH INTERRUPTS DISABLED
709585765734e9 Bob Moore          2012-02-14   65   *
709585765734e9 Bob Moore          2012-02-14   66   ******************************************************************************/
709585765734e9 Bob Moore          2012-02-14   67  
3f6f49c7854c92 Len Brown          2012-07-26   68  acpi_status acpi_hw_extended_sleep(u8 sleep_state)
709585765734e9 Bob Moore          2012-02-14   69  {
709585765734e9 Bob Moore          2012-02-14   70  	acpi_status status;
0fc5e8f4e4b33d Lv Zheng           2016-12-28   71  	u8 sleep_control;
709585765734e9 Bob Moore          2012-02-14   72  	u64 sleep_status;
709585765734e9 Bob Moore          2012-02-14   73  
709585765734e9 Bob Moore          2012-02-14   74  	ACPI_FUNCTION_TRACE(hw_extended_sleep);
709585765734e9 Bob Moore          2012-02-14   75  
709585765734e9 Bob Moore          2012-02-14   76  	/* Extended sleep registers must be valid */
709585765734e9 Bob Moore          2012-02-14   77  
709585765734e9 Bob Moore          2012-02-14   78  	if (!acpi_gbl_FADT.sleep_control.address ||
709585765734e9 Bob Moore          2012-02-14   79  	    !acpi_gbl_FADT.sleep_status.address) {
709585765734e9 Bob Moore          2012-02-14   80  		return_ACPI_STATUS(AE_NOT_EXIST);
709585765734e9 Bob Moore          2012-02-14   81  	}
709585765734e9 Bob Moore          2012-02-14   82  
709585765734e9 Bob Moore          2012-02-14   83  	/* Clear wake status (WAK_STS) */
709585765734e9 Bob Moore          2012-02-14   84  
1fad87385e7e82 Bob Moore          2015-12-29   85  	status = acpi_write((u64)ACPI_X_WAKE_STATUS,
1fad87385e7e82 Bob Moore          2015-12-29   86  			    &acpi_gbl_FADT.sleep_status);
709585765734e9 Bob Moore          2012-02-14   87  	if (ACPI_FAILURE(status)) {
709585765734e9 Bob Moore          2012-02-14   88  		return_ACPI_STATUS(status);
709585765734e9 Bob Moore          2012-02-14   89  	}
709585765734e9 Bob Moore          2012-02-14   90  
709585765734e9 Bob Moore          2012-02-14   91  	acpi_gbl_system_awake_and_running = FALSE;
709585765734e9 Bob Moore          2012-02-14   92  
709585765734e9 Bob Moore          2012-02-14   93  	/*
709585765734e9 Bob Moore          2012-02-14   94  	 * Set the SLP_TYP and SLP_EN bits.
709585765734e9 Bob Moore          2012-02-14   95  	 *
709585765734e9 Bob Moore          2012-02-14   96  	 * Note: We only use the first value returned by the \_Sx method
709585765734e9 Bob Moore          2012-02-14   97  	 * (acpi_gbl_sleep_type_a) - As per ACPI specification.
709585765734e9 Bob Moore          2012-02-14   98  	 */
709585765734e9 Bob Moore          2012-02-14   99  	ACPI_DEBUG_PRINT((ACPI_DB_INIT,
709585765734e9 Bob Moore          2012-02-14  100  			  "Entering sleep state [S%u]\n", sleep_state));
709585765734e9 Bob Moore          2012-02-14  101  
0fc5e8f4e4b33d Lv Zheng           2016-12-28  102  	sleep_control = ((acpi_gbl_sleep_type_a << ACPI_X_SLEEP_TYPE_POSITION) &
0fc5e8f4e4b33d Lv Zheng           2016-12-28  103  			 ACPI_X_SLEEP_TYPE_MASK) | ACPI_X_SLEEP_ENABLE;
0fc5e8f4e4b33d Lv Zheng           2016-12-28  104  
0fc5e8f4e4b33d Lv Zheng           2016-12-28  105  	/* Flush caches, as per ACPI specification */
0fc5e8f4e4b33d Lv Zheng           2016-12-28  106  
3c56234d196f87 Kirill A. Shutemov 2021-12-06  107  	if (sleep_state < ACPI_STATE_S4)
0fc5e8f4e4b33d Lv Zheng           2016-12-28 @108  		ACPI_FLUSH_CPU_CACHE();
0fc5e8f4e4b33d Lv Zheng           2016-12-28  109  
0fc5e8f4e4b33d Lv Zheng           2016-12-28  110  	status = acpi_os_enter_sleep(sleep_state, sleep_control, 0);
0fc5e8f4e4b33d Lv Zheng           2016-12-28  111  	if (status == AE_CTRL_TERMINATE) {
0fc5e8f4e4b33d Lv Zheng           2016-12-28  112  		return_ACPI_STATUS(AE_OK);
0fc5e8f4e4b33d Lv Zheng           2016-12-28  113  	}
0fc5e8f4e4b33d Lv Zheng           2016-12-28  114  	if (ACPI_FAILURE(status)) {
0fc5e8f4e4b33d Lv Zheng           2016-12-28  115  		return_ACPI_STATUS(status);
0fc5e8f4e4b33d Lv Zheng           2016-12-28  116  	}
709585765734e9 Bob Moore          2012-02-14  117  
0fc5e8f4e4b33d Lv Zheng           2016-12-28  118  	status = acpi_write((u64)sleep_control, &acpi_gbl_FADT.sleep_control);
709585765734e9 Bob Moore          2012-02-14  119  	if (ACPI_FAILURE(status)) {
709585765734e9 Bob Moore          2012-02-14  120  		return_ACPI_STATUS(status);
709585765734e9 Bob Moore          2012-02-14  121  	}
709585765734e9 Bob Moore          2012-02-14  122  
709585765734e9 Bob Moore          2012-02-14  123  	/* Wait for transition back to Working State */
709585765734e9 Bob Moore          2012-02-14  124  
709585765734e9 Bob Moore          2012-02-14  125  	do {
709585765734e9 Bob Moore          2012-02-14  126  		status = acpi_read(&sleep_status, &acpi_gbl_FADT.sleep_status);
709585765734e9 Bob Moore          2012-02-14  127  		if (ACPI_FAILURE(status)) {
709585765734e9 Bob Moore          2012-02-14  128  			return_ACPI_STATUS(status);
709585765734e9 Bob Moore          2012-02-14  129  		}
709585765734e9 Bob Moore          2012-02-14  130  
709585765734e9 Bob Moore          2012-02-14  131  	} while (!(((u8)sleep_status) & ACPI_X_WAKE_STATUS));
709585765734e9 Bob Moore          2012-02-14  132  
709585765734e9 Bob Moore          2012-02-14  133  	return_ACPI_STATUS(AE_OK);
709585765734e9 Bob Moore          2012-02-14  134  }
709585765734e9 Bob Moore          2012-02-14  135  

:::::: The code at line 108 was first introduced by commit
:::::: 0fc5e8f4e4b33ddfa1d1d673fcd420d6e13eb076 ACPICA: Hardware: Add sleep register hooks

:::::: TO: Lv Zheng <lv.zheng@intel.com>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
