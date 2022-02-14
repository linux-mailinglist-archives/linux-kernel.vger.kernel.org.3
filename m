Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481DD4B47DE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 10:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241364AbiBNJu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 04:50:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245345AbiBNJpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 04:45:53 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C1660D9F;
        Mon, 14 Feb 2022 01:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644831538; x=1676367538;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0IGPbPVaQO9WmcVVZypsyEn9AxDkiOr4ZxM5KcPK1wc=;
  b=MVi4kPkioulQr2CO1lP/7xOWSPUzzTsokGKHEhud34EeXYOAiOLJ30LQ
   y/9BT79qy8PUNiWHJISdv/HMDKoGGKLhkLAncbved2N9/StNILxs5iA0Z
   L7wqcWxkYvUBZojD6QOwUjGz3MePLkZMFarC/pMx9q4AvmMpodlkbz5YX
   tuuk7RWf9uFvYw7stYJWJ773eA44roEpDdQzPjwO44duph93rNUhjZ5BH
   fS5yeyigcYGJg8+65Z28L54tuTFBvu+WKIVip+HrX5M3tc3/hIovrsONY
   XkCkIWG5QyZfxC8nZdr9wgHXEyYhbgyUo19+Hspka+XoNq8DrDbfLhEsU
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="247647693"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="247647693"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 01:38:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="635052312"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 14 Feb 2022 01:38:51 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJXoo-0008M7-E2; Mon, 14 Feb 2022 09:38:50 +0000
Date:   Mon, 14 Feb 2022 17:38:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guixin Liu <kanie@linux.alibaba.com>, bostroesser@gmail.com,
        martin.petersen@oracle.com
Cc:     kbuild-all@lists.01.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiaoguang.wang@linux.alibaba.com, xlpang@linux.alibaba.com
Subject: Re: [PATCH V2] scsi: target: tcmu: Make cmd_ring_size changeable via
 configfs.
Message-ID: <202202141721.OdtEVrDJ-lkp@intel.com>
References: <1644808523-21069-1-git-send-email-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644808523-21069-1-git-send-email-kanie@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guixin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on mkp-scsi/for-next]
[also build test WARNING on v5.17-rc4 next-20220211]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Guixin-Liu/scsi-target-tcmu-Make-cmd_ring_size-changeable-via-configfs/20220214-111810
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
config: xtensa-allyesconfig (https://download.01.org/0day-ci/archive/20220214/202202141721.OdtEVrDJ-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/c972a1533164208e331a5a4d34a7ed0bb44b17ba
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Guixin-Liu/scsi-target-tcmu-Make-cmd_ring_size-changeable-via-configfs/20220214-111810
        git checkout c972a1533164208e331a5a4d34a7ed0bb44b17ba
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/target/target_core_user.c: In function 'tcmu_show_configfs_dev_params':
>> drivers/target/target_core_user.c:2627:49: warning: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'u32' {aka 'unsigned int'} [-Wformat=]
    2627 |         bl += sprintf(b + bl, "CmdRingSizeMB: %lu\n",
         |                                               ~~^
         |                                                 |
         |                                                 long unsigned int
         |                                               %u
    2628 |                       (udev->cmdr_size + CMDR_OFF) >> 20);
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                                    |
         |                                                    u32 {aka unsigned int}
   drivers/target/target_core_user.c: In function 'tcmu_cmd_ring_size_mb_show':
   drivers/target/target_core_user.c:2743:45: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'u32' {aka 'unsigned int'} [-Wformat=]
    2743 |         return snprintf(page, PAGE_SIZE, "%lu\n",
         |                                           ~~^
         |                                             |
         |                                             long unsigned int
         |                                           %u
    2744 |                         (udev->cmdr_size + CMDR_OFF) >> 20);
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                                      |
         |                                                      u32 {aka unsigned int}


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
> 2627		bl += sprintf(b + bl, "CmdRingSizeMB: %lu\n",
  2628			      (udev->cmdr_size + CMDR_OFF) >> 20);
  2629	
  2630		return bl;
  2631	}
  2632	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
