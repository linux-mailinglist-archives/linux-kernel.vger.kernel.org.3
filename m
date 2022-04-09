Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B774FAB1C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 01:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbiDIXWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 19:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiDIXWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 19:22:37 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3380F12621
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 16:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649546428; x=1681082428;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7ZHJQEOwF/MeNPTWYrUODuI57RvjnwKWAIlsemHcqyI=;
  b=QxaqWKiReqTdrZsoTF1ZRle5+XaRbeKAR6mX0FraFaK0M+n0leHQU3Yq
   DAJTDViO0h+1dP40jTeWEgP7W5Czjkoq96ueR88NTjqv+KW2oKN1HDFVO
   PALq916v1p1kDTWs22P2SCwHRVGzqgtQwnJqmlANH8IjoP68Gi5pOf8gy
   0gIWWakNpnzaqA/ZtBrkzi3UtD0L9V9mFLcUgVbP+FKoSYoxcq5MPhyMG
   lZ1398hAL2fE1vMMqXsWqJg2FY4lL/7w2hWmp+EcWfOWB61GIB8yhYCXg
   LUPv8dE0Ucq+FGojcuTO6CNFoe7gp3l2+x3cfUPJ+tn/spOGVMaKIZxBi
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10312"; a="242510043"
X-IronPort-AV: E=Sophos;i="5.90,248,1643702400"; 
   d="scan'208";a="242510043"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2022 16:20:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,248,1643702400"; 
   d="scan'208";a="622373043"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 09 Apr 2022 16:20:26 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndKNV-0000Tz-Cg;
        Sat, 09 Apr 2022 23:20:25 +0000
Date:   Sun, 10 Apr 2022 07:19:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Quentin Perret <qperret@google.com>
Subject: arch/arm64/kvm/va_layout.c:292:6: warning: no previous prototype for
 'kvm_compute_final_ctr_el0'
Message-ID: <202204100747.cAEiiULQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e1f700ebd6bea293abe3c7e2807b252018efde01
commit: 755db23420a1ce4b740186543432983e9bbe713e KVM: arm64: Generate final CTR_EL0 value when running in Protected mode
date:   1 year, 1 month ago
config: arm64-randconfig-r002-20220410 (https://download.01.org/0day-ci/archive/20220410/202204100747.cAEiiULQ-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=755db23420a1ce4b740186543432983e9bbe713e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 755db23420a1ce4b740186543432983e9bbe713e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kvm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/arm64/kvm/va_layout.c:188:6: warning: no previous prototype for 'kvm_patch_vector_branch' [-Wmissing-prototypes]
     188 | void kvm_patch_vector_branch(struct alt_instr *alt,
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/va_layout.c:286:6: warning: no previous prototype for 'kvm_get_kimage_voffset' [-Wmissing-prototypes]
     286 | void kvm_get_kimage_voffset(struct alt_instr *alt,
         |      ^~~~~~~~~~~~~~~~~~~~~~
>> arch/arm64/kvm/va_layout.c:292:6: warning: no previous prototype for 'kvm_compute_final_ctr_el0' [-Wmissing-prototypes]
     292 | void kvm_compute_final_ctr_el0(struct alt_instr *alt,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/kvm_compute_final_ctr_el0 +292 arch/arm64/kvm/va_layout.c

   291	
 > 292	void kvm_compute_final_ctr_el0(struct alt_instr *alt,

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
