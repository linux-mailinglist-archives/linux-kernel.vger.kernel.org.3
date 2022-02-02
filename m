Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1BD64A75B3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 17:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345821AbiBBQYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 11:24:31 -0500
Received: from mga12.intel.com ([192.55.52.136]:9064 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236409AbiBBQYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 11:24:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643819070; x=1675355070;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=crIMANMLKBvQD5aO8/SbvlEbfgJkAqaDfeDT9EokKZE=;
  b=P1DcY38jzVOvNCGuNJK6At4mFbxvK3q/sOtJ8Wmm6lUaTKsbQGx7Aa85
   lq+OQDE8eTHxoPgH8CJPKmb1qv46/O1I6oEZgYcSB1ERL9QmyDKPVtiL8
   9VRZ10d6xGodqYczHKlSKsc4cMoVVOKWsLX6Z3L3WjlYyT40cItxDk16b
   ovcRFoOAj0jZE5lVL4EvMUqbm8FcLuNj927fNhlP6Ko6vlk/gap0OhLKK
   taFDYaXZyYU3GIwV46lGjYauTFD37pqMsZICHLEyfDFAz4RhZy2ouvf6N
   /6J1oXRz3z86cYVEGgw7Bd+IkjtWKWgjo9XLmE0wJ+KiR2JaFFbVW+ix9
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="227923534"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="227923534"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 08:24:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="771489431"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 02 Feb 2022 08:24:08 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFIQR-000Uom-R8; Wed, 02 Feb 2022 16:24:07 +0000
Date:   Thu, 3 Feb 2022 00:23:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jorgen Hansen <jhansen@vmware.com>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     kbuild-all@lists.01.org, gregkh@linuxfoundation.org,
        pv-drivers@vmware.com, Jorgen Hansen <jhansen@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>
Subject: Re: [PATCH 2/8] VMCI: dma dg: add MMIO access to registers
Message-ID: <202202030055.O6CyDujA-lkp@intel.com>
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
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220203/202202030055.O6CyDujA-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/f2afd39bab80c2e42ac789f6d949d779411df928
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jorgen-Hansen/VMCI-dma-dg-Add-support-for-DMA-datagrams/20220202-230034
        git checkout f2afd39bab80c2e42ac789f6d949d779411df928
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/misc/vmw_vmci/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/misc/vmw_vmci/vmci_guest.c:93:14: warning: no previous prototype for 'vmci_read_reg' [-Wmissing-prototypes]
      93 | unsigned int vmci_read_reg(struct vmci_guest_device *dev, u32 reg)
         |              ^~~~~~~~~~~~~
>> drivers/misc/vmw_vmci/vmci_guest.c:100:6: warning: no previous prototype for 'vmci_write_reg' [-Wmissing-prototypes]
     100 | void vmci_write_reg(struct vmci_guest_device *dev, u32 val, u32 reg)
         |      ^~~~~~~~~~~~~~


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
