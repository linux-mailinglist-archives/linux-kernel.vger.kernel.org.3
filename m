Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D2B50B40B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446012AbiDVJap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445997AbiDVJaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:30:35 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC4F36315
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 02:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650619663; x=1682155663;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XP/Bq2pc0VZygbMNaDlk5rjG7Tyup7dHcAYPoZ9I3CM=;
  b=lC4fGPelOhUwQDoSV4vQTwlr1fi6rWxUii1HIcWqD6rFmHcVLZzGSnSm
   e06zRItbUbqdKovy0MqOUYDaiUaZBV4Cy0h5SPYihuQlh44erAwuFNVZ2
   wHcLH38xCJEobbn3qHLPl9H4Z5zEwBVPmBb1sxxFt+T6WcVfNCYvCcI5x
   sAuIqpkIBJilqlaCb7TSSQpCWUOUf3dSL5n/hiwDRL5GTj3Ec2dxnZJpd
   cKc9Ic995XPrQPvDvVulK/wSlgZ28k4Xf2OpsVXEXasvXYJJPDziCAkGd
   vc8f8eBLmM7FaVja6LJu/2j/Tr74h39sAXOLci/wz6LNnuYvY8RYoqdu8
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264798519"
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="264798519"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 02:27:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="534069027"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 22 Apr 2022 02:27:40 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhpZj-0009yQ-G1;
        Fri, 22 Apr 2022 09:27:39 +0000
Date:   Fri, 22 Apr 2022 17:27:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qing Wang <wangqing@vivo.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Wang Qing <wangqing@vivo.com>
Subject: Re: [PATCH 1/2] arch_topology: support for describing cache topology
 from DT
Message-ID: <202204221720.cO70SkrD-lkp@intel.com>
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
config: riscv-randconfig-c006-20220421 (https://download.01.org/0day-ci/archive/20220422/202204221720.cO70SkrD-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5bd87350a5ae429baf8f373cb226a57b62f87280)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/854ee80a8c32ea98203c96ba25cae2e87eeb43b1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Qing-Wang/Add-complex-scheduler-level-for-arm64/20220421-225748
        git checkout 854ee80a8c32ea98203c96ba25cae2e87eeb43b1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/ drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/base/arch_topology.c:617:1: error: unknown type name 'staic'; did you mean 'static'?
   staic struct device_node *cache_topology[NR_CPUS][MAX_CACHE_LEVEL];
   ^~~~~
   static
   1 error generated.


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
