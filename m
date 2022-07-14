Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5062E5749A7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbiGNJvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238098AbiGNJvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:51:23 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319F74BD33
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657792276; x=1689328276;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=X6hreYbVjHvf40p2LuAOzp9Z9aRhDAEm5TxVhK1TaLE=;
  b=MvBsZkD5o19vvdefusFHfuFMjoMNu/FaLIpOlj5ScYZk0LPtOcFsY1f3
   PV0ck0wcUoEFlEDGFgglPubtfvQnmdiXrqi6BK2s7XASJRzVvfBRi0lYo
   ApMcGW2WVHjFZ1zVwfujaNr0/JJzvwIy7lFYRvnIb998Kx9P7CwmrK93b
   OTFnnSa68GLP3Ox23MByONzogylM8scD6f5qsyek6x5gflcyMKtSSd/CF
   mOtYqT2z8d+mDJvEkLF6QT4DaaVdJYo2kOY1YrnHtGdAQDpxuvkRmZOFk
   oaNFFAsdffaZ9v0OM81egSdOUNxjmEly6CAcp+elt/XpTlpS1CDYWwJOW
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="265256147"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="265256147"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 02:51:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="663722834"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 14 Jul 2022 02:51:07 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBvUw-0000PK-Vw;
        Thu, 14 Jul 2022 09:51:06 +0000
Date:   Thu, 14 Jul 2022 17:50:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: module.c:undefined reference to `apply_returns'
Message-ID: <202207141712.n23UKGoF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4a57a8400075bc5287c5c877702c68aeae2a033d
commit: 15e67227c49a57837108acfe1c80570e1bd9f962 x86: Undo return-thunk damage
date:   2 weeks ago
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220714/202207141712.n23UKGoF-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=15e67227c49a57837108acfe1c80570e1bd9f962
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 15e67227c49a57837108acfe1c80570e1bd9f962
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   /usr/bin/ld: arch/x86/um/../kernel/module.o: in function `module_finalize':
>> module.c:(.text+0x23b): undefined reference to `apply_returns'
   collect2: error: ld returned 1 exit status

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
