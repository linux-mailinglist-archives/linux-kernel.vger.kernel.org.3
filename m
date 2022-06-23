Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA310557E20
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 16:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbiFWOsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 10:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbiFWOsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 10:48:47 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE50A4616E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 07:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655995726; x=1687531726;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=a+M6xTI8fcv0XoP4gDaiPmN5PUSrKQKhNoe1i4lIUXU=;
  b=QSmsZTzUl87J27USrTk+IK6UvcE8ODyAwG55vznXdyqkV1DDXnLgn0F9
   L3i2QzdIKmoqe7vugsBNSla+pYYJQ/ghPOxCFGDkOgNMkRjIce+Sb1qNP
   xTu69oYlkdXunfD6D9k8AJdHnRwof/0Aqjtki5aRFUlN0sR3rS0OkrOHB
   FZpygEqrviLoTvyfrZ7JBukoKfUtnb9ORaQuBcWSPMlOd6LVN5Wv72+Jp
   DC+fliKBXGF+23j4mUiyNXSjT2oWJLVZ0Tn7ovlYHpOSIKNBg6GmWgdRr
   4xv+UiNGonzPGqK14fz6bUlRSNhV2s9HAMJ1TfaL2neeLc2J/JVK54Dyt
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="306198388"
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="306198388"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 07:48:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="588645360"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 23 Jun 2022 07:48:45 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4O8S-0001QH-Lz;
        Thu, 23 Jun 2022 14:48:44 +0000
Date:   Thu, 23 Jun 2022 22:48:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/tramp_11 19/21] kernel/bpf/trampoline.c:81:17:
 warning: address of stack memory associated with parameter 'id' returned
Message-ID: <202206232231.u4YhpRYy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/tramp_11
head:   c807110aa605281263da02a78af57847f5c4275e
commit: a2660a85cc98b2db2577fd844985884cff0e5cae [19/21] bpf: Add support to store multiple ids in bpf_tramp_id object
config: i386-randconfig-a015 (https://download.01.org/0day-ci/archive/20220623/202206232231.u4YhpRYy-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 46be5faaf03466c3751f8a2882bef5a217e15926)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=a2660a85cc98b2db2577fd844985884cff0e5cae
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/tramp_11
        git checkout a2660a85cc98b2db2577fd844985884cff0e5cae
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/bpf/trampoline.c:81:17: warning: address of stack memory associated with parameter 'id' returned [-Wreturn-stack-address]
                   return (u64) &id;
                                 ^~
   1 warning generated.


vim +/id +81 kernel/bpf/trampoline.c

    77	
    78	static u64 bpf_tramp_id_key(struct bpf_tramp_id *id)
    79	{
    80		if (bpf_tramp_id_is_multi(id))
  > 81			return (u64) &id;
    82		else
    83			return ((u64) id->obj_id << 32) | id->id[0];
    84	}
    85	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
