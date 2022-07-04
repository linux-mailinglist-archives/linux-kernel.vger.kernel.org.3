Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06DD56519C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbiGDKCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234200AbiGDKCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:02:09 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD329DECC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 03:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656928865; x=1688464865;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rZJZNYyUjaCklL7GHEnhlSGt+cA2Y29hgj1ktyJ5UEc=;
  b=ZuYc6aoWpofOnLq51NIuCoBg1C0a+oeQ3T5pu8Jzh2VoAGH8OMApJnzR
   JF57oZvNkeFvNy2yyV1d312RT/W4RfNlNDWaOEEPQXeuygAozVlVxBfFP
   GHkb7+enTrZaYXj8RtXwGvOwTpGkxylB3w3F6cSoY45uGGus2YmyJ2uVH
   UpzAkrnqtaNCYsxy/jdACJO9bMlZPFH75yYzB8LbxOirR5p0cbnUc+Fy1
   0+55Th3sJ3fPb632wh3AoliwrBLJiF9HezlBADowKc3ChIKAu7uY7+nky
   Ilsn3sSPHJmGyYF3YzqNsmkTtnFFD06Uh16eVfQsaQX9D8XmgeFHC3Jkg
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="283118763"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="283118763"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 03:01:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="682145055"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Jul 2022 03:01:04 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8It5-000Hml-CO;
        Mon, 04 Jul 2022 10:01:03 +0000
Date:   Mon, 4 Jul 2022 18:00:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [avpatel:riscv_kvm_aia_v1 27/28] arch/riscv/kvm/aia_aplic.c:264:6:
 warning: variable 'inject' is used uninitialized whenever 'if' condition is
 true
Message-ID: <202207041703.6Z7hrqnM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git riscv_kvm_aia_v1
head:   c830f720ffbbcea6f88ee7335a86c047b68004bc
commit: d51776ea544550a51604f697f23e5ee2bd1114b5 [27/28] RISC-V: KVM: Add in-kernel emulation of AIA APLIC
config: riscv-rv32_defconfig (https://download.01.org/0day-ci/archive/20220704/202207041703.6Z7hrqnM-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f7a80c3d08d4821e621fc88d6a2e435291f82dff)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv-linux-gnu
        # https://github.com/avpatel/linux/commit/d51776ea544550a51604f697f23e5ee2bd1114b5
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel riscv_kvm_aia_v1
        git checkout d51776ea544550a51604f697f23e5ee2bd1114b5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kvm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/riscv/kvm/aia_aplic.c:264:6: warning: variable 'inject' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (irqd->sourcecfg & APLIC_SOURCECFG_D)
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/kvm/aia_aplic.c:303:6: note: uninitialized use occurs here
           if (inject)
               ^~~~~~
   arch/riscv/kvm/aia_aplic.c:264:2: note: remove the 'if' if its condition is always false
           if (irqd->sourcecfg & APLIC_SOURCECFG_D)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/kvm/aia_aplic.c:252:13: note: initialize the variable 'inject' to silence this warning
           bool inject, ie;
                      ^
                       = 0
   1 warning generated.


vim +264 arch/riscv/kvm/aia_aplic.c

   248	
   249	int kvm_riscv_aia_aplic_inject(struct kvm *kvm, u32 source, bool level)
   250	{
   251		u32 target;
   252		bool inject, ie;
   253		unsigned long flags;
   254		struct aplic_irq *irqd;
   255		struct aplic *aplic = kvm->arch.aia.aplic_state;
   256	
   257		if (!aplic || !source || (aplic->nr_irqs <= source))
   258			return -ENODEV;
   259		irqd = &aplic->irqs[source];
   260		ie = (aplic->domaincfg & APLIC_DOMAINCFG_IE) ? true : false;
   261	
   262		raw_spin_lock_irqsave(&irqd->lock, flags);
   263	
 > 264		if (irqd->sourcecfg & APLIC_SOURCECFG_D)
   265			goto skip_unlock;
   266	
   267		switch (irqd->sourcecfg & APLIC_SOURCECFG_SM_MASK) {
   268		case APLIC_SOURCECFG_SM_EDGE_RISE:
   269			if (level && !(irqd->state & APLIC_IRQ_STATE_INPUT) &&
   270			    !(irqd->state & APLIC_IRQ_STATE_PENDING))
   271				irqd->state |= APLIC_IRQ_STATE_PENDING;
   272			break;
   273		case APLIC_SOURCECFG_SM_EDGE_FALL:
   274			if (!level && (irqd->state & APLIC_IRQ_STATE_INPUT) &&
   275			    !(irqd->state & APLIC_IRQ_STATE_PENDING))
   276				irqd->state |= APLIC_IRQ_STATE_PENDING;
   277			break;
   278		case APLIC_SOURCECFG_SM_LEVEL_HIGH:
   279			if (level && !(irqd->state & APLIC_IRQ_STATE_PENDING))
   280				irqd->state |= APLIC_IRQ_STATE_PENDING;
   281			break;
   282		case APLIC_SOURCECFG_SM_LEVEL_LOW:
   283			if (!level && !(irqd->state & APLIC_IRQ_STATE_PENDING))
   284				irqd->state |= APLIC_IRQ_STATE_PENDING;
   285			break;
   286		}
   287	
   288		if (level)
   289			irqd->state |= APLIC_IRQ_STATE_INPUT;
   290		else
   291			irqd->state &= ~APLIC_IRQ_STATE_INPUT;
   292	
   293		inject = false;
   294		target = irqd->target;
   295		if (ie && (irqd->state & APLIC_IRQ_STATE_ENPEND)) {
   296			irqd->state &= ~APLIC_IRQ_STATE_PENDING;
   297			inject = true;
   298		}
   299	
   300	skip_unlock:
   301		raw_spin_unlock_irqrestore(&irqd->lock, flags);
   302	
   303		if (inject)
   304			aplic_inject_msi(kvm, source, target);
   305	
   306		return 0;
   307	}
   308	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
