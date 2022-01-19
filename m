Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72161493B7E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 14:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354938AbiASNzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 08:55:31 -0500
Received: from mga01.intel.com ([192.55.52.88]:52535 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354896AbiASNza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 08:55:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642600530; x=1674136530;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jJdu8bfBssb1Sxa25PfZW1bRYo2nN5kcy6RTFVeBC0U=;
  b=XGi3o7bWw572hJ9Xf6fh6QTdV9ZUg5FnKm+dKfLXxVgxyTeQt6VvjrKs
   TWcZos4FMqekkISz0yjhK0au3w+f+qjSfs4SuEu2qP1Y3A5aCkOTkdNfo
   gyipG9OgF2ksbs+j5T+VUB0y744JjAb9xQffmGTQCFuLrotePqJ2LRhdK
   beROrVOg9LsvSR5KCNtCL712Nl27JzzkwIMCn1s8ii1mQoHw/BCFDYqzO
   5lUKIp0v5X+YEHTHYIKPfVT1EczQSUp1ahiPFv/1vHfTfH4j+oNY+PeXj
   Czp4r+XNeDPoqky50ssl8C3+w98UEghN2McEJBWlRjOY8xwvxwDgqGtMQ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="269460716"
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="269460716"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 05:55:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="625890904"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 19 Jan 2022 05:55:28 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nABQt-000DYB-RL; Wed, 19 Jan 2022 13:55:27 +0000
Date:   Wed, 19 Jan 2022 21:54:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: drivers/block/aoe/aoenet.c:42:9: warning: 'strncpy' specified bound
 1024 equals destination size
Message-ID: <202201192107.YpjbsasI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1d1df41c5a33359a00e919d54eaebfb789711fdc
commit: dd03762ab608e058c8f390ad9cf667e490089796 arm64: Enable KCSAN
date:   5 weeks ago
config: arm64-randconfig-r026-20220119 (https://download.01.org/0day-ci/archive/20220119/202201192107.YpjbsasI-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dd03762ab608e058c8f390ad9cf667e490089796
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout dd03762ab608e058c8f390ad9cf667e490089796
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/block/aoe/aoenet.c: In function 'aoe_iflist_setup':
>> drivers/block/aoe/aoenet.c:42:9: warning: 'strncpy' specified bound 1024 equals destination size [-Wstringop-truncation]
      42 |         strncpy(aoe_iflist, str, IFLISTSZ);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/strncpy +42 drivers/block/aoe/aoenet.c

eb086ec59667df Ed L. Cashin 2012-10-04  38  
03c41c434775c5 Ed L. Cashin 2005-04-29  39  #ifndef MODULE
03c41c434775c5 Ed L. Cashin 2005-04-29  40  static int __init aoe_iflist_setup(char *str)
03c41c434775c5 Ed L. Cashin 2005-04-29  41  {
03c41c434775c5 Ed L. Cashin 2005-04-29 @42  	strncpy(aoe_iflist, str, IFLISTSZ);
03c41c434775c5 Ed L. Cashin 2005-04-29  43  	aoe_iflist[IFLISTSZ - 1] = '\0';
03c41c434775c5 Ed L. Cashin 2005-04-29  44  	return 1;
03c41c434775c5 Ed L. Cashin 2005-04-29  45  }
03c41c434775c5 Ed L. Cashin 2005-04-29  46  

:::::: The code at line 42 was first introduced by commit
:::::: 03c41c434775c52092d17a5031ad8ebaaf555bc4 [PATCH] aoe: improve allowed interfaces configuration

:::::: TO: Ed L Cashin <ecashin@coraid.com>
:::::: CC: Greg KH <gregkh@suse.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
