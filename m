Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E44493322
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 03:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351084AbiASCvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 21:51:18 -0500
Received: from mga06.intel.com ([134.134.136.31]:6865 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244048AbiASCvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 21:51:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642560676; x=1674096676;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6MNgv6gOBWr2etpKObCC3kKbrF9v4SwaLJQQ3hF4zuM=;
  b=exSSY9ii3WrQNOXU2uga7HtT8bht5Z75Ao/a7OltjNxkP3qDLjwR2EV+
   zFUjvYynF3U2ucbPry24jd0aTFl7amzy44EYFcMsMTmyEQJ5jFRATPo3k
   qV6PgcHY6VEYtWr550bDluIzdxDEwQL5rwO+f9hG4VZgFbtmHsioAET/q
   qItMVthSkEe3Zg/I1i46LX23OTrwqRlHZ1hekE248qe91Qvk4mUy0WJhG
   IXGoQeP/vnjM2KLka+QfqFgbS1lSiEt/ScHdtBdd78ZXzg3vAyt02k0jZ
   boEpOdUyBnPEvACswNCFyS2hetgpLfh0/5WIUh16O5aO11lgE1ACmBaoU
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="305699713"
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="305699713"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 18:51:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="625724713"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 18 Jan 2022 18:51:14 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nA146-000DAE-3b; Wed, 19 Jan 2022 02:51:14 +0000
Date:   Wed, 19 Jan 2022 10:50:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Farzad Farshchi <farzadfr@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: [esmil:visionfive 72/80] drivers/nvdla/nvdla_gem.c:74:3: warning:
 cast to pointer from integer of different size
Message-ID: <202201191052.0lVZjaZf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   e46c3a7e373e6faa03399f1a41c29cf7546c37cb
commit: 22c69dadd3685e2d35fb43f4da3bb7fe43f2548c [72/80] nvdla: add NVDLA driver
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220119/202201191052.0lVZjaZf-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/esmil/linux/commit/22c69dadd3685e2d35fb43f4da3bb7fe43f2548c
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout 22c69dadd3685e2d35fb43f4da3bb7fe43f2548c
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/nvdla/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/nvdla/nvdla_gem.c: In function 'nvdla_fill_task_desc':
>> drivers/nvdla/nvdla_gem.c:74:3: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
      74 |   (void __user *)local_task->address_list,
         |   ^


vim +74 drivers/nvdla/nvdla_gem.c

    58	
    59	static int32_t nvdla_fill_task_desc(struct nvdla_ioctl_submit_task *local_task,
    60					struct nvdla_task *task)
    61	{
    62		struct nvdla_mem_handle *handles;
    63	
    64		/* update task desc fields */
    65		task->num_addresses = local_task->num_addresses;
    66	
    67		handles = kzalloc(local_task->num_addresses *
    68					sizeof(struct nvdla_mem_handle), GFP_KERNEL);
    69		if (handles == NULL)
    70			return -EFAULT;
    71	
    72		/* get user addresses list */
    73		if (copy_from_user(handles,
  > 74			(void __user *)local_task->address_list,
    75			(task->num_addresses *
    76				sizeof(struct nvdla_mem_handle)))) {
    77			pr_err("failed to copy address list from user ptr\n");
    78			kfree(handles);
    79			return -EFAULT;
    80		}
    81	
    82		task->address_list = handles;
    83		return 0;
    84	}
    85	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
