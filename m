Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB5C4EE8D6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 09:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343746AbiDAHLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 03:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241278AbiDAHLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 03:11:44 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDC91D67C8
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 00:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648796995; x=1680332995;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=x7JxNYZE4bR2Se13EgnNdI0M8Y2HG+1d7lIDBk7wNqs=;
  b=k1pJVLwUyoCjHG/1D4A6mFt+94jvX8WcSG0yRUdwHqDu1B3NG1W/V8u4
   xrZXJFoty7iGXY1j3nHYfcxX4xCK5npHrArjbZDqxkVGdlXaEgVraH5Vq
   IlZ57mRr7s6R1kLjmEN/frK5Of5eNpgcr8o8w24oN2YfAVVBR06I96Kdb
   z22Ntk2j4cpz8YDMu6hUjwbNlICodTtrt4oybJ7NxD2uHk38uPfkgd3rn
   ZMyDTztjV1O6IoQpj0sOyHN4Ct218dMIyPJGRve6E/q/+hAryOluDduy4
   wAROnzhbZVqWlvGiWMY3oumxpMie+WOCO4v/vfoX+t4F2yS7lPiccWI8j
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10303"; a="242208282"
X-IronPort-AV: E=Sophos;i="5.90,226,1643702400"; 
   d="scan'208";a="242208282"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 00:09:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,226,1643702400"; 
   d="scan'208";a="504064753"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 01 Apr 2022 00:09:31 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1naBPX-00012m-2V;
        Fri, 01 Apr 2022 07:09:31 +0000
Date:   Fri, 1 Apr 2022 15:08:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>
Subject: [intel-tdx:guest-upstream 5/32] arch/x86/coco/tdx/tdcall.o: warning:
 objtool: __tdx_module_call()+0x3a: missing int3 after ret
Message-ID: <202204011414.sHGf1lWN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kuppuswamy,

First bad commit (maybe != root cause):

tree:   https://github.com/intel/tdx.git guest-upstream
head:   7d5c8afa0ebaf1731bb7ce8fe34a3248224fe0e9
commit: c03bec7b2dad416b31b8e5d5d656dfd84430ee09 [5/32] x86/tdx: Add __tdx_module_call() and __tdx_hypercall() helper functions
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220401/202204011414.sHGf1lWN-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/c03bec7b2dad416b31b8e5d5d656dfd84430ee09
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-upstream
        git checkout c03bec7b2dad416b31b8e5d5d656dfd84430ee09
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/coco/tdx/tdcall.o: warning: objtool: __tdx_module_call()+0x3a: missing int3 after ret
>> arch/x86/coco/tdx/tdcall.o: warning: objtool: __tdx_hypercall()+0x60: missing int3 after ret

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
