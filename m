Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4B04D1D9B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237028AbiCHQno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348762AbiCHQnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:43:04 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F89351E7D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646757718; x=1678293718;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gxzLS3gy5LU7YpYO+WjqIpkupjHeEsFeLiAdD0l+l5w=;
  b=PqLyBdziZ2ct6KqiuqM4stG5IGJOTbDfmHnpnJK95JrQouZLBN3YIF31
   x+jALR+WW0+9gYER3RCHkAXXT/J6gzmrugeqWCjV35EIIb/w0pnzXjyKu
   5NwSyEd/0+nlYbYHuOUYFBksyF7jrnU+cnZ+CY2OCqdM42hcUmKtk+w3f
   +kwmhExCbPjQaMJ3NCHRzSGZ2yc1O0E1G6upsFKaXRfEmK0zoR0b6ly4U
   LHNbMDoyhBwLFFr5UCfB7fFD/1vGNg8+G4sZhLPlpuw/2dLSU3nklJO+p
   0ygSeRIahm30wgImxsr2zq2QRt/2FkfuUCbASwALnw+soQUWXbPMziQCF
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="341165977"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="341165977"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 08:41:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="513172086"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 08 Mar 2022 08:41:33 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRctw-0001ix-FE; Tue, 08 Mar 2022 16:41:32 +0000
Date:   Wed, 9 Mar 2022 00:41:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-5.4
 4028/9999] drivers/dma-buf/heaps/deferred-free-helper.c:23:19: sparse:
 sparse: symbol 'freelist_waitqueue' was not declared. Should it be static?
Message-ID: <202203090021.OvfMJum5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

First bad commit (maybe != root cause):

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-5.4
head:   8a3679a75730c1babde6bf63e35d227f3305bd90
commit: e3919bfeb0066ab9b5f9765e5610b95672990e64 [4028/9999] ANDROID: dma-buf: system_heap: Add deferred freeing to the system heap
config: x86_64-randconfig-s021-20220307 (https://download.01.org/0day-ci/archive/20220309/202203090021.OvfMJum5-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/e3919bfeb0066ab9b5f9765e5610b95672990e64
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-5.4
        git checkout e3919bfeb0066ab9b5f9765e5610b95672990e64
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/dma-buf/heaps/ init/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/dma-buf/heaps/deferred-free-helper.c:23:19: sparse: sparse: symbol 'freelist_waitqueue' was not declared. Should it be static?
>> drivers/dma-buf/heaps/deferred-free-helper.c:24:20: sparse: sparse: symbol 'freelist_task' was not declared. Should it be static?

vim +/freelist_waitqueue +23 drivers/dma-buf/heaps/deferred-free-helper.c

bd1639945c30298 John Stultz 2020-12-09  20  
bd1639945c30298 John Stultz 2020-12-09  21  static LIST_HEAD(free_list);
bd1639945c30298 John Stultz 2020-12-09  22  static size_t list_nr_pages;
bd1639945c30298 John Stultz 2020-12-09 @23  wait_queue_head_t freelist_waitqueue;
bd1639945c30298 John Stultz 2020-12-09 @24  struct task_struct *freelist_task;
bd1639945c30298 John Stultz 2020-12-09  25  static DEFINE_SPINLOCK(free_list_lock);
bd1639945c30298 John Stultz 2020-12-09  26  

:::::: The code at line 23 was first introduced by commit
:::::: bd1639945c30298e4bea2b611d6b0cd08d3cdd98 ANDROID: dma-buf: heaps: Add deferred-free-helper library code

:::::: TO: John Stultz <john.stultz@linaro.org>
:::::: CC: John Stultz <john.stultz@linaro.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
