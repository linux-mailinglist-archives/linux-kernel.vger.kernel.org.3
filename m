Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719E95874C6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 02:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbiHBAYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 20:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiHBAYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 20:24:01 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1860F27;
        Mon,  1 Aug 2022 17:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659399840; x=1690935840;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=axUDlJzadxSeIRLhebaAK4Au66FF2r3QhjWZs5FUcrU=;
  b=CgB6OnXWmv3cTFzlHlv0EJbF1xdP71tJF7Z9UG0PUNiLeMMmQEgIpyh8
   wPqDtBMKApXfMAiDTsbRjffXk7KHHR2XqZHU2WP7ORC0xKLCD80IoJ5kN
   vxQb1LyGZguB65r5zgSriKVM6ZzA3669L34OR/XDZT1Gdj3rt9XvdpcQv
   h8nV7F+D2hzJgF9PudfG9upxttxtiLk2H34X1euwTbXpW8cM6VPQprUfH
   KZ+L7qyIf5EachD+Vv04qNgaXj/7S8+NORcpoFklxTTNYlPR1j6fpxDo3
   qpCXtAANlThhiwIHBzwRZjGVGLb9WGD46ol+JLLps3VzIe5RTOJfOey/H
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="353286989"
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="353286989"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 17:24:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="778435481"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 01 Aug 2022 17:23:57 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIfhU-000FVw-16;
        Tue, 02 Aug 2022 00:23:56 +0000
Date:   Tue, 2 Aug 2022 08:23:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniil Lunev <dlunev@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Stanley Chu <chu.stanley@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Daniil Lunev <dlunev@chromium.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        Daejun Park <daejun7.park@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v2] ufs: core: ufshcd: use local_clock() for debugging
 timestamps
Message-ID: <202208020844.RaNi6Dg0-lkp@intel.com>
References: <20220801142931.v2.1.I699244ea7efbd326a34a6dfd9b5a31e78400cf68@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801142931.v2.1.I699244ea7efbd326a34a6dfd9b5a31e78400cf68@changeid>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniil,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on jejb-scsi/for-next]
[also build test ERROR on mkp-scsi/for-next linus/master v5.19 next-20220728]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniil-Lunev/ufs-core-ufshcd-use-local_clock-for-debugging-timestamps/20220801-123157
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git for-next
config: x86_64-randconfig-a001-20220801 (https://download.01.org/0day-ci/archive/20220802/202208020844.RaNi6Dg0-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 52cd00cabf479aa7eb6dbb063b7ba41ea57bce9e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/45a46347597e5c368c27a9fe01e400af675eb5e9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Daniil-Lunev/ufs-core-ufshcd-use-local_clock-for-debugging-timestamps/20220801-123157
        git checkout 45a46347597e5c368c27a9fe01e400af675eb5e9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/ufs/ kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/ufs/core/ufshcd.c:2143:39: error: call to undeclared function 'local_clock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           lrbp->issue_time_stamp_local_clock = local_clock();
                                                ^
   drivers/ufs/core/ufshcd.c:4227:45: error: call to undeclared function 'local_clock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   hba->ufs_stats.last_hibern8_exit_tstamp = local_clock();
                                                             ^
   drivers/ufs/core/ufshcd.c:4729:22: error: call to undeclared function 'local_clock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           e->tstamp[e->pos] = local_clock();
                               ^
   drivers/ufs/core/ufshcd.c:5362:40: error: call to undeclared function 'local_clock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   lrbp->compl_time_stamp_local_clock = local_clock();
                                                        ^
   drivers/ufs/core/ufshcd.c:6651:32: error: call to undeclared function 'local_clock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           hba->ufs_stats.last_intr_ts = local_clock();
                                         ^
   drivers/ufs/core/ufshcd.c:9553:44: warning: shift count >= width of type [-Wshift-count-overflow]
                   if (!dma_set_mask_and_coherent(hba->dev, DMA_BIT_MASK(64)))
                                                            ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^ ~~~
   1 warning and 5 errors generated.


vim +/local_clock +2143 drivers/ufs/core/ufshcd.c

  2130	
  2131	/**
  2132	 * ufshcd_send_command - Send SCSI or device management commands
  2133	 * @hba: per adapter instance
  2134	 * @task_tag: Task tag of the command
  2135	 */
  2136	static inline
  2137	void ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag)
  2138	{
  2139		struct ufshcd_lrb *lrbp = &hba->lrb[task_tag];
  2140		unsigned long flags;
  2141	
  2142		lrbp->issue_time_stamp = ktime_get();
> 2143		lrbp->issue_time_stamp_local_clock = local_clock();
  2144		lrbp->compl_time_stamp = ktime_set(0, 0);
  2145		lrbp->compl_time_stamp_local_clock = 0;
  2146		ufshcd_add_command_trace(hba, task_tag, UFS_CMD_SEND);
  2147		ufshcd_clk_scaling_start_busy(hba);
  2148		if (unlikely(ufshcd_should_inform_monitor(hba, lrbp)))
  2149			ufshcd_start_monitor(hba, lrbp);
  2150	
  2151		spin_lock_irqsave(&hba->outstanding_lock, flags);
  2152		if (hba->vops && hba->vops->setup_xfer_req)
  2153			hba->vops->setup_xfer_req(hba, task_tag, !!lrbp->cmd);
  2154		__set_bit(task_tag, &hba->outstanding_reqs);
  2155		ufshcd_writel(hba, 1 << task_tag, REG_UTP_TRANSFER_REQ_DOOR_BELL);
  2156		spin_unlock_irqrestore(&hba->outstanding_lock, flags);
  2157	}
  2158	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
