Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A0D4B7193
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239395AbiBOOwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:52:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239504AbiBOOvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:51:39 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9570711B325;
        Tue, 15 Feb 2022 06:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644936611; x=1676472611;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xFA9nntrtGrpU/cgN8W3xUF0mYNVZIjdFM78u82ttwU=;
  b=GsA1Ih/U6EHGkLWy/ASI/7pjcl7fs9MnLUZNHtb1wO8JuvI6nqxsHCFz
   IX6SwHcSqLDFA7eolfSrtNJn235A2qoycwqIGgz5Nk9HovJrAGo4HbV0M
   g7mulxfE8V7mOvEyViZW/FXe3znO6RhnFsM5gqsAmAQPEBvhCytGsMaXf
   bROfPE70FLZcfg8vrkGMpZyy4AEMPKBHSOMFdmIn5sPPgSsomSSznxMcg
   HTUKpZEUhjN456Pv7i0L+k82z/ykPmsLtE2LmUyCga3WHY2ngVAj2IEmc
   R0lUuCt8YY5RUVHe3d3EgBKdKy4bvG9yLHoKv8yJHejK/YHalKSkxrB4s
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="233907259"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="233907259"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 06:49:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="486204509"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 15 Feb 2022 06:49:52 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJz9L-0009lk-Vv; Tue, 15 Feb 2022 14:49:51 +0000
Date:   Tue, 15 Feb 2022 22:49:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guixin Liu <kanie@linux.alibaba.com>, bostroesser@gmail.com,
        martin.petersen@oracle.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguang.wang@linux.alibaba.com,
        xlpang@linux.alibaba.com
Subject: Re: [PATCH V3] scsi: target: tcmu: Make cmd_ring_size changeable via
 configfs.
Message-ID: <202202152239.8LJNreof-lkp@intel.com>
References: <1644912216-97633-1-git-send-email-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644912216-97633-1-git-send-email-kanie@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
config: x86_64-randconfig-a005-20220214 (https://download.01.org/0day-ci/archive/20220215/202202152239.8LJNreof-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 37f422f4ac31c8b8041c6b62065263314282dab6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/7f77700542b8196c546ef10656dda7a107d8d1ad
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Guixin-Liu/scsi-target-tcmu-Make-cmd_ring_size-changeable-via-configfs/20220215-160505
        git checkout 7f77700542b8196c546ef10656dda7a107d8d1ad
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/target/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/target/target_core_user.c:2628:9: warning: format specifies type 'unsigned int' but the argument has type 'unsigned long' [-Wformat]
                         (udev->cmdr_size + CMDR_OFF) >> 20);
                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/target/target_core_user.c:2744:4: warning: format specifies type 'unsigned int' but the argument has type 'unsigned long' [-Wformat]
                           (udev->cmdr_size + CMDR_OFF) >> 20);
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   2 warnings generated.


vim +2628 drivers/target/target_core_user.c

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
  2627		bl += sprintf(b + bl, "CmdRingSizeMB: %u\n",
> 2628			      (udev->cmdr_size + CMDR_OFF) >> 20);
  2629	
  2630		return bl;
  2631	}
  2632	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
