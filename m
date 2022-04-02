Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA194EFF38
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 09:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238420AbiDBHDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 03:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiDBHDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 03:03:36 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EA91D915A;
        Sat,  2 Apr 2022 00:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648882905; x=1680418905;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fLmsgl0Q4YkX0EizUHeR74OfO/1Yuf1/KhQm7/xuNO8=;
  b=CRYLBkwTUK6pBUsKZ9LWvv5PKfV1f9WUDLzR+ZzwRMwm8fot5USS8Vt7
   BbfMLfVYV0yuhMA1y1L1nznyYhdHvDC8p/6MKPZ6Qf5+eBvLYsos/420N
   cg/H45cV4tbdp1R1LGnYsr0hGuFW7jDLb2iqhGIcjjbavircmt0H3YM/Z
   y6f6E89VYstMouMZ0RAyNDeY+lMyXI/NXXuyPUBjAW4rdx9TgMQgRf4cO
   5vP5nnQH8AF7ig6pcmvHGQT+t9Jx52MIn1mi3pFpYLPEezu5sNYmEz5BT
   OIDLyaZ4U59Af5+IpUKlf0NJX+rArdeVeFqNXkomQg0Ueqg0MmkP5z35r
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="260461114"
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="260461114"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2022 00:01:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="504407121"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 02 Apr 2022 00:01:41 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1naXlV-0001zP-4e;
        Sat, 02 Apr 2022 07:01:41 +0000
Date:   Sat, 2 Apr 2022 15:01:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     james.liu@hpe.com, rafael@kernel.org, lenb@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        rwright@hpe.com, david.chang@hpe.co, clayc@hpe.com,
        james.liu@hpe.com
Subject: Re: [PATCH]     ACPI: OSL: Fix the memory mapping of an ACPI GAS
 that addresses a data structure
Message-ID: <202204021406.lxRmdIm5-lkp@intel.com>
References: <20220401172840.1252-1-james.liu@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401172840.1252-1-james.liu@hpe.com>
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

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on v5.17 next-20220401]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/james-liu-hpe-com/ACPI-OSL-Fix-the-memory-mapping-of-an-ACPI-GAS-that-addresses-a-data-structure/20220402-013755
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20220402/202204021406.lxRmdIm5-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c4a1b07d0979e7ff20d7d541af666d822d66b566)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/594496ff7d62c6d42b3c8a436fca46cc289aea67
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review james-liu-hpe-com/ACPI-OSL-Fix-the-memory-mapping-of-an-ACPI-GAS-that-addresses-a-data-structure/20220402-013755
        git checkout 594496ff7d62c6d42b3c8a436fca46cc289aea67
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/acpi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/acpi/osl.c:463:29: warning: variable 'addr' is uninitialized when used here [-Wuninitialized]
                   return  acpi_os_map_iomem(addr, PAGE_SIZE);
                                             ^~~~
   drivers/acpi/osl.c:455:10: note: initialize the variable 'addr' to silence this warning
           u64 addr;
                   ^
                    = 0
   drivers/acpi/osl.c:487:25: warning: variable 'addr' is uninitialized when used here [-Wuninitialized]
                   map = acpi_map_lookup(addr, PAGE_SIZE);
                                         ^~~~
   drivers/acpi/osl.c:477:10: note: initialize the variable 'addr' to silence this warning
           u64 addr;
                   ^
                    = 0
   2 warnings generated.


vim +/addr +463 drivers/acpi/osl.c

   452	
   453	void __iomem *acpi_os_map_generic_address(struct acpi_generic_address *gas)
   454	{
   455		u64 addr;
   456	
   457		if (gas->space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY)
   458			return NULL;
   459	
   460		/* Handle a case that GAS is used to address an ACPI data structure */
   461		if (!gas->bit_width) {
   462			pr_info("An ACPI data structure at 0x%llx is mapped\n", addr);
 > 463			return  acpi_os_map_iomem(addr, PAGE_SIZE);
   464		}
   465	
   466		/* Handle possible alignment issues */
   467		memcpy(&addr, &gas->address, sizeof(addr));
   468		if (!addr)
   469			return NULL;
   470	
   471		return acpi_os_map_iomem(addr, gas->bit_width / 8);
   472	}
   473	EXPORT_SYMBOL(acpi_os_map_generic_address);
   474	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
