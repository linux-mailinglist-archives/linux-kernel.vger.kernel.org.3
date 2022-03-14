Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EEB4D7DAC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 09:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237620AbiCNIit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 04:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiCNIiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 04:38:46 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B253C3EF36;
        Mon, 14 Mar 2022 01:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647247056; x=1678783056;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KiIxpXiSc1nrTXbKR7UVVKxgfhqBw+3rTz9+FPtUiMQ=;
  b=KOlnsQV19HCjblGHSsJXCEA9hRWaDyxs5zghSPM46D5P7pXZysutJFi8
   xaGNp0+0BM4goXhAlo25hMLhbvyFe03KVbUkmFZYR+zG3MKozMBth5ud/
   9thi6HadH0pmvXrG99kSHaSGkH/cyi/1s8myVXVYUOe8HSUWLOlPWb8GO
   3Cz2G0+Uqv8X4B8I3jS3BJng9pNyjrYp/trg0V6+EP8mcbFvS5YY7LmeV
   PCd0OOvxfpxo71xTzRGitYPyFU241OsHmDDRf2QVBsooYOn52vGikIrzH
   UXQgIj7Bq/8f7UTXlJdDxoEjaHeH90WsGb8uov6DCvxxp/A7j5rVJVj3C
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="256156217"
X-IronPort-AV: E=Sophos;i="5.90,180,1643702400"; 
   d="scan'208";a="256156217"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 01:37:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,180,1643702400"; 
   d="scan'208";a="597812090"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 14 Mar 2022 01:37:32 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTgCq-0009jV-9o; Mon, 14 Mar 2022 08:37:32 +0000
Date:   Mon, 14 Mar 2022 16:37:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, acme@kernel.org
Cc:     kbuild-all@lists.01.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V3 05/10] perf: Add PERF_BR_NEW_ARCH_[N] map for BRBE on
 arm64 platform
Message-ID: <202203141608.b9LFCtgv-lkp@intel.com>
References: <20220314055857.125421-6-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314055857.125421-6-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.17-rc8]
[cannot apply to tip/perf/core tip/master linux/master next-20220310]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Anshuman-Khandual/perf-Expand-perf_branch_entry/20220314-140231
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 09688c0166e76ce2fb85e86b9d99be8b0084cdf9
config: arm-randconfig-m031-20220314 (https://download.01.org/0day-ci/archive/20220314/202203141608.b9LFCtgv-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/03ab85fbfe308184a6e9ad9039338f722204f2fd
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Anshuman-Khandual/perf-Expand-perf_branch_entry/20220314-140231
        git checkout 03ab85fbfe308184a6e9ad9039338f722204f2fd
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> error: include/uapi/linux/perf_event.h: leak CONFIG_ARM64 to user-space
   make[2]: *** [scripts/Makefile.headersinst:63: usr/include/linux/perf_event.h] Error 1
   make[2]: Target '__headers' not remade because of errors.
   make[1]: *** [Makefile:1277: headers] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
