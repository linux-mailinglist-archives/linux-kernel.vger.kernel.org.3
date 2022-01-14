Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7056A48E4C8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 08:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239467AbiANHQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 02:16:35 -0500
Received: from mga02.intel.com ([134.134.136.20]:35261 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230454AbiANHQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 02:16:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642144592; x=1673680592;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gIwPE/4QVephQw/l1ovxSoeOjbE7W+DsxdOrYO1sESc=;
  b=UR08ar7mgGIlj2htToH3we1bnWF5h2rYnPcMNBYIzROdIwow1BgCHcQl
   RoOoRmxUoq2WPbPtYH/d5AMy3hoEWlWMnDZVWTIrKfT5Ah3pq9uLVmuGS
   I+d6fGBneeFtzBVPotiwFozunaZcTfyKNhrGOm8IiUHbt5YvgNUfao1sE
   nfws7S0bkoj+kTyLeBPscUfz9NrLeVDtWN3Y1shUCmtAFCl66Z4+T3OAn
   7uSj8nxV4DeWHtYtKyUjiI4TNg3FlYg5G8cJNfHpeloZbBkrD/XCSr3Nx
   hYzz6wqMc2WNBUwqopbFlAyQJmrpBnXdaaqAoTZe3gI45kNd3tHBnck74
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="231546490"
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="231546490"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 23:16:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="692103243"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 13 Jan 2022 23:16:29 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8Gp3-0008Em-1K; Fri, 14 Jan 2022 07:16:29 +0000
Date:   Fri, 14 Jan 2022 15:15:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rafael@kernel.org, lenb@kernel.org
Cc:     kbuild-all@lists.01.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] ACPI / fan: Properly handle fine grain control
Message-ID: <202201141519.esDIoL2I-lkp@intel.com>
References: <20220113224713.90092-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113224713.90092-1-srinivas.pandruvada@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

I love your patch! Yet something to improve:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on linux/master linus/master v5.16 next-20220114]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Srinivas-Pandruvada/ACPI-fan-Properly-handle-fine-grain-control/20220114-064818
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20220114/202201141519.esDIoL2I-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/f30ef71d0435cd8735ee418eeb0bfc71a58a4554
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Srinivas-Pandruvada/ACPI-fan-Properly-handle-fine-grain-control/20220114-064818
        git checkout f30ef71d0435cd8735ee418eeb0bfc71a58a4554
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: drivers/acpi/fan.o: in function `fan_get_max_state':
>> drivers/acpi/fan.c:100: undefined reference to `__udivdi3'
   ld: drivers/acpi/fan.o: in function `fan_set_state_acpi4':
   drivers/acpi/fan.c:222: undefined reference to `__udivdi3'
   ld: drivers/acpi/fan.o: in function `fan_get_state_acpi4':
   drivers/acpi/fan.c:160: undefined reference to `__udivdi3'


vim +100 drivers/acpi/fan.c

    91	
    92	/* thermal cooling device callbacks */
    93	static int fan_get_max_state(struct thermal_cooling_device *cdev, unsigned long
    94				     *state)
    95	{
    96		struct acpi_device *device = cdev->devdata;
    97		struct acpi_fan *fan = acpi_driver_data(device);
    98	
    99		if (fan->fif.fine_grain_ctrl)
 > 100			*state = 100 / fan->fif.step_size;
   101		else if (fan->acpi4)
   102			*state = fan->fps_count - 1;
   103		else
   104			*state = 1;
   105	
   106		return 0;
   107	}
   108	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
