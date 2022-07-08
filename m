Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3F456AF3E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 02:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236926AbiGHADR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 20:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbiGHADP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 20:03:15 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAD66EE84
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 17:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657238594; x=1688774594;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mr0tTST7+RPahHby1oQ1rXExTGfFu1KWfF0lR3cVpqU=;
  b=OhuKFIyfJ9bIpBGrt7YN+zMcVXdhUW4TZyx9NBaOPaSVYfSjSzIW02yZ
   d6Shytq22xF59sXgWtE/kUVMizLxT7g8WQ3eUaK9JWIdWROlQ5bN32Y2D
   6vy/nmoHVFiIhwa53OMuHSVtXyPh7bxj+Q1sZ3qhf/vfxlMh1SQYL1OGI
   mrJw09LixW6Or9FhWpXupMxQdSMC2mUgT/QGk+UCiNiSpWwHKhJwp83Qc
   7fb5W0aS18OXVePz9jxsOp3AYXJ7j2iF9gc+U9hsoc+FIf5PVGCJQ6smk
   z+NRPPXnrTwyzjRza6YxUHZKOH5rivPEX/ryt8BSkP0Jat4hFpvw4RmyK
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="370462313"
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="370462313"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 17:03:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="683482749"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Jul 2022 17:03:12 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9bSi-000Mdw-5i;
        Fri, 08 Jul 2022 00:03:12 +0000
Date:   Fri, 8 Jul 2022 08:02:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [intel-tdx:guest-hardening-rebased 11/23]
 arch/x86/coco/tdx/tdx.c:297:14: warning: no previous prototype for
 'tdx_write_msr'
Message-ID: <202207080723.aRk54tCZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-hardening-rebased
head:   64a4c4e66ca9cce1ca55de6d801f32284fbf7c8e
commit: d1a7216a37f68b347a3622a0c8498134d5cb8970 [11/23] x86/tdx: Use direct paravirt call for wrmsrl
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220708/202207080723.aRk54tCZ-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/d1a7216a37f68b347a3622a0c8498134d5cb8970
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-hardening-rebased
        git checkout d1a7216a37f68b347a3622a0c8498134d5cb8970
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/coco/tdx/ arch/x86/mm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/coco/tdx/tdx.c:297:14: warning: no previous prototype for 'tdx_write_msr' [-Wmissing-prototypes]
     297 | void notrace tdx_write_msr(unsigned int msr, u32 low, u32 high)
         |              ^~~~~~~~~~~~~


vim +/tdx_write_msr +297 arch/x86/coco/tdx/tdx.c

   296	
 > 297	void notrace tdx_write_msr(unsigned int msr, u32 low, u32 high)
   298	{
   299		struct tdx_hypercall_args args = {
   300			.r10 = TDX_HYPERCALL_STANDARD,
   301			.r11 = hcall_func(EXIT_REASON_MSR_WRITE),
   302			.r12 = msr,
   303			.r13 = (u64)high << 32 | low,
   304		};
   305	
   306		if (tdx_fast_tdcall_path_msr(msr))
   307			__tdx_hypercall(&args, 0);
   308		else
   309			native_write_msr(msr, low, high);
   310	}
   311	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
