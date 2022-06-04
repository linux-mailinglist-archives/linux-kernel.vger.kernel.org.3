Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7037453D626
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 10:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbiFDIjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 04:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbiFDIj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 04:39:28 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1582112D0A
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 01:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654331967; x=1685867967;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=p2asbGTYnRUKSc6CNgW+MxeAm9Vp8COBTvXPjJA1nPE=;
  b=M98GQiZ+RS07BnSb6bh8WazWyVO6jQjFEuMV3EYu2UI42PQnnnWUmYSq
   uXPnuocVHDNeu+dWk25d2MrarEFLTNmQmqwxHzMTb0Q5C/m7h0NksI4at
   JVvIl2ZeXbd0VfguM9kxBnS/MQCpfNTpYlP1iYMfk7CjW+Sul0Tn+rWwj
   E1qDNyXSBH6C9/ZDYC7lCLs0EMlwQuoAW2mubmumK1b6Y5gxbjBNe0nCe
   0MQTQbF73+WAGHTfQes7vTE4DBm5yYLLs3uanYVdiPPzpv/hMg7hcqXBf
   MFH2gXA0/ijurXN6480c4sPoNQNA3WhYN/huMcoBCskU8Ev3eYSxGusXM
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10367"; a="276175205"
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="276175205"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 01:39:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="531347788"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 04 Jun 2022 01:39:25 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxPJc-000AWB-9O;
        Sat, 04 Jun 2022 08:39:24 +0000
Date:   Sat, 4 Jun 2022 16:38:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bang Li <libang.linuxer@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vgupta@kernel.org>
Subject: arch/arc/kernel/smp.c:277:30: sparse: sparse: dereference of noderef
 expression
Message-ID: <202206041630.8CNeV2bc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   032dcf09e2bf7c822be25b4abef7a6c913870d98
commit: c6ed4d84a2c49de7d6f490144cca7b4a4831fb6e ARC: remove redundant READ_ONCE() in cmpxchg loop
date:   7 weeks ago
config: arc-randconfig-s032-20220603 (https://download.01.org/0day-ci/archive/20220604/202206041630.8CNeV2bc-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-18-g56afb504-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c6ed4d84a2c49de7d6f490144cca7b4a4831fb6e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c6ed4d84a2c49de7d6f490144cca7b4a4831fb6e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arc SHELL=/bin/bash arch/arc/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   arch/arc/kernel/smp.c:264:48: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __percpu *ipi_data_ptr @@     got unsigned long * @@
   arch/arc/kernel/smp.c:264:48: sparse:     expected unsigned long [noderef] __percpu *ipi_data_ptr
   arch/arc/kernel/smp.c:264:48: sparse:     got unsigned long *
   arch/arc/kernel/smp.c:279:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile *v @@     got unsigned long [noderef] __percpu *__ai_ptr @@
   arch/arc/kernel/smp.c:279:18: sparse:     expected void const volatile *v
   arch/arc/kernel/smp.c:279:18: sparse:     got unsigned long [noderef] __percpu *__ai_ptr
   arch/arc/kernel/smp.c:413:72: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected void [noderef] __percpu *percpu_dev_id @@     got int *dev @@
   arch/arc/kernel/smp.c:413:72: sparse:     expected void [noderef] __percpu *percpu_dev_id
   arch/arc/kernel/smp.c:413:72: sparse:     got int *dev
>> arch/arc/kernel/smp.c:277:30: sparse: sparse: dereference of noderef expression

vim +277 arch/arc/kernel/smp.c

   261	
   262	static void ipi_send_msg_one(int cpu, enum ipi_msg_type msg)
   263	{
   264		unsigned long __percpu *ipi_data_ptr = per_cpu_ptr(&ipi_data, cpu);
   265		unsigned long old, new;
   266		unsigned long flags;
   267	
   268		pr_debug("%d Sending msg [%d] to %d\n", smp_processor_id(), msg, cpu);
   269	
   270		local_irq_save(flags);
   271	
   272		/*
   273		 * Atomically write new msg bit (in case others are writing too),
   274		 * and read back old value
   275		 */
   276		do {
 > 277			new = old = *ipi_data_ptr;
   278			new |= 1U << msg;
   279		} while (cmpxchg(ipi_data_ptr, old, new) != old);
   280	
   281		/*
   282		 * Call the platform specific IPI kick function, but avoid if possible:
   283		 * Only do so if there's no pending msg from other concurrent sender(s).
   284		 * Otherwise, receiver will see this msg as well when it takes the
   285		 * IPI corresponding to that msg. This is true, even if it is already in
   286		 * IPI handler, because !@old means it has not yet dequeued the msg(s)
   287		 * so @new msg can be a free-loader
   288		 */
   289		if (plat_smp_ops.ipi_send && !old)
   290			plat_smp_ops.ipi_send(cpu);
   291	
   292		local_irq_restore(flags);
   293	}
   294	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
