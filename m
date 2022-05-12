Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92AA52570C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 23:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358738AbiELVb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 17:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358729AbiELVb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 17:31:57 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8885B20F4ED
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 14:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652391115; x=1683927115;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=GMPd1GDaFBymkbp6wyI83NlrTGkPVgA3CTpb0qctdMQ=;
  b=fjEae0YMozdjtiKDkFnCOH1vAxQjNQn9icjvnpbxhUOviZMZEybcDx0L
   fCjyxj1Zx31S46VMMBcc6kadvdtbAzD5U4Jrbn2HF3ZFp1Kl2Zg9uCGSd
   mVVBBS+f69NhWxmftxfiJolHIwzB2c4qr0eIDkCOjP16jXp2nhZ2JwuiM
   cTlMb5x9g08zsLpildXsJ//AEM/7/l3FWd+n6o/1l/mS0vFIcMeWiriGk
   6PNMdcobRw+GLx0KEVYpLyvBO7ktQe6GzIZ8mmF66QIzX7kzJkSRGeIL8
   uGp7vawqaewjlui/h/CtJMCyMKaMInqpwf9misELhtEIme/nLcEjqexap
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="270275263"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="270275263"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 14:31:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="603559437"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 12 May 2022 14:31:53 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npGPY-000Kxk-Lg;
        Thu, 12 May 2022 21:31:52 +0000
Date:   Fri, 13 May 2022 05:31:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/kvm/book3s_64_mmu.c:263:28: sparse: sparse: cast to
 restricted __be64
Message-ID: <202205130559.aKAAQhs8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
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
commit: b352ddae7b2ccd2cb29f495ca0a7c9b6848b623f KVM: PPC: Book3S PR: Remove unused variable
date:   9 months ago
config: powerpc64-randconfig-s031-20220512 (https://download.01.org/0day-ci/archive/20220513/202205130559.aKAAQhs8-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b352ddae7b2ccd2cb29f495ca0a7c9b6848b623f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b352ddae7b2ccd2cb29f495ca0a7c9b6848b623f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/kvm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/powerpc/kvm/book3s_64_mmu.c:263:28: sparse: sparse: cast to restricted __be64
   arch/powerpc/kvm/book3s_64_mmu.c:264:28: sparse: sparse: cast to restricted __be64
   arch/powerpc/kvm/book3s_64_mmu.c:288:13: sparse: sparse: cast to restricted __be64
   arch/powerpc/kvm/book3s_64_mmu.c: note: in included file:
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
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64

vim +263 arch/powerpc/kvm/book3s_64_mmu.c

a4a0f2524acc2c Paul Mackerras       2013-09-20  190  
e71b2a39afff24 Alexander Graf       2009-10-30  191  static int kvmppc_mmu_book3s_64_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
93b159b466bdc9 Paul Mackerras       2013-09-20  192  				      struct kvmppc_pte *gpte, bool data,
93b159b466bdc9 Paul Mackerras       2013-09-20  193  				      bool iswrite)
e71b2a39afff24 Alexander Graf       2009-10-30  194  {
e71b2a39afff24 Alexander Graf       2009-10-30  195  	struct kvmppc_slb *slbe;
e71b2a39afff24 Alexander Graf       2009-10-30  196  	hva_t ptegp;
e71b2a39afff24 Alexander Graf       2009-10-30  197  	u64 pteg[16];
e71b2a39afff24 Alexander Graf       2009-10-30  198  	u64 avpn = 0;
b352ddae7b2ccd Cédric Le Goater     2021-08-19  199  	u64 r;
7e48c101e0c53e Paul Mackerras       2013-08-06  200  	u64 v_val, v_mask;
7e48c101e0c53e Paul Mackerras       2013-08-06  201  	u64 eaddr_mask;
e71b2a39afff24 Alexander Graf       2009-10-30  202  	int i;
7e48c101e0c53e Paul Mackerras       2013-08-06  203  	u8 pp, key = 0;
e71b2a39afff24 Alexander Graf       2009-10-30  204  	bool found = false;
7e48c101e0c53e Paul Mackerras       2013-08-06  205  	bool second = false;
a4a0f2524acc2c Paul Mackerras       2013-09-20  206  	int pgsize;
e8508940a88691 Alexander Graf       2010-07-29  207  	ulong mp_ea = vcpu->arch.magic_page_ea;
e8508940a88691 Alexander Graf       2010-07-29  208  
e8508940a88691 Alexander Graf       2010-07-29  209  	/* Magic page override */
e8508940a88691 Alexander Graf       2010-07-29  210  	if (unlikely(mp_ea) &&
e8508940a88691 Alexander Graf       2010-07-29  211  	    unlikely((eaddr & ~0xfffULL) == (mp_ea & ~0xfffULL)) &&
5deb8e7ad8ac7e Alexander Graf       2014-04-24  212  	    !(kvmppc_get_msr(vcpu) & MSR_PR)) {
e8508940a88691 Alexander Graf       2010-07-29  213  		gpte->eaddr = eaddr;
e8508940a88691 Alexander Graf       2010-07-29  214  		gpte->vpage = kvmppc_mmu_book3s_64_ea_to_vp(vcpu, eaddr, data);
e8508940a88691 Alexander Graf       2010-07-29  215  		gpte->raddr = vcpu->arch.magic_page_pa | (gpte->raddr & 0xfff);
e8508940a88691 Alexander Graf       2010-07-29  216  		gpte->raddr &= KVM_PAM;
e8508940a88691 Alexander Graf       2010-07-29  217  		gpte->may_execute = true;
e8508940a88691 Alexander Graf       2010-07-29  218  		gpte->may_read = true;
e8508940a88691 Alexander Graf       2010-07-29  219  		gpte->may_write = true;
a4a0f2524acc2c Paul Mackerras       2013-09-20  220  		gpte->page_size = MMU_PAGE_4K;
6c7d47c33ed323 Alexey Kardashevskiy 2017-11-22  221  		gpte->wimg = HPTE_R_M;
e8508940a88691 Alexander Graf       2010-07-29  222  
e8508940a88691 Alexander Graf       2010-07-29  223  		return 0;
e8508940a88691 Alexander Graf       2010-07-29  224  	}
e71b2a39afff24 Alexander Graf       2009-10-30  225  
c4befc58a0cc5a Paul Mackerras       2011-06-29  226  	slbe = kvmppc_mmu_book3s_64_find_slbe(vcpu, eaddr);
e71b2a39afff24 Alexander Graf       2009-10-30  227  	if (!slbe)
e71b2a39afff24 Alexander Graf       2009-10-30  228  		goto no_seg_found;
e71b2a39afff24 Alexander Graf       2009-10-30  229  
0f296829b5a59d Paul Mackerras       2013-06-22  230  	avpn = kvmppc_mmu_book3s_64_get_avpn(slbe, eaddr);
7e48c101e0c53e Paul Mackerras       2013-08-06  231  	v_val = avpn & HPTE_V_AVPN;
7e48c101e0c53e Paul Mackerras       2013-08-06  232  
0f296829b5a59d Paul Mackerras       2013-06-22  233  	if (slbe->tb)
7e48c101e0c53e Paul Mackerras       2013-08-06  234  		v_val |= SLB_VSID_B_1T;
7e48c101e0c53e Paul Mackerras       2013-08-06  235  	if (slbe->large)
7e48c101e0c53e Paul Mackerras       2013-08-06  236  		v_val |= HPTE_V_LARGE;
7e48c101e0c53e Paul Mackerras       2013-08-06  237  	v_val |= HPTE_V_VALID;
7e48c101e0c53e Paul Mackerras       2013-08-06  238  
7e48c101e0c53e Paul Mackerras       2013-08-06  239  	v_mask = SLB_VSID_B | HPTE_V_AVPN | HPTE_V_LARGE | HPTE_V_VALID |
7e48c101e0c53e Paul Mackerras       2013-08-06  240  		HPTE_V_SECONDARY;
0f296829b5a59d Paul Mackerras       2013-06-22  241  
a4a0f2524acc2c Paul Mackerras       2013-09-20  242  	pgsize = slbe->large ? MMU_PAGE_16M : MMU_PAGE_4K;
a4a0f2524acc2c Paul Mackerras       2013-09-20  243  
9308ab8e2da933 Paul Mackerras       2013-09-20  244  	mutex_lock(&vcpu->kvm->arch.hpt_mutex);
9308ab8e2da933 Paul Mackerras       2013-09-20  245  
e71b2a39afff24 Alexander Graf       2009-10-30  246  do_second:
3ff955024d186c Paul Mackerras       2013-09-20  247  	ptegp = kvmppc_mmu_book3s_64_get_pteg(vcpu, slbe, eaddr, second);
e71b2a39afff24 Alexander Graf       2009-10-30  248  	if (kvm_is_error_hva(ptegp))
e71b2a39afff24 Alexander Graf       2009-10-30  249  		goto no_page_found;
e71b2a39afff24 Alexander Graf       2009-10-30  250  
e71b2a39afff24 Alexander Graf       2009-10-30  251  	if(copy_from_user(pteg, (void __user *)ptegp, sizeof(pteg))) {
4da934dc6515af Vipin K Parashar     2017-02-16  252  		printk_ratelimited(KERN_ERR
4da934dc6515af Vipin K Parashar     2017-02-16  253  			"KVM: Can't copy data from 0x%lx!\n", ptegp);
e71b2a39afff24 Alexander Graf       2009-10-30  254  		goto no_page_found;
e71b2a39afff24 Alexander Graf       2009-10-30  255  	}
e71b2a39afff24 Alexander Graf       2009-10-30  256  
5deb8e7ad8ac7e Alexander Graf       2014-04-24  257  	if ((kvmppc_get_msr(vcpu) & MSR_PR) && slbe->Kp)
e71b2a39afff24 Alexander Graf       2009-10-30  258  		key = 4;
5deb8e7ad8ac7e Alexander Graf       2014-04-24  259  	else if (!(kvmppc_get_msr(vcpu) & MSR_PR) && slbe->Ks)
e71b2a39afff24 Alexander Graf       2009-10-30  260  		key = 4;
e71b2a39afff24 Alexander Graf       2009-10-30  261  
e71b2a39afff24 Alexander Graf       2009-10-30  262  	for (i=0; i<16; i+=2) {
4e509af9f83deb Alexander Graf       2014-04-24 @263  		u64 pte0 = be64_to_cpu(pteg[i]);
4e509af9f83deb Alexander Graf       2014-04-24  264  		u64 pte1 = be64_to_cpu(pteg[i + 1]);
4e509af9f83deb Alexander Graf       2014-04-24  265  
7e48c101e0c53e Paul Mackerras       2013-08-06  266  		/* Check all relevant fields of 1st dword */
4e509af9f83deb Alexander Graf       2014-04-24  267  		if ((pte0 & v_mask) == v_val) {
a4a0f2524acc2c Paul Mackerras       2013-09-20  268  			/* If large page bit is set, check pgsize encoding */
a4a0f2524acc2c Paul Mackerras       2013-09-20  269  			if (slbe->large &&
a4a0f2524acc2c Paul Mackerras       2013-09-20  270  			    (vcpu->arch.hflags & BOOK3S_HFLAG_MULTI_PGSIZE)) {
4e509af9f83deb Alexander Graf       2014-04-24  271  				pgsize = decode_pagesize(slbe, pte1);
a4a0f2524acc2c Paul Mackerras       2013-09-20  272  				if (pgsize < 0)
a4a0f2524acc2c Paul Mackerras       2013-09-20  273  					continue;
a4a0f2524acc2c Paul Mackerras       2013-09-20  274  			}
7e48c101e0c53e Paul Mackerras       2013-08-06  275  			found = true;
7e48c101e0c53e Paul Mackerras       2013-08-06  276  			break;
7e48c101e0c53e Paul Mackerras       2013-08-06  277  		}
7e48c101e0c53e Paul Mackerras       2013-08-06  278  	}
e71b2a39afff24 Alexander Graf       2009-10-30  279  
7e48c101e0c53e Paul Mackerras       2013-08-06  280  	if (!found) {
7e48c101e0c53e Paul Mackerras       2013-08-06  281  		if (second)
7e48c101e0c53e Paul Mackerras       2013-08-06  282  			goto no_page_found;
7e48c101e0c53e Paul Mackerras       2013-08-06  283  		v_val |= HPTE_V_SECONDARY;
7e48c101e0c53e Paul Mackerras       2013-08-06  284  		second = true;
7e48c101e0c53e Paul Mackerras       2013-08-06  285  		goto do_second;
7e48c101e0c53e Paul Mackerras       2013-08-06  286  	}
e71b2a39afff24 Alexander Graf       2009-10-30  287  
4e509af9f83deb Alexander Graf       2014-04-24  288  	r = be64_to_cpu(pteg[i+1]);
7e48c101e0c53e Paul Mackerras       2013-08-06  289  	pp = (r & HPTE_R_PP) | key;
03a9c90334d611 Paul Mackerras       2013-09-20  290  	if (r & HPTE_R_PP0)
03a9c90334d611 Paul Mackerras       2013-09-20  291  		pp |= 8;
e71b2a39afff24 Alexander Graf       2009-10-30  292  
e71b2a39afff24 Alexander Graf       2009-10-30  293  	gpte->eaddr = eaddr;
7e48c101e0c53e Paul Mackerras       2013-08-06  294  	gpte->vpage = kvmppc_mmu_book3s_64_ea_to_vp(vcpu, eaddr, data);
a4a0f2524acc2c Paul Mackerras       2013-09-20  295  
a4a0f2524acc2c Paul Mackerras       2013-09-20  296  	eaddr_mask = (1ull << mmu_pagesize(pgsize)) - 1;
7e48c101e0c53e Paul Mackerras       2013-08-06  297  	gpte->raddr = (r & HPTE_R_RPN & ~eaddr_mask) | (eaddr & eaddr_mask);
a4a0f2524acc2c Paul Mackerras       2013-09-20  298  	gpte->page_size = pgsize;
e71b2a39afff24 Alexander Graf       2009-10-30  299  	gpte->may_execute = ((r & HPTE_R_N) ? false : true);
f3383cf80e417e Alexander Graf       2014-05-12  300  	if (unlikely(vcpu->arch.disable_kernel_nx) &&
f3383cf80e417e Alexander Graf       2014-05-12  301  	    !(kvmppc_get_msr(vcpu) & MSR_PR))
f3383cf80e417e Alexander Graf       2014-05-12  302  		gpte->may_execute = true;
e71b2a39afff24 Alexander Graf       2009-10-30  303  	gpte->may_read = false;
e71b2a39afff24 Alexander Graf       2009-10-30  304  	gpte->may_write = false;
96df2267695199 Alexey Kardashevskiy 2017-03-24  305  	gpte->wimg = r & HPTE_R_WIMG;
e71b2a39afff24 Alexander Graf       2009-10-30  306  
e71b2a39afff24 Alexander Graf       2009-10-30  307  	switch (pp) {
e71b2a39afff24 Alexander Graf       2009-10-30  308  	case 0:
e71b2a39afff24 Alexander Graf       2009-10-30  309  	case 1:
e71b2a39afff24 Alexander Graf       2009-10-30  310  	case 2:
e71b2a39afff24 Alexander Graf       2009-10-30  311  	case 6:
e71b2a39afff24 Alexander Graf       2009-10-30  312  		gpte->may_write = true;
8fc6ba0a205e9a Joe Perches          2020-03-10  313  		fallthrough;
e71b2a39afff24 Alexander Graf       2009-10-30  314  	case 3:
e71b2a39afff24 Alexander Graf       2009-10-30  315  	case 5:
e71b2a39afff24 Alexander Graf       2009-10-30  316  	case 7:
03a9c90334d611 Paul Mackerras       2013-09-20  317  	case 10:
e71b2a39afff24 Alexander Graf       2009-10-30  318  		gpte->may_read = true;
e71b2a39afff24 Alexander Graf       2009-10-30  319  		break;
e71b2a39afff24 Alexander Graf       2009-10-30  320  	}
e71b2a39afff24 Alexander Graf       2009-10-30  321  
e71b2a39afff24 Alexander Graf       2009-10-30  322  	dprintk("KVM MMU: Translated 0x%lx [0x%llx] -> 0x%llx "
af7b4d104b36e7 Alexander Graf       2010-04-20  323  		"-> 0x%lx\n",
e71b2a39afff24 Alexander Graf       2009-10-30  324  		eaddr, avpn, gpte->vpage, gpte->raddr);
e71b2a39afff24 Alexander Graf       2009-10-30  325  
e71b2a39afff24 Alexander Graf       2009-10-30  326  	/* Update PTE R and C bits, so the guest's swapper knows we used the
e71b2a39afff24 Alexander Graf       2009-10-30  327  	 * page */
9308ab8e2da933 Paul Mackerras       2013-09-20  328  	if (gpte->may_read && !(r & HPTE_R_R)) {
9308ab8e2da933 Paul Mackerras       2013-09-20  329  		/*
9308ab8e2da933 Paul Mackerras       2013-09-20  330  		 * Set the accessed flag.
9308ab8e2da933 Paul Mackerras       2013-09-20  331  		 * We have to write this back with a single byte write
9308ab8e2da933 Paul Mackerras       2013-09-20  332  		 * because another vcpu may be accessing this on
9308ab8e2da933 Paul Mackerras       2013-09-20  333  		 * non-PAPR platforms such as mac99, and this is
9308ab8e2da933 Paul Mackerras       2013-09-20  334  		 * what real hardware does.
9308ab8e2da933 Paul Mackerras       2013-09-20  335  		 */
740f834eb2505e Alexander Graf       2014-04-24  336                  char __user *addr = (char __user *) (ptegp + (i + 1) * sizeof(u64));
7e48c101e0c53e Paul Mackerras       2013-08-06  337  		r |= HPTE_R_R;
9308ab8e2da933 Paul Mackerras       2013-09-20  338  		put_user(r >> 8, addr + 6);
e71b2a39afff24 Alexander Graf       2009-10-30  339  	}
93b159b466bdc9 Paul Mackerras       2013-09-20  340  	if (iswrite && gpte->may_write && !(r & HPTE_R_C)) {
93b159b466bdc9 Paul Mackerras       2013-09-20  341  		/* Set the dirty flag */
9308ab8e2da933 Paul Mackerras       2013-09-20  342  		/* Use a single byte write */
740f834eb2505e Alexander Graf       2014-04-24  343                  char __user *addr = (char __user *) (ptegp + (i + 1) * sizeof(u64));
7e48c101e0c53e Paul Mackerras       2013-08-06  344  		r |= HPTE_R_C;
9308ab8e2da933 Paul Mackerras       2013-09-20  345  		put_user(r, addr + 7);
e71b2a39afff24 Alexander Graf       2009-10-30  346  	}
e71b2a39afff24 Alexander Graf       2009-10-30  347  
9308ab8e2da933 Paul Mackerras       2013-09-20  348  	mutex_unlock(&vcpu->kvm->arch.hpt_mutex);
e71b2a39afff24 Alexander Graf       2009-10-30  349  
93b159b466bdc9 Paul Mackerras       2013-09-20  350  	if (!gpte->may_read || (iswrite && !gpte->may_write))
6ed1485f65f0eb Paul Mackerras       2013-06-22  351  		return -EPERM;
e71b2a39afff24 Alexander Graf       2009-10-30  352  	return 0;
e71b2a39afff24 Alexander Graf       2009-10-30  353  
e71b2a39afff24 Alexander Graf       2009-10-30  354  no_page_found:
9308ab8e2da933 Paul Mackerras       2013-09-20  355  	mutex_unlock(&vcpu->kvm->arch.hpt_mutex);
e71b2a39afff24 Alexander Graf       2009-10-30  356  	return -ENOENT;
e71b2a39afff24 Alexander Graf       2009-10-30  357  
e71b2a39afff24 Alexander Graf       2009-10-30  358  no_seg_found:
e71b2a39afff24 Alexander Graf       2009-10-30  359  	dprintk("KVM MMU: Trigger segment fault\n");
e71b2a39afff24 Alexander Graf       2009-10-30  360  	return -EINVAL;
e71b2a39afff24 Alexander Graf       2009-10-30  361  }
e71b2a39afff24 Alexander Graf       2009-10-30  362  

:::::: The code at line 263 was first introduced by commit
:::::: 4e509af9f83debe296661d2e09a8a214850efe3c KVM: PPC: Book3S_64 PR: Access HTAB in big endian

:::::: TO: Alexander Graf <agraf@suse.de>
:::::: CC: Alexander Graf <agraf@suse.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
