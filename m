Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7916A4FED4F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 05:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiDMDHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 23:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbiDMDHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 23:07:02 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA7B56221
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 20:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649819075; x=1681355075;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+vRyKL7wFUME5O1rDWrPY2YoN3Duc/RqdXFsNqce0kI=;
  b=NifFBzNsnOTePH6Vv1Gc7g0igr1evBuQK9QkK4rSawMV0NtToeuiZKex
   BXj/OMEX+O04RyF0fmEKVmn6cR8JMscO1JVaUsp+MfqwrIKmHtvVUWqzA
   mcaQKUqKPFF0UtDne4rbOejZLJakcrOr8xHVNl1W5BM7bpTpWyNTgGdYt
   cYuKaJ1er9V9PsCyvYteTGSFn+lP6Vg4udjGdDCBNHz2UnWGyjSzxo4pn
   jG7Hz/GvvaNFf1650luZGVQFFL+j8tbGzlPKQ5uGfa8mhIJsmQ5OW1UHi
   xIfv114Mr71euXx2hndTGcTVwoSP4v5BRCGJneZh17W6rmbeoaJsRJRPP
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="249846723"
X-IronPort-AV: E=Sophos;i="5.90,255,1643702400"; 
   d="scan'208";a="249846723"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 20:04:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,255,1643702400"; 
   d="scan'208";a="559584553"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 12 Apr 2022 20:04:29 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neTIz-0003OK-7Y;
        Wed, 13 Apr 2022 03:04:29 +0000
Date:   Wed, 13 Apr 2022 11:03:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mark:stacktrace/testing 1/1] ERROR: modpost:
 ".stack_trace_save_tsk_reliable" [lib/test_stacktrace/test_stacktrace.ko]
 undefined!
Message-ID: <202204131117.cGGwO7Ul-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git stacktrace/testing
head:   a8e8825116626f8c3e8be3bb889b6442a7465cb8
commit: a8e8825116626f8c3e8be3bb889b6442a7465cb8 [1/1] WIP: stacktrace tests
config: powerpc64-buildonly-randconfig-r005-20220412 (https://download.01.org/0day-ci/archive/20220413/202204131117.cGGwO7Ul-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=a8e8825116626f8c3e8be3bb889b6442a7465cb8
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark stacktrace/testing
        git checkout a8e8825116626f8c3e8be3bb889b6442a7465cb8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: missing MODULE_LICENSE() in drivers/iio/afe/iio-rescale.o
ERROR: modpost: ".kallsyms_lookup_size_offset" [lib/test_stacktrace/test_stacktrace.ko] undefined!
>> ERROR: modpost: ".stack_trace_save_tsk_reliable" [lib/test_stacktrace/test_stacktrace.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
