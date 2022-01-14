Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6DB48E1BA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 01:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238542AbiANArj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 19:47:39 -0500
Received: from mga05.intel.com ([192.55.52.43]:47124 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238527AbiANAri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 19:47:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642121258; x=1673657258;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mw7PgDCgWUoYN/WHMFi5MZBOGxgUw4OtOQW8D6uKzSA=;
  b=I8CO8PsPYOgI38VowDVILEpnKItEIgzPZkPDRD0IYUgXRFcpFT6UBHXf
   wsZRMGaZTYHCRMNvAyL43qj7jYkYoFMMvqgyRdEG6NyUcqJ8IGcniG7hA
   no7EowNBlXOzi52FJ+AwsAKQAmE6td0oIOft7tug3Zo6Zn6OL9hNSBDFn
   kb575YNhMwpnAeY+smXDOu1ibzc5KA1Z4R+l92fwFCO56gbzES1TPfTVS
   nFkBL6Q6YPUsYTuEBJ1+2cA2/4mq7Ql8s5aztCQkn1pEP/PrbAyBlBA47
   uZ/yyKgSbJ4wdKXT/k91sB6Uy6VQgwc97FVrpchE0HBgwWF6O8wRFEGRa
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="330499675"
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="330499675"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 16:47:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="491321439"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 13 Jan 2022 16:47:15 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8AkN-0007q1-8I; Fri, 14 Jan 2022 00:47:15 +0000
Date:   Fri, 14 Jan 2022 08:46:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [intel-tdx:tdx/guest-rebased 38/133]
 arch/x86/boot/compressed/misc.c:454:17: warning: cast from pointer to
 integer of different size
Message-ID: <202201140813.Ymp2JKvR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git tdx/guest-rebased
head:   e3995864d37c56f431c93fc3dc454d9c65f5e9ea
commit: 38bb454722407639d0570dd216f8cf65e7f93b84 [38/133] x86/boot/compressed: Handle unaccepted memory
config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20220114/202201140813.Ymp2JKvR-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/38bb454722407639d0570dd216f8cf65e7f93b84
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx tdx/guest-rebased
        git checkout 38bb454722407639d0570dd216f8cf65e7f93b84
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/x86/boot/compressed/misc.c: In function 'extract_kernel':
>> arch/x86/boot/compressed/misc.c:454:17: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     454 |   accept_memory((phys_addr_t)output,
         |                 ^
   arch/x86/boot/compressed/misc.c:455:10: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     455 |          (phys_addr_t)output + needed_size);
         |          ^


vim +454 arch/x86/boot/compressed/misc.c

   448	
   449		debug_putstr("\nDecompressing Linux... ");
   450	
   451		if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY) &&
   452		    boot_params->unaccepted_memory) {
   453			debug_putstr("Accepting memory... ");
 > 454			accept_memory((phys_addr_t)output,
   455				      (phys_addr_t)output + needed_size);
   456		}
   457	
   458		__decompress(input_data, input_len, NULL, NULL, output, output_len,
   459				NULL, error);
   460		parse_elf(output);
   461		handle_relocations(output, output_len, virt_addr);
   462		debug_putstr("done.\nBooting the kernel.\n");
   463	
   464		/* Disable exception handling before booting the kernel */
   465		cleanup_exception_handling();
   466	
   467		return output;
   468	}
   469	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
