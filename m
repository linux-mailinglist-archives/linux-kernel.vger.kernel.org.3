Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86034A7B00
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 23:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347843AbiBBWTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 17:19:33 -0500
Received: from mga17.intel.com ([192.55.52.151]:60535 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235181AbiBBWTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 17:19:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643840372; x=1675376372;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XfujBTN+u0aYzQcxfjJSTOYOLdePPqbT+2Jtxu0iXqY=;
  b=HPYS/4ROfjY5mnd6j+my9N55PiWyWRWluLes2dmCwuKAk3LMFt7DmUrv
   oTbD8ckHdciR1BInQoNPrTQp2blLkNbValr7LdUJvUlNaLvsMcpERG4d2
   aPIZhyv5MzaBFwU3r5tEg0VvkURqnSS3n3MHjVRdwiOksptNfjDVLLGjv
   5d4EvJ5Go/hujz+dAvDg8+HjWRNDK3FvDc0Ff6kw8rs24TYIBDwSN6Lnf
   QlAy5p1wPQ/tLVd8KrVvBOmF0NrqZovSCDupE8x1BAHYp5EOu4gQBHitq
   HpRFnsmZQnKe6krBfSWKP74dCaV9AO7APIbnZRfGKDvIBpHxwFExSvSXn
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="228685497"
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="228685497"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 14:19:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="483018110"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 02 Feb 2022 14:19:29 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFNyK-000VCn-QL; Wed, 02 Feb 2022 22:19:28 +0000
Date:   Thu, 3 Feb 2022 06:19:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jorgen Hansen <jhansen@vmware.com>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        gregkh@linuxfoundation.org, pv-drivers@vmware.com,
        Jorgen Hansen <jhansen@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>
Subject: Re: [PATCH 2/8] VMCI: dma dg: add MMIO access to registers
Message-ID: <202202030643.4ehOD5SG-lkp@intel.com>
References: <20220202144910.10349-3-jhansen@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202144910.10349-3-jhansen@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jorgen,

I love your patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on linux/master linus/master v5.17-rc2 next-20220202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jorgen-Hansen/VMCI-dma-dg-Add-support-for-DMA-datagrams/20220202-230034
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 7ab004dbcbee38b8a70798835d3ffcd97a985a5e
config: i386-randconfig-a013-20220131 (https://download.01.org/0day-ci/archive/20220203/202202030643.4ehOD5SG-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 6b1e844b69f15bb7dffaf9365cd2b355d2eb7579)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/f2afd39bab80c2e42ac789f6d949d779411df928
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jorgen-Hansen/VMCI-dma-dg-Add-support-for-DMA-datagrams/20220202-230034
        git checkout f2afd39bab80c2e42ac789f6d949d779411df928
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/misc/vmw_vmci/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/misc/vmw_vmci/vmci_guest.c:93:14: warning: no previous prototype for function 'vmci_read_reg' [-Wmissing-prototypes]
   unsigned int vmci_read_reg(struct vmci_guest_device *dev, u32 reg)
                ^
   drivers/misc/vmw_vmci/vmci_guest.c:93:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   unsigned int vmci_read_reg(struct vmci_guest_device *dev, u32 reg)
   ^
   static 
>> drivers/misc/vmw_vmci/vmci_guest.c:100:6: warning: no previous prototype for function 'vmci_write_reg' [-Wmissing-prototypes]
   void vmci_write_reg(struct vmci_guest_device *dev, u32 val, u32 reg)
        ^
   drivers/misc/vmw_vmci/vmci_guest.c:100:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void vmci_write_reg(struct vmci_guest_device *dev, u32 val, u32 reg)
   ^
   static 
   2 warnings generated.


vim +/vmci_read_reg +93 drivers/misc/vmw_vmci/vmci_guest.c

    92	
  > 93	unsigned int vmci_read_reg(struct vmci_guest_device *dev, u32 reg)
    94	{
    95		if (dev->mmio_base != NULL)
    96			return readl(dev->mmio_base + reg);
    97		return ioread32(dev->iobase + reg);
    98	}
    99	
 > 100	void vmci_write_reg(struct vmci_guest_device *dev, u32 val, u32 reg)
   101	{
   102		if (dev->mmio_base != NULL)
   103			writel(val, dev->mmio_base + reg);
   104		else
   105			iowrite32(val, dev->iobase + reg);
   106	}
   107	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
