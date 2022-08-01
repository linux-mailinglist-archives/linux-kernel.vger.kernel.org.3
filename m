Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9362D586788
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 12:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiHAKbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 06:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiHAKam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 06:30:42 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508402B61D;
        Mon,  1 Aug 2022 03:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659349833; x=1690885833;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eGo0V8fFrWREYTwhr5/rcZuEs8MyHDPd7UAYMxVJyHY=;
  b=ax+iUAh/dAM0BaCpP8FLGn0pR55ML8BISXJWj+hUUcwFGrsg6aHP1T6s
   +8w8/g59E/sn3RAN1RMLpwVdypf8r/wpXoQ71BWrla6C1jviDLaIeCMbM
   SPKuAksycfDcxE+szAVB8RajmPGhu9QCgzx/bO8h/cXKvRdxgNUEBIlrQ
   Tbz6L0xZsAt540oXrU/rEN84WnQ2okG4or/wc54QE631eRFMcxukCoaAZ
   JC5zlspFrLV6RQ9ZVk4X+KA3UThmjaGY4JJPCvV6eZT9ZLs+5guFdyZOM
   66bffWghbrqLDkqqHS9ANmNI6sSKlaDl0H6tozSNtY93vfbAzB004qig2
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="289125299"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="289125299"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 03:30:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="552469679"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 01 Aug 2022 03:30:27 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oISgs-000F1v-1U;
        Mon, 01 Aug 2022 10:30:26 +0000
Date:   Mon, 1 Aug 2022 18:29:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniil Lunev <dlunev@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Stanley Chu <chu.stanley@gmail.com>
Cc:     kbuild-all@lists.01.org, Daniil Lunev <dlunev@chromium.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        Daejun Park <daejun7.park@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v2] ufs: core: ufshcd: use local_clock() for debugging
 timestamps
Message-ID: <202208011814.gx9OZFDF-lkp@intel.com>
References: <20220801142931.v2.1.I699244ea7efbd326a34a6dfd9b5a31e78400cf68@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801142931.v2.1.I699244ea7efbd326a34a6dfd9b5a31e78400cf68@changeid>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
[cannot apply to bvanassche/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniil-Lunev/ufs-core-ufshcd-use-local_clock-for-debugging-timestamps/20220801-123157
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git for-next
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20220801/202208011814.gx9OZFDF-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/45a46347597e5c368c27a9fe01e400af675eb5e9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Daniil-Lunev/ufs-core-ufshcd-use-local_clock-for-debugging-timestamps/20220801-123157
        git checkout 45a46347597e5c368c27a9fe01e400af675eb5e9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/ufs/core/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/ufs/core/ufshcd.c: In function 'ufshcd_send_command':
>> drivers/ufs/core/ufshcd.c:2143:46: error: implicit declaration of function 'local_clock'; did you mean 'local_lock'? [-Werror=implicit-function-declaration]
    2143 |         lrbp->issue_time_stamp_local_clock = local_clock();
         |                                              ^~~~~~~~~~~
         |                                              local_lock
   cc1: some warnings being treated as errors


vim +2143 drivers/ufs/core/ufshcd.c

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
