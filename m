Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB9F50C894
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 11:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbiDWJd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 05:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbiDWJdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 05:33:18 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69A6C8BE5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 02:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650706215; x=1682242215;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PBCdMFUfBx3arTmg/F40pbY08SWeH4eP+o9eyt9mTZI=;
  b=SypYRQVroPQGSbh9RU7qXQu2gEQag6VGPWsVM7iehjKDiYZ4JG6teq9w
   phkcn+/fWLyG5/Borpv7rAGOX2mM/c4l/ZmsRmRxuQyYZons0qS32aRU8
   8rO/lStDx5ceaFjrp/bmC7kMLUkZQPeofePuLZ+RhiQlcHLPwItGJ1lGp
   PFLPyIQuKqKKo7YbZWcURomgFA2FOuU0E08eS6rKABSydQq6R3XgM6o0g
   MZVOrO2FP4EskQNax3M3R51osQecf+50m8TvaBtLXNLxhHnTQ1dQCyZH4
   XAjr3HHPDTBY3UZhm+WrODU0U8WRX1ukB3WtDPt7KeeDBXAOfi12eoHf9
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="263723032"
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="263723032"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 02:30:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="703875136"
Received: from lkp-server01.sh.intel.com (HELO dd58949a6e39) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 23 Apr 2022 02:30:14 -0700
Received: from kbuild by dd58949a6e39 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niC5l-00007T-Lk;
        Sat, 23 Apr 2022 09:30:13 +0000
Date:   Sat, 23 Apr 2022 17:29:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [intel-tdx:guest-rebased 4/129] arch/x86/kernel/tdcall.o: warning:
 objtool: __tdx_module_call()+0x3f: missing int3 after ret
Message-ID: <202204231753.86pSanI4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kuppuswamy,

First bad commit (maybe != root cause):

tree:   https://github.com/intel/tdx.git guest-rebased
head:   4c095660b91dbdd18042456e395af0deeef93485
commit: 78ee914ccc3ec6aba40ea3ffd044ea17b1aba9ce [4/129] x86/tdx: Add __tdx_module_call() and __tdx_hypercall() helper functions
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220423/202204231753.86pSanI4-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/78ee914ccc3ec6aba40ea3ffd044ea17b1aba9ce
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-rebased
        git checkout 78ee914ccc3ec6aba40ea3ffd044ea17b1aba9ce
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/tdcall.o: warning: objtool: __tdx_module_call()+0x3f: missing int3 after ret
>> arch/x86/kernel/tdcall.o: warning: objtool: __tdx_hypercall()+0x60: missing int3 after ret

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
