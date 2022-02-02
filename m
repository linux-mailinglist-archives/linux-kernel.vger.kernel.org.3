Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9843A4A7A1C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 22:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239968AbiBBVSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 16:18:31 -0500
Received: from mga02.intel.com ([134.134.136.20]:60397 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232071AbiBBVS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 16:18:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643836709; x=1675372709;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pKbwTf351WMGvUo20IwzPN+wwoLePreHupAdfPbGkZg=;
  b=Mnid2m3zeoEGpqZW45YRe+fZcplPdn+32XrFmoUxLB3E506ED9KlOEry
   h5Ak705jv1oKzkriZ479OkKWk88Re73O5ua1pdxIEbgg6gk1b413pR3J4
   kZBUTDt9NfFigeyR6enKXxMNE4sPlYgUW2Kn2wazSEVlXeZjhtSHUrHw7
   SC/wvmcyyjEL8B2l5V4ihncz3bdo5GvozbcBFPst3YVs8gy5Z3ItAvThK
   4iNUKb1Yf84tOyZS22hnLTdtWWnsS/xLk016wDXwTXoQ0c4aH2nj33ImF
   qzTQaxhXb5dnRoPJnnWW4kIfMvOxyw2D3dZfnhilHiyyV//3zj8VSn5Ys
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="235421865"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="235421865"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 13:18:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="699059022"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 02 Feb 2022 13:18:27 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFN1H-000V8n-0Q; Wed, 02 Feb 2022 21:18:27 +0000
Date:   Thu, 3 Feb 2022 05:18:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jorgen Hansen <jhansen@vmware.com>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     kbuild-all@lists.01.org, gregkh@linuxfoundation.org,
        pv-drivers@vmware.com, Jorgen Hansen <jhansen@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>
Subject: Re: [PATCH 2/8] VMCI: dma dg: add MMIO access to registers
Message-ID: <202202030509.ZJep87ms-lkp@intel.com>
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
config: i386-randconfig-s002 (https://download.01.org/0day-ci/archive/20220203/202202030509.ZJep87ms-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/f2afd39bab80c2e42ac789f6d949d779411df928
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jorgen-Hansen/VMCI-dma-dg-Add-support-for-DMA-datagrams/20220202-230034
        git checkout f2afd39bab80c2e42ac789f6d949d779411df928
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/misc/vmw_vmci/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/misc/vmw_vmci/vmci_guest.c:96:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got char * @@
   drivers/misc/vmw_vmci/vmci_guest.c:96:45: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/misc/vmw_vmci/vmci_guest.c:96:45: sparse:     got char *
>> drivers/misc/vmw_vmci/vmci_guest.c:93:14: sparse: sparse: symbol 'vmci_read_reg' was not declared. Should it be static?
>> drivers/misc/vmw_vmci/vmci_guest.c:103:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got char * @@
   drivers/misc/vmw_vmci/vmci_guest.c:103:44: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/misc/vmw_vmci/vmci_guest.c:103:44: sparse:     got char *
>> drivers/misc/vmw_vmci/vmci_guest.c:100:6: sparse: sparse: symbol 'vmci_write_reg' was not declared. Should it be static?
>> drivers/misc/vmw_vmci/vmci_guest.c:473:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char *mmio_base @@     got void [noderef] __iomem * @@
   drivers/misc/vmw_vmci/vmci_guest.c:473:27: sparse:     expected char *mmio_base
   drivers/misc/vmw_vmci/vmci_guest.c:473:27: sparse:     got void [noderef] __iomem *

Please review and possibly fold the followup patch.

vim +96 drivers/misc/vmw_vmci/vmci_guest.c

    92	
  > 93	unsigned int vmci_read_reg(struct vmci_guest_device *dev, u32 reg)
    94	{
    95		if (dev->mmio_base != NULL)
  > 96			return readl(dev->mmio_base + reg);
    97		return ioread32(dev->iobase + reg);
    98	}
    99	
 > 100	void vmci_write_reg(struct vmci_guest_device *dev, u32 val, u32 reg)
   101	{
   102		if (dev->mmio_base != NULL)
 > 103			writel(val, dev->mmio_base + reg);
   104		else
   105			iowrite32(val, dev->iobase + reg);
   106	}
   107	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
