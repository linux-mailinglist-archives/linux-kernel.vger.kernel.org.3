Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3721551E377
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 04:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445338AbiEGCLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 22:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444001AbiEGCLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 22:11:12 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565A6712CE
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 19:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651889247; x=1683425247;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zVRxbeZDh90L1tFtgjPeb/LFPCLM+gmbkakcvqNbHeY=;
  b=hZ5IpydSUTcZVv/bKRLWrwk/uMmAWeDplZ33VLFM4xoCHEcc0GFRPd98
   MJ+7eR7zu/e/y4UREjB20/xdxZy+Yx/H1INlyVX0MbNjZJtNrZhOD9Ly1
   Wm9/CLDwIZqlyEDM/2z0vwKowq8xjFZfW2yWU1UUjOfXmmTg6Vmrsl5SY
   /FgiZBBbhIFnbdzF3lCH/o1kK2g54TvR8VfW0hz53h7hUY2klJYRJWVjD
   K+bpjLjJPumE1wHhesLsyihbwHKyNIf+nVMs2LwyM/N1R6wfRz8aYI4Jc
   emUSc0oowQ8IIbsYscfpqbzXt+MxG5X90MbZ9Pr++V80AivjtCHK8et/b
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="267469581"
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="267469581"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 19:07:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="633203158"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 06 May 2022 19:07:26 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nn9qu-000E70-Qv;
        Sat, 07 May 2022 02:07:24 +0000
Date:   Sat, 7 May 2022 10:07:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:objtool/core 27/28] vmlinux.o: warning: objtool:
 enter_from_user_mode+0x4e: call to on_thread_stack() leaves .noinstr.text
 section
Message-ID: <202205070939.aHPp3lal-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git objtool/core
head:   0c477702d82da35bdf3b944cb844829fdfac2a53
commit: 0c1ce224210235e8a51495014a2a6c9a020d24f0 [27/28] x86/cpu: Elide KCSAN for cpu_has() and friends
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220507/202205070939.aHPp3lal-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=0c1ce224210235e8a51495014a2a6c9a020d24f0
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue objtool/core
        git checkout 0c1ce224210235e8a51495014a2a6c9a020d24f0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: enter_from_user_mode+0x4e: call to on_thread_stack() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: syscall_enter_from_user_mode+0x53: call to on_thread_stack() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0x4e: call to on_thread_stack() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0x4e: call to on_thread_stack() leaves .noinstr.text section

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
