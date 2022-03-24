Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3169F4E6151
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 10:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349367AbiCXJyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 05:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241065AbiCXJyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 05:54:06 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3944D9F6C3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 02:52:32 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id t13so2162197pgn.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 02:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VKsAFrEW5UakIPwCeIroVBiJ0SXVbCowO3E0PKINvAY=;
        b=p4DnDcauGaHCZN0uk8XvAlx+9fgCE/B4S71OYScEqwcX3SDlFK7PRoVqXrJGVYHH0o
         YGpeLe59IA+TH2B3QPtRpj1UDk1HT8XOo7HwBI3h1v0Zou0NQzs+K8Xz9BiCyQv+AvjE
         esS+JURGUHAZeWoCADZuCmRL80c64U8z23DnYVL7FoG3Cr5OCZ778oDyy+mN1DmVYclP
         PipBl5iN+heX6wIEbByXgn2h1qT8HKR0Jti6rKS12gCOyPM61WsFugiCT3MVt2ZsTfn0
         KuY2z3/JsHFRvHZdWSEYIx7dli7ZGUfaIqMVDkeSM2p9/HJPwqwG/MdM/VRd+ZZXdUpF
         L65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VKsAFrEW5UakIPwCeIroVBiJ0SXVbCowO3E0PKINvAY=;
        b=S79XY1CyKfgQiXxFJjCTERyRmpCrmrP1llC0UU/9dnB8gLSbCt/ro1sXQJb97LZJps
         DwAK4kxkO+6KoM9DFQJGJGGDG3CsBlh4ld42Vfv9U7dCDlBozcEhYgUooxQfjC37YcKb
         QKsaeZfc+LYlvydTXC3y8RTdPH2SKRvKUXkIQciLWyoSVGP63YwP0mwUrin2ats4zXAU
         0Y5VJCSUliBaPzFDVNAU8aGBB59BLIQRyXD9xiytjQVTd9adyOcb14fNxYWJKNsDBa1h
         l6tAdBXNWgghWD4+OG16Rjp1+EL65Ep+enLr5rSjwB49NxQitWz237GFQsnjvTt35BPS
         KCdw==
X-Gm-Message-State: AOAM530w27BO4bOLiW0u5Oe81qG5akVrRoGVwxj9F3fw1fxXHSgYCNaU
        usD/mmP6Lw4oukl0vhr/GbA=
X-Google-Smtp-Source: ABdhPJwW4WxoPkIhsi9NdtX2bZxtH2zczxjO5xyMYLXYaMjOzH/aRfukd3q/Bz0krwDasbL5gWLQMg==
X-Received: by 2002:a05:6a00:238f:b0:4f6:b09a:4c63 with SMTP id f15-20020a056a00238f00b004f6b09a4c63mr4460064pfc.35.1648115550723;
        Thu, 24 Mar 2022 02:52:30 -0700 (PDT)
Received: from odroid ([114.29.23.97])
        by smtp.gmail.com with ESMTPSA id b20-20020a17090a991400b001befe07ae5csm8733370pjp.22.2022.03.24.02.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 02:52:29 -0700 (PDT)
Date:   Thu, 24 Mar 2022 09:52:18 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Oliver Glitta <glittao@gmail.com>, lkp@lists.01.org, lkp@intel.com,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Marco Elever <elver@google.com>,
        Imran Khan <imran.f.khan@oracle.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zqiang <qiang.zhang@windriver.com>
Subject: Re: [mm/slub]  555b8c8cb3:
 WARNING:at_lib/stackdepot.c:#stack_depot_fetch
Message-ID: <20220324095218.GA2108184@odroid>
References: <20220323090520.GG16885@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323090520.GG16885@xsang-OptiPlex-9020>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 05:05:20PM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 555b8c8cb3f335ec8fd9d1ffd25e1395790d102d ("mm/slub: use stackdepot to save stack trace in objects")
> https://git.kernel.org/cgit/linux/kernel/git/vbabka/linux.git slub-stackdepot-v3r1
> 
> in testcase: rcutorture
> version: 
> with following parameters:
> 
> 	runtime: 300s
> 	test: cpuhotplug
> 	torture_type: tasks
> 

[+Cc Vlastimil, linux-mm, and people related to stackdepot]

I'm going to spend time on it.
I have no clue why this happened yet.

> test-description: rcutorture is rcutorture kernel module load/unload test.
> test-url: https://www.kernel.org/doc/Documentation/RCU/torture.txt
> 
> 
> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> (please be noted the issue is random, we observed it 4 times out of 32 runs.
> parent keeps clean on 32 runs.)
> 
> [ 318.532656][ T1741] WARNING: CPU: 0 PID: 1741 at lib/stackdepot.c:326 stack_depot_fetch (lib/stackdepot.c:326 (discriminator 1)) 
> [  318.534566][ T1741] Modules linked in: rcutorture(-) torture aesni_intel crypto_simd cryptd input_leds pcspkr qemu_fw_cfg tiny_power_button button
> [  318.537087][ T1741] CPU: 0 PID: 1741 Comm: rmmod Not tainted 5.17.0-rc1-00003-g555b8c8cb3f3 #1 1fcfbabccf3b829d5910183510efdc3cb11ab20b
> [  318.539366][ T1741] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [ 318.541093][ T1741] EIP: stack_depot_fetch (lib/stackdepot.c:326 (discriminator 1)) 
> [ 318.542104][ T1741] Code: 66 81 e3 ff 03 85 c0 74 26 89 d6 89 c7 8b 15 f0 56 3e d5 81 e7 ff ff 1f 00 39 d7 7e 16 50 52 57 68 20 37 59 d4 e8 47 f4 50 00 <0f> 0b 83 c4 10 31 c0 eb 2f 81 ff ff 1f 00 00 76 0c 89 fa b8 04 bd
> All code
> ========
>    0:	66 81 e3 ff 03       	and    $0x3ff,%bx
>    5:	85 c0                	test   %eax,%eax
>    7:	74 26                	je     0x2f
>    9:	89 d6                	mov    %edx,%esi
>    b:	89 c7                	mov    %eax,%edi
>    d:	8b 15 f0 56 3e d5    	mov    -0x2ac1a910(%rip),%edx        # 0xffffffffd53e5703
>   13:	81 e7 ff ff 1f 00    	and    $0x1fffff,%edi
>   19:	39 d7                	cmp    %edx,%edi
>   1b:	7e 16                	jle    0x33
>   1d:	50                   	push   %rax
>   1e:	52                   	push   %rdx
>   1f:	57                   	push   %rdi
>   20:	68 20 37 59 d4       	pushq  $0xffffffffd4593720
>   25:	e8 47 f4 50 00       	callq  0x50f471
>   2a:*	0f 0b                	ud2    		<-- trapping instruction
>   2c:	83 c4 10             	add    $0x10,%esp
>   2f:	31 c0                	xor    %eax,%eax
>   31:	eb 2f                	jmp    0x62
>   33:	81 ff ff 1f 00 00    	cmp    $0x1fff,%edi
>   39:	76 0c                	jbe    0x47
>   3b:	89 fa                	mov    %edi,%edx
>   3d:	b8                   	.byte 0xb8
>   3e:	04 bd                	add    $0xbd,%al
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	0f 0b                	ud2    
>    2:	83 c4 10             	add    $0x10,%esp
>    5:	31 c0                	xor    %eax,%eax
>    7:	eb 2f                	jmp    0x38
>    9:	81 ff ff 1f 00 00    	cmp    $0x1fff,%edi
>    f:	76 0c                	jbe    0x1d
>   11:	89 fa                	mov    %edi,%edx
>   13:	b8                   	.byte 0xb8
>   14:	04 bd                	add    $0xbd,%al
> [  318.545357][ T1741] EAX: 0000003a EBX: 0000016d ECX: 00000027 EDX: d471aa3c
> [  318.546659][ T1741] ESI: f4a31e20 EDI: 000cafae EBP: f4a31e0c ESP: f4a31df0
> [  318.547930][ T1741] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00010296
> [  318.549302][ T1741] CR0: 80050033 CR2: b7234000 CR3: 3493c000 CR4: 000406d0
> [  318.550616][ T1741] Call Trace:
> [ 318.551322][ T1741] kmem_obj_info (mm/slub.c:4365) 
> [ 318.552241][ T1741] kmem_dump_obj (mm/slab_common.c:594) 
> [ 318.553214][ T1741] mem_dump_obj (mm/util.c:1026) 
> [ 318.554068][ T1741] rcu_torture_cleanup+0x3be/0x613 rcutorture
> [ 318.555861][ T1741] ? rcu_read_lock_sched_held (kernel/rcu/update.c:125) 
> [ 318.557037][ T1741] ? prepare_to_wait_exclusive (kernel/sched/wait.c:415) 
> [ 318.558077][ T1741] rcu_torture_cleanup (kernel/rcu/rcutorture.c:3008) rcutorture
> [ 318.559763][ T1741] __ia32_sys_delete_module (kernel/module.c:969 kernel/module.c:912 kernel/module.c:912) 
> [ 318.560840][ T1741] ? lock_release (kernel/locking/lockdep.c:5315 kernel/locking/lockdep.c:5659) 
> [ 318.561769][ T1741] ? __might_fault (mm/memory.c:5272 mm/memory.c:5257) 
> [ 318.562605][ T1741] __do_fast_syscall_32 (arch/x86/entry/common.c:112 arch/x86/entry/common.c:178) 
> [ 318.563575][ T1741] do_fast_syscall_32 (arch/x86/entry/common.c:203) 
> [ 318.564559][ T1741] do_SYSENTER_32 (arch/x86/entry/common.c:247) 
> [ 318.565406][ T1741] entry_SYSENTER_32 (arch/x86/entry/entry_32.S:869) 
> [  318.566306][ T1741] EIP: 0xb7edb549
> [ 318.567141][ T1741] Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
> All code
> ========
>    0:	03 74 c0 01          	add    0x1(%rax,%rax,8),%esi
>    4:	10 05 03 74 b8 01    	adc    %al,0x1b87403(%rip)        # 0x1b8740d
>    a:	10 06                	adc    %al,(%rsi)
>    c:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
>   10:	10 07                	adc    %al,(%rdi)
>   12:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
>   16:	10 08                	adc    %cl,(%rax)
>   18:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
>   1c:	00 00                	add    %al,(%rax)
>   1e:	00 00                	add    %al,(%rax)
>   20:	00 51 52             	add    %dl,0x52(%rcx)
>   23:	55                   	push   %rbp
>   24:	89 e5                	mov    %esp,%ebp
>   26:	0f 34                	sysenter 
>   28:	cd 80                	int    $0x80
>   2a:*	5d                   	pop    %rbp		<-- trapping instruction
>   2b:	5a                   	pop    %rdx
>   2c:	59                   	pop    %rcx
>   2d:	c3                   	retq   
>   2e:	90                   	nop
>   2f:	90                   	nop
>   30:	90                   	nop
>   31:	90                   	nop
>   32:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
>   39:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	5d                   	pop    %rbp
>    1:	5a                   	pop    %rdx
>    2:	59                   	pop    %rcx
>    3:	c3                   	retq   
>    4:	90                   	nop
>    5:	90                   	nop
>    6:	90                   	nop
>    7:	90                   	nop
>    8:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
>    f:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
> [  318.570837][ T1741] EAX: ffffffda EBX: b7f2ee44 ECX: 00000800 EDX: b7f15949
> [  318.572303][ T1741] ESI: b7f2ee08 EDI: b7f2ee08 EBP: bfedfe99 ESP: bfede158
> [  318.573645][ T1741] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000202
> [  318.575211][ T1741] irq event stamp: 4771
> [ 318.576062][ T1741] hardirqs last enabled at (4779): __up_console_sem (arch/x86/include/asm/irqflags.h:45 (discriminator 1) arch/x86/include/asm/irqflags.h:80 (discriminator 1) arch/x86/include/asm/irqflags.h:138 (discriminator 1) kernel/printk/printk.c:256 (discriminator 1)) 
> [ 318.578008][ T1741] hardirqs last disabled at (4788): __up_console_sem (kernel/printk/printk.c:254 (discriminator 3)) 
> [ 318.579667][ T1741] softirqs last enabled at (4654): __do_softirq (arch/x86/include/asm/preempt.h:27 kernel/softirq.c:402 kernel/softirq.c:587) 
> [ 318.581320][ T1741] softirqs last disabled at (4645): do_softirq_own_stack (arch/x86/kernel/irq_32.c:60 arch/x86/kernel/irq_32.c:150) 
> [  318.583074][ T1741] ---[ end trace 0000000000000000 ]---
> [  318.584139][ T1741] ------------[ cut here ]------------
> [  318.585205][ T1741] slab index 568234 out of bounds (73) for stack id a9a8abaa
> 
> 
> To reproduce:
> 
>         # build kernel
> 	cd linux
> 	cp config-5.17.0-rc1-00003-g555b8c8cb3f3 .config
> 	make HOSTCC=gcc-9 CC=gcc-9 ARCH=i386 olddefconfig prepare modules_prepare bzImage modules
> 	make HOSTCC=gcc-9 CC=gcc-9 ARCH=i386 INSTALL_MOD_PATH=<mod-install-dir> modules_install
> 	cd <mod-install-dir>
> 	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
> 
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email
> 
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
> 
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
> 
> 

> #
> # Automatically generated file; DO NOT EDIT.
> # Linux/i386 5.17.0-rc1 Kernel Configuration
> #
> CONFIG_CC_VERSION_TEXT="gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0"
> CONFIG_CC_IS_GCC=y
> CONFIG_GCC_VERSION=90400
> CONFIG_CLANG_VERSION=0
> CONFIG_AS_IS_GNU=y
> CONFIG_AS_VERSION=23502
> CONFIG_LD_IS_BFD=y
> CONFIG_LD_VERSION=23502
> CONFIG_LLD_VERSION=0
> CONFIG_CC_CAN_LINK=y
> CONFIG_CC_CAN_LINK_STATIC=y
> CONFIG_CC_HAS_ASM_GOTO=y
> CONFIG_CC_HAS_ASM_INLINE=y
> CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
> CONFIG_IRQ_WORK=y
> CONFIG_BUILDTIME_TABLE_SORT=y
> CONFIG_THREAD_INFO_IN_TASK=y
> 
> #
> # General setup
> #
> CONFIG_BROKEN_ON_SMP=y
> CONFIG_INIT_ENV_ARG_LIMIT=32
> # CONFIG_COMPILE_TEST is not set
> # CONFIG_WERROR is not set
> CONFIG_LOCALVERSION=""
> CONFIG_LOCALVERSION_AUTO=y
> CONFIG_BUILD_SALT=""
> CONFIG_HAVE_KERNEL_GZIP=y
> CONFIG_HAVE_KERNEL_BZIP2=y
> CONFIG_HAVE_KERNEL_LZMA=y
> CONFIG_HAVE_KERNEL_XZ=y
> CONFIG_HAVE_KERNEL_LZO=y
> CONFIG_HAVE_KERNEL_LZ4=y
> CONFIG_HAVE_KERNEL_ZSTD=y
> # CONFIG_KERNEL_GZIP is not set
> # CONFIG_KERNEL_BZIP2 is not set
> # CONFIG_KERNEL_LZMA is not set
> # CONFIG_KERNEL_XZ is not set
> CONFIG_KERNEL_LZO=y
> # CONFIG_KERNEL_LZ4 is not set
> # CONFIG_KERNEL_ZSTD is not set
> CONFIG_DEFAULT_INIT=""
> CONFIG_DEFAULT_HOSTNAME="(none)"
> CONFIG_SWAP=y
> CONFIG_SYSVIPC=y
> CONFIG_SYSVIPC_SYSCTL=y
> # CONFIG_POSIX_MQUEUE is not set
> CONFIG_WATCH_QUEUE=y
> CONFIG_CROSS_MEMORY_ATTACH=y
> # CONFIG_USELIB is not set
> CONFIG_AUDIT=y
> CONFIG_HAVE_ARCH_AUDITSYSCALL=y
> CONFIG_AUDITSYSCALL=y
> 
> #
> # IRQ subsystem
> #
> CONFIG_GENERIC_IRQ_PROBE=y
> CONFIG_GENERIC_IRQ_SHOW=y
> CONFIG_GENERIC_IRQ_INJECTION=y
> CONFIG_HARDIRQS_SW_RESEND=y
> CONFIG_IRQ_DOMAIN=y
> CONFIG_IRQ_SIM=y
> CONFIG_IRQ_DOMAIN_HIERARCHY=y
> CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
> CONFIG_IRQ_FORCED_THREADING=y
> CONFIG_SPARSE_IRQ=y
> CONFIG_GENERIC_IRQ_DEBUGFS=y
> # end of IRQ subsystem
> 
> CONFIG_CLOCKSOURCE_WATCHDOG=y
> CONFIG_ARCH_CLOCKSOURCE_INIT=y
> CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
> CONFIG_GENERIC_TIME_VSYSCALL=y
> CONFIG_GENERIC_CLOCKEVENTS=y
> CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
> CONFIG_GENERIC_CMOS_UPDATE=y
> CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
> CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y
> 
> #
> # Timers subsystem
> #
> CONFIG_HZ_PERIODIC=y
> # CONFIG_NO_HZ_IDLE is not set
> CONFIG_NO_HZ=y
> # CONFIG_HIGH_RES_TIMERS is not set
> # end of Timers subsystem
> 
> CONFIG_BPF=y
> CONFIG_HAVE_EBPF_JIT=y
> 
> #
> # BPF subsystem
> #
> CONFIG_BPF_SYSCALL=y
> CONFIG_BPF_JIT=y
> # CONFIG_BPF_JIT_ALWAYS_ON is not set
> CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
> # CONFIG_BPF_PRELOAD is not set
> # end of BPF subsystem
> 
> CONFIG_PREEMPT_VOLUNTARY_BUILD=y
> # CONFIG_PREEMPT_NONE is not set
> CONFIG_PREEMPT_VOLUNTARY=y
> # CONFIG_PREEMPT is not set
> CONFIG_PREEMPT_COUNT=y
> # CONFIG_PREEMPT_DYNAMIC is not set
> 
> #
> # CPU/Task time and stats accounting
> #
> CONFIG_TICK_CPU_ACCOUNTING=y
> CONFIG_IRQ_TIME_ACCOUNTING=y
> # CONFIG_BSD_PROCESS_ACCT is not set
> # CONFIG_TASKSTATS is not set
> CONFIG_PSI=y
> # CONFIG_PSI_DEFAULT_DISABLED is not set
> # end of CPU/Task time and stats accounting
> 
> #
> # RCU Subsystem
> #
> CONFIG_TINY_RCU=y
> # CONFIG_RCU_EXPERT is not set
> CONFIG_SRCU=y
> CONFIG_TINY_SRCU=y
> CONFIG_TASKS_RCU_GENERIC=y
> CONFIG_TASKS_RCU=y
> CONFIG_TASKS_RUDE_RCU=y
> CONFIG_TASKS_TRACE_RCU=y
> CONFIG_RCU_NEED_SEGCBLIST=y
> # end of RCU Subsystem
> 
> CONFIG_IKCONFIG=y
> CONFIG_IKCONFIG_PROC=y
> CONFIG_IKHEADERS=y
> CONFIG_LOG_BUF_SHIFT=20
> CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
> # CONFIG_PRINTK_INDEX is not set
> CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
> 
> #
> # Scheduler features
> #
> # end of Scheduler features
> 
> CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
> CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
> CONFIG_CGROUPS=y
> # CONFIG_MEMCG is not set
> # CONFIG_BLK_CGROUP is not set
> # CONFIG_CGROUP_SCHED is not set
> # CONFIG_CGROUP_PIDS is not set
> # CONFIG_CGROUP_RDMA is not set
> # CONFIG_CGROUP_FREEZER is not set
> # CONFIG_CGROUP_DEVICE is not set
> # CONFIG_CGROUP_CPUACCT is not set
> # CONFIG_CGROUP_PERF is not set
> # CONFIG_CGROUP_BPF is not set
> # CONFIG_CGROUP_MISC is not set
> # CONFIG_CGROUP_DEBUG is not set
> CONFIG_NAMESPACES=y
> CONFIG_UTS_NS=y
> # CONFIG_TIME_NS is not set
> CONFIG_IPC_NS=y
> CONFIG_USER_NS=y
> CONFIG_PID_NS=y
> # CONFIG_NET_NS is not set
> CONFIG_CHECKPOINT_RESTORE=y
> # CONFIG_SCHED_AUTOGROUP is not set
> # CONFIG_SYSFS_DEPRECATED is not set
> # CONFIG_RELAY is not set
> CONFIG_BLK_DEV_INITRD=y
> CONFIG_INITRAMFS_SOURCE=""
> CONFIG_RD_GZIP=y
> CONFIG_RD_BZIP2=y
> CONFIG_RD_LZMA=y
> CONFIG_RD_XZ=y
> CONFIG_RD_LZO=y
> CONFIG_RD_LZ4=y
> CONFIG_RD_ZSTD=y
> # CONFIG_BOOT_CONFIG is not set
> # CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
> CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> CONFIG_LD_ORPHAN_WARN=y
> CONFIG_SYSCTL=y
> CONFIG_HAVE_UID16=y
> CONFIG_SYSCTL_EXCEPTION_TRACE=y
> CONFIG_HAVE_PCSPKR_PLATFORM=y
> # CONFIG_EXPERT is not set
> CONFIG_UID16=y
> CONFIG_MULTIUSER=y
> CONFIG_SGETMASK_SYSCALL=y
> CONFIG_SYSFS_SYSCALL=y
> CONFIG_FHANDLE=y
> CONFIG_POSIX_TIMERS=y
> CONFIG_PRINTK=y
> CONFIG_BUG=y
> CONFIG_ELF_CORE=y
> CONFIG_PCSPKR_PLATFORM=y
> CONFIG_BASE_FULL=y
> CONFIG_FUTEX=y
> CONFIG_FUTEX_PI=y
> CONFIG_EPOLL=y
> CONFIG_SIGNALFD=y
> CONFIG_TIMERFD=y
> CONFIG_EVENTFD=y
> CONFIG_SHMEM=y
> CONFIG_AIO=y
> CONFIG_IO_URING=y
> CONFIG_ADVISE_SYSCALLS=y
> CONFIG_MEMBARRIER=y
> CONFIG_KALLSYMS=y
> CONFIG_KALLSYMS_ALL=y
> CONFIG_KALLSYMS_BASE_RELATIVE=y
> # CONFIG_USERFAULTFD is not set
> CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
> CONFIG_KCMP=y
> CONFIG_RSEQ=y
> # CONFIG_EMBEDDED is not set
> CONFIG_HAVE_PERF_EVENTS=y
> 
> #
> # Kernel Performance Events And Counters
> #
> CONFIG_PERF_EVENTS=y
> # CONFIG_DEBUG_PERF_USE_VMALLOC is not set
> # end of Kernel Performance Events And Counters
> 
> CONFIG_VM_EVENT_COUNTERS=y
> CONFIG_SLUB_DEBUG=y
> CONFIG_COMPAT_BRK=y
> # CONFIG_SLAB is not set
> CONFIG_SLUB=y
> # CONFIG_SLAB_MERGE_DEFAULT is not set
> # CONFIG_SLAB_FREELIST_RANDOM is not set
> CONFIG_SLAB_FREELIST_HARDENED=y
> # CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
> CONFIG_SYSTEM_DATA_VERIFICATION=y
> CONFIG_PROFILING=y
> CONFIG_TRACEPOINTS=y
> # end of General setup
> 
> CONFIG_X86_32=y
> CONFIG_X86=y
> CONFIG_INSTRUCTION_DECODER=y
> CONFIG_OUTPUT_FORMAT="elf32-i386"
> CONFIG_LOCKDEP_SUPPORT=y
> CONFIG_STACKTRACE_SUPPORT=y
> CONFIG_MMU=y
> CONFIG_ARCH_MMAP_RND_BITS_MIN=8
> CONFIG_ARCH_MMAP_RND_BITS_MAX=16
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
> CONFIG_GENERIC_ISA_DMA=y
> CONFIG_GENERIC_BUG=y
> CONFIG_ARCH_MAY_HAVE_PC_FDC=y
> CONFIG_GENERIC_CALIBRATE_DELAY=y
> CONFIG_ARCH_HAS_CPU_RELAX=y
> CONFIG_ARCH_HAS_FILTER_PGPROT=y
> CONFIG_ARCH_HIBERNATION_POSSIBLE=y
> CONFIG_ARCH_NR_GPIO=512
> CONFIG_ARCH_SUSPEND_POSSIBLE=y
> CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
> CONFIG_ARCH_SUPPORTS_UPROBES=y
> CONFIG_FIX_EARLYCON_MEM=y
> CONFIG_PGTABLE_LEVELS=2
> CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
> 
> #
> # Processor type and features
> #
> # CONFIG_SMP is not set
> CONFIG_X86_FEATURE_NAMES=y
> # CONFIG_GOLDFISH is not set
> # CONFIG_RETPOLINE is not set
> CONFIG_X86_CPU_RESCTRL=y
> # CONFIG_X86_EXTENDED_PLATFORM is not set
> # CONFIG_X86_INTEL_LPSS is not set
> # CONFIG_X86_AMD_PLATFORM_DEVICE is not set
> # CONFIG_IOSF_MBI is not set
> # CONFIG_X86_32_IRIS is not set
> # CONFIG_SCHED_OMIT_FRAME_POINTER is not set
> CONFIG_HYPERVISOR_GUEST=y
> CONFIG_PARAVIRT=y
> # CONFIG_PARAVIRT_DEBUG is not set
> CONFIG_X86_HV_CALLBACK_VECTOR=y
> CONFIG_KVM_GUEST=y
> CONFIG_ARCH_CPUIDLE_HALTPOLL=y
> # CONFIG_PVH is not set
> # CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
> CONFIG_PARAVIRT_CLOCK=y
> # CONFIG_M486SX is not set
> # CONFIG_M486 is not set
> # CONFIG_M586 is not set
> # CONFIG_M586TSC is not set
> CONFIG_M586MMX=y
> # CONFIG_M686 is not set
> # CONFIG_MPENTIUMII is not set
> # CONFIG_MPENTIUMIII is not set
> # CONFIG_MPENTIUMM is not set
> # CONFIG_MPENTIUM4 is not set
> # CONFIG_MK6 is not set
> # CONFIG_MK7 is not set
> # CONFIG_MK8 is not set
> # CONFIG_MCRUSOE is not set
> # CONFIG_MEFFICEON is not set
> # CONFIG_MWINCHIPC6 is not set
> # CONFIG_MWINCHIP3D is not set
> # CONFIG_MELAN is not set
> # CONFIG_MGEODEGX1 is not set
> # CONFIG_MGEODE_LX is not set
> # CONFIG_MCYRIXIII is not set
> # CONFIG_MVIAC3_2 is not set
> # CONFIG_MVIAC7 is not set
> # CONFIG_MCORE2 is not set
> # CONFIG_MATOM is not set
> CONFIG_X86_GENERIC=y
> CONFIG_X86_INTERNODE_CACHE_SHIFT=6
> CONFIG_X86_L1_CACHE_SHIFT=6
> CONFIG_X86_F00F_BUG=y
> CONFIG_X86_ALIGNMENT_16=y
> CONFIG_X86_INTEL_USERCOPY=y
> CONFIG_X86_TSC=y
> CONFIG_X86_CMPXCHG64=y
> CONFIG_X86_MINIMUM_CPU_FAMILY=5
> CONFIG_IA32_FEAT_CTL=y
> CONFIG_X86_VMX_FEATURE_NAMES=y
> CONFIG_CPU_SUP_INTEL=y
> CONFIG_CPU_SUP_CYRIX_32=y
> CONFIG_CPU_SUP_AMD=y
> CONFIG_CPU_SUP_HYGON=y
> CONFIG_CPU_SUP_CENTAUR=y
> CONFIG_CPU_SUP_TRANSMETA_32=y
> CONFIG_CPU_SUP_ZHAOXIN=y
> CONFIG_CPU_SUP_VORTEX_32=y
> CONFIG_HPET_TIMER=y
> CONFIG_DMI=y
> CONFIG_NR_CPUS_RANGE_BEGIN=1
> CONFIG_NR_CPUS_RANGE_END=1
> CONFIG_NR_CPUS_DEFAULT=1
> CONFIG_NR_CPUS=1
> # CONFIG_X86_UP_APIC is not set
> CONFIG_X86_MCE=y
> CONFIG_X86_MCELOG_LEGACY=y
> CONFIG_X86_ANCIENT_MCE=y
> 
> #
> # Performance monitoring
> #
> CONFIG_PERF_EVENTS_INTEL_UNCORE=y
> CONFIG_PERF_EVENTS_INTEL_RAPL=y
> CONFIG_PERF_EVENTS_INTEL_CSTATE=y
> # CONFIG_PERF_EVENTS_AMD_POWER is not set
> # CONFIG_PERF_EVENTS_AMD_UNCORE is not set
> # end of Performance monitoring
> 
> # CONFIG_X86_LEGACY_VM86 is not set
> CONFIG_X86_16BIT=y
> CONFIG_X86_ESPFIX32=y
> CONFIG_X86_IOPL_IOPERM=y
> CONFIG_TOSHIBA=y
> # CONFIG_X86_REBOOTFIXUPS is not set
> # CONFIG_MICROCODE is not set
> CONFIG_X86_MSR=y
> # CONFIG_X86_CPUID is not set
> # CONFIG_NOHIGHMEM is not set
> CONFIG_HIGHMEM4G=y
> CONFIG_PAGE_OFFSET=0xC0000000
> CONFIG_HIGHMEM=y
> CONFIG_X86_CPA_STATISTICS=y
> CONFIG_ARCH_FLATMEM_ENABLE=y
> CONFIG_ARCH_SPARSEMEM_ENABLE=y
> CONFIG_ARCH_SELECT_MEMORY_MODEL=y
> CONFIG_ILLEGAL_POINTER_VALUE=0
> CONFIG_HIGHPTE=y
> # CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
> CONFIG_MTRR=y
> CONFIG_MTRR_SANITIZER=y
> CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
> CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
> CONFIG_X86_PAT=y
> CONFIG_ARCH_USES_PG_UNCACHED=y
> CONFIG_ARCH_RANDOM=y
> CONFIG_X86_SMAP=y
> CONFIG_X86_UMIP=y
> # CONFIG_X86_INTEL_TSX_MODE_OFF is not set
> CONFIG_X86_INTEL_TSX_MODE_ON=y
> # CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
> CONFIG_EFI=y
> # CONFIG_EFI_STUB is not set
> CONFIG_HZ_100=y
> # CONFIG_HZ_250 is not set
> # CONFIG_HZ_300 is not set
> # CONFIG_HZ_1000 is not set
> CONFIG_HZ=100
> # CONFIG_KEXEC is not set
> CONFIG_CRASH_DUMP=y
> CONFIG_PHYSICAL_START=0x1000000
> CONFIG_RELOCATABLE=y
> CONFIG_RANDOMIZE_BASE=y
> CONFIG_X86_NEED_RELOCS=y
> CONFIG_PHYSICAL_ALIGN=0x200000
> # CONFIG_COMPAT_VDSO is not set
> # CONFIG_CMDLINE_BOOL is not set
> CONFIG_MODIFY_LDT_SYSCALL=y
> CONFIG_STRICT_SIGALTSTACK_SIZE=y
> # end of Processor type and features
> 
> CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y
> 
> #
> # Power management and ACPI options
> #
> # CONFIG_SUSPEND is not set
> # CONFIG_HIBERNATION is not set
> CONFIG_PM=y
> # CONFIG_PM_DEBUG is not set
> CONFIG_PM_CLK=y
> # CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
> CONFIG_ARCH_SUPPORTS_ACPI=y
> CONFIG_ACPI=y
> CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
> CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
> CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
> # CONFIG_ACPI_DEBUGGER is not set
> CONFIG_ACPI_SPCR_TABLE=y
> # CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
> # CONFIG_ACPI_EC_DEBUGFS is not set
> # CONFIG_ACPI_AC is not set
> # CONFIG_ACPI_BATTERY is not set
> CONFIG_ACPI_BUTTON=m
> CONFIG_ACPI_TINY_POWER_BUTTON=m
> CONFIG_ACPI_TINY_POWER_BUTTON_SIGNAL=38
> CONFIG_ACPI_VIDEO=m
> CONFIG_ACPI_FAN=y
> # CONFIG_ACPI_DOCK is not set
> # CONFIG_ACPI_PROCESSOR is not set
> CONFIG_ACPI_CUSTOM_DSDT_FILE=""
> CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
> CONFIG_ACPI_TABLE_UPGRADE=y
> CONFIG_ACPI_DEBUG=y
> # CONFIG_ACPI_PCI_SLOT is not set
> # CONFIG_ACPI_CONTAINER is not set
> CONFIG_ACPI_SBS=y
> CONFIG_ACPI_HED=m
> CONFIG_ACPI_CUSTOM_METHOD=m
> CONFIG_ACPI_BGRT=y
> CONFIG_HAVE_ACPI_APEI=y
> CONFIG_HAVE_ACPI_APEI_NMI=y
> # CONFIG_ACPI_APEI is not set
> # CONFIG_ACPI_DPTF is not set
> CONFIG_ACPI_CONFIGFS=y
> # CONFIG_PMIC_OPREGION is not set
> CONFIG_X86_PM_TIMER=y
> 
> #
> # CPU Frequency scaling
> #
> CONFIG_CPU_FREQ=y
> CONFIG_CPU_FREQ_GOV_ATTR_SET=y
> CONFIG_CPU_FREQ_GOV_COMMON=y
> # CONFIG_CPU_FREQ_STAT is not set
> CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
> # CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
> CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> CONFIG_CPU_FREQ_GOV_POWERSAVE=y
> CONFIG_CPU_FREQ_GOV_USERSPACE=y
> # CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
> CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
> 
> #
> # CPU frequency scaling drivers
> #
> CONFIG_CPUFREQ_DT=y
> CONFIG_CPUFREQ_DT_PLATDEV=y
> # CONFIG_X86_INTEL_PSTATE is not set
> # CONFIG_X86_AMD_PSTATE is not set
> CONFIG_X86_POWERNOW_K6=y
> # CONFIG_X86_POWERNOW_K7 is not set
> # CONFIG_X86_GX_SUSPMOD is not set
> # CONFIG_X86_SPEEDSTEP_CENTRINO is not set
> CONFIG_X86_SPEEDSTEP_ICH=m
> # CONFIG_X86_SPEEDSTEP_SMI is not set
> CONFIG_X86_P4_CLOCKMOD=m
> # CONFIG_X86_CPUFREQ_NFORCE2 is not set
> # CONFIG_X86_LONGRUN is not set
> 
> #
> # shared options
> #
> CONFIG_X86_SPEEDSTEP_LIB=m
> # CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK is not set
> # end of CPU Frequency scaling
> 
> #
> # CPU Idle
> #
> # CONFIG_CPU_IDLE is not set
> # end of CPU Idle
> # end of Power management and ACPI options
> 
> #
> # Bus options (PCI etc.)
> #
> # CONFIG_PCI_GOBIOS is not set
> # CONFIG_PCI_GOMMCONFIG is not set
> # CONFIG_PCI_GODIRECT is not set
> # CONFIG_PCI_GOOLPC is not set
> CONFIG_PCI_GOANY=y
> CONFIG_PCI_BIOS=y
> CONFIG_PCI_DIRECT=y
> CONFIG_PCI_MMCONFIG=y
> CONFIG_PCI_OLPC=y
> CONFIG_ISA_DMA_API=y
> CONFIG_ISA=y
> CONFIG_SCx200=y
> CONFIG_SCx200HR_TIMER=y
> CONFIG_OLPC=y
> CONFIG_OLPC_XO15_SCI=y
> # CONFIG_ALIX is not set
> CONFIG_NET5501=y
> CONFIG_GEOS=y
> CONFIG_AMD_NB=y
> # end of Bus options (PCI etc.)
> 
> #
> # Binary Emulations
> #
> CONFIG_COMPAT_32=y
> # end of Binary Emulations
> 
> CONFIG_HAVE_ATOMIC_IOMAP=y
> CONFIG_HAVE_KVM=y
> # CONFIG_VIRTUALIZATION is not set
> CONFIG_AS_AVX512=y
> CONFIG_AS_SHA1_NI=y
> CONFIG_AS_SHA256_NI=y
> CONFIG_AS_TPAUSE=y
> 
> #
> # General architecture-dependent options
> #
> CONFIG_GENERIC_ENTRY=y
> CONFIG_KPROBES=y
> # CONFIG_JUMP_LABEL is not set
> # CONFIG_STATIC_CALL_SELFTEST is not set
> CONFIG_OPTPROBES=y
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
> CONFIG_ARCH_USE_BUILTIN_BSWAP=y
> CONFIG_KRETPROBES=y
> CONFIG_HAVE_IOREMAP_PROT=y
> CONFIG_HAVE_KPROBES=y
> CONFIG_HAVE_KRETPROBES=y
> CONFIG_HAVE_OPTPROBES=y
> CONFIG_HAVE_KPROBES_ON_FTRACE=y
> CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
> CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
> CONFIG_HAVE_NMI=y
> CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> CONFIG_HAVE_ARCH_TRACEHOOK=y
> CONFIG_HAVE_DMA_CONTIGUOUS=y
> CONFIG_GENERIC_SMP_IDLE_THREAD=y
> CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
> CONFIG_ARCH_HAS_SET_MEMORY=y
> CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
> CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
> CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
> CONFIG_ARCH_WANTS_NO_INSTR=y
> CONFIG_ARCH_32BIT_OFF_T=y
> CONFIG_HAVE_ASM_MODVERSIONS=y
> CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
> CONFIG_HAVE_RSEQ=y
> CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
> CONFIG_HAVE_HW_BREAKPOINT=y
> CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
> CONFIG_HAVE_USER_RETURN_NOTIFIER=y
> CONFIG_HAVE_PERF_EVENTS_NMI=y
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
> CONFIG_HAVE_PERF_REGS=y
> CONFIG_HAVE_PERF_USER_STACK_DUMP=y
> CONFIG_HAVE_ARCH_JUMP_LABEL=y
> CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
> CONFIG_MMU_GATHER_TABLE_FREE=y
> CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
> CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
> CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
> CONFIG_HAVE_CMPXCHG_LOCAL=y
> CONFIG_HAVE_CMPXCHG_DOUBLE=y
> CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
> CONFIG_HAVE_ARCH_SECCOMP=y
> CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
> CONFIG_SECCOMP=y
> CONFIG_SECCOMP_FILTER=y
> # CONFIG_SECCOMP_CACHE_DEBUG is not set
> CONFIG_HAVE_ARCH_STACKLEAK=y
> CONFIG_HAVE_STACKPROTECTOR=y
> # CONFIG_STACKPROTECTOR is not set
> CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
> CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
> CONFIG_LTO_NONE=y
> CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
> CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
> CONFIG_HAVE_MOVE_PUD=y
> CONFIG_HAVE_MOVE_PMD=y
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
> CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
> CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
> CONFIG_MODULES_USE_ELF_REL=y
> CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
> CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
> CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
> CONFIG_HAVE_EXIT_THREAD=y
> CONFIG_ARCH_MMAP_RND_BITS=8
> CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
> CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
> CONFIG_ISA_BUS_API=y
> CONFIG_CLONE_BACKWARDS=y
> CONFIG_OLD_SIGSUSPEND3=y
> CONFIG_OLD_SIGACTION=y
> CONFIG_COMPAT_32BIT_TIME=y
> CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
> # CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
> CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
> CONFIG_STRICT_KERNEL_RWX=y
> CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
> CONFIG_STRICT_MODULE_RWX=y
> CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
> CONFIG_ARCH_USE_MEMREMAP_PROT=y
> CONFIG_LOCK_EVENT_COUNTS=y
> CONFIG_ARCH_HAS_MEM_ENCRYPT=y
> CONFIG_HAVE_STATIC_CALL=y
> CONFIG_HAVE_PREEMPT_DYNAMIC=y
> CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
> CONFIG_ARCH_SPLIT_ARG64=y
> CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
> CONFIG_DYNAMIC_SIGFRAME=y
> 
> #
> # GCOV-based kernel profiling
> #
> # CONFIG_GCOV_KERNEL is not set
> CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
> # end of GCOV-based kernel profiling
> 
> CONFIG_HAVE_GCC_PLUGINS=y
> # end of General architecture-dependent options
> 
> CONFIG_RT_MUTEXES=y
> CONFIG_BASE_SMALL=0
> CONFIG_MODULES=y
> CONFIG_MODULE_FORCE_LOAD=y
> CONFIG_MODULE_UNLOAD=y
> # CONFIG_MODULE_FORCE_UNLOAD is not set
> # CONFIG_MODVERSIONS is not set
> # CONFIG_MODULE_SRCVERSION_ALL is not set
> # CONFIG_MODULE_SIG is not set
> CONFIG_MODULE_COMPRESS_NONE=y
> # CONFIG_MODULE_COMPRESS_GZIP is not set
> # CONFIG_MODULE_COMPRESS_XZ is not set
> # CONFIG_MODULE_COMPRESS_ZSTD is not set
> # CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
> CONFIG_MODPROBE_PATH="/sbin/modprobe"
> CONFIG_MODULES_TREE_LOOKUP=y
> CONFIG_BLOCK=y
> CONFIG_BLK_DEV_BSG_COMMON=y
> CONFIG_BLK_DEV_BSGLIB=y
> CONFIG_BLK_DEV_INTEGRITY=y
> CONFIG_BLK_DEV_INTEGRITY_T10=y
> # CONFIG_BLK_DEV_ZONED is not set
> # CONFIG_BLK_WBT is not set
> # CONFIG_BLK_DEBUG_FS is not set
> # CONFIG_BLK_SED_OPAL is not set
> # CONFIG_BLK_INLINE_ENCRYPTION is not set
> 
> #
> # Partition Types
> #
> # CONFIG_PARTITION_ADVANCED is not set
> CONFIG_MSDOS_PARTITION=y
> CONFIG_EFI_PARTITION=y
> # end of Partition Types
> 
> CONFIG_BLK_MQ_PCI=y
> CONFIG_BLK_MQ_VIRTIO=y
> CONFIG_BLK_PM=y
> 
> #
> # IO Schedulers
> #
> CONFIG_MQ_IOSCHED_DEADLINE=m
> CONFIG_MQ_IOSCHED_KYBER=y
> # CONFIG_IOSCHED_BFQ is not set
> # end of IO Schedulers
> 
> CONFIG_ASN1=y
> CONFIG_UNINLINE_SPIN_UNLOCK=y
> CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
> CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
> CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
> CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
> CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
> CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
> 
> #
> # Executable file formats
> #
> CONFIG_BINFMT_ELF=y
> CONFIG_ELFCORE=y
> CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
> CONFIG_BINFMT_SCRIPT=y
> CONFIG_BINFMT_MISC=y
> CONFIG_COREDUMP=y
> # end of Executable file formats
> 
> #
> # Memory Management options
> #
> CONFIG_SELECT_MEMORY_MODEL=y
> # CONFIG_FLATMEM_MANUAL is not set
> CONFIG_SPARSEMEM_MANUAL=y
> CONFIG_SPARSEMEM=y
> CONFIG_SPARSEMEM_STATIC=y
> CONFIG_HAVE_FAST_GUP=y
> CONFIG_MEMORY_ISOLATION=y
> CONFIG_EXCLUSIVE_SYSTEM_RAM=y
> CONFIG_SPLIT_PTLOCK_CPUS=4
> CONFIG_MEMORY_BALLOON=y
> # CONFIG_BALLOON_COMPACTION is not set
> CONFIG_COMPACTION=y
> CONFIG_PAGE_REPORTING=y
> CONFIG_MIGRATION=y
> CONFIG_CONTIG_ALLOC=y
> CONFIG_BOUNCE=y
> CONFIG_VIRT_TO_BUS=y
> # CONFIG_KSM is not set
> CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
> CONFIG_TRANSPARENT_HUGEPAGE=y
> CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
> # CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
> CONFIG_NEED_PER_CPU_KM=y
> CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
> CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
> CONFIG_HAVE_SETUP_PER_CPU_AREA=y
> CONFIG_FRONTSWAP=y
> CONFIG_CMA=y
> # CONFIG_CMA_DEBUG is not set
> # CONFIG_CMA_DEBUGFS is not set
> CONFIG_CMA_SYSFS=y
> CONFIG_CMA_AREAS=7
> CONFIG_ZSWAP=y
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO is not set
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
> CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC=y
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
> CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lz4hc"
> CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
> # CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
> # CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
> CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
> # CONFIG_ZSWAP_DEFAULT_ON is not set
> CONFIG_ZPOOL=y
> CONFIG_ZBUD=y
> CONFIG_Z3FOLD=m
> # CONFIG_ZSMALLOC is not set
> CONFIG_GENERIC_EARLY_IOREMAP=y
> CONFIG_PAGE_IDLE_FLAG=y
> CONFIG_IDLE_PAGE_TRACKING=y
> CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
> CONFIG_ZONE_DMA=y
> # CONFIG_PERCPU_STATS is not set
> # CONFIG_GUP_TEST is not set
> CONFIG_READ_ONLY_THP_FOR_FS=y
> CONFIG_ARCH_HAS_PTE_SPECIAL=y
> CONFIG_KMAP_LOCAL=y
> CONFIG_SECRETMEM=y
> CONFIG_ANON_VMA_NAME=y
> 
> #
> # Data Access Monitoring
> #
> CONFIG_DAMON=y
> # CONFIG_DAMON_VADDR is not set
> CONFIG_DAMON_PADDR=y
> CONFIG_DAMON_RECLAIM=y
> # end of Data Access Monitoring
> # end of Memory Management options
> 
> CONFIG_NET=y
> CONFIG_NET_INGRESS=y
> CONFIG_NET_EGRESS=y
> 
> #
> # Networking options
> #
> CONFIG_PACKET=y
> # CONFIG_PACKET_DIAG is not set
> CONFIG_UNIX=y
> CONFIG_UNIX_SCM=y
> CONFIG_AF_UNIX_OOB=y
> # CONFIG_UNIX_DIAG is not set
> # CONFIG_TLS is not set
> # CONFIG_XFRM_USER is not set
> # CONFIG_NET_KEY is not set
> CONFIG_XDP_SOCKETS=y
> CONFIG_XDP_SOCKETS_DIAG=y
> CONFIG_INET=y
> # CONFIG_IP_MULTICAST is not set
> # CONFIG_IP_ADVANCED_ROUTER is not set
> CONFIG_IP_PNP=y
> CONFIG_IP_PNP_DHCP=y
> # CONFIG_IP_PNP_BOOTP is not set
> # CONFIG_IP_PNP_RARP is not set
> # CONFIG_NET_IPIP is not set
> # CONFIG_NET_IPGRE_DEMUX is not set
> CONFIG_NET_IP_TUNNEL=y
> # CONFIG_SYN_COOKIES is not set
> # CONFIG_NET_IPVTI is not set
> # CONFIG_NET_FOU is not set
> # CONFIG_NET_FOU_IP_TUNNELS is not set
> # CONFIG_INET_AH is not set
> # CONFIG_INET_ESP is not set
> # CONFIG_INET_IPCOMP is not set
> CONFIG_INET_TUNNEL=y
> CONFIG_INET_DIAG=y
> CONFIG_INET_TCP_DIAG=y
> # CONFIG_INET_UDP_DIAG is not set
> # CONFIG_INET_RAW_DIAG is not set
> # CONFIG_INET_DIAG_DESTROY is not set
> # CONFIG_TCP_CONG_ADVANCED is not set
> CONFIG_TCP_CONG_CUBIC=y
> CONFIG_DEFAULT_TCP_CONG="cubic"
> # CONFIG_TCP_MD5SIG is not set
> CONFIG_IPV6=y
> # CONFIG_IPV6_ROUTER_PREF is not set
> # CONFIG_IPV6_OPTIMISTIC_DAD is not set
> # CONFIG_INET6_AH is not set
> # CONFIG_INET6_ESP is not set
> # CONFIG_INET6_IPCOMP is not set
> # CONFIG_IPV6_MIP6 is not set
> # CONFIG_IPV6_ILA is not set
> # CONFIG_IPV6_VTI is not set
> CONFIG_IPV6_SIT=y
> # CONFIG_IPV6_SIT_6RD is not set
> CONFIG_IPV6_NDISC_NODETYPE=y
> # CONFIG_IPV6_TUNNEL is not set
> # CONFIG_IPV6_MULTIPLE_TABLES is not set
> # CONFIG_IPV6_MROUTE is not set
> # CONFIG_IPV6_SEG6_LWTUNNEL is not set
> # CONFIG_IPV6_SEG6_HMAC is not set
> # CONFIG_IPV6_RPL_LWTUNNEL is not set
> # CONFIG_IPV6_IOAM6_LWTUNNEL is not set
> # CONFIG_NETLABEL is not set
> # CONFIG_MPTCP is not set
> # CONFIG_NETWORK_SECMARK is not set
> CONFIG_NET_PTP_CLASSIFY=y
> CONFIG_NETWORK_PHY_TIMESTAMPING=y
> CONFIG_NETFILTER=y
> CONFIG_NETFILTER_ADVANCED=y
> 
> #
> # Core Netfilter Configuration
> #
> CONFIG_NETFILTER_INGRESS=y
> CONFIG_NETFILTER_EGRESS=y
> # CONFIG_NETFILTER_NETLINK_ACCT is not set
> # CONFIG_NETFILTER_NETLINK_QUEUE is not set
> # CONFIG_NETFILTER_NETLINK_LOG is not set
> # CONFIG_NETFILTER_NETLINK_OSF is not set
> # CONFIG_NF_CONNTRACK is not set
> # CONFIG_NF_LOG_SYSLOG is not set
> # CONFIG_NF_TABLES is not set
> # CONFIG_NETFILTER_XTABLES is not set
> # end of Core Netfilter Configuration
> 
> # CONFIG_IP_SET is not set
> # CONFIG_IP_VS is not set
> 
> #
> # IP: Netfilter Configuration
> #
> # CONFIG_NF_SOCKET_IPV4 is not set
> # CONFIG_NF_TPROXY_IPV4 is not set
> # CONFIG_NF_DUP_IPV4 is not set
> # CONFIG_NF_LOG_ARP is not set
> # CONFIG_NF_LOG_IPV4 is not set
> # CONFIG_NF_REJECT_IPV4 is not set
> # CONFIG_IP_NF_IPTABLES is not set
> # CONFIG_IP_NF_ARPTABLES is not set
> # end of IP: Netfilter Configuration
> 
> #
> # IPv6: Netfilter Configuration
> #
> # CONFIG_NF_SOCKET_IPV6 is not set
> # CONFIG_NF_TPROXY_IPV6 is not set
> # CONFIG_NF_DUP_IPV6 is not set
> # CONFIG_NF_REJECT_IPV6 is not set
> # CONFIG_NF_LOG_IPV6 is not set
> # CONFIG_IP6_NF_IPTABLES is not set
> # end of IPv6: Netfilter Configuration
> 
> #
> # DECnet: Netfilter Configuration
> #
> CONFIG_DECNET_NF_GRABULATOR=m
> # end of DECnet: Netfilter Configuration
> 
> # CONFIG_BPFILTER is not set
> # CONFIG_IP_DCCP is not set
> # CONFIG_IP_SCTP is not set
> # CONFIG_RDS is not set
> # CONFIG_TIPC is not set
> CONFIG_ATM=y
> # CONFIG_ATM_CLIP is not set
> CONFIG_ATM_LANE=y
> # CONFIG_ATM_MPOA is not set
> # CONFIG_ATM_BR2684 is not set
> # CONFIG_L2TP is not set
> # CONFIG_BRIDGE is not set
> # CONFIG_NET_DSA is not set
> # CONFIG_VLAN_8021Q is not set
> CONFIG_DECNET=m
> CONFIG_DECNET_ROUTER=y
> CONFIG_LLC=y
> CONFIG_LLC2=y
> CONFIG_ATALK=m
> CONFIG_DEV_APPLETALK=m
> CONFIG_LTPC=m
> # CONFIG_COPS is not set
> # CONFIG_IPDDP is not set
> CONFIG_X25=m
> CONFIG_LAPB=y
> # CONFIG_PHONET is not set
> # CONFIG_6LOWPAN is not set
> CONFIG_IEEE802154=m
> CONFIG_IEEE802154_NL802154_EXPERIMENTAL=y
> CONFIG_IEEE802154_SOCKET=m
> CONFIG_MAC802154=m
> CONFIG_NET_SCHED=y
> 
> #
> # Queueing/Scheduling
> #
> CONFIG_NET_SCH_CBQ=m
> # CONFIG_NET_SCH_HTB is not set
> CONFIG_NET_SCH_HFSC=m
> CONFIG_NET_SCH_ATM=y
> # CONFIG_NET_SCH_PRIO is not set
> CONFIG_NET_SCH_MULTIQ=y
> CONFIG_NET_SCH_RED=y
> CONFIG_NET_SCH_SFB=m
> # CONFIG_NET_SCH_SFQ is not set
> # CONFIG_NET_SCH_TEQL is not set
> CONFIG_NET_SCH_TBF=y
> # CONFIG_NET_SCH_CBS is not set
> # CONFIG_NET_SCH_ETF is not set
> # CONFIG_NET_SCH_TAPRIO is not set
> # CONFIG_NET_SCH_GRED is not set
> CONFIG_NET_SCH_DSMARK=y
> CONFIG_NET_SCH_NETEM=y
> # CONFIG_NET_SCH_DRR is not set
> CONFIG_NET_SCH_MQPRIO=y
> # CONFIG_NET_SCH_SKBPRIO is not set
> CONFIG_NET_SCH_CHOKE=m
> # CONFIG_NET_SCH_QFQ is not set
> # CONFIG_NET_SCH_CODEL is not set
> CONFIG_NET_SCH_FQ_CODEL=y
> CONFIG_NET_SCH_CAKE=m
> CONFIG_NET_SCH_FQ=y
> # CONFIG_NET_SCH_HHF is not set
> CONFIG_NET_SCH_PIE=m
> # CONFIG_NET_SCH_FQ_PIE is not set
> # CONFIG_NET_SCH_PLUG is not set
> # CONFIG_NET_SCH_ETS is not set
> # CONFIG_NET_SCH_DEFAULT is not set
> 
> #
> # Classification
> #
> CONFIG_NET_CLS=y
> CONFIG_NET_CLS_BASIC=m
> CONFIG_NET_CLS_TCINDEX=y
> # CONFIG_NET_CLS_ROUTE4 is not set
> # CONFIG_NET_CLS_FW is not set
> CONFIG_NET_CLS_U32=y
> # CONFIG_CLS_U32_PERF is not set
> # CONFIG_CLS_U32_MARK is not set
> CONFIG_NET_CLS_RSVP=m
> CONFIG_NET_CLS_RSVP6=y
> CONFIG_NET_CLS_FLOW=m
> # CONFIG_NET_CLS_CGROUP is not set
> # CONFIG_NET_CLS_BPF is not set
> # CONFIG_NET_CLS_FLOWER is not set
> CONFIG_NET_CLS_MATCHALL=m
> CONFIG_NET_EMATCH=y
> CONFIG_NET_EMATCH_STACK=32
> CONFIG_NET_EMATCH_CMP=m
> # CONFIG_NET_EMATCH_NBYTE is not set
> # CONFIG_NET_EMATCH_U32 is not set
> CONFIG_NET_EMATCH_META=y
> CONFIG_NET_EMATCH_TEXT=m
> CONFIG_NET_EMATCH_CANID=y
> # CONFIG_NET_CLS_ACT is not set
> CONFIG_NET_SCH_FIFO=y
> # CONFIG_DCB is not set
> CONFIG_DNS_RESOLVER=m
> # CONFIG_BATMAN_ADV is not set
> # CONFIG_OPENVSWITCH is not set
> CONFIG_VSOCKETS=y
> # CONFIG_VSOCKETS_DIAG is not set
> CONFIG_VSOCKETS_LOOPBACK=y
> CONFIG_VIRTIO_VSOCKETS=y
> CONFIG_VIRTIO_VSOCKETS_COMMON=y
> # CONFIG_NETLINK_DIAG is not set
> CONFIG_MPLS=y
> # CONFIG_NET_MPLS_GSO is not set
> CONFIG_MPLS_ROUTING=y
> CONFIG_NET_NSH=y
> # CONFIG_HSR is not set
> # CONFIG_NET_SWITCHDEV is not set
> # CONFIG_NET_L3_MASTER_DEV is not set
> CONFIG_QRTR=y
> CONFIG_QRTR_SMD=m
> CONFIG_QRTR_TUN=m
> # CONFIG_NET_NCSI is not set
> # CONFIG_CGROUP_NET_PRIO is not set
> # CONFIG_CGROUP_NET_CLASSID is not set
> CONFIG_NET_RX_BUSY_POLL=y
> CONFIG_BQL=y
> 
> #
> # Network testing
> #
> # CONFIG_NET_PKTGEN is not set
> # CONFIG_NET_DROP_MONITOR is not set
> # end of Network testing
> # end of Networking options
> 
> # CONFIG_HAMRADIO is not set
> CONFIG_CAN=y
> CONFIG_CAN_RAW=y
> CONFIG_CAN_BCM=y
> CONFIG_CAN_GW=y
> CONFIG_CAN_J1939=m
> CONFIG_CAN_ISOTP=m
> 
> #
> # CAN Device Drivers
> #
> CONFIG_CAN_VCAN=m
> CONFIG_CAN_VXCAN=m
> CONFIG_CAN_SLCAN=m
> # CONFIG_CAN_DEV is not set
> # CONFIG_CAN_DEBUG_DEVICES is not set
> # end of CAN Device Drivers
> 
> # CONFIG_BT is not set
> # CONFIG_AF_RXRPC is not set
> # CONFIG_AF_KCM is not set
> # CONFIG_MCTP is not set
> CONFIG_FIB_RULES=y
> CONFIG_WIRELESS=y
> CONFIG_WEXT_CORE=y
> CONFIG_WEXT_PROC=y
> CONFIG_CFG80211=y
> # CONFIG_NL80211_TESTMODE is not set
> # CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
> CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
> CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
> CONFIG_CFG80211_DEFAULT_PS=y
> CONFIG_CFG80211_DEBUGFS=y
> CONFIG_CFG80211_CRDA_SUPPORT=y
> CONFIG_CFG80211_WEXT=y
> CONFIG_MAC80211=y
> CONFIG_MAC80211_HAS_RC=y
> CONFIG_MAC80211_RC_MINSTREL=y
> CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
> CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
> CONFIG_MAC80211_MESH=y
> CONFIG_MAC80211_LEDS=y
> # CONFIG_MAC80211_DEBUGFS is not set
> CONFIG_MAC80211_MESSAGE_TRACING=y
> # CONFIG_MAC80211_DEBUG_MENU is not set
> CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
> CONFIG_RFKILL=y
> CONFIG_RFKILL_LEDS=y
> CONFIG_RFKILL_INPUT=y
> CONFIG_RFKILL_GPIO=y
> CONFIG_NET_9P=y
> CONFIG_NET_9P_FD=y
> CONFIG_NET_9P_VIRTIO=y
> # CONFIG_NET_9P_DEBUG is not set
> # CONFIG_CAIF is not set
> # CONFIG_CEPH_LIB is not set
> # CONFIG_NFC is not set
> # CONFIG_PSAMPLE is not set
> # CONFIG_NET_IFE is not set
> # CONFIG_LWTUNNEL is not set
> CONFIG_DST_CACHE=y
> CONFIG_GRO_CELLS=y
> CONFIG_NET_SOCK_MSG=y
> CONFIG_FAILOVER=m
> CONFIG_ETHTOOL_NETLINK=y
> 
> #
> # Device Drivers
> #
> CONFIG_HAVE_EISA=y
> # CONFIG_EISA is not set
> CONFIG_HAVE_PCI=y
> CONFIG_PCI=y
> CONFIG_PCI_DOMAINS=y
> # CONFIG_PCIEPORTBUS is not set
> CONFIG_PCIEASPM=y
> CONFIG_PCIEASPM_DEFAULT=y
> # CONFIG_PCIEASPM_POWERSAVE is not set
> # CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
> # CONFIG_PCIEASPM_PERFORMANCE is not set
> # CONFIG_PCIE_PTM is not set
> # CONFIG_PCI_MSI is not set
> CONFIG_PCI_QUIRKS=y
> # CONFIG_PCI_DEBUG is not set
> # CONFIG_PCI_STUB is not set
> CONFIG_PCI_LOCKLESS_CONFIG=y
> # CONFIG_PCI_IOV is not set
> # CONFIG_PCI_PRI is not set
> # CONFIG_PCI_PASID is not set
> CONFIG_PCI_LABEL=y
> # CONFIG_HOTPLUG_PCI is not set
> 
> #
> # PCI controller drivers
> #
> # CONFIG_PCI_FTPCI100 is not set
> # CONFIG_PCI_HOST_GENERIC is not set
> 
> #
> # DesignWare PCI Core Support
> #
> # end of DesignWare PCI Core Support
> 
> #
> # Mobiveil PCIe Core Support
> #
> # end of Mobiveil PCIe Core Support
> 
> #
> # Cadence PCIe controllers support
> #
> # CONFIG_PCIE_CADENCE_PLAT_HOST is not set
> # CONFIG_PCI_J721E_HOST is not set
> # end of Cadence PCIe controllers support
> # end of PCI controller drivers
> 
> #
> # PCI Endpoint
> #
> # CONFIG_PCI_ENDPOINT is not set
> # end of PCI Endpoint
> 
> #
> # PCI switch controller drivers
> #
> # CONFIG_PCI_SW_SWITCHTEC is not set
> # end of PCI switch controller drivers
> 
> # CONFIG_CXL_BUS is not set
> # CONFIG_PCCARD is not set
> # CONFIG_RAPIDIO is not set
> 
> #
> # Generic Driver Options
> #
> # CONFIG_UEVENT_HELPER is not set
> CONFIG_DEVTMPFS=y
> # CONFIG_DEVTMPFS_MOUNT is not set
> # CONFIG_DEVTMPFS_SAFE is not set
> # CONFIG_STANDALONE is not set
> CONFIG_PREVENT_FIRMWARE_BUILD=y
> 
> #
> # Firmware loader
> #
> CONFIG_FW_LOADER=y
> CONFIG_FW_LOADER_PAGED_BUF=y
> CONFIG_EXTRA_FIRMWARE=""
> CONFIG_FW_LOADER_USER_HELPER=y
> CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
> CONFIG_FW_LOADER_COMPRESS=y
> # end of Firmware loader
> 
> CONFIG_WANT_DEV_COREDUMP=y
> CONFIG_ALLOW_DEV_COREDUMP=y
> CONFIG_DEV_COREDUMP=y
> # CONFIG_DEBUG_DRIVER is not set
> # CONFIG_DEBUG_DEVRES is not set
> # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> # CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
> CONFIG_GENERIC_CPU_AUTOPROBE=y
> CONFIG_GENERIC_CPU_VULNERABILITIES=y
> CONFIG_REGMAP=y
> CONFIG_REGMAP_I2C=y
> CONFIG_REGMAP_SPI=y
> CONFIG_REGMAP_SPMI=y
> CONFIG_REGMAP_W1=m
> CONFIG_REGMAP_MMIO=y
> CONFIG_REGMAP_IRQ=y
> CONFIG_REGMAP_SOUNDWIRE=m
> CONFIG_REGMAP_SOUNDWIRE_MBQ=m
> CONFIG_REGMAP_SCCB=m
> CONFIG_DMA_SHARED_BUFFER=y
> # CONFIG_DMA_FENCE_TRACE is not set
> # end of Generic Driver Options
> 
> #
> # Bus devices
> #
> CONFIG_MOXTET=y
> # CONFIG_MHI_BUS is not set
> # end of Bus devices
> 
> # CONFIG_CONNECTOR is not set
> 
> #
> # Firmware Drivers
> #
> 
> #
> # ARM System Control and Management Interface Protocol
> #
> # end of ARM System Control and Management Interface Protocol
> 
> CONFIG_EDD=y
> # CONFIG_EDD_OFF is not set
> CONFIG_FIRMWARE_MEMMAP=y
> # CONFIG_DMIID is not set
> CONFIG_DMI_SYSFS=m
> CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
> CONFIG_FW_CFG_SYSFS=m
> # CONFIG_FW_CFG_SYSFS_CMDLINE is not set
> CONFIG_SYSFB=y
> CONFIG_SYSFB_SIMPLEFB=y
> CONFIG_CS_DSP=m
> CONFIG_GOOGLE_FIRMWARE=y
> CONFIG_GOOGLE_SMI=m
> CONFIG_GOOGLE_COREBOOT_TABLE=y
> CONFIG_GOOGLE_MEMCONSOLE=m
> CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY=m
> # CONFIG_GOOGLE_MEMCONSOLE_COREBOOT is not set
> CONFIG_GOOGLE_VPD=y
> 
> #
> # EFI (Extensible Firmware Interface) Support
> #
> CONFIG_EFI_VARS=m
> CONFIG_EFI_ESRT=y
> CONFIG_EFI_FAKE_MEMMAP=y
> CONFIG_EFI_MAX_FAKE_MEM=8
> CONFIG_EFI_RUNTIME_WRAPPERS=y
> CONFIG_EFI_BOOTLOADER_CONTROL=m
> CONFIG_EFI_CAPSULE_LOADER=m
> # CONFIG_EFI_CAPSULE_QUIRK_QUARK_CSH is not set
> # CONFIG_EFI_TEST is not set
> # CONFIG_EFI_RCI2_TABLE is not set
> # CONFIG_EFI_DISABLE_PCI_DMA is not set
> # end of EFI (Extensible Firmware Interface) Support
> 
> CONFIG_EFI_EARLYCON=y
> # CONFIG_EFI_CUSTOM_SSDT_OVERLAYS is not set
> 
> #
> # Tegra firmware driver
> #
> # end of Tegra firmware driver
> # end of Firmware Drivers
> 
> CONFIG_GNSS=y
> CONFIG_GNSS_SERIAL=y
> CONFIG_GNSS_MTK_SERIAL=m
> # CONFIG_GNSS_SIRF_SERIAL is not set
> CONFIG_GNSS_UBX_SERIAL=y
> CONFIG_GNSS_USB=m
> CONFIG_MTD=y
> # CONFIG_MTD_TESTS is not set
> 
> #
> # Partition parsers
> #
> CONFIG_MTD_AR7_PARTS=y
> CONFIG_MTD_CMDLINE_PARTS=m
> # CONFIG_MTD_OF_PARTS is not set
> CONFIG_MTD_REDBOOT_PARTS=y
> CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
> # CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
> # CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
> # end of Partition parsers
> 
> #
> # User Modules And Translation Layers
> #
> CONFIG_MTD_BLKDEVS=y
> CONFIG_MTD_BLOCK=y
> 
> #
> # Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK.
> #
> # CONFIG_FTL is not set
> CONFIG_NFTL=y
> CONFIG_NFTL_RW=y
> # CONFIG_INFTL is not set
> CONFIG_RFD_FTL=y
> CONFIG_SSFDC=m
> CONFIG_SM_FTL=y
> CONFIG_MTD_OOPS=y
> CONFIG_MTD_SWAP=m
> # CONFIG_MTD_PARTITIONED_MASTER is not set
> 
> #
> # RAM/ROM/Flash chip drivers
> #
> CONFIG_MTD_CFI=y
> # CONFIG_MTD_JEDECPROBE is not set
> CONFIG_MTD_GEN_PROBE=y
> CONFIG_MTD_CFI_ADV_OPTIONS=y
> CONFIG_MTD_CFI_NOSWAP=y
> # CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
> # CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
> # CONFIG_MTD_CFI_GEOMETRY is not set
> CONFIG_MTD_MAP_BANK_WIDTH_1=y
> CONFIG_MTD_MAP_BANK_WIDTH_2=y
> CONFIG_MTD_MAP_BANK_WIDTH_4=y
> CONFIG_MTD_CFI_I1=y
> CONFIG_MTD_CFI_I2=y
> CONFIG_MTD_OTP=y
> CONFIG_MTD_CFI_INTELEXT=m
> CONFIG_MTD_CFI_AMDSTD=y
> CONFIG_MTD_CFI_STAA=m
> CONFIG_MTD_CFI_UTIL=y
> CONFIG_MTD_RAM=y
> CONFIG_MTD_ROM=y
> CONFIG_MTD_ABSENT=y
> # end of RAM/ROM/Flash chip drivers
> 
> #
> # Mapping drivers for chip access
> #
> CONFIG_MTD_COMPLEX_MAPPINGS=y
> # CONFIG_MTD_PHYSMAP is not set
> # CONFIG_MTD_SBC_GXX is not set
> # CONFIG_MTD_SCx200_DOCFLASH is not set
> # CONFIG_MTD_PCI is not set
> # CONFIG_MTD_INTEL_VR_NOR is not set
> CONFIG_MTD_PLATRAM=m
> # end of Mapping drivers for chip access
> 
> #
> # Self-contained MTD device drivers
> #
> # CONFIG_MTD_PMC551 is not set
> CONFIG_MTD_DATAFLASH=m
> # CONFIG_MTD_DATAFLASH_WRITE_VERIFY is not set
> # CONFIG_MTD_DATAFLASH_OTP is not set
> # CONFIG_MTD_MCHP23K256 is not set
> CONFIG_MTD_MCHP48L640=m
> # CONFIG_MTD_SST25L is not set
> # CONFIG_MTD_SLRAM is not set
> CONFIG_MTD_PHRAM=y
> # CONFIG_MTD_MTDRAM is not set
> CONFIG_MTD_BLOCK2MTD=y
> 
> #
> # Disk-On-Chip Device Drivers
> #
> CONFIG_MTD_DOCG3=y
> CONFIG_BCH_CONST_M=14
> CONFIG_BCH_CONST_T=4
> # end of Self-contained MTD device drivers
> 
> #
> # NAND
> #
> CONFIG_MTD_NAND_CORE=y
> CONFIG_MTD_ONENAND=y
> CONFIG_MTD_ONENAND_VERIFY_WRITE=y
> # CONFIG_MTD_ONENAND_GENERIC is not set
> # CONFIG_MTD_ONENAND_OTP is not set
> CONFIG_MTD_ONENAND_2X_PROGRAM=y
> CONFIG_MTD_RAW_NAND=m
> 
> #
> # Raw/parallel NAND flash controllers
> #
> CONFIG_MTD_NAND_DENALI=m
> # CONFIG_MTD_NAND_DENALI_PCI is not set
> CONFIG_MTD_NAND_DENALI_DT=m
> # CONFIG_MTD_NAND_CAFE is not set
> CONFIG_MTD_NAND_CS553X=m
> # CONFIG_MTD_NAND_MXIC is not set
> CONFIG_MTD_NAND_GPIO=m
> CONFIG_MTD_NAND_PLATFORM=m
> CONFIG_MTD_NAND_CADENCE=m
> # CONFIG_MTD_NAND_ARASAN is not set
> # CONFIG_MTD_NAND_INTEL_LGM is not set
> 
> #
> # Misc
> #
> # CONFIG_MTD_NAND_NANDSIM is not set
> # CONFIG_MTD_NAND_RICOH is not set
> CONFIG_MTD_NAND_DISKONCHIP=m
> CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED=y
> CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
> # CONFIG_MTD_NAND_DISKONCHIP_PROBE_HIGH is not set
> CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE=y
> # CONFIG_MTD_SPI_NAND is not set
> 
> #
> # ECC engine support
> #
> CONFIG_MTD_NAND_ECC=y
> CONFIG_MTD_NAND_ECC_SW_HAMMING=y
> # CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC is not set
> CONFIG_MTD_NAND_ECC_SW_BCH=y
> # end of ECC engine support
> # end of NAND
> 
> #
> # LPDDR & LPDDR2 PCM memory drivers
> #
> CONFIG_MTD_LPDDR=y
> CONFIG_MTD_QINFO_PROBE=y
> # end of LPDDR & LPDDR2 PCM memory drivers
> 
> CONFIG_MTD_SPI_NOR=m
> CONFIG_MTD_SPI_NOR_USE_4K_SECTORS=y
> # CONFIG_MTD_SPI_NOR_SWP_DISABLE is not set
> # CONFIG_MTD_SPI_NOR_SWP_DISABLE_ON_VOLATILE is not set
> CONFIG_MTD_SPI_NOR_SWP_KEEP=y
> CONFIG_SPI_INTEL_SPI=m
> # CONFIG_SPI_INTEL_SPI_PCI is not set
> CONFIG_SPI_INTEL_SPI_PLATFORM=m
> CONFIG_MTD_UBI=m
> CONFIG_MTD_UBI_WL_THRESHOLD=4096
> CONFIG_MTD_UBI_BEB_LIMIT=20
> CONFIG_MTD_UBI_FASTMAP=y
> CONFIG_MTD_UBI_GLUEBI=m
> # CONFIG_MTD_UBI_BLOCK is not set
> CONFIG_MTD_HYPERBUS=y
> CONFIG_DTC=y
> CONFIG_OF=y
> # CONFIG_OF_UNITTEST is not set
> CONFIG_OF_FLATTREE=y
> CONFIG_OF_EARLY_FLATTREE=y
> CONFIG_OF_PROMTREE=y
> CONFIG_OF_KOBJ=y
> CONFIG_OF_ADDRESS=y
> CONFIG_OF_IRQ=y
> CONFIG_OF_RESERVED_MEM=y
> # CONFIG_OF_OVERLAY is not set
> CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
> # CONFIG_PARPORT is not set
> CONFIG_PNP=y
> CONFIG_PNP_DEBUG_MESSAGES=y
> 
> #
> # Protocols
> #
> # CONFIG_ISAPNP is not set
> # CONFIG_PNPBIOS is not set
> CONFIG_PNPACPI=y
> CONFIG_BLK_DEV=y
> CONFIG_BLK_DEV_NULL_BLK=m
> # CONFIG_BLK_DEV_FD is not set
> CONFIG_CDROM=m
> # CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
> CONFIG_BLK_DEV_LOOP=m
> CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
> # CONFIG_BLK_DEV_DRBD is not set
> CONFIG_BLK_DEV_NBD=y
> # CONFIG_BLK_DEV_SX8 is not set
> # CONFIG_BLK_DEV_RAM is not set
> CONFIG_CDROM_PKTCDVD=m
> CONFIG_CDROM_PKTCDVD_BUFFERS=8
> CONFIG_CDROM_PKTCDVD_WCACHE=y
> # CONFIG_ATA_OVER_ETH is not set
> CONFIG_VIRTIO_BLK=m
> # CONFIG_BLK_DEV_RBD is not set
> 
> #
> # NVME Support
> #
> CONFIG_NVME_CORE=y
> # CONFIG_BLK_DEV_NVME is not set
> CONFIG_NVME_MULTIPATH=y
> CONFIG_NVME_FABRICS=y
> CONFIG_NVME_FC=y
> # CONFIG_NVME_TCP is not set
> CONFIG_NVME_TARGET=m
> # CONFIG_NVME_TARGET_PASSTHRU is not set
> # CONFIG_NVME_TARGET_LOOP is not set
> CONFIG_NVME_TARGET_FC=m
> CONFIG_NVME_TARGET_FCLOOP=m
> # CONFIG_NVME_TARGET_TCP is not set
> # end of NVME Support
> 
> #
> # Misc devices
> #
> CONFIG_SENSORS_LIS3LV02D=y
> CONFIG_AD525X_DPOT=m
> CONFIG_AD525X_DPOT_I2C=m
> CONFIG_AD525X_DPOT_SPI=m
> CONFIG_DUMMY_IRQ=m
> # CONFIG_IBM_ASM is not set
> # CONFIG_PHANTOM is not set
> # CONFIG_TIFM_CORE is not set
> CONFIG_ICS932S401=y
> CONFIG_ENCLOSURE_SERVICES=m
> CONFIG_HI6421V600_IRQ=y
> # CONFIG_HP_ILO is not set
> # CONFIG_APDS9802ALS is not set
> CONFIG_ISL29003=y
> CONFIG_ISL29020=m
> CONFIG_SENSORS_TSL2550=m
> # CONFIG_SENSORS_BH1770 is not set
> CONFIG_SENSORS_APDS990X=y
> CONFIG_HMC6352=y
> CONFIG_DS1682=m
> # CONFIG_PCH_PHUB is not set
> CONFIG_LATTICE_ECP3_CONFIG=m
> CONFIG_SRAM=y
> # CONFIG_DW_XDATA_PCIE is not set
> # CONFIG_PCI_ENDPOINT_TEST is not set
> CONFIG_XILINX_SDFEC=y
> CONFIG_HISI_HIKEY_USB=m
> # CONFIG_C2PORT is not set
> 
> #
> # EEPROM support
> #
> CONFIG_EEPROM_AT24=m
> # CONFIG_EEPROM_AT25 is not set
> CONFIG_EEPROM_LEGACY=y
> CONFIG_EEPROM_MAX6875=y
> CONFIG_EEPROM_93CX6=y
> CONFIG_EEPROM_93XX46=m
> CONFIG_EEPROM_IDT_89HPESX=y
> CONFIG_EEPROM_EE1004=y
> # end of EEPROM support
> 
> # CONFIG_CB710_CORE is not set
> 
> #
> # Texas Instruments shared transport line discipline
> #
> # CONFIG_TI_ST is not set
> # end of Texas Instruments shared transport line discipline
> 
> CONFIG_SENSORS_LIS3_I2C=y
> # CONFIG_ALTERA_STAPL is not set
> # CONFIG_INTEL_MEI is not set
> # CONFIG_INTEL_MEI_ME is not set
> # CONFIG_INTEL_MEI_TXE is not set
> # CONFIG_VMWARE_VMCI is not set
> CONFIG_ECHO=y
> # CONFIG_MISC_ALCOR_PCI is not set
> # CONFIG_MISC_RTSX_PCI is not set
> # CONFIG_MISC_RTSX_USB is not set
> # CONFIG_HABANA_AI is not set
> # CONFIG_PVPANIC is not set
> # end of Misc devices
> 
> #
> # SCSI device support
> #
> CONFIG_SCSI_MOD=y
> CONFIG_RAID_ATTRS=y
> CONFIG_SCSI_COMMON=y
> CONFIG_SCSI=y
> CONFIG_SCSI_DMA=y
> CONFIG_SCSI_NETLINK=y
> CONFIG_SCSI_PROC_FS=y
> 
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> # CONFIG_BLK_DEV_SD is not set
> CONFIG_CHR_DEV_ST=y
> CONFIG_BLK_DEV_SR=m
> CONFIG_CHR_DEV_SG=y
> # CONFIG_BLK_DEV_BSG is not set
> # CONFIG_CHR_DEV_SCH is not set
> # CONFIG_SCSI_ENCLOSURE is not set
> # CONFIG_SCSI_CONSTANTS is not set
> # CONFIG_SCSI_LOGGING is not set
> # CONFIG_SCSI_SCAN_ASYNC is not set
> 
> #
> # SCSI Transports
> #
> CONFIG_SCSI_SPI_ATTRS=m
> CONFIG_SCSI_FC_ATTRS=m
> # CONFIG_SCSI_ISCSI_ATTRS is not set
> CONFIG_SCSI_SAS_ATTRS=m
> # CONFIG_SCSI_SAS_LIBSAS is not set
> # CONFIG_SCSI_SRP_ATTRS is not set
> # end of SCSI Transports
> 
> # CONFIG_SCSI_LOWLEVEL is not set
> # CONFIG_SCSI_DH is not set
> # end of SCSI device support
> 
> CONFIG_ATA=y
> CONFIG_SATA_HOST=y
> CONFIG_ATA_VERBOSE_ERROR=y
> CONFIG_ATA_FORCE=y
> # CONFIG_ATA_ACPI is not set
> CONFIG_SATA_PMP=y
> 
> #
> # Controllers with non-SFF native interface
> #
> # CONFIG_SATA_AHCI is not set
> CONFIG_SATA_AHCI_PLATFORM=y
> # CONFIG_AHCI_CEVA is not set
> CONFIG_AHCI_QORIQ=m
> # CONFIG_SATA_INIC162X is not set
> # CONFIG_SATA_ACARD_AHCI is not set
> # CONFIG_SATA_SIL24 is not set
> # CONFIG_ATA_SFF is not set
> # CONFIG_MD is not set
> # CONFIG_TARGET_CORE is not set
> # CONFIG_FUSION is not set
> 
> #
> # IEEE 1394 (FireWire) support
> #
> CONFIG_FIREWIRE=y
> # CONFIG_FIREWIRE_OHCI is not set
> CONFIG_FIREWIRE_SBP2=y
> # CONFIG_FIREWIRE_NET is not set
> # CONFIG_FIREWIRE_NOSY is not set
> # end of IEEE 1394 (FireWire) support
> 
> # CONFIG_MACINTOSH_DRIVERS is not set
> CONFIG_NETDEVICES=y
> CONFIG_NET_CORE=y
> # CONFIG_BONDING is not set
> # CONFIG_DUMMY is not set
> # CONFIG_WIREGUARD is not set
> # CONFIG_EQUALIZER is not set
> # CONFIG_NET_FC is not set
> # CONFIG_NET_TEAM is not set
> # CONFIG_MACVLAN is not set
> # CONFIG_IPVLAN is not set
> # CONFIG_VXLAN is not set
> # CONFIG_GENEVE is not set
> # CONFIG_BAREUDP is not set
> # CONFIG_GTP is not set
> # CONFIG_MACSEC is not set
> # CONFIG_NETCONSOLE is not set
> # CONFIG_TUN is not set
> # CONFIG_TUN_VNET_CROSS_LE is not set
> # CONFIG_VETH is not set
> CONFIG_VIRTIO_NET=m
> # CONFIG_NLMON is not set
> # CONFIG_VSOCKMON is not set
> # CONFIG_ARCNET is not set
> CONFIG_ATM_DRIVERS=y
> # CONFIG_ATM_DUMMY is not set
> # CONFIG_ATM_TCP is not set
> # CONFIG_ATM_LANAI is not set
> # CONFIG_ATM_ENI is not set
> # CONFIG_ATM_FIRESTREAM is not set
> # CONFIG_ATM_ZATM is not set
> # CONFIG_ATM_NICSTAR is not set
> # CONFIG_ATM_IDT77252 is not set
> # CONFIG_ATM_AMBASSADOR is not set
> # CONFIG_ATM_HORIZON is not set
> # CONFIG_ATM_IA is not set
> # CONFIG_ATM_FORE200E is not set
> # CONFIG_ATM_HE is not set
> # CONFIG_ATM_SOLOS is not set
> CONFIG_ETHERNET=y
> CONFIG_NET_VENDOR_3COM=y
> # CONFIG_EL3 is not set
> # CONFIG_3C515 is not set
> # CONFIG_VORTEX is not set
> # CONFIG_TYPHOON is not set
> CONFIG_NET_VENDOR_ADAPTEC=y
> # CONFIG_ADAPTEC_STARFIRE is not set
> CONFIG_NET_VENDOR_AGERE=y
> # CONFIG_ET131X is not set
> CONFIG_NET_VENDOR_ALACRITECH=y
> # CONFIG_SLICOSS is not set
> CONFIG_NET_VENDOR_ALTEON=y
> # CONFIG_ACENIC is not set
> # CONFIG_ALTERA_TSE is not set
> CONFIG_NET_VENDOR_AMAZON=y
> # CONFIG_NET_VENDOR_AMD is not set
> CONFIG_NET_VENDOR_AQUANTIA=y
> # CONFIG_AQTION is not set
> CONFIG_NET_VENDOR_ARC=y
> CONFIG_NET_VENDOR_ASIX=y
> # CONFIG_SPI_AX88796C is not set
> CONFIG_NET_VENDOR_ATHEROS=y
> # CONFIG_ATL2 is not set
> # CONFIG_ATL1 is not set
> # CONFIG_ATL1E is not set
> # CONFIG_ATL1C is not set
> # CONFIG_ALX is not set
> CONFIG_NET_VENDOR_BROADCOM=y
> # CONFIG_B44 is not set
> # CONFIG_BCMGENET is not set
> # CONFIG_BNX2 is not set
> # CONFIG_CNIC is not set
> # CONFIG_TIGON3 is not set
> # CONFIG_BNX2X is not set
> # CONFIG_SYSTEMPORT is not set
> # CONFIG_BNXT is not set
> CONFIG_NET_VENDOR_BROCADE=y
> # CONFIG_BNA is not set
> CONFIG_NET_VENDOR_CADENCE=y
> # CONFIG_MACB is not set
> CONFIG_NET_VENDOR_CAVIUM=y
> CONFIG_NET_VENDOR_CHELSIO=y
> # CONFIG_CHELSIO_T1 is not set
> # CONFIG_CHELSIO_T3 is not set
> # CONFIG_CHELSIO_T4 is not set
> # CONFIG_CHELSIO_T4VF is not set
> CONFIG_NET_VENDOR_CIRRUS=y
> # CONFIG_CS89x0_ISA is not set
> CONFIG_NET_VENDOR_CISCO=y
> # CONFIG_ENIC is not set
> CONFIG_NET_VENDOR_CORTINA=y
> # CONFIG_GEMINI_ETHERNET is not set
> # CONFIG_CX_ECAT is not set
> # CONFIG_DNET is not set
> CONFIG_NET_VENDOR_DEC=y
> # CONFIG_NET_TULIP is not set
> CONFIG_NET_VENDOR_DLINK=y
> # CONFIG_DL2K is not set
> # CONFIG_SUNDANCE is not set
> CONFIG_NET_VENDOR_EMULEX=y
> # CONFIG_BE2NET is not set
> CONFIG_NET_VENDOR_ENGLEDER=y
> # CONFIG_TSNEP is not set
> CONFIG_NET_VENDOR_EZCHIP=y
> # CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
> CONFIG_NET_VENDOR_GOOGLE=y
> CONFIG_NET_VENDOR_HUAWEI=y
> CONFIG_NET_VENDOR_I825XX=y
> CONFIG_NET_VENDOR_INTEL=y
> # CONFIG_E100 is not set
> CONFIG_E1000=y
> # CONFIG_E1000E is not set
> # CONFIG_IGB is not set
> # CONFIG_IGBVF is not set
> # CONFIG_IXGB is not set
> # CONFIG_IXGBE is not set
> # CONFIG_I40E is not set
> # CONFIG_IGC is not set
> CONFIG_NET_VENDOR_MICROSOFT=y
> # CONFIG_JME is not set
> CONFIG_NET_VENDOR_LITEX=y
> # CONFIG_LITEX_LITEETH is not set
> CONFIG_NET_VENDOR_MARVELL=y
> # CONFIG_MVMDIO is not set
> # CONFIG_SKGE is not set
> # CONFIG_SKY2 is not set
> CONFIG_NET_VENDOR_MELLANOX=y
> # CONFIG_MLX4_EN is not set
> # CONFIG_MLX5_CORE is not set
> # CONFIG_MLXSW_CORE is not set
> # CONFIG_MLXFW is not set
> CONFIG_NET_VENDOR_MICREL=y
> # CONFIG_KS8851 is not set
> # CONFIG_KS8851_MLL is not set
> # CONFIG_KSZ884X_PCI is not set
> CONFIG_NET_VENDOR_MICROCHIP=y
> # CONFIG_ENC28J60 is not set
> # CONFIG_ENCX24J600 is not set
> # CONFIG_LAN743X is not set
> CONFIG_NET_VENDOR_MICROSEMI=y
> CONFIG_NET_VENDOR_MYRI=y
> # CONFIG_MYRI10GE is not set
> # CONFIG_FEALNX is not set
> CONFIG_NET_VENDOR_NATSEMI=y
> # CONFIG_NATSEMI is not set
> # CONFIG_NS83820 is not set
> CONFIG_NET_VENDOR_NETERION=y
> # CONFIG_S2IO is not set
> # CONFIG_VXGE is not set
> CONFIG_NET_VENDOR_NETRONOME=y
> CONFIG_NET_VENDOR_NI=y
> # CONFIG_NI_XGE_MANAGEMENT_ENET is not set
> CONFIG_NET_VENDOR_8390=y
> # CONFIG_NE2000 is not set
> # CONFIG_NE2K_PCI is not set
> # CONFIG_ULTRA is not set
> # CONFIG_WD80x3 is not set
> CONFIG_NET_VENDOR_NVIDIA=y
> # CONFIG_FORCEDETH is not set
> CONFIG_NET_VENDOR_OKI=y
> # CONFIG_ETHOC is not set
> CONFIG_NET_VENDOR_PACKET_ENGINES=y
> # CONFIG_HAMACHI is not set
> # CONFIG_YELLOWFIN is not set
> CONFIG_NET_VENDOR_PENSANDO=y
> CONFIG_NET_VENDOR_QLOGIC=y
> # CONFIG_QLA3XXX is not set
> # CONFIG_QLCNIC is not set
> # CONFIG_NETXEN_NIC is not set
> # CONFIG_QED is not set
> CONFIG_NET_VENDOR_QUALCOMM=y
> # CONFIG_QCA7000_SPI is not set
> # CONFIG_QCA7000_UART is not set
> # CONFIG_QCOM_EMAC is not set
> # CONFIG_RMNET is not set
> CONFIG_NET_VENDOR_RDC=y
> # CONFIG_R6040 is not set
> CONFIG_NET_VENDOR_REALTEK=y
> # CONFIG_8139CP is not set
> # CONFIG_8139TOO is not set
> # CONFIG_R8169 is not set
> CONFIG_NET_VENDOR_RENESAS=y
> CONFIG_NET_VENDOR_ROCKER=y
> CONFIG_NET_VENDOR_SAMSUNG=y
> # CONFIG_SXGBE_ETH is not set
> CONFIG_NET_VENDOR_SEEQ=y
> CONFIG_NET_VENDOR_SOLARFLARE=y
> # CONFIG_SFC is not set
> # CONFIG_SFC_FALCON is not set
> CONFIG_NET_VENDOR_SILAN=y
> # CONFIG_SC92031 is not set
> CONFIG_NET_VENDOR_SIS=y
> # CONFIG_SIS900 is not set
> # CONFIG_SIS190 is not set
> CONFIG_NET_VENDOR_SMSC=y
> # CONFIG_SMC9194 is not set
> # CONFIG_EPIC100 is not set
> # CONFIG_SMSC911X is not set
> # CONFIG_SMSC9420 is not set
> CONFIG_NET_VENDOR_SOCIONEXT=y
> CONFIG_NET_VENDOR_STMICRO=y
> # CONFIG_STMMAC_ETH is not set
> CONFIG_NET_VENDOR_SUN=y
> # CONFIG_HAPPYMEAL is not set
> # CONFIG_SUNGEM is not set
> # CONFIG_CASSINI is not set
> # CONFIG_NIU is not set
> CONFIG_NET_VENDOR_SYNOPSYS=y
> # CONFIG_DWC_XLGMAC is not set
> CONFIG_NET_VENDOR_TEHUTI=y
> # CONFIG_TEHUTI is not set
> CONFIG_NET_VENDOR_TI=y
> # CONFIG_TI_CPSW_PHY_SEL is not set
> # CONFIG_TLAN is not set
> CONFIG_NET_VENDOR_VERTEXCOM=y
> # CONFIG_MSE102X is not set
> CONFIG_NET_VENDOR_VIA=y
> # CONFIG_VIA_RHINE is not set
> # CONFIG_VIA_VELOCITY is not set
> CONFIG_NET_VENDOR_WIZNET=y
> # CONFIG_WIZNET_W5100 is not set
> # CONFIG_WIZNET_W5300 is not set
> CONFIG_NET_VENDOR_XILINX=y
> # CONFIG_XILINX_EMACLITE is not set
> # CONFIG_XILINX_AXI_EMAC is not set
> # CONFIG_XILINX_LL_TEMAC is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> # CONFIG_NET_SB1000 is not set
> # CONFIG_PHYLIB is not set
> # CONFIG_MICREL_KS8995MA is not set
> # CONFIG_MDIO_DEVICE is not set
> 
> #
> # PCS device drivers
> #
> # end of PCS device drivers
> 
> # CONFIG_PPP is not set
> # CONFIG_SLIP is not set
> CONFIG_USB_NET_DRIVERS=y
> # CONFIG_USB_CATC is not set
> # CONFIG_USB_KAWETH is not set
> # CONFIG_USB_PEGASUS is not set
> # CONFIG_USB_RTL8150 is not set
> # CONFIG_USB_RTL8152 is not set
> # CONFIG_USB_LAN78XX is not set
> # CONFIG_USB_USBNET is not set
> # CONFIG_USB_HSO is not set
> # CONFIG_USB_IPHETH is not set
> CONFIG_WLAN=y
> CONFIG_WLAN_VENDOR_ADMTEK=y
> # CONFIG_ADM8211 is not set
> CONFIG_WLAN_VENDOR_ATH=y
> # CONFIG_ATH_DEBUG is not set
> # CONFIG_ATH5K is not set
> # CONFIG_ATH5K_PCI is not set
> # CONFIG_ATH9K is not set
> # CONFIG_ATH9K_HTC is not set
> # CONFIG_CARL9170 is not set
> # CONFIG_ATH6KL is not set
> # CONFIG_AR5523 is not set
> # CONFIG_WIL6210 is not set
> # CONFIG_ATH10K is not set
> # CONFIG_WCN36XX is not set
> CONFIG_WLAN_VENDOR_ATMEL=y
> # CONFIG_ATMEL is not set
> # CONFIG_AT76C50X_USB is not set
> CONFIG_WLAN_VENDOR_BROADCOM=y
> # CONFIG_B43 is not set
> # CONFIG_B43LEGACY is not set
> # CONFIG_BRCMSMAC is not set
> # CONFIG_BRCMFMAC is not set
> CONFIG_WLAN_VENDOR_CISCO=y
> # CONFIG_AIRO is not set
> CONFIG_WLAN_VENDOR_INTEL=y
> # CONFIG_IPW2100 is not set
> # CONFIG_IPW2200 is not set
> # CONFIG_IWL4965 is not set
> # CONFIG_IWL3945 is not set
> # CONFIG_IWLWIFI is not set
> CONFIG_WLAN_VENDOR_INTERSIL=y
> # CONFIG_HOSTAP is not set
> # CONFIG_HERMES is not set
> # CONFIG_P54_COMMON is not set
> CONFIG_WLAN_VENDOR_MARVELL=y
> # CONFIG_LIBERTAS is not set
> # CONFIG_LIBERTAS_THINFIRM is not set
> # CONFIG_MWIFIEX is not set
> # CONFIG_MWL8K is not set
> CONFIG_WLAN_VENDOR_MEDIATEK=y
> # CONFIG_MT7601U is not set
> # CONFIG_MT76x0U is not set
> # CONFIG_MT76x0E is not set
> # CONFIG_MT76x2E is not set
> # CONFIG_MT76x2U is not set
> # CONFIG_MT7603E is not set
> # CONFIG_MT7615E is not set
> # CONFIG_MT7663U is not set
> # CONFIG_MT7663S is not set
> # CONFIG_MT7915E is not set
> # CONFIG_MT7921E is not set
> # CONFIG_MT7921S is not set
> CONFIG_WLAN_VENDOR_MICROCHIP=y
> # CONFIG_WILC1000_SDIO is not set
> # CONFIG_WILC1000_SPI is not set
> CONFIG_WLAN_VENDOR_RALINK=y
> # CONFIG_RT2X00 is not set
> CONFIG_WLAN_VENDOR_REALTEK=y
> # CONFIG_RTL8180 is not set
> # CONFIG_RTL8187 is not set
> CONFIG_RTL_CARDS=y
> # CONFIG_RTL8192CE is not set
> # CONFIG_RTL8192SE is not set
> # CONFIG_RTL8192DE is not set
> # CONFIG_RTL8723AE is not set
> # CONFIG_RTL8723BE is not set
> # CONFIG_RTL8188EE is not set
> # CONFIG_RTL8192EE is not set
> # CONFIG_RTL8821AE is not set
> # CONFIG_RTL8192CU is not set
> # CONFIG_RTL8XXXU is not set
> # CONFIG_RTW88 is not set
> # CONFIG_RTW89 is not set
> CONFIG_WLAN_VENDOR_RSI=y
> # CONFIG_RSI_91X is not set
> CONFIG_WLAN_VENDOR_ST=y
> # CONFIG_CW1200 is not set
> CONFIG_WLAN_VENDOR_TI=y
> # CONFIG_WL1251 is not set
> # CONFIG_WL12XX is not set
> # CONFIG_WL18XX is not set
> # CONFIG_WLCORE is not set
> CONFIG_WLAN_VENDOR_ZYDAS=y
> # CONFIG_USB_ZD1201 is not set
> # CONFIG_ZD1211RW is not set
> CONFIG_WLAN_VENDOR_QUANTENNA=y
> # CONFIG_QTNFMAC_PCIE is not set
> # CONFIG_MAC80211_HWSIM is not set
> # CONFIG_USB_NET_RNDIS_WLAN is not set
> # CONFIG_VIRT_WIFI is not set
> # CONFIG_WAN is not set
> CONFIG_IEEE802154_DRIVERS=m
> # CONFIG_IEEE802154_FAKELB is not set
> # CONFIG_IEEE802154_AT86RF230 is not set
> # CONFIG_IEEE802154_MRF24J40 is not set
> # CONFIG_IEEE802154_CC2520 is not set
> # CONFIG_IEEE802154_ATUSB is not set
> # CONFIG_IEEE802154_ADF7242 is not set
> # CONFIG_IEEE802154_CA8210 is not set
> # CONFIG_IEEE802154_MCR20A is not set
> # CONFIG_IEEE802154_HWSIM is not set
> 
> #
> # Wireless WAN
> #
> # CONFIG_WWAN is not set
> # end of Wireless WAN
> 
> # CONFIG_VMXNET3 is not set
> # CONFIG_FUJITSU_ES is not set
> # CONFIG_NETDEVSIM is not set
> CONFIG_NET_FAILOVER=m
> # CONFIG_ISDN is not set
> 
> #
> # Input device support
> #
> CONFIG_INPUT=y
> CONFIG_INPUT_LEDS=m
> CONFIG_INPUT_FF_MEMLESS=y
> CONFIG_INPUT_SPARSEKMAP=y
> CONFIG_INPUT_MATRIXKMAP=y
> 
> #
> # Userland interfaces
> #
> # CONFIG_INPUT_MOUSEDEV is not set
> CONFIG_INPUT_JOYDEV=m
> # CONFIG_INPUT_EVDEV is not set
> # CONFIG_INPUT_EVBUG is not set
> 
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=y
> # CONFIG_KEYBOARD_ADC is not set
> # CONFIG_KEYBOARD_ADP5588 is not set
> # CONFIG_KEYBOARD_ADP5589 is not set
> # CONFIG_KEYBOARD_APPLESPI is not set
> CONFIG_KEYBOARD_ATKBD=y
> # CONFIG_KEYBOARD_QT1050 is not set
> # CONFIG_KEYBOARD_QT1070 is not set
> # CONFIG_KEYBOARD_QT2160 is not set
> # CONFIG_KEYBOARD_DLINK_DIR685 is not set
> # CONFIG_KEYBOARD_LKKBD is not set
> # CONFIG_KEYBOARD_GPIO is not set
> # CONFIG_KEYBOARD_GPIO_POLLED is not set
> # CONFIG_KEYBOARD_TCA6416 is not set
> # CONFIG_KEYBOARD_TCA8418 is not set
> # CONFIG_KEYBOARD_MATRIX is not set
> # CONFIG_KEYBOARD_LM8323 is not set
> # CONFIG_KEYBOARD_LM8333 is not set
> # CONFIG_KEYBOARD_MAX7359 is not set
> # CONFIG_KEYBOARD_MCS is not set
> # CONFIG_KEYBOARD_MPR121 is not set
> # CONFIG_KEYBOARD_NEWTON is not set
> # CONFIG_KEYBOARD_OPENCORES is not set
> # CONFIG_KEYBOARD_SAMSUNG is not set
> # CONFIG_KEYBOARD_STOWAWAY is not set
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_STMPE is not set
> # CONFIG_KEYBOARD_IQS62X is not set
> # CONFIG_KEYBOARD_OMAP4 is not set
> # CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
> # CONFIG_KEYBOARD_XTKBD is not set
> # CONFIG_KEYBOARD_CROS_EC is not set
> # CONFIG_KEYBOARD_CAP11XX is not set
> # CONFIG_KEYBOARD_BCM is not set
> # CONFIG_KEYBOARD_MTK_PMIC is not set
> # CONFIG_KEYBOARD_CYPRESS_SF is not set
> # CONFIG_INPUT_MOUSE is not set
> # CONFIG_INPUT_JOYSTICK is not set
> CONFIG_INPUT_TABLET=y
> # CONFIG_TABLET_USB_ACECAD is not set
> # CONFIG_TABLET_USB_AIPTEK is not set
> # CONFIG_TABLET_USB_HANWANG is not set
> CONFIG_TABLET_USB_KBTAB=y
> CONFIG_TABLET_USB_PEGASUS=y
> # CONFIG_TABLET_SERIAL_WACOM4 is not set
> CONFIG_INPUT_TOUCHSCREEN=y
> CONFIG_TOUCHSCREEN_ADS7846=m
> CONFIG_TOUCHSCREEN_AD7877=y
> # CONFIG_TOUCHSCREEN_AD7879 is not set
> CONFIG_TOUCHSCREEN_ADC=m
> # CONFIG_TOUCHSCREEN_AR1021_I2C is not set
> # CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
> CONFIG_TOUCHSCREEN_AUO_PIXCIR=y
> CONFIG_TOUCHSCREEN_BU21013=y
> CONFIG_TOUCHSCREEN_BU21029=y
> CONFIG_TOUCHSCREEN_CHIPONE_ICN8318=m
> # CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
> CONFIG_TOUCHSCREEN_CY8CTMA140=m
> # CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
> # CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
> # CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
> CONFIG_TOUCHSCREEN_DA9052=m
> CONFIG_TOUCHSCREEN_DYNAPRO=m
> # CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
> # CONFIG_TOUCHSCREEN_EETI is not set
> CONFIG_TOUCHSCREEN_EGALAX=y
> CONFIG_TOUCHSCREEN_EGALAX_SERIAL=y
> CONFIG_TOUCHSCREEN_EXC3000=m
> CONFIG_TOUCHSCREEN_FUJITSU=m
> # CONFIG_TOUCHSCREEN_GOODIX is not set
> CONFIG_TOUCHSCREEN_HIDEEP=y
> CONFIG_TOUCHSCREEN_HYCON_HY46XX=m
> # CONFIG_TOUCHSCREEN_ILI210X is not set
> CONFIG_TOUCHSCREEN_ILITEK=m
> CONFIG_TOUCHSCREEN_S6SY761=y
> CONFIG_TOUCHSCREEN_GUNZE=m
> CONFIG_TOUCHSCREEN_EKTF2127=m
> # CONFIG_TOUCHSCREEN_ELAN is not set
> CONFIG_TOUCHSCREEN_ELO=y
> CONFIG_TOUCHSCREEN_WACOM_W8001=y
> # CONFIG_TOUCHSCREEN_WACOM_I2C is not set
> # CONFIG_TOUCHSCREEN_MAX11801 is not set
> CONFIG_TOUCHSCREEN_MCS5000=m
> CONFIG_TOUCHSCREEN_MMS114=y
> # CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
> # CONFIG_TOUCHSCREEN_MSG2638 is not set
> CONFIG_TOUCHSCREEN_MTOUCH=m
> CONFIG_TOUCHSCREEN_IMX6UL_TSC=m
> # CONFIG_TOUCHSCREEN_INEXIO is not set
> CONFIG_TOUCHSCREEN_MK712=m
> CONFIG_TOUCHSCREEN_HTCPEN=m
> # CONFIG_TOUCHSCREEN_PENMOUNT is not set
> # CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
> # CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
> # CONFIG_TOUCHSCREEN_TOUCHWIN is not set
> CONFIG_TOUCHSCREEN_UCB1400=m
> # CONFIG_TOUCHSCREEN_PIXCIR is not set
> # CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
> CONFIG_TOUCHSCREEN_WM831X=y
> CONFIG_TOUCHSCREEN_WM97XX=m
> CONFIG_TOUCHSCREEN_WM9705=y
> # CONFIG_TOUCHSCREEN_WM9712 is not set
> # CONFIG_TOUCHSCREEN_WM9713 is not set
> # CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
> CONFIG_TOUCHSCREEN_MC13783=m
> CONFIG_TOUCHSCREEN_TOUCHIT213=y
> # CONFIG_TOUCHSCREEN_TSC_SERIO is not set
> CONFIG_TOUCHSCREEN_TSC200X_CORE=y
> # CONFIG_TOUCHSCREEN_TSC2004 is not set
> CONFIG_TOUCHSCREEN_TSC2005=y
> # CONFIG_TOUCHSCREEN_TSC2007 is not set
> # CONFIG_TOUCHSCREEN_PCAP is not set
> # CONFIG_TOUCHSCREEN_RM_TS is not set
> # CONFIG_TOUCHSCREEN_SILEAD is not set
> CONFIG_TOUCHSCREEN_SIS_I2C=y
> # CONFIG_TOUCHSCREEN_ST1232 is not set
> # CONFIG_TOUCHSCREEN_STMFTS is not set
> # CONFIG_TOUCHSCREEN_STMPE is not set
> CONFIG_TOUCHSCREEN_SUR40=m
> # CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
> CONFIG_TOUCHSCREEN_SX8654=m
> CONFIG_TOUCHSCREEN_TPS6507X=y
> # CONFIG_TOUCHSCREEN_ZET6223 is not set
> CONFIG_TOUCHSCREEN_ZFORCE=y
> # CONFIG_TOUCHSCREEN_COLIBRI_VF50 is not set
> CONFIG_TOUCHSCREEN_ROHM_BU21023=y
> CONFIG_TOUCHSCREEN_IQS5XX=y
> CONFIG_TOUCHSCREEN_ZINITIX=m
> CONFIG_INPUT_MISC=y
> # CONFIG_INPUT_88PM80X_ONKEY is not set
> CONFIG_INPUT_AD714X=y
> CONFIG_INPUT_AD714X_I2C=y
> CONFIG_INPUT_AD714X_SPI=m
> CONFIG_INPUT_ARIZONA_HAPTICS=m
> # CONFIG_INPUT_ATC260X_ONKEY is not set
> # CONFIG_INPUT_ATMEL_CAPTOUCH is not set
> CONFIG_INPUT_BMA150=m
> CONFIG_INPUT_E3X0_BUTTON=y
> CONFIG_INPUT_PCSPKR=m
> CONFIG_INPUT_MAX8925_ONKEY=m
> CONFIG_INPUT_MC13783_PWRBUTTON=y
> CONFIG_INPUT_MMA8450=y
> CONFIG_INPUT_APANEL=m
> CONFIG_INPUT_GPIO_BEEPER=m
> CONFIG_INPUT_GPIO_DECODER=y
> # CONFIG_INPUT_GPIO_VIBRA is not set
> CONFIG_INPUT_WISTRON_BTNS=y
> CONFIG_INPUT_ATLAS_BTNS=m
> CONFIG_INPUT_ATI_REMOTE2=y
> # CONFIG_INPUT_KEYSPAN_REMOTE is not set
> CONFIG_INPUT_KXTJ9=m
> CONFIG_INPUT_POWERMATE=m
> CONFIG_INPUT_YEALINK=m
> CONFIG_INPUT_CM109=y
> CONFIG_INPUT_REGULATOR_HAPTIC=y
> CONFIG_INPUT_RETU_PWRBUTTON=m
> CONFIG_INPUT_TPS65218_PWRBUTTON=m
> # CONFIG_INPUT_TWL6040_VIBRA is not set
> # CONFIG_INPUT_UINPUT is not set
> CONFIG_INPUT_PCF50633_PMU=m
> # CONFIG_INPUT_PCF8574 is not set
> CONFIG_INPUT_GPIO_ROTARY_ENCODER=y
> CONFIG_INPUT_DA7280_HAPTICS=m
> # CONFIG_INPUT_DA9052_ONKEY is not set
> CONFIG_INPUT_DA9055_ONKEY=m
> CONFIG_INPUT_WM831X_ON=y
> CONFIG_INPUT_PCAP=y
> CONFIG_INPUT_ADXL34X=m
> CONFIG_INPUT_ADXL34X_I2C=m
> # CONFIG_INPUT_ADXL34X_SPI is not set
> # CONFIG_INPUT_IMS_PCU is not set
> CONFIG_INPUT_IQS269A=y
> # CONFIG_INPUT_IQS626A is not set
> CONFIG_INPUT_CMA3000=m
> CONFIG_INPUT_CMA3000_I2C=m
> # CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
> CONFIG_INPUT_DRV260X_HAPTICS=y
> CONFIG_INPUT_DRV2665_HAPTICS=m
> # CONFIG_INPUT_DRV2667_HAPTICS is not set
> # CONFIG_INPUT_RAVE_SP_PWRBUTTON is not set
> CONFIG_INPUT_STPMIC1_ONKEY=m
> CONFIG_RMI4_CORE=y
> CONFIG_RMI4_I2C=m
> CONFIG_RMI4_SPI=y
> CONFIG_RMI4_SMB=m
> CONFIG_RMI4_F03=y
> CONFIG_RMI4_F03_SERIO=y
> CONFIG_RMI4_2D_SENSOR=y
> CONFIG_RMI4_F11=y
> CONFIG_RMI4_F12=y
> CONFIG_RMI4_F30=y
> CONFIG_RMI4_F34=y
> # CONFIG_RMI4_F3A is not set
> CONFIG_RMI4_F55=y
> 
> #
> # Hardware I/O ports
> #
> CONFIG_SERIO=y
> CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
> CONFIG_SERIO_I8042=y
> CONFIG_SERIO_SERPORT=m
> CONFIG_SERIO_CT82C710=y
> # CONFIG_SERIO_PCIPS2 is not set
> CONFIG_SERIO_LIBPS2=y
> CONFIG_SERIO_RAW=y
> # CONFIG_SERIO_ALTERA_PS2 is not set
> CONFIG_SERIO_PS2MULT=m
> CONFIG_SERIO_ARC_PS2=y
> # CONFIG_SERIO_APBPS2 is not set
> CONFIG_SERIO_GPIO_PS2=y
> # CONFIG_USERIO is not set
> CONFIG_GAMEPORT=y
> CONFIG_GAMEPORT_NS558=m
> # CONFIG_GAMEPORT_L4 is not set
> # CONFIG_GAMEPORT_EMU10K1 is not set
> # CONFIG_GAMEPORT_FM801 is not set
> # end of Hardware I/O ports
> # end of Input device support
> 
> #
> # Character devices
> #
> CONFIG_TTY=y
> CONFIG_VT=y
> CONFIG_CONSOLE_TRANSLATIONS=y
> CONFIG_VT_CONSOLE=y
> CONFIG_HW_CONSOLE=y
> CONFIG_VT_HW_CONSOLE_BINDING=y
> CONFIG_UNIX98_PTYS=y
> CONFIG_LEGACY_PTYS=y
> CONFIG_LEGACY_PTY_COUNT=256
> CONFIG_LDISC_AUTOLOAD=y
> 
> #
> # Serial drivers
> #
> CONFIG_SERIAL_EARLYCON=y
> CONFIG_SERIAL_8250=y
> # CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
> CONFIG_SERIAL_8250_PNP=y
> CONFIG_SERIAL_8250_16550A_VARIANTS=y
> # CONFIG_SERIAL_8250_FINTEK is not set
> CONFIG_SERIAL_8250_CONSOLE=y
> CONFIG_SERIAL_8250_PCI=y
> CONFIG_SERIAL_8250_EXAR=y
> # CONFIG_SERIAL_8250_MEN_MCB is not set
> CONFIG_SERIAL_8250_NR_UARTS=4
> CONFIG_SERIAL_8250_RUNTIME_UARTS=4
> CONFIG_SERIAL_8250_EXTENDED=y
> CONFIG_SERIAL_8250_MANY_PORTS=y
> CONFIG_SERIAL_8250_FOURPORT=m
> CONFIG_SERIAL_8250_ACCENT=m
> CONFIG_SERIAL_8250_ASPEED_VUART=m
> # CONFIG_SERIAL_8250_BOCA is not set
> CONFIG_SERIAL_8250_EXAR_ST16C554=y
> # CONFIG_SERIAL_8250_HUB6 is not set
> CONFIG_SERIAL_8250_SHARE_IRQ=y
> # CONFIG_SERIAL_8250_DETECT_IRQ is not set
> # CONFIG_SERIAL_8250_RSA is not set
> CONFIG_SERIAL_8250_DWLIB=y
> CONFIG_SERIAL_8250_DW=m
> # CONFIG_SERIAL_8250_RT288X is not set
> CONFIG_SERIAL_8250_LPSS=y
> CONFIG_SERIAL_8250_MID=y
> CONFIG_SERIAL_8250_PERICOM=y
> CONFIG_SERIAL_OF_PLATFORM=y
> 
> #
> # Non-8250 serial port support
> #
> # CONFIG_SERIAL_MAX3100 is not set
> CONFIG_SERIAL_MAX310X=m
> CONFIG_SERIAL_UARTLITE=y
> # CONFIG_SERIAL_UARTLITE_CONSOLE is not set
> CONFIG_SERIAL_UARTLITE_NR_UARTS=1
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_CORE_CONSOLE=y
> # CONFIG_SERIAL_JSM is not set
> CONFIG_SERIAL_SIFIVE=m
> CONFIG_SERIAL_LANTIQ=m
> # CONFIG_SERIAL_SCCNXP is not set
> CONFIG_SERIAL_SC16IS7XX_CORE=m
> CONFIG_SERIAL_SC16IS7XX=m
> CONFIG_SERIAL_SC16IS7XX_I2C=y
> CONFIG_SERIAL_SC16IS7XX_SPI=y
> # CONFIG_SERIAL_TIMBERDALE is not set
> # CONFIG_SERIAL_BCM63XX is not set
> # CONFIG_SERIAL_ALTERA_JTAGUART is not set
> # CONFIG_SERIAL_ALTERA_UART is not set
> # CONFIG_SERIAL_PCH_UART is not set
> CONFIG_SERIAL_XILINX_PS_UART=m
> CONFIG_SERIAL_ARC=y
> CONFIG_SERIAL_ARC_CONSOLE=y
> CONFIG_SERIAL_ARC_NR_PORTS=1
> # CONFIG_SERIAL_RP2 is not set
> # CONFIG_SERIAL_FSL_LPUART is not set
> # CONFIG_SERIAL_FSL_LINFLEXUART is not set
> CONFIG_SERIAL_CONEXANT_DIGICOLOR=m
> CONFIG_SERIAL_MEN_Z135=m
> CONFIG_SERIAL_SPRD=m
> # end of Serial drivers
> 
> CONFIG_SERIAL_MCTRL_GPIO=y
> CONFIG_SERIAL_NONSTANDARD=y
> # CONFIG_MOXA_INTELLIO is not set
> # CONFIG_MOXA_SMARTIO is not set
> # CONFIG_SYNCLINK_GT is not set
> CONFIG_N_HDLC=y
> # CONFIG_N_GSM is not set
> # CONFIG_NOZOMI is not set
> CONFIG_NULL_TTY=y
> CONFIG_RPMSG_TTY=m
> CONFIG_SERIAL_DEV_BUS=y
> CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
> # CONFIG_VIRTIO_CONSOLE is not set
> # CONFIG_IPMI_HANDLER is not set
> CONFIG_IPMB_DEVICE_INTERFACE=y
> CONFIG_HW_RANDOM=y
> CONFIG_HW_RANDOM_TIMERIOMEM=m
> CONFIG_HW_RANDOM_INTEL=y
> # CONFIG_HW_RANDOM_AMD is not set
> # CONFIG_HW_RANDOM_BA431 is not set
> CONFIG_HW_RANDOM_GEODE=y
> CONFIG_HW_RANDOM_VIA=y
> CONFIG_HW_RANDOM_VIRTIO=y
> CONFIG_HW_RANDOM_CCTRNG=y
> CONFIG_HW_RANDOM_XIPHERA=m
> # CONFIG_DTLK is not set
> # CONFIG_APPLICOM is not set
> # CONFIG_SONYPI is not set
> CONFIG_MWAVE=y
> CONFIG_SCx200_GPIO=y
> CONFIG_PC8736x_GPIO=m
> CONFIG_NSC_GPIO=y
> # CONFIG_DEVMEM is not set
> CONFIG_NVRAM=y
> # CONFIG_DEVPORT is not set
> CONFIG_HPET=y
> CONFIG_HPET_MMAP=y
> # CONFIG_HPET_MMAP_DEFAULT is not set
> CONFIG_HANGCHECK_TIMER=m
> CONFIG_TCG_TPM=y
> # CONFIG_HW_RANDOM_TPM is not set
> CONFIG_TCG_TIS_CORE=y
> CONFIG_TCG_TIS=y
> CONFIG_TCG_TIS_SPI=m
> CONFIG_TCG_TIS_SPI_CR50=y
> CONFIG_TCG_TIS_I2C_CR50=y
> # CONFIG_TCG_TIS_I2C_ATMEL is not set
> CONFIG_TCG_TIS_I2C_INFINEON=m
> # CONFIG_TCG_TIS_I2C_NUVOTON is not set
> CONFIG_TCG_NSC=m
> CONFIG_TCG_ATMEL=m
> CONFIG_TCG_INFINEON=m
> CONFIG_TCG_CRB=y
> CONFIG_TCG_VTPM_PROXY=m
> CONFIG_TCG_TIS_ST33ZP24=y
> # CONFIG_TCG_TIS_ST33ZP24_I2C is not set
> CONFIG_TCG_TIS_ST33ZP24_SPI=y
> CONFIG_TELCLOCK=m
> CONFIG_XILLYBUS_CLASS=m
> CONFIG_XILLYBUS=m
> CONFIG_XILLYBUS_OF=m
> CONFIG_XILLYUSB=m
> CONFIG_RANDOM_TRUST_CPU=y
> # CONFIG_RANDOM_TRUST_BOOTLOADER is not set
> # end of Character devices
> 
> #
> # I2C support
> #
> CONFIG_I2C=y
> CONFIG_ACPI_I2C_OPREGION=y
> CONFIG_I2C_BOARDINFO=y
> # CONFIG_I2C_COMPAT is not set
> CONFIG_I2C_CHARDEV=y
> CONFIG_I2C_MUX=m
> 
> #
> # Multiplexer I2C Chip support
> #
> # CONFIG_I2C_ARB_GPIO_CHALLENGE is not set
> CONFIG_I2C_MUX_GPIO=m
> # CONFIG_I2C_MUX_GPMUX is not set
> # CONFIG_I2C_MUX_LTC4306 is not set
> CONFIG_I2C_MUX_PCA9541=m
> CONFIG_I2C_MUX_PCA954x=m
> CONFIG_I2C_MUX_PINCTRL=m
> # CONFIG_I2C_MUX_REG is not set
> # CONFIG_I2C_DEMUX_PINCTRL is not set
> CONFIG_I2C_MUX_MLXCPLD=m
> # end of Multiplexer I2C Chip support
> 
> # CONFIG_I2C_HELPER_AUTO is not set
> CONFIG_I2C_SMBUS=y
> 
> #
> # I2C Algorithms
> #
> CONFIG_I2C_ALGOBIT=y
> CONFIG_I2C_ALGOPCF=y
> CONFIG_I2C_ALGOPCA=y
> # end of I2C Algorithms
> 
> #
> # I2C Hardware Bus support
> #
> 
> #
> # PC SMBus host controller drivers
> #
> # CONFIG_I2C_ALI1535 is not set
> # CONFIG_I2C_ALI1563 is not set
> # CONFIG_I2C_ALI15X3 is not set
> # CONFIG_I2C_AMD756 is not set
> # CONFIG_I2C_AMD8111 is not set
> # CONFIG_I2C_AMD_MP2 is not set
> # CONFIG_I2C_I801 is not set
> # CONFIG_I2C_ISCH is not set
> # CONFIG_I2C_ISMT is not set
> # CONFIG_I2C_PIIX4 is not set
> # CONFIG_I2C_NFORCE2 is not set
> # CONFIG_I2C_NVIDIA_GPU is not set
> # CONFIG_I2C_SIS5595 is not set
> # CONFIG_I2C_SIS630 is not set
> # CONFIG_I2C_SIS96X is not set
> # CONFIG_I2C_VIA is not set
> # CONFIG_I2C_VIAPRO is not set
> 
> #
> # ACPI drivers
> #
> CONFIG_I2C_SCMI=y
> 
> #
> # I2C system bus drivers (mostly embedded / system-on-chip)
> #
> # CONFIG_I2C_CBUS_GPIO is not set
> # CONFIG_I2C_DESIGNWARE_PLATFORM is not set
> # CONFIG_I2C_DESIGNWARE_PCI is not set
> # CONFIG_I2C_EG20T is not set
> # CONFIG_I2C_EMEV2 is not set
> # CONFIG_I2C_GPIO is not set
> CONFIG_I2C_OCORES=m
> CONFIG_I2C_PCA_PLATFORM=m
> CONFIG_I2C_PXA=m
> CONFIG_I2C_PXA_PCI=y
> CONFIG_I2C_RK3X=m
> CONFIG_I2C_SIMTEC=m
> # CONFIG_I2C_XILINX is not set
> 
> #
> # External I2C/SMBus adapter drivers
> #
> CONFIG_I2C_DIOLAN_U2C=y
> CONFIG_I2C_DLN2=y
> CONFIG_I2C_CP2615=y
> # CONFIG_I2C_ROBOTFUZZ_OSIF is not set
> CONFIG_I2C_TAOS_EVM=m
> CONFIG_I2C_TINY_USB=m
> CONFIG_I2C_VIPERBOARD=m
> 
> #
> # Other I2C/SMBus bus drivers
> #
> CONFIG_I2C_ELEKTOR=y
> # CONFIG_I2C_PCA_ISA is not set
> # CONFIG_I2C_CROS_EC_TUNNEL is not set
> # CONFIG_SCx200_ACB is not set
> CONFIG_I2C_FSI=m
> CONFIG_I2C_VIRTIO=y
> # end of I2C Hardware Bus support
> 
> CONFIG_I2C_STUB=m
> CONFIG_I2C_SLAVE=y
> CONFIG_I2C_SLAVE_EEPROM=y
> CONFIG_I2C_SLAVE_TESTUNIT=m
> # CONFIG_I2C_DEBUG_CORE is not set
> # CONFIG_I2C_DEBUG_ALGO is not set
> # CONFIG_I2C_DEBUG_BUS is not set
> # end of I2C support
> 
> CONFIG_I3C=y
> # CONFIG_CDNS_I3C_MASTER is not set
> # CONFIG_DW_I3C_MASTER is not set
> CONFIG_SVC_I3C_MASTER=y
> CONFIG_MIPI_I3C_HCI=m
> CONFIG_SPI=y
> # CONFIG_SPI_DEBUG is not set
> CONFIG_SPI_MASTER=y
> CONFIG_SPI_MEM=y
> 
> #
> # SPI Master Controller Drivers
> #
> CONFIG_SPI_ALTERA=m
> CONFIG_SPI_ALTERA_CORE=m
> CONFIG_SPI_ALTERA_DFL=m
> # CONFIG_SPI_AXI_SPI_ENGINE is not set
> CONFIG_SPI_BITBANG=y
> CONFIG_SPI_CADENCE=m
> CONFIG_SPI_CADENCE_QUADSPI=y
> CONFIG_SPI_CADENCE_XSPI=m
> # CONFIG_SPI_DESIGNWARE is not set
> CONFIG_SPI_DLN2=y
> CONFIG_SPI_FSI=m
> # CONFIG_SPI_NXP_FLEXSPI is not set
> # CONFIG_SPI_GPIO is not set
> CONFIG_SPI_FSL_LIB=m
> CONFIG_SPI_FSL_SPI=m
> CONFIG_SPI_LANTIQ_SSC=y
> CONFIG_SPI_OC_TINY=y
> CONFIG_SPI_PXA2XX=y
> CONFIG_SPI_PXA2XX_PCI=y
> # CONFIG_SPI_ROCKCHIP is not set
> CONFIG_SPI_SC18IS602=y
> CONFIG_SPI_SIFIVE=m
> CONFIG_SPI_MXIC=m
> # CONFIG_SPI_TOPCLIFF_PCH is not set
> CONFIG_SPI_XCOMM=y
> # CONFIG_SPI_XILINX is not set
> CONFIG_SPI_ZYNQMP_GQSPI=y
> CONFIG_SPI_AMD=m
> 
> #
> # SPI Multiplexer support
> #
> CONFIG_SPI_MUX=y
> 
> #
> # SPI Protocol Masters
> #
> # CONFIG_SPI_SPIDEV is not set
> # CONFIG_SPI_LOOPBACK_TEST is not set
> CONFIG_SPI_TLE62X0=y
> # CONFIG_SPI_SLAVE is not set
> CONFIG_SPI_DYNAMIC=y
> CONFIG_SPMI=y
> CONFIG_SPMI_HISI3670=y
> # CONFIG_HSI is not set
> # CONFIG_PPS is not set
> 
> #
> # PTP clock support
> #
> # CONFIG_PTP_1588_CLOCK is not set
> CONFIG_PTP_1588_CLOCK_OPTIONAL=y
> 
> #
> # Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
> #
> # end of PTP clock support
> 
> CONFIG_PINCTRL=y
> CONFIG_GENERIC_PINCTRL_GROUPS=y
> CONFIG_PINMUX=y
> CONFIG_GENERIC_PINMUX_FUNCTIONS=y
> CONFIG_PINCONF=y
> CONFIG_GENERIC_PINCONF=y
> # CONFIG_DEBUG_PINCTRL is not set
> # CONFIG_PINCTRL_AMD is not set
> CONFIG_PINCTRL_AS3722=y
> CONFIG_PINCTRL_EQUILIBRIUM=y
> CONFIG_PINCTRL_MAX77620=m
> CONFIG_PINCTRL_MCP23S08_I2C=y
> CONFIG_PINCTRL_MCP23S08_SPI=y
> CONFIG_PINCTRL_MCP23S08=y
> CONFIG_PINCTRL_MICROCHIP_SGPIO=y
> # CONFIG_PINCTRL_OCELOT is not set
> CONFIG_PINCTRL_SINGLE=y
> CONFIG_PINCTRL_STMFX=y
> # CONFIG_PINCTRL_SX150X is not set
> # CONFIG_PINCTRL_LOCHNAGAR is not set
> CONFIG_PINCTRL_MADERA=m
> CONFIG_PINCTRL_CS47L85=y
> CONFIG_PINCTRL_CS47L90=y
> CONFIG_PINCTRL_CS47L92=y
> 
> #
> # Intel pinctrl drivers
> #
> # CONFIG_PINCTRL_BAYTRAIL is not set
> CONFIG_PINCTRL_CHERRYVIEW=m
> CONFIG_PINCTRL_LYNXPOINT=m
> CONFIG_PINCTRL_INTEL=y
> CONFIG_PINCTRL_ALDERLAKE=y
> CONFIG_PINCTRL_BROXTON=m
> # CONFIG_PINCTRL_CANNONLAKE is not set
> CONFIG_PINCTRL_CEDARFORK=m
> # CONFIG_PINCTRL_DENVERTON is not set
> # CONFIG_PINCTRL_ELKHARTLAKE is not set
> CONFIG_PINCTRL_EMMITSBURG=m
> # CONFIG_PINCTRL_GEMINILAKE is not set
> CONFIG_PINCTRL_ICELAKE=m
> CONFIG_PINCTRL_JASPERLAKE=m
> CONFIG_PINCTRL_LAKEFIELD=m
> CONFIG_PINCTRL_LEWISBURG=y
> # CONFIG_PINCTRL_SUNRISEPOINT is not set
> CONFIG_PINCTRL_TIGERLAKE=m
> # end of Intel pinctrl drivers
> 
> #
> # Renesas pinctrl drivers
> #
> # end of Renesas pinctrl drivers
> 
> CONFIG_GPIOLIB=y
> CONFIG_GPIOLIB_FASTPATH_LIMIT=512
> CONFIG_OF_GPIO=y
> CONFIG_GPIO_ACPI=y
> CONFIG_GPIOLIB_IRQCHIP=y
> # CONFIG_DEBUG_GPIO is not set
> CONFIG_GPIO_CDEV=y
> # CONFIG_GPIO_CDEV_V1 is not set
> CONFIG_GPIO_GENERIC=y
> CONFIG_GPIO_MAX730X=m
> 
> #
> # Memory mapped GPIO drivers
> #
> CONFIG_GPIO_74XX_MMIO=y
> # CONFIG_GPIO_ALTERA is not set
> # CONFIG_GPIO_AMDPT is not set
> CONFIG_GPIO_CADENCE=y
> CONFIG_GPIO_DWAPB=y
> # CONFIG_GPIO_EXAR is not set
> CONFIG_GPIO_FTGPIO010=y
> CONFIG_GPIO_GENERIC_PLATFORM=y
> CONFIG_GPIO_GRGPIO=y
> CONFIG_GPIO_HLWD=m
> # CONFIG_GPIO_LOGICVC is not set
> # CONFIG_GPIO_MB86S7X is not set
> CONFIG_GPIO_MENZ127=m
> # CONFIG_GPIO_SAMA5D2_PIOBU is not set
> CONFIG_GPIO_SIFIVE=y
> CONFIG_GPIO_SIOX=y
> CONFIG_GPIO_SYSCON=m
> # CONFIG_GPIO_VX855 is not set
> CONFIG_GPIO_XILINX=y
> # CONFIG_GPIO_AMD_FCH is not set
> # end of Memory mapped GPIO drivers
> 
> #
> # Port-mapped I/O GPIO drivers
> #
> CONFIG_GPIO_F7188X=y
> # CONFIG_GPIO_IT87 is not set
> CONFIG_GPIO_SCH311X=y
> CONFIG_GPIO_WINBOND=m
> CONFIG_GPIO_WS16C48=m
> # end of Port-mapped I/O GPIO drivers
> 
> #
> # I2C GPIO expanders
> #
> CONFIG_GPIO_ADP5588=m
> CONFIG_GPIO_ADNP=m
> # CONFIG_GPIO_GW_PLD is not set
> CONFIG_GPIO_MAX7300=m
> CONFIG_GPIO_MAX732X=y
> CONFIG_GPIO_MAX732X_IRQ=y
> CONFIG_GPIO_PCA953X=y
> CONFIG_GPIO_PCA953X_IRQ=y
> # CONFIG_GPIO_PCA9570 is not set
> # CONFIG_GPIO_PCF857X is not set
> CONFIG_GPIO_TPIC2810=y
> # end of I2C GPIO expanders
> 
> #
> # MFD GPIO expanders
> #
> CONFIG_GPIO_ARIZONA=y
> CONFIG_GPIO_DA9052=m
> CONFIG_GPIO_DA9055=y
> CONFIG_GPIO_DLN2=m
> # CONFIG_GPIO_LP3943 is not set
> # CONFIG_GPIO_MADERA is not set
> # CONFIG_GPIO_MAX77620 is not set
> CONFIG_GPIO_RC5T583=y
> # CONFIG_GPIO_STMPE is not set
> CONFIG_GPIO_TPS65218=y
> CONFIG_GPIO_TPS65910=y
> CONFIG_GPIO_TPS65912=y
> CONFIG_GPIO_TWL6040=y
> CONFIG_GPIO_UCB1400=m
> CONFIG_GPIO_WM831X=m
> # end of MFD GPIO expanders
> 
> #
> # PCI GPIO expanders
> #
> # CONFIG_GPIO_AMD8111 is not set
> # CONFIG_GPIO_BT8XX is not set
> # CONFIG_GPIO_ML_IOH is not set
> # CONFIG_GPIO_PCH is not set
> # CONFIG_GPIO_PCI_IDIO_16 is not set
> # CONFIG_GPIO_PCIE_IDIO_24 is not set
> # CONFIG_GPIO_RDC321X is not set
> # CONFIG_GPIO_SODAVILLE is not set
> # end of PCI GPIO expanders
> 
> #
> # SPI GPIO expanders
> #
> CONFIG_GPIO_74X164=y
> # CONFIG_GPIO_MAX3191X is not set
> # CONFIG_GPIO_MAX7301 is not set
> CONFIG_GPIO_MC33880=y
> CONFIG_GPIO_PISOSR=m
> CONFIG_GPIO_XRA1403=m
> CONFIG_GPIO_MOXTET=y
> # end of SPI GPIO expanders
> 
> #
> # USB GPIO expanders
> #
> CONFIG_GPIO_VIPERBOARD=m
> # end of USB GPIO expanders
> 
> #
> # Virtual GPIO drivers
> #
> # CONFIG_GPIO_AGGREGATOR is not set
> # CONFIG_GPIO_MOCKUP is not set
> CONFIG_GPIO_VIRTIO=y
> CONFIG_GPIO_SIM=m
> # end of Virtual GPIO drivers
> 
> CONFIG_W1=y
> 
> #
> # 1-wire Bus Masters
> #
> # CONFIG_W1_MASTER_MATROX is not set
> # CONFIG_W1_MASTER_DS2490 is not set
> CONFIG_W1_MASTER_DS2482=m
> # CONFIG_W1_MASTER_DS1WM is not set
> CONFIG_W1_MASTER_GPIO=m
> CONFIG_W1_MASTER_SGI=y
> # end of 1-wire Bus Masters
> 
> #
> # 1-wire Slaves
> #
> CONFIG_W1_SLAVE_THERM=y
> CONFIG_W1_SLAVE_SMEM=m
> CONFIG_W1_SLAVE_DS2405=m
> CONFIG_W1_SLAVE_DS2408=m
> CONFIG_W1_SLAVE_DS2408_READBACK=y
> CONFIG_W1_SLAVE_DS2413=y
> CONFIG_W1_SLAVE_DS2406=y
> CONFIG_W1_SLAVE_DS2423=y
> # CONFIG_W1_SLAVE_DS2805 is not set
> # CONFIG_W1_SLAVE_DS2430 is not set
> CONFIG_W1_SLAVE_DS2431=m
> CONFIG_W1_SLAVE_DS2433=m
> # CONFIG_W1_SLAVE_DS2433_CRC is not set
> # CONFIG_W1_SLAVE_DS2438 is not set
> CONFIG_W1_SLAVE_DS250X=y
> # CONFIG_W1_SLAVE_DS2780 is not set
> CONFIG_W1_SLAVE_DS2781=y
> CONFIG_W1_SLAVE_DS28E04=y
> # CONFIG_W1_SLAVE_DS28E17 is not set
> # end of 1-wire Slaves
> 
> # CONFIG_POWER_RESET is not set
> CONFIG_POWER_SUPPLY=y
> # CONFIG_POWER_SUPPLY_DEBUG is not set
> CONFIG_PDA_POWER=y
> # CONFIG_GENERIC_ADC_BATTERY is not set
> CONFIG_MAX8925_POWER=y
> CONFIG_WM831X_BACKUP=y
> CONFIG_WM831X_POWER=y
> # CONFIG_TEST_POWER is not set
> # CONFIG_CHARGER_ADP5061 is not set
> CONFIG_BATTERY_CW2015=y
> CONFIG_BATTERY_DS2760=m
> # CONFIG_BATTERY_DS2780 is not set
> # CONFIG_BATTERY_DS2781 is not set
> # CONFIG_BATTERY_DS2782 is not set
> # CONFIG_BATTERY_OLPC is not set
> # CONFIG_BATTERY_SBS is not set
> CONFIG_CHARGER_SBS=m
> # CONFIG_MANAGER_SBS is not set
> # CONFIG_BATTERY_BQ27XXX is not set
> CONFIG_BATTERY_DA9052=y
> # CONFIG_BATTERY_MAX17040 is not set
> CONFIG_BATTERY_MAX17042=m
> CONFIG_BATTERY_MAX1721X=m
> # CONFIG_CHARGER_PCF50633 is not set
> CONFIG_CHARGER_ISP1704=y
> # CONFIG_CHARGER_MAX8903 is not set
> CONFIG_CHARGER_LP8727=y
> CONFIG_CHARGER_GPIO=y
> # CONFIG_CHARGER_MANAGER is not set
> # CONFIG_CHARGER_LT3651 is not set
> CONFIG_CHARGER_LTC4162L=m
> CONFIG_CHARGER_MAX14577=m
> CONFIG_CHARGER_DETECTOR_MAX14656=y
> CONFIG_CHARGER_MAX77976=m
> CONFIG_CHARGER_BQ2415X=y
> CONFIG_CHARGER_BQ24190=y
> # CONFIG_CHARGER_BQ24257 is not set
> CONFIG_CHARGER_BQ24735=y
> CONFIG_CHARGER_BQ2515X=m
> # CONFIG_CHARGER_BQ25890 is not set
> CONFIG_CHARGER_BQ25980=m
> CONFIG_CHARGER_BQ256XX=m
> CONFIG_CHARGER_SMB347=m
> # CONFIG_CHARGER_TPS65090 is not set
> CONFIG_CHARGER_TPS65217=m
> CONFIG_BATTERY_GAUGE_LTC2941=y
> CONFIG_BATTERY_GOLDFISH=y
> CONFIG_BATTERY_RT5033=m
> CONFIG_CHARGER_RT9455=y
> # CONFIG_CHARGER_CROS_PCHG is not set
> CONFIG_CHARGER_UCS1002=m
> CONFIG_CHARGER_BD99954=y
> CONFIG_CHARGER_WILCO=m
> CONFIG_RN5T618_POWER=m
> # CONFIG_HWMON is not set
> CONFIG_THERMAL=y
> # CONFIG_THERMAL_NETLINK is not set
> # CONFIG_THERMAL_STATISTICS is not set
> CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
> CONFIG_THERMAL_OF=y
> # CONFIG_THERMAL_WRITABLE_TRIPS is not set
> CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
> # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
> # CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
> CONFIG_THERMAL_GOV_FAIR_SHARE=y
> CONFIG_THERMAL_GOV_STEP_WISE=y
> CONFIG_THERMAL_GOV_BANG_BANG=y
> # CONFIG_THERMAL_GOV_USER_SPACE is not set
> CONFIG_CPU_THERMAL=y
> # CONFIG_CPU_FREQ_THERMAL is not set
> CONFIG_DEVFREQ_THERMAL=y
> # CONFIG_THERMAL_EMULATION is not set
> CONFIG_THERMAL_MMIO=m
> CONFIG_MAX77620_THERMAL=m
> 
> #
> # Intel thermal drivers
> #
> # CONFIG_INTEL_POWERCLAMP is not set
> # CONFIG_INTEL_SOC_DTS_THERMAL is not set
> 
> #
> # ACPI INT340X thermal drivers
> #
> # end of ACPI INT340X thermal drivers
> 
> # CONFIG_INTEL_PCH_THERMAL is not set
> CONFIG_INTEL_TCC_COOLING=m
> # end of Intel thermal drivers
> 
> CONFIG_GENERIC_ADC_THERMAL=y
> # CONFIG_WATCHDOG is not set
> CONFIG_SSB_POSSIBLE=y
> CONFIG_SSB=y
> CONFIG_SSB_SPROM=y
> CONFIG_SSB_PCIHOST_POSSIBLE=y
> CONFIG_SSB_PCIHOST=y
> CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
> # CONFIG_SSB_DRIVER_PCICORE is not set
> # CONFIG_SSB_DRIVER_GPIO is not set
> CONFIG_BCMA_POSSIBLE=y
> CONFIG_BCMA=y
> CONFIG_BCMA_HOST_PCI_POSSIBLE=y
> CONFIG_BCMA_HOST_PCI=y
> CONFIG_BCMA_HOST_SOC=y
> CONFIG_BCMA_DRIVER_PCI=y
> CONFIG_BCMA_SFLASH=y
> CONFIG_BCMA_DRIVER_GMAC_CMN=y
> CONFIG_BCMA_DRIVER_GPIO=y
> # CONFIG_BCMA_DEBUG is not set
> 
> #
> # Multifunction device drivers
> #
> CONFIG_MFD_CORE=y
> # CONFIG_MFD_CS5535 is not set
> # CONFIG_MFD_ACT8945A is not set
> CONFIG_MFD_AS3711=y
> CONFIG_MFD_AS3722=y
> # CONFIG_PMIC_ADP5520 is not set
> CONFIG_MFD_AAT2870_CORE=y
> CONFIG_MFD_ATMEL_FLEXCOM=y
> # CONFIG_MFD_ATMEL_HLCDC is not set
> # CONFIG_MFD_BCM590XX is not set
> # CONFIG_MFD_BD9571MWV is not set
> # CONFIG_MFD_AXP20X_I2C is not set
> CONFIG_MFD_CROS_EC_DEV=m
> CONFIG_MFD_MADERA=m
> CONFIG_MFD_MADERA_I2C=m
> # CONFIG_MFD_MADERA_SPI is not set
> # CONFIG_MFD_CS47L15 is not set
> # CONFIG_MFD_CS47L35 is not set
> CONFIG_MFD_CS47L85=y
> CONFIG_MFD_CS47L90=y
> CONFIG_MFD_CS47L92=y
> # CONFIG_PMIC_DA903X is not set
> CONFIG_PMIC_DA9052=y
> CONFIG_MFD_DA9052_SPI=y
> # CONFIG_MFD_DA9052_I2C is not set
> CONFIG_MFD_DA9055=y
> # CONFIG_MFD_DA9062 is not set
> # CONFIG_MFD_DA9063 is not set
> # CONFIG_MFD_DA9150 is not set
> CONFIG_MFD_DLN2=y
> CONFIG_MFD_GATEWORKS_GSC=y
> CONFIG_MFD_MC13XXX=y
> CONFIG_MFD_MC13XXX_SPI=y
> CONFIG_MFD_MC13XXX_I2C=m
> CONFIG_MFD_MP2629=y
> CONFIG_MFD_HI6421_PMIC=y
> CONFIG_MFD_HI6421_SPMI=y
> CONFIG_HTC_PASIC3=m
> CONFIG_HTC_I2CPLD=y
> # CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
> # CONFIG_LPC_ICH is not set
> # CONFIG_LPC_SCH is not set
> # CONFIG_MFD_INTEL_LPSS_ACPI is not set
> # CONFIG_MFD_INTEL_LPSS_PCI is not set
> CONFIG_MFD_IQS62X=m
> # CONFIG_MFD_JANZ_CMODIO is not set
> # CONFIG_MFD_KEMPLD is not set
> CONFIG_MFD_88PM800=m
> CONFIG_MFD_88PM805=m
> # CONFIG_MFD_88PM860X is not set
> CONFIG_MFD_MAX14577=m
> CONFIG_MFD_MAX77620=y
> # CONFIG_MFD_MAX77650 is not set
> CONFIG_MFD_MAX77686=m
> # CONFIG_MFD_MAX77693 is not set
> CONFIG_MFD_MAX77843=y
> CONFIG_MFD_MAX8907=m
> CONFIG_MFD_MAX8925=y
> # CONFIG_MFD_MAX8997 is not set
> CONFIG_MFD_MAX8998=y
> # CONFIG_MFD_MT6360 is not set
> CONFIG_MFD_MT6397=m
> CONFIG_MFD_MENF21BMC=m
> CONFIG_EZX_PCAP=y
> # CONFIG_MFD_CPCAP is not set
> CONFIG_MFD_VIPERBOARD=m
> CONFIG_MFD_NTXEC=y
> CONFIG_MFD_RETU=y
> CONFIG_MFD_PCF50633=y
> CONFIG_PCF50633_ADC=y
> CONFIG_PCF50633_GPIO=y
> CONFIG_UCB1400_CORE=m
> # CONFIG_MFD_RDC321X is not set
> CONFIG_MFD_RT4831=y
> CONFIG_MFD_RT5033=y
> CONFIG_MFD_RC5T583=y
> # CONFIG_MFD_RK808 is not set
> CONFIG_MFD_RN5T618=m
> # CONFIG_MFD_SEC_CORE is not set
> CONFIG_MFD_SI476X_CORE=y
> CONFIG_MFD_SM501=m
> # CONFIG_MFD_SM501_GPIO is not set
> CONFIG_MFD_SKY81452=m
> CONFIG_MFD_STMPE=y
> 
> #
> # STMicroelectronics STMPE Interface Drivers
> #
> # CONFIG_STMPE_I2C is not set
> # CONFIG_STMPE_SPI is not set
> # end of STMicroelectronics STMPE Interface Drivers
> 
> CONFIG_MFD_SYSCON=y
> # CONFIG_MFD_TI_AM335X_TSCADC is not set
> CONFIG_MFD_LP3943=y
> # CONFIG_MFD_LP8788 is not set
> CONFIG_MFD_TI_LMU=m
> # CONFIG_MFD_PALMAS is not set
> # CONFIG_TPS6105X is not set
> # CONFIG_TPS65010 is not set
> CONFIG_TPS6507X=m
> # CONFIG_MFD_TPS65086 is not set
> CONFIG_MFD_TPS65090=y
> CONFIG_MFD_TPS65217=y
> # CONFIG_MFD_TI_LP873X is not set
> # CONFIG_MFD_TI_LP87565 is not set
> CONFIG_MFD_TPS65218=y
> # CONFIG_MFD_TPS6586X is not set
> CONFIG_MFD_TPS65910=y
> CONFIG_MFD_TPS65912=y
> # CONFIG_MFD_TPS65912_I2C is not set
> CONFIG_MFD_TPS65912_SPI=y
> # CONFIG_TWL4030_CORE is not set
> CONFIG_TWL6040_CORE=y
> # CONFIG_MFD_WL1273_CORE is not set
> CONFIG_MFD_LM3533=m
> # CONFIG_MFD_TIMBERDALE is not set
> # CONFIG_MFD_TC3589X is not set
> # CONFIG_MFD_TQMX86 is not set
> # CONFIG_MFD_VX855 is not set
> CONFIG_MFD_LOCHNAGAR=y
> CONFIG_MFD_ARIZONA=y
> # CONFIG_MFD_ARIZONA_I2C is not set
> CONFIG_MFD_ARIZONA_SPI=y
> # CONFIG_MFD_CS47L24 is not set
> CONFIG_MFD_WM5102=y
> CONFIG_MFD_WM5110=y
> # CONFIG_MFD_WM8997 is not set
> CONFIG_MFD_WM8998=y
> # CONFIG_MFD_WM8400 is not set
> CONFIG_MFD_WM831X=y
> CONFIG_MFD_WM831X_I2C=y
> CONFIG_MFD_WM831X_SPI=y
> # CONFIG_MFD_WM8350_I2C is not set
> # CONFIG_MFD_WM8994 is not set
> # CONFIG_MFD_ROHM_BD718XX is not set
> # CONFIG_MFD_ROHM_BD71828 is not set
> CONFIG_MFD_ROHM_BD957XMUF=y
> CONFIG_MFD_STPMIC1=m
> CONFIG_MFD_STMFX=y
> # CONFIG_MFD_WCD934X is not set
> CONFIG_MFD_ATC260X=y
> CONFIG_MFD_ATC260X_I2C=y
> CONFIG_MFD_QCOM_PM8008=m
> CONFIG_RAVE_SP_CORE=y
> # CONFIG_MFD_INTEL_M10_BMC is not set
> # CONFIG_MFD_RSMU_I2C is not set
> CONFIG_MFD_RSMU_SPI=m
> # end of Multifunction device drivers
> 
> CONFIG_REGULATOR=y
> CONFIG_REGULATOR_DEBUG=y
> # CONFIG_REGULATOR_FIXED_VOLTAGE is not set
> # CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
> CONFIG_REGULATOR_USERSPACE_CONSUMER=m
> CONFIG_REGULATOR_88PG86X=m
> CONFIG_REGULATOR_88PM800=m
> # CONFIG_REGULATOR_ACT8865 is not set
> CONFIG_REGULATOR_AD5398=m
> CONFIG_REGULATOR_AAT2870=y
> # CONFIG_REGULATOR_ARIZONA_LDO1 is not set
> CONFIG_REGULATOR_ARIZONA_MICSUPP=m
> CONFIG_REGULATOR_AS3711=m
> CONFIG_REGULATOR_AS3722=y
> CONFIG_REGULATOR_ATC260X=y
> CONFIG_REGULATOR_BD957XMUF=y
> # CONFIG_REGULATOR_CROS_EC is not set
> CONFIG_REGULATOR_DA9052=m
> # CONFIG_REGULATOR_DA9055 is not set
> # CONFIG_REGULATOR_DA9121 is not set
> CONFIG_REGULATOR_DA9210=m
> # CONFIG_REGULATOR_DA9211 is not set
> CONFIG_REGULATOR_FAN53555=y
> CONFIG_REGULATOR_FAN53880=y
> CONFIG_REGULATOR_GPIO=y
> CONFIG_REGULATOR_HI6421=y
> CONFIG_REGULATOR_HI6421V530=y
> CONFIG_REGULATOR_HI6421V600=m
> # CONFIG_REGULATOR_ISL9305 is not set
> CONFIG_REGULATOR_ISL6271A=y
> CONFIG_REGULATOR_LM363X=m
> CONFIG_REGULATOR_LOCHNAGAR=m
> # CONFIG_REGULATOR_LP3971 is not set
> # CONFIG_REGULATOR_LP3972 is not set
> CONFIG_REGULATOR_LP872X=m
> # CONFIG_REGULATOR_LP8755 is not set
> CONFIG_REGULATOR_LTC3589=y
> # CONFIG_REGULATOR_LTC3676 is not set
> # CONFIG_REGULATOR_MAX14577 is not set
> CONFIG_REGULATOR_MAX1586=m
> CONFIG_REGULATOR_MAX77620=y
> # CONFIG_REGULATOR_MAX8649 is not set
> CONFIG_REGULATOR_MAX8660=m
> # CONFIG_REGULATOR_MAX8893 is not set
> CONFIG_REGULATOR_MAX8907=m
> CONFIG_REGULATOR_MAX8925=y
> # CONFIG_REGULATOR_MAX8952 is not set
> CONFIG_REGULATOR_MAX8973=m
> # CONFIG_REGULATOR_MAX8998 is not set
> CONFIG_REGULATOR_MAX20086=m
> CONFIG_REGULATOR_MAX77686=m
> # CONFIG_REGULATOR_MAX77693 is not set
> # CONFIG_REGULATOR_MAX77802 is not set
> CONFIG_REGULATOR_MAX77826=m
> # CONFIG_REGULATOR_MC13783 is not set
> # CONFIG_REGULATOR_MC13892 is not set
> # CONFIG_REGULATOR_MCP16502 is not set
> CONFIG_REGULATOR_MP5416=y
> # CONFIG_REGULATOR_MP8859 is not set
> # CONFIG_REGULATOR_MP886X is not set
> CONFIG_REGULATOR_MPQ7920=y
> # CONFIG_REGULATOR_MT6311 is not set
> CONFIG_REGULATOR_MT6315=y
> CONFIG_REGULATOR_MT6323=m
> # CONFIG_REGULATOR_MT6358 is not set
> CONFIG_REGULATOR_MT6359=m
> CONFIG_REGULATOR_MT6397=m
> # CONFIG_REGULATOR_PCA9450 is not set
> # CONFIG_REGULATOR_PCAP is not set
> # CONFIG_REGULATOR_PCF50633 is not set
> CONFIG_REGULATOR_PF8X00=y
> # CONFIG_REGULATOR_PFUZE100 is not set
> # CONFIG_REGULATOR_PV88060 is not set
> CONFIG_REGULATOR_PV88080=y
> CONFIG_REGULATOR_PV88090=y
> CONFIG_REGULATOR_QCOM_SPMI=m
> # CONFIG_REGULATOR_QCOM_USB_VBUS is not set
> CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY=m
> CONFIG_REGULATOR_RC5T583=m
> CONFIG_REGULATOR_RN5T618=m
> CONFIG_REGULATOR_RT4801=y
> # CONFIG_REGULATOR_RT4831 is not set
> CONFIG_REGULATOR_RT5033=m
> # CONFIG_REGULATOR_RT6160 is not set
> CONFIG_REGULATOR_RT6245=m
> # CONFIG_REGULATOR_RTQ2134 is not set
> CONFIG_REGULATOR_RTMV20=m
> CONFIG_REGULATOR_RTQ6752=y
> # CONFIG_REGULATOR_SKY81452 is not set
> CONFIG_REGULATOR_SLG51000=m
> CONFIG_REGULATOR_STPMIC1=m
> CONFIG_REGULATOR_SY8106A=y
> CONFIG_REGULATOR_SY8824X=m
> CONFIG_REGULATOR_SY8827N=m
> CONFIG_REGULATOR_TPS51632=y
> # CONFIG_REGULATOR_TPS62360 is not set
> CONFIG_REGULATOR_TPS65023=y
> CONFIG_REGULATOR_TPS6507X=y
> CONFIG_REGULATOR_TPS65090=m
> CONFIG_REGULATOR_TPS65132=m
> CONFIG_REGULATOR_TPS65217=y
> # CONFIG_REGULATOR_TPS65218 is not set
> # CONFIG_REGULATOR_TPS6524X is not set
> CONFIG_REGULATOR_TPS65910=m
> CONFIG_REGULATOR_TPS65912=m
> # CONFIG_REGULATOR_VCTRL is not set
> CONFIG_REGULATOR_WM831X=y
> CONFIG_REGULATOR_QCOM_LABIBB=m
> CONFIG_RC_CORE=y
> CONFIG_RC_MAP=m
> # CONFIG_LIRC is not set
> # CONFIG_RC_DECODERS is not set
> # CONFIG_RC_DEVICES is not set
> CONFIG_CEC_CORE=m
> CONFIG_CEC_NOTIFIER=y
> 
> #
> # CEC support
> #
> CONFIG_MEDIA_CEC_RC=y
> # CONFIG_MEDIA_CEC_SUPPORT is not set
> # end of CEC support
> 
> CONFIG_MEDIA_SUPPORT=m
> CONFIG_MEDIA_SUPPORT_FILTER=y
> # CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
> 
> #
> # Media device types
> #
> CONFIG_MEDIA_CAMERA_SUPPORT=y
> # CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
> CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
> CONFIG_MEDIA_RADIO_SUPPORT=y
> # CONFIG_MEDIA_SDR_SUPPORT is not set
> # CONFIG_MEDIA_PLATFORM_SUPPORT is not set
> # CONFIG_MEDIA_TEST_SUPPORT is not set
> # end of Media device types
> 
> CONFIG_VIDEO_DEV=m
> CONFIG_MEDIA_CONTROLLER=y
> CONFIG_DVB_CORE=m
> 
> #
> # Video4Linux options
> #
> CONFIG_VIDEO_V4L2=m
> CONFIG_VIDEO_V4L2_I2C=y
> CONFIG_VIDEO_V4L2_SUBDEV_API=y
> CONFIG_VIDEO_ADV_DEBUG=y
> # CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
> CONFIG_VIDEO_TUNER=m
> CONFIG_V4L2_FLASH_LED_CLASS=m
> CONFIG_V4L2_FWNODE=m
> CONFIG_V4L2_ASYNC=m
> CONFIG_VIDEOBUF_GEN=m
> CONFIG_VIDEOBUF_VMALLOC=m
> # end of Video4Linux options
> 
> #
> # Media controller options
> #
> CONFIG_MEDIA_CONTROLLER_DVB=y
> # end of Media controller options
> 
> #
> # Digital TV options
> #
> # CONFIG_DVB_MMAP is not set
> CONFIG_DVB_NET=y
> CONFIG_DVB_MAX_ADAPTERS=16
> CONFIG_DVB_DYNAMIC_MINORS=y
> # CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
> # CONFIG_DVB_ULE_DEBUG is not set
> # end of Digital TV options
> 
> #
> # Media drivers
> #
> 
> #
> # Drivers filtered as selected at 'Filter media drivers'
> #
> CONFIG_MEDIA_USB_SUPPORT=y
> 
> #
> # Webcam devices
> #
> # CONFIG_USB_VIDEO_CLASS is not set
> CONFIG_USB_GSPCA=m
> CONFIG_USB_M5602=m
> # CONFIG_USB_STV06XX is not set
> CONFIG_USB_GL860=m
> # CONFIG_USB_GSPCA_BENQ is not set
> CONFIG_USB_GSPCA_CONEX=m
> # CONFIG_USB_GSPCA_CPIA1 is not set
> # CONFIG_USB_GSPCA_DTCS033 is not set
> # CONFIG_USB_GSPCA_ETOMS is not set
> CONFIG_USB_GSPCA_FINEPIX=m
> # CONFIG_USB_GSPCA_JEILINJ is not set
> # CONFIG_USB_GSPCA_JL2005BCD is not set
> CONFIG_USB_GSPCA_KINECT=m
> CONFIG_USB_GSPCA_KONICA=m
> # CONFIG_USB_GSPCA_MARS is not set
> # CONFIG_USB_GSPCA_MR97310A is not set
> # CONFIG_USB_GSPCA_NW80X is not set
> CONFIG_USB_GSPCA_OV519=m
> CONFIG_USB_GSPCA_OV534=m
> CONFIG_USB_GSPCA_OV534_9=m
> CONFIG_USB_GSPCA_PAC207=m
> CONFIG_USB_GSPCA_PAC7302=m
> # CONFIG_USB_GSPCA_PAC7311 is not set
> # CONFIG_USB_GSPCA_SE401 is not set
> # CONFIG_USB_GSPCA_SN9C2028 is not set
> CONFIG_USB_GSPCA_SN9C20X=m
> CONFIG_USB_GSPCA_SONIXB=m
> CONFIG_USB_GSPCA_SONIXJ=m
> CONFIG_USB_GSPCA_SPCA500=m
> # CONFIG_USB_GSPCA_SPCA501 is not set
> CONFIG_USB_GSPCA_SPCA505=m
> CONFIG_USB_GSPCA_SPCA506=m
> CONFIG_USB_GSPCA_SPCA508=m
> CONFIG_USB_GSPCA_SPCA561=m
> CONFIG_USB_GSPCA_SPCA1528=m
> # CONFIG_USB_GSPCA_SQ905 is not set
> CONFIG_USB_GSPCA_SQ905C=m
> CONFIG_USB_GSPCA_SQ930X=m
> CONFIG_USB_GSPCA_STK014=m
> CONFIG_USB_GSPCA_STK1135=m
> CONFIG_USB_GSPCA_STV0680=m
> CONFIG_USB_GSPCA_SUNPLUS=m
> # CONFIG_USB_GSPCA_T613 is not set
> CONFIG_USB_GSPCA_TOPRO=m
> CONFIG_USB_GSPCA_TOUPTEK=m
> # CONFIG_USB_GSPCA_TV8532 is not set
> CONFIG_USB_GSPCA_VC032X=m
> # CONFIG_USB_GSPCA_VICAM is not set
> CONFIG_USB_GSPCA_XIRLINK_CIT=m
> # CONFIG_USB_GSPCA_ZC3XX is not set
> CONFIG_USB_PWC=m
> CONFIG_USB_PWC_DEBUG=y
> # CONFIG_USB_PWC_INPUT_EVDEV is not set
> # CONFIG_VIDEO_CPIA2 is not set
> CONFIG_USB_ZR364XX=m
> # CONFIG_USB_STKWEBCAM is not set
> # CONFIG_USB_S2255 is not set
> CONFIG_VIDEO_USBTV=m
> 
> #
> # Analog/digital TV USB devices
> #
> CONFIG_VIDEO_AU0828=m
> CONFIG_VIDEO_AU0828_V4L2=y
> CONFIG_VIDEO_AU0828_RC=y
> CONFIG_VIDEO_CX231XX=m
> CONFIG_VIDEO_CX231XX_RC=y
> CONFIG_VIDEO_CX231XX_ALSA=m
> CONFIG_VIDEO_CX231XX_DVB=m
> CONFIG_VIDEO_TM6000=m
> # CONFIG_VIDEO_TM6000_ALSA is not set
> CONFIG_VIDEO_TM6000_DVB=m
> 
> #
> # Digital TV USB devices
> #
> CONFIG_DVB_USB=m
> CONFIG_DVB_USB_DEBUG=y
> CONFIG_DVB_USB_DIB3000MC=m
> CONFIG_DVB_USB_A800=m
> CONFIG_DVB_USB_DIBUSB_MB=m
> CONFIG_DVB_USB_DIBUSB_MB_FAULTY=y
> CONFIG_DVB_USB_DIBUSB_MC=m
> # CONFIG_DVB_USB_DIB0700 is not set
> CONFIG_DVB_USB_UMT_010=m
> CONFIG_DVB_USB_CXUSB=m
> # CONFIG_DVB_USB_CXUSB_ANALOG is not set
> CONFIG_DVB_USB_M920X=m
> # CONFIG_DVB_USB_DIGITV is not set
> # CONFIG_DVB_USB_VP7045 is not set
> CONFIG_DVB_USB_VP702X=m
> # CONFIG_DVB_USB_GP8PSK is not set
> CONFIG_DVB_USB_NOVA_T_USB2=m
> CONFIG_DVB_USB_TTUSB2=m
> CONFIG_DVB_USB_DTT200U=m
> # CONFIG_DVB_USB_OPERA1 is not set
> CONFIG_DVB_USB_AF9005=m
> CONFIG_DVB_USB_AF9005_REMOTE=m
> CONFIG_DVB_USB_PCTV452E=m
> CONFIG_DVB_USB_DW2102=m
> # CONFIG_DVB_USB_CINERGY_T2 is not set
> CONFIG_DVB_USB_DTV5100=m
> CONFIG_DVB_USB_AZ6027=m
> # CONFIG_DVB_USB_TECHNISAT_USB2 is not set
> # CONFIG_DVB_USB_V2 is not set
> # CONFIG_DVB_TTUSB_BUDGET is not set
> # CONFIG_DVB_TTUSB_DEC is not set
> CONFIG_SMS_USB_DRV=m
> CONFIG_DVB_B2C2_FLEXCOP_USB=m
> # CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG is not set
> # CONFIG_DVB_AS102 is not set
> 
> #
> # Webcam, TV (analog/digital) USB devices
> #
> CONFIG_VIDEO_EM28XX=m
> CONFIG_VIDEO_EM28XX_V4L2=m
> CONFIG_VIDEO_EM28XX_ALSA=m
> CONFIG_VIDEO_EM28XX_DVB=m
> CONFIG_VIDEO_EM28XX_RC=m
> # CONFIG_MEDIA_PCI_SUPPORT is not set
> CONFIG_RADIO_ADAPTERS=y
> CONFIG_RADIO_TEA575X=m
> CONFIG_RADIO_SI470X=m
> CONFIG_USB_SI470X=m
> # CONFIG_I2C_SI470X is not set
> # CONFIG_RADIO_SI4713 is not set
> CONFIG_RADIO_SI476X=m
> CONFIG_USB_MR800=m
> CONFIG_USB_DSBR=m
> # CONFIG_RADIO_MAXIRADIO is not set
> CONFIG_RADIO_SHARK=m
> CONFIG_RADIO_SHARK2=m
> # CONFIG_USB_KEENE is not set
> CONFIG_USB_RAREMONO=m
> CONFIG_USB_MA901=m
> # CONFIG_RADIO_TEA5764 is not set
> # CONFIG_RADIO_SAA7706H is not set
> CONFIG_RADIO_TEF6862=m
> # CONFIG_RADIO_WL1273 is not set
> CONFIG_V4L_RADIO_ISA_DRIVERS=y
> CONFIG_RADIO_ISA=m
> CONFIG_RADIO_CADET=m
> # CONFIG_RADIO_RTRACK is not set
> # CONFIG_RADIO_RTRACK2 is not set
> # CONFIG_RADIO_AZTECH is not set
> # CONFIG_RADIO_GEMTEK is not set
> # CONFIG_RADIO_MIROPCM20 is not set
> CONFIG_RADIO_SF16FMI=m
> CONFIG_RADIO_SF16FMR2=m
> # CONFIG_RADIO_TERRATEC is not set
> # CONFIG_RADIO_TRUST is not set
> CONFIG_RADIO_TYPHOON=m
> CONFIG_RADIO_ZOLTRIX=m
> CONFIG_MEDIA_COMMON_OPTIONS=y
> 
> #
> # common driver options
> #
> CONFIG_VIDEO_CX2341X=m
> CONFIG_VIDEO_TVEEPROM=m
> CONFIG_TTPCI_EEPROM=m
> CONFIG_CYPRESS_FIRMWARE=m
> CONFIG_VIDEOBUF2_CORE=m
> CONFIG_VIDEOBUF2_V4L2=m
> CONFIG_VIDEOBUF2_MEMOPS=m
> CONFIG_VIDEOBUF2_VMALLOC=m
> CONFIG_VIDEOBUF2_DMA_SG=m
> CONFIG_DVB_B2C2_FLEXCOP=m
> CONFIG_SMS_SIANO_MDTV=m
> CONFIG_SMS_SIANO_RC=y
> 
> #
> # FireWire (IEEE 1394) Adapters
> #
> CONFIG_DVB_FIREDTV=m
> CONFIG_DVB_FIREDTV_INPUT=y
> # end of Media drivers
> 
> #
> # Media ancillary drivers
> #
> CONFIG_MEDIA_ATTACH=y
> # CONFIG_VIDEO_IR_I2C is not set
> 
> #
> # Audio decoders, processors and mixers
> #
> CONFIG_VIDEO_TVAUDIO=m
> CONFIG_VIDEO_TDA7432=m
> # CONFIG_VIDEO_TDA9840 is not set
> CONFIG_VIDEO_TDA1997X=m
> CONFIG_VIDEO_TEA6415C=m
> CONFIG_VIDEO_TEA6420=m
> CONFIG_VIDEO_MSP3400=m
> CONFIG_VIDEO_CS3308=m
> # CONFIG_VIDEO_CS5345 is not set
> CONFIG_VIDEO_CS53L32A=m
> CONFIG_VIDEO_TLV320AIC23B=m
> CONFIG_VIDEO_UDA1342=m
> # CONFIG_VIDEO_WM8775 is not set
> CONFIG_VIDEO_WM8739=m
> # CONFIG_VIDEO_VP27SMPX is not set
> CONFIG_VIDEO_SONY_BTF_MPX=m
> # end of Audio decoders, processors and mixers
> 
> #
> # RDS decoders
> #
> CONFIG_VIDEO_SAA6588=m
> # end of RDS decoders
> 
> #
> # Video decoders
> #
> CONFIG_VIDEO_ADV7180=m
> # CONFIG_VIDEO_ADV7183 is not set
> CONFIG_VIDEO_ADV748X=m
> CONFIG_VIDEO_ADV7604=m
> # CONFIG_VIDEO_ADV7604_CEC is not set
> CONFIG_VIDEO_ADV7842=m
> CONFIG_VIDEO_ADV7842_CEC=y
> CONFIG_VIDEO_BT819=m
> # CONFIG_VIDEO_BT856 is not set
> CONFIG_VIDEO_BT866=m
> CONFIG_VIDEO_KS0127=m
> CONFIG_VIDEO_ML86V7667=m
> CONFIG_VIDEO_SAA7110=m
> CONFIG_VIDEO_SAA711X=m
> # CONFIG_VIDEO_TC358743 is not set
> # CONFIG_VIDEO_TVP514X is not set
> # CONFIG_VIDEO_TVP5150 is not set
> # CONFIG_VIDEO_TVP7002 is not set
> # CONFIG_VIDEO_TW2804 is not set
> CONFIG_VIDEO_TW9903=m
> # CONFIG_VIDEO_TW9906 is not set
> CONFIG_VIDEO_TW9910=m
> CONFIG_VIDEO_VPX3220=m
> CONFIG_VIDEO_MAX9286=m
> 
> #
> # Video and audio decoders
> #
> CONFIG_VIDEO_SAA717X=m
> CONFIG_VIDEO_CX25840=m
> # end of Video decoders
> 
> #
> # Video encoders
> #
> CONFIG_VIDEO_SAA7127=m
> CONFIG_VIDEO_SAA7185=m
> CONFIG_VIDEO_ADV7170=m
> CONFIG_VIDEO_ADV7175=m
> CONFIG_VIDEO_ADV7343=m
> CONFIG_VIDEO_ADV7393=m
> CONFIG_VIDEO_AD9389B=m
> # CONFIG_VIDEO_AK881X is not set
> CONFIG_VIDEO_THS8200=m
> # end of Video encoders
> 
> #
> # Video improvement chips
> #
> CONFIG_VIDEO_UPD64031A=m
> CONFIG_VIDEO_UPD64083=m
> # end of Video improvement chips
> 
> #
> # Audio/Video compression chips
> #
> CONFIG_VIDEO_SAA6752HS=m
> # end of Audio/Video compression chips
> 
> #
> # SDR tuner chips
> #
> # end of SDR tuner chips
> 
> #
> # Miscellaneous helper chips
> #
> CONFIG_VIDEO_THS7303=m
> # CONFIG_VIDEO_M52790 is not set
> # CONFIG_VIDEO_I2C is not set
> # CONFIG_VIDEO_ST_MIPID02 is not set
> # end of Miscellaneous helper chips
> 
> #
> # Camera sensor devices
> #
> CONFIG_VIDEO_APTINA_PLL=m
> CONFIG_VIDEO_CCS_PLL=m
> CONFIG_VIDEO_HI556=m
> CONFIG_VIDEO_HI846=m
> # CONFIG_VIDEO_IMX208 is not set
> CONFIG_VIDEO_IMX214=m
> CONFIG_VIDEO_IMX219=m
> # CONFIG_VIDEO_IMX258 is not set
> # CONFIG_VIDEO_IMX274 is not set
> CONFIG_VIDEO_IMX290=m
> # CONFIG_VIDEO_IMX319 is not set
> # CONFIG_VIDEO_IMX334 is not set
> CONFIG_VIDEO_IMX335=m
> CONFIG_VIDEO_IMX355=m
> CONFIG_VIDEO_IMX412=m
> CONFIG_VIDEO_OV02A10=m
> # CONFIG_VIDEO_OV2640 is not set
> # CONFIG_VIDEO_OV2659 is not set
> CONFIG_VIDEO_OV2680=m
> CONFIG_VIDEO_OV2685=m
> CONFIG_VIDEO_OV2740=m
> CONFIG_VIDEO_OV5640=m
> CONFIG_VIDEO_OV5645=m
> # CONFIG_VIDEO_OV5647 is not set
> CONFIG_VIDEO_OV5648=m
> CONFIG_VIDEO_OV6650=m
> CONFIG_VIDEO_OV5670=m
> # CONFIG_VIDEO_OV5675 is not set
> CONFIG_VIDEO_OV5693=m
> CONFIG_VIDEO_OV5695=m
> CONFIG_VIDEO_OV7251=m
> CONFIG_VIDEO_OV772X=m
> CONFIG_VIDEO_OV7640=m
> CONFIG_VIDEO_OV7670=m
> CONFIG_VIDEO_OV7740=m
> # CONFIG_VIDEO_OV8856 is not set
> CONFIG_VIDEO_OV8865=m
> CONFIG_VIDEO_OV9282=m
> CONFIG_VIDEO_OV9640=m
> CONFIG_VIDEO_OV9650=m
> # CONFIG_VIDEO_OV9734 is not set
> CONFIG_VIDEO_OV13858=m
> # CONFIG_VIDEO_OV13B10 is not set
> CONFIG_VIDEO_VS6624=m
> CONFIG_VIDEO_MT9M001=m
> # CONFIG_VIDEO_MT9M032 is not set
> CONFIG_VIDEO_MT9M111=m
> CONFIG_VIDEO_MT9P031=m
> CONFIG_VIDEO_MT9T001=m
> CONFIG_VIDEO_MT9T112=m
> CONFIG_VIDEO_MT9V011=m
> # CONFIG_VIDEO_MT9V032 is not set
> CONFIG_VIDEO_MT9V111=m
> CONFIG_VIDEO_SR030PC30=m
> CONFIG_VIDEO_NOON010PC30=m
> # CONFIG_VIDEO_M5MOLS is not set
> CONFIG_VIDEO_MAX9271_LIB=m
> CONFIG_VIDEO_RDACM20=m
> CONFIG_VIDEO_RDACM21=m
> # CONFIG_VIDEO_RJ54N1 is not set
> CONFIG_VIDEO_S5K6AA=m
> CONFIG_VIDEO_S5K6A3=m
> CONFIG_VIDEO_S5K4ECGX=m
> CONFIG_VIDEO_S5K5BAF=m
> CONFIG_VIDEO_CCS=m
> CONFIG_VIDEO_ET8EK8=m
> # CONFIG_VIDEO_S5C73M3 is not set
> # end of Camera sensor devices
> 
> #
> # Lens drivers
> #
> CONFIG_VIDEO_AD5820=m
> # CONFIG_VIDEO_AK7375 is not set
> CONFIG_VIDEO_DW9714=m
> CONFIG_VIDEO_DW9768=m
> # CONFIG_VIDEO_DW9807_VCM is not set
> # end of Lens drivers
> 
> #
> # Flash devices
> #
> CONFIG_VIDEO_ADP1653=m
> CONFIG_VIDEO_LM3560=m
> CONFIG_VIDEO_LM3646=m
> # end of Flash devices
> 
> #
> # SPI helper chips
> #
> CONFIG_VIDEO_GS1662=m
> # end of SPI helper chips
> 
> #
> # Media SPI Adapters
> #
> CONFIG_CXD2880_SPI_DRV=m
> # end of Media SPI Adapters
> 
> CONFIG_MEDIA_TUNER=m
> 
> #
> # Customize TV tuners
> #
> # CONFIG_MEDIA_TUNER_SIMPLE is not set
> CONFIG_MEDIA_TUNER_TDA18250=m
> CONFIG_MEDIA_TUNER_TDA8290=m
> CONFIG_MEDIA_TUNER_TDA827X=m
> CONFIG_MEDIA_TUNER_TDA18271=m
> CONFIG_MEDIA_TUNER_TDA9887=m
> CONFIG_MEDIA_TUNER_TEA5761=m
> # CONFIG_MEDIA_TUNER_TEA5767 is not set
> CONFIG_MEDIA_TUNER_MSI001=m
> CONFIG_MEDIA_TUNER_MT20XX=m
> # CONFIG_MEDIA_TUNER_MT2060 is not set
> CONFIG_MEDIA_TUNER_MT2063=m
> CONFIG_MEDIA_TUNER_MT2266=m
> CONFIG_MEDIA_TUNER_MT2131=m
> CONFIG_MEDIA_TUNER_QT1010=m
> CONFIG_MEDIA_TUNER_XC2028=m
> CONFIG_MEDIA_TUNER_XC5000=m
> # CONFIG_MEDIA_TUNER_XC4000 is not set
> CONFIG_MEDIA_TUNER_MXL5005S=m
> CONFIG_MEDIA_TUNER_MXL5007T=m
> # CONFIG_MEDIA_TUNER_MC44S803 is not set
> CONFIG_MEDIA_TUNER_MAX2165=m
> CONFIG_MEDIA_TUNER_TDA18218=m
> CONFIG_MEDIA_TUNER_FC0011=m
> # CONFIG_MEDIA_TUNER_FC0012 is not set
> # CONFIG_MEDIA_TUNER_FC0013 is not set
> CONFIG_MEDIA_TUNER_TDA18212=m
> # CONFIG_MEDIA_TUNER_E4000 is not set
> CONFIG_MEDIA_TUNER_FC2580=m
> CONFIG_MEDIA_TUNER_M88RS6000T=m
> CONFIG_MEDIA_TUNER_TUA9001=m
> CONFIG_MEDIA_TUNER_SI2157=m
> CONFIG_MEDIA_TUNER_IT913X=m
> CONFIG_MEDIA_TUNER_R820T=m
> # CONFIG_MEDIA_TUNER_MXL301RF is not set
> CONFIG_MEDIA_TUNER_QM1D1C0042=m
> # CONFIG_MEDIA_TUNER_QM1D1B0004 is not set
> # end of Customize TV tuners
> 
> #
> # Customise DVB Frontends
> #
> 
> #
> # Multistandard (satellite) frontends
> #
> # CONFIG_DVB_STB0899 is not set
> CONFIG_DVB_STB6100=m
> CONFIG_DVB_STV090x=m
> CONFIG_DVB_STV0910=m
> # CONFIG_DVB_STV6110x is not set
> CONFIG_DVB_STV6111=m
> # CONFIG_DVB_MXL5XX is not set
> # CONFIG_DVB_M88DS3103 is not set
> 
> #
> # Multistandard (cable + terrestrial) frontends
> #
> CONFIG_DVB_DRXK=m
> CONFIG_DVB_TDA18271C2DD=m
> CONFIG_DVB_SI2165=m
> CONFIG_DVB_MN88472=m
> # CONFIG_DVB_MN88473 is not set
> 
> #
> # DVB-S (satellite) frontends
> #
> CONFIG_DVB_CX24110=m
> CONFIG_DVB_CX24123=m
> # CONFIG_DVB_MT312 is not set
> # CONFIG_DVB_ZL10036 is not set
> # CONFIG_DVB_ZL10039 is not set
> CONFIG_DVB_S5H1420=m
> CONFIG_DVB_STV0288=m
> CONFIG_DVB_STB6000=m
> CONFIG_DVB_STV0299=m
> # CONFIG_DVB_STV6110 is not set
> # CONFIG_DVB_STV0900 is not set
> CONFIG_DVB_TDA8083=m
> CONFIG_DVB_TDA10086=m
> CONFIG_DVB_TDA8261=m
> CONFIG_DVB_VES1X93=m
> CONFIG_DVB_TUNER_ITD1000=m
> # CONFIG_DVB_TUNER_CX24113 is not set
> CONFIG_DVB_TDA826X=m
> CONFIG_DVB_TUA6100=m
> CONFIG_DVB_CX24116=m
> # CONFIG_DVB_CX24117 is not set
> CONFIG_DVB_CX24120=m
> CONFIG_DVB_SI21XX=m
> CONFIG_DVB_TS2020=m
> CONFIG_DVB_DS3000=m
> CONFIG_DVB_MB86A16=m
> CONFIG_DVB_TDA10071=m
> 
> #
> # DVB-T (terrestrial) frontends
> #
> CONFIG_DVB_SP887X=m
> CONFIG_DVB_CX22700=m
> CONFIG_DVB_CX22702=m
> CONFIG_DVB_S5H1432=m
> # CONFIG_DVB_DRXD is not set
> # CONFIG_DVB_L64781 is not set
> CONFIG_DVB_TDA1004X=m
> CONFIG_DVB_NXT6000=m
> # CONFIG_DVB_MT352 is not set
> CONFIG_DVB_ZL10353=m
> CONFIG_DVB_DIB3000MB=m
> CONFIG_DVB_DIB3000MC=m
> # CONFIG_DVB_DIB7000M is not set
> CONFIG_DVB_DIB7000P=m
> CONFIG_DVB_DIB9000=m
> # CONFIG_DVB_TDA10048 is not set
> # CONFIG_DVB_AF9013 is not set
> # CONFIG_DVB_EC100 is not set
> CONFIG_DVB_STV0367=m
> CONFIG_DVB_CXD2820R=m
> # CONFIG_DVB_CXD2841ER is not set
> CONFIG_DVB_RTL2830=m
> CONFIG_DVB_RTL2832=m
> # CONFIG_DVB_SI2168 is not set
> CONFIG_DVB_ZD1301_DEMOD=m
> CONFIG_DVB_CXD2880=m
> 
> #
> # DVB-C (cable) frontends
> #
> CONFIG_DVB_VES1820=m
> # CONFIG_DVB_TDA10021 is not set
> CONFIG_DVB_TDA10023=m
> CONFIG_DVB_STV0297=m
> 
> #
> # ATSC (North American/Korean Terrestrial/Cable DTV) frontends
> #
> CONFIG_DVB_NXT200X=m
> # CONFIG_DVB_OR51211 is not set
> CONFIG_DVB_OR51132=m
> # CONFIG_DVB_BCM3510 is not set
> CONFIG_DVB_LGDT330X=m
> # CONFIG_DVB_LGDT3305 is not set
> CONFIG_DVB_LGDT3306A=m
> CONFIG_DVB_LG2160=m
> CONFIG_DVB_S5H1409=m
> # CONFIG_DVB_AU8522_DTV is not set
> # CONFIG_DVB_AU8522_V4L is not set
> # CONFIG_DVB_S5H1411 is not set
> # CONFIG_DVB_MXL692 is not set
> 
> #
> # ISDB-T (terrestrial) frontends
> #
> # CONFIG_DVB_S921 is not set
> CONFIG_DVB_DIB8000=m
> CONFIG_DVB_MB86A20S=m
> 
> #
> # ISDB-S (satellite) & ISDB-T (terrestrial) frontends
> #
> CONFIG_DVB_TC90522=m
> # CONFIG_DVB_MN88443X is not set
> 
> #
> # Digital terrestrial only tuners/PLL
> #
> # CONFIG_DVB_PLL is not set
> # CONFIG_DVB_TUNER_DIB0070 is not set
> # CONFIG_DVB_TUNER_DIB0090 is not set
> 
> #
> # SEC control devices for DVB-S
> #
> CONFIG_DVB_DRX39XYJ=m
> CONFIG_DVB_LNBH25=m
> CONFIG_DVB_LNBH29=m
> CONFIG_DVB_LNBP21=m
> CONFIG_DVB_LNBP22=m
> CONFIG_DVB_ISL6405=m
> CONFIG_DVB_ISL6421=m
> CONFIG_DVB_ISL6423=m
> CONFIG_DVB_A8293=m
> # CONFIG_DVB_LGS8GL5 is not set
> CONFIG_DVB_LGS8GXX=m
> CONFIG_DVB_ATBM8830=m
> CONFIG_DVB_TDA665x=m
> CONFIG_DVB_IX2505V=m
> # CONFIG_DVB_M88RS2000 is not set
> # CONFIG_DVB_AF9033 is not set
> CONFIG_DVB_HORUS3A=m
> CONFIG_DVB_ASCOT2E=m
> CONFIG_DVB_HELENE=m
> 
> #
> # Common Interface (EN50221) controller drivers
> #
> CONFIG_DVB_CXD2099=m
> CONFIG_DVB_SP2=m
> # end of Customise DVB Frontends
> # end of Media ancillary drivers
> 
> #
> # Graphics support
> #
> # CONFIG_AGP is not set
> CONFIG_VGA_ARB=y
> CONFIG_VGA_ARB_MAX_GPUS=16
> # CONFIG_VGA_SWITCHEROO is not set
> CONFIG_DRM=m
> CONFIG_DRM_MIPI_DBI=m
> CONFIG_DRM_MIPI_DSI=y
> CONFIG_DRM_DP_AUX_BUS=m
> CONFIG_DRM_DP_AUX_CHARDEV=y
> # CONFIG_DRM_DEBUG_SELFTEST is not set
> CONFIG_DRM_KMS_HELPER=m
> CONFIG_DRM_LOAD_EDID_FIRMWARE=y
> CONFIG_DRM_DP_CEC=y
> CONFIG_DRM_GEM_CMA_HELPER=m
> CONFIG_DRM_GEM_SHMEM_HELPER=m
> 
> #
> # I2C encoder or helper chips
> #
> CONFIG_DRM_I2C_CH7006=m
> CONFIG_DRM_I2C_SIL164=m
> CONFIG_DRM_I2C_NXP_TDA998X=m
> CONFIG_DRM_I2C_NXP_TDA9950=m
> # end of I2C encoder or helper chips
> 
> #
> # ARM devices
> #
> CONFIG_DRM_KOMEDA=m
> # end of ARM devices
> 
> # CONFIG_DRM_RADEON is not set
> # CONFIG_DRM_AMDGPU is not set
> # CONFIG_DRM_NOUVEAU is not set
> # CONFIG_DRM_I915 is not set
> CONFIG_DRM_VGEM=m
> CONFIG_DRM_VKMS=m
> # CONFIG_DRM_VMWGFX is not set
> # CONFIG_DRM_GMA500 is not set
> # CONFIG_DRM_UDL is not set
> # CONFIG_DRM_AST is not set
> # CONFIG_DRM_MGAG200 is not set
> CONFIG_DRM_RCAR_DW_HDMI=m
> # CONFIG_DRM_RCAR_USE_LVDS is not set
> CONFIG_DRM_RCAR_MIPI_DSI=m
> # CONFIG_DRM_QXL is not set
> # CONFIG_DRM_VIRTIO_GPU is not set
> CONFIG_DRM_PANEL=y
> 
> #
> # Display Panels
> #
> CONFIG_DRM_PANEL_ABT_Y030XX067A=m
> # CONFIG_DRM_PANEL_ARM_VERSATILE is not set
> CONFIG_DRM_PANEL_ASUS_Z00T_TM5P5_NT35596=m
> # CONFIG_DRM_PANEL_BOE_BF060Y8M_AJ0 is not set
> CONFIG_DRM_PANEL_BOE_HIMAX8279D=m
> CONFIG_DRM_PANEL_BOE_TV101WUM_NL6=m
> CONFIG_DRM_PANEL_DSI_CM=m
> # CONFIG_DRM_PANEL_LVDS is not set
> CONFIG_DRM_PANEL_SIMPLE=m
> # CONFIG_DRM_PANEL_EDP is not set
> # CONFIG_DRM_PANEL_ELIDA_KD35T133 is not set
> CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02=m
> # CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D is not set
> # CONFIG_DRM_PANEL_ILITEK_IL9322 is not set
> # CONFIG_DRM_PANEL_ILITEK_ILI9341 is not set
> CONFIG_DRM_PANEL_ILITEK_ILI9881C=m
> CONFIG_DRM_PANEL_INNOLUX_EJ030NA=m
> CONFIG_DRM_PANEL_INNOLUX_P079ZCA=m
> CONFIG_DRM_PANEL_JDI_LT070ME05000=m
> CONFIG_DRM_PANEL_JDI_R63452=m
> # CONFIG_DRM_PANEL_KHADAS_TS050 is not set
> # CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04 is not set
> CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W=m
> # CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829 is not set
> # CONFIG_DRM_PANEL_SAMSUNG_LD9040 is not set
> CONFIG_DRM_PANEL_LG_LB035Q02=m
> CONFIG_DRM_PANEL_LG_LG4573=m
> CONFIG_DRM_PANEL_NEC_NL8048HL11=m
> CONFIG_DRM_PANEL_NOVATEK_NT35510=m
> CONFIG_DRM_PANEL_NOVATEK_NT35950=m
> CONFIG_DRM_PANEL_NOVATEK_NT36672A=m
> CONFIG_DRM_PANEL_NOVATEK_NT39016=m
> CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=m
> CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO=m
> CONFIG_DRM_PANEL_ORISETECH_OTM8009A=m
> # CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS is not set
> CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=m
> CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=m
> CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
> # CONFIG_DRM_PANEL_RAYDIUM_RM68200 is not set
> # CONFIG_DRM_PANEL_RONBO_RB070D30 is not set
> CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20=m
> CONFIG_DRM_PANEL_SAMSUNG_DB7430=m
> # CONFIG_DRM_PANEL_SAMSUNG_S6D16D0 is not set
> CONFIG_DRM_PANEL_SAMSUNG_S6D27A1=m
> CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2=m
> # CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03 is not set
> CONFIG_DRM_PANEL_SAMSUNG_S6E63M0=m
> # CONFIG_DRM_PANEL_SAMSUNG_S6E63M0_SPI is not set
> # CONFIG_DRM_PANEL_SAMSUNG_S6E63M0_DSI is not set
> CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01=m
> # CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0 is not set
> CONFIG_DRM_PANEL_SAMSUNG_SOFEF00=m
> # CONFIG_DRM_PANEL_SEIKO_43WVF1G is not set
> CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=m
> CONFIG_DRM_PANEL_SHARP_LS037V7DW01=m
> CONFIG_DRM_PANEL_SHARP_LS043T1LE01=m
> CONFIG_DRM_PANEL_SHARP_LS060T1SX01=m
> CONFIG_DRM_PANEL_SITRONIX_ST7701=m
> CONFIG_DRM_PANEL_SITRONIX_ST7703=m
> # CONFIG_DRM_PANEL_SITRONIX_ST7789V is not set
> # CONFIG_DRM_PANEL_SONY_ACX424AKP is not set
> CONFIG_DRM_PANEL_SONY_ACX565AKM=m
> # CONFIG_DRM_PANEL_SONY_TULIP_TRULY_NT35521 is not set
> # CONFIG_DRM_PANEL_TDO_TL070WSH30 is not set
> # CONFIG_DRM_PANEL_TPO_TD028TTEC1 is not set
> CONFIG_DRM_PANEL_TPO_TD043MTEA1=m
> CONFIG_DRM_PANEL_TPO_TPG110=m
> # CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA is not set
> CONFIG_DRM_PANEL_VISIONOX_RM69299=m
> CONFIG_DRM_PANEL_WIDECHIPS_WS2401=m
> CONFIG_DRM_PANEL_XINPENG_XPP055C272=m
> # end of Display Panels
> 
> CONFIG_DRM_BRIDGE=y
> CONFIG_DRM_PANEL_BRIDGE=y
> 
> #
> # Display Interface Bridges
> #
> CONFIG_DRM_CDNS_DSI=m
> CONFIG_DRM_CHIPONE_ICN6211=m
> CONFIG_DRM_CHRONTEL_CH7033=m
> # CONFIG_DRM_DISPLAY_CONNECTOR is not set
> CONFIG_DRM_LONTIUM_LT8912B=m
> CONFIG_DRM_LONTIUM_LT9611=m
> # CONFIG_DRM_LONTIUM_LT9611UXC is not set
> CONFIG_DRM_ITE_IT66121=m
> CONFIG_DRM_LVDS_CODEC=m
> # CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW is not set
> # CONFIG_DRM_NWL_MIPI_DSI is not set
> CONFIG_DRM_NXP_PTN3460=m
> CONFIG_DRM_PARADE_PS8622=m
> CONFIG_DRM_PARADE_PS8640=m
> # CONFIG_DRM_SIL_SII8620 is not set
> CONFIG_DRM_SII902X=m
> # CONFIG_DRM_SII9234 is not set
> CONFIG_DRM_SIMPLE_BRIDGE=m
> # CONFIG_DRM_THINE_THC63LVD1024 is not set
> CONFIG_DRM_TOSHIBA_TC358762=m
> CONFIG_DRM_TOSHIBA_TC358764=m
> # CONFIG_DRM_TOSHIBA_TC358767 is not set
> CONFIG_DRM_TOSHIBA_TC358768=m
> CONFIG_DRM_TOSHIBA_TC358775=m
> # CONFIG_DRM_TI_TFP410 is not set
> CONFIG_DRM_TI_SN65DSI83=m
> # CONFIG_DRM_TI_SN65DSI86 is not set
> CONFIG_DRM_TI_TPD12S015=m
> CONFIG_DRM_ANALOGIX_ANX6345=m
> CONFIG_DRM_ANALOGIX_ANX78XX=m
> CONFIG_DRM_ANALOGIX_DP=m
> CONFIG_DRM_ANALOGIX_ANX7625=m
> CONFIG_DRM_I2C_ADV7511=m
> # CONFIG_DRM_I2C_ADV7511_AUDIO is not set
> # CONFIG_DRM_I2C_ADV7511_CEC is not set
> # CONFIG_DRM_CDNS_MHDP8546 is not set
> CONFIG_DRM_DW_HDMI=m
> CONFIG_DRM_DW_HDMI_AHB_AUDIO=m
> CONFIG_DRM_DW_HDMI_I2S_AUDIO=m
> CONFIG_DRM_DW_HDMI_CEC=m
> # end of Display Interface Bridges
> 
> # CONFIG_DRM_ETNAVIV is not set
> CONFIG_DRM_MXS=y
> CONFIG_DRM_MXSFB=m
> CONFIG_DRM_ARCPGU=m
> # CONFIG_DRM_BOCHS is not set
> # CONFIG_DRM_CIRRUS_QEMU is not set
> CONFIG_DRM_GM12U320=m
> # CONFIG_DRM_SIMPLEDRM is not set
> CONFIG_TINYDRM_HX8357D=m
> CONFIG_TINYDRM_ILI9163=m
> # CONFIG_TINYDRM_ILI9225 is not set
> CONFIG_TINYDRM_ILI9341=m
> CONFIG_TINYDRM_ILI9486=m
> CONFIG_TINYDRM_MI0283QT=m
> # CONFIG_TINYDRM_REPAPER is not set
> # CONFIG_TINYDRM_ST7586 is not set
> CONFIG_TINYDRM_ST7735R=m
> # CONFIG_DRM_VBOXVIDEO is not set
> # CONFIG_DRM_GUD is not set
> # CONFIG_DRM_LEGACY is not set
> CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=m
> CONFIG_DRM_NOMODESET=y
> 
> #
> # Frame buffer Devices
> #
> CONFIG_FB_CMDLINE=y
> # CONFIG_FB is not set
> # end of Frame buffer Devices
> 
> #
> # Backlight & LCD device support
> #
> # CONFIG_LCD_CLASS_DEVICE is not set
> CONFIG_BACKLIGHT_CLASS_DEVICE=y
> # CONFIG_BACKLIGHT_KTD253 is not set
> # CONFIG_BACKLIGHT_LM3533 is not set
> CONFIG_BACKLIGHT_DA9052=y
> # CONFIG_BACKLIGHT_MAX8925 is not set
> CONFIG_BACKLIGHT_APPLE=y
> CONFIG_BACKLIGHT_QCOM_WLED=y
> CONFIG_BACKLIGHT_RT4831=y
> CONFIG_BACKLIGHT_SAHARA=m
> # CONFIG_BACKLIGHT_WM831X is not set
> CONFIG_BACKLIGHT_ADP8860=m
> # CONFIG_BACKLIGHT_ADP8870 is not set
> CONFIG_BACKLIGHT_PCF50633=m
> # CONFIG_BACKLIGHT_AAT2870 is not set
> CONFIG_BACKLIGHT_LM3639=m
> CONFIG_BACKLIGHT_SKY81452=m
> # CONFIG_BACKLIGHT_TPS65217 is not set
> CONFIG_BACKLIGHT_AS3711=y
> CONFIG_BACKLIGHT_GPIO=m
> CONFIG_BACKLIGHT_LV5207LP=y
> CONFIG_BACKLIGHT_BD6107=y
> CONFIG_BACKLIGHT_ARCXCNN=m
> CONFIG_BACKLIGHT_RAVE_SP=y
> # CONFIG_BACKLIGHT_LED is not set
> # end of Backlight & LCD device support
> 
> CONFIG_VIDEOMODE_HELPERS=y
> CONFIG_HDMI=y
> 
> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=y
> # CONFIG_MDA_CONSOLE is not set
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_DUMMY_CONSOLE_COLUMNS=80
> CONFIG_DUMMY_CONSOLE_ROWS=25
> # end of Console display driver support
> # end of Graphics support
> 
> CONFIG_SOUND=y
> CONFIG_SND=m
> CONFIG_SND_TIMER=m
> CONFIG_SND_PCM=m
> CONFIG_SND_PCM_ELD=y
> CONFIG_SND_PCM_IEC958=y
> CONFIG_SND_DMAENGINE_PCM=m
> CONFIG_SND_HWDEP=m
> CONFIG_SND_SEQ_DEVICE=m
> CONFIG_SND_RAWMIDI=m
> CONFIG_SND_COMPRESS_OFFLOAD=m
> CONFIG_SND_JACK=y
> CONFIG_SND_JACK_INPUT_DEV=y
> # CONFIG_SND_OSSEMUL is not set
> CONFIG_SND_PCM_TIMER=y
> CONFIG_SND_DYNAMIC_MINORS=y
> CONFIG_SND_MAX_CARDS=32
> CONFIG_SND_SUPPORT_OLD_API=y
> CONFIG_SND_PROC_FS=y
> # CONFIG_SND_VERBOSE_PROCFS is not set
> CONFIG_SND_VERBOSE_PRINTK=y
> CONFIG_SND_DEBUG=y
> # CONFIG_SND_DEBUG_VERBOSE is not set
> CONFIG_SND_CTL_VALIDATION=y
> CONFIG_SND_JACK_INJECTION_DEBUG=y
> CONFIG_SND_VMASTER=y
> CONFIG_SND_DMA_SGBUF=y
> CONFIG_SND_SEQUENCER=m
> CONFIG_SND_SEQ_DUMMY=m
> CONFIG_SND_SEQ_MIDI_EVENT=m
> CONFIG_SND_SEQ_MIDI=m
> CONFIG_SND_SEQ_VIRMIDI=m
> CONFIG_SND_MPU401_UART=m
> CONFIG_SND_AC97_CODEC=m
> CONFIG_SND_DRIVERS=y
> CONFIG_SND_DUMMY=m
> # CONFIG_SND_ALOOP is not set
> CONFIG_SND_VIRMIDI=m
> CONFIG_SND_MTPAV=m
> CONFIG_SND_SERIAL_U16550=m
> CONFIG_SND_MPU401=m
> # CONFIG_SND_AC97_POWER_SAVE is not set
> # CONFIG_SND_ISA is not set
> CONFIG_SND_PCI=y
> # CONFIG_SND_AD1889 is not set
> # CONFIG_SND_ALS300 is not set
> # CONFIG_SND_ALS4000 is not set
> # CONFIG_SND_ALI5451 is not set
> # CONFIG_SND_ASIHPI is not set
> # CONFIG_SND_ATIIXP is not set
> # CONFIG_SND_ATIIXP_MODEM is not set
> # CONFIG_SND_AU8810 is not set
> # CONFIG_SND_AU8820 is not set
> # CONFIG_SND_AU8830 is not set
> # CONFIG_SND_AW2 is not set
> # CONFIG_SND_AZT3328 is not set
> # CONFIG_SND_BT87X is not set
> # CONFIG_SND_CA0106 is not set
> # CONFIG_SND_CMIPCI is not set
> # CONFIG_SND_OXYGEN is not set
> # CONFIG_SND_CS4281 is not set
> # CONFIG_SND_CS46XX is not set
> # CONFIG_SND_CS5530 is not set
> # CONFIG_SND_CS5535AUDIO is not set
> # CONFIG_SND_CTXFI is not set
> # CONFIG_SND_DARLA20 is not set
> # CONFIG_SND_GINA20 is not set
> # CONFIG_SND_LAYLA20 is not set
> # CONFIG_SND_DARLA24 is not set
> # CONFIG_SND_GINA24 is not set
> # CONFIG_SND_LAYLA24 is not set
> # CONFIG_SND_MONA is not set
> # CONFIG_SND_MIA is not set
> # CONFIG_SND_ECHO3G is not set
> # CONFIG_SND_INDIGO is not set
> # CONFIG_SND_INDIGOIO is not set
> # CONFIG_SND_INDIGODJ is not set
> # CONFIG_SND_INDIGOIOX is not set
> # CONFIG_SND_INDIGODJX is not set
> # CONFIG_SND_EMU10K1 is not set
> # CONFIG_SND_EMU10K1X is not set
> # CONFIG_SND_ENS1370 is not set
> # CONFIG_SND_ENS1371 is not set
> # CONFIG_SND_ES1938 is not set
> # CONFIG_SND_ES1968 is not set
> # CONFIG_SND_FM801 is not set
> # CONFIG_SND_HDSP is not set
> # CONFIG_SND_HDSPM is not set
> # CONFIG_SND_ICE1712 is not set
> # CONFIG_SND_ICE1724 is not set
> # CONFIG_SND_INTEL8X0 is not set
> # CONFIG_SND_INTEL8X0M is not set
> # CONFIG_SND_KORG1212 is not set
> # CONFIG_SND_LOLA is not set
> # CONFIG_SND_LX6464ES is not set
> # CONFIG_SND_MAESTRO3 is not set
> # CONFIG_SND_MIXART is not set
> # CONFIG_SND_NM256 is not set
> # CONFIG_SND_PCXHR is not set
> # CONFIG_SND_RIPTIDE is not set
> # CONFIG_SND_RME32 is not set
> # CONFIG_SND_RME96 is not set
> # CONFIG_SND_RME9652 is not set
> # CONFIG_SND_SE6X is not set
> # CONFIG_SND_SIS7019 is not set
> # CONFIG_SND_SONICVIBES is not set
> # CONFIG_SND_TRIDENT is not set
> # CONFIG_SND_VIA82XX is not set
> # CONFIG_SND_VIA82XX_MODEM is not set
> # CONFIG_SND_VIRTUOSO is not set
> # CONFIG_SND_VX222 is not set
> # CONFIG_SND_YMFPCI is not set
> 
> #
> # HD-Audio
> #
> # CONFIG_SND_HDA_INTEL is not set
> # end of HD-Audio
> 
> CONFIG_SND_HDA_PREALLOC_SIZE=0
> CONFIG_SND_SPI=y
> # CONFIG_SND_USB is not set
> CONFIG_SND_FIREWIRE=y
> CONFIG_SND_FIREWIRE_LIB=m
> # CONFIG_SND_DICE is not set
> CONFIG_SND_OXFW=m
> CONFIG_SND_ISIGHT=m
> # CONFIG_SND_FIREWORKS is not set
> # CONFIG_SND_BEBOB is not set
> # CONFIG_SND_FIREWIRE_DIGI00X is not set
> CONFIG_SND_FIREWIRE_TASCAM=m
> # CONFIG_SND_FIREWIRE_MOTU is not set
> # CONFIG_SND_FIREFACE is not set
> CONFIG_SND_SOC=m
> CONFIG_SND_SOC_AC97_BUS=y
> CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
> CONFIG_SND_SOC_COMPRESS=y
> CONFIG_SND_SOC_ACPI=m
> # CONFIG_SND_SOC_ADI is not set
> # CONFIG_SND_SOC_AMD_ACP is not set
> # CONFIG_SND_SOC_AMD_ACP3x is not set
> # CONFIG_SND_SOC_AMD_RENOIR is not set
> # CONFIG_SND_SOC_AMD_ACP5x is not set
> # CONFIG_SND_SOC_AMD_ACP6x is not set
> CONFIG_SND_AMD_ACP_CONFIG=m
> # CONFIG_SND_SOC_AMD_ACP_COMMON is not set
> # CONFIG_SND_ATMEL_SOC is not set
> CONFIG_SND_BCM63XX_I2S_WHISTLER=m
> CONFIG_SND_DESIGNWARE_I2S=m
> # CONFIG_SND_DESIGNWARE_PCM is not set
> 
> #
> # SoC Audio for Freescale CPUs
> #
> 
> #
> # Common SoC Audio options for Freescale CPUs:
> #
> CONFIG_SND_SOC_FSL_ASRC=m
> CONFIG_SND_SOC_FSL_SAI=m
> CONFIG_SND_SOC_FSL_MQS=m
> CONFIG_SND_SOC_FSL_AUDMIX=m
> # CONFIG_SND_SOC_FSL_SSI is not set
> CONFIG_SND_SOC_FSL_SPDIF=m
> CONFIG_SND_SOC_FSL_ESAI=m
> # CONFIG_SND_SOC_FSL_MICFIL is not set
> # CONFIG_SND_SOC_FSL_EASRC is not set
> # CONFIG_SND_SOC_FSL_XCVR is not set
> CONFIG_SND_SOC_FSL_RPMSG=m
> # CONFIG_SND_SOC_IMX_AUDMUX is not set
> # end of SoC Audio for Freescale CPUs
> 
> # CONFIG_SND_I2S_HI6210_I2S is not set
> CONFIG_SND_SOC_IMG=y
> CONFIG_SND_SOC_IMG_I2S_IN=m
> # CONFIG_SND_SOC_IMG_I2S_OUT is not set
> # CONFIG_SND_SOC_IMG_PARALLEL_OUT is not set
> CONFIG_SND_SOC_IMG_SPDIF_IN=m
> CONFIG_SND_SOC_IMG_SPDIF_OUT=m
> # CONFIG_SND_SOC_IMG_PISTACHIO_INTERNAL_DAC is not set
> # CONFIG_SND_SOC_INTEL_SST_TOPLEVEL is not set
> # CONFIG_SND_SOC_MTK_BTCVSD is not set
> # CONFIG_SND_SOC_SOF_TOPLEVEL is not set
> 
> #
> # STMicroelectronics STM32 SOC audio support
> #
> # end of STMicroelectronics STM32 SOC audio support
> 
> # CONFIG_SND_SOC_XILINX_I2S is not set
> # CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
> # CONFIG_SND_SOC_XILINX_SPDIF is not set
> CONFIG_SND_SOC_XTFPGA_I2S=m
> CONFIG_SND_SOC_I2C_AND_SPI=m
> 
> #
> # CODEC drivers
> #
> CONFIG_SND_SOC_WM_ADSP=m
> CONFIG_SND_SOC_AC97_CODEC=m
> CONFIG_SND_SOC_ADAU_UTILS=m
> CONFIG_SND_SOC_ADAU1372=m
> CONFIG_SND_SOC_ADAU1372_I2C=m
> CONFIG_SND_SOC_ADAU1372_SPI=m
> CONFIG_SND_SOC_ADAU1701=m
> CONFIG_SND_SOC_ADAU17X1=m
> CONFIG_SND_SOC_ADAU1761=m
> CONFIG_SND_SOC_ADAU1761_I2C=m
> # CONFIG_SND_SOC_ADAU1761_SPI is not set
> CONFIG_SND_SOC_ADAU7002=m
> CONFIG_SND_SOC_ADAU7118=m
> # CONFIG_SND_SOC_ADAU7118_HW is not set
> CONFIG_SND_SOC_ADAU7118_I2C=m
> CONFIG_SND_SOC_AK4104=m
> CONFIG_SND_SOC_AK4118=m
> CONFIG_SND_SOC_AK4375=m
> CONFIG_SND_SOC_AK4458=m
> CONFIG_SND_SOC_AK4554=m
> CONFIG_SND_SOC_AK4613=m
> # CONFIG_SND_SOC_AK4642 is not set
> # CONFIG_SND_SOC_AK5386 is not set
> # CONFIG_SND_SOC_AK5558 is not set
> CONFIG_SND_SOC_ALC5623=m
> CONFIG_SND_SOC_BD28623=m
> CONFIG_SND_SOC_BT_SCO=m
> CONFIG_SND_SOC_CROS_EC_CODEC=m
> # CONFIG_SND_SOC_CS35L32 is not set
> CONFIG_SND_SOC_CS35L33=m
> # CONFIG_SND_SOC_CS35L34 is not set
> CONFIG_SND_SOC_CS35L35=m
> CONFIG_SND_SOC_CS35L36=m
> CONFIG_SND_SOC_CS35L41_LIB=m
> CONFIG_SND_SOC_CS35L41=m
> CONFIG_SND_SOC_CS35L41_SPI=m
> # CONFIG_SND_SOC_CS35L41_I2C is not set
> CONFIG_SND_SOC_CS42L42=m
> CONFIG_SND_SOC_CS42L51=m
> CONFIG_SND_SOC_CS42L51_I2C=m
> CONFIG_SND_SOC_CS42L52=m
> # CONFIG_SND_SOC_CS42L56 is not set
> CONFIG_SND_SOC_CS42L73=m
> CONFIG_SND_SOC_CS4234=m
> CONFIG_SND_SOC_CS4265=m
> # CONFIG_SND_SOC_CS4270 is not set
> # CONFIG_SND_SOC_CS4271_I2C is not set
> # CONFIG_SND_SOC_CS4271_SPI is not set
> CONFIG_SND_SOC_CS42XX8=m
> CONFIG_SND_SOC_CS42XX8_I2C=m
> CONFIG_SND_SOC_CS43130=m
> # CONFIG_SND_SOC_CS4341 is not set
> # CONFIG_SND_SOC_CS4349 is not set
> CONFIG_SND_SOC_CS53L30=m
> CONFIG_SND_SOC_CX2072X=m
> # CONFIG_SND_SOC_DA7213 is not set
> # CONFIG_SND_SOC_DMIC is not set
> CONFIG_SND_SOC_HDMI_CODEC=m
> CONFIG_SND_SOC_ES7134=m
> CONFIG_SND_SOC_ES7241=m
> # CONFIG_SND_SOC_ES8316 is not set
> CONFIG_SND_SOC_ES8328=m
> CONFIG_SND_SOC_ES8328_I2C=m
> CONFIG_SND_SOC_ES8328_SPI=m
> CONFIG_SND_SOC_GTM601=m
> CONFIG_SND_SOC_ICS43432=m
> CONFIG_SND_SOC_INNO_RK3036=m
> CONFIG_SND_SOC_LOCHNAGAR_SC=m
> CONFIG_SND_SOC_MAX98088=m
> CONFIG_SND_SOC_MAX98357A=m
> CONFIG_SND_SOC_MAX98504=m
> # CONFIG_SND_SOC_MAX9867 is not set
> CONFIG_SND_SOC_MAX98927=m
> CONFIG_SND_SOC_MAX98520=m
> CONFIG_SND_SOC_MAX98373=m
> CONFIG_SND_SOC_MAX98373_I2C=m
> # CONFIG_SND_SOC_MAX98373_SDW is not set
> # CONFIG_SND_SOC_MAX98390 is not set
> # CONFIG_SND_SOC_MAX9860 is not set
> # CONFIG_SND_SOC_MSM8916_WCD_ANALOG is not set
> CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=m
> # CONFIG_SND_SOC_PCM1681 is not set
> CONFIG_SND_SOC_PCM1789=m
> CONFIG_SND_SOC_PCM1789_I2C=m
> CONFIG_SND_SOC_PCM179X=m
> CONFIG_SND_SOC_PCM179X_I2C=m
> CONFIG_SND_SOC_PCM179X_SPI=m
> CONFIG_SND_SOC_PCM186X=m
> CONFIG_SND_SOC_PCM186X_I2C=m
> CONFIG_SND_SOC_PCM186X_SPI=m
> CONFIG_SND_SOC_PCM3060=m
> # CONFIG_SND_SOC_PCM3060_I2C is not set
> CONFIG_SND_SOC_PCM3060_SPI=m
> CONFIG_SND_SOC_PCM3168A=m
> CONFIG_SND_SOC_PCM3168A_I2C=m
> CONFIG_SND_SOC_PCM3168A_SPI=m
> CONFIG_SND_SOC_PCM5102A=m
> CONFIG_SND_SOC_PCM512x=m
> CONFIG_SND_SOC_PCM512x_I2C=m
> # CONFIG_SND_SOC_PCM512x_SPI is not set
> # CONFIG_SND_SOC_RK3328 is not set
> CONFIG_SND_SOC_RL6231=m
> CONFIG_SND_SOC_RT1308_SDW=m
> CONFIG_SND_SOC_RT1316_SDW=m
> # CONFIG_SND_SOC_RT5616 is not set
> CONFIG_SND_SOC_RT5631=m
> CONFIG_SND_SOC_RT5640=m
> CONFIG_SND_SOC_RT5659=m
> # CONFIG_SND_SOC_RT5682_SDW is not set
> # CONFIG_SND_SOC_RT700_SDW is not set
> # CONFIG_SND_SOC_RT711_SDW is not set
> CONFIG_SND_SOC_RT711_SDCA_SDW=m
> CONFIG_SND_SOC_RT715=m
> CONFIG_SND_SOC_RT715_SDW=m
> CONFIG_SND_SOC_RT715_SDCA_SDW=m
> # CONFIG_SND_SOC_RT9120 is not set
> CONFIG_SND_SOC_SGTL5000=m
> CONFIG_SND_SOC_SI476X=m
> CONFIG_SND_SOC_SIGMADSP=m
> CONFIG_SND_SOC_SIGMADSP_I2C=m
> CONFIG_SND_SOC_SIGMADSP_REGMAP=m
> CONFIG_SND_SOC_SIMPLE_AMPLIFIER=m
> CONFIG_SND_SOC_SIMPLE_MUX=m
> CONFIG_SND_SOC_SPDIF=m
> # CONFIG_SND_SOC_SSM2305 is not set
> # CONFIG_SND_SOC_SSM2518 is not set
> CONFIG_SND_SOC_SSM2602=m
> # CONFIG_SND_SOC_SSM2602_SPI is not set
> CONFIG_SND_SOC_SSM2602_I2C=m
> # CONFIG_SND_SOC_SSM4567 is not set
> # CONFIG_SND_SOC_STA32X is not set
> CONFIG_SND_SOC_STA350=m
> # CONFIG_SND_SOC_STI_SAS is not set
> # CONFIG_SND_SOC_TAS2552 is not set
> CONFIG_SND_SOC_TAS2562=m
> CONFIG_SND_SOC_TAS2764=m
> # CONFIG_SND_SOC_TAS2770 is not set
> CONFIG_SND_SOC_TAS5086=m
> CONFIG_SND_SOC_TAS571X=m
> CONFIG_SND_SOC_TAS5720=m
> CONFIG_SND_SOC_TAS6424=m
> # CONFIG_SND_SOC_TDA7419 is not set
> # CONFIG_SND_SOC_TFA9879 is not set
> # CONFIG_SND_SOC_TFA989X is not set
> CONFIG_SND_SOC_TLV320ADC3XXX=m
> CONFIG_SND_SOC_TLV320AIC23=m
> CONFIG_SND_SOC_TLV320AIC23_I2C=m
> CONFIG_SND_SOC_TLV320AIC23_SPI=m
> CONFIG_SND_SOC_TLV320AIC31XX=m
> CONFIG_SND_SOC_TLV320AIC32X4=m
> CONFIG_SND_SOC_TLV320AIC32X4_I2C=m
> CONFIG_SND_SOC_TLV320AIC32X4_SPI=m
> CONFIG_SND_SOC_TLV320AIC3X=m
> CONFIG_SND_SOC_TLV320AIC3X_I2C=m
> CONFIG_SND_SOC_TLV320AIC3X_SPI=m
> CONFIG_SND_SOC_TLV320ADCX140=m
> CONFIG_SND_SOC_TS3A227E=m
> CONFIG_SND_SOC_TSCS42XX=m
> CONFIG_SND_SOC_TSCS454=m
> CONFIG_SND_SOC_UDA1334=m
> # CONFIG_SND_SOC_WCD9335 is not set
> CONFIG_SND_SOC_WCD_MBHC=m
> CONFIG_SND_SOC_WCD938X=m
> CONFIG_SND_SOC_WCD938X_SDW=m
> CONFIG_SND_SOC_WM8510=m
> CONFIG_SND_SOC_WM8523=m
> CONFIG_SND_SOC_WM8524=m
> CONFIG_SND_SOC_WM8580=m
> CONFIG_SND_SOC_WM8711=m
> CONFIG_SND_SOC_WM8728=m
> CONFIG_SND_SOC_WM8731=m
> CONFIG_SND_SOC_WM8737=m
> CONFIG_SND_SOC_WM8741=m
> CONFIG_SND_SOC_WM8750=m
> CONFIG_SND_SOC_WM8753=m
> # CONFIG_SND_SOC_WM8770 is not set
> # CONFIG_SND_SOC_WM8776 is not set
> CONFIG_SND_SOC_WM8782=m
> CONFIG_SND_SOC_WM8804=m
> CONFIG_SND_SOC_WM8804_I2C=m
> # CONFIG_SND_SOC_WM8804_SPI is not set
> CONFIG_SND_SOC_WM8903=m
> CONFIG_SND_SOC_WM8904=m
> CONFIG_SND_SOC_WM8960=m
> CONFIG_SND_SOC_WM8962=m
> CONFIG_SND_SOC_WM8974=m
> CONFIG_SND_SOC_WM8978=m
> CONFIG_SND_SOC_WM8985=m
> CONFIG_SND_SOC_WSA881X=m
> # CONFIG_SND_SOC_ZL38060 is not set
> CONFIG_SND_SOC_MAX9759=m
> CONFIG_SND_SOC_MT6351=m
> # CONFIG_SND_SOC_MT6358 is not set
> CONFIG_SND_SOC_MT6660=m
> CONFIG_SND_SOC_NAU8315=m
> CONFIG_SND_SOC_NAU8540=m
> CONFIG_SND_SOC_NAU8810=m
> # CONFIG_SND_SOC_NAU8821 is not set
> # CONFIG_SND_SOC_NAU8822 is not set
> CONFIG_SND_SOC_NAU8824=m
> # CONFIG_SND_SOC_TPA6130A2 is not set
> CONFIG_SND_SOC_LPASS_WSA_MACRO=m
> CONFIG_SND_SOC_LPASS_VA_MACRO=m
> CONFIG_SND_SOC_LPASS_RX_MACRO=m
> CONFIG_SND_SOC_LPASS_TX_MACRO=m
> # end of CODEC drivers
> 
> CONFIG_SND_SIMPLE_CARD_UTILS=m
> # CONFIG_SND_SIMPLE_CARD is not set
> CONFIG_SND_AUDIO_GRAPH_CARD=m
> # CONFIG_SND_AUDIO_GRAPH_CARD2 is not set
> # CONFIG_SND_TEST_COMPONENT is not set
> # CONFIG_SND_X86 is not set
> CONFIG_SND_VIRTIO=m
> CONFIG_AC97_BUS=m
> 
> #
> # HID support
> #
> CONFIG_HID=y
> # CONFIG_HID_BATTERY_STRENGTH is not set
> CONFIG_HIDRAW=y
> # CONFIG_UHID is not set
> CONFIG_HID_GENERIC=y
> 
> #
> # Special HID drivers
> #
> # CONFIG_HID_A4TECH is not set
> CONFIG_HID_ACCUTOUCH=m
> CONFIG_HID_ACRUX=m
> # CONFIG_HID_ACRUX_FF is not set
> CONFIG_HID_APPLE=y
> CONFIG_HID_APPLEIR=y
> CONFIG_HID_ASUS=m
> CONFIG_HID_AUREAL=y
> CONFIG_HID_BELKIN=m
> CONFIG_HID_BETOP_FF=y
> CONFIG_HID_BIGBEN_FF=m
> CONFIG_HID_CHERRY=m
> # CONFIG_HID_CHICONY is not set
> # CONFIG_HID_CORSAIR is not set
> # CONFIG_HID_COUGAR is not set
> CONFIG_HID_MACALLY=m
> CONFIG_HID_PRODIKEYS=m
> CONFIG_HID_CMEDIA=m
> # CONFIG_HID_CP2112 is not set
> CONFIG_HID_CREATIVE_SB0540=m
> # CONFIG_HID_CYPRESS is not set
> # CONFIG_HID_DRAGONRISE is not set
> # CONFIG_HID_EMS_FF is not set
> CONFIG_HID_ELAN=m
> # CONFIG_HID_ELECOM is not set
> # CONFIG_HID_ELO is not set
> CONFIG_HID_EZKEY=m
> CONFIG_HID_FT260=m
> CONFIG_HID_GEMBIRD=y
> # CONFIG_HID_GFRM is not set
> CONFIG_HID_GLORIOUS=y
> # CONFIG_HID_HOLTEK is not set
> CONFIG_HID_GOOGLE_HAMMER=m
> # CONFIG_HID_VIVALDI is not set
> CONFIG_HID_GT683R=y
> # CONFIG_HID_KEYTOUCH is not set
> CONFIG_HID_KYE=y
> # CONFIG_HID_UCLOGIC is not set
> CONFIG_HID_WALTOP=y
> CONFIG_HID_VIEWSONIC=m
> CONFIG_HID_XIAOMI=m
> # CONFIG_HID_GYRATION is not set
> # CONFIG_HID_ICADE is not set
> CONFIG_HID_ITE=y
> # CONFIG_HID_JABRA is not set
> # CONFIG_HID_TWINHAN is not set
> CONFIG_HID_KENSINGTON=m
> CONFIG_HID_LCPOWER=y
> CONFIG_HID_LED=y
> # CONFIG_HID_LENOVO is not set
> CONFIG_HID_LETSKETCH=y
> CONFIG_HID_LOGITECH=m
> CONFIG_HID_LOGITECH_DJ=m
> CONFIG_HID_LOGITECH_HIDPP=m
> # CONFIG_LOGITECH_FF is not set
> CONFIG_LOGIRUMBLEPAD2_FF=y
> # CONFIG_LOGIG940_FF is not set
> CONFIG_LOGIWHEELS_FF=y
> CONFIG_HID_MAGICMOUSE=m
> # CONFIG_HID_MALTRON is not set
> CONFIG_HID_MAYFLASH=m
> CONFIG_HID_REDRAGON=m
> CONFIG_HID_MICROSOFT=m
> CONFIG_HID_MONTEREY=m
> CONFIG_HID_MULTITOUCH=m
> CONFIG_HID_NINTENDO=y
> # CONFIG_NINTENDO_FF is not set
> CONFIG_HID_NTI=m
> CONFIG_HID_NTRIG=m
> CONFIG_HID_ORTEK=y
> CONFIG_HID_PANTHERLORD=y
> # CONFIG_PANTHERLORD_FF is not set
> CONFIG_HID_PENMOUNT=y
> # CONFIG_HID_PETALYNX is not set
> CONFIG_HID_PICOLCD=m
> CONFIG_HID_PICOLCD_BACKLIGHT=y
> CONFIG_HID_PICOLCD_LEDS=y
> CONFIG_HID_PICOLCD_CIR=y
> CONFIG_HID_PLANTRONICS=m
> CONFIG_HID_PLAYSTATION=y
> CONFIG_PLAYSTATION_FF=y
> CONFIG_HID_PRIMAX=m
> # CONFIG_HID_RETRODE is not set
> CONFIG_HID_ROCCAT=y
> CONFIG_HID_SAITEK=y
> # CONFIG_HID_SAMSUNG is not set
> CONFIG_HID_SEMITEK=m
> CONFIG_HID_SONY=y
> # CONFIG_SONY_FF is not set
> CONFIG_HID_SPEEDLINK=y
> CONFIG_HID_STEAM=y
> CONFIG_HID_STEELSERIES=y
> CONFIG_HID_SUNPLUS=m
> CONFIG_HID_RMI=y
> # CONFIG_HID_GREENASIA is not set
> CONFIG_HID_SMARTJOYPLUS=y
> CONFIG_SMARTJOYPLUS_FF=y
> CONFIG_HID_TIVO=m
> CONFIG_HID_TOPSEED=m
> CONFIG_HID_THINGM=y
> CONFIG_HID_THRUSTMASTER=y
> CONFIG_THRUSTMASTER_FF=y
> CONFIG_HID_UDRAW_PS3=y
> # CONFIG_HID_U2FZERO is not set
> CONFIG_HID_WACOM=m
> CONFIG_HID_WIIMOTE=m
> # CONFIG_HID_XINMO is not set
> CONFIG_HID_ZEROPLUS=m
> # CONFIG_ZEROPLUS_FF is not set
> # CONFIG_HID_ZYDACRON is not set
> CONFIG_HID_SENSOR_HUB=y
> CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
> # CONFIG_HID_ALPS is not set
> CONFIG_HID_MCP2221=m
> # end of Special HID drivers
> 
> #
> # USB HID support
> #
> CONFIG_USB_HID=y
> CONFIG_HID_PID=y
> # CONFIG_USB_HIDDEV is not set
> # end of USB HID support
> 
> #
> # I2C HID support
> #
> CONFIG_I2C_HID_ACPI=m
> # CONFIG_I2C_HID_OF is not set
> CONFIG_I2C_HID_OF_GOODIX=m
> # end of I2C HID support
> 
> CONFIG_I2C_HID_CORE=m
> # end of HID support
> 
> CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> CONFIG_USB_SUPPORT=y
> CONFIG_USB_COMMON=y
> # CONFIG_USB_LED_TRIG is not set
> CONFIG_USB_ULPI_BUS=m
> CONFIG_USB_CONN_GPIO=m
> CONFIG_USB_ARCH_HAS_HCD=y
> CONFIG_USB=y
> CONFIG_USB_PCI=y
> # CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set
> 
> #
> # Miscellaneous USB options
> #
> CONFIG_USB_DEFAULT_PERSIST=y
> CONFIG_USB_FEW_INIT_RETRIES=y
> # CONFIG_USB_DYNAMIC_MINORS is not set
> # CONFIG_USB_OTG is not set
> # CONFIG_USB_OTG_PRODUCTLIST is not set
> # CONFIG_USB_LEDS_TRIGGER_USBPORT is not set
> CONFIG_USB_AUTOSUSPEND_DELAY=2
> CONFIG_USB_MON=m
> 
> #
> # USB Host Controller Drivers
> #
> CONFIG_USB_C67X00_HCD=y
> CONFIG_USB_XHCI_HCD=m
> # CONFIG_USB_XHCI_DBGCAP is not set
> CONFIG_USB_XHCI_PCI=m
> CONFIG_USB_XHCI_PCI_RENESAS=m
> CONFIG_USB_XHCI_PLATFORM=m
> CONFIG_USB_EHCI_HCD=m
> # CONFIG_USB_EHCI_ROOT_HUB_TT is not set
> # CONFIG_USB_EHCI_TT_NEWSCHED is not set
> CONFIG_USB_EHCI_PCI=m
> # CONFIG_USB_EHCI_FSL is not set
> CONFIG_USB_EHCI_HCD_PLATFORM=m
> # CONFIG_USB_OXU210HP_HCD is not set
> CONFIG_USB_ISP116X_HCD=m
> CONFIG_USB_FOTG210_HCD=m
> # CONFIG_USB_MAX3421_HCD is not set
> CONFIG_USB_OHCI_HCD=y
> CONFIG_USB_OHCI_HCD_PCI=y
> # CONFIG_USB_OHCI_HCD_SSB is not set
> CONFIG_USB_OHCI_HCD_PLATFORM=y
> # CONFIG_USB_UHCI_HCD is not set
> CONFIG_USB_U132_HCD=m
> CONFIG_USB_SL811_HCD=m
> # CONFIG_USB_SL811_HCD_ISO is not set
> # CONFIG_USB_R8A66597_HCD is not set
> # CONFIG_USB_HCD_BCMA is not set
> CONFIG_USB_HCD_SSB=m
> # CONFIG_USB_HCD_TEST_MODE is not set
> 
> #
> # USB Device Class drivers
> #
> CONFIG_USB_ACM=y
> CONFIG_USB_PRINTER=m
> CONFIG_USB_WDM=y
> CONFIG_USB_TMC=y
> 
> #
> # NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
> #
> 
> #
> # also be needed; see USB_STORAGE Help for more info
> #
> # CONFIG_USB_STORAGE is not set
> 
> #
> # USB Imaging devices
> #
> CONFIG_USB_MDC800=y
> CONFIG_USB_MICROTEK=y
> CONFIG_USBIP_CORE=m
> # CONFIG_USBIP_VHCI_HCD is not set
> # CONFIG_USBIP_HOST is not set
> CONFIG_USBIP_VUDC=m
> CONFIG_USBIP_DEBUG=y
> CONFIG_USB_CDNS_SUPPORT=m
> CONFIG_USB_CDNS3=m
> # CONFIG_USB_CDNS3_GADGET is not set
> # CONFIG_USB_CDNS3_HOST is not set
> CONFIG_USB_CDNS3_PCI_WRAP=m
> # CONFIG_USB_CDNSP_PCI is not set
> CONFIG_USB_MUSB_HDRC=y
> CONFIG_USB_MUSB_HOST=y
> # CONFIG_USB_MUSB_GADGET is not set
> # CONFIG_USB_MUSB_DUAL_ROLE is not set
> 
> #
> # Platform Glue Layer
> #
> 
> #
> # MUSB DMA mode
> #
> CONFIG_MUSB_PIO_ONLY=y
> CONFIG_USB_DWC3=m
> # CONFIG_USB_DWC3_ULPI is not set
> # CONFIG_USB_DWC3_HOST is not set
> # CONFIG_USB_DWC3_GADGET is not set
> CONFIG_USB_DWC3_DUAL_ROLE=y
> 
> #
> # Platform Glue Driver Support
> #
> CONFIG_USB_DWC3_PCI=m
> CONFIG_USB_DWC3_HAPS=m
> # CONFIG_USB_DWC3_OF_SIMPLE is not set
> CONFIG_USB_DWC2=m
> # CONFIG_USB_DWC2_HOST is not set
> 
> #
> # Gadget/Dual-role mode requires USB Gadget support to be enabled
> #
> CONFIG_USB_DWC2_PERIPHERAL=y
> # CONFIG_USB_DWC2_DUAL_ROLE is not set
> # CONFIG_USB_DWC2_PCI is not set
> # CONFIG_USB_DWC2_DEBUG is not set
> # CONFIG_USB_DWC2_TRACK_MISSED_SOFS is not set
> CONFIG_USB_CHIPIDEA=m
> # CONFIG_USB_CHIPIDEA_UDC is not set
> # CONFIG_USB_CHIPIDEA_HOST is not set
> CONFIG_USB_CHIPIDEA_PCI=m
> CONFIG_USB_CHIPIDEA_MSM=m
> CONFIG_USB_CHIPIDEA_IMX=m
> CONFIG_USB_CHIPIDEA_GENERIC=m
> CONFIG_USB_CHIPIDEA_TEGRA=m
> CONFIG_USB_ISP1760=m
> CONFIG_USB_ISP1760_HCD=y
> CONFIG_USB_ISP1760_HOST_ROLE=y
> # CONFIG_USB_ISP1760_GADGET_ROLE is not set
> # CONFIG_USB_ISP1760_DUAL_ROLE is not set
> 
> #
> # USB port drivers
> #
> CONFIG_USB_SERIAL=y
> # CONFIG_USB_SERIAL_CONSOLE is not set
> # CONFIG_USB_SERIAL_GENERIC is not set
> CONFIG_USB_SERIAL_SIMPLE=y
> CONFIG_USB_SERIAL_AIRCABLE=m
> CONFIG_USB_SERIAL_ARK3116=m
> CONFIG_USB_SERIAL_BELKIN=m
> CONFIG_USB_SERIAL_CH341=y
> CONFIG_USB_SERIAL_WHITEHEAT=y
> CONFIG_USB_SERIAL_DIGI_ACCELEPORT=y
> CONFIG_USB_SERIAL_CP210X=m
> CONFIG_USB_SERIAL_CYPRESS_M8=y
> CONFIG_USB_SERIAL_EMPEG=m
> CONFIG_USB_SERIAL_FTDI_SIO=m
> CONFIG_USB_SERIAL_VISOR=y
> # CONFIG_USB_SERIAL_IPAQ is not set
> CONFIG_USB_SERIAL_IR=y
> # CONFIG_USB_SERIAL_EDGEPORT is not set
> # CONFIG_USB_SERIAL_EDGEPORT_TI is not set
> CONFIG_USB_SERIAL_F81232=y
> CONFIG_USB_SERIAL_F8153X=m
> CONFIG_USB_SERIAL_GARMIN=m
> CONFIG_USB_SERIAL_IPW=m
> # CONFIG_USB_SERIAL_IUU is not set
> CONFIG_USB_SERIAL_KEYSPAN_PDA=y
> CONFIG_USB_SERIAL_KEYSPAN=m
> CONFIG_USB_SERIAL_KLSI=y
> # CONFIG_USB_SERIAL_KOBIL_SCT is not set
> CONFIG_USB_SERIAL_MCT_U232=m
> CONFIG_USB_SERIAL_METRO=m
> CONFIG_USB_SERIAL_MOS7720=y
> CONFIG_USB_SERIAL_MOS7840=m
> # CONFIG_USB_SERIAL_MXUPORT is not set
> CONFIG_USB_SERIAL_NAVMAN=y
> # CONFIG_USB_SERIAL_PL2303 is not set
> CONFIG_USB_SERIAL_OTI6858=y
> CONFIG_USB_SERIAL_QCAUX=m
> # CONFIG_USB_SERIAL_QUALCOMM is not set
> CONFIG_USB_SERIAL_SPCP8X5=y
> # CONFIG_USB_SERIAL_SAFE is not set
> # CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
> CONFIG_USB_SERIAL_SYMBOL=y
> CONFIG_USB_SERIAL_TI=m
> CONFIG_USB_SERIAL_CYBERJACK=m
> CONFIG_USB_SERIAL_WWAN=y
> CONFIG_USB_SERIAL_OPTION=y
> CONFIG_USB_SERIAL_OMNINET=y
> CONFIG_USB_SERIAL_OPTICON=y
> CONFIG_USB_SERIAL_XSENS_MT=m
> # CONFIG_USB_SERIAL_WISHBONE is not set
> CONFIG_USB_SERIAL_SSU100=m
> # CONFIG_USB_SERIAL_QT2 is not set
> CONFIG_USB_SERIAL_UPD78F0730=y
> # CONFIG_USB_SERIAL_XR is not set
> CONFIG_USB_SERIAL_DEBUG=y
> 
> #
> # USB Miscellaneous drivers
> #
> CONFIG_USB_EMI62=y
> CONFIG_USB_EMI26=y
> CONFIG_USB_ADUTUX=m
> CONFIG_USB_SEVSEG=m
> CONFIG_USB_LEGOTOWER=m
> CONFIG_USB_LCD=y
> # CONFIG_USB_CYPRESS_CY7C63 is not set
> CONFIG_USB_CYTHERM=m
> CONFIG_USB_IDMOUSE=m
> CONFIG_USB_FTDI_ELAN=m
> CONFIG_USB_APPLEDISPLAY=y
> # CONFIG_APPLE_MFI_FASTCHARGE is not set
> # CONFIG_USB_SISUSBVGA is not set
> CONFIG_USB_LD=m
> CONFIG_USB_TRANCEVIBRATOR=y
> CONFIG_USB_IOWARRIOR=y
> # CONFIG_USB_TEST is not set
> # CONFIG_USB_EHSET_TEST_FIXTURE is not set
> CONFIG_USB_ISIGHTFW=y
> CONFIG_USB_YUREX=m
> CONFIG_USB_EZUSB_FX2=y
> CONFIG_USB_HUB_USB251XB=m
> CONFIG_USB_HSIC_USB3503=m
> # CONFIG_USB_HSIC_USB4604 is not set
> # CONFIG_USB_LINK_LAYER_TEST is not set
> CONFIG_USB_CHAOSKEY=y
> CONFIG_USB_ATM=y
> # CONFIG_USB_SPEEDTOUCH is not set
> CONFIG_USB_CXACRU=y
> CONFIG_USB_UEAGLEATM=y
> CONFIG_USB_XUSBATM=y
> 
> #
> # USB Physical Layer drivers
> #
> CONFIG_USB_PHY=y
> CONFIG_NOP_USB_XCEIV=m
> CONFIG_USB_GPIO_VBUS=m
> CONFIG_TAHVO_USB=m
> # CONFIG_TAHVO_USB_HOST_BY_DEFAULT is not set
> CONFIG_USB_ISP1301=m
> # end of USB Physical Layer drivers
> 
> CONFIG_USB_GADGET=y
> # CONFIG_USB_GADGET_DEBUG is not set
> CONFIG_USB_GADGET_DEBUG_FILES=y
> CONFIG_USB_GADGET_DEBUG_FS=y
> CONFIG_USB_GADGET_VBUS_DRAW=2
> CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2
> # CONFIG_U_SERIAL_CONSOLE is not set
> 
> #
> # USB Peripheral Controller
> #
> CONFIG_USB_FUSB300=y
> # CONFIG_USB_FOTG210_UDC is not set
> CONFIG_USB_GR_UDC=m
> CONFIG_USB_R8A66597=m
> CONFIG_USB_PXA27X=m
> CONFIG_USB_MV_UDC=y
> # CONFIG_USB_MV_U3D is not set
> CONFIG_USB_SNP_CORE=m
> CONFIG_USB_SNP_UDC_PLAT=m
> # CONFIG_USB_M66592 is not set
> # CONFIG_USB_BDC_UDC is not set
> # CONFIG_USB_AMD5536UDC is not set
> # CONFIG_USB_NET2272 is not set
> # CONFIG_USB_NET2280 is not set
> # CONFIG_USB_GOKU is not set
> # CONFIG_USB_EG20T is not set
> CONFIG_USB_GADGET_XILINX=y
> # CONFIG_USB_MAX3420_UDC is not set
> CONFIG_USB_DUMMY_HCD=y
> # end of USB Peripheral Controller
> 
> CONFIG_USB_LIBCOMPOSITE=y
> CONFIG_USB_F_ACM=y
> CONFIG_USB_U_SERIAL=y
> CONFIG_USB_U_ETHER=y
> CONFIG_USB_F_SERIAL=y
> CONFIG_USB_F_OBEX=y
> CONFIG_USB_F_NCM=y
> CONFIG_USB_F_ECM=y
> CONFIG_USB_F_EEM=y
> CONFIG_USB_F_SUBSET=y
> CONFIG_USB_F_RNDIS=m
> CONFIG_USB_F_MASS_STORAGE=m
> CONFIG_USB_F_MIDI=m
> CONFIG_USB_F_HID=y
> CONFIG_USB_F_PRINTER=m
> # CONFIG_USB_CONFIGFS is not set
> 
> #
> # USB Gadget precomposed configurations
> #
> # CONFIG_USB_ZERO is not set
> # CONFIG_USB_AUDIO is not set
> CONFIG_USB_ETH=y
> # CONFIG_USB_ETH_RNDIS is not set
> CONFIG_USB_ETH_EEM=y
> CONFIG_USB_G_NCM=y
> CONFIG_USB_GADGETFS=y
> # CONFIG_USB_FUNCTIONFS is not set
> # CONFIG_USB_MASS_STORAGE is not set
> CONFIG_USB_G_SERIAL=y
> CONFIG_USB_MIDI_GADGET=m
> CONFIG_USB_G_PRINTER=m
> # CONFIG_USB_CDC_COMPOSITE is not set
> # CONFIG_USB_G_ACM_MS is not set
> CONFIG_USB_G_MULTI=m
> CONFIG_USB_G_MULTI_RNDIS=y
> # CONFIG_USB_G_MULTI_CDC is not set
> CONFIG_USB_G_HID=y
> CONFIG_USB_G_DBGP=m
> # CONFIG_USB_G_DBGP_PRINTK is not set
> CONFIG_USB_G_DBGP_SERIAL=y
> # CONFIG_USB_G_WEBCAM is not set
> # CONFIG_USB_RAW_GADGET is not set
> # end of USB Gadget precomposed configurations
> 
> CONFIG_TYPEC=y
> CONFIG_TYPEC_TCPM=y
> # CONFIG_TYPEC_TCPCI is not set
> # CONFIG_TYPEC_FUSB302 is not set
> CONFIG_TYPEC_UCSI=y
> CONFIG_UCSI_CCG=y
> # CONFIG_UCSI_ACPI is not set
> # CONFIG_TYPEC_TPS6598X is not set
> CONFIG_TYPEC_HD3SS3220=m
> CONFIG_TYPEC_STUSB160X=y
> 
> #
> # USB Type-C Multiplexer/DeMultiplexer Switch support
> #
> # CONFIG_TYPEC_MUX_PI3USB30532 is not set
> # end of USB Type-C Multiplexer/DeMultiplexer Switch support
> 
> #
> # USB Type-C Alternate Mode drivers
> #
> CONFIG_TYPEC_DP_ALTMODE=m
> # CONFIG_TYPEC_NVIDIA_ALTMODE is not set
> # end of USB Type-C Alternate Mode drivers
> 
> CONFIG_USB_ROLE_SWITCH=y
> CONFIG_USB_ROLES_INTEL_XHCI=y
> CONFIG_MMC=m
> CONFIG_PWRSEQ_EMMC=m
> CONFIG_PWRSEQ_SIMPLE=m
> CONFIG_MMC_BLOCK=m
> CONFIG_MMC_BLOCK_MINORS=8
> CONFIG_SDIO_UART=m
> # CONFIG_MMC_TEST is not set
> 
> #
> # MMC/SD/SDIO Host Controller Drivers
> #
> CONFIG_MMC_DEBUG=y
> # CONFIG_MMC_SDHCI is not set
> CONFIG_MMC_WBSD=m
> # CONFIG_MMC_TIFM_SD is not set
> CONFIG_MMC_SPI=m
> # CONFIG_MMC_CB710 is not set
> # CONFIG_MMC_VIA_SDMMC is not set
> CONFIG_MMC_VUB300=m
> # CONFIG_MMC_USHC is not set
> CONFIG_MMC_USDHI6ROL0=m
> CONFIG_MMC_CQHCI=m
> CONFIG_MMC_HSQ=m
> # CONFIG_MMC_TOSHIBA_PCI is not set
> CONFIG_MMC_MTK=m
> CONFIG_MEMSTICK=y
> # CONFIG_MEMSTICK_DEBUG is not set
> 
> #
> # MemoryStick drivers
> #
> # CONFIG_MEMSTICK_UNSAFE_RESUME is not set
> CONFIG_MSPRO_BLOCK=y
> CONFIG_MS_BLOCK=y
> 
> #
> # MemoryStick Host Controller Drivers
> #
> # CONFIG_MEMSTICK_TIFM_MS is not set
> # CONFIG_MEMSTICK_JMICRON_38X is not set
> # CONFIG_MEMSTICK_R592 is not set
> CONFIG_NEW_LEDS=y
> CONFIG_LEDS_CLASS=y
> CONFIG_LEDS_CLASS_FLASH=y
> CONFIG_LEDS_CLASS_MULTICOLOR=y
> # CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set
> 
> #
> # LED drivers
> #
> # CONFIG_LEDS_AN30259A is not set
> CONFIG_LEDS_APU=y
> # CONFIG_LEDS_AW2013 is not set
> # CONFIG_LEDS_BCM6328 is not set
> CONFIG_LEDS_BCM6358=m
> # CONFIG_LEDS_CR0014114 is not set
> CONFIG_LEDS_EL15203000=y
> CONFIG_LEDS_LM3530=m
> CONFIG_LEDS_LM3532=y
> # CONFIG_LEDS_LM3533 is not set
> CONFIG_LEDS_LM3642=m
> CONFIG_LEDS_LM3692X=m
> CONFIG_LEDS_MT6323=m
> CONFIG_LEDS_NET48XX=m
> CONFIG_LEDS_WRAP=m
> CONFIG_LEDS_PCA9532=m
> CONFIG_LEDS_PCA9532_GPIO=y
> # CONFIG_LEDS_GPIO is not set
> CONFIG_LEDS_LP3944=y
> CONFIG_LEDS_LP3952=m
> CONFIG_LEDS_LP50XX=y
> CONFIG_LEDS_LP55XX_COMMON=m
> CONFIG_LEDS_LP5521=m
> # CONFIG_LEDS_LP5523 is not set
> # CONFIG_LEDS_LP5562 is not set
> CONFIG_LEDS_LP8501=m
> CONFIG_LEDS_LP8860=y
> CONFIG_LEDS_CLEVO_MAIL=m
> CONFIG_LEDS_PCA955X=y
> # CONFIG_LEDS_PCA955X_GPIO is not set
> # CONFIG_LEDS_PCA963X is not set
> CONFIG_LEDS_WM831X_STATUS=y
> # CONFIG_LEDS_DA9052 is not set
> CONFIG_LEDS_DAC124S085=m
> # CONFIG_LEDS_REGULATOR is not set
> CONFIG_LEDS_BD2802=y
> # CONFIG_LEDS_INTEL_SS4200 is not set
> CONFIG_LEDS_LT3593=y
> CONFIG_LEDS_MC13783=y
> CONFIG_LEDS_TCA6507=y
> # CONFIG_LEDS_TLC591XX is not set
> CONFIG_LEDS_LM355x=y
> # CONFIG_LEDS_OT200 is not set
> CONFIG_LEDS_MENF21BMC=m
> CONFIG_LEDS_IS31FL319X=y
> CONFIG_LEDS_IS31FL32XX=m
> 
> #
> # LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
> #
> CONFIG_LEDS_BLINKM=y
> # CONFIG_LEDS_SYSCON is not set
> CONFIG_LEDS_MLXCPLD=y
> # CONFIG_LEDS_MLXREG is not set
> CONFIG_LEDS_USER=m
> CONFIG_LEDS_NIC78BX=m
> CONFIG_LEDS_SPI_BYTE=m
> CONFIG_LEDS_TI_LMU_COMMON=m
> CONFIG_LEDS_LM3697=m
> CONFIG_LEDS_LM36274=m
> CONFIG_LEDS_LGM=y
> 
> #
> # Flash and Torch LED drivers
> #
> CONFIG_LEDS_AAT1290=m
> # CONFIG_LEDS_AS3645A is not set
> CONFIG_LEDS_KTD2692=m
> CONFIG_LEDS_LM3601X=m
> CONFIG_LEDS_RT4505=m
> # CONFIG_LEDS_RT8515 is not set
> CONFIG_LEDS_SGM3140=m
> 
> #
> # LED Triggers
> #
> CONFIG_LEDS_TRIGGERS=y
> CONFIG_LEDS_TRIGGER_TIMER=m
> CONFIG_LEDS_TRIGGER_ONESHOT=m
> CONFIG_LEDS_TRIGGER_DISK=y
> CONFIG_LEDS_TRIGGER_MTD=y
> # CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
> CONFIG_LEDS_TRIGGER_BACKLIGHT=m
> # CONFIG_LEDS_TRIGGER_CPU is not set
> # CONFIG_LEDS_TRIGGER_ACTIVITY is not set
> CONFIG_LEDS_TRIGGER_GPIO=y
> # CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set
> 
> #
> # iptables trigger is under Netfilter config (LED target)
> #
> # CONFIG_LEDS_TRIGGER_TRANSIENT is not set
> # CONFIG_LEDS_TRIGGER_CAMERA is not set
> # CONFIG_LEDS_TRIGGER_PANIC is not set
> CONFIG_LEDS_TRIGGER_NETDEV=y
> CONFIG_LEDS_TRIGGER_PATTERN=m
> CONFIG_LEDS_TRIGGER_AUDIO=m
> CONFIG_LEDS_TRIGGER_TTY=y
> 
> #
> # Simple LED drivers
> #
> # CONFIG_ACCESSIBILITY is not set
> # CONFIG_INFINIBAND is not set
> CONFIG_EDAC_ATOMIC_SCRUB=y
> CONFIG_EDAC_SUPPORT=y
> CONFIG_EDAC=m
> CONFIG_EDAC_LEGACY_SYSFS=y
> CONFIG_EDAC_DEBUG=y
> # CONFIG_EDAC_AMD76X is not set
> # CONFIG_EDAC_E7XXX is not set
> # CONFIG_EDAC_E752X is not set
> # CONFIG_EDAC_I82875P is not set
> # CONFIG_EDAC_I82975X is not set
> # CONFIG_EDAC_I3000 is not set
> # CONFIG_EDAC_I3200 is not set
> # CONFIG_EDAC_IE31200 is not set
> # CONFIG_EDAC_X38 is not set
> # CONFIG_EDAC_I5400 is not set
> # CONFIG_EDAC_I82860 is not set
> # CONFIG_EDAC_R82600 is not set
> # CONFIG_EDAC_I5000 is not set
> # CONFIG_EDAC_I5100 is not set
> # CONFIG_EDAC_I7300 is not set
> CONFIG_RTC_LIB=y
> CONFIG_RTC_MC146818_LIB=y
> # CONFIG_RTC_CLASS is not set
> # CONFIG_DMADEVICES is not set
> 
> #
> # DMABUF options
> #
> CONFIG_SYNC_FILE=y
> # CONFIG_SW_SYNC is not set
> # CONFIG_UDMABUF is not set
> # CONFIG_DMABUF_MOVE_NOTIFY is not set
> CONFIG_DMABUF_DEBUG=y
> # CONFIG_DMABUF_SELFTESTS is not set
> # CONFIG_DMABUF_HEAPS is not set
> CONFIG_DMABUF_SYSFS_STATS=y
> # end of DMABUF options
> 
> # CONFIG_AUXDISPLAY is not set
> CONFIG_UIO=m
> # CONFIG_UIO_CIF is not set
> CONFIG_UIO_PDRV_GENIRQ=m
> CONFIG_UIO_DMEM_GENIRQ=m
> # CONFIG_UIO_AEC is not set
> # CONFIG_UIO_SERCOS3 is not set
> # CONFIG_UIO_PCI_GENERIC is not set
> # CONFIG_UIO_NETX is not set
> CONFIG_UIO_PRUSS=m
> # CONFIG_UIO_MF624 is not set
> CONFIG_UIO_DFL=m
> # CONFIG_VFIO is not set
> CONFIG_IRQ_BYPASS_MANAGER=m
> # CONFIG_VIRT_DRIVERS is not set
> CONFIG_VIRTIO=y
> CONFIG_VIRTIO_MENU=y
> # CONFIG_VIRTIO_PCI is not set
> CONFIG_VIRTIO_VDPA=m
> CONFIG_VIRTIO_BALLOON=m
> CONFIG_VIRTIO_INPUT=m
> CONFIG_VIRTIO_MMIO=y
> # CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES is not set
> CONFIG_VDPA=m
> CONFIG_VDPA_USER=m
> CONFIG_VHOST_IOTLB=y
> CONFIG_VHOST=y
> CONFIG_VHOST_MENU=y
> CONFIG_VHOST_NET=m
> CONFIG_VHOST_VSOCK=y
> CONFIG_VHOST_VDPA=m
> CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y
> 
> #
> # Microsoft Hyper-V guest support
> #
> # end of Microsoft Hyper-V guest support
> 
> CONFIG_GREYBUS=y
> CONFIG_GREYBUS_ES2=m
> # CONFIG_COMEDI is not set
> # CONFIG_STAGING is not set
> # CONFIG_X86_PLATFORM_DEVICES is not set
> CONFIG_PMC_ATOM=y
> CONFIG_CHROME_PLATFORMS=y
> CONFIG_CHROMEOS_LAPTOP=y
> # CONFIG_CHROMEOS_PSTORE is not set
> CONFIG_CHROMEOS_TBMC=y
> CONFIG_CROS_EC=y
> CONFIG_CROS_EC_I2C=y
> CONFIG_CROS_EC_RPMSG=m
> # CONFIG_CROS_EC_SPI is not set
> CONFIG_CROS_EC_LPC=m
> CONFIG_CROS_EC_PROTO=y
> CONFIG_CROS_KBD_LED_BACKLIGHT=m
> # CONFIG_CROS_EC_CHARDEV is not set
> # CONFIG_CROS_EC_LIGHTBAR is not set
> CONFIG_CROS_EC_VBC=m
> # CONFIG_CROS_EC_DEBUGFS is not set
> CONFIG_CROS_EC_SENSORHUB=m
> CONFIG_CROS_EC_SYSFS=m
> # CONFIG_CROS_USBPD_NOTIFY is not set
> CONFIG_WILCO_EC=m
> # CONFIG_WILCO_EC_DEBUGFS is not set
> CONFIG_WILCO_EC_EVENTS=m
> CONFIG_WILCO_EC_TELEMETRY=m
> # CONFIG_MELLANOX_PLATFORM is not set
> CONFIG_OLPC_EC=y
> # CONFIG_SURFACE_PLATFORMS is not set
> CONFIG_HAVE_CLK=y
> CONFIG_HAVE_CLK_PREPARE=y
> CONFIG_COMMON_CLK=y
> # CONFIG_COMMON_CLK_WM831X is not set
> CONFIG_LMK04832=y
> # CONFIG_COMMON_CLK_MAX77686 is not set
> # CONFIG_COMMON_CLK_MAX9485 is not set
> CONFIG_COMMON_CLK_SI5341=y
> CONFIG_COMMON_CLK_SI5351=m
> CONFIG_COMMON_CLK_SI514=m
> CONFIG_COMMON_CLK_SI544=m
> CONFIG_COMMON_CLK_SI570=m
> # CONFIG_COMMON_CLK_CDCE706 is not set
> # CONFIG_COMMON_CLK_CDCE925 is not set
> CONFIG_COMMON_CLK_CS2000_CP=y
> # CONFIG_COMMON_CLK_LAN966X is not set
> CONFIG_CLK_TWL6040=m
> CONFIG_COMMON_CLK_AXI_CLKGEN=y
> CONFIG_COMMON_CLK_LOCHNAGAR=m
> # CONFIG_COMMON_CLK_VC5 is not set
> CONFIG_COMMON_CLK_FIXED_MMIO=y
> CONFIG_CLK_LGM_CGU=y
> # CONFIG_XILINX_VCU is not set
> # CONFIG_HWSPINLOCK is not set
> 
> #
> # Clock Source drivers
> #
> CONFIG_CLKSRC_I8253=y
> CONFIG_CLKEVT_I8253=y
> CONFIG_I8253_LOCK=y
> CONFIG_CLKBLD_I8253=y
> # CONFIG_MICROCHIP_PIT64B is not set
> # end of Clock Source drivers
> 
> # CONFIG_MAILBOX is not set
> CONFIG_IOMMU_IOVA=m
> CONFIG_IOMMU_SUPPORT=y
> 
> #
> # Generic IOMMU Pagetable Support
> #
> # end of Generic IOMMU Pagetable Support
> 
> # CONFIG_IOMMU_DEBUGFS is not set
> # CONFIG_VIRTIO_IOMMU is not set
> 
> #
> # Remoteproc drivers
> #
> CONFIG_REMOTEPROC=y
> CONFIG_REMOTEPROC_CDEV=y
> # end of Remoteproc drivers
> 
> #
> # Rpmsg drivers
> #
> CONFIG_RPMSG=m
> CONFIG_RPMSG_CHAR=m
> CONFIG_RPMSG_NS=m
> CONFIG_RPMSG_VIRTIO=m
> # end of Rpmsg drivers
> 
> CONFIG_SOUNDWIRE=m
> 
> #
> # SoundWire Devices
> #
> # CONFIG_SOUNDWIRE_INTEL is not set
> # CONFIG_SOUNDWIRE_QCOM is not set
> 
> #
> # SOC (System On Chip) specific Drivers
> #
> 
> #
> # Amlogic SoC drivers
> #
> # end of Amlogic SoC drivers
> 
> #
> # Broadcom SoC drivers
> #
> # end of Broadcom SoC drivers
> 
> #
> # NXP/Freescale QorIQ SoC drivers
> #
> # end of NXP/Freescale QorIQ SoC drivers
> 
> #
> # i.MX SoC drivers
> #
> # end of i.MX SoC drivers
> 
> #
> # Enable LiteX SoC Builder specific drivers
> #
> # CONFIG_LITEX_SOC_CONTROLLER is not set
> # end of Enable LiteX SoC Builder specific drivers
> 
> #
> # Qualcomm SoC drivers
> #
> # end of Qualcomm SoC drivers
> 
> CONFIG_SOC_TI=y
> 
> #
> # Xilinx SoC drivers
> #
> # end of Xilinx SoC drivers
> # end of SOC (System On Chip) specific Drivers
> 
> CONFIG_PM_DEVFREQ=y
> 
> #
> # DEVFREQ Governors
> #
> CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
> # CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
> CONFIG_DEVFREQ_GOV_POWERSAVE=y
> # CONFIG_DEVFREQ_GOV_USERSPACE is not set
> CONFIG_DEVFREQ_GOV_PASSIVE=y
> 
> #
> # DEVFREQ Drivers
> #
> CONFIG_PM_DEVFREQ_EVENT=y
> CONFIG_EXTCON=y
> 
> #
> # Extcon Device Drivers
> #
> # CONFIG_EXTCON_ADC_JACK is not set
> # CONFIG_EXTCON_FSA9480 is not set
> CONFIG_EXTCON_GPIO=y
> CONFIG_EXTCON_INTEL_INT3496=m
> CONFIG_EXTCON_MAX14577=m
> CONFIG_EXTCON_MAX3355=m
> # CONFIG_EXTCON_MAX77843 is not set
> # CONFIG_EXTCON_PTN5150 is not set
> # CONFIG_EXTCON_RT8973A is not set
> CONFIG_EXTCON_SM5502=y
> CONFIG_EXTCON_USB_GPIO=y
> # CONFIG_EXTCON_USBC_CROS_EC is not set
> CONFIG_EXTCON_USBC_TUSB320=y
> # CONFIG_MEMORY is not set
> CONFIG_IIO=y
> CONFIG_IIO_BUFFER=y
> CONFIG_IIO_BUFFER_CB=m
> CONFIG_IIO_BUFFER_DMA=y
> CONFIG_IIO_BUFFER_DMAENGINE=y
> CONFIG_IIO_BUFFER_HW_CONSUMER=y
> CONFIG_IIO_KFIFO_BUF=y
> CONFIG_IIO_TRIGGERED_BUFFER=y
> CONFIG_IIO_CONFIGFS=m
> CONFIG_IIO_TRIGGER=y
> CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
> CONFIG_IIO_SW_DEVICE=m
> CONFIG_IIO_SW_TRIGGER=m
> CONFIG_IIO_TRIGGERED_EVENT=m
> 
> #
> # Accelerometers
> #
> CONFIG_ADIS16201=m
> CONFIG_ADIS16209=y
> CONFIG_ADXL313=m
> CONFIG_ADXL313_I2C=m
> CONFIG_ADXL313_SPI=m
> CONFIG_ADXL355=m
> # CONFIG_ADXL355_I2C is not set
> CONFIG_ADXL355_SPI=m
> CONFIG_ADXL372=m
> # CONFIG_ADXL372_SPI is not set
> CONFIG_ADXL372_I2C=m
> # CONFIG_BMA220 is not set
> # CONFIG_BMA400 is not set
> CONFIG_BMC150_ACCEL=m
> CONFIG_BMC150_ACCEL_I2C=m
> CONFIG_BMC150_ACCEL_SPI=m
> CONFIG_BMI088_ACCEL=y
> CONFIG_BMI088_ACCEL_SPI=y
> CONFIG_DA280=m
> CONFIG_DA311=y
> CONFIG_DMARD06=m
> CONFIG_DMARD09=y
> # CONFIG_DMARD10 is not set
> CONFIG_FXLS8962AF=m
> # CONFIG_FXLS8962AF_I2C is not set
> CONFIG_FXLS8962AF_SPI=m
> CONFIG_HID_SENSOR_ACCEL_3D=m
> CONFIG_KXSD9=y
> CONFIG_KXSD9_SPI=m
> CONFIG_KXSD9_I2C=m
> CONFIG_KXCJK1013=m
> CONFIG_MC3230=m
> CONFIG_MMA7455=m
> CONFIG_MMA7455_I2C=m
> CONFIG_MMA7455_SPI=m
> # CONFIG_MMA7660 is not set
> # CONFIG_MMA8452 is not set
> # CONFIG_MMA9551 is not set
> # CONFIG_MMA9553 is not set
> # CONFIG_MXC4005 is not set
> CONFIG_MXC6255=m
> CONFIG_SCA3000=m
> CONFIG_SCA3300=m
> # CONFIG_STK8312 is not set
> CONFIG_STK8BA50=m
> # end of Accelerometers
> 
> #
> # Analog to digital converters
> #
> CONFIG_AD_SIGMA_DELTA=y
> CONFIG_AD7091R5=y
> CONFIG_AD7124=y
> CONFIG_AD7192=m
> CONFIG_AD7266=m
> CONFIG_AD7291=m
> CONFIG_AD7292=y
> CONFIG_AD7298=y
> CONFIG_AD7476=y
> CONFIG_AD7606=y
> CONFIG_AD7606_IFACE_PARALLEL=m
> CONFIG_AD7606_IFACE_SPI=y
> # CONFIG_AD7766 is not set
> CONFIG_AD7768_1=m
> CONFIG_AD7780=y
> CONFIG_AD7791=y
> CONFIG_AD7793=y
> # CONFIG_AD7887 is not set
> CONFIG_AD7923=y
> # CONFIG_AD7949 is not set
> CONFIG_AD799X=y
> # CONFIG_ADI_AXI_ADC is not set
> CONFIG_CC10001_ADC=m
> CONFIG_DLN2_ADC=m
> CONFIG_ENVELOPE_DETECTOR=m
> CONFIG_HI8435=m
> CONFIG_HX711=y
> CONFIG_INA2XX_ADC=m
> # CONFIG_LTC2471 is not set
> CONFIG_LTC2485=y
> # CONFIG_LTC2496 is not set
> # CONFIG_LTC2497 is not set
> # CONFIG_MAX1027 is not set
> # CONFIG_MAX11100 is not set
> CONFIG_MAX1118=m
> # CONFIG_MAX1241 is not set
> CONFIG_MAX1363=y
> # CONFIG_MAX9611 is not set
> # CONFIG_MCP320X is not set
> CONFIG_MCP3422=m
> CONFIG_MCP3911=y
> CONFIG_MEN_Z188_ADC=m
> # CONFIG_MP2629_ADC is not set
> CONFIG_NAU7802=m
> CONFIG_QCOM_VADC_COMMON=y
> CONFIG_QCOM_SPMI_IADC=y
> CONFIG_QCOM_SPMI_VADC=m
> CONFIG_QCOM_SPMI_ADC5=y
> CONFIG_RN5T618_ADC=m
> # CONFIG_SD_ADC_MODULATOR is not set
> CONFIG_STMPE_ADC=y
> CONFIG_TI_ADC081C=y
> # CONFIG_TI_ADC0832 is not set
> CONFIG_TI_ADC084S021=y
> CONFIG_TI_ADC12138=y
> CONFIG_TI_ADC108S102=y
> # CONFIG_TI_ADC128S052 is not set
> # CONFIG_TI_ADC161S626 is not set
> # CONFIG_TI_ADS1015 is not set
> CONFIG_TI_ADS7950=m
> CONFIG_TI_ADS8344=m
> CONFIG_TI_ADS8688=m
> CONFIG_TI_ADS124S08=y
> CONFIG_TI_ADS131E08=m
> CONFIG_TI_TLC4541=y
> CONFIG_TI_TSC2046=y
> CONFIG_VF610_ADC=y
> # CONFIG_VIPERBOARD_ADC is not set
> CONFIG_XILINX_XADC=y
> # end of Analog to digital converters
> 
> #
> # Analog to digital and digital to analog converters
> #
> # CONFIG_AD74413R is not set
> # end of Analog to digital and digital to analog converters
> 
> #
> # Analog Front Ends
> #
> CONFIG_IIO_RESCALE=m
> # end of Analog Front Ends
> 
> #
> # Amplifiers
> #
> CONFIG_AD8366=m
> # CONFIG_HMC425 is not set
> # end of Amplifiers
> 
> #
> # Capacitance to digital converters
> #
> # CONFIG_AD7150 is not set
> # end of Capacitance to digital converters
> 
> #
> # Chemical Sensors
> #
> # CONFIG_ATLAS_PH_SENSOR is not set
> CONFIG_ATLAS_EZO_SENSOR=m
> CONFIG_BME680=y
> CONFIG_BME680_I2C=y
> CONFIG_BME680_SPI=y
> # CONFIG_CCS811 is not set
> CONFIG_IAQCORE=y
> # CONFIG_PMS7003 is not set
> CONFIG_SCD30_CORE=y
> # CONFIG_SCD30_I2C is not set
> # CONFIG_SCD30_SERIAL is not set
> CONFIG_SCD4X=y
> CONFIG_SENSIRION_SGP30=m
> # CONFIG_SENSIRION_SGP40 is not set
> CONFIG_SPS30=y
> CONFIG_SPS30_I2C=y
> # CONFIG_SPS30_SERIAL is not set
> CONFIG_SENSEAIR_SUNRISE_CO2=m
> CONFIG_VZ89X=y
> # end of Chemical Sensors
> 
> # CONFIG_IIO_CROS_EC_SENSORS_CORE is not set
> 
> #
> # Hid Sensor IIO Common
> #
> CONFIG_HID_SENSOR_IIO_COMMON=y
> CONFIG_HID_SENSOR_IIO_TRIGGER=y
> # end of Hid Sensor IIO Common
> 
> CONFIG_IIO_MS_SENSORS_I2C=y
> 
> #
> # IIO SCMI Sensors
> #
> # end of IIO SCMI Sensors
> 
> #
> # SSP Sensor Common
> #
> # CONFIG_IIO_SSP_SENSORS_COMMONS is not set
> CONFIG_IIO_SSP_SENSORHUB=m
> # end of SSP Sensor Common
> 
> CONFIG_IIO_ST_SENSORS_I2C=y
> CONFIG_IIO_ST_SENSORS_SPI=y
> CONFIG_IIO_ST_SENSORS_CORE=y
> 
> #
> # Digital to analog converters
> #
> CONFIG_AD3552R=y
> # CONFIG_AD5064 is not set
> CONFIG_AD5360=y
> # CONFIG_AD5380 is not set
> CONFIG_AD5421=y
> CONFIG_AD5446=y
> CONFIG_AD5449=m
> # CONFIG_AD5592R is not set
> # CONFIG_AD5593R is not set
> # CONFIG_AD5504 is not set
> CONFIG_AD5624R_SPI=y
> CONFIG_AD5686=m
> CONFIG_AD5686_SPI=m
> # CONFIG_AD5696_I2C is not set
> # CONFIG_AD5755 is not set
> # CONFIG_AD5758 is not set
> CONFIG_AD5761=m
> # CONFIG_AD5764 is not set
> CONFIG_AD5766=m
> # CONFIG_AD5770R is not set
> CONFIG_AD5791=y
> # CONFIG_AD7293 is not set
> CONFIG_AD7303=m
> # CONFIG_AD8801 is not set
> CONFIG_DPOT_DAC=y
> CONFIG_DS4424=y
> CONFIG_LTC1660=y
> CONFIG_LTC2632=y
> # CONFIG_M62332 is not set
> CONFIG_MAX517=y
> CONFIG_MAX5821=m
> # CONFIG_MCP4725 is not set
> CONFIG_MCP4922=m
> # CONFIG_TI_DAC082S085 is not set
> CONFIG_TI_DAC5571=y
> # CONFIG_TI_DAC7311 is not set
> CONFIG_TI_DAC7612=m
> CONFIG_VF610_DAC=m
> # end of Digital to analog converters
> 
> #
> # IIO dummy driver
> #
> CONFIG_IIO_SIMPLE_DUMMY=m
> # CONFIG_IIO_SIMPLE_DUMMY_EVENTS is not set
> # CONFIG_IIO_SIMPLE_DUMMY_BUFFER is not set
> # end of IIO dummy driver
> 
> #
> # Filters
> #
> # end of Filters
> 
> #
> # Frequency Synthesizers DDS/PLL
> #
> 
> #
> # Clock Generator/Distribution
> #
> CONFIG_AD9523=m
> # end of Clock Generator/Distribution
> 
> #
> # Phase-Locked Loop (PLL) frequency synthesizers
> #
> CONFIG_ADF4350=y
> # CONFIG_ADF4371 is not set
> CONFIG_ADMV1013=y
> # CONFIG_ADRF6780 is not set
> # end of Phase-Locked Loop (PLL) frequency synthesizers
> # end of Frequency Synthesizers DDS/PLL
> 
> #
> # Digital gyroscope sensors
> #
> # CONFIG_ADIS16080 is not set
> CONFIG_ADIS16130=y
> CONFIG_ADIS16136=m
> # CONFIG_ADIS16260 is not set
> # CONFIG_ADXRS290 is not set
> CONFIG_ADXRS450=y
> CONFIG_BMG160=m
> CONFIG_BMG160_I2C=m
> CONFIG_BMG160_SPI=m
> CONFIG_FXAS21002C=m
> CONFIG_FXAS21002C_I2C=m
> CONFIG_FXAS21002C_SPI=m
> # CONFIG_HID_SENSOR_GYRO_3D is not set
> CONFIG_MPU3050=m
> CONFIG_MPU3050_I2C=m
> CONFIG_IIO_ST_GYRO_3AXIS=m
> CONFIG_IIO_ST_GYRO_I2C_3AXIS=m
> CONFIG_IIO_ST_GYRO_SPI_3AXIS=m
> CONFIG_ITG3200=m
> # end of Digital gyroscope sensors
> 
> #
> # Health Sensors
> #
> 
> #
> # Heart Rate Monitors
> #
> CONFIG_AFE4403=m
> CONFIG_AFE4404=m
> # CONFIG_MAX30100 is not set
> CONFIG_MAX30102=y
> # end of Heart Rate Monitors
> # end of Health Sensors
> 
> #
> # Humidity sensors
> #
> # CONFIG_AM2315 is not set
> # CONFIG_DHT11 is not set
> CONFIG_HDC100X=y
> # CONFIG_HDC2010 is not set
> # CONFIG_HID_SENSOR_HUMIDITY is not set
> CONFIG_HTS221=y
> CONFIG_HTS221_I2C=y
> CONFIG_HTS221_SPI=y
> CONFIG_HTU21=y
> # CONFIG_SI7005 is not set
> # CONFIG_SI7020 is not set
> # end of Humidity sensors
> 
> #
> # Inertial measurement units
> #
> # CONFIG_ADIS16400 is not set
> CONFIG_ADIS16460=m
> CONFIG_ADIS16475=m
> CONFIG_ADIS16480=m
> CONFIG_BMI160=m
> CONFIG_BMI160_I2C=m
> CONFIG_BMI160_SPI=m
> CONFIG_FXOS8700=y
> CONFIG_FXOS8700_I2C=m
> CONFIG_FXOS8700_SPI=y
> CONFIG_KMX61=m
> CONFIG_INV_ICM42600=y
> CONFIG_INV_ICM42600_I2C=y
> # CONFIG_INV_ICM42600_SPI is not set
> # CONFIG_INV_MPU6050_I2C is not set
> # CONFIG_INV_MPU6050_SPI is not set
> # CONFIG_IIO_ST_LSM6DSX is not set
> # end of Inertial measurement units
> 
> CONFIG_IIO_ADIS_LIB=y
> CONFIG_IIO_ADIS_LIB_BUFFER=y
> 
> #
> # Light sensors
> #
> CONFIG_ACPI_ALS=m
> # CONFIG_ADJD_S311 is not set
> CONFIG_ADUX1020=m
> # CONFIG_AL3010 is not set
> CONFIG_AL3320A=y
> CONFIG_APDS9300=y
> CONFIG_APDS9960=m
> CONFIG_AS73211=m
> CONFIG_BH1750=m
> # CONFIG_BH1780 is not set
> CONFIG_CM32181=m
> CONFIG_CM3232=m
> CONFIG_CM3323=m
> CONFIG_CM3605=y
> # CONFIG_CM36651 is not set
> CONFIG_GP2AP002=y
> CONFIG_GP2AP020A00F=y
> # CONFIG_IQS621_ALS is not set
> CONFIG_SENSORS_ISL29018=y
> CONFIG_SENSORS_ISL29028=m
> # CONFIG_ISL29125 is not set
> CONFIG_HID_SENSOR_ALS=m
> CONFIG_HID_SENSOR_PROX=y
> CONFIG_JSA1212=y
> # CONFIG_RPR0521 is not set
> # CONFIG_SENSORS_LM3533 is not set
> CONFIG_LTR501=y
> CONFIG_LV0104CS=y
> CONFIG_MAX44000=m
> CONFIG_MAX44009=m
> # CONFIG_NOA1305 is not set
> # CONFIG_OPT3001 is not set
> CONFIG_PA12203001=y
> # CONFIG_SI1133 is not set
> CONFIG_SI1145=m
> # CONFIG_STK3310 is not set
> CONFIG_ST_UVIS25=y
> CONFIG_ST_UVIS25_I2C=y
> CONFIG_ST_UVIS25_SPI=y
> # CONFIG_TCS3414 is not set
> # CONFIG_TCS3472 is not set
> CONFIG_SENSORS_TSL2563=y
> CONFIG_TSL2583=y
> CONFIG_TSL2591=y
> # CONFIG_TSL2772 is not set
> # CONFIG_TSL4531 is not set
> CONFIG_US5182D=y
> CONFIG_VCNL4000=y
> # CONFIG_VCNL4035 is not set
> CONFIG_VEML6030=y
> # CONFIG_VEML6070 is not set
> CONFIG_VL6180=y
> CONFIG_ZOPT2201=y
> # end of Light sensors
> 
> #
> # Magnetometer sensors
> #
> # CONFIG_AK8974 is not set
> CONFIG_AK8975=y
> CONFIG_AK09911=m
> CONFIG_BMC150_MAGN=m
> # CONFIG_BMC150_MAGN_I2C is not set
> CONFIG_BMC150_MAGN_SPI=m
> CONFIG_MAG3110=y
> CONFIG_HID_SENSOR_MAGNETOMETER_3D=y
> # CONFIG_MMC35240 is not set
> CONFIG_IIO_ST_MAGN_3AXIS=y
> CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
> CONFIG_IIO_ST_MAGN_SPI_3AXIS=y
> CONFIG_SENSORS_HMC5843=y
> CONFIG_SENSORS_HMC5843_I2C=y
> CONFIG_SENSORS_HMC5843_SPI=m
> CONFIG_SENSORS_RM3100=y
> CONFIG_SENSORS_RM3100_I2C=m
> CONFIG_SENSORS_RM3100_SPI=y
> CONFIG_YAMAHA_YAS530=y
> # end of Magnetometer sensors
> 
> #
> # Multiplexers
> #
> # CONFIG_IIO_MUX is not set
> # end of Multiplexers
> 
> #
> # Inclinometer sensors
> #
> CONFIG_HID_SENSOR_INCLINOMETER_3D=y
> CONFIG_HID_SENSOR_DEVICE_ROTATION=m
> # end of Inclinometer sensors
> 
> #
> # Triggers - standalone
> #
> CONFIG_IIO_HRTIMER_TRIGGER=m
> # CONFIG_IIO_INTERRUPT_TRIGGER is not set
> CONFIG_IIO_TIGHTLOOP_TRIGGER=m
> CONFIG_IIO_SYSFS_TRIGGER=y
> # end of Triggers - standalone
> 
> #
> # Linear and angular position sensors
> #
> CONFIG_IQS624_POS=m
> CONFIG_HID_SENSOR_CUSTOM_INTEL_HINGE=y
> # end of Linear and angular position sensors
> 
> #
> # Digital potentiometers
> #
> # CONFIG_AD5110 is not set
> CONFIG_AD5272=m
> # CONFIG_DS1803 is not set
> CONFIG_MAX5432=m
> # CONFIG_MAX5481 is not set
> CONFIG_MAX5487=m
> # CONFIG_MCP4018 is not set
> CONFIG_MCP4131=m
> CONFIG_MCP4531=y
> # CONFIG_MCP41010 is not set
> CONFIG_TPL0102=m
> # end of Digital potentiometers
> 
> #
> # Digital potentiostats
> #
> # CONFIG_LMP91000 is not set
> # end of Digital potentiostats
> 
> #
> # Pressure sensors
> #
> # CONFIG_ABP060MG is not set
> CONFIG_BMP280=y
> CONFIG_BMP280_I2C=y
> CONFIG_BMP280_SPI=y
> CONFIG_DLHL60D=m
> # CONFIG_DPS310 is not set
> CONFIG_HID_SENSOR_PRESS=m
> # CONFIG_HP03 is not set
> # CONFIG_ICP10100 is not set
> CONFIG_MPL115=m
> # CONFIG_MPL115_I2C is not set
> CONFIG_MPL115_SPI=m
> # CONFIG_MPL3115 is not set
> CONFIG_MS5611=y
> CONFIG_MS5611_I2C=y
> # CONFIG_MS5611_SPI is not set
> CONFIG_MS5637=y
> CONFIG_IIO_ST_PRESS=y
> CONFIG_IIO_ST_PRESS_I2C=y
> CONFIG_IIO_ST_PRESS_SPI=y
> # CONFIG_T5403 is not set
> CONFIG_HP206C=m
> # CONFIG_ZPA2326 is not set
> # end of Pressure sensors
> 
> #
> # Lightning sensors
> #
> CONFIG_AS3935=y
> # end of Lightning sensors
> 
> #
> # Proximity and distance sensors
> #
> # CONFIG_CROS_EC_MKBP_PROXIMITY is not set
> CONFIG_ISL29501=y
> CONFIG_LIDAR_LITE_V2=y
> # CONFIG_MB1232 is not set
> CONFIG_PING=m
> CONFIG_RFD77402=y
> # CONFIG_SRF04 is not set
> CONFIG_SX9310=y
> CONFIG_SX9500=y
> CONFIG_SRF08=m
> CONFIG_VCNL3020=y
> # CONFIG_VL53L0X_I2C is not set
> # end of Proximity and distance sensors
> 
> #
> # Resolver to digital converters
> #
> CONFIG_AD2S90=y
> CONFIG_AD2S1200=y
> # end of Resolver to digital converters
> 
> #
> # Temperature sensors
> #
> CONFIG_IQS620AT_TEMP=m
> CONFIG_LTC2983=y
> # CONFIG_MAXIM_THERMOCOUPLE is not set
> # CONFIG_HID_SENSOR_TEMP is not set
> CONFIG_MLX90614=m
> # CONFIG_MLX90632 is not set
> # CONFIG_TMP006 is not set
> CONFIG_TMP007=y
> CONFIG_TMP117=m
> # CONFIG_TSYS01 is not set
> CONFIG_TSYS02D=m
> CONFIG_MAX31856=y
> CONFIG_MAX31865=m
> # end of Temperature sensors
> 
> # CONFIG_NTB is not set
> # CONFIG_VME_BUS is not set
> # CONFIG_PWM is not set
> 
> #
> # IRQ chip support
> #
> CONFIG_IRQCHIP=y
> # CONFIG_AL_FIC is not set
> CONFIG_MADERA_IRQ=m
> # end of IRQ chip support
> 
> CONFIG_IPACK_BUS=y
> # CONFIG_BOARD_TPCI200 is not set
> CONFIG_SERIAL_IPOCTAL=y
> CONFIG_RESET_CONTROLLER=y
> CONFIG_RESET_INTEL_GW=y
> CONFIG_RESET_TI_SYSCON=y
> 
> #
> # PHY Subsystem
> #
> CONFIG_GENERIC_PHY=y
> CONFIG_GENERIC_PHY_MIPI_DPHY=y
> # CONFIG_USB_LGM_PHY is not set
> # CONFIG_PHY_CAN_TRANSCEIVER is not set
> 
> #
> # PHY drivers for Broadcom platforms
> #
> # CONFIG_BCM_KONA_USB2_PHY is not set
> # end of PHY drivers for Broadcom platforms
> 
> # CONFIG_PHY_CADENCE_TORRENT is not set
> CONFIG_PHY_CADENCE_DPHY=y
> # CONFIG_PHY_CADENCE_SIERRA is not set
> CONFIG_PHY_CADENCE_SALVO=m
> # CONFIG_PHY_FSL_IMX8MQ_USB is not set
> CONFIG_PHY_MIXEL_MIPI_DPHY=m
> CONFIG_PHY_FSL_IMX8M_PCIE=y
> CONFIG_PHY_PXA_28NM_HSIC=m
> # CONFIG_PHY_PXA_28NM_USB2 is not set
> CONFIG_PHY_LAN966X_SERDES=m
> CONFIG_PHY_CPCAP_USB=m
> CONFIG_PHY_MAPPHONE_MDM6600=m
> # CONFIG_PHY_OCELOT_SERDES is not set
> CONFIG_PHY_QCOM_USB_HS=m
> CONFIG_PHY_QCOM_USB_HSIC=m
> # CONFIG_PHY_SAMSUNG_USB2 is not set
> CONFIG_PHY_TUSB1210=m
> CONFIG_PHY_INTEL_LGM_COMBO=y
> CONFIG_PHY_INTEL_LGM_EMMC=y
> # end of PHY Subsystem
> 
> # CONFIG_POWERCAP is not set
> CONFIG_MCB=m
> # CONFIG_MCB_PCI is not set
> # CONFIG_MCB_LPC is not set
> 
> #
> # Performance monitor support
> #
> # end of Performance monitor support
> 
> CONFIG_RAS=y
> # CONFIG_USB4 is not set
> 
> #
> # Android
> #
> # CONFIG_ANDROID is not set
> # end of Android
> 
> # CONFIG_DAX is not set
> CONFIG_NVMEM=y
> CONFIG_NVMEM_SYSFS=y
> # CONFIG_NVMEM_SPMI_SDAM is not set
> CONFIG_RAVE_SP_EEPROM=m
> # CONFIG_NVMEM_RMEM is not set
> 
> #
> # HW tracing support
> #
> # CONFIG_STM is not set
> # CONFIG_INTEL_TH is not set
> # end of HW tracing support
> 
> CONFIG_FPGA=y
> # CONFIG_ALTERA_PR_IP_CORE is not set
> # CONFIG_FPGA_MGR_ALTERA_PS_SPI is not set
> # CONFIG_FPGA_MGR_ALTERA_CVP is not set
> # CONFIG_FPGA_MGR_XILINX_SPI is not set
> # CONFIG_FPGA_MGR_ICE40_SPI is not set
> # CONFIG_FPGA_MGR_MACHXO2_SPI is not set
> CONFIG_FPGA_BRIDGE=m
> CONFIG_ALTERA_FREEZE_BRIDGE=m
> CONFIG_XILINX_PR_DECOUPLER=m
> CONFIG_FPGA_REGION=m
> CONFIG_OF_FPGA_REGION=m
> CONFIG_FPGA_DFL=m
> CONFIG_FPGA_DFL_AFU=m
> CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000=m
> # CONFIG_FPGA_DFL_PCI is not set
> CONFIG_FSI=m
> # CONFIG_FSI_NEW_DEV_NODE is not set
> CONFIG_FSI_MASTER_GPIO=m
> CONFIG_FSI_MASTER_HUB=m
> CONFIG_FSI_MASTER_ASPEED=m
> # CONFIG_FSI_SCOM is not set
> CONFIG_FSI_SBEFIFO=m
> CONFIG_FSI_OCC=m
> CONFIG_TEE=y
> 
> #
> # TEE drivers
> #
> # end of TEE drivers
> 
> CONFIG_MULTIPLEXER=y
> 
> #
> # Multiplexer drivers
> #
> CONFIG_MUX_ADG792A=m
> # CONFIG_MUX_ADGS1408 is not set
> # CONFIG_MUX_GPIO is not set
> CONFIG_MUX_MMIO=y
> # end of Multiplexer drivers
> 
> CONFIG_PM_OPP=y
> CONFIG_SIOX=y
> # CONFIG_SIOX_BUS_GPIO is not set
> CONFIG_SLIMBUS=y
> CONFIG_SLIM_QCOM_CTRL=m
> # CONFIG_INTERCONNECT is not set
> # CONFIG_COUNTER is not set
> CONFIG_MOST=m
> CONFIG_MOST_USB_HDM=m
> # CONFIG_MOST_CDEV is not set
> # CONFIG_MOST_SND is not set
> # end of Device Drivers
> 
> #
> # File systems
> #
> CONFIG_DCACHE_WORD_ACCESS=y
> # CONFIG_VALIDATE_FS_PARSER is not set
> CONFIG_FS_IOMAP=y
> CONFIG_EXT2_FS=y
> CONFIG_EXT2_FS_XATTR=y
> CONFIG_EXT2_FS_POSIX_ACL=y
> CONFIG_EXT2_FS_SECURITY=y
> # CONFIG_EXT3_FS is not set
> CONFIG_EXT4_FS=y
> CONFIG_EXT4_FS_POSIX_ACL=y
> # CONFIG_EXT4_FS_SECURITY is not set
> # CONFIG_EXT4_DEBUG is not set
> CONFIG_JBD2=y
> # CONFIG_JBD2_DEBUG is not set
> CONFIG_FS_MBCACHE=y
> # CONFIG_REISERFS_FS is not set
> # CONFIG_JFS_FS is not set
> CONFIG_XFS_FS=m
> # CONFIG_XFS_SUPPORT_V4 is not set
> # CONFIG_XFS_QUOTA is not set
> # CONFIG_XFS_POSIX_ACL is not set
> # CONFIG_XFS_RT is not set
> CONFIG_XFS_ONLINE_SCRUB=y
> # CONFIG_XFS_ONLINE_REPAIR is not set
> CONFIG_XFS_DEBUG=y
> CONFIG_XFS_ASSERT_FATAL=y
> CONFIG_GFS2_FS=y
> # CONFIG_OCFS2_FS is not set
> CONFIG_BTRFS_FS=y
> CONFIG_BTRFS_FS_POSIX_ACL=y
> CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
> # CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
> CONFIG_BTRFS_DEBUG=y
> # CONFIG_BTRFS_ASSERT is not set
> CONFIG_BTRFS_FS_REF_VERIFY=y
> # CONFIG_NILFS2_FS is not set
> # CONFIG_F2FS_FS is not set
> # CONFIG_FS_DAX is not set
> CONFIG_FS_POSIX_ACL=y
> CONFIG_EXPORTFS=y
> # CONFIG_EXPORTFS_BLOCK_OPS is not set
> CONFIG_FILE_LOCKING=y
> # CONFIG_FS_ENCRYPTION is not set
> CONFIG_FS_VERITY=y
> # CONFIG_FS_VERITY_DEBUG is not set
> CONFIG_FS_VERITY_BUILTIN_SIGNATURES=y
> CONFIG_FSNOTIFY=y
> # CONFIG_DNOTIFY is not set
> CONFIG_INOTIFY_USER=y
> # CONFIG_FANOTIFY is not set
> CONFIG_QUOTA=y
> CONFIG_QUOTA_NETLINK_INTERFACE=y
> # CONFIG_PRINT_QUOTA_WARNING is not set
> CONFIG_QUOTA_DEBUG=y
> # CONFIG_QFMT_V1 is not set
> # CONFIG_QFMT_V2 is not set
> CONFIG_QUOTACTL=y
> CONFIG_AUTOFS4_FS=y
> CONFIG_AUTOFS_FS=y
> # CONFIG_FUSE_FS is not set
> CONFIG_OVERLAY_FS=m
> CONFIG_OVERLAY_FS_REDIRECT_DIR=y
> # CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
> CONFIG_OVERLAY_FS_INDEX=y
> CONFIG_OVERLAY_FS_METACOPY=y
> 
> #
> # Caches
> #
> CONFIG_NETFS_SUPPORT=y
> CONFIG_NETFS_STATS=y
> CONFIG_FSCACHE=y
> # CONFIG_FSCACHE_STATS is not set
> # CONFIG_FSCACHE_DEBUG is not set
> CONFIG_CACHEFILES=y
> # CONFIG_CACHEFILES_DEBUG is not set
> # CONFIG_CACHEFILES_ERROR_INJECTION is not set
> # end of Caches
> 
> #
> # CD-ROM/DVD Filesystems
> #
> CONFIG_ISO9660_FS=y
> CONFIG_JOLIET=y
> CONFIG_ZISOFS=y
> CONFIG_UDF_FS=m
> # end of CD-ROM/DVD Filesystems
> 
> #
> # DOS/FAT/EXFAT/NT Filesystems
> #
> CONFIG_FAT_FS=y
> CONFIG_MSDOS_FS=y
> # CONFIG_VFAT_FS is not set
> CONFIG_FAT_DEFAULT_CODEPAGE=437
> # CONFIG_EXFAT_FS is not set
> # CONFIG_NTFS_FS is not set
> CONFIG_NTFS3_FS=y
> CONFIG_NTFS3_LZX_XPRESS=y
> CONFIG_NTFS3_FS_POSIX_ACL=y
> # end of DOS/FAT/EXFAT/NT Filesystems
> 
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> # CONFIG_PROC_KCORE is not set
> # CONFIG_PROC_VMCORE is not set
> CONFIG_PROC_SYSCTL=y
> CONFIG_PROC_PAGE_MONITOR=y
> CONFIG_PROC_CHILDREN=y
> CONFIG_PROC_PID_ARCH_STATUS=y
> CONFIG_PROC_CPU_RESCTRL=y
> CONFIG_KERNFS=y
> CONFIG_SYSFS=y
> CONFIG_TMPFS=y
> # CONFIG_TMPFS_POSIX_ACL is not set
> # CONFIG_TMPFS_XATTR is not set
> # CONFIG_HUGETLBFS is not set
> CONFIG_MEMFD_CREATE=y
> CONFIG_CONFIGFS_FS=y
> CONFIG_EFIVAR_FS=m
> # end of Pseudo filesystems
> 
> CONFIG_MISC_FILESYSTEMS=y
> CONFIG_ORANGEFS_FS=y
> CONFIG_ADFS_FS=m
> CONFIG_ADFS_FS_RW=y
> # CONFIG_AFFS_FS is not set
> # CONFIG_ECRYPT_FS is not set
> CONFIG_HFS_FS=y
> # CONFIG_HFSPLUS_FS is not set
> # CONFIG_BEFS_FS is not set
> # CONFIG_BFS_FS is not set
> # CONFIG_EFS_FS is not set
> # CONFIG_JFFS2_FS is not set
> # CONFIG_UBIFS_FS is not set
> CONFIG_CRAMFS=m
> CONFIG_CRAMFS_BLOCKDEV=y
> # CONFIG_CRAMFS_MTD is not set
> CONFIG_SQUASHFS=m
> # CONFIG_SQUASHFS_FILE_CACHE is not set
> CONFIG_SQUASHFS_FILE_DIRECT=y
> # CONFIG_SQUASHFS_DECOMP_SINGLE is not set
> CONFIG_SQUASHFS_DECOMP_MULTI=y
> # CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
> CONFIG_SQUASHFS_XATTR=y
> CONFIG_SQUASHFS_ZLIB=y
> # CONFIG_SQUASHFS_LZ4 is not set
> CONFIG_SQUASHFS_LZO=y
> # CONFIG_SQUASHFS_XZ is not set
> # CONFIG_SQUASHFS_ZSTD is not set
> CONFIG_SQUASHFS_4K_DEVBLK_SIZE=y
> CONFIG_SQUASHFS_EMBEDDED=y
> CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
> # CONFIG_VXFS_FS is not set
> CONFIG_MINIX_FS=y
> CONFIG_OMFS_FS=m
> # CONFIG_HPFS_FS is not set
> # CONFIG_QNX4FS_FS is not set
> CONFIG_QNX6FS_FS=m
> # CONFIG_QNX6FS_DEBUG is not set
> CONFIG_ROMFS_FS=y
> # CONFIG_ROMFS_BACKED_BY_BLOCK is not set
> CONFIG_ROMFS_BACKED_BY_MTD=y
> # CONFIG_ROMFS_BACKED_BY_BOTH is not set
> CONFIG_ROMFS_ON_MTD=y
> # CONFIG_PSTORE is not set
> # CONFIG_SYSV_FS is not set
> # CONFIG_UFS_FS is not set
> CONFIG_EROFS_FS=m
> CONFIG_EROFS_FS_DEBUG=y
> # CONFIG_EROFS_FS_XATTR is not set
> # CONFIG_EROFS_FS_ZIP is not set
> CONFIG_NETWORK_FILESYSTEMS=y
> CONFIG_NFS_FS=y
> CONFIG_NFS_V2=y
> CONFIG_NFS_V3=y
> # CONFIG_NFS_V3_ACL is not set
> CONFIG_NFS_V4=m
> # CONFIG_NFS_SWAP is not set
> # CONFIG_NFS_V4_1 is not set
> # CONFIG_ROOT_NFS is not set
> # CONFIG_NFS_FSCACHE is not set
> # CONFIG_NFS_USE_LEGACY_DNS is not set
> CONFIG_NFS_USE_KERNEL_DNS=y
> CONFIG_NFS_DISABLE_UDP_SUPPORT=y
> # CONFIG_NFSD is not set
> CONFIG_GRACE_PERIOD=y
> CONFIG_LOCKD=y
> CONFIG_LOCKD_V4=y
> CONFIG_NFS_COMMON=y
> CONFIG_SUNRPC=y
> CONFIG_SUNRPC_GSS=m
> CONFIG_RPCSEC_GSS_KRB5=m
> # CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
> # CONFIG_SUNRPC_DEBUG is not set
> # CONFIG_CEPH_FS is not set
> CONFIG_CIFS=m
> CONFIG_CIFS_STATS2=y
> CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
> # CONFIG_CIFS_UPCALL is not set
> # CONFIG_CIFS_XATTR is not set
> CONFIG_CIFS_DEBUG=y
> # CONFIG_CIFS_DEBUG2 is not set
> # CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
> # CONFIG_CIFS_DFS_UPCALL is not set
> # CONFIG_CIFS_SWN_UPCALL is not set
> # CONFIG_CIFS_FSCACHE is not set
> # CONFIG_SMB_SERVER is not set
> CONFIG_SMBFS_COMMON=m
> # CONFIG_CODA_FS is not set
> # CONFIG_AFS_FS is not set
> # CONFIG_9P_FS is not set
> CONFIG_NLS=y
> CONFIG_NLS_DEFAULT="iso8859-1"
> CONFIG_NLS_CODEPAGE_437=m
> CONFIG_NLS_CODEPAGE_737=m
> CONFIG_NLS_CODEPAGE_775=m
> # CONFIG_NLS_CODEPAGE_850 is not set
> # CONFIG_NLS_CODEPAGE_852 is not set
> CONFIG_NLS_CODEPAGE_855=m
> CONFIG_NLS_CODEPAGE_857=m
> CONFIG_NLS_CODEPAGE_860=m
> CONFIG_NLS_CODEPAGE_861=m
> # CONFIG_NLS_CODEPAGE_862 is not set
> CONFIG_NLS_CODEPAGE_863=m
> # CONFIG_NLS_CODEPAGE_864 is not set
> CONFIG_NLS_CODEPAGE_865=y
> # CONFIG_NLS_CODEPAGE_866 is not set
> CONFIG_NLS_CODEPAGE_869=y
> CONFIG_NLS_CODEPAGE_936=y
> CONFIG_NLS_CODEPAGE_950=m
> CONFIG_NLS_CODEPAGE_932=m
> # CONFIG_NLS_CODEPAGE_949 is not set
> # CONFIG_NLS_CODEPAGE_874 is not set
> # CONFIG_NLS_ISO8859_8 is not set
> # CONFIG_NLS_CODEPAGE_1250 is not set
> CONFIG_NLS_CODEPAGE_1251=y
> CONFIG_NLS_ASCII=m
> # CONFIG_NLS_ISO8859_1 is not set
> # CONFIG_NLS_ISO8859_2 is not set
> CONFIG_NLS_ISO8859_3=y
> CONFIG_NLS_ISO8859_4=y
> CONFIG_NLS_ISO8859_5=m
> CONFIG_NLS_ISO8859_6=m
> CONFIG_NLS_ISO8859_7=y
> # CONFIG_NLS_ISO8859_9 is not set
> CONFIG_NLS_ISO8859_13=y
> # CONFIG_NLS_ISO8859_14 is not set
> CONFIG_NLS_ISO8859_15=y
> CONFIG_NLS_KOI8_R=y
> CONFIG_NLS_KOI8_U=y
> CONFIG_NLS_MAC_ROMAN=m
> # CONFIG_NLS_MAC_CELTIC is not set
> # CONFIG_NLS_MAC_CENTEURO is not set
> CONFIG_NLS_MAC_CROATIAN=y
> # CONFIG_NLS_MAC_CYRILLIC is not set
> CONFIG_NLS_MAC_GAELIC=y
> CONFIG_NLS_MAC_GREEK=y
> CONFIG_NLS_MAC_ICELAND=y
> # CONFIG_NLS_MAC_INUIT is not set
> CONFIG_NLS_MAC_ROMANIAN=y
> CONFIG_NLS_MAC_TURKISH=y
> CONFIG_NLS_UTF8=m
> # CONFIG_DLM is not set
> CONFIG_UNICODE=y
> # CONFIG_UNICODE_UTF8_DATA is not set
> CONFIG_IO_WQ=y
> # end of File systems
> 
> #
> # Security options
> #
> CONFIG_KEYS=y
> CONFIG_KEYS_REQUEST_CACHE=y
> # CONFIG_PERSISTENT_KEYRINGS is not set
> CONFIG_TRUSTED_KEYS=m
> CONFIG_ENCRYPTED_KEYS=y
> CONFIG_KEY_DH_OPERATIONS=y
> CONFIG_KEY_NOTIFICATIONS=y
> # CONFIG_SECURITY_DMESG_RESTRICT is not set
> CONFIG_SECURITY=y
> CONFIG_SECURITYFS=y
> CONFIG_SECURITY_NETWORK=y
> CONFIG_SECURITY_PATH=y
> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
> CONFIG_HARDENED_USERCOPY=y
> CONFIG_FORTIFY_SOURCE=y
> # CONFIG_STATIC_USERMODEHELPER is not set
> # CONFIG_SECURITY_SELINUX is not set
> # CONFIG_SECURITY_SMACK is not set
> # CONFIG_SECURITY_TOMOYO is not set
> CONFIG_SECURITY_APPARMOR=y
> # CONFIG_SECURITY_APPARMOR_HASH is not set
> CONFIG_SECURITY_APPARMOR_DEBUG=y
> CONFIG_SECURITY_APPARMOR_DEBUG_ASSERTS=y
> # CONFIG_SECURITY_APPARMOR_DEBUG_MESSAGES is not set
> # CONFIG_SECURITY_LOADPIN is not set
> CONFIG_SECURITY_YAMA=y
> # CONFIG_SECURITY_SAFESETID is not set
> # CONFIG_SECURITY_LOCKDOWN_LSM is not set
> CONFIG_SECURITY_LANDLOCK=y
> CONFIG_INTEGRITY=y
> CONFIG_INTEGRITY_SIGNATURE=y
> CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
> CONFIG_INTEGRITY_TRUSTED_KEYRING=y
> # CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
> CONFIG_INTEGRITY_AUDIT=y
> CONFIG_IMA=y
> CONFIG_IMA_MEASURE_PCR_IDX=10
> CONFIG_IMA_LSM_RULES=y
> # CONFIG_IMA_TEMPLATE is not set
> CONFIG_IMA_NG_TEMPLATE=y
> # CONFIG_IMA_SIG_TEMPLATE is not set
> CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
> CONFIG_IMA_DEFAULT_HASH_SHA1=y
> # CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
> # CONFIG_IMA_DEFAULT_HASH_SM3 is not set
> CONFIG_IMA_DEFAULT_HASH="sha1"
> # CONFIG_IMA_WRITE_POLICY is not set
> # CONFIG_IMA_READ_POLICY is not set
> CONFIG_IMA_APPRAISE=y
> CONFIG_IMA_ARCH_POLICY=y
> # CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
> # CONFIG_IMA_APPRAISE_BOOTPARAM is not set
> # CONFIG_IMA_APPRAISE_MODSIG is not set
> CONFIG_IMA_TRUSTED_KEYRING=y
> # CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY is not set
> # CONFIG_IMA_BLACKLIST_KEYRING is not set
> CONFIG_IMA_LOAD_X509=y
> CONFIG_IMA_X509_PATH="/etc/keys/x509_ima.der"
> # CONFIG_IMA_APPRAISE_SIGNED_INIT is not set
> CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
> CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
> CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=y
> # CONFIG_IMA_DISABLE_HTABLE is not set
> # CONFIG_EVM is not set
> CONFIG_DEFAULT_SECURITY_APPARMOR=y
> # CONFIG_DEFAULT_SECURITY_DAC is not set
> CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,tomoyo,bpf"
> 
> #
> # Kernel hardening options
> #
> 
> #
> # Memory initialization
> #
> CONFIG_INIT_STACK_NONE=y
> CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
> CONFIG_INIT_ON_FREE_DEFAULT_ON=y
> # end of Memory initialization
> # end of Kernel hardening options
> # end of Security options
> 
> CONFIG_XOR_BLOCKS=y
> CONFIG_CRYPTO=y
> 
> #
> # Crypto core or helper
> #
> CONFIG_CRYPTO_ALGAPI=y
> CONFIG_CRYPTO_ALGAPI2=y
> CONFIG_CRYPTO_AEAD=y
> CONFIG_CRYPTO_AEAD2=y
> CONFIG_CRYPTO_SKCIPHER=y
> CONFIG_CRYPTO_SKCIPHER2=y
> CONFIG_CRYPTO_HASH=y
> CONFIG_CRYPTO_HASH2=y
> CONFIG_CRYPTO_RNG=y
> CONFIG_CRYPTO_RNG2=y
> CONFIG_CRYPTO_RNG_DEFAULT=m
> CONFIG_CRYPTO_AKCIPHER2=y
> CONFIG_CRYPTO_AKCIPHER=y
> CONFIG_CRYPTO_KPP2=y
> CONFIG_CRYPTO_KPP=y
> CONFIG_CRYPTO_ACOMP2=y
> CONFIG_CRYPTO_MANAGER=y
> CONFIG_CRYPTO_MANAGER2=y
> # CONFIG_CRYPTO_USER is not set
> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
> CONFIG_CRYPTO_GF128MUL=y
> CONFIG_CRYPTO_NULL=y
> CONFIG_CRYPTO_NULL2=y
> CONFIG_CRYPTO_CRYPTD=m
> CONFIG_CRYPTO_AUTHENC=y
> # CONFIG_CRYPTO_TEST is not set
> CONFIG_CRYPTO_SIMD=m
> 
> #
> # Public-key cryptography
> #
> CONFIG_CRYPTO_RSA=y
> CONFIG_CRYPTO_DH=y
> CONFIG_CRYPTO_ECC=m
> CONFIG_CRYPTO_ECDH=m
> CONFIG_CRYPTO_ECDSA=m
> # CONFIG_CRYPTO_ECRDSA is not set
> CONFIG_CRYPTO_SM2=y
> CONFIG_CRYPTO_CURVE25519=m
> 
> #
> # Authenticated Encryption with Associated Data
> #
> CONFIG_CRYPTO_CCM=y
> CONFIG_CRYPTO_GCM=y
> # CONFIG_CRYPTO_CHACHA20POLY1305 is not set
> CONFIG_CRYPTO_AEGIS128=y
> # CONFIG_CRYPTO_SEQIV is not set
> # CONFIG_CRYPTO_ECHAINIV is not set
> 
> #
> # Block modes
> #
> CONFIG_CRYPTO_CBC=y
> CONFIG_CRYPTO_CFB=m
> CONFIG_CRYPTO_CTR=y
> CONFIG_CRYPTO_CTS=m
> CONFIG_CRYPTO_ECB=y
> CONFIG_CRYPTO_LRW=y
> CONFIG_CRYPTO_OFB=y
> # CONFIG_CRYPTO_PCBC is not set
> CONFIG_CRYPTO_XTS=y
> # CONFIG_CRYPTO_KEYWRAP is not set
> CONFIG_CRYPTO_NHPOLY1305=m
> CONFIG_CRYPTO_ADIANTUM=m
> # CONFIG_CRYPTO_ESSIV is not set
> 
> #
> # Hash modes
> #
> CONFIG_CRYPTO_CMAC=y
> CONFIG_CRYPTO_HMAC=y
> CONFIG_CRYPTO_XCBC=y
> CONFIG_CRYPTO_VMAC=m
> 
> #
> # Digest
> #
> CONFIG_CRYPTO_CRC32C=y
> # CONFIG_CRYPTO_CRC32C_INTEL is not set
> CONFIG_CRYPTO_CRC32=m
> # CONFIG_CRYPTO_CRC32_PCLMUL is not set
> CONFIG_CRYPTO_XXHASH=y
> CONFIG_CRYPTO_BLAKE2B=y
> # CONFIG_CRYPTO_BLAKE2S is not set
> CONFIG_CRYPTO_CRCT10DIF=y
> CONFIG_CRYPTO_GHASH=y
> CONFIG_CRYPTO_POLY1305=y
> CONFIG_CRYPTO_MD4=m
> CONFIG_CRYPTO_MD5=m
> # CONFIG_CRYPTO_MICHAEL_MIC is not set
> CONFIG_CRYPTO_RMD160=y
> CONFIG_CRYPTO_SHA1=y
> CONFIG_CRYPTO_SHA256=y
> CONFIG_CRYPTO_SHA512=m
> CONFIG_CRYPTO_SHA3=m
> CONFIG_CRYPTO_SM3=y
> # CONFIG_CRYPTO_STREEBOG is not set
> # CONFIG_CRYPTO_WP512 is not set
> 
> #
> # Ciphers
> #
> CONFIG_CRYPTO_AES=y
> CONFIG_CRYPTO_AES_TI=m
> CONFIG_CRYPTO_AES_NI_INTEL=m
> CONFIG_CRYPTO_BLOWFISH=m
> CONFIG_CRYPTO_BLOWFISH_COMMON=m
> CONFIG_CRYPTO_CAMELLIA=m
> CONFIG_CRYPTO_CAST_COMMON=y
> CONFIG_CRYPTO_CAST5=y
> # CONFIG_CRYPTO_CAST6 is not set
> CONFIG_CRYPTO_DES=m
> CONFIG_CRYPTO_FCRYPT=y
> CONFIG_CRYPTO_CHACHA20=m
> CONFIG_CRYPTO_SERPENT=m
> CONFIG_CRYPTO_SERPENT_SSE2_586=m
> # CONFIG_CRYPTO_SM4 is not set
> CONFIG_CRYPTO_TWOFISH=y
> CONFIG_CRYPTO_TWOFISH_COMMON=y
> # CONFIG_CRYPTO_TWOFISH_586 is not set
> 
> #
> # Compression
> #
> # CONFIG_CRYPTO_DEFLATE is not set
> # CONFIG_CRYPTO_LZO is not set
> # CONFIG_CRYPTO_842 is not set
> CONFIG_CRYPTO_LZ4=y
> CONFIG_CRYPTO_LZ4HC=y
> CONFIG_CRYPTO_ZSTD=y
> 
> #
> # Random Number Generation
> #
> CONFIG_CRYPTO_ANSI_CPRNG=m
> CONFIG_CRYPTO_DRBG_MENU=m
> CONFIG_CRYPTO_DRBG_HMAC=y
> # CONFIG_CRYPTO_DRBG_HASH is not set
> # CONFIG_CRYPTO_DRBG_CTR is not set
> CONFIG_CRYPTO_DRBG=m
> CONFIG_CRYPTO_JITTERENTROPY=y
> CONFIG_CRYPTO_KDF800108_CTR=y
> CONFIG_CRYPTO_USER_API=m
> # CONFIG_CRYPTO_USER_API_HASH is not set
> CONFIG_CRYPTO_USER_API_SKCIPHER=m
> CONFIG_CRYPTO_USER_API_RNG=m
> CONFIG_CRYPTO_USER_API_RNG_CAVP=y
> # CONFIG_CRYPTO_USER_API_AEAD is not set
> # CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE is not set
> CONFIG_CRYPTO_HASH_INFO=y
> # CONFIG_CRYPTO_HW is not set
> CONFIG_ASYMMETRIC_KEY_TYPE=y
> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
> CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE=m
> CONFIG_X509_CERTIFICATE_PARSER=y
> CONFIG_PKCS8_PRIVATE_KEY_PARSER=y
> CONFIG_TPM_KEY_PARSER=m
> CONFIG_PKCS7_MESSAGE_PARSER=y
> # CONFIG_PKCS7_TEST_KEY is not set
> CONFIG_SIGNED_PE_FILE_VERIFICATION=y
> 
> #
> # Certificates for signature checking
> #
> CONFIG_SYSTEM_TRUSTED_KEYRING=y
> CONFIG_SYSTEM_TRUSTED_KEYS=""
> CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
> CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
> CONFIG_SECONDARY_TRUSTED_KEYRING=y
> CONFIG_SYSTEM_BLACKLIST_KEYRING=y
> CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
> CONFIG_SYSTEM_REVOCATION_LIST=y
> CONFIG_SYSTEM_REVOCATION_KEYS=""
> # end of Certificates for signature checking
> 
> CONFIG_BINARY_PRINTF=y
> 
> #
> # Library routines
> #
> CONFIG_RAID6_PQ=y
> # CONFIG_RAID6_PQ_BENCHMARK is not set
> CONFIG_LINEAR_RANGES=y
> # CONFIG_PACKING is not set
> CONFIG_BITREVERSE=y
> CONFIG_GENERIC_STRNCPY_FROM_USER=y
> CONFIG_GENERIC_STRNLEN_USER=y
> CONFIG_GENERIC_NET_UTILS=y
> CONFIG_CORDIC=m
> CONFIG_PRIME_NUMBERS=m
> CONFIG_RATIONAL=y
> CONFIG_GENERIC_PCI_IOMAP=y
> CONFIG_GENERIC_IOMAP=y
> CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
> CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
> 
> #
> # Crypto library routines
> #
> CONFIG_CRYPTO_LIB_AES=y
> CONFIG_CRYPTO_LIB_ARC4=y
> CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
> CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
> CONFIG_CRYPTO_LIB_CHACHA=y
> CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
> CONFIG_CRYPTO_LIB_CURVE25519=y
> CONFIG_CRYPTO_LIB_DES=m
> CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
> CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
> # CONFIG_CRYPTO_LIB_POLY1305 is not set
> # CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
> CONFIG_CRYPTO_LIB_SHA256=y
> # end of Crypto library routines
> 
> CONFIG_CRC_CCITT=y
> CONFIG_CRC16=y
> CONFIG_CRC_T10DIF=y
> CONFIG_CRC_ITU_T=y
> CONFIG_CRC32=y
> # CONFIG_CRC32_SELFTEST is not set
> # CONFIG_CRC32_SLICEBY8 is not set
> CONFIG_CRC32_SLICEBY4=y
> # CONFIG_CRC32_SARWATE is not set
> # CONFIG_CRC32_BIT is not set
> CONFIG_CRC64=y
> CONFIG_CRC4=m
> CONFIG_CRC7=m
> CONFIG_LIBCRC32C=y
> CONFIG_CRC8=y
> CONFIG_XXHASH=y
> CONFIG_AUDIT_GENERIC=y
> # CONFIG_RANDOM32_SELFTEST is not set
> CONFIG_ZLIB_INFLATE=y
> CONFIG_ZLIB_DEFLATE=y
> CONFIG_LZO_COMPRESS=y
> CONFIG_LZO_DECOMPRESS=y
> CONFIG_LZ4_COMPRESS=y
> CONFIG_LZ4HC_COMPRESS=y
> CONFIG_LZ4_DECOMPRESS=y
> CONFIG_ZSTD_COMPRESS=y
> CONFIG_ZSTD_DECOMPRESS=y
> CONFIG_XZ_DEC=y
> CONFIG_XZ_DEC_X86=y
> CONFIG_XZ_DEC_POWERPC=y
> CONFIG_XZ_DEC_IA64=y
> CONFIG_XZ_DEC_ARM=y
> CONFIG_XZ_DEC_ARMTHUMB=y
> CONFIG_XZ_DEC_SPARC=y
> CONFIG_XZ_DEC_MICROLZMA=y
> CONFIG_XZ_DEC_BCJ=y
> # CONFIG_XZ_DEC_TEST is not set
> CONFIG_DECOMPRESS_GZIP=y
> CONFIG_DECOMPRESS_BZIP2=y
> CONFIG_DECOMPRESS_LZMA=y
> CONFIG_DECOMPRESS_XZ=y
> CONFIG_DECOMPRESS_LZO=y
> CONFIG_DECOMPRESS_LZ4=y
> CONFIG_DECOMPRESS_ZSTD=y
> CONFIG_GENERIC_ALLOCATOR=y
> CONFIG_REED_SOLOMON=m
> CONFIG_REED_SOLOMON_DEC16=y
> CONFIG_BCH=y
> CONFIG_TEXTSEARCH=y
> CONFIG_TEXTSEARCH_KMP=m
> CONFIG_TEXTSEARCH_BM=m
> CONFIG_TEXTSEARCH_FSM=m
> CONFIG_XARRAY_MULTI=y
> CONFIG_ASSOCIATIVE_ARRAY=y
> CONFIG_HAS_IOMEM=y
> CONFIG_HAS_IOPORT_MAP=y
> CONFIG_HAS_DMA=y
> CONFIG_DMA_OPS=y
> CONFIG_NEED_SG_DMA_LENGTH=y
> CONFIG_DMA_DECLARE_COHERENT=y
> CONFIG_DMA_CMA=y
> # CONFIG_DMA_PERNUMA_CMA is not set
> 
> #
> # Default contiguous memory area size:
> #
> CONFIG_CMA_SIZE_MBYTES=0
> CONFIG_CMA_SIZE_SEL_MBYTES=y
> # CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
> # CONFIG_CMA_SIZE_SEL_MIN is not set
> # CONFIG_CMA_SIZE_SEL_MAX is not set
> CONFIG_CMA_ALIGNMENT=8
> # CONFIG_DMA_API_DEBUG is not set
> # CONFIG_DMA_MAP_BENCHMARK is not set
> CONFIG_SGL_ALLOC=y
> CONFIG_CHECK_SIGNATURE=y
> CONFIG_DQL=y
> CONFIG_GLOB=y
> # CONFIG_GLOB_SELFTEST is not set
> CONFIG_NLATTR=y
> CONFIG_CLZ_TAB=y
> # CONFIG_IRQ_POLL is not set
> CONFIG_MPILIB=y
> CONFIG_SIGNATURE=y
> CONFIG_LIBFDT=y
> CONFIG_OID_REGISTRY=y
> CONFIG_UCS2_STRING=y
> CONFIG_HAVE_GENERIC_VDSO=y
> CONFIG_GENERIC_GETTIMEOFDAY=y
> CONFIG_GENERIC_VDSO_32=y
> CONFIG_GENERIC_VDSO_TIME_NS=y
> CONFIG_FONT_SUPPORT=y
> CONFIG_FONT_8x16=y
> CONFIG_FONT_AUTOSELECT=y
> CONFIG_SG_POOL=y
> CONFIG_ARCH_STACKWALK=y
> CONFIG_STACKDEPOT=y
> CONFIG_STACKDEPOT_ALWAYS_INIT=y
> CONFIG_STACK_HASH_ORDER=20
> CONFIG_SBITMAP=y
> # end of Library routines
> 
> CONFIG_ASN1_ENCODER=m
> 
> #
> # Kernel hacking
> #
> 
> #
> # printk and dmesg options
> #
> CONFIG_PRINTK_TIME=y
> CONFIG_PRINTK_CALLER=y
> CONFIG_STACKTRACE_BUILD_ID=y
> CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
> CONFIG_CONSOLE_LOGLEVEL_QUIET=4
> CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
> # CONFIG_BOOT_PRINTK_DELAY is not set
> # CONFIG_DYNAMIC_DEBUG is not set
> # CONFIG_DYNAMIC_DEBUG_CORE is not set
> # CONFIG_SYMBOLIC_ERRNAME is not set
> CONFIG_DEBUG_BUGVERBOSE=y
> # end of printk and dmesg options
> 
> #
> # Compile-time checks and compiler options
> #
> CONFIG_DEBUG_INFO=y
> CONFIG_DEBUG_INFO_REDUCED=y
> # CONFIG_DEBUG_INFO_COMPRESSED is not set
> # CONFIG_DEBUG_INFO_SPLIT is not set
> CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
> # CONFIG_DEBUG_INFO_DWARF4 is not set
> # CONFIG_DEBUG_INFO_DWARF5 is not set
> CONFIG_PAHOLE_HAS_SPLIT_BTF=y
> # CONFIG_GDB_SCRIPTS is not set
> CONFIG_FRAME_WARN=1024
> CONFIG_STRIP_ASM_SYMS=y
> # CONFIG_READABLE_ASM is not set
> # CONFIG_HEADERS_INSTALL is not set
> CONFIG_DEBUG_SECTION_MISMATCH=y
> CONFIG_SECTION_MISMATCH_WARN_ONLY=y
> CONFIG_FRAME_POINTER=y
> # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
> # end of Compile-time checks and compiler options
> 
> #
> # Generic Kernel Debugging Instruments
> #
> CONFIG_MAGIC_SYSRQ=y
> CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
> CONFIG_MAGIC_SYSRQ_SERIAL=y
> CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
> CONFIG_DEBUG_FS=y
> CONFIG_DEBUG_FS_ALLOW_ALL=y
> # CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
> # CONFIG_DEBUG_FS_ALLOW_NONE is not set
> CONFIG_HAVE_ARCH_KGDB=y
> # CONFIG_KGDB is not set
> CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
> CONFIG_UBSAN=y
> # CONFIG_UBSAN_TRAP is not set
> CONFIG_CC_HAS_UBSAN_BOUNDS=y
> CONFIG_UBSAN_BOUNDS=y
> CONFIG_UBSAN_ONLY_BOUNDS=y
> CONFIG_UBSAN_SHIFT=y
> # CONFIG_UBSAN_DIV_ZERO is not set
> CONFIG_UBSAN_UNREACHABLE=y
> # CONFIG_UBSAN_BOOL is not set
> # CONFIG_UBSAN_ENUM is not set
> # CONFIG_UBSAN_ALIGNMENT is not set
> CONFIG_UBSAN_SANITIZE_ALL=y
> # CONFIG_TEST_UBSAN is not set
> # end of Generic Kernel Debugging Instruments
> 
> CONFIG_DEBUG_KERNEL=y
> CONFIG_DEBUG_MISC=y
> 
> #
> # Networking Debugging
> #
> # CONFIG_NET_DEV_REFCNT_TRACKER is not set
> # CONFIG_NET_NS_REFCNT_TRACKER is not set
> # end of Networking Debugging
> 
> #
> # Memory Debugging
> #
> CONFIG_PAGE_EXTENSION=y
> # CONFIG_DEBUG_PAGEALLOC is not set
> # CONFIG_PAGE_OWNER is not set
> # CONFIG_PAGE_POISONING is not set
> # CONFIG_DEBUG_PAGE_REF is not set
> # CONFIG_DEBUG_RODATA_TEST is not set
> CONFIG_ARCH_HAS_DEBUG_WX=y
> # CONFIG_DEBUG_WX is not set
> CONFIG_GENERIC_PTDUMP=y
> CONFIG_PTDUMP_CORE=y
> # CONFIG_PTDUMP_DEBUGFS is not set
> # CONFIG_DEBUG_OBJECTS is not set
> CONFIG_SLUB_DEBUG_ON=y
> CONFIG_SLUB_STATS=y
> CONFIG_HAVE_DEBUG_KMEMLEAK=y
> # CONFIG_DEBUG_KMEMLEAK is not set
> # CONFIG_DEBUG_STACK_USAGE is not set
> # CONFIG_SCHED_STACK_END_CHECK is not set
> CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
> # CONFIG_DEBUG_VM is not set
> CONFIG_DEBUG_VM_PGTABLE=y
> CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
> # CONFIG_DEBUG_VIRTUAL is not set
> CONFIG_DEBUG_MEMORY_INIT=y
> # CONFIG_DEBUG_KMAP_LOCAL is not set
> CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
> # CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is not set
> # CONFIG_DEBUG_HIGHMEM is not set
> CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
> # CONFIG_DEBUG_STACKOVERFLOW is not set
> CONFIG_CC_HAS_KASAN_GENERIC=y
> CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
> CONFIG_HAVE_ARCH_KFENCE=y
> CONFIG_KFENCE=y
> CONFIG_KFENCE_SAMPLE_INTERVAL=100
> CONFIG_KFENCE_NUM_OBJECTS=255
> CONFIG_KFENCE_STRESS_TEST_FAULTS=0
> # end of Memory Debugging
> 
> # CONFIG_DEBUG_SHIRQ is not set
> 
> #
> # Debug Oops, Lockups and Hangs
> #
> CONFIG_PANIC_ON_OOPS=y
> CONFIG_PANIC_ON_OOPS_VALUE=1
> CONFIG_PANIC_TIMEOUT=0
> CONFIG_LOCKUP_DETECTOR=y
> CONFIG_SOFTLOCKUP_DETECTOR=y
> # CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
> # CONFIG_HARDLOCKUP_DETECTOR is not set
> CONFIG_DETECT_HUNG_TASK=y
> CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
> # CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
> CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
> CONFIG_WQ_WATCHDOG=y
> # CONFIG_TEST_LOCKUP is not set
> # end of Debug Oops, Lockups and Hangs
> 
> #
> # Scheduler Debugging
> #
> CONFIG_SCHED_DEBUG=y
> CONFIG_SCHED_INFO=y
> CONFIG_SCHEDSTATS=y
> # end of Scheduler Debugging
> 
> CONFIG_DEBUG_TIMEKEEPING=y
> 
> #
> # Lock Debugging (spinlocks, mutexes, etc...)
> #
> CONFIG_LOCK_DEBUGGING_SUPPORT=y
> CONFIG_PROVE_LOCKING=y
> # CONFIG_PROVE_RAW_LOCK_NESTING is not set
> # CONFIG_LOCK_STAT is not set
> CONFIG_DEBUG_RT_MUTEXES=y
> CONFIG_DEBUG_SPINLOCK=y
> CONFIG_DEBUG_MUTEXES=y
> CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
> CONFIG_DEBUG_RWSEMS=y
> CONFIG_DEBUG_LOCK_ALLOC=y
> CONFIG_LOCKDEP=y
> CONFIG_LOCKDEP_BITS=15
> CONFIG_LOCKDEP_CHAINS_BITS=16
> CONFIG_LOCKDEP_STACK_TRACE_BITS=19
> CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
> CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
> # CONFIG_DEBUG_LOCKDEP is not set
> CONFIG_DEBUG_ATOMIC_SLEEP=y
> # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
> CONFIG_LOCK_TORTURE_TEST=m
> # CONFIG_WW_MUTEX_SELFTEST is not set
> # CONFIG_SCF_TORTURE_TEST is not set
> # end of Lock Debugging (spinlocks, mutexes, etc...)
> 
> CONFIG_TRACE_IRQFLAGS=y
> CONFIG_TRACE_IRQFLAGS_NMI=y
> # CONFIG_DEBUG_IRQFLAGS is not set
> CONFIG_STACKTRACE=y
> CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
> # CONFIG_DEBUG_KOBJECT is not set
> 
> #
> # Debug kernel data structures
> #
> # CONFIG_DEBUG_LIST is not set
> # CONFIG_DEBUG_PLIST is not set
> # CONFIG_DEBUG_SG is not set
> # CONFIG_DEBUG_NOTIFIERS is not set
> # CONFIG_BUG_ON_DATA_CORRUPTION is not set
> # end of Debug kernel data structures
> 
> # CONFIG_DEBUG_CREDENTIALS is not set
> 
> #
> # RCU Debugging
> #
> CONFIG_PROVE_RCU=y
> CONFIG_TORTURE_TEST=m
> CONFIG_RCU_SCALE_TEST=m
> CONFIG_RCU_TORTURE_TEST=m
> # CONFIG_RCU_REF_SCALE_TEST is not set
> # CONFIG_RCU_TRACE is not set
> # CONFIG_RCU_EQS_DEBUG is not set
> # end of RCU Debugging
> 
> # CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
> CONFIG_LATENCYTOP=y
> CONFIG_USER_STACKTRACE_SUPPORT=y
> CONFIG_NOP_TRACER=y
> CONFIG_HAVE_FUNCTION_TRACER=y
> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> CONFIG_HAVE_DYNAMIC_FTRACE=y
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
> CONFIG_HAVE_C_RECORDMCOUNT=y
> CONFIG_BUILDTIME_MCOUNT_SORT=y
> CONFIG_TRACE_CLOCK=y
> CONFIG_RING_BUFFER=y
> CONFIG_EVENT_TRACING=y
> CONFIG_CONTEXT_SWITCH_TRACER=y
> CONFIG_PREEMPTIRQ_TRACEPOINTS=y
> CONFIG_TRACING=y
> CONFIG_TRACING_SUPPORT=y
> # CONFIG_FTRACE is not set
> # CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
> # CONFIG_SAMPLES is not set
> CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
> # CONFIG_STRICT_DEVMEM is not set
> 
> #
> # x86 Debugging
> #
> CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
> CONFIG_EARLY_PRINTK_USB=y
> CONFIG_X86_VERBOSE_BOOTUP=y
> CONFIG_EARLY_PRINTK=y
> CONFIG_EARLY_PRINTK_DBGP=y
> CONFIG_EARLY_PRINTK_USB_XDBC=y
> CONFIG_EFI_PGT_DUMP=y
> # CONFIG_DEBUG_TLBFLUSH is not set
> CONFIG_HAVE_MMIOTRACE_SUPPORT=y
> # CONFIG_X86_DECODER_SELFTEST is not set
> # CONFIG_IO_DELAY_0X80 is not set
> # CONFIG_IO_DELAY_0XED is not set
> CONFIG_IO_DELAY_UDELAY=y
> # CONFIG_IO_DELAY_NONE is not set
> # CONFIG_DEBUG_BOOT_PARAMS is not set
> # CONFIG_CPA_DEBUG is not set
> # CONFIG_DEBUG_ENTRY is not set
> CONFIG_X86_DEBUG_FPU=y
> # CONFIG_PUNIT_ATOM_DEBUG is not set
> CONFIG_UNWINDER_FRAME_POINTER=y
> # end of x86 Debugging
> 
> #
> # Kernel Testing and Coverage
> #
> # CONFIG_KUNIT is not set
> # CONFIG_NOTIFIER_ERROR_INJECTION is not set
> CONFIG_FUNCTION_ERROR_INJECTION=y
> # CONFIG_FAULT_INJECTION is not set
> CONFIG_CC_HAS_SANCOV_TRACE_PC=y
> # CONFIG_RUNTIME_TESTING_MENU is not set
> CONFIG_ARCH_USE_MEMTEST=y
> CONFIG_MEMTEST=y
> # end of Kernel Testing and Coverage
> # end of Kernel hacking

> #!/bin/sh
> 
> export_top_env()
> {
> 	export suite='rcutorture'
> 	export testcase='rcutorture'
> 	export category='functional'
> 	export need_memory='300MB'
> 	export runtime=300
> 	export job_origin='rcutorture.yaml'
> 	export queue_cmdline_keys='branch
> commit'
> 	export queue='validate'
> 	export testbox='vm-snb-i386-129'
> 	export tbox_group='vm-snb-i386'
> 	export branch='vbabka/slub-stackdepot-v3r1'
> 	export commit='555b8c8cb3f335ec8fd9d1ffd25e1395790d102d'
> 	export kconfig='i386-randconfig-a004-20220314'
> 	export nr_vm=160
> 	export submit_id='623a82e3bf36902a2008661c'
> 	export job_file='/lkp/jobs/scheduled/vm-snb-i386-129/rcutorture-300s-cpuhotplug-tasks-debian-i386-20191205.cgz-555b8c8cb3f335ec8fd9d1ffd25e1395790d102d-20220323-76320-4rvhyt-25.yaml'
> 	export id='c22042fb112ba6a0bc489bdf55cde4e35922d75e'
> 	export queuer_version='/lkp-src'
> 	export model='qemu-system-i386 -enable-kvm -cpu SandyBridge'
> 	export nr_cpu=2
> 	export memory='4G'
> 	export need_kconfig=\{\"RCU_TORTURE_TEST\"\=\>\"m\"\}'
> '\{\"SECURITY_LOADPIN_ENABLED\"\=\>\"n,\ \<\=\ v4.19\"\}'
> '\{\"SECURITY_LOADPIN_ENFORCE\"\=\>\"n,\ v4.20\"\}'
> '\{\"MODULE_UNLOAD\"\=\>\"y\"\}'
> '\{\"KVM_GUEST\"\=\>\"y\"\}
> 	export ssh_base_port=23400
> 	export kernel_cmdline='vmalloc=128M initramfs_async=0 page_owner=on'
> 	export rootfs='debian-i386-20191205.cgz'
> 	export compiler='gcc-9'
> 	export enqueue_time='2022-03-23 10:16:03 +0800'
> 	export _id='623a82f9bf36902a20086625'
> 	export _rt='/result/rcutorture/300s-cpuhotplug-tasks/vm-snb-i386/debian-i386-20191205.cgz/i386-randconfig-a004-20220314/gcc-9/555b8c8cb3f335ec8fd9d1ffd25e1395790d102d'
> 	export user='lkp'
> 	export LKP_SERVER='internal-lkp-server'
> 	export result_root='/result/rcutorture/300s-cpuhotplug-tasks/vm-snb-i386/debian-i386-20191205.cgz/i386-randconfig-a004-20220314/gcc-9/555b8c8cb3f335ec8fd9d1ffd25e1395790d102d/22'
> 	export scheduler_version='/lkp/lkp/.src-20220323-100648'
> 	export arch='i386'
> 	export max_uptime=2100
> 	export initrd='/osimage/debian/debian-i386-20191205.cgz'
> 	export bootloader_append='root=/dev/ram0
> RESULT_ROOT=/result/rcutorture/300s-cpuhotplug-tasks/vm-snb-i386/debian-i386-20191205.cgz/i386-randconfig-a004-20220314/gcc-9/555b8c8cb3f335ec8fd9d1ffd25e1395790d102d/22
> BOOT_IMAGE=/pkg/linux/i386-randconfig-a004-20220314/gcc-9/555b8c8cb3f335ec8fd9d1ffd25e1395790d102d/vmlinuz-5.17.0-rc1-00003-g555b8c8cb3f3
> branch=vbabka/slub-stackdepot-v3r1
> job=/lkp/jobs/scheduled/vm-snb-i386-129/rcutorture-300s-cpuhotplug-tasks-debian-i386-20191205.cgz-555b8c8cb3f335ec8fd9d1ffd25e1395790d102d-20220323-76320-4rvhyt-25.yaml
> user=lkp
> ARCH=i386
> kconfig=i386-randconfig-a004-20220314
> commit=555b8c8cb3f335ec8fd9d1ffd25e1395790d102d
> vmalloc=128M initramfs_async=0 page_owner=on
> max_uptime=2100
> LKP_SERVER=internal-lkp-server
> selinux=0
> debug
> apic=debug
> sysrq_always_enabled
> rcupdate.rcu_cpu_stall_timeout=100
> net.ifnames=0
> printk.devkmsg=on
> panic=-1
> softlockup_panic=1
> nmi_watchdog=panic
> oops=panic
> load_ramdisk=2
> prompt_ramdisk=0
> drbd.minor_count=8
> systemd.log_level=err
> ignore_loglevel
> console=tty0
> earlyprintk=ttyS0,115200
> console=ttyS0,115200
> vga=normal
> rw'
> 	export modules_initrd='/pkg/linux/i386-randconfig-a004-20220314/gcc-9/555b8c8cb3f335ec8fd9d1ffd25e1395790d102d/modules.cgz'
> 	export bm_initrd='/osimage/deps/debian-i386-20191205.cgz/lkp_20201203.cgz'
> 	export lkp_initrd='/osimage/user/lkp/lkp-i386.cgz'
> 	export site='inn'
> 	export LKP_CGI_PORT=80
> 	export LKP_CIFS_PORT=139
> 	export repeat_to=32
> 	export schedule_notify_address=
> 	export kernel='/pkg/linux/i386-randconfig-a004-20220314/gcc-9/555b8c8cb3f335ec8fd9d1ffd25e1395790d102d/vmlinuz-5.17.0-rc1-00003-g555b8c8cb3f3'
> 	export dequeue_time='2022-03-23 10:17:55 +0800'
> 	export job_initrd='/lkp/jobs/scheduled/vm-snb-i386-129/rcutorture-300s-cpuhotplug-tasks-debian-i386-20191205.cgz-555b8c8cb3f335ec8fd9d1ffd25e1395790d102d-20220323-76320-4rvhyt-25.cgz'
> 
> 	[ -n "$LKP_SRC" ] ||
> 	export LKP_SRC=/lkp/${user:-lkp}/src
> }
> 
> run_job()
> {
> 	echo $$ > $TMP/run-job.pid
> 
> 	. $LKP_SRC/lib/http.sh
> 	. $LKP_SRC/lib/job.sh
> 	. $LKP_SRC/lib/env.sh
> 
> 	export_top_env
> 
> 	run_monitor $LKP_SRC/monitors/wrapper kmsg
> 	run_monitor $LKP_SRC/monitors/wrapper heartbeat
> 	run_monitor $LKP_SRC/monitors/wrapper meminfo
> 	run_monitor $LKP_SRC/monitors/wrapper oom-killer
> 	run_monitor $LKP_SRC/monitors/plain/watchdog
> 
> 	run_test test='cpuhotplug' torture_type='tasks' $LKP_SRC/tests/wrapper rcutorture
> }
> 
> extract_stats()
> {
> 	export stats_part_begin=
> 	export stats_part_end=
> 
> 	env test='cpuhotplug' torture_type='tasks' $LKP_SRC/stats/wrapper rcutorture
> 	$LKP_SRC/stats/wrapper kmsg
> 	$LKP_SRC/stats/wrapper meminfo
> 
> 	$LKP_SRC/stats/wrapper time rcutorture.time
> 	$LKP_SRC/stats/wrapper dmesg
> 	$LKP_SRC/stats/wrapper kmsg
> 	$LKP_SRC/stats/wrapper last_state
> 	$LKP_SRC/stats/wrapper stderr
> 	$LKP_SRC/stats/wrapper time
> }
> 
> "$@"


> 2022-03-23 02:18:35 modprobe rcutorture onoff_interval=3 onoff_holdoff=30 torture_type=tasks
> 2022-03-23 02:18:35 sleep 300
> 2022-03-23 02:23:35 rmmod rcutorture
> [   18.040468] tasks-torture:--- Start of test: nreaders=1 nfakewriters=4 stat_interval=60 verbose=1 test_no_idle_hz=1 shuffle_interval=3 stutter=5 irqreader=1 fqs_duration=0 fqs_holdoff=0 fqs_stutter=3 test_boost=1/0 test_boost_interval=7 test_boost_duration=4 shutdown_secs=0 stall_cpu=0 stall_cpu_holdoff=10 stall_cpu_irqsoff=0 stall_cpu_block=0 n_barrier_cbs=0 onoff_interval=3 onoff_holdoff=30 read_exit_delay=13 read_exit_burst=16 nocbs_nthreads=0 nocbs_toggle=1000
> [   18.046148] tasks-torture: Creating rcu_torture_writer task
> [   18.075572] tasks-torture: Creating rcu_torture_fakewriter task
> [   18.076426] tasks-torture: rcu_torture_writer task started
> [   18.076993] tasks-torture: GP expediting controlled from boot/sysfs for tasks.
> [   18.077785] tasks-torture: Creating rcu_torture_fakewriter task
> [   18.078407] tasks-torture: rcu_torture_fakewriter task started
> [   18.079008] tasks-torture: Creating rcu_torture_fakewriter task
> [   18.079630] tasks-torture: rcu_torture_fakewriter task started
> [   18.080225] tasks-torture: Creating rcu_torture_fakewriter task
> [   18.080866] tasks-torture: rcu_torture_fakewriter task started
> [   18.091986] tasks-torture: Creating rcu_torture_reader task
> [   18.092673] tasks-torture: rcu_torture_fakewriter task started
> [   18.093275] tasks-torture: Creating rcu_torture_stats task
> [   18.093870] tasks-torture: rcu_torture_reader task started
> [   18.098748] tasks-torture: Creating torture_shuffle task
> [   18.099366] tasks-torture: rcu_torture_stats task started
> [   18.107324] tasks-torture: Creating torture_stutter task
> [   18.107972] tasks-torture: torture_shuffle task started
> [   18.117163] tasks-torture: rcu_torture_fwd_prog_init: Limiting fwd_progress to # CPUs.
> [   18.118151] tasks-torture: rcu_torture_fwd_prog_init: Disabled, unsupported by RCU flavor under test
> [   18.119000] tasks-torture: Creating rcu_torture_read_exit task
> [   18.119634] tasks-torture: torture_stutter task started
> [   18.121854] tasks-torture: rcu_torture_read_exit: Start of test
> [   23.485403] tasks-torture: rcu_torture_read_exit: End of episode
> [   37.094692] tasks-torture: rcu_torture_read_exit: Start of episode
> [   37.174939] tasks-torture: rcu_torture_read_exit: End of episode
> [   51.425013] tasks-torture: rcu_torture_read_exit: Start of episode
> [   53.196427] tasks-torture: rcu_torture_read_exit: End of episode
> [   66.963911] tasks-torture: rcu_torture_read_exit: Start of episode
> [   66.967746] tasks-torture: rcu_torture_read_exit: End of episode
> [   80.523487] tasks-torture: rcu_torture_read_exit: Start of episode
> [   81.243474] tasks-torture: rtc: f7513624 ver: 132 tfle: 0 rta: 132 rtaf: 0 rtf: 123 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 759 barrier: 0/0:0 read-exits: 68 nocb-toggles: 0:0
> [   81.246883] tasks-torture: Reader Pipe:  15634400 0 0 0 0 0 0 0 0 0 0
> [   81.248077] tasks-torture: Reader Batch:  15634400 0 0 0 0 0 0 0 0 0 0
> [   81.249528] tasks-torture: Free-Block Circulation:  131 131 130 129 128 127 126 125 124 123 0
> [   83.245694] tasks-torture: rcu_torture_read_exit: End of episode
> [   97.102976] tasks-torture: rcu_torture_read_exit: Start of episode
> [   97.106741] tasks-torture: rcu_torture_read_exit: End of episode
> [  110.922622] tasks-torture: rcu_torture_read_exit: Start of episode
> [  113.492006] tasks-torture: rcu_torture_read_exit: End of episode
> [  127.372129] tasks-torture: rcu_torture_read_exit: Start of episode
> [  127.385908] tasks-torture: rcu_torture_read_exit: End of episode
> [  141.152066] tasks-torture: rcu_torture_read_exit: Start of episode
> [  143.071702] tasks-torture: rtc: f7513d08 ver: 292 tfle: 0 rta: 292 rtaf: 0 rtf: 283 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 1940 barrier: 0/0:0 read-exits: 136 nocb-toggles: 0:0
> [  143.075769] tasks-torture: Reader Pipe:  38409326 0 0 0 0 0 0 0 0 0 0
> [  143.077168] tasks-torture: Reader Batch:  38409326 0 0 0 0 0 0 0 0 0 0
> [  143.078509] tasks-torture: Free-Block Circulation:  291 291 290 289 288 287 286 285 284 283 0
> [  143.684331] tasks-torture: rcu_torture_read_exit: End of episode
> [  157.946436] tasks-torture: rcu_torture_read_exit: Start of episode
> [  157.950429] tasks-torture: rcu_torture_read_exit: End of episode
> [  171.510857] tasks-torture: rcu_torture_read_exit: Start of episode
> [  173.863192] tasks-torture: rcu_torture_read_exit: End of episode
> [  187.577288] tasks-torture: rcu_torture_read_exit: Start of episode
> [  187.599735] tasks-torture: rcu_torture_read_exit: End of episode
> [  203.969936] tasks-torture: rcu_torture_read_exit: Start of episode
> [  204.391993] tasks-torture: rcu_torture_read_exit: End of episode
> [  207.599784] tasks-torture: rtc: f7513a14 ver: 474 tfle: 0 rta: 475 rtaf: 0 rtf: 457 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 3022 barrier: 0/0:0 read-exits: 220 nocb-toggles: 0:0
> [  207.602216] tasks-torture: Reader Pipe:  61571337 0 0 0 0 0 0 0 0 0 0
> [  207.603225] tasks-torture: Reader Batch:  61571337 0 0 0 0 0 0 0 0 0 0
> [  207.604266] tasks-torture: Free-Block Circulation:  474 473 469 467 466 465 463 459 458 457 0
> [  218.009503] tasks-torture: rcu_torture_read_exit: Start of episode
> [  218.016359] tasks-torture: rcu_torture_read_exit: End of episode
> [  232.029040] tasks-torture: rcu_torture_read_exit: Start of episode
> [  234.656530] tasks-torture: rcu_torture_read_exit: End of episode
> [  248.298583] tasks-torture: rcu_torture_read_exit: Start of episode
> [  248.312720] tasks-torture: rcu_torture_read_exit: End of episode
> [  262.158221] tasks-torture: rcu_torture_read_exit: Start of episode
> [  264.850689] tasks-torture: rcu_torture_read_exit: End of episode
> [  269.545749] tasks-torture: rtc: f7513694 ver: 643 tfle: 0 rta: 644 rtaf: 0 rtf: 631 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 4205 barrier: 0/0:0 read-exits: 288 nocb-toggles: 0:0
> [  269.549182] tasks-torture: Reader Pipe:  83224300 0 0 0 0 0 0 0 0 0 0
> [  269.550432] tasks-torture: Reader Batch:  83224300 0 0 0 0 0 0 0 0 0 0
> [  269.551758] tasks-torture: Free-Block Circulation:  643 642 640 639 638 637 634 633 632 631 0
> [  278.677655] tasks-torture: rcu_torture_read_exit: Start of episode
> [  278.681017] tasks-torture: rcu_torture_read_exit: End of episode
> [  292.742541] tasks-torture: rcu_torture_read_exit: Start of episode
> [  294.907579] tasks-torture: rcu_torture_read_exit: End of episode
> [  308.796167] tasks-torture: rcu_torture_read_exit: Start of episode
> [  308.800302] tasks-torture: rcu_torture_read_exit: End of episode
> [  318.174095] tasks-torture: Stopping torture_shuffle task
> [  318.175385] tasks-torture: Stopping torture_shuffle
> [  318.180138] tasks-torture: Stopping torture_stutter task
> [  318.181387] tasks-torture: Stopping torture_stutter
> [  318.182636] tasks-torture: Stopping rcu_torture_reader
> [  318.226676] tasks-torture: Stopping rcu_torture_read_exit
> [  318.227939] tasks-torture: Stopping rcutorture_read_exit task
> [  318.229195] tasks-torture: Stopping rcu_torture_writer task
> [  318.246520] tasks-torture: Stopping rcu_torture_fakewriter
> [  318.376621] tasks-torture: Dynamic grace-period expediting was disabled.
> [  318.378103] tasks-torture: Stopping rcu_torture_writer
> [  318.379104] tasks-torture: Stopping rcu_torture_reader task
> [  318.380229] tasks-torture: Stopping rcu_torture_fakewriter
> [  318.381192] tasks-torture: Stopping rcu_torture_fakewriter
> [  318.382174] tasks-torture: Stopping rcu_torture_fakewriter
> [  318.383372] tasks-torture: Stopping rcu_torture_fakewriter task
> [  318.384733] tasks-torture: Stopping rcu_torture_fakewriter task
> [  318.386024] tasks-torture: Stopping rcu_torture_fakewriter task
> [  318.404594] tasks-torture: Stopping rcu_torture_fakewriter task
> [  318.407345] tasks-torture: Stopping rcu_torture_stats task
> [  318.413027] tasks-torture: rtc: 00000000 VER: 782 tfle: 0 rta: 782 rtaf: 0 rtf: 772 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 5058 barrier: 0/0:0 read-exits: 339 nocb-toggles: 0:0
> [  318.416674] tasks-torture: Reader Pipe:  99476015 0 0 0 0 0 0 0 0 0 0
> [  318.418078] tasks-torture: Reader Batch:  99476015 0 0 0 0 0 0 0 0 0 0
> [  318.419514] tasks-torture: Free-Block Circulation:  781 781 779 778 777 776 775 774 773 772 0
> [  318.421299] tasks-torture: Stopping rcu_torture_stats
> [  319.028923] tasks-torture: rtc: 00000000 VER: 782 tfle: 0 rta: 782 rtaf: 0 rtf: 772 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 5058 barrier: 0/0:0 read-exits: 339 nocb-toggles: 0:0
> [  319.032352] tasks-torture: Reader Pipe:  99476015 0 0 0 0 0 0 0 0 0 0
> [  319.033727] tasks-torture: Reader Batch:  99476015 0 0 0 0 0 0 0 0 0 0
> [  319.035188] tasks-torture: Free-Block Circulation:  781 781 779 778 777 776 775 774 773 772 0
> [  319.037158] tasks-torture:--- End of test: SUCCESS: nreaders=1 nfakewriters=4 stat_interval=60 verbose=1 test_no_idle_hz=1 shuffle_interval=3 stutter=5 irqreader=1 fqs_duration=0 fqs_holdoff=0 fqs_stutter=3 test_boost=1/0 test_boost_interval=7 test_boost_duration=4 shutdown_secs=0 stall_cpu=0 stall_cpu_holdoff=10 stall_cpu_irqsoff=0 stall_cpu_block=0 n_barrier_cbs=0 onoff_interval=3 onoff_holdoff=30 read_exit_delay=13 read_exit_burst=16 nocbs_nthreads=0 nocbs_toggle=1000

