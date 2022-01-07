Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5254878B9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 15:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347602AbiAGOPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 09:15:09 -0500
Received: from mga18.intel.com ([134.134.136.126]:28275 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347612AbiAGOPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 09:15:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641564906; x=1673100906;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QGn+yGeVoCBsRYC4Z0Q2iIHTyTv3rgfF0gDAaX5K5mc=;
  b=LdWzjMD+WfQwBvbcblkD3HNbMNAX6eqs2AAdQg1DZDK78A0InS5dW0Xs
   TzLm2rjvqE6HUyiQGnFTKgbiFy/Yqdn7WrX9rSCirQdC9I3KNP0KbOrIj
   xYdx+0ho5E+U6M23aPj0J+LU/2ual/sVd0BJFpHoN2R7Vp+HEuDoVHS6x
   bBtWVMqG2yk1uvoztR6kv62wbzlF7Lo0jS17pIM4/7cb7aa/iElFWcgcK
   PaGH1XhxOonOl5tgPe2cNLZbK5SuAzN/eqenzX90qmU0CRiELBv/DpU4Z
   qiMkGq7pPO8Uu6KfNpmvaau8LJYi193OK/NQsnEwWpwaSoA0oxFs5T+2u
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="229680740"
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="229680740"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 06:15:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="489297945"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 07 Jan 2022 06:14:59 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5q1C-000Ika-TU; Fri, 07 Jan 2022 14:14:58 +0000
Date:   Fri, 7 Jan 2022 22:14:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hongchen Zhang <zhanghongchen@loongson.cn>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ye Guojin <ye.guojin@zte.com.cn>, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH] signal: strict valid signal check
Message-ID: <202201072220.gCthUkw6-lkp@intel.com>
References: <1641530757-3835-1-git-send-email-zhanghongchen@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1641530757-3835-1-git-send-email-zhanghongchen@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hongchen,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linux/master]
[also build test ERROR on linus/master hnaz-mm/master v5.16-rc8 next-20220106]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Hongchen-Zhang/signal-strict-valid-signal-check/20220107-124756
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 136057256686de39cc3a07c2e39ef6bc43003ff6
config: hexagon-randconfig-r041-20220107 (https://download.01.org/0day-ci/archive/20220107/202201072220.gCthUkw6-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 32167bfe64a4c5dd4eb3f7a58e24f4cba76f5ac2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/d6ab2033eb509bf064e07f58074e58562098dfcc
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Hongchen-Zhang/signal-strict-valid-signal-check/20220107-124756
        git checkout d6ab2033eb509bf064e07f58074e58562098dfcc
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/tty/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/tty/tty_io.c:71:
>> include/linux/signal.h:277:16: error: implicit declaration of function 'min' [-Werror,-Wimplicit-function-declaration]
           return sig <= min(_NSIG, 127) ? 1 : 0;
                         ^
   1 error generated.


vim +/min +277 include/linux/signal.h

   269	
   270	/* Test if 'sig' is valid signal. Use this instead of testing _NSIG directly */
   271	static inline int valid_signal(unsigned long sig)
   272	{
   273		/* max usable signal number is limited by both _NSIG and task's
   274		 * exit_code, and the max available signal number encoded in
   275		 * task's exit_code is 127.
   276		 */
 > 277		return sig <= min(_NSIG, 127) ? 1 : 0;
   278	}
   279	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
