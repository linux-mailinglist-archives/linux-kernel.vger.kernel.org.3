Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E024547FD5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 08:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238272AbiFMGvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 02:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238392AbiFMGvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 02:51:03 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9799F1EAE7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 23:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655103006; x=1686639006;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RGtR00YXznzblbZw6feUnIn4iE2iFhjqHOStGqIumPY=;
  b=d9tZu/eWNuxPSenGteO1BzHMy8LhFAsCllGFcW5oNWJ8D2RtgPFa6WTi
   ItFhINYi0R9rn0SYr/Fpp7gfVlkAVCGuAjtuLKfVDCRCLK3y/E2gehlUv
   BospXCSK2vsWiPwScmY7dKgRDiB3VvTbJc5gkOZxkmmg5baePoc7GMXX7
   CNvtXCmTCf11HSVWeZJe2AXhdbEnTVekIcNYXsGcKMNRjMT3sg3kzxNXb
   nYnkwpYpW3cpaNpiLID6bRlcdSUuZFCTqGFByZhBALLRWbpSjGp1XNGQV
   yBhqCQQnWAttoFVWRRPAOkyd2wgRdKAaAzHQOA9wo3PNvTC2hDlme2xbj
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10376"; a="339861047"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="339861047"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2022 23:49:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="567782758"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 12 Jun 2022 23:49:47 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0dtS-000Kaj-UI;
        Mon, 13 Jun 2022 06:49:46 +0000
Date:   Mon, 13 Jun 2022 14:49:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalesh Singh <kaleshsingh@google.com>, mark.rutland@arm.com,
        broonie@kernel.org, maz@kernel.org
Cc:     kbuild-all@lists.01.org, will@kernel.org, qperret@google.com,
        tabba@google.com, surenb@google.com, tjmercier@google.com,
        kernel-team@android.com, Kalesh Singh <kaleshsingh@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Jones <drjones@redhat.com>,
        Keir Fraser <keirf@google.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Oliver Upton <oupton@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] KVM: arm64: Unwind and dump nVHE hypervisor
 stacktrace
Message-ID: <202206131423.8tjrMBgk-lkp@intel.com>
References: <20220607165105.639716-6-kaleshsingh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607165105.639716-6-kaleshsingh@google.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kalesh,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on f2906aa863381afb0015a9eb7fefad885d4e5a56]

url:    https://github.com/intel-lab-lkp/linux/commits/Kalesh-Singh/KVM-nVHE-Hypervisor-stack-unwinder/20220608-011351
base:   f2906aa863381afb0015a9eb7fefad885d4e5a56
config: arm64-randconfig-c024-20220612 (https://download.01.org/0day-ci/archive/20220613/202206131423.8tjrMBgk-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/ac1ce397ffe5b05df06cdb56a30db4099c7428ec
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kalesh-Singh/KVM-nVHE-Hypervisor-stack-unwinder/20220608-011351
        git checkout ac1ce397ffe5b05df06cdb56a30db4099c7428ec
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   aarch64-linux-ld: arch/arm64/kernel/stacktrace.o: in function `hyp_dump_backtrace':
>> arch/arm64/kernel/stacktrace.c:254: undefined reference to `kvm_arm_hyp_stacktrace_page'
   aarch64-linux-ld: arch/arm64/kernel/stacktrace.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `kvm_arm_hyp_stacktrace_page' which may bind externally can not be used when making a shared object; recompile with -fPIC
   arch/arm64/kernel/stacktrace.c:254:(.text+0x634): dangerous relocation: unsupported relocation
>> aarch64-linux-ld: arch/arm64/kernel/stacktrace.c:254: undefined reference to `kvm_arm_hyp_stacktrace_page'
   pahole: .tmp_vmlinux.btf: No such file or directory
   .btf.vmlinux.bin.o: file not recognized: file format not recognized


vim +254 arch/arm64/kernel/stacktrace.c

   246	
   247	/**
   248	 * Symbolizes and dumps the hypervisor backtrace from the shared
   249	 * stacktrace page.
   250	 */
   251	noinline notrace void hyp_dump_backtrace(unsigned long hyp_offset)
   252	{
   253		unsigned long *stacktrace_pos =
 > 254			(unsigned long *)*this_cpu_ptr(&kvm_arm_hyp_stacktrace_page);
   255		unsigned long va_mask = GENMASK_ULL(vabits_actual - 1, 0);
   256		unsigned long pc = *stacktrace_pos++;
   257	
   258		kvm_err("nVHE HYP call trace:\n");
   259	
   260		while (pc) {
   261			pc &= va_mask;		/* Mask tags */
   262			pc += hyp_offset;	/* Convert to kern addr */
   263			kvm_err("[<%016lx>] %pB\n", pc, (void *)pc);
   264			pc = *stacktrace_pos++;
   265		}
   266	
   267		kvm_err("---- end of nVHE HYP call trace ----\n");
   268	}
   269	#else /* __KVM_NVHE_HYPERVISOR__ */
   270	DEFINE_PER_CPU(unsigned long [PAGE_SIZE/sizeof(long)], overflow_stack)
   271		__aligned(16);
   272	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
