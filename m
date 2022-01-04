Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C831484069
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 12:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbiADLBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 06:01:49 -0500
Received: from mga14.intel.com ([192.55.52.115]:30087 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231877AbiADLBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 06:01:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641294108; x=1672830108;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7+XfuoTK3vv/uNsp+5tdOS8M8eM+zNrH/yUGmDfkkCA=;
  b=SCfb5ckc15CcurEFHDaEbX++FtTgMJdO2JCPU/863fYAdtFfmaN9ravW
   tG4/Eb29Y7a+/ITXvmixWlT0BKA0ovY/faIMkTIu+/7SWaHE4BEAbfHXT
   pV1X5sRNTG/zJUYLbne6sz8Z/FlfEmxhaWlyHLddhBkZxQDBv8oWkjwZ5
   ZiFI8lHnXCEpVmb/az2d4y7CYM9mf7tPUt4Q+DNCPPY1gZnFeEnVW/vrZ
   kDIqB7YEDVF6AV7L/KgMCWIETXFy3Lp8yZ+7nhfCtVOfZGqMB5hLh/da9
   q41jk8Q6iPXqHu4+A3pH4X7JxtZgU5cYZ3/XQnLo+EYYMsbOl40vqSyRd
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="242411595"
X-IronPort-AV: E=Sophos;i="5.88,260,1635231600"; 
   d="scan'208";a="242411595"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 03:01:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,260,1635231600"; 
   d="scan'208";a="620609387"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 04 Jan 2022 03:01:46 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n4hZZ-000FEW-Ep; Tue, 04 Jan 2022 11:01:45 +0000
Date:   Tue, 4 Jan 2022 19:00:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>
Cc:     kbuild-all@lists.01.org, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] module: add in-kernel support for decompressing
Message-ID: <202201041811.tEtjVHGi-lkp@intel.com>
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

I love your patch! Yet something to improve:

[auto build test ERROR on kees/for-next/pstore]
[also build test ERROR on linus/master jeyu/modules-next v5.16-rc8 next-20211224]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Dmitry-Torokhov/module-add-in-kernel-support-for-decompressing/20220104-133017
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/pstore
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20220104/202201041811.tEtjVHGi-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/dee0e9ca58491575033bc7911dd4fe8f7cea40e4
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Dmitry-Torokhov/module-add-in-kernel-support-for-decompressing/20220104-133017
        git checkout dee0e9ca58491575033bc7911dd4fe8f7cea40e4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   m68k-linux-ld: kernel/module_signing.o: in function `module_decompress':
>> module_signing.c:(.text+0x0): multiple definition of `module_decompress'; kernel/module.o:(.text+0x3280): first defined here
   m68k-linux-ld: kernel/module_signing.o: in function `module_decompress_cleanup':
>> module_signing.c:(.text+0x40): multiple definition of `module_decompress_cleanup'; kernel/module.o:(.text+0x32c0): first defined here

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
