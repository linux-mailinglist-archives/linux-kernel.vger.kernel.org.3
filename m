Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2214554A8BB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 07:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239943AbiFNF10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 01:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiFNF1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 01:27:19 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B4027176;
        Mon, 13 Jun 2022 22:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655184437; x=1686720437;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3R/m9ZYiDMw+eVKxVZcWQRpsASUlvIbz8hBNCg/KPZ4=;
  b=goX9ySWdiv3Ci3aSIvhQScIiodCA5feTrcH6RurK+RWqMFS3znQUUgsx
   +5xTQE+hwtn3JRz17B2jVAlOzLEyFuvvgOGe5vFQ8qRY+21Trd7YOU/5N
   3FMxZAAvP9UU3gI0Z28M6XoHeK0UmzdUggso6obGkKr6jyb1QTHgti5m4
   Ht+534kW2VfIYDBh4kW4L2TgSULYJvjT+hQ6EI0sqgyB+7SUKQ8XgCcXC
   SC/EChPHeaF2OvSRpbUc0ytny0hQxJFosMuEOyEjTOfEDevKCLCazjm9S
   bbPt7kBlGiIoRxi4Sx48yJZt+L0xWx+IQZWg28/BoqkRTfUaAtDHF372H
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="258341116"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="258341116"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 22:27:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="712326117"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 13 Jun 2022 22:27:15 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0z58-000LW1-Bz;
        Tue, 14 Jun 2022 05:27:14 +0000
Date:   Tue, 14 Jun 2022 13:27:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Micah Morton <mortonm@chromium.org>,
        linux-security-module@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        keescook@chromium.org, jmorris@namei.org, serge@hallyn.com,
        linux-kernel@vger.kernel.org, Micah Morton <mortonm@chromium.org>
Subject: Re: [PATCH 1/2] security: Add LSM hook to setgroups() syscall
Message-ID: <202206141343.mSI8gmLO-lkp@intel.com>
References: <20220613202807.447694-1-mortonm@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613202807.447694-1-mortonm@chromium.org>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Micah,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on kees/for-next/pstore v5.19-rc2 next-20220610]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Micah-Morton/security-Add-LSM-hook-to-setgroups-syscall/20220614-050341
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3
config: hexagon-randconfig-r045-20220613 (https://download.01.org/0day-ci/archive/20220614/202206141343.mSI8gmLO-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c97436f8b6e2718286e8496faf53a2c800e281cf)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b21cba6f759a2a60439de4d0f85323ed745b3ade
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Micah-Morton/security-Add-LSM-hook-to-setgroups-syscall/20220614-050341
        git checkout b21cba6f759a2a60439de4d0f85323ed745b3ade
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/groups.c:143:6: error: assigning to 'struct cred *' from 'typeof (*((__current_thread_info->task)->cred)) *' (aka 'const struct cred *') discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           old = current_cred();
               ^ ~~~~~~~~~~~~~~
>> kernel/groups.c:147:2: error: use of undeclared identifier 'retval'
           retval = security_task_fix_setgroups(new, old);
           ^
   kernel/groups.c:148:6: error: use of undeclared identifier 'retval'
           if (retval < 0)
               ^
   kernel/groups.c:155:9: error: use of undeclared identifier 'retval'
           return retval;
                  ^
   4 errors generated.


vim +143 kernel/groups.c

   126	
   127	/**
   128	 * set_current_groups - Change current's group subscription
   129	 * @group_info: The group list to impose
   130	 *
   131	 * Validate a group subscription and, if valid, impose it upon current's task
   132	 * security record.
   133	 */
   134	int set_current_groups(struct group_info *group_info)
   135	{
   136		struct cred *new;
   137		struct cred *old;
   138	
   139		new = prepare_creds();
   140		if (!new)
   141			return -ENOMEM;
   142	
 > 143		old = current_cred();
   144	
   145		set_groups(new, group_info);
   146	
 > 147		retval = security_task_fix_setgroups(new, old);
   148		if (retval < 0)
   149			goto error;
   150	
   151		return commit_creds(new);
   152	
   153	error:
   154		abort_creds(new);
   155		return retval;
   156	}
   157	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
