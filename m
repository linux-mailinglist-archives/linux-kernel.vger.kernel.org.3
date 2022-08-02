Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C6B588405
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 00:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236495AbiHBWMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 18:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235369AbiHBWLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 18:11:50 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356063FA29
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 15:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659478301; x=1691014301;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gj1R8PYkuhpliO3kZU490We6AAGLH9lpWLDvSGBIVvM=;
  b=OWxsodO6afgMwTRYLUa0rOfooq0KNIEvEP6FGj1lFiWHnX6TURr8Mx53
   Y5sHdDwAXCXJQa118LXjmR8EBG3rtX3V2m8REb7fOKz3FA+Vs+WniiRkT
   Hm8Kva76uJRnSG0jdmCY3/T6T0HHJAS7/QRDbyORxy9CG2BnvuD7G8tS7
   Xb1uK4VLHOKpZ6z/A8efEbQLnNW29g84OH8itdhz872SKnVUmpgM/rciS
   rRTpJMLedlS92iEUvy3U3UwaenF0xI1WnJJETrylsnl4U31mIMrYE2qiL
   j/ktykVVQMcEKw8sqdZ7a8PoOFcjXSArjOrJ9m97JcHVulGZ7jPpRPbWe
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="315383679"
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="315383679"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 15:11:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="635452902"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 02 Aug 2022 15:11:37 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJ06y-000GVL-0g;
        Tue, 02 Aug 2022 22:11:36 +0000
Date:   Wed, 3 Aug 2022 06:11:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aaron Tomlin <atomlin@redhat.com>, frederic@kernel.org,
        mtosatti@redhat.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, cl@linux.com,
        tglx@linutronix.de, mingo@kernel.org, peterz@infradead.org,
        pauld@redhat.com, neelx@redhat.com, oleksandr@natalenko.name,
        atomlin@atomlin.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v5 2/2] tick/sched: Ensure quiet_vmstat() is called when
 the idle tick was stopped too
Message-ID: <202208030608.T5WKMCpb-lkp@intel.com>
References: <20220801234258.134609-3-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801234258.134609-3-atomlin@redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aaron,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.19 next-20220728]
[cannot apply to tip/timers/nohz]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aaron-Tomlin/tick-sched-Ensure-quiet_vmstat-is-called-when-the-idle-tick-was-stopped-too/20220802-074341
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 9de1f9c8ca5100a02a2e271bdbde36202e251b4b
config: i386-randconfig-a002-20220801 (https://download.01.org/0day-ci/archive/20220803/202208030608.T5WKMCpb-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 52cd00cabf479aa7eb6dbb063b7ba41ea57bce9e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a0d3b9fe31484c4c44c430d10d0b60e2e0551525
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Aaron-Tomlin/tick-sched-Ensure-quiet_vmstat-is-called-when-the-idle-tick-was-stopped-too/20220802-074341
        git checkout a0d3b9fe31484c4c44c430d10d0b60e2e0551525
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: tick_nohz_user_enter_prepare
   >>> referenced by common.c
   >>>               entry/common.o:(exit_to_user_mode_prepare) in archive kernel/built-in.a
   >>> referenced by common.c
   >>>               entry/common.o:(exit_to_user_mode_prepare) in archive kernel/built-in.a

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
