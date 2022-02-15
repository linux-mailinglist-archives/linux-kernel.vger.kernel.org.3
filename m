Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA284B6D01
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 14:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238095AbiBONHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 08:07:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbiBONHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 08:07:02 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E9A2A26C;
        Tue, 15 Feb 2022 05:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644930412; x=1676466412;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2FCB7XCUy/Va+LwVfTWnmqFaNBc9mwY+9pf6LoBiIRY=;
  b=grF5vEg1jjrx2H9KSuH6elpIMrqbhoQukfHvzthMFbvSDLyaz9QjPtSC
   3prpC1pbdBG2qAgDwxHDNnPapWCuJx/AMyQc+h4QgEtpvhQlaJIb575ms
   uM6/t4O8+I3dpCkDxCPIAlypVk+d0DimDheRQdyEl3Eb8O91uvp82kZN5
   Zpfw2RWvNfmqrb6TpMG2D2sDu+nrqs8nBVpmgaFFz7ACyNasNrf5CJAe2
   jivVmBIjgvWdzcvflitA2iQ1QoaJpLe5ftwdi/jNe6Cb0WaqRj4ser7Gk
   eplA1aqk0jvaFNB3yb9H4mzP2/z2pR2XIb0nnzOFLgqH5jv8PFhKagAOR
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="313621068"
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="313621068"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 05:06:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="635865651"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 15 Feb 2022 05:06:50 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJxXd-0009fn-BA; Tue, 15 Feb 2022 13:06:49 +0000
Date:   Tue, 15 Feb 2022 21:05:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guixin Liu <kanie@linux.alibaba.com>, bostroesser@gmail.com,
        martin.petersen@oracle.com
Cc:     kbuild-all@lists.01.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiaoguang.wang@linux.alibaba.com, xlpang@linux.alibaba.com
Subject: Re: [PATCH V3] scsi: target: tcmu: Make cmd_ring_size changeable via
 configfs.
Message-ID: <202202152052.AEF7jHIH-lkp@intel.com>
References: <1644912216-97633-1-git-send-email-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644912216-97633-1-git-send-email-kanie@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guixin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on mkp-scsi/for-next]
[also build test WARNING on v5.17-rc4 next-20220215]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Guixin-Liu/scsi-target-tcmu-Make-cmd_ring_size-changeable-via-configfs/20220215-160505
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220215/202202152052.AEF7jHIH-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/7f77700542b8196c546ef10656dda7a107d8d1ad
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Guixin-Liu/scsi-target-tcmu-Make-cmd_ring_size-changeable-via-configfs/20220215-160505
        git checkout 7f77700542b8196c546ef10656dda7a107d8d1ad
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/target/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/target/target_core_user.c: In function 'tcmu_show_configfs_dev_params':
>> drivers/target/target_core_user.c:2627:41: warning: format '%u' expects argument of type 'unsigned int', but argument 3 has type 'long unsigned int' [-Wformat=]
    2627 |  bl += sprintf(b + bl, "CmdRingSizeMB: %u\n",
         |                                        ~^
         |                                         |
         |                                         unsigned int
         |                                        %lu
    2628 |         (udev->cmdr_size + CMDR_OFF) >> 20);
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                      |
         |                                      long unsigned int
   drivers/target/target_core_user.c: In function 'tcmu_cmd_ring_size_mb_show':
   drivers/target/target_core_user.c:2743:37: warning: format '%u' expects argument of type 'unsigned int', but argument 4 has type 'long unsigned int' [-Wformat=]
    2743 |  return snprintf(page, PAGE_SIZE, "%u\n",
         |                                    ~^
         |                                     |
         |                                     unsigned int
         |                                    %lu
    2744 |    (udev->cmdr_size + CMDR_OFF) >> 20);
         |    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 long unsigned int


vim +2627 drivers/target/target_core_user.c

  2616	
  2617	static ssize_t tcmu_show_configfs_dev_params(struct se_device *dev, char *b)
  2618	{
  2619		struct tcmu_dev *udev = TCMU_DEV(dev);
  2620		ssize_t bl = 0;
  2621	
  2622		bl = sprintf(b + bl, "Config: %s ",
  2623			     udev->dev_config[0] ? udev->dev_config : "NULL");
  2624		bl += sprintf(b + bl, "Size: %llu ", udev->dev_size);
  2625		bl += sprintf(b + bl, "MaxDataAreaMB: %u ", udev->data_area_mb);
  2626		bl += sprintf(b + bl, "DataPagesPerBlk: %u", udev->data_pages_per_blk);
> 2627		bl += sprintf(b + bl, "CmdRingSizeMB: %u\n",
  2628			      (udev->cmdr_size + CMDR_OFF) >> 20);
  2629	
  2630		return bl;
  2631	}
  2632	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
