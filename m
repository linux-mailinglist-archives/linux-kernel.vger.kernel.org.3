Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAE24B402F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 04:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239926AbiBNDVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 22:21:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiBNDVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 22:21:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4C254187
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 19:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=PzNmb7ymhI1JBKsynhmh74W9Gs5DRP8aDGheazdf06s=; b=W9GlaXBalI+QgsgTDtM3on0yUf
        9XQ2zPtMTZsWX91p7LXNaOQu3tlb8/sSr7KVj8fTdeeiRBbbmeRkMRRxqk5TrclsRdSe0vHGbX/x3
        kgm4JA5Oe3LThK9b7uLdZDwq5dhtx/Ezz+4Yzv5+Kt5XG3TtXfJLwhTJjSfzPAyDxCSC4Tb4iZmoh
        pkuFJWaMr+y7rAH9T7a9oUM3SeqSnC6TymvpsOnXtbkFZlolZvkOpP7Jjutnzxc9nwVWzluGxCbT0
        oYMW1HX5GSEHtEa5mOSVUHNBtjLvtMHHDh4/95IV+lxFoqnY6aaBmgWWedj+zIPfeoTV+BtsbVkD7
        osmU1iow==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJRv8-00CVDZ-Kh; Mon, 14 Feb 2022 03:20:58 +0000
Message-ID: <99c19600-d6a7-75d3-3d00-e0423da92237@infradead.org>
Date:   Sun, 13 Feb 2022 19:20:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [tip:locking/core 1/2] vmlinux.o: warning: objtool:
 mce_start()+0x69: call to ftrace_likely_update() leaves .noinstr.text section
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, Borislav Petkov <bp@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>
References: <202202141123.gFaMRI4k-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <202202141123.gFaMRI4k-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/13/22 19:18, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
> head:   b008893b08dcc8c30d756db05c229a1491bcb992
> commit: f5c54f77b07b278cfde4a654e111c39996ac8b5b [1/2] cpumask: Add a x86-specific cpumask_clear_cpu() helper
> config: x86_64-randconfig-c002-20220214 (https://download.01.org/0day-ci/archive/20220214/202202141123.gFaMRI4k-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=f5c54f77b07b278cfde4a654e111c39996ac8b5b
>         git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
>         git fetch --no-tags tip locking/core
>         git checkout f5c54f77b07b278cfde4a654e111c39996ac8b5b
>         # save the config file to linux build tree
>         mkdir build_dir
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    vmlinux.o: warning: objtool: __rdgsbase_inactive()+0x34: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: __wrgsbase_inactive()+0x39: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: fixup_bad_iret()+0x72: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: noist_exc_debug()+0x39: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: exc_nmi()+0x31: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: poke_int3_handler()+0x47: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: mce_check_crashing_cpu()+0x2c: call to ftrace_likely_update() leaves .noinstr.text section
>>> vmlinux.o: warning: objtool: mce_start()+0x69: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: mce_read_aux()+0x41: call to mca_msr_reg() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: do_machine_check()+0x49: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: exc_machine_check()+0x4f: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: rcu_dynticks_eqs_enter()+0x1a: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: rcu_dynticks_eqs_exit()+0x1a: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: rcu_eqs_exit.constprop.0()+0x37: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: rcu_eqs_enter.constprop.0()+0x3c: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: rcu_irq_exit()+0x34: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: rcu_nmi_enter()+0x2e: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: rcu_irq_enter()+0x34: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: irqentry_nmi_enter()+0x48: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: irqentry_nmi_exit()+0x73: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: enter_from_user_mode()+0x58: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: syscall_enter_from_user_mode()+0x5e: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare()+0x58: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: irqentry_enter_from_user_mode()+0x58: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: irqentry_exit()+0x3c: call to ftrace_likely_update() leaves .noinstr.text section

Yes. See Peter's response here:
  https://lore.kernel.org/all/YgdqmbK7Irwa2Ryh@hirez.programming.kicks-ass.net/

-- 
~Randy
