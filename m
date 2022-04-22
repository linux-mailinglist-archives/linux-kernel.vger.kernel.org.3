Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D84550B812
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447758AbiDVNQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447710AbiDVNQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:16:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F48580C6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:13:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23358B82CF7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:13:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6B0C385A0;
        Fri, 22 Apr 2022 13:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650633195;
        bh=emSGr4+smQ98ALXdYO2qBhavUsM1G8UzwvYEe66FXYY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DBIfDx2g3yT0vWfX7yO4UKb/fA43qc9EBaBk3ZXlRDfWqHRCLxFDZNGZEHMwXN1i5
         3Dh3UX5kaNLEiednFqrhZHbA/RTQOAGBIOpM4rWkwAOCnN1BoM17PkKZLvtPN/61bp
         VEcgImBC4Yt91sIIr/PEbsFddW/G7oik7nn3OOuFxa7I4NnDviWVXDYv6yqAcn3BDk
         jaOZuRQvRT/820hc6CxL//c1UyuxVeqKlW0CusVuFGlzExjlZzEAHQ6E+JSJoZNfQL
         BMJ54cKeC173br5lBGmRimsvsMMsTJHTXm1MBwXD2hZMGAKYlu+UGKT2ryJTPodoDL
         PlInoSK+N4zMA==
Date:   Fri, 22 Apr 2022 22:13:12 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [linux-stable-rc:queue/4.19 3886/9999]
 arch/ia64/kernel/kprobes.c:414:24: error: implicit declaration of function
 '__kretprobe_trampoline_handler'; did you mean 'kretprobe_trampoline'?
Message-Id: <20220422221312.f1bc4222cd2eb871ff066e24@kernel.org>
In-Reply-To: <202204130102.JZPa6KCQ-lkp@intel.com>
References: <202204130102.JZPa6KCQ-lkp@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Can you revert/drop this patch from 4.19 stable tree?
This patch is a part of bigger series, which introduces a generic
arch-independent kretprobe trampoline handler, but that is not for the
stable tree.

Also, the commit f5f96e3643dc33d6117cf7047e73512046e4858b is in the 4.19
stable tree, which fixes this commit. Thus that must be removed too.

Thank you,

On Wed, 13 Apr 2022 01:59:56 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Masami,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/4.19
> head:   bdfbd5df0daf1748bef4501ce255ce594ee8d55f
> commit: d3380de483d55d904fb94a241406b34ed2fada7d [3886/9999] ia64: kprobes: Use generic kretprobe trampoline handler
> config: ia64-allyesconfig (https://download.01.org/0day-ci/archive/20220413/202204130102.JZPa6KCQ-lkp@intel.com/config)
> compiler: ia64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=d3380de483d55d904fb94a241406b34ed2fada7d
>         git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
>         git fetch --no-tags linux-stable-rc queue/4.19
>         git checkout d3380de483d55d904fb94a241406b34ed2fada7d
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    arch/ia64/kernel/kprobes.c: In function 'get_kprobe_inst':
>    arch/ia64/kernel/kprobes.c:338:22: warning: variable 'template' set but not used [-Wunused-but-set-variable]
>      338 |         unsigned int template;
>          |                      ^~~~~~~~
>    arch/ia64/kernel/kprobes.c: At top level:
>    arch/ia64/kernel/kprobes.c:412:15: warning: no previous prototype for 'trampoline_probe_handler' [-Wmissing-prototypes]
>      412 | int __kprobes trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
>          |               ^~~~~~~~~~~~~~~~~~~~~~~~
>    arch/ia64/kernel/kprobes.c: In function 'trampoline_probe_handler':
> >> arch/ia64/kernel/kprobes.c:414:24: error: implicit declaration of function '__kretprobe_trampoline_handler'; did you mean 'kretprobe_trampoline'? [-Werror=implicit-function-declaration]
>      414 |         regs->cr_iip = __kretprobe_trampoline_handler(regs, kretprobe_trampoline, NULL);
>          |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>          |                        kretprobe_trampoline
>    At top level:
>    arch/ia64/kernel/kprobes.c:928:13: warning: 'ia64_get_bsp_cfm' defined but not used [-Wunused-function]
>      928 | static void ia64_get_bsp_cfm(struct unw_frame_info *info, void *arg)
>          |             ^~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
> 
> Kconfig warnings: (for reference only)
>    WARNING: unmet direct dependencies detected for FRAME_POINTER
>    Depends on DEBUG_KERNEL && (M68K || UML || SUPERH) || ARCH_WANT_FRAME_POINTERS
>    Selected by
>    - FAULT_INJECTION_STACKTRACE_FILTER && FAULT_INJECTION_DEBUG_FS && STACKTRACE_SUPPORT && !X86_64 && !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM_UNWIND && !ARC && !X86
> 
> 
> vim +414 arch/ia64/kernel/kprobes.c
> 
>    333	
>    334	static void __kprobes get_kprobe_inst(bundle_t *bundle, uint slot,
>    335		       	unsigned long *kprobe_inst, uint *major_opcode)
>    336	{
>    337		unsigned long kprobe_inst_p0, kprobe_inst_p1;
>  > 338		unsigned int template;
>    339	
>    340		template = bundle->quad0.template;
>    341	
>    342		switch (slot) {
>    343		  case 0:
>    344			*major_opcode = (bundle->quad0.slot0 >> SLOT0_OPCODE_SHIFT);
>    345			*kprobe_inst = bundle->quad0.slot0;
>    346			  break;
>    347		  case 1:
>    348			*major_opcode = (bundle->quad1.slot1_p1 >> SLOT1_p1_OPCODE_SHIFT);
>    349			kprobe_inst_p0 = bundle->quad0.slot1_p0;
>    350			kprobe_inst_p1 = bundle->quad1.slot1_p1;
>    351			*kprobe_inst = kprobe_inst_p0 | (kprobe_inst_p1 << (64-46));
>    352			break;
>    353		  case 2:
>    354			*major_opcode = (bundle->quad1.slot2 >> SLOT2_OPCODE_SHIFT);
>    355			*kprobe_inst = bundle->quad1.slot2;
>    356			break;
>    357		}
>    358	}
>    359	
>    360	/* Returns non-zero if the addr is in the Interrupt Vector Table */
>    361	static int __kprobes in_ivt_functions(unsigned long addr)
>    362	{
>    363		return (addr >= (unsigned long)__start_ivt_text
>    364			&& addr < (unsigned long)__end_ivt_text);
>    365	}
>    366	
>    367	static int __kprobes valid_kprobe_addr(int template, int slot,
>    368					       unsigned long addr)
>    369	{
>    370		if ((slot > 2) || ((bundle_encoding[template][1] == L) && slot > 1)) {
>    371			printk(KERN_WARNING "Attempting to insert unaligned kprobe "
>    372					"at 0x%lx\n", addr);
>    373			return -EINVAL;
>    374		}
>    375	
>    376		if (in_ivt_functions(addr)) {
>    377			printk(KERN_WARNING "Kprobes can't be inserted inside "
>    378					"IVT functions at 0x%lx\n", addr);
>    379			return -EINVAL;
>    380		}
>    381	
>    382		return 0;
>    383	}
>    384	
>    385	static void __kprobes save_previous_kprobe(struct kprobe_ctlblk *kcb)
>    386	{
>    387		unsigned int i;
>    388		i = atomic_add_return(1, &kcb->prev_kprobe_index);
>    389		kcb->prev_kprobe[i-1].kp = kprobe_running();
>    390		kcb->prev_kprobe[i-1].status = kcb->kprobe_status;
>    391	}
>    392	
>    393	static void __kprobes restore_previous_kprobe(struct kprobe_ctlblk *kcb)
>    394	{
>    395		unsigned int i;
>    396		i = atomic_read(&kcb->prev_kprobe_index);
>    397		__this_cpu_write(current_kprobe, kcb->prev_kprobe[i-1].kp);
>    398		kcb->kprobe_status = kcb->prev_kprobe[i-1].status;
>    399		atomic_sub(1, &kcb->prev_kprobe_index);
>    400	}
>    401	
>    402	static void __kprobes set_current_kprobe(struct kprobe *p,
>    403				struct kprobe_ctlblk *kcb)
>    404	{
>    405		__this_cpu_write(current_kprobe, p);
>    406	}
>    407	
>    408	static void kretprobe_trampoline(void)
>    409	{
>    410	}
>    411	
>    412	int __kprobes trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
>    413	{
>  > 414		regs->cr_iip = __kretprobe_trampoline_handler(regs, kretprobe_trampoline, NULL);
>    415		/*
>    416		 * By returning a non-zero value, we are telling
>    417		 * kprobe_handler() that we don't want the post_handler
>    418		 * to run (and have re-enabled preemption)
>    419		 */
>    420		return 1;
>    421	}
>    422	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp


-- 
Masami Hiramatsu <mhiramat@kernel.org>
