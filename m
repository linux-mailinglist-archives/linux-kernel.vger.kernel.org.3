Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1437451E963
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 21:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446836AbiEGTVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 15:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiEGTUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 15:20:54 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D392B1BC
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 12:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651951027; x=1683487027;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=x32iCAAS+BpjT0CIy9XvnliIpXMVAbwNO7q8HRMOPbk=;
  b=mbUvW4pNgPI627XfHqUR/Fqkhh9IHNsw03NJsMcIgep60c/PGqPoHMrG
   Aw3oGXxE5tJfxIRL9foMAuuHOUC3tFtV+qHjUS65/dtmCr1rKhhiJoLIS
   pf8dm5TEba8jA5Hs3U3wb43y1G8W8hAQ1voGvuyt0TW9ILSCruVEYXVyK
   5loM++TF93997N1Nb1bxq07lHrYSr9i8jmW4pX3ADfIgOk6p5FbstuyQH
   X0N1MYhxohrJEPBj34n3hw3oncy+ha6+VCQSt/YL2AmDeg5NPNV+Q3aTg
   wqMLzYWZASXxgUvPvBkQefJaVehDRyp7ngDhgUQtCZq3fjsu8+FS5oQBG
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10340"; a="249279790"
X-IronPort-AV: E=Sophos;i="5.91,207,1647327600"; 
   d="scan'208";a="249279790"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2022 12:17:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,207,1647327600"; 
   d="scan'208";a="538409860"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 07 May 2022 12:17:06 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nnPvN-000EtX-Bl;
        Sat, 07 May 2022 19:17:05 +0000
Date:   Sun, 8 May 2022 03:16:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:objtool/core 29/30] vmlinux.o: warning: objtool:
 enter_from_user_mode+0x61: call to task_stack_page() leaves .noinstr.text
 section
Message-ID: <202205080306.4EAdgsdm-lkp@intel.com>
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
head:   800d7a995ef68c19a467b612d83fe302138df62e
commit: f8ce83e69bde4cd934b768ae569445fb0781905f [29/30] x86: Always inline on_thread_stack() and current_top_of_stack()
config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20220508/202205080306.4EAdgsdm-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=f8ce83e69bde4cd934b768ae569445fb0781905f
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue objtool/core
        git checkout f8ce83e69bde4cd934b768ae569445fb0781905f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: enter_from_user_mode+0x61: call to task_stack_page() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: syscall_enter_from_user_mode+0x6e: call to task_stack_page() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0x61: call to task_stack_page() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0x61: call to task_stack_page() leaves .noinstr.text section

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
