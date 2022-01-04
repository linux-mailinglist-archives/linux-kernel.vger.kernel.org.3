Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E7D483EE0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 10:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiADJJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 04:09:45 -0500
Received: from mga18.intel.com ([134.134.136.126]:35841 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229650AbiADJJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 04:09:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641287384; x=1672823384;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Th+inFVG54Ia8AqsQkCMNngyTxRszwXkT5RY6W+AcX0=;
  b=brYzBxF63nLz9BW+4sOU+ze0qnb36Kyho1Vvbjqctx/97afz+cNORFwe
   TSpyS6+mv77p15tad19m1D1vWeCMPqeRtk+nbnkx1I/3412BXIZ2vHb95
   b6GQ0EoQHpyGfOlxocbtrdeszGaCEPoNMO1AgGP/zAJTScOi3ovvj3O7R
   epXS9Sg69WKctZU21YKWalN3EkjhaHRXCZAm963noeZHlgXtfDoSt72xg
   ShZ2HRR+x7uTGfYT2f0rvHoB9R6sRVJF80kYfgsc0PY0ImXHCCvtLq9+m
   v4N/uv25xOeVafwiqjdW2DyPfcmICrRYKCTvHEb5J3Tf1THVd31J8HIPo
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="229008496"
X-IronPort-AV: E=Sophos;i="5.88,260,1635231600"; 
   d="scan'208";a="229008496"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 01:09:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,260,1635231600"; 
   d="scan'208";a="620580451"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 04 Jan 2022 01:09:41 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n4fp7-000F8l-0a; Tue, 04 Jan 2022 09:09:41 +0000
Date:   Tue, 4 Jan 2022 17:08:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>
Cc:     kbuild-all@lists.01.org, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] module: add in-kernel support for decompressing
Message-ID: <202201041739.pqEpumnU-lkp@intel.com>
References: <YdPa+w0xYkXXEE9s@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdPa+w0xYkXXEE9s@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

I love your patch! Perhaps something to improve:

[auto build test WARNING on kees/for-next/pstore]
[also build test WARNING on linus/master jeyu/modules-next v5.16-rc8 next-20211224]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Dmitry-Torokhov/module-add-in-kernel-support-for-decompressing/20220104-133017
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/pstore
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220104/202201041739.pqEpumnU-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/dee0e9ca58491575033bc7911dd4fe8f7cea40e4
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Dmitry-Torokhov/module-add-in-kernel-support-for-decompressing/20220104-133017
        git checkout dee0e9ca58491575033bc7911dd4fe8f7cea40e4
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from kernel/module.c:61:
>> kernel/module-internal.h:42:5: warning: no previous prototype for 'module_decompress' [-Wmissing-prototypes]
      42 | int module_decompress(struct load_info *info, const void *buf, size_t size)
         |     ^~~~~~~~~~~~~~~~~
>> kernel/module-internal.h:46:6: warning: no previous prototype for 'module_decompress_cleanup' [-Wmissing-prototypes]
      46 | void module_decompress_cleanup(struct load_info *info)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/module_decompress +42 kernel/module-internal.h

    37	
    38	#ifdef CONFIG_MODULE_DECOMPRESS
    39	int module_decompress(struct load_info *info, const void *buf, size_t size);
    40	void module_decompress_cleanup(struct load_info *info);
    41	#else
  > 42	int module_decompress(struct load_info *info, const void *buf, size_t size)
    43	{
    44		return -EOPNOTSUPP;
    45	}
  > 46	void module_decompress_cleanup(struct load_info *info)

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
