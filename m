Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4D34612C6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 11:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbhK2KsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 05:48:25 -0500
Received: from mga02.intel.com ([134.134.136.20]:58585 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237014AbhK2KqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 05:46:24 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10182"; a="223169013"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="223169013"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 02:43:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="459099913"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 29 Nov 2021 02:43:04 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mre7j-000BpL-9G; Mon, 29 Nov 2021 10:43:03 +0000
Date:   Mon, 29 Nov 2021 18:42:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [tglx-devel:msi 84/100] kernel/irq/msi.c:782:16: error: 'struct
 msi_device_data' has no member named 'num_descs'
Message-ID: <202111291855.ARueBRqf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git msi
head:   76af424949030bcbbe874fc272e3cd7e388a6c7f
commit: 17095e2e663ae46ffdfe22111d6cca139d4da515 [84/100] platform-msi: Simplify platform device MSI code
config: x86_64-rhel-8.3-func (https://download.01.org/0day-ci/archive/20211129/202111291855.ARueBRqf-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git/commit/?id=17095e2e663ae46ffdfe22111d6cca139d4da515
        git remote add tglx-devel https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git
        git fetch --no-tags tglx-devel msi
        git checkout 17095e2e663ae46ffdfe22111d6cca139d4da515
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the tglx-devel/msi HEAD 76af424949030bcbbe874fc272e3cd7e388a6c7f builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   kernel/irq/msi.c: In function 'msi_domain_populate_irqs':
>> kernel/irq/msi.c:782:16: error: 'struct msi_device_data' has no member named 'num_descs'
     782 |   dev->msi.data->num_descs++;
         |                ^~


vim +782 kernel/irq/msi.c

   762	
   763	int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,
   764				     int virq_base, int nvec, msi_alloc_info_t *arg)
   765	{
   766		struct msi_domain_info *info = domain->host_data;
   767		struct msi_domain_ops *ops = info->ops;
   768		struct msi_desc *desc;
   769		int ret, virq;
   770	
   771		msi_lock_descs(dev);
   772		for (virq = virq_base; virq < virq_base + nvec; virq++) {
   773			desc = alloc_msi_entry(dev, 1, NULL);
   774			if (!desc) {
   775				ret = -ENOMEM;
   776				goto fail;
   777			}
   778	
   779			desc->msi_index = virq;
   780			desc->irq = virq;
   781			list_add_tail(&desc->list, &dev->msi.data->list);
 > 782			dev->msi.data->num_descs++;
   783	
   784			ops->set_desc(arg, desc);
   785			ret = irq_domain_alloc_irqs_hierarchy(domain, virq, 1, arg);
   786			if (ret)
   787				goto fail;
   788	
   789			irq_set_msi_desc(virq, desc);
   790		}
   791		msi_unlock_descs(dev);
   792		return 0;
   793	
   794	fail:
   795		for (--virq; virq >= virq_base; virq--)
   796			irq_domain_free_irqs_common(domain, virq, 1);
   797		msi_free_msi_descs_range(dev, MSI_DESC_ALL, virq_base, nvec);
   798		msi_unlock_descs(dev);
   799		return ret;
   800	}
   801	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
