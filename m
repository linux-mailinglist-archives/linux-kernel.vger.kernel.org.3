Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A30852610E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 13:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbiEMLeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 07:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243824AbiEMLem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 07:34:42 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7D22B824C
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 04:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652441681; x=1683977681;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RXfsKO0LSh69xJrO0LkwO1HcUpg+7526NohhqiMOFTA=;
  b=HeBE/xXZ+6WvkAbWK2uJ/kne8Nq+aJy4Yo+SDf+wxXAYA0D0yMebpW6M
   7cS5saHT29cSyYa4sAYHO5KQRqoXalUMQAFg6vfmzeZFPyLc//19Rs203
   ROwEWQtbL7Y+VaDbrfcN13nLpx6uBd06LdOfzx1sbSt/naslF1cIkjQ8z
   +AMREHDj37HxTBmTvnG+YmRwOpvSrvSljx08+4mT2HUqXJaKLjKtwoUnV
   gapRRg0uYykOwykKVD3qJ/dSPrrVAb5uxedR8M2iPdBagJOxnuNcm3qS4
   Age7DJMInIQjBBMbLapDLGJsZeOahrow0Ow7Z+j5vHZjaQXvcz+hRPkSv
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="252331852"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="252331852"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 04:34:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="740123180"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 13 May 2022 04:34:37 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npTZ6-000Lh2-J0;
        Fri, 13 May 2022 11:34:36 +0000
Date:   Fri, 13 May 2022 19:33:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Cruz Zhao <CruzZhao@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>, Josh Don <joshdon@google.com>
Subject: Re: [PATCH] sched/core: add forced idle accounting for cgroups
Message-ID: <202205131951.zAnitpiH-lkp@intel.com>
References: <20220513005427.2507335-1-joshdon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513005427.2507335-1-joshdon@google.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on tip/master linux/master linus/master v5.18-rc6 next-20220512]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Josh-Don/sched-core-add-forced-idle-accounting-for-cgroups/20220513-085621
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 734387ec2f9d77b00276042b1fa7c95f48ee879d
config: i386-randconfig-a004 (https://download.01.org/0day-ci/archive/20220513/202205131951.zAnitpiH-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 9519dacab7b8afd537811fc2abaceb4d14f4e16a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/21dca7763777c1985d6f5ac289e6e0c20d429d05
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Josh-Don/sched-core-add-forced-idle-accounting-for-cgroups/20220513-085621
        git checkout 21dca7763777c1985d6f5ac289e6e0c20d429d05
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: __udivdi3
   >>> referenced by core.c
   >>>               sched/core.o:(cpu_extra_stat_show) in archive kernel/built-in.a

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
