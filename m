Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8967853B0B7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 02:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbiFBATB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 20:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbiFBAS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 20:18:58 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA192296303
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 17:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654129137; x=1685665137;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9RbFovD48hyxruRDdIoOpiROhUh41L0yn94NAxXemzM=;
  b=IhaKvJIZf1C58gyeBWLfMxXECeKbcw+8JQHJhExWfh1PjsTxivc2wvSN
   kKZhCzDRhBorgjlkZi5Pgar0ucGuq3snrneVkZI/i3hpcbb6vWVNebJ3o
   dmZOUBKd7DTscLLUo6FVoffZEhU88RcrpV089cdK/JCYjZdY5HwCVNKo1
   GPMLHDWpe/LuEY9a/KvrBz0C1ngwQRGwAvO8IMnpQpG69mO6HaOrWiPUt
   oUQEQ4ft3uHp4x9SaROYJAxHdE1A3KMLHP34LaHomF2MD+LlYqihB4fw7
   HzHIJBCmvbbq1oUVJ+G+Shi34OyssvA3dezOL7ZRn498DHuW1aCU7GRDN
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="336426361"
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; 
   d="scan'208";a="336426361"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 17:18:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; 
   d="scan'208";a="530317885"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 01 Jun 2022 17:18:55 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwYYB-0004Z8-8F;
        Thu, 02 Jun 2022 00:18:55 +0000
Date:   Thu, 2 Jun 2022 08:18:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Julien Grall <julien.grall@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: arch/arm64/kvm/vmid.c:62 flush_context() warn: inconsistent indenting
Message-ID: <202206020819.HlyEM8rW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julien,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8171acb8bc9b33f3ed827f0615b24f7a06495cd0
commit: 3248136b3637e1671e4fa46e32e2122f9ec4bc3d KVM: arm64: Align the VMID allocation with the arm64 ASID
date:   4 months ago
config: arm64-randconfig-m031-20220530 (https://download.01.org/0day-ci/archive/20220602/202206020819.HlyEM8rW-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
arch/arm64/kvm/vmid.c:62 flush_context() warn: inconsistent indenting

vim +62 arch/arm64/kvm/vmid.c

417838392f2e657 Shameer Kolothum 2021-11-22  34  
417838392f2e657 Shameer Kolothum 2021-11-22  35  #define vmid_gen_match(vmid) \
417838392f2e657 Shameer Kolothum 2021-11-22  36  	(!(((vmid) ^ atomic64_read(&vmid_generation)) >> kvm_arm_vmid_bits))
417838392f2e657 Shameer Kolothum 2021-11-22  37  
417838392f2e657 Shameer Kolothum 2021-11-22  38  static void flush_context(void)
417838392f2e657 Shameer Kolothum 2021-11-22  39  {
417838392f2e657 Shameer Kolothum 2021-11-22  40  	int cpu;
417838392f2e657 Shameer Kolothum 2021-11-22  41  	u64 vmid;
417838392f2e657 Shameer Kolothum 2021-11-22  42  
417838392f2e657 Shameer Kolothum 2021-11-22  43  	bitmap_clear(vmid_map, 0, NUM_USER_VMIDS);
417838392f2e657 Shameer Kolothum 2021-11-22  44  
417838392f2e657 Shameer Kolothum 2021-11-22  45  	for_each_possible_cpu(cpu) {
417838392f2e657 Shameer Kolothum 2021-11-22  46  		vmid = atomic64_xchg_relaxed(&per_cpu(active_vmids, cpu), 0);
417838392f2e657 Shameer Kolothum 2021-11-22  47  
417838392f2e657 Shameer Kolothum 2021-11-22  48  		/* Preserve reserved VMID */
417838392f2e657 Shameer Kolothum 2021-11-22  49  		if (vmid == 0)
417838392f2e657 Shameer Kolothum 2021-11-22  50  			vmid = per_cpu(reserved_vmids, cpu);
417838392f2e657 Shameer Kolothum 2021-11-22  51  		__set_bit(vmid2idx(vmid), vmid_map);
417838392f2e657 Shameer Kolothum 2021-11-22  52  		per_cpu(reserved_vmids, cpu) = vmid;
417838392f2e657 Shameer Kolothum 2021-11-22  53  	}
417838392f2e657 Shameer Kolothum 2021-11-22  54  
417838392f2e657 Shameer Kolothum 2021-11-22  55  	/*
417838392f2e657 Shameer Kolothum 2021-11-22  56  	 * Unlike ASID allocator, we expect less frequent rollover in
417838392f2e657 Shameer Kolothum 2021-11-22  57  	 * case of VMIDs. Hence, instead of marking the CPU as
417838392f2e657 Shameer Kolothum 2021-11-22  58  	 * flush_pending and issuing a local context invalidation on
417838392f2e657 Shameer Kolothum 2021-11-22  59  	 * the next context-switch, we broadcast TLB flush + I-cache
417838392f2e657 Shameer Kolothum 2021-11-22  60  	 * invalidation over the inner shareable domain on rollover.
417838392f2e657 Shameer Kolothum 2021-11-22  61  	 */
417838392f2e657 Shameer Kolothum 2021-11-22 @62  	 kvm_call_hyp(__kvm_flush_vm_context);
417838392f2e657 Shameer Kolothum 2021-11-22  63  }
417838392f2e657 Shameer Kolothum 2021-11-22  64  

:::::: The code at line 62 was first introduced by commit
:::::: 417838392f2e657ee25cc30e373ff4c35a0faa90 KVM: arm64: Introduce a new VMID allocator for KVM

:::::: TO: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
:::::: CC: Marc Zyngier <maz@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
