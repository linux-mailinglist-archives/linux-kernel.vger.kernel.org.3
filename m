Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11517507EB7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 04:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358883AbiDTCQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 22:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiDTCQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 22:16:39 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B13C289BC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 19:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650420835; x=1681956835;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8r0tP4tVUtTNBiRI7kELiBfkISrTH3l3zHHdmYedFNY=;
  b=M5BzQLvYpOICoVuw9HSaTa6csL98AtV1RoFdWnv4wjm7Fa3UuFHLNyy4
   MOWm49HC23seOPajvaN30tRKR7LQTZI0soxif5FDznQvTpaUGkmiEGU8y
   P9yQH7FBGgJ3valNWH1a7Q/68n+fID9K43NhQq4yhyJCOjuy/NqGzqwLi
   btOi65BfypWOVI54djcuaQHnnGeTLR7O8I8Qz98/Ev5tlhMdo0jfQt38a
   uqEUGNYUc2oPvvya1JjiOl9h4dmSKOPYbhixS2SCgre6wnjqE4KviHH30
   8GGVe+6kKfC5HLHvleZnGTByfGJjZZ+MlfqeLEp+ZtrRUcSqIh7cV9cBS
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="245811969"
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="245811969"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 19:13:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="529550215"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 19 Apr 2022 19:13:53 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngzqq-0006SD-HG;
        Wed, 20 Apr 2022 02:13:52 +0000
Date:   Wed, 20 Apr 2022 10:13:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Cc:     kbuild-all@lists.01.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v3 14/15] printk: extend console_lock for proper
 kthread support
Message-ID: <202204201041.ZwRzv18o-lkp@intel.com>
References: <20220419234637.357112-15-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419234637.357112-15-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

I love your patch! Perhaps something to improve:

[auto build test WARNING on 84d7df104dbab9c3dda8f2c5b46f9a6fc256fe02]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Ogness/printk-for-next/20220420-080725
base:   84d7df104dbab9c3dda8f2c5b46f9a6fc256fe02
config: openrisc-randconfig-r022-20220419 (https://download.01.org/0day-ci/archive/20220420/202204201041.ZwRzv18o-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/5139c5b347088e124f3812a3fa63eb284b14f2dc
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review John-Ogness/printk-for-next/20220420-080725
        git checkout 5139c5b347088e124f3812a3fa63eb284b14f2dc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=openrisc SHELL=/bin/bash kernel/printk/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/printk/printk.c:2703:6: warning: no previous prototype for 'console_lock_single_hold' [-Wmissing-prototypes]
    2703 | void console_lock_single_hold(struct console *con)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/console_lock_single_hold +2703 kernel/printk/printk.c

  2697	
  2698	/*
  2699	 * Lock the console_lock, but rather than blocking all the kthread printers,
  2700	 * lock a specified kthread printer and hold the lock. This is useful if
  2701	 * console flags for a particular console need to be updated.
  2702	 */
> 2703	void console_lock_single_hold(struct console *con)
  2704	{
  2705		might_sleep();
  2706		down_console_sem();
  2707		mutex_lock(&con->lock);
  2708		console_locked = 1;
  2709		console_may_schedule = 1;
  2710	}
  2711	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
