Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F4F50ADC7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 04:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443359AbiDVCeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 22:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443337AbiDVCe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 22:34:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60924B409
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 19:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650594697; x=1682130697;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=78y0yrj0J9t8THX+CNky5t58FoNwsrtgOsmtpg7MFrM=;
  b=BwYpmF1H3hu5iyvUn2bFn6D9bKSCGM3OoJkSg2Fgy+ovG0k08p9IY8EV
   LD8EGHQ41jsla6JWhjdZEglBvP0Ht3b63wCAk4csXzvTAbm9t42JUkdUN
   rYX8dr318FzFPmWuh/YTpCF0xmQ+ZSPFzIS8C/xPcXVjTIzn/7l309Y/5
   tR8WywiEx1SeGa94VHgR3mPRXP1khPrvTkmLNDit5HdfPAn4e4aXRzSyB
   a8lM8iWpmnB0mGoodmzoC116OQkX4DBQ+Sm5iRvjJqyV6WLDo+RZmDu5p
   j5FDITH0wDen8vYRFZMyxLZlF0tX+IhjIi91lzvj+WCWDPIjUh1tlYlHq
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264714053"
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="264714053"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 19:31:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="562852132"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 21 Apr 2022 19:31:35 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhj54-00097a-Sm;
        Fri, 22 Apr 2022 02:31:34 +0000
Date:   Fri, 22 Apr 2022 10:30:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qing Wang <wangqing@vivo.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Wang Qing <wangqing@vivo.com>
Subject: Re: [PATCH 1/2] arch_topology: support for describing cache topology
 from DT
Message-ID: <202204221053.QFSQGEXr-lkp@intel.com>
References: <1650552960-60165-2-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650552960-60165-2-git-send-email-wangqing@vivo.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qing,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on driver-core/driver-core-testing linus/master arm-perf/for-next/perf v5.18-rc3 next-20220421]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Qing-Wang/Add-complex-scheduler-level-for-arm64/20220421-225748
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: arm-keystone_defconfig (https://download.01.org/0day-ci/archive/20220422/202204221053.QFSQGEXr-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/854ee80a8c32ea98203c96ba25cae2e87eeb43b1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Qing-Wang/Add-complex-scheduler-level-for-arm64/20220421-225748
        git checkout 854ee80a8c32ea98203c96ba25cae2e87eeb43b1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/base/arch_topology.c:617:6: error: expected ';' before 'struct'
     617 | staic struct device_node *cache_topology[NR_CPUS][MAX_CACHE_LEVEL];
         |      ^~~~~~~
         |      ;


vim +617 drivers/base/arch_topology.c

   612	
   613	/*
   614	 * cpu cache topology table
   615	 */
   616	#define MAX_CACHE_LEVEL 7
 > 617	staic struct device_node *cache_topology[NR_CPUS][MAX_CACHE_LEVEL];
   618	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
