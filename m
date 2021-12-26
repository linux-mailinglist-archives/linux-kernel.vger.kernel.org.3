Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4443047F608
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 10:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbhLZJ2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 04:28:40 -0500
Received: from mga02.intel.com ([134.134.136.20]:22850 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231529AbhLZJ2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 04:28:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640510919; x=1672046919;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=KxToBOjDH0BckICmRIKltdNPqHQwORInrWaePI7n8/U=;
  b=HkpNpI74YoaNGQZJ+3LiTO3NQVclT8+Ow+Ar4L8zEO4Qg8ryEw1+CIW7
   nIsKa21R7ACzeaqQcpzULxDlKScIU1nc+ilHxzkS+mJSvjNdq5YBCYsc8
   5Xu5e6b0BqxDtRoQ5kt+xHZgPrqIJ/ggOlkuPEN2T5OEtDjtQWlhy4Lua
   f7DkCo3IlK2HokZl6Zc+XsgJdF8UaxgWeEaQa2TvCLav8lVuiShfhzifK
   gqJxRwhNV4NrP28WZ1tlxUiDHdyt6dVZc/PESdr0xg71EL1sk9OJtupqt
   pgUiYH1P6GnBajyTJIKTxVLLmgdwY4B6CfwOVEpjuFsZ3KgYwHKVepuFz
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10208"; a="228398141"
X-IronPort-AV: E=Sophos;i="5.88,236,1635231600"; 
   d="scan'208";a="228398141"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2021 01:28:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,236,1635231600"; 
   d="scan'208";a="553326501"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 26 Dec 2021 01:28:37 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n1PpU-0005Gd-P5; Sun, 26 Dec 2021 09:28:36 +0000
Date:   Sun, 26 Dec 2021 17:28:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/kvm/book3s_64_mmu.c:263:28: sparse: sparse: cast to
 restricted __be64
Message-ID: <202112261729.FSD0kgxB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cédric,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   438645193e59e91761ccb3fa55f6ce70b615ff93
commit: b352ddae7b2ccd2cb29f495ca0a7c9b6848b623f KVM: PPC: Book3S PR: Remove unused variable
date:   4 months ago
config: powerpc64-randconfig-s032-20211226 (https://download.01.org/0day-ci/archive/20211226/202112261729.FSD0kgxB-lkp@intel.com/config)
compiler: powerpc64le-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b352ddae7b2ccd2cb29f495ca0a7c9b6848b623f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b352ddae7b2ccd2cb29f495ca0a7c9b6848b623f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/kvm/ drivers/misc/ drivers/pinctrl/nuvoton/

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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
