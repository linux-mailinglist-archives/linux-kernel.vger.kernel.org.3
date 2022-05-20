Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACAD52E65B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 09:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346542AbiETHiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 03:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346535AbiETHiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 03:38:05 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB4314A243;
        Fri, 20 May 2022 00:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653032284; x=1684568284;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rtepu/ruq0EW+A7tbd3HbQbyCoghYdIk0/jAPt0oXFI=;
  b=fef6XOtv5E5nTazsKqMw9Il7Mbxn8eBYQOxuRStl3fXWUOhDKHZxH2rD
   8GfTiS6F43YQL8YahrxHhgkk6UNmbyAZBp3cQYjjbJbcwB7FNfnWj4lcs
   VyMB9UA24MSJxOd3RQff1nX6cvKDblm/2shUC5kNDDagnzA2UgzWADtVg
   AY3b3NfNBz5h1a02M0pEq6GEnIY5mGDruzK3DWWRrW7/vsPI/5IZ4dAeV
   AMC+WFxUQb0ingjMQ/Oe7EXqbcQMBsCK5AN9bmUmKgor1B+LBI3XPu14n
   hMAfVdZhQ0C8zvn1lEqosyf9ohGzFkN4/hoShFCA37ayk/y8CtUL2BL3e
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="254579751"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="254579751"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 00:34:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="743369440"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 20 May 2022 00:34:22 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrx9R-0004Rz-TW;
        Fri, 20 May 2022 07:34:21 +0000
Date:   Fri, 20 May 2022 15:33:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zqiang <qiang1.zhang@intel.com>, paulmck@kernel.org,
        frederic@kernel.org
Cc:     kbuild-all@lists.01.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu-tasks: Stop RCU Tasks scanning tasks which record on
 dyntick-idle entry
Message-ID: <202205201526.INo2g6TS-lkp@intel.com>
References: <20220520045645.1692124-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520045645.1692124-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zqiang,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on paulmck-rcu/dev]
[also build test ERROR on v5.18-rc7 next-20220519]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Zqiang/rcu-tasks-Stop-RCU-Tasks-scanning-tasks-which-record-on-dyntick-idle-entry/20220520-125904
base:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
config: m68k-defconfig (https://download.01.org/0day-ci/archive/20220520/202205201526.INo2g6TS-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/47ee19cf17eefb7dd696eabb583e5dcba4cd89e1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Zqiang/rcu-tasks-Stop-RCU-Tasks-scanning-tasks-which-record-on-dyntick-idle-entry/20220520-125904
        git checkout 47ee19cf17eefb7dd696eabb583e5dcba4cd89e1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/rcu/update.c:606:
   kernel/rcu/tasks.h: In function 'task_is_on_dyntick_idle':
>> kernel/rcu/tasks.h:212:34: error: 'struct task_struct' has no member named 'rcu_tasks_idle_cpu'
     212 |                                 t->rcu_tasks_idle_cpu >= 0;
         |                                  ^~
   At top level:
   kernel/rcu/tasks.h:209:13: warning: 'task_is_on_dyntick_idle' defined but not used [-Wunused-function]
     209 | static bool task_is_on_dyntick_idle(struct task_struct *t)
         |             ^~~~~~~~~~~~~~~~~~~~~~~


vim +212 kernel/rcu/tasks.h

   208	
   209	static bool task_is_on_dyntick_idle(struct task_struct *t)
   210	{
   211		return IS_ENABLED(CONFIG_NO_HZ_FULL) && !is_idle_task(t) &&
 > 212					t->rcu_tasks_idle_cpu >= 0;
   213	}
   214	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
