Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597884FCEEC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 07:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348114AbiDLFY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 01:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238062AbiDLFYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 01:24:54 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1C221E2D;
        Mon, 11 Apr 2022 22:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649740957; x=1681276957;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VwBsYPOA6UzCQhM7M1EA3LR9hWztHC4Nf+zw3YFCNbg=;
  b=bbvZlOjKQI3ZU5FAj6NxKSnL1b2ZxYPDgFkvpiTtuz1oZIqzZxM+HSJT
   RP4ukXA4Jkg2BhiwJbGK65R9sUOaFV6pSLsgtmkJ376k5MsdYPg4lRfSe
   CAuWU4G6wdGDeS7hlXYBb3Cmhxyt59x0fcpjCuAOzMZC6p45k+HSi1Ois
   FRGVZZ1IhF6itn7PGfrEew7ifJLHT1duuLJL3EySfGCI1waNAy0IABo0s
   ITo2uNymzGNc7IlCJvtmo5dSvqUIW32v/RqFWofKuWutOb68jdCoAy8a4
   J2by2pxAh8RkdcfhRfGMNamic9yaudPxBErJqGCdupgKOSvi/bw4VGIk9
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="322724253"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="322724253"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 22:22:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="507396618"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 11 Apr 2022 22:22:35 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ne8z4-0002XU-AR;
        Tue, 12 Apr 2022 05:22:34 +0000
Date:   Tue, 12 Apr 2022 13:22:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: Re: [PATCH 15/20] ACPICA: executer/exsystem: Warn about sleeps
 greater than 10 ms
Message-ID: <202204121322.P9yX0gKP-lkp@intel.com>
References: <4200238.ejJDZkT8p0@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4200238.ejJDZkT8p0@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Rafael,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on linus/master linux/master v5.18-rc2 next-20220411]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Rafael-J-Wysocki/ACPICA-ACPICA-20220331/20220412-030922
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: i386-randconfig-a006-20220411 (https://download.01.org/0day-ci/archive/20220412/202204121322.P9yX0gKP-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project fe2478d44e4f7f191c43fef629ac7a23d0251e72)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/22c298d3a077e7ea8503e9acf7ac83e6b1e10148
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Rafael-J-Wysocki/ACPICA-ACPICA-20220331/20220412-030922
        git checkout 22c298d3a077e7ea8503e9acf7ac83e6b1e10148
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the linux-review/Rafael-J-Wysocki/ACPICA-ACPICA-20220331/20220412-030922 HEAD 32181ae3d3173aeee41f709612dfa4d52951b39d builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   drivers/acpi/acpica/exsystem.c:140:7: error: use of undeclared identifier 'how_long_US'; did you mean 'how_long_us'?
                   if (how_long_US > 100) {
                       ^~~~~~~~~~~
                       how_long_us
   drivers/acpi/acpica/exsystem.c:123:41: note: 'how_long_us' declared here
   acpi_status acpi_ex_system_do_stall(u32 how_long_us)
                                           ^
>> drivers/acpi/acpica/exsystem.c:179:10: error: use of undeclared identifier 'how_long_us'; did you mean 'how_long_ms'?
                                 how_long_us));
                                 ^~~~~~~~~~~
                                 how_long_ms
   include/acpi/acoutput.h:203:54: note: expanded from macro 'ACPI_WARNING'
   #define ACPI_WARNING(plist)             acpi_warning plist
                                                        ^
   drivers/acpi/acpica/exsystem.c:164:41: note: 'how_long_ms' declared here
   acpi_status acpi_ex_system_do_sleep(u64 how_long_ms)
                                           ^
   2 errors generated.


vim +179 drivers/acpi/acpica/exsystem.c

   150	
   151	/*******************************************************************************
   152	 *
   153	 * FUNCTION:    acpi_ex_system_do_sleep
   154	 *
   155	 * PARAMETERS:  how_long_ms     - The amount of time to sleep,
   156	 *                                in milliseconds
   157	 *
   158	 * RETURN:      None
   159	 *
   160	 * DESCRIPTION: Sleep the running thread for specified amount of time.
   161	 *
   162	 ******************************************************************************/
   163	
   164	acpi_status acpi_ex_system_do_sleep(u64 how_long_ms)
   165	{
   166		ACPI_FUNCTION_ENTRY();
   167	
   168		/* Since this thread will sleep, we must release the interpreter */
   169	
   170		acpi_ex_exit_interpreter();
   171	
   172		/*
   173		 * Warn users about excessive sleep times, so ASL code can be improved to
   174		 * use polling or similar techniques.
   175		 */
   176		if (how_long_ms > 10) {
   177			ACPI_WARNING((AE_INFO,
   178				      "Firmware issue: Excessive sleep time (%llu ms > 10 ms) in ACPI Control Method",
 > 179				      how_long_us));
   180		}
   181	
   182		/*
   183		 * For compatibility with other ACPI implementations and to prevent
   184		 * accidental deep sleeps, limit the sleep time to something reasonable.
   185		 */
   186		if (how_long_ms > ACPI_MAX_SLEEP) {
   187			how_long_ms = ACPI_MAX_SLEEP;
   188		}
   189	
   190		acpi_os_sleep(how_long_ms);
   191	
   192		/* And now we must get the interpreter again */
   193	
   194		acpi_ex_enter_interpreter();
   195		return (AE_OK);
   196	}
   197	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
