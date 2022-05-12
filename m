Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D06525647
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 22:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358318AbiELUO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 16:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357941AbiELUOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 16:14:54 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36925AEC6
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 13:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652386492; x=1683922492;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=sWMoEmv5M9+5j4diEIgRyDkXPSAFp5UbF9L9c25C3tE=;
  b=kQ6HvW3i6Fk197biWLS7ur/XYYGYjBmGzFK2FdsUsfAw3EUbO2cizF7Y
   Vw+3qSyymS6yXtB04CWRyeFK8zptFrBDxa/FcJpEGhwHSozwkxc8rX92q
   8ENUO8nuxTkAKqvV6uIt5fAk2ERnNlihrArlXLem8PlBaREl5s+jq4zSs
   5XwRLlp+EE3XvFnKA4qLLCZTzSsM33Mm4jo1/kzg0q7GbWws6/gSpajXA
   cG1QwYuwnRvKXE8nkj4X/g962N6w3hFjLDSbrU87h3BflOS6fKJUvvPNy
   SHCOk987MoXAXRV9nPFZSETXc2xAvS5LIiE/6z/DL580Uquzl0+eoWi6u
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="330727333"
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="330727333"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 13:14:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="521116015"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 12 May 2022 13:14:49 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npFCy-000Ksu-BO;
        Thu, 12 May 2022 20:14:48 +0000
Date:   Fri, 13 May 2022 04:14:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/kvm/book3s_pr.c:660:22: sparse: sparse: cast to
 restricted __be32
Message-ID: <202205130409.MfQ1ZvwW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cédric,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0ac824f379fba2c2b17b75fd5ada69cd68c66348
commit: cb53a93e33e108bfec00a13cd12696e1c0ccc8b6 KVM: PPC: Book3S PR: Declare kvmppc_handle_exit_pr()
date:   9 months ago
config: powerpc64-randconfig-s031-20220512 (https://download.01.org/0day-ci/archive/20220513/202205130409.MfQ1ZvwW-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cb53a93e33e108bfec00a13cd12696e1c0ccc8b6
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout cb53a93e33e108bfec00a13cd12696e1c0ccc8b6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/powerpc/kvm/book3s_pr.c:660:22: sparse: sparse: cast to restricted __be32
>> arch/powerpc/kvm/book3s_pr.c:661:33: sparse: sparse: invalid assignment: &=
>> arch/powerpc/kvm/book3s_pr.c:661:33: sparse:    left side has type unsigned int
>> arch/powerpc/kvm/book3s_pr.c:661:33: sparse:    right side has type restricted __be32
   arch/powerpc/kvm/book3s_pr.c: note: in included file:
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:962:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] srr0 @@     got restricted __be64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:962:1: sparse:     expected unsigned long long [usertype] srr0
   arch/powerpc/include/asm/kvm_ppc.h:962:1: sparse:     got restricted __be64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:962:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] srr0 @@     got restricted __le64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:962:1: sparse:     expected unsigned long long [usertype] srr0
   arch/powerpc/include/asm/kvm_ppc.h:962:1: sparse:     got restricted __le64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:963:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] srr1 @@     got restricted __be64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:963:1: sparse:     expected unsigned long long [usertype] srr1
   arch/powerpc/include/asm/kvm_ppc.h:963:1: sparse:     got restricted __be64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:963:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] srr1 @@     got restricted __le64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:963:1: sparse:     expected unsigned long long [usertype] srr1
   arch/powerpc/include/asm/kvm_ppc.h:963:1: sparse:     got restricted __le64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:970:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] msr @@     got restricted __be64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:970:39: sparse:     expected unsigned long long [usertype] msr
   arch/powerpc/include/asm/kvm_ppc.h:970:39: sparse:     got restricted __be64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:972:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] msr @@     got restricted __le64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:972:39: sparse:     expected unsigned long long [usertype] msr
   arch/powerpc/include/asm/kvm_ppc.h:972:39: sparse:     got restricted __le64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:970:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] msr @@     got restricted __be64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:970:39: sparse:     expected unsigned long long [usertype] msr
   arch/powerpc/include/asm/kvm_ppc.h:970:39: sparse:     got restricted __be64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:972:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] msr @@     got restricted __le64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:972:39: sparse:     expected unsigned long long [usertype] msr
   arch/powerpc/include/asm/kvm_ppc.h:972:39: sparse:     got restricted __le64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] dar @@     got restricted __be64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse:     expected unsigned long long [usertype] dar
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse:     got restricted __be64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] dar @@     got restricted __le64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse:     expected unsigned long long [usertype] dar
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse:     got restricted __le64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] dar @@     got restricted __be64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse:     expected unsigned long long [usertype] dar
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse:     got restricted __be64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] dar @@     got restricted __le64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse:     expected unsigned long long [usertype] dar
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse:     got restricted __le64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:974:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] dsisr @@     got restricted __be32 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:974:1: sparse:     expected unsigned int [usertype] dsisr
   arch/powerpc/include/asm/kvm_ppc.h:974:1: sparse:     got restricted __be32 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:974:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] dsisr @@     got restricted __le32 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:974:1: sparse:     expected unsigned int [usertype] dsisr
   arch/powerpc/include/asm/kvm_ppc.h:974:1: sparse:     got restricted __le32 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] dar @@     got restricted __be64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse:     expected unsigned long long [usertype] dar
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse:     got restricted __be64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] dar @@     got restricted __le64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse:     expected unsigned long long [usertype] dar
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse:     got restricted __le64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:984:23: sparse: sparse: cast to restricted __be32

vim +660 arch/powerpc/kvm/book3s_pr.c

f05ed4d56e9cff Paul Mackerras 2011-06-29  630  
f05ed4d56e9cff Paul Mackerras 2011-06-29  631  /* Book3s_32 CPUs always have 32 bytes cache line size, which Linux assumes. To
f05ed4d56e9cff Paul Mackerras 2011-06-29  632   * make Book3s_32 Linux work on Book3s_64, we have to make sure we trap dcbz to
f05ed4d56e9cff Paul Mackerras 2011-06-29  633   * emulate 32 bytes dcbz length.
f05ed4d56e9cff Paul Mackerras 2011-06-29  634   *
f05ed4d56e9cff Paul Mackerras 2011-06-29  635   * The Book3s_64 inventors also realized this case and implemented a special bit
f05ed4d56e9cff Paul Mackerras 2011-06-29  636   * in the HID5 register, which is a hypervisor ressource. Thus we can't use it.
f05ed4d56e9cff Paul Mackerras 2011-06-29  637   *
f05ed4d56e9cff Paul Mackerras 2011-06-29  638   * My approach here is to patch the dcbz instruction on executing pages.
f05ed4d56e9cff Paul Mackerras 2011-06-29  639   */
f05ed4d56e9cff Paul Mackerras 2011-06-29  640  static void kvmppc_patch_dcbz(struct kvm_vcpu *vcpu, struct kvmppc_pte *pte)
f05ed4d56e9cff Paul Mackerras 2011-06-29  641  {
f05ed4d56e9cff Paul Mackerras 2011-06-29  642  	struct page *hpage;
f05ed4d56e9cff Paul Mackerras 2011-06-29  643  	u64 hpage_offset;
f05ed4d56e9cff Paul Mackerras 2011-06-29  644  	u32 *page;
f05ed4d56e9cff Paul Mackerras 2011-06-29  645  	int i;
f05ed4d56e9cff Paul Mackerras 2011-06-29  646  
f05ed4d56e9cff Paul Mackerras 2011-06-29  647  	hpage = gfn_to_page(vcpu->kvm, pte->raddr >> PAGE_SHIFT);
32cad84f44d186 Xiao Guangrong 2012-08-03  648  	if (is_error_page(hpage))
f05ed4d56e9cff Paul Mackerras 2011-06-29  649  		return;
f05ed4d56e9cff Paul Mackerras 2011-06-29  650  
f05ed4d56e9cff Paul Mackerras 2011-06-29  651  	hpage_offset = pte->raddr & ~PAGE_MASK;
f05ed4d56e9cff Paul Mackerras 2011-06-29  652  	hpage_offset &= ~0xFFFULL;
f05ed4d56e9cff Paul Mackerras 2011-06-29  653  	hpage_offset /= 4;
f05ed4d56e9cff Paul Mackerras 2011-06-29  654  
f05ed4d56e9cff Paul Mackerras 2011-06-29  655  	get_page(hpage);
2480b2089210de Cong Wang      2011-11-25  656  	page = kmap_atomic(hpage);
f05ed4d56e9cff Paul Mackerras 2011-06-29  657  
f05ed4d56e9cff Paul Mackerras 2011-06-29  658  	/* patch dcbz into reserved instruction, so we trap */
f05ed4d56e9cff Paul Mackerras 2011-06-29  659  	for (i=hpage_offset; i < hpage_offset + (HW_PAGE_SIZE / 4); i++)
cd087eefe637d5 Alexander Graf 2014-04-24 @660  		if ((be32_to_cpu(page[i]) & 0xff0007ff) == INS_DCBZ)
cd087eefe637d5 Alexander Graf 2014-04-24 @661  			page[i] &= cpu_to_be32(0xfffffff7);
f05ed4d56e9cff Paul Mackerras 2011-06-29  662  
2480b2089210de Cong Wang      2011-11-25  663  	kunmap_atomic(page);
f05ed4d56e9cff Paul Mackerras 2011-06-29  664  	put_page(hpage);
f05ed4d56e9cff Paul Mackerras 2011-06-29  665  }
f05ed4d56e9cff Paul Mackerras 2011-06-29  666  

:::::: The code at line 660 was first introduced by commit
:::::: cd087eefe637d545345ea5f888d4ea4fe52e312c KVM: PPC: Book3S PR: Do dcbz32 patching with big endian instructions

:::::: TO: Alexander Graf <agraf@suse.de>
:::::: CC: Alexander Graf <agraf@suse.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
