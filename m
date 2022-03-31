Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04AA24ED69C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 11:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbiCaJQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 05:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbiCaJQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 05:16:45 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D912CA0FB
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 02:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648718097; x=1680254097;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pXOuzQYr/d9cHEXuvFCt+4ZxeZDdyCyLFVcDvahNi2A=;
  b=A6Lljr0QaI+9FKEC6Z4moXRK4yPTTT2/NeUSg9OMteeMIpvuOWymU0lg
   LmtmCPlk0WsCCnGSjOpdvV6EtKNcppZ/jAfyKPKc4PfGBvF4aK01PMZGD
   TEjPJ/KxmyHI5lec8kJC7rt4Imi5mrolx8Sld/JX5rh413LZfr2j09eCb
   WyQwq3TXB7FbM+njmWPxc+otb0Ul5eHs077++Kr5snVKndYWoisnXdcj+
   COYec2xT8AiNGygoUxGS0uyVIEYQUKqWXRrPL6aEmInFxB86wM2PGBKlW
   YyCHQqIZfka9n0BTH+s11SMG+UfouWiKlFlLsCQPrsa0QHGavaYmXfW0Z
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="247273888"
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="247273888"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 02:14:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="720377634"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 31 Mar 2022 02:14:51 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZqtG-00007M-Rl;
        Thu, 31 Mar 2022 09:14:50 +0000
Date:   Thu, 31 Mar 2022 17:14:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>
Subject: arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_l1d_flush()+0xb5:
 missing int3 after ret
Message-ID: <202203311730.Io171QCN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   787af64d05cd528aac9ad16752d11bb1c6061bb9
commit: e463a09af2f0677b9485a7e8e4e70b396b2ffb6f x86: Add straight-line-speculation mitigation
date:   4 months ago
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220331/202203311730.Io171QCN-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e463a09af2f0677b9485a7e8e4e70b396b2ffb6f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e463a09af2f0677b9485a7e8e4e70b396b2ffb6f
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/ samples/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_l1d_flush()+0xb5: missing int3 after ret
   arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_l1d_flush()+0xf2: missing int3 after ret
>> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_update_host_rsp()+0x2f: missing int3 after ret
--
>> arch/x86/kvm/x86.o: warning: objtool: kvm_spurious_fault()+0x34: missing int3 after ret
--
   arch/x86/xen/enlighten_pv.c:1181:34: warning: no previous prototype for 'xen_start_kernel' [-Wmissing-prototypes]
    1181 | asmlinkage __visible void __init xen_start_kernel(void)
         |                                  ^~~~~~~~~~~~~~~~
>> arch/x86/xen/enlighten_pv.o: warning: objtool: xenpv_exc_debug()+0x46: missing int3 after ret
   arch/x86/xen/enlighten_pv.o: warning: objtool: xenpv_exc_debug()+0x32: missing int3 after ret
>> arch/x86/xen/enlighten_pv.o: warning: objtool: xenpv_exc_machine_check()+0x46: missing int3 after ret
   arch/x86/xen/enlighten_pv.o: warning: objtool: xenpv_exc_machine_check()+0x32: missing int3 after ret
--
>> arch/x86/kernel/kvm.o: warning: objtool: __raw_callee_save___kvm_vcpu_is_preempted()+0x12: missing int3 after ret
--
>> arch/x86/mm/fault.o: warning: objtool: exc_page_fault()+0x124: missing int3 after ret
   arch/x86/mm/fault.o: warning: objtool: exc_page_fault()+0x154: missing int3 after ret
--
>> arch/x86/crypto/poly1305-x86_64-cryptogams.o: warning: objtool: poly1305_init_x86_64()+0x3a: missing int3 after ret
>> arch/x86/crypto/poly1305-x86_64-cryptogams.o: warning: objtool: poly1305_blocks_x86_64()+0xf2: missing int3 after ret
>> arch/x86/crypto/poly1305-x86_64-cryptogams.o: warning: objtool: poly1305_emit_x86_64()+0x37: missing int3 after ret
>> arch/x86/crypto/poly1305-x86_64-cryptogams.o: warning: objtool: __poly1305_block()+0x6d: missing int3 after ret
>> arch/x86/crypto/poly1305-x86_64-cryptogams.o: warning: objtool: __poly1305_init_avx()+0x1e8: missing int3 after ret
>> arch/x86/crypto/poly1305-x86_64-cryptogams.o: warning: objtool: poly1305_blocks_avx()+0x18a: missing int3 after ret
   arch/x86/crypto/poly1305-x86_64-cryptogams.o: warning: objtool: poly1305_blocks_avx()+0xaf8: missing int3 after ret
>> arch/x86/crypto/poly1305-x86_64-cryptogams.o: warning: objtool: poly1305_emit_avx()+0x99: missing int3 after ret
>> arch/x86/crypto/poly1305-x86_64-cryptogams.o: warning: objtool: poly1305_blocks_avx2()+0x18a: missing int3 after ret
   arch/x86/crypto/poly1305-x86_64-cryptogams.o: warning: objtool: poly1305_blocks_avx2()+0x776: missing int3 after ret
>> arch/x86/crypto/poly1305-x86_64-cryptogams.o: warning: objtool: poly1305_blocks_avx512()+0x18a: missing int3 after ret
   arch/x86/crypto/poly1305-x86_64-cryptogams.o: warning: objtool: poly1305_blocks_avx512()+0x796: missing int3 after ret
   arch/x86/crypto/poly1305-x86_64-cryptogams.o: warning: objtool: poly1305_blocks_avx512()+0x10bd: missing int3 after ret
--
>> arch/x86/kernel/cpu/mce/core.o: warning: objtool: mce_wrmsrl.constprop.0()+0x6b: missing int3 after ret
   arch/x86/kernel/cpu/mce/core.o: warning: objtool: mce_wrmsrl.constprop.0()+0x3e: missing int3 after ret
>> arch/x86/kernel/cpu/mce/core.o: warning: objtool: exc_machine_check()+0x12a: missing int3 after ret
>> arch/x86/kernel/cpu/mce/core.o: warning: objtool: noist_exc_machine_check()+0xfb: missing int3 after ret
   arch/x86/kernel/cpu/mce/core.o: warning: objtool: noist_exc_machine_check()+0x121: missing int3 after ret
--
>> samples/ftrace/ftrace-direct-multi.o: warning: objtool: my_tramp()+0x10: missing int3 after ret

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
