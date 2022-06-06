Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA9953DF2A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 02:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351907AbiFFAtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 20:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348528AbiFFAtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 20:49:07 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3394A93E
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 17:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654476545; x=1686012545;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m5LILM4W5Jo90plBdmv3m5E4L9wGQpi9t3QELpQxIGA=;
  b=L+xnnjrnF4aGw0xXPOUS9EZNskMCl6xCtr6v7ojA6lbHavN4EgbLI7he
   SN3SQ5PIBYLW3IGuPvylsd3nJIC3Nx/0Tsww34+xh9gOvmwMVirMAd5L4
   zKn0lKXpgBwCni3H2Iw0Gefq16a3GJ4BzyPoQqvN1R+W7ISJVNx2WGz7m
   wW2DMzVHdniHz9Q8nPbTtzlrx3XzPciBSUBZDqIRpehkUbOsNqxPbP8LL
   xi5kcULMyk/cAebgtUdeNw4EmCVnx+4H0QNHtvletw7FA1K0ohkCnffKX
   tEqvA1LeFJj+UgLQ+FGuDFa7yHQDWgZnZnHGp1ek8jTUMqNfKHcWie0MQ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="258763278"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="258763278"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2022 17:49:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="564654466"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 05 Jun 2022 17:49:02 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ny0vV-000CMv-T2;
        Mon, 06 Jun 2022 00:49:01 +0000
Date:   Mon, 6 Jun 2022 08:48:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sander Vanheule <sander@svanheule.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Yury Norov <yury.norov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marco Elver <elver@google.com>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sander Vanheule <sander@svanheule.net>
Subject: Re: [PATCH v3 1/4] cpumask: Fix invalid uniprocessor mask assumption
Message-ID: <202206060858.wA0FOzRy-lkp@intel.com>
References: <cc1f7d3334348cccbf9fde091015a802f379a9be.1654410109.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc1f7d3334348cccbf9fde091015a802f379a9be.1654410109.git.sander@svanheule.net>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sander,

I love your patch! Yet something to improve:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v5.18 next-20220603]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Sander-Vanheule/cpumask-Fix-invalid-uniprocessor-assumptions/20220606-004959
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
config: i386-randconfig-a009 (https://download.01.org/0day-ci/archive/20220606/202206060858.wA0FOzRy-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/37b3f10c4604ea299b454f39ac5ba3cad903ae16
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sander-Vanheule/cpumask-Fix-invalid-uniprocessor-assumptions/20220606-004959
        git checkout 37b3f10c4604ea299b454f39ac5ba3cad903ae16
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: arch/x86/kernel/cpu/cacheinfo.o: in function `__cache_amd_cpumap_setup':
   arch/x86/kernel/cpu/cacheinfo.c:890: undefined reference to `cpu_llc_shared_map'
>> ld: arch/x86/kernel/cpu/cacheinfo.c:895: undefined reference to `cpu_llc_shared_map'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
