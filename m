Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A40150C843
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 10:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbiDWImN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 04:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiDWImL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 04:42:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F09A15AE16
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 01:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650703155; x=1682239155;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Koqb3ucL794VO7WRQVKQ9u/oAiwHZzbd/44eKdUbvoU=;
  b=MuNJr/4miFEf02qsDFLrmBxrtrZM6PKbrE28Lx28TgQ+XjHadOokh5Bv
   Yx7bjMIrOVKHi0kgl3hVETb26cg8V65wjPdeuYjWR+oS3D2hAvOk6dqlS
   wZpozGS7kCrUhKCNeRWH3uYcq3CvbJsey5jAhPC9t6Ab1xXxTsjDcJ3Vw
   0SsmehEvNSAWC/b28HHFhIYji4kAgqhdskoISmkr5B5g9/Wdo57diLkbO
   Scp6r3WzRUxdPILDQzzN8RdbGcxA5uYVTcmZGUVFXbx2Dj7KrFEXa+nXu
   IIYSw5mEHuqOrtnoMRNQN1qMzLQJVfqgx8mgbDo/K6ekskasceFg+SgGG
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="265037372"
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="265037372"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 01:39:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="869027047"
Received: from lkp-server01.sh.intel.com (HELO dd58949a6e39) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 23 Apr 2022 01:39:12 -0700
Received: from kbuild by dd58949a6e39 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niBIN-000054-9G;
        Sat, 23 Apr 2022 08:39:11 +0000
Date:   Sat, 23 Apr 2022 16:38:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jagdish Gediya <jvgediya@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc:     kbuild-all@lists.01.org, baolin.wang@linux.alibaba.com,
        dave.hansen@linux.intel.com, ying.huang@intel.com,
        aneesh.kumar@linux.ibm.com, shy828301@gmail.com,
        weixugc@google.com, gthelen@google.com, dan.j.williams@intel.com,
        Jagdish Gediya <jvgediya@linux.ibm.com>
Subject: Re: [PATCH v3 6/7] mm: demotion: expose per-node demotion targets
 via sysfs
Message-ID: <202204231602.2DeA4BIa-lkp@intel.com>
References: <20220422195516.10769-7-jvgediya@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422195516.10769-7-jvgediya@linux.ibm.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagdish,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on driver-core/driver-core-testing]
[also build test ERROR on linus/master linux/master v5.18-rc3]
[cannot apply to hnaz-mm/master next-20220422]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Jagdish-Gediya/mm-demotion-Introduce-new-node-state-N_DEMOTION_TARGETS/20220423-035714
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git 4e224719f5d9b92abf1e0edfb2a83053208f3026
config: sparc-randconfig-r034-20220422 (https://download.01.org/0day-ci/archive/20220423/202204231602.2DeA4BIa-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0717e30f61ac83bd6ec65395bf46fdb5131cb83f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jagdish-Gediya/mm-demotion-Introduce-new-node-state-N_DEMOTION_TARGETS/20220423-035714
        git checkout 0717e30f61ac83bd6ec65395bf46fdb5131cb83f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash drivers/base/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/base/node.c: In function 'demotion_targets_show':
>> drivers/base/node.c:567:39: error: implicit declaration of function 'node_get_demotion_targets' [-Werror=implicit-function-declaration]
     567 |         nodemask_t demotion_targets = node_get_demotion_targets(dev->id);
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/base/node.c:567:39: error: invalid initializer
   cc1: some warnings being treated as errors


vim +/node_get_demotion_targets +567 drivers/base/node.c

   563	
   564	static ssize_t demotion_targets_show(struct device *dev,
   565					     struct device_attribute *attr, char *buf)
   566	{
 > 567		nodemask_t demotion_targets = node_get_demotion_targets(dev->id);
   568	
   569		return sysfs_emit(buf, "%*pbl\n", nodemask_pr_args(&demotion_targets));
   570	}
   571	static DEVICE_ATTR_RO(demotion_targets);
   572	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
