Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944BB54BB51
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 22:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358217AbiFNUPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 16:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358639AbiFNUOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 16:14:45 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E1826ACF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655237528; x=1686773528;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H39qclFsqZbsKF4/6iQ+SjBBp3vw55ZbnY4RJ7gbLBE=;
  b=hwbvR6YkgaZ7MHDplQxEddgb8cLPfgHpQVKZ2PKWgLDLDkVknIe0bjRT
   Tgl0LYGD8z+0heoBeQzNsDJmrLLQBo24426A0l6s0rf/gEArEqaXb/F4S
   aECEJZNWM/Hh886D5nXh6BCX8ZWNsNNUl5vWisRLLQiSRmcW7raykeF1U
   TlY6GiS/4gbC+F3fAbFDKZ4VWq/ZUq3aJ/SGKqvRfN+Lu0UCZ+KRwEhVX
   JxA35XCQ0OSzhGcGCabN7XVTx6FGPc5mY1DXOnbdYjENLGs8j+wJKfvh2
   ZpPmz1dtXG5o1CDUPXUyZFTo1j04faz7P5H+SdjX26SqKTsCu/cn4Gk86
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="342692970"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="342692970"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 13:09:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="582851874"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 14 Jun 2022 13:09:50 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1CrF-000MGT-Cq;
        Tue, 14 Jun 2022 20:09:49 +0000
Date:   Wed, 15 Jun 2022 04:09:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalesh Singh <kaleshsingh@google.com>, mark.rutland@arm.com,
        broonie@kernel.org, maz@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, will@kernel.org,
        qperret@google.com, tabba@google.com, surenb@google.com,
        tjmercier@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
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
Message-ID: <202206150420.KMU4kXzZ-lkp@intel.com>
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
config: arm64-buildonly-randconfig-r003-20220613 (https://download.01.org/0day-ci/archive/20220615/202206150420.KMU4kXzZ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c97436f8b6e2718286e8496faf53a2c800e281cf)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/ac1ce397ffe5b05df06cdb56a30db4099c7428ec
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kalesh-Singh/KVM-nVHE-Hypervisor-stack-unwinder/20220608-011351
        git checkout ac1ce397ffe5b05df06cdb56a30db4099c7428ec
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: kvm_arm_hyp_stacktrace_page
   >>> referenced by stacktrace.c:254 (arch/arm64/kernel/stacktrace.c:254)
   >>>               kernel/stacktrace.o:(hyp_dump_backtrace) in archive arch/arm64/built-in.a
   >>> referenced by stacktrace.c:254 (arch/arm64/kernel/stacktrace.c:254)
   >>>               kernel/stacktrace.o:(hyp_dump_backtrace) in archive arch/arm64/built-in.a

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
