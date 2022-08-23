Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60FF59E424
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 15:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240228AbiHWNGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 09:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239478AbiHWNGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 09:06:11 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D086644540
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 03:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661249312; x=1692785312;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=40xYcxGbAaCY2yU3+PNRKX05WeMt3NF3HpgfT7YSQ8g=;
  b=An3zOmXvokcUnDjF05v1fmFQYWSUsPUZsN7vbWigkm7g2oI4GxYWQ3dI
   bVrxIw0034OJIVcqbrtqgfkG++sQpHqz66WYdi87+M1C+G4ljB4wGZbHp
   SZpEUwjmHjUZkqCTlv9lnvmYGqUx8VjEZmhjJ4fTV0fSsJIbO5ZJi5JJq
   2g+nLliFIiB0tAiccRF8lLkIOj06hQHuXMv88D0jJ+D2+1PeEiVGQM3qu
   o7ubknPYfN5Zmh3sS/N2DP+eVNBBHDbdjxhmjUGKTct6OoYNT5khi2WoG
   eLtFklS5b6OhAi6tU+r+YUcFNG4LzVRc3AQv1zCIoD6p5g7jiUd4ySCA5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="379936701"
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="379936701"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 03:06:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="560103695"
Received: from lkp-server02.sh.intel.com (HELO 9bbcefcddf9f) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 23 Aug 2022 03:06:53 -0700
Received: from kbuild by 9bbcefcddf9f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQQo3-00008B-1G;
        Tue, 23 Aug 2022 10:06:47 +0000
Date:   Tue, 23 Aug 2022 18:06:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuniyuki Iwashima <kuniyu@amazon.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Christian Brauner <brauner@kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        linux-kernel@vger.kernel.org,
        syzbot+ab17848fe269b573eb71@syzkaller.appspotmail.com,
        Ayushman Dutta <ayudutta@amazon.com>
Subject: Re: [PATCH v2] seccomp: Move copy_seccomp() to no failure path.
Message-ID: <202208231731.jLa4KypR-lkp@intel.com>
References: <20220823004806.38681-1-kuniyu@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823004806.38681-1-kuniyu@amazon.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kuniyuki,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.0-rc2 next-20220823]
[cannot apply to kees/for-next/pstore]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/seccomp-Move-copy_seccomp-to-no-failure-path/20220823-085102
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 072e51356cd5a4a1c12c1020bc054c99b98333df
config: x86_64-randconfig-a002-20220822 (https://download.01.org/0day-ci/archive/20220823/202208231731.jLa4KypR-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f5034318d40caefe1d5445e4ae3db7b632010bb8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kuniyuki-Iwashima/seccomp-Move-copy_seccomp-to-no-failure-path/20220823-085102
        git checkout f5034318d40caefe1d5445e4ae3db7b632010bb8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/fork.c:540:28: error: no member named 'filter' in 'struct seccomp'
           WARN_ON_ONCE(tsk->seccomp.filter);
                        ~~~~~~~~~~~~ ^
   include/asm-generic/bug.h:110:25: note: expanded from macro 'WARN_ON_ONCE'
           int __ret_warn_on = !!(condition);                      \
                                  ^~~~~~~~~
   1 error generated.


vim +540 kernel/fork.c

   537	
   538	void free_task(struct task_struct *tsk)
   539	{
 > 540		WARN_ON_ONCE(tsk->seccomp.filter);
   541		release_user_cpus_ptr(tsk);
   542		scs_release(tsk);
   543	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
