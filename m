Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7595588733
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 08:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbiHCGO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 02:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiHCGOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 02:14:55 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8E92181B
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 23:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659507294; x=1691043294;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=grNcxGxfxKqQRMh3VdHKu0SZeqP13QI8mn6oD6ZSJj8=;
  b=ZMHw9Auvu2e8Hymxb4QW2HVxElmskZkWsvYtO880kGwsNPkaa0JUOTK8
   FhCTvFY0X2YhIaALC66dZD3aHWTLRfVb6IX8FAyfTj72zkrN0YJLV3a0V
   xsKskpasbF5zyl7ysIoawZXN1fgr+LS98FLlsmqfzXFvkOQUmmNk9WCDG
   5rnFmOEFLYgaIQop2YgZGlc/2LoGXnQV+FXYuBmMxON2JDFFrRYs659f+
   bwXJBNqJOjdjAKqlZwWoDlUn2iJgRKZuzP1WXEQpJocaPrf+J68UITS65
   TrCZvILuCI2EOwK3LuhmDnyhOI++KhKVwpf9vQPfH3VwjtZagmNC3TtaI
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="288350272"
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="288350272"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 23:14:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="744944472"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 02 Aug 2022 23:14:51 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJ7ed-000Gub-0k;
        Wed, 03 Aug 2022 06:14:51 +0000
Date:   Wed, 3 Aug 2022 14:14:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aaron Tomlin <atomlin@redhat.com>, frederic@kernel.org,
        mtosatti@redhat.com
Cc:     kbuild-all@lists.01.org, cl@linux.com, tglx@linutronix.de,
        mingo@kernel.org, peterz@infradead.org, pauld@redhat.com,
        neelx@redhat.com, oleksandr@natalenko.name, atomlin@atomlin.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 2/2] tick/sched: Ensure quiet_vmstat() is called when
 the idle tick was stopped too
Message-ID: <202208031440.kq5bbt4F-lkp@intel.com>
References: <20220801234258.134609-3-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801234258.134609-3-atomlin@redhat.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aaron,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.19 next-20220802]
[cannot apply to tip/timers/nohz]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aaron-Tomlin/tick-sched-Ensure-quiet_vmstat-is-called-when-the-idle-tick-was-stopped-too/20220802-074341
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 9de1f9c8ca5100a02a2e271bdbde36202e251b4b
config: x86_64-randconfig-a013-20220801 (https://download.01.org/0day-ci/archive/20220803/202208031440.kq5bbt4F-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/a0d3b9fe31484c4c44c430d10d0b60e2e0551525
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Aaron-Tomlin/tick-sched-Ensure-quiet_vmstat-is-called-when-the-idle-tick-was-stopped-too/20220802-074341
        git checkout a0d3b9fe31484c4c44c430d10d0b60e2e0551525
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: vmlinux.o: in function `exit_to_user_mode_prepare':
>> common.c:(.text+0x1d4569): undefined reference to `tick_nohz_user_enter_prepare'
>> ld: common.c:(.text+0x1d45df): undefined reference to `tick_nohz_user_enter_prepare'
   ld: common.c:(.text+0x1d460c): undefined reference to `tick_nohz_user_enter_prepare'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
