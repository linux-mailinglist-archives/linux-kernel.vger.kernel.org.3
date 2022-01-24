Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C544983B8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242396AbiAXPnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:43:04 -0500
Received: from mga07.intel.com ([134.134.136.100]:22288 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231203AbiAXPm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:42:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643038976; x=1674574976;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o7lH/4xup0K6KID7TsgwO6gKu75g/dBARvlYR98pp6s=;
  b=UKijXZJV2ye52eQyWejgDlCs3boqNsEn5hs9RA1wTenwI/yD1HDvtVVC
   7idgVRTUW+OrYuZFxItT5eSYJr4U/Jrhpl9R4gQWbseooLc5b0EpevvoV
   svUOhiWN3HzxMkHH4ZUsyG+WVuQA5vj9buJGwFFhxhodw5EOerGNKuiii
   xiSYl8dYsZPk32ycC2IeHr5ajQ4rTw7mb0BV0+qhekj/pAaD2eD/wzadj
   ilWphMJF0ci9f4fNH9HhUSdufTsgmZmZ1leYqzWkQXKfxHBsD68XGhmgn
   PTNgf9nBmShUCsbDtQlNmW36JWxGbuXaH9ih+33rcxQo6VoCp7U2LE/sb
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="309391920"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="309391920"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 07:42:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="476758918"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 24 Jan 2022 07:42:53 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nC1Ua-000IXj-Hi; Mon, 24 Jan 2022 15:42:52 +0000
Date:   Mon, 24 Jan 2022 23:42:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     SEO HOYOUNG <hy50.seo@samsung.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        asutoshd@codeaurora.org, cang@codeaurora.org, bvanassche@acm.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org
Subject: Re: [PATCH v1] scsi: ufs: disable auto hibern8 while entering suspend
Message-ID: <202201242333.B4Rc0F9H-lkp@intel.com>
References: <20220123234044.163394-1-hy50.seo@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220123234044.163394-1-hy50.seo@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi SEO,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on jejb-scsi/for-next]
[also build test WARNING on mkp-scsi/for-next linux/master linus/master v5.17-rc1 next-20220124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/SEO-HOYOUNG/scsi-ufs-disable-auto-hibern8-while-entering-suspend/20220124-195745
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git for-next
config: hexagon-randconfig-r005-20220124 (https://download.01.org/0day-ci/archive/20220124/202201242333.B4Rc0F9H-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 2e58a18910867ba6795066e044293e6daf89edf5)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/07442fb1071785299ef4ec421a37874e0d84babf
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review SEO-HOYOUNG/scsi-ufs-disable-auto-hibern8-while-entering-suspend/20220124-195745
        git checkout 07442fb1071785299ef4ec421a37874e0d84babf
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/scsi/ufs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/scsi/ufs/ufshcd.c:4207:6: warning: no previous prototype for function 'ufshcd_auto_hibern8_disable' [-Wmissing-prototypes]
   void ufshcd_auto_hibern8_disable(struct ufs_hba *hba)
        ^
   drivers/scsi/ufs/ufshcd.c:4207:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void ufshcd_auto_hibern8_disable(struct ufs_hba *hba)
   ^
   static 
   1 warning generated.


vim +/ufshcd_auto_hibern8_disable +4207 drivers/scsi/ufs/ufshcd.c

  4206	
> 4207	void ufshcd_auto_hibern8_disable(struct ufs_hba *hba)
  4208	{
  4209		unsigned long flags;
  4210	
  4211		if (!ufshcd_is_auto_hibern8_supported(hba))
  4212			return;
  4213	
  4214		spin_lock_irqsave(hba->host->host_lock, flags);
  4215		ufshcd_writel(hba, 0, REG_AUTO_HIBERNATE_IDLE_TIMER);
  4216		spin_unlock_irqrestore(hba->host->host_lock, flags);
  4217	}
  4218	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
