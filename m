Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F2C4C516A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 23:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237173AbiBYWTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 17:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiBYWTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 17:19:03 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8773FCFBAC
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 14:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645827509; x=1677363509;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z0t6umZFSsFQi800PuhFPF3XXD6xv7GQd81Q9Rk0qK0=;
  b=dwR6gkttQfDjMkkpLxqHjtdbXgAiavrJO8LlDGgMqvvflHgbF2Fuztua
   RgNLu2xfNDD5qnAjtlESr8Cb2YGJ/veh4nXVG39BV44RnelnXTe5AbAEv
   efb3LsKfHZ0qfyQzVXzG/njjdSeyTRSasUS26hF60sp/xnpvs1DORh5/9
   XOdXyTNSvrVe/L4LhmI1fydvtvTQKsL+uI5D/2FCaoMNMdxCUFiulSm/F
   ami5dXun701/k6cIi+rBFE4xd93oQdSV8wUgtAmDzJ3pH9JhlcvTBtHCh
   PuliLNp6BsANgmLCdHDgdkD2RmSf7GeDyWM66NkvfCNzqhHzhEq5e3F0J
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10269"; a="252786632"
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; 
   d="scan'208";a="252786632"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 14:18:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; 
   d="scan'208";a="492107723"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 25 Feb 2022 14:18:26 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNiuv-0004mD-NC; Fri, 25 Feb 2022 22:18:25 +0000
Date:   Sat, 26 Feb 2022 06:18:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Cheng <michael.cheng@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, willy@infradead.org,
        michael.cheng@intel.com, casey.g.bowman@intel.com,
        lucas.demarchi@intel.com, wayne.boyer@intel.com,
        tvrtko.ursulin@linux.intel.com, matthew.d.roper@intel.com,
        geert@linux-m68k.org
Subject: Re: [PATCH v1] Add struct folio to cacheflush.h
Message-ID: <202202260658.uzJ0YnVP-lkp@intel.com>
References: <20220225201248.984169-1-michael.cheng@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225201248.984169-1-michael.cheng@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linux/master]
[also build test ERROR on linus/master v5.17-rc5 next-20220224]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Michael-Cheng/Add-struct-folio-to-cacheflush-h/20220226-041442
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 2c271fe77d52a0555161926c232cd5bc07178b39
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220226/202202260658.uzJ0YnVP-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/f519440dbde207a6ade2472cd2e6c32028923342
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Michael-Cheng/Add-struct-folio-to-cacheflush-h/20220226-041442
        git checkout f519440dbde207a6ade2472cd2e6c32028923342
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld: block/bfq-wf2q.o:(.bss+0x0): multiple definition of `folio'; block/bfq-iosched.o:(.bss+0x0): first defined here
   ld: block/bfq-cgroup.o:(.bss+0x0): multiple definition of `folio'; block/bfq-iosched.o:(.bss+0x0): first defined here
--
>> ld: fs/isofs/inode.o:(.bss+0x0): multiple definition of `folio'; fs/isofs/namei.o:(.bss+0x0): first defined here
   ld: fs/isofs/dir.o:(.bss+0x0): multiple definition of `folio'; fs/isofs/namei.o:(.bss+0x0): first defined here
   ld: fs/isofs/util.o:(.bss+0x0): multiple definition of `folio'; fs/isofs/namei.o:(.bss+0x0): first defined here
   ld: fs/isofs/rock.o:(.bss+0x0): multiple definition of `folio'; fs/isofs/namei.o:(.bss+0x0): first defined here
   ld: fs/isofs/export.o:(.bss+0x0): multiple definition of `folio'; fs/isofs/namei.o:(.bss+0x0): first defined here
   ld: fs/isofs/joliet.o:(.bss+0x0): multiple definition of `folio'; fs/isofs/namei.o:(.bss+0x0): first defined here

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
