Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41254ED8B7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 13:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbiCaLxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 07:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbiCaLxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 07:53:32 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2414520826F
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 04:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8e0iZrnnsPjluY5m9kw6M0KfCCgEKkKPgHri6PSqbww=; b=SBUeRPL4OWtCznombVrebeaTFj
        4lwFsqEU795lMMPjtPBVtzFu4eH8sOz+BLU4n1040D7JvHOtVDvrnxPR9XrKPdiextHKIGk5RLIuh
        Qm+QwTQUulAxWY/FCPLIBBgdD6b9F8xcwu8sqVCnLMBvCGzSDn3k6ngyyYIIfpAV31zp5T9k9jHcn
        qNE04gw2+ZR+4GtaCyuD8vD65Wmf1dGQrkR3izGSw2PCw9i9ue9V2tSrp66Zbz/t1NFTPQII818dJ
        vOo24gfOD3Cg2M2ig69y0FGbgJaWBEJDzO16JHW8YCVpDvN4blH2vKDosowO2ZzD6/+FcJ+LQsLs3
        vcDX/TUQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZtL0-0002sq-0U; Thu, 31 Mar 2022 11:51:38 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8F52D9861D6; Thu, 31 Mar 2022 13:51:37 +0200 (CEST)
Date:   Thu, 31 Mar 2022 13:51:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>
Subject: Re: arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_l1d_flush()+0xb5:
 missing int3 after ret
Message-ID: <20220331115137.GT8939@worktop.programming.kicks-ass.net>
References: <202203311730.Io171QCN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202203311730.Io171QCN-lkp@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 05:14:37PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   787af64d05cd528aac9ad16752d11bb1c6061bb9
> commit: e463a09af2f0677b9485a7e8e4e70b396b2ffb6f x86: Add straight-line-speculation mitigation
> date:   4 months ago
> config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220331/202203311730.Io171QCN-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e463a09af2f0677b9485a7e8e4e70b396b2ffb6f
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout e463a09af2f0677b9485a7e8e4e70b396b2ffb6f
>         # save the config file to linux build tree
>         mkdir build_dir
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/ samples/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_l1d_flush()+0xb5: missing int3 after ret
>    arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_l1d_flush()+0xf2: missing int3 after ret
> >> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_update_host_rsp()+0x2f: missing int3 after ret
> --
> >> arch/x86/kvm/x86.o: warning: objtool: kvm_spurious_fault()+0x34: missing int3 after ret
> --
>    arch/x86/xen/enlighten_pv.c:1181:34: warning: no previous prototype for 'xen_start_kernel' [-Wmissing-prototypes]
>     1181 | asmlinkage __visible void __init xen_start_kernel(void)
>          |                                  ^~~~~~~~~~~~~~~~
> >> arch/x86/xen/enlighten_pv.o: warning: objtool: xenpv_exc_debug()+0x46: missing int3 after ret
>    arch/x86/xen/enlighten_pv.o: warning: objtool: xenpv_exc_debug()+0x32: missing int3 after ret
> >> arch/x86/xen/enlighten_pv.o: warning: objtool: xenpv_exc_machine_check()+0x46: missing int3 after ret
>    arch/x86/xen/enlighten_pv.o: warning: objtool: xenpv_exc_machine_check()+0x32: missing int3 after ret
> --
> >> arch/x86/kernel/kvm.o: warning: objtool: __raw_callee_save___kvm_vcpu_is_preempted()+0x12: missing int3 after ret
> --
> >> arch/x86/mm/fault.o: warning: objtool: exc_page_fault()+0x124: missing int3 after ret
>    arch/x86/mm/fault.o: warning: objtool: exc_page_fault()+0x154: missing int3 after ret
> --
> >> arch/x86/crypto/poly1305-x86_64-cryptogams.o: warning: objtool: poly1305_init_x86_64()+0x3a: missing int3 after ret
> >> arch/x86/crypto/poly1305-x86_64-cryptogams.o: warning: objtool: poly1305_blocks_x86_64()+0xf2: missing int3 after ret
> >> arch/x86/crypto/poly1305-x86_64-cryptogams.o: warning: objtool: poly1305_emit_x86_64()+0x37: missing int3 after ret
> >> arch/x86/crypto/poly1305-x86_64-cryptogams.o: warning: objtool: __poly1305_block()+0x6d: missing int3 after ret
> >> arch/x86/crypto/poly1305-x86_64-cryptogams.o: warning: objtool: __poly1305_init_avx()+0x1e8: missing int3 after ret
> >> arch/x86/crypto/poly1305-x86_64-cryptogams.o: warning: objtool: poly1305_blocks_avx()+0x18a: missing int3 after ret
>    arch/x86/crypto/poly1305-x86_64-cryptogams.o: warning: objtool: poly1305_blocks_avx()+0xaf8: missing int3 after ret
> >> arch/x86/crypto/poly1305-x86_64-cryptogams.o: warning: objtool: poly1305_emit_avx()+0x99: missing int3 after ret
> >> arch/x86/crypto/poly1305-x86_64-cryptogams.o: warning: objtool: poly1305_blocks_avx2()+0x18a: missing int3 after ret
>    arch/x86/crypto/poly1305-x86_64-cryptogams.o: warning: objtool: poly1305_blocks_avx2()+0x776: missing int3 after ret
> >> arch/x86/crypto/poly1305-x86_64-cryptogams.o: warning: objtool: poly1305_blocks_avx512()+0x18a: missing int3 after ret
>    arch/x86/crypto/poly1305-x86_64-cryptogams.o: warning: objtool: poly1305_blocks_avx512()+0x796: missing int3 after ret
>    arch/x86/crypto/poly1305-x86_64-cryptogams.o: warning: objtool: poly1305_blocks_avx512()+0x10bd: missing int3 after ret
> --
> >> arch/x86/kernel/cpu/mce/core.o: warning: objtool: mce_wrmsrl.constprop.0()+0x6b: missing int3 after ret
>    arch/x86/kernel/cpu/mce/core.o: warning: objtool: mce_wrmsrl.constprop.0()+0x3e: missing int3 after ret
> >> arch/x86/kernel/cpu/mce/core.o: warning: objtool: exc_machine_check()+0x12a: missing int3 after ret
> >> arch/x86/kernel/cpu/mce/core.o: warning: objtool: noist_exc_machine_check()+0xfb: missing int3 after ret
>    arch/x86/kernel/cpu/mce/core.o: warning: objtool: noist_exc_machine_check()+0x121: missing int3 after ret
> --
> >> samples/ftrace/ftrace-direct-multi.o: warning: objtool: my_tramp()+0x10: missing int3 after ret

I think I sorted all those with these 5 patches here:

  https://lkml.kernel.org/r/20220322114809.381992456@infradead.org

3 of those are currently in the crypto tree, and I'll queue the two
remaining post -rc1.
