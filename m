Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781814FBCBE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 15:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346342AbiDKNH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 09:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346336AbiDKNHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 09:07:24 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6803812AAC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 06:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649682310; x=1681218310;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3EYCtu7I/YXMAq1JWVo59c6vq4WBdg1M5OL4/HmSekQ=;
  b=QBkE0kXkS7hF2r07guhXfBfi9gV0Lrp3BkyV5OpqIahk2/holsDT7up9
   MIBi2bxi6lh2+X6Q7REin2Q94rlcfknL4cb9ML5OmvcVIXqOg5qlZ8NCT
   UcmpAQFZX5jWjENYxT2Z8+BM589R12l/ObrcN57TmUWKc+kFyXPVVoXqR
   TheDvE+9uFe5BS86di9UwD9z4WabYSCumKwM2nEdZ8m7efRNyHW4yPWXr
   Izuwg6e4fJtVAIuEPjUItv8TBTHh9zTd/ar2Z+GHlAxSah5E0rhV9o7Xj
   cBGPjsM3pvKXeWg49jraWestghLV9kBCMu11pP5nnijgShHFATLEQ/4cX
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="260957180"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="260957180"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 06:05:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="525970233"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 11 Apr 2022 06:05:08 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndtj9-0001rb-So;
        Mon, 11 Apr 2022 13:05:07 +0000
Date:   Mon, 11 Apr 2022 21:04:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: vmlinux.o: warning: objtool: __fentry__()+0x8c: call without frame
 pointer save/setup
Message-ID: <202204112113.ys4DIvVl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e
commit: ed53a0d971926e484d86cce617ec02a7ee85c3fe x86/alternative: Use .ibt_endbr_seal to seal indirect calls
date:   4 weeks ago
config: x86_64-randconfig-r022-20220411 (https://download.01.org/0day-ci/archive/20220411/202204112113.ys4DIvVl-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ed53a0d971926e484d86cce617ec02a7ee85c3fe
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ed53a0d971926e484d86cce617ec02a7ee85c3fe
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: ibt_selftest()+0x11: sibling call from callable instruction with modified stack frame
>> vmlinux.o: warning: objtool: __fentry__()+0x8c: call without frame pointer save/setup
   vmlinux.o: warning: objtool: do_syscall_64()+0x10: call to static_key_count.constprop.0() leaves .noinstr.text section
   vmlinux.o: warning: objtool: mce_start()+0x3d: call to __kcsan_check_access() leaves .noinstr.text section
   vmlinux.o: warning: objtool: mce_gather_info()+0x3f: call to v8086_mode.constprop.0() leaves .noinstr.text section
   vmlinux.o: warning: objtool: mce_read_aux()+0xe4: call to mca_msr_reg() leaves .noinstr.text section
   vmlinux.o: warning: objtool: do_machine_check()+0xab: call to mce_no_way_out() leaves .noinstr.text section
   vmlinux.o: warning: objtool: mce_severity_amd.constprop.0()+0x45: call to mce_severity_amd_smca() leaves .noinstr.text section
   vmlinux.o: warning: objtool: enter_from_user_mode()+0x1d: call to test_bit() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode()+0x21: call to test_bit() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare()+0x1d: call to test_bit() leaves .noinstr.text section
   vmlinux.o: warning: objtool: exit_to_user_mode()+0x1f: call to static_key_count() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_exit_to_user_mode()+0x38: call to static_key_count() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_enter_from_user_mode()+0x1d: call to test_bit() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_exit_to_user_mode()+0x26: call to static_key_count() leaves .noinstr.text section
   vmlinux.o: warning: objtool: ibt_selftest()+0x1e: return with modified stack frame

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
