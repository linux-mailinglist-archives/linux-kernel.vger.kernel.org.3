Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE339466F6F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 02:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237498AbhLCCCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 21:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhLCCCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 21:02:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB757C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 17:59:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BD70628FC
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 01:59:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBA7C00446;
        Fri,  3 Dec 2021 01:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638496754;
        bh=/TWekCuW1FvGBFWPjKbpr7DX/IcHVREl0aLY2DA5WvA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=OPd6RjOpxLChaklnIE0MBbjis4YbHn8amI7PCUwDjTAVWW7wWwN1oVLFgx2GqU8fr
         DAIdptrqAdw1FNc0eTj6mx9UH/FGWXrXUepmrtzs8iP4j1rPByTfubhUSVVmUBhDxY
         vvn1403FZjy+fkckm7SkxzARGbxOdf+8cQQCIkZAlz58TW2DgH41tWVGXAJzqZQzf4
         km4YUZ6dxWY3sonHVOgeMCKyO1IKVud44n6GAofdBR5iHICLMX0bEUAnc6iAF1XbTb
         UpyJEEYF5YYtbUf3hmt0fjIn9PF0MRjH4rkzsbiPzAwgHpbN3Kx3gfYN3fzGXfLA5E
         JtSBUrHLyX0zw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7FADF5C0FA2; Thu,  2 Dec 2021 17:59:14 -0800 (PST)
Date:   Thu, 2 Dec 2021 17:59:14 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: Re: [rcutorture]  46faccd527:
 WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_writer[rcutorture]
Message-ID: <20211203015914.GP641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211203011548.GA5881@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203011548.GA5881@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 09:15:48AM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 46faccd52724dc4f779da6c328b8d894846b8e30 ("rcutorture: More thoroughly test nested readers")
> https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git dev.2021.11.30b
> 
> in testcase: rcutorture
> version: 
> with following parameters:
> 
> 	runtime: 300s
> 	test: default
> 	torture_type: srcu
> 
> test-description: rcutorture is rcutorture kernel module load/unload test.
> test-url: https://www.kernel.org/doc/Documentation/RCU/torture.txt
> 
> 
> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):

Good catch!  This was due to a bug in Tiny SRCU, which has since been
fixed by 1f8da406a964 ("srcu: Prevent redundant __srcu_read_unlock()
wakeup").  Another related commit is 340170fef01b ("rcutorture: Suppress
pi-lock-across read-unlock testing for Tiny SRCU").

							Thanx, Paul

> +--------------------------------------------------------------------+------------+------------+
> |                                                                    | bcc46f0b2a | 46faccd527 |
> +--------------------------------------------------------------------+------------+------------+
> | boot_successes                                                     | 55         | 35         |
> | boot_failures                                                      | 0          | 20         |
> | WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_writer[rcutorture] | 0          | 20         |
> | EIP:rcu_torture_writer                                             | 0          | 20         |
> | calltrace:do_softirq_own_stack                                     | 0          | 12         |
> +--------------------------------------------------------------------+------------+------------+
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> 
> [  325.115664][  T529] ------------[ cut here ]------------
> [  325.116845][  T529] rcu_torture_writer: rtort_pipe_count: 4
> [  325.117999][  T529] WARNING: CPU: 0 PID: 529 at kernel/rcu/rcutorture.c:1278 rcu_torture_writer+0x590/0x6f0 [rcutorture]
> [  325.120374][  T529] Modules linked in: rcutorture torture
> [  325.121573][  T529] CPU: 0 PID: 529 Comm: rcu_torture_wri Not tainted 5.16.0-rc1-00037-g46faccd52724 #1 b5cf7d385afc57ab3fa152cf43de31cbfe88ce04
> [  325.124250][  T529] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [  325.126067][  T529] EIP: rcu_torture_writer+0x590/0x6f0 [rcutorture]
> [  325.127582][  T529] Code: b8 01 00 00 00 87 05 70 a1 72 f7 85 c0 74 2b 83 ff 63 0f 87 20 01 00 00 ff 73 fc 68 9c 7b 72 f7 68 d4 75 72 f7 e8 9d ef 31 ca <0f> 0b 83
> c4 0c eb 89 8d b4 26 00 00 00 00 66 90 e8 9b 8d 9e c9 8b
> [  325.131635][  T529] EAX: 00000027 EBX: f772b034 ECX: c2351948 EDX: 00000001
> [  325.133071][  T529] ESI: 00000000 EDI: 00000046 EBP: f40cdf8c ESP: f40cdf5c
> [  325.134455][  T529] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010292
> [  325.136123][  T529] CR0: 80050033 CR2: b7219000 CR3: 357c6000 CR4: 000006b0
> [  325.137479][  T529] Call Trace:
> [  325.138064][  T529]  kthread+0x12c/0x150
> [  325.138649][  T529]  ? rcu_torture_pipe_update+0x120/0x120 [rcutorture a8481dc77ce1197ae1610575a1871655600ee491]
> [  325.141288][  T529]  ? set_kthread_struct+0x40/0x40
> [  325.142308][  T529]  ret_from_fork+0x19/0x24
> [  325.143277][  T529] irq event stamp: 121029
> [  325.144291][  T529] hardirqs last  enabled at (121039): [<c10a519e>] __up_console_sem+0x4e/0x60
> [  325.145984][  T529] hardirqs last disabled at (121046): [<c10a5185>] __up_console_sem+0x35/0x60
> [  325.147915][  T529] softirqs last  enabled at (120862): [<c1ad4f1a>] __do_softirq+0x2aa/0x466
> [  325.149575][  T529] softirqs last disabled at (120761): [<c101f406>] do_softirq_own_stack+0x26/0x30
> [  325.151630][  T529] ---[ end trace ffb013ff47f63253 ]---
> 
> 
> 
> To reproduce:
> 
>         # build kernel
> 	cd linux
> 	cp config-5.16.0-rc1-00037-g46faccd52724 .config
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
> ---
> 0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
> https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation
> 
> Thanks,
> Oliver Sang
> 

> #
> # Automatically generated file; DO NOT EDIT.
> # Linux/i386 5.16.0-rc1 Kernel Configuration
> #
> CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-22) 9.3.0"
> CONFIG_CC_IS_GCC=y
> CONFIG_GCC_VERSION=90300
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
> CONFIG_CONSTRUCTORS=y
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
> CONFIG_KERNEL_XZ=y
> # CONFIG_KERNEL_LZO is not set
> # CONFIG_KERNEL_LZ4 is not set
> # CONFIG_KERNEL_ZSTD is not set
> CONFIG_DEFAULT_INIT=""
> CONFIG_DEFAULT_HOSTNAME="(none)"
> CONFIG_SYSVIPC=y
> CONFIG_SYSVIPC_SYSCTL=y
> # CONFIG_POSIX_MQUEUE is not set
> CONFIG_WATCH_QUEUE=y
> # CONFIG_CROSS_MEMORY_ATTACH is not set
> # CONFIG_USELIB is not set
> # CONFIG_AUDIT is not set
> CONFIG_HAVE_ARCH_AUDITSYSCALL=y
> 
> #
> # IRQ subsystem
> #
> CONFIG_GENERIC_IRQ_PROBE=y
> CONFIG_GENERIC_IRQ_SHOW=y
> CONFIG_HARDIRQS_SW_RESEND=y
> CONFIG_GENERIC_IRQ_CHIP=y
> CONFIG_IRQ_DOMAIN=y
> CONFIG_IRQ_DOMAIN_HIERARCHY=y
> CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
> CONFIG_IRQ_FORCED_THREADING=y
> CONFIG_SPARSE_IRQ=y
> # CONFIG_GENERIC_IRQ_DEBUGFS is not set
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
> # CONFIG_TIME_KUNIT_TEST is not set
> 
> #
> # Timers subsystem
> #
> CONFIG_TICK_ONESHOT=y
> CONFIG_NO_HZ_COMMON=y
> # CONFIG_HZ_PERIODIC is not set
> CONFIG_NO_HZ_IDLE=y
> # CONFIG_NO_HZ is not set
> CONFIG_HIGH_RES_TIMERS=y
> # end of Timers subsystem
> 
> CONFIG_BPF=y
> CONFIG_HAVE_EBPF_JIT=y
> 
> #
> # BPF subsystem
> #
> # CONFIG_BPF_SYSCALL is not set
> # CONFIG_BPF_JIT is not set
> # end of BPF subsystem
> 
> CONFIG_PREEMPT_BUILD=y
> # CONFIG_PREEMPT_NONE is not set
> CONFIG_PREEMPT_VOLUNTARY=y
> # CONFIG_PREEMPT is not set
> CONFIG_PREEMPT_COUNT=y
> CONFIG_PREEMPTION=y
> CONFIG_PREEMPT_DYNAMIC=y
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
> CONFIG_TREE_RCU=y
> CONFIG_PREEMPT_RCU=y
> # CONFIG_RCU_EXPERT is not set
> CONFIG_SRCU=y
> CONFIG_TREE_SRCU=y
> CONFIG_TASKS_RCU_GENERIC=y
> CONFIG_TASKS_RCU=y
> CONFIG_TASKS_RUDE_RCU=y
> CONFIG_TASKS_TRACE_RCU=y
> CONFIG_RCU_STALL_COMMON=y
> CONFIG_RCU_NEED_SEGCBLIST=y
> # end of RCU Subsystem
> 
> CONFIG_IKCONFIG=y
> CONFIG_IKCONFIG_PROC=y
> # CONFIG_IKHEADERS is not set
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
> # CONFIG_CGROUP_SCHED is not set
> CONFIG_CGROUP_PIDS=y
> # CONFIG_CGROUP_RDMA is not set
> CONFIG_CGROUP_FREEZER=y
> # CONFIG_CGROUP_DEVICE is not set
> CONFIG_CGROUP_CPUACCT=y
> CONFIG_CGROUP_PERF=y
> # CONFIG_CGROUP_MISC is not set
> CONFIG_CGROUP_DEBUG=y
> # CONFIG_NAMESPACES is not set
> # CONFIG_CHECKPOINT_RESTORE is not set
> # CONFIG_SCHED_AUTOGROUP is not set
> # CONFIG_SYSFS_DEPRECATED is not set
> # CONFIG_RELAY is not set
> CONFIG_BLK_DEV_INITRD=y
> CONFIG_INITRAMFS_SOURCE=""
> CONFIG_RD_GZIP=y
> # CONFIG_RD_BZIP2 is not set
> CONFIG_RD_LZMA=y
> # CONFIG_RD_XZ is not set
> # CONFIG_RD_LZO is not set
> # CONFIG_RD_LZ4 is not set
> # CONFIG_RD_ZSTD is not set
> CONFIG_BOOT_CONFIG=y
> CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> CONFIG_LD_ORPHAN_WARN=y
> CONFIG_SYSCTL=y
> CONFIG_HAVE_UID16=y
> CONFIG_SYSCTL_EXCEPTION_TRACE=y
> CONFIG_HAVE_PCSPKR_PLATFORM=y
> CONFIG_EXPERT=y
> CONFIG_UID16=y
> CONFIG_MULTIUSER=y
> CONFIG_SGETMASK_SYSCALL=y
> CONFIG_SYSFS_SYSCALL=y
> CONFIG_FHANDLE=y
> # CONFIG_POSIX_TIMERS is not set
> CONFIG_PRINTK=y
> CONFIG_BUG=y
> CONFIG_PCSPKR_PLATFORM=y
> CONFIG_BASE_FULL=y
> CONFIG_FUTEX=y
> CONFIG_FUTEX_PI=y
> CONFIG_EPOLL=y
> CONFIG_SIGNALFD=y
> CONFIG_TIMERFD=y
> # CONFIG_EVENTFD is not set
> CONFIG_SHMEM=y
> CONFIG_AIO=y
> CONFIG_IO_URING=y
> # CONFIG_ADVISE_SYSCALLS is not set
> # CONFIG_MEMBARRIER is not set
> CONFIG_KALLSYMS=y
> CONFIG_KALLSYMS_ALL=y
> CONFIG_KALLSYMS_BASE_RELATIVE=y
> # CONFIG_USERFAULTFD is not set
> CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
> # CONFIG_KCMP is not set
> # CONFIG_RSEQ is not set
> CONFIG_EMBEDDED=y
> CONFIG_HAVE_PERF_EVENTS=y
> # CONFIG_PC104 is not set
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
> # CONFIG_SLOB is not set
> # CONFIG_SLAB_MERGE_DEFAULT is not set
> CONFIG_SLAB_FREELIST_RANDOM=y
> CONFIG_SLAB_FREELIST_HARDENED=y
> CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
> CONFIG_SYSTEM_DATA_VERIFICATION=y
> # CONFIG_PROFILING is not set
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
> CONFIG_HAVE_SETUP_PER_CPU_AREA=y
> CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
> CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
> CONFIG_ARCH_HIBERNATION_POSSIBLE=y
> CONFIG_ARCH_NR_GPIO=512
> CONFIG_ARCH_SUSPEND_POSSIBLE=y
> CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
> CONFIG_ARCH_SUPPORTS_UPROBES=y
> CONFIG_FIX_EARLYCON_MEM=y
> CONFIG_PGTABLE_LEVELS=3
> CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
> 
> #
> # Processor type and features
> #
> # CONFIG_SMP is not set
> CONFIG_X86_FEATURE_NAMES=y
> CONFIG_GOLDFISH=y
> # CONFIG_RETPOLINE is not set
> CONFIG_X86_CPU_RESCTRL=y
> # CONFIG_X86_EXTENDED_PLATFORM is not set
> # CONFIG_X86_INTEL_LPSS is not set
> # CONFIG_X86_AMD_PLATFORM_DEVICE is not set
> CONFIG_IOSF_MBI=y
> # CONFIG_IOSF_MBI_DEBUG is not set
> CONFIG_X86_32_IRIS=y
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
> # CONFIG_M586MMX is not set
> # CONFIG_M686 is not set
> CONFIG_MPENTIUMII=y
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
> CONFIG_X86_INTEL_USERCOPY=y
> CONFIG_X86_USE_PPRO_CHECKSUM=y
> CONFIG_X86_TSC=y
> CONFIG_X86_CMPXCHG64=y
> CONFIG_X86_CMOV=y
> CONFIG_X86_MINIMUM_CPU_FAMILY=6
> CONFIG_X86_DEBUGCTLMSR=y
> CONFIG_IA32_FEAT_CTL=y
> CONFIG_X86_VMX_FEATURE_NAMES=y
> CONFIG_PROCESSOR_SELECT=y
> CONFIG_CPU_SUP_INTEL=y
> # CONFIG_CPU_SUP_CYRIX_32 is not set
> # CONFIG_CPU_SUP_AMD is not set
> # CONFIG_CPU_SUP_HYGON is not set
> # CONFIG_CPU_SUP_CENTAUR is not set
> # CONFIG_CPU_SUP_TRANSMETA_32 is not set
> CONFIG_CPU_SUP_UMC_32=y
> # CONFIG_CPU_SUP_ZHAOXIN is not set
> CONFIG_CPU_SUP_VORTEX_32=y
> CONFIG_HPET_TIMER=y
> CONFIG_DMI=y
> CONFIG_NR_CPUS_RANGE_BEGIN=1
> CONFIG_NR_CPUS_RANGE_END=1
> CONFIG_NR_CPUS_DEFAULT=1
> CONFIG_NR_CPUS=1
> # CONFIG_X86_UP_APIC is not set
> # CONFIG_X86_MCE is not set
> 
> #
> # Performance monitoring
> #
> CONFIG_PERF_EVENTS_INTEL_UNCORE=y
> CONFIG_PERF_EVENTS_INTEL_RAPL=y
> CONFIG_PERF_EVENTS_INTEL_CSTATE=y
> # end of Performance monitoring
> 
> # CONFIG_X86_LEGACY_VM86 is not set
> CONFIG_X86_IOPL_IOPERM=y
> CONFIG_TOSHIBA=y
> # CONFIG_I8K is not set
> CONFIG_X86_REBOOTFIXUPS=y
> CONFIG_MICROCODE=y
> # CONFIG_MICROCODE_INTEL is not set
> # CONFIG_MICROCODE_AMD is not set
> CONFIG_MICROCODE_OLD_INTERFACE=y
> # CONFIG_X86_MSR is not set
> CONFIG_X86_CPUID=y
> # CONFIG_NOHIGHMEM is not set
> # CONFIG_HIGHMEM4G is not set
> CONFIG_HIGHMEM64G=y
> CONFIG_VMSPLIT_3G=y
> # CONFIG_VMSPLIT_2G is not set
> # CONFIG_VMSPLIT_1G is not set
> CONFIG_PAGE_OFFSET=0xC0000000
> CONFIG_HIGHMEM=y
> CONFIG_X86_PAE=y
> # CONFIG_X86_CPA_STATISTICS is not set
> CONFIG_ARCH_FLATMEM_ENABLE=y
> CONFIG_ARCH_SPARSEMEM_ENABLE=y
> CONFIG_ARCH_SELECT_MEMORY_MODEL=y
> CONFIG_ILLEGAL_POINTER_VALUE=0
> CONFIG_HIGHPTE=y
> # CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
> # CONFIG_MTRR is not set
> CONFIG_ARCH_RANDOM=y
> CONFIG_X86_SMAP=y
> # CONFIG_X86_UMIP is not set
> CONFIG_X86_INTEL_TSX_MODE_OFF=y
> # CONFIG_X86_INTEL_TSX_MODE_ON is not set
> # CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
> # CONFIG_EFI is not set
> # CONFIG_HZ_100 is not set
> CONFIG_HZ_250=y
> # CONFIG_HZ_300 is not set
> # CONFIG_HZ_1000 is not set
> CONFIG_HZ=250
> CONFIG_SCHED_HRTICK=y
> # CONFIG_KEXEC is not set
> # CONFIG_CRASH_DUMP is not set
> CONFIG_PHYSICAL_START=0x1000000
> # CONFIG_RELOCATABLE is not set
> CONFIG_PHYSICAL_ALIGN=0x200000
> # CONFIG_COMPAT_VDSO is not set
> # CONFIG_CMDLINE_BOOL is not set
> # CONFIG_MODIFY_LDT_SYSCALL is not set
> # CONFIG_STRICT_SIGALTSTACK_SIZE is not set
> # end of Processor type and features
> 
> CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y
> 
> #
> # Power management and ACPI options
> #
> CONFIG_SUSPEND=y
> CONFIG_SUSPEND_FREEZER=y
> CONFIG_SUSPEND_SKIP_SYNC=y
> CONFIG_PM_SLEEP=y
> CONFIG_PM_AUTOSLEEP=y
> CONFIG_PM_WAKELOCKS=y
> CONFIG_PM_WAKELOCKS_LIMIT=100
> CONFIG_PM_WAKELOCKS_GC=y
> CONFIG_PM=y
> CONFIG_PM_DEBUG=y
> CONFIG_PM_ADVANCED_DEBUG=y
> # CONFIG_PM_TEST_SUSPEND is not set
> CONFIG_PM_SLEEP_DEBUG=y
> # CONFIG_PM_TRACE_RTC is not set
> CONFIG_PM_CLK=y
> CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
> CONFIG_ARCH_SUPPORTS_ACPI=y
> CONFIG_ACPI=y
> CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
> CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
> CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
> CONFIG_ACPI_DEBUGGER=y
> CONFIG_ACPI_DEBUGGER_USER=y
> CONFIG_ACPI_SPCR_TABLE=y
> CONFIG_ACPI_SLEEP=y
> # CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
> CONFIG_ACPI_EC_DEBUGFS=y
> CONFIG_ACPI_AC=y
> CONFIG_ACPI_BATTERY=y
> # CONFIG_ACPI_BUTTON is not set
> CONFIG_ACPI_TINY_POWER_BUTTON=y
> CONFIG_ACPI_TINY_POWER_BUTTON_SIGNAL=38
> CONFIG_ACPI_VIDEO=y
> CONFIG_ACPI_FAN=y
> # CONFIG_ACPI_TAD is not set
> # CONFIG_ACPI_DOCK is not set
> CONFIG_ACPI_CPU_FREQ_PSS=y
> CONFIG_ACPI_PROCESSOR_CSTATE=y
> CONFIG_ACPI_PROCESSOR_IDLE=y
> CONFIG_ACPI_PROCESSOR=y
> CONFIG_ACPI_PROCESSOR_AGGREGATOR=y
> CONFIG_ACPI_THERMAL=y
> CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
> CONFIG_ACPI_TABLE_UPGRADE=y
> CONFIG_ACPI_DEBUG=y
> # CONFIG_ACPI_PCI_SLOT is not set
> CONFIG_ACPI_CONTAINER=y
> CONFIG_ACPI_SBS=y
> CONFIG_ACPI_HED=y
> # CONFIG_ACPI_CUSTOM_METHOD is not set
> # CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
> CONFIG_HAVE_ACPI_APEI=y
> CONFIG_HAVE_ACPI_APEI_NMI=y
> # CONFIG_ACPI_APEI is not set
> CONFIG_ACPI_DPTF=y
> # CONFIG_DPTF_POWER is not set
> # CONFIG_DPTF_PCH_FIVR is not set
> CONFIG_ACPI_CONFIGFS=y
> CONFIG_PMIC_OPREGION=y
> # CONFIG_XPOWER_PMIC_OPREGION is not set
> # CONFIG_CHT_WC_PMIC_OPREGION is not set
> # CONFIG_CHT_DC_TI_PMIC_OPREGION is not set
> CONFIG_X86_PM_TIMER=y
> CONFIG_X86_APM_BOOT=y
> CONFIG_APM=y
> # CONFIG_APM_IGNORE_USER_SUSPEND is not set
> CONFIG_APM_DO_ENABLE=y
> CONFIG_APM_CPU_IDLE=y
> # CONFIG_APM_DISPLAY_BLANK is not set
> # CONFIG_APM_ALLOW_INTS is not set
> 
> #
> # CPU Frequency scaling
> #
> CONFIG_CPU_FREQ=y
> CONFIG_CPU_FREQ_GOV_ATTR_SET=y
> CONFIG_CPU_FREQ_GOV_COMMON=y
> # CONFIG_CPU_FREQ_STAT is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
> CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
> # CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
> CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> CONFIG_CPU_FREQ_GOV_POWERSAVE=y
> CONFIG_CPU_FREQ_GOV_USERSPACE=y
> # CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
> CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
> 
> #
> # CPU frequency scaling drivers
> #
> CONFIG_CPUFREQ_DT=y
> CONFIG_CPUFREQ_DT_PLATDEV=y
> CONFIG_X86_INTEL_PSTATE=y
> CONFIG_X86_PCC_CPUFREQ=y
> CONFIG_X86_ACPI_CPUFREQ=y
> CONFIG_X86_POWERNOW_K6=y
> CONFIG_X86_POWERNOW_K7=y
> CONFIG_X86_POWERNOW_K7_ACPI=y
> # CONFIG_X86_POWERNOW_K8 is not set
> # CONFIG_X86_GX_SUSPMOD is not set
> # CONFIG_X86_SPEEDSTEP_CENTRINO is not set
> # CONFIG_X86_SPEEDSTEP_ICH is not set
> CONFIG_X86_SPEEDSTEP_SMI=y
> CONFIG_X86_P4_CLOCKMOD=y
> # CONFIG_X86_CPUFREQ_NFORCE2 is not set
> CONFIG_X86_LONGRUN=y
> # CONFIG_X86_LONGHAUL is not set
> # CONFIG_X86_E_POWERSAVER is not set
> 
> #
> # shared options
> #
> CONFIG_X86_SPEEDSTEP_LIB=y
> CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK=y
> # end of CPU Frequency scaling
> 
> #
> # CPU Idle
> #
> CONFIG_CPU_IDLE=y
> CONFIG_CPU_IDLE_GOV_LADDER=y
> CONFIG_CPU_IDLE_GOV_MENU=y
> CONFIG_CPU_IDLE_GOV_TEO=y
> # CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
> CONFIG_HALTPOLL_CPUIDLE=y
> # end of CPU Idle
> 
> # CONFIG_INTEL_IDLE is not set
> # end of Power management and ACPI options
> 
> #
> # Bus options (PCI etc.)
> #
> # CONFIG_PCI_GOBIOS is not set
> # CONFIG_PCI_GOMMCONFIG is not set
> # CONFIG_PCI_GODIRECT is not set
> CONFIG_PCI_GOANY=y
> CONFIG_PCI_BIOS=y
> CONFIG_PCI_DIRECT=y
> CONFIG_PCI_MMCONFIG=y
> # CONFIG_PCI_CNB20LE_QUIRK is not set
> CONFIG_ISA_BUS=y
> CONFIG_ISA_DMA_API=y
> CONFIG_ISA=y
> # CONFIG_SCx200 is not set
> CONFIG_ALIX=y
> CONFIG_NET5501=y
> # CONFIG_GEOS is not set
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
> CONFIG_CRASH_CORE=y
> CONFIG_GENERIC_ENTRY=y
> # CONFIG_KPROBES is not set
> # CONFIG_JUMP_LABEL is not set
> # CONFIG_STATIC_CALL_SELFTEST is not set
> CONFIG_UPROBES=y
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
> CONFIG_ARCH_USE_BUILTIN_BSWAP=y
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
> # CONFIG_SECCOMP is not set
> CONFIG_HAVE_ARCH_STACKLEAK=y
> CONFIG_HAVE_STACKPROTECTOR=y
> CONFIG_STACKPROTECTOR=y
> CONFIG_STACKPROTECTOR_STRONG=y
> CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
> CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
> CONFIG_LTO_NONE=y
> CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
> CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
> CONFIG_HAVE_MOVE_PUD=y
> CONFIG_HAVE_MOVE_PMD=y
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
> CONFIG_HAVE_ARCH_HUGE_VMAP=y
> CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
> CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
> CONFIG_MODULES_USE_ELF_REL=y
> CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
> CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
> CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
> CONFIG_HAVE_EXIT_THREAD=y
> CONFIG_ARCH_MMAP_RND_BITS=8
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
> CONFIG_GCOV_KERNEL=y
> CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
> # CONFIG_GCOV_PROFILE_ALL is not set
> # end of GCOV-based kernel profiling
> 
> CONFIG_HAVE_GCC_PLUGINS=y
> # end of General architecture-dependent options
> 
> CONFIG_RT_MUTEXES=y
> CONFIG_BASE_SMALL=0
> CONFIG_MODULE_SIG_FORMAT=y
> CONFIG_MODULES=y
> # CONFIG_MODULE_FORCE_LOAD is not set
> CONFIG_MODULE_UNLOAD=y
> # CONFIG_MODULE_FORCE_UNLOAD is not set
> # CONFIG_MODVERSIONS is not set
> # CONFIG_MODULE_SRCVERSION_ALL is not set
> # CONFIG_MODULE_SIG is not set
> CONFIG_MODULE_SIG_ALL=y
> CONFIG_MODULE_SIG_SHA1=y
> # CONFIG_MODULE_SIG_SHA224 is not set
> # CONFIG_MODULE_SIG_SHA256 is not set
> # CONFIG_MODULE_SIG_SHA384 is not set
> # CONFIG_MODULE_SIG_SHA512 is not set
> CONFIG_MODULE_SIG_HASH="sha1"
> CONFIG_MODULE_COMPRESS_NONE=y
> # CONFIG_MODULE_COMPRESS_GZIP is not set
> # CONFIG_MODULE_COMPRESS_XZ is not set
> # CONFIG_MODULE_COMPRESS_ZSTD is not set
> # CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
> CONFIG_MODPROBE_PATH="/sbin/modprobe"
> # CONFIG_TRIM_UNUSED_KSYMS is not set
> CONFIG_MODULES_TREE_LOOKUP=y
> # CONFIG_BLOCK is not set
> CONFIG_ASN1=y
> CONFIG_UNINLINE_SPIN_UNLOCK=y
> CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
> CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
> CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
> CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
> CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
> CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
> CONFIG_FREEZER=y
> 
> #
> # Executable file formats
> #
> CONFIG_BINFMT_ELF=y
> CONFIG_ELFCORE=y
> CONFIG_BINFMT_SCRIPT=y
> CONFIG_BINFMT_MISC=y
> # CONFIG_COREDUMP is not set
> # end of Executable file formats
> 
> #
> # Memory Management options
> #
> CONFIG_SELECT_MEMORY_MODEL=y
> CONFIG_FLATMEM_MANUAL=y
> # CONFIG_SPARSEMEM_MANUAL is not set
> CONFIG_FLATMEM=y
> CONFIG_SPARSEMEM_STATIC=y
> CONFIG_HAVE_FAST_GUP=y
> CONFIG_MEMORY_ISOLATION=y
> CONFIG_EXCLUSIVE_SYSTEM_RAM=y
> CONFIG_SPLIT_PTLOCK_CPUS=4
> CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
> CONFIG_COMPACTION=y
> CONFIG_PAGE_REPORTING=y
> CONFIG_MIGRATION=y
> CONFIG_CONTIG_ALLOC=y
> CONFIG_PHYS_ADDR_T_64BIT=y
> CONFIG_VIRT_TO_BUS=y
> CONFIG_KSM=y
> CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
> CONFIG_TRANSPARENT_HUGEPAGE=y
> # CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
> CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
> CONFIG_NEED_PER_CPU_KM=y
> # CONFIG_CLEANCACHE is not set
> CONFIG_CMA=y
> CONFIG_CMA_DEBUG=y
> # CONFIG_CMA_DEBUGFS is not set
> # CONFIG_CMA_SYSFS is not set
> CONFIG_CMA_AREAS=7
> CONFIG_ZPOOL=y
> CONFIG_ZBUD=y
> CONFIG_Z3FOLD=y
> CONFIG_ZSMALLOC=y
> # CONFIG_ZSMALLOC_STAT is not set
> CONFIG_GENERIC_EARLY_IOREMAP=y
> # CONFIG_IDLE_PAGE_TRACKING is not set
> CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
> CONFIG_ARCH_HAS_ZONE_DMA_SET=y
> CONFIG_ZONE_DMA=y
> CONFIG_PERCPU_STATS=y
> # CONFIG_GUP_TEST is not set
> CONFIG_GUP_GET_PTE_LOW_HIGH=y
> # CONFIG_READ_ONLY_THP_FOR_FS is not set
> CONFIG_ARCH_HAS_PTE_SPECIAL=y
> CONFIG_KMAP_LOCAL=y
> 
> #
> # Data Access Monitoring
> #
> # CONFIG_DAMON is not set
> # end of Data Access Monitoring
> # end of Memory Management options
> 
> CONFIG_NET=y
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
> # CONFIG_NETWORK_PHY_TIMESTAMPING is not set
> # CONFIG_NETFILTER is not set
> # CONFIG_BPFILTER is not set
> # CONFIG_IP_DCCP is not set
> # CONFIG_IP_SCTP is not set
> # CONFIG_RDS is not set
> # CONFIG_TIPC is not set
> # CONFIG_ATM is not set
> # CONFIG_L2TP is not set
> # CONFIG_BRIDGE is not set
> # CONFIG_NET_DSA is not set
> # CONFIG_VLAN_8021Q is not set
> # CONFIG_DECNET is not set
> # CONFIG_LLC2 is not set
> # CONFIG_ATALK is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_PHONET is not set
> # CONFIG_6LOWPAN is not set
> # CONFIG_IEEE802154 is not set
> # CONFIG_NET_SCHED is not set
> # CONFIG_DCB is not set
> CONFIG_DNS_RESOLVER=m
> # CONFIG_BATMAN_ADV is not set
> # CONFIG_OPENVSWITCH is not set
> # CONFIG_VSOCKETS is not set
> # CONFIG_NETLINK_DIAG is not set
> # CONFIG_MPLS is not set
> # CONFIG_NET_NSH is not set
> # CONFIG_HSR is not set
> # CONFIG_NET_SWITCHDEV is not set
> # CONFIG_NET_L3_MASTER_DEV is not set
> # CONFIG_QRTR is not set
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
> # CONFIG_CAN is not set
> # CONFIG_BT is not set
> # CONFIG_AF_RXRPC is not set
> # CONFIG_AF_KCM is not set
> # CONFIG_MCTP is not set
> CONFIG_WIRELESS=y
> # CONFIG_CFG80211 is not set
> 
> #
> # CFG80211 needs to be enabled for MAC80211
> #
> CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
> # CONFIG_RFKILL is not set
> CONFIG_NET_9P=y
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
> CONFIG_FAILOVER=m
> CONFIG_ETHTOOL_NETLINK=y
> 
> #
> # Device Drivers
> #
> CONFIG_HAVE_EISA=y
> CONFIG_EISA=y
> # CONFIG_EISA_VLB_PRIMING is not set
> CONFIG_EISA_PCI_EISA=y
> # CONFIG_EISA_VIRTUAL_ROOT is not set
> CONFIG_EISA_NAMES=y
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
> # CONFIG_PCIE_BUS_TUNE_OFF is not set
> CONFIG_PCIE_BUS_DEFAULT=y
> # CONFIG_PCIE_BUS_SAFE is not set
> # CONFIG_PCIE_BUS_PERFORMANCE is not set
> # CONFIG_PCIE_BUS_PEER2PEER is not set
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
> CONFIG_PCCARD=y
> CONFIG_PCMCIA=y
> # CONFIG_PCMCIA_LOAD_CIS is not set
> CONFIG_CARDBUS=y
> 
> #
> # PC-card bridges
> #
> # CONFIG_YENTA is not set
> # CONFIG_PD6729 is not set
> # CONFIG_I82092 is not set
> CONFIG_I82365=y
> CONFIG_TCIC=y
> CONFIG_PCMCIA_PROBE=y
> CONFIG_PCCARD_NONSTATIC=y
> # CONFIG_RAPIDIO is not set
> 
> #
> # Generic Driver Options
> #
> CONFIG_AUXILIARY_BUS=y
> # CONFIG_UEVENT_HELPER is not set
> CONFIG_DEVTMPFS=y
> # CONFIG_DEVTMPFS_MOUNT is not set
> CONFIG_STANDALONE=y
> # CONFIG_PREVENT_FIRMWARE_BUILD is not set
> 
> #
> # Firmware loader
> #
> CONFIG_FW_LOADER=y
> CONFIG_FW_LOADER_PAGED_BUF=y
> CONFIG_EXTRA_FIRMWARE=""
> CONFIG_FW_LOADER_USER_HELPER=y
> CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
> # CONFIG_FW_LOADER_COMPRESS is not set
> CONFIG_FW_CACHE=y
> # end of Firmware loader
> 
> CONFIG_ALLOW_DEV_COREDUMP=y
> # CONFIG_DEBUG_DRIVER is not set
> # CONFIG_DEBUG_DEVRES is not set
> # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> CONFIG_PM_QOS_KUNIT_TEST=y
> # CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
> # CONFIG_DRIVER_PE_KUNIT_TEST is not set
> CONFIG_GENERIC_CPU_AUTOPROBE=y
> CONFIG_GENERIC_CPU_VULNERABILITIES=y
> CONFIG_REGMAP=y
> CONFIG_REGMAP_I2C=y
> CONFIG_REGMAP_SLIMBUS=y
> CONFIG_REGMAP_SPMI=y
> CONFIG_REGMAP_W1=y
> CONFIG_REGMAP_MMIO=y
> CONFIG_REGMAP_IRQ=y
> CONFIG_REGMAP_SOUNDWIRE=y
> # end of Generic Driver Options
> 
> #
> # Bus devices
> #
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
> CONFIG_EDD_OFF=y
> # CONFIG_FIRMWARE_MEMMAP is not set
> # CONFIG_DMIID is not set
> CONFIG_DMI_SYSFS=y
> CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
> CONFIG_FW_CFG_SYSFS=y
> CONFIG_FW_CFG_SYSFS_CMDLINE=y
> CONFIG_SYSFB=y
> # CONFIG_SYSFB_SIMPLEFB is not set
> CONFIG_GOOGLE_FIRMWARE=y
> # CONFIG_GOOGLE_SMI is not set
> # CONFIG_GOOGLE_COREBOOT_TABLE is not set
> CONFIG_GOOGLE_MEMCONSOLE=y
> CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY=y
> 
> #
> # Tegra firmware driver
> #
> # end of Tegra firmware driver
> # end of Firmware Drivers
> 
> # CONFIG_GNSS is not set
> # CONFIG_MTD is not set
> CONFIG_DTC=y
> CONFIG_OF=y
> # CONFIG_OF_UNITTEST is not set
> CONFIG_OF_FLATTREE=y
> CONFIG_OF_EARLY_FLATTREE=y
> CONFIG_OF_KOBJ=y
> CONFIG_OF_ADDRESS=y
> CONFIG_OF_IRQ=y
> CONFIG_OF_RESERVED_MEM=y
> # CONFIG_OF_OVERLAY is not set
> CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
> CONFIG_PARPORT=y
> CONFIG_PARPORT_PC=y
> # CONFIG_PARPORT_SERIAL is not set
> CONFIG_PARPORT_PC_FIFO=y
> CONFIG_PARPORT_PC_SUPERIO=y
> CONFIG_PARPORT_PC_PCMCIA=y
> # CONFIG_PARPORT_AX88796 is not set
> # CONFIG_PARPORT_1284 is not set
> CONFIG_PNP=y
> CONFIG_PNP_DEBUG_MESSAGES=y
> 
> #
> # Protocols
> #
> # CONFIG_ISAPNP is not set
> CONFIG_PNPBIOS=y
> CONFIG_PNPBIOS_PROC_FS=y
> CONFIG_PNPACPI=y
> 
> #
> # NVME Support
> #
> # end of NVME Support
> 
> #
> # Misc devices
> #
> CONFIG_SENSORS_LIS3LV02D=y
> CONFIG_AD525X_DPOT=y
> CONFIG_AD525X_DPOT_I2C=y
> # CONFIG_DUMMY_IRQ is not set
> # CONFIG_IBM_ASM is not set
> # CONFIG_PHANTOM is not set
> # CONFIG_TIFM_CORE is not set
> CONFIG_ICS932S401=y
> CONFIG_ENCLOSURE_SERVICES=y
> # CONFIG_HI6421V600_IRQ is not set
> # CONFIG_HP_ILO is not set
> # CONFIG_APDS9802ALS is not set
> CONFIG_ISL29003=y
> CONFIG_ISL29020=y
> CONFIG_SENSORS_TSL2550=y
> CONFIG_SENSORS_BH1770=y
> CONFIG_SENSORS_APDS990X=y
> CONFIG_HMC6352=y
> CONFIG_DS1682=y
> # CONFIG_PCH_PHUB is not set
> # CONFIG_SRAM is not set
> # CONFIG_DW_XDATA_PCIE is not set
> # CONFIG_PCI_ENDPOINT_TEST is not set
> CONFIG_XILINX_SDFEC=y
> CONFIG_C2PORT=y
> CONFIG_C2PORT_DURAMAR_2150=y
> 
> #
> # EEPROM support
> #
> CONFIG_EEPROM_AT24=y
> CONFIG_EEPROM_LEGACY=y
> # CONFIG_EEPROM_MAX6875 is not set
> CONFIG_EEPROM_93CX6=y
> # CONFIG_EEPROM_IDT_89HPESX is not set
> # CONFIG_EEPROM_EE1004 is not set
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
> CONFIG_ALTERA_STAPL=y
> # CONFIG_INTEL_MEI is not set
> # CONFIG_INTEL_MEI_ME is not set
> # CONFIG_INTEL_MEI_TXE is not set
> # CONFIG_VMWARE_VMCI is not set
> CONFIG_ECHO=y
> # CONFIG_MISC_ALCOR_PCI is not set
> # CONFIG_MISC_RTSX_PCI is not set
> # CONFIG_HABANA_AI is not set
> CONFIG_PVPANIC=y
> # CONFIG_PVPANIC_MMIO is not set
> # CONFIG_PVPANIC_PCI is not set
> # end of Misc devices
> 
> #
> # SCSI device support
> #
> CONFIG_SCSI_MOD=y
> # end of SCSI device support
> 
> # CONFIG_FUSION is not set
> 
> #
> # IEEE 1394 (FireWire) support
> #
> # CONFIG_FIREWIRE is not set
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
> # CONFIG_ARCNET is not set
> CONFIG_ETHERNET=y
> CONFIG_NET_VENDOR_3COM=y
> # CONFIG_EL3 is not set
> # CONFIG_3C515 is not set
> # CONFIG_PCMCIA_3C574 is not set
> # CONFIG_PCMCIA_3C589 is not set
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
> CONFIG_NET_VENDOR_AMD=y
> # CONFIG_AMD8111_ETH is not set
> # CONFIG_LANCE is not set
> # CONFIG_PCNET32 is not set
> # CONFIG_PCMCIA_NMCLAN is not set
> # CONFIG_NI65 is not set
> # CONFIG_AMD_XGBE is not set
> CONFIG_NET_VENDOR_AQUANTIA=y
> # CONFIG_AQTION is not set
> CONFIG_NET_VENDOR_ARC=y
> CONFIG_NET_VENDOR_ASIX=y
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
> CONFIG_NET_VENDOR_EZCHIP=y
> # CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
> CONFIG_NET_VENDOR_FUJITSU=y
> # CONFIG_PCMCIA_FMVJ18X is not set
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
> # CONFIG_KS8851_MLL is not set
> # CONFIG_KSZ884X_PCI is not set
> CONFIG_NET_VENDOR_MICROCHIP=y
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
> # CONFIG_PCMCIA_AXNET is not set
> # CONFIG_NE2000 is not set
> # CONFIG_NE2K_PCI is not set
> # CONFIG_PCMCIA_PCNET is not set
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
> # CONFIG_QCOM_EMAC is not set
> # CONFIG_RMNET is not set
> CONFIG_NET_VENDOR_RDC=y
> # CONFIG_R6040 is not set
> CONFIG_NET_VENDOR_REALTEK=y
> # CONFIG_ATP is not set
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
> # CONFIG_PCMCIA_SMC91C92 is not set
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
> CONFIG_NET_VENDOR_XIRCOM=y
> # CONFIG_PCMCIA_XIRC2PS is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> # CONFIG_NET_SB1000 is not set
> # CONFIG_PHYLIB is not set
> # CONFIG_MDIO_DEVICE is not set
> 
> #
> # PCS device drivers
> #
> # end of PCS device drivers
> 
> # CONFIG_PLIP is not set
> # CONFIG_PPP is not set
> # CONFIG_SLIP is not set
> 
> #
> # Host-side USB support is needed for USB Network Adapter support
> #
> CONFIG_WLAN=y
> CONFIG_WLAN_VENDOR_ADMTEK=y
> CONFIG_WLAN_VENDOR_ATH=y
> # CONFIG_ATH_DEBUG is not set
> # CONFIG_ATH5K_PCI is not set
> CONFIG_WLAN_VENDOR_ATMEL=y
> CONFIG_WLAN_VENDOR_BROADCOM=y
> CONFIG_WLAN_VENDOR_CISCO=y
> CONFIG_WLAN_VENDOR_INTEL=y
> CONFIG_WLAN_VENDOR_INTERSIL=y
> # CONFIG_HOSTAP is not set
> CONFIG_WLAN_VENDOR_MARVELL=y
> CONFIG_WLAN_VENDOR_MEDIATEK=y
> CONFIG_WLAN_VENDOR_MICROCHIP=y
> CONFIG_WLAN_VENDOR_RALINK=y
> CONFIG_WLAN_VENDOR_REALTEK=y
> CONFIG_WLAN_VENDOR_RSI=y
> CONFIG_WLAN_VENDOR_ST=y
> CONFIG_WLAN_VENDOR_TI=y
> CONFIG_WLAN_VENDOR_ZYDAS=y
> CONFIG_WLAN_VENDOR_QUANTENNA=y
> # CONFIG_PCMCIA_RAYCS is not set
> # CONFIG_WAN is not set
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
> CONFIG_INPUT_LEDS=y
> CONFIG_INPUT_FF_MEMLESS=y
> CONFIG_INPUT_SPARSEKMAP=y
> CONFIG_INPUT_MATRIXKMAP=y
> 
> #
> # Userland interfaces
> #
> # CONFIG_INPUT_MOUSEDEV is not set
> CONFIG_INPUT_JOYDEV=y
> # CONFIG_INPUT_EVDEV is not set
> CONFIG_INPUT_EVBUG=y
> 
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=y
> # CONFIG_KEYBOARD_ADP5588 is not set
> # CONFIG_KEYBOARD_ADP5589 is not set
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
> # CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
> # CONFIG_KEYBOARD_STOWAWAY is not set
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_OMAP4 is not set
> # CONFIG_KEYBOARD_TC3589X is not set
> # CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
> # CONFIG_KEYBOARD_XTKBD is not set
> # CONFIG_KEYBOARD_CAP11XX is not set
> # CONFIG_KEYBOARD_BCM is not set
> # CONFIG_KEYBOARD_MTK_PMIC is not set
> # CONFIG_KEYBOARD_CYPRESS_SF is not set
> # CONFIG_INPUT_MOUSE is not set
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TABLET is not set
> CONFIG_INPUT_TOUCHSCREEN=y
> CONFIG_TOUCHSCREEN_AD7879=y
> CONFIG_TOUCHSCREEN_AD7879_I2C=y
> CONFIG_TOUCHSCREEN_AR1021_I2C=y
> # CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
> # CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
> CONFIG_TOUCHSCREEN_BU21013=y
> CONFIG_TOUCHSCREEN_BU21029=y
> CONFIG_TOUCHSCREEN_CHIPONE_ICN8318=y
> # CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
> CONFIG_TOUCHSCREEN_CY8CTMA140=y
> CONFIG_TOUCHSCREEN_CY8CTMG110=y
> CONFIG_TOUCHSCREEN_CYTTSP_CORE=y
> CONFIG_TOUCHSCREEN_CYTTSP_I2C=y
> # CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
> # CONFIG_TOUCHSCREEN_DA9034 is not set
> # CONFIG_TOUCHSCREEN_DA9052 is not set
> CONFIG_TOUCHSCREEN_DYNAPRO=y
> CONFIG_TOUCHSCREEN_HAMPSHIRE=y
> # CONFIG_TOUCHSCREEN_EETI is not set
> CONFIG_TOUCHSCREEN_EGALAX=y
> CONFIG_TOUCHSCREEN_EGALAX_SERIAL=y
> CONFIG_TOUCHSCREEN_EXC3000=y
> CONFIG_TOUCHSCREEN_FUJITSU=y
> CONFIG_TOUCHSCREEN_GOODIX=y
> CONFIG_TOUCHSCREEN_HIDEEP=y
> # CONFIG_TOUCHSCREEN_HYCON_HY46XX is not set
> CONFIG_TOUCHSCREEN_ILI210X=y
> # CONFIG_TOUCHSCREEN_ILITEK is not set
> CONFIG_TOUCHSCREEN_S6SY761=y
> CONFIG_TOUCHSCREEN_GUNZE=y
> CONFIG_TOUCHSCREEN_EKTF2127=y
> CONFIG_TOUCHSCREEN_ELAN=y
> CONFIG_TOUCHSCREEN_ELO=y
> CONFIG_TOUCHSCREEN_WACOM_W8001=y
> CONFIG_TOUCHSCREEN_WACOM_I2C=y
> CONFIG_TOUCHSCREEN_MAX11801=y
> CONFIG_TOUCHSCREEN_MCS5000=y
> # CONFIG_TOUCHSCREEN_MMS114 is not set
> CONFIG_TOUCHSCREEN_MELFAS_MIP4=y
> # CONFIG_TOUCHSCREEN_MSG2638 is not set
> # CONFIG_TOUCHSCREEN_MTOUCH is not set
> CONFIG_TOUCHSCREEN_IMX6UL_TSC=y
> CONFIG_TOUCHSCREEN_INEXIO=y
> CONFIG_TOUCHSCREEN_MK712=y
> CONFIG_TOUCHSCREEN_HTCPEN=y
> CONFIG_TOUCHSCREEN_PENMOUNT=y
> CONFIG_TOUCHSCREEN_EDT_FT5X06=y
> CONFIG_TOUCHSCREEN_TOUCHRIGHT=y
> # CONFIG_TOUCHSCREEN_TOUCHWIN is not set
> # CONFIG_TOUCHSCREEN_PIXCIR is not set
> CONFIG_TOUCHSCREEN_WDT87XX_I2C=y
> CONFIG_TOUCHSCREEN_WM831X=y
> # CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
> CONFIG_TOUCHSCREEN_TOUCHIT213=y
> # CONFIG_TOUCHSCREEN_TSC_SERIO is not set
> # CONFIG_TOUCHSCREEN_TSC2004 is not set
> # CONFIG_TOUCHSCREEN_TSC2007 is not set
> CONFIG_TOUCHSCREEN_RM_TS=y
> CONFIG_TOUCHSCREEN_SILEAD=y
> # CONFIG_TOUCHSCREEN_SIS_I2C is not set
> CONFIG_TOUCHSCREEN_ST1232=y
> CONFIG_TOUCHSCREEN_STMFTS=y
> CONFIG_TOUCHSCREEN_SX8654=y
> CONFIG_TOUCHSCREEN_TPS6507X=y
> CONFIG_TOUCHSCREEN_ZET6223=y
> CONFIG_TOUCHSCREEN_ZFORCE=y
> CONFIG_TOUCHSCREEN_ROHM_BU21023=y
> # CONFIG_TOUCHSCREEN_IQS5XX is not set
> CONFIG_TOUCHSCREEN_ZINITIX=y
> CONFIG_INPUT_MISC=y
> CONFIG_INPUT_88PM80X_ONKEY=y
> # CONFIG_INPUT_AD714X is not set
> CONFIG_INPUT_ARIZONA_HAPTICS=y
> # CONFIG_INPUT_ATMEL_CAPTOUCH is not set
> # CONFIG_INPUT_BMA150 is not set
> CONFIG_INPUT_E3X0_BUTTON=y
> CONFIG_INPUT_PCSPKR=y
> # CONFIG_INPUT_MAX77650_ONKEY is not set
> CONFIG_INPUT_MAX77693_HAPTIC=y
> CONFIG_INPUT_MAX8925_ONKEY=y
> # CONFIG_INPUT_MAX8997_HAPTIC is not set
> CONFIG_INPUT_MMA8450=y
> CONFIG_INPUT_APANEL=y
> CONFIG_INPUT_GPIO_BEEPER=y
> # CONFIG_INPUT_GPIO_DECODER is not set
> CONFIG_INPUT_GPIO_VIBRA=y
> CONFIG_INPUT_WISTRON_BTNS=y
> CONFIG_INPUT_ATLAS_BTNS=y
> # CONFIG_INPUT_ATI_REMOTE2 is not set
> # CONFIG_INPUT_KEYSPAN_REMOTE is not set
> CONFIG_INPUT_KXTJ9=y
> # CONFIG_INPUT_POWERMATE is not set
> # CONFIG_INPUT_YEALINK is not set
> # CONFIG_INPUT_CM109 is not set
> CONFIG_INPUT_REGULATOR_HAPTIC=y
> CONFIG_INPUT_RETU_PWRBUTTON=y
> CONFIG_INPUT_TPS65218_PWRBUTTON=y
> # CONFIG_INPUT_AXP20X_PEK is not set
> CONFIG_INPUT_TWL6040_VIBRA=y
> # CONFIG_INPUT_UINPUT is not set
> CONFIG_INPUT_PCF50633_PMU=y
> CONFIG_INPUT_PCF8574=y
> CONFIG_INPUT_PWM_BEEPER=y
> CONFIG_INPUT_PWM_VIBRA=y
> # CONFIG_INPUT_RK805_PWRKEY is not set
> CONFIG_INPUT_GPIO_ROTARY_ENCODER=y
> # CONFIG_INPUT_DA7280_HAPTICS is not set
> CONFIG_INPUT_DA9052_ONKEY=y
> CONFIG_INPUT_DA9063_ONKEY=y
> CONFIG_INPUT_WM831X_ON=y
> # CONFIG_INPUT_ADXL34X is not set
> CONFIG_INPUT_IQS269A=y
> # CONFIG_INPUT_IQS626A is not set
> CONFIG_INPUT_CMA3000=y
> # CONFIG_INPUT_CMA3000_I2C is not set
> # CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
> CONFIG_INPUT_DRV260X_HAPTICS=y
> # CONFIG_INPUT_DRV2665_HAPTICS is not set
> CONFIG_INPUT_DRV2667_HAPTICS=y
> CONFIG_RMI4_CORE=y
> CONFIG_RMI4_I2C=y
> # CONFIG_RMI4_SMB is not set
> CONFIG_RMI4_F03=y
> CONFIG_RMI4_F03_SERIO=y
> # CONFIG_RMI4_F11 is not set
> # CONFIG_RMI4_F12 is not set
> CONFIG_RMI4_F30=y
> # CONFIG_RMI4_F34 is not set
> # CONFIG_RMI4_F3A is not set
> CONFIG_RMI4_F55=y
> 
> #
> # Hardware I/O ports
> #
> CONFIG_SERIO=y
> CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
> CONFIG_SERIO_I8042=y
> CONFIG_SERIO_SERPORT=y
> # CONFIG_SERIO_CT82C710 is not set
> CONFIG_SERIO_PARKBD=y
> # CONFIG_SERIO_PCIPS2 is not set
> CONFIG_SERIO_LIBPS2=y
> CONFIG_SERIO_RAW=y
> # CONFIG_SERIO_ALTERA_PS2 is not set
> CONFIG_SERIO_PS2MULT=y
> # CONFIG_SERIO_ARC_PS2 is not set
> CONFIG_SERIO_APBPS2=y
> CONFIG_SERIO_GPIO_PS2=y
> CONFIG_USERIO=y
> CONFIG_GAMEPORT=y
> CONFIG_GAMEPORT_NS558=y
> CONFIG_GAMEPORT_L4=y
> # CONFIG_GAMEPORT_EMU10K1 is not set
> # CONFIG_GAMEPORT_FM801 is not set
> # end of Hardware I/O ports
> # end of Input device support
> 
> #
> # Character devices
> #
> CONFIG_TTY=y
> # CONFIG_VT is not set
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
> CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
> CONFIG_SERIAL_8250_PNP=y
> # CONFIG_SERIAL_8250_16550A_VARIANTS is not set
> # CONFIG_SERIAL_8250_FINTEK is not set
> CONFIG_SERIAL_8250_CONSOLE=y
> CONFIG_SERIAL_8250_PCI=y
> CONFIG_SERIAL_8250_EXAR=y
> # CONFIG_SERIAL_8250_CS is not set
> # CONFIG_SERIAL_8250_MEN_MCB is not set
> CONFIG_SERIAL_8250_NR_UARTS=4
> CONFIG_SERIAL_8250_RUNTIME_UARTS=4
> # CONFIG_SERIAL_8250_EXTENDED is not set
> # CONFIG_SERIAL_8250_ASPEED_VUART is not set
> CONFIG_SERIAL_8250_DWLIB=y
> # CONFIG_SERIAL_8250_DW is not set
> # CONFIG_SERIAL_8250_RT288X is not set
> CONFIG_SERIAL_8250_LPSS=y
> CONFIG_SERIAL_8250_MID=y
> # CONFIG_SERIAL_OF_PLATFORM is not set
> 
> #
> # Non-8250 serial port support
> #
> # CONFIG_SERIAL_UARTLITE is not set
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_CORE_CONSOLE=y
> # CONFIG_SERIAL_JSM is not set
> # CONFIG_SERIAL_SIFIVE is not set
> # CONFIG_SERIAL_LANTIQ is not set
> # CONFIG_SERIAL_SCCNXP is not set
> # CONFIG_SERIAL_SC16IS7XX is not set
> # CONFIG_SERIAL_TIMBERDALE is not set
> # CONFIG_SERIAL_BCM63XX is not set
> # CONFIG_SERIAL_ALTERA_JTAGUART is not set
> # CONFIG_SERIAL_ALTERA_UART is not set
> # CONFIG_SERIAL_PCH_UART is not set
> # CONFIG_SERIAL_XILINX_PS_UART is not set
> # CONFIG_SERIAL_ARC is not set
> # CONFIG_SERIAL_RP2 is not set
> # CONFIG_SERIAL_FSL_LPUART is not set
> # CONFIG_SERIAL_FSL_LINFLEXUART is not set
> # CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
> # CONFIG_SERIAL_MEN_Z135 is not set
> # CONFIG_SERIAL_SPRD is not set
> # end of Serial drivers
> 
> CONFIG_SERIAL_MCTRL_GPIO=y
> # CONFIG_SERIAL_NONSTANDARD is not set
> # CONFIG_GOLDFISH_TTY is not set
> # CONFIG_N_GSM is not set
> # CONFIG_NOZOMI is not set
> # CONFIG_NULL_TTY is not set
> # CONFIG_RPMSG_TTY is not set
> # CONFIG_SERIAL_DEV_BUS is not set
> # CONFIG_TTY_PRINTK is not set
> CONFIG_PRINTER=y
> # CONFIG_LP_CONSOLE is not set
> # CONFIG_PPDEV is not set
> # CONFIG_VIRTIO_CONSOLE is not set
> # CONFIG_IPMI_HANDLER is not set
> CONFIG_IPMB_DEVICE_INTERFACE=y
> CONFIG_HW_RANDOM=y
> CONFIG_HW_RANDOM_TIMERIOMEM=y
> CONFIG_HW_RANDOM_INTEL=y
> CONFIG_HW_RANDOM_AMD=y
> CONFIG_HW_RANDOM_BA431=y
> CONFIG_HW_RANDOM_GEODE=y
> # CONFIG_HW_RANDOM_VIA is not set
> CONFIG_HW_RANDOM_VIRTIO=y
> CONFIG_HW_RANDOM_CCTRNG=y
> CONFIG_HW_RANDOM_XIPHERA=y
> # CONFIG_DTLK is not set
> # CONFIG_APPLICOM is not set
> # CONFIG_SONYPI is not set
> 
> #
> # PCMCIA character devices
> #
> # CONFIG_SYNCLINK_CS is not set
> CONFIG_CARDMAN_4000=y
> # CONFIG_CARDMAN_4040 is not set
> CONFIG_SCR24X=y
> # CONFIG_IPWIRELESS is not set
> # end of PCMCIA character devices
> 
> # CONFIG_MWAVE is not set
> # CONFIG_PC8736x_GPIO is not set
> # CONFIG_NSC_GPIO is not set
> # CONFIG_DEVMEM is not set
> # CONFIG_NVRAM is not set
> # CONFIG_DEVPORT is not set
> # CONFIG_HPET is not set
> CONFIG_HANGCHECK_TIMER=y
> CONFIG_TCG_TPM=y
> CONFIG_HW_RANDOM_TPM=y
> CONFIG_TCG_TIS_CORE=y
> CONFIG_TCG_TIS=y
> # CONFIG_TCG_TIS_I2C_CR50 is not set
> CONFIG_TCG_TIS_I2C_ATMEL=y
> CONFIG_TCG_TIS_I2C_INFINEON=y
> CONFIG_TCG_TIS_I2C_NUVOTON=y
> CONFIG_TCG_NSC=y
> CONFIG_TCG_ATMEL=y
> # CONFIG_TCG_INFINEON is not set
> CONFIG_TCG_CRB=y
> CONFIG_TCG_VTPM_PROXY=y
> CONFIG_TCG_TIS_ST33ZP24=y
> CONFIG_TCG_TIS_ST33ZP24_I2C=y
> # CONFIG_TELCLOCK is not set
> CONFIG_XILLYBUS_CLASS=y
> CONFIG_XILLYBUS=y
> CONFIG_XILLYBUS_OF=y
> # CONFIG_RANDOM_TRUST_CPU is not set
> CONFIG_RANDOM_TRUST_BOOTLOADER=y
> # end of Character devices
> 
> #
> # I2C support
> #
> CONFIG_I2C=y
> # CONFIG_ACPI_I2C_OPREGION is not set
> CONFIG_I2C_BOARDINFO=y
> CONFIG_I2C_COMPAT=y
> CONFIG_I2C_CHARDEV=y
> # CONFIG_I2C_MUX is not set
> CONFIG_I2C_HELPER_AUTO=y
> CONFIG_I2C_SMBUS=y
> CONFIG_I2C_ALGOBIT=y
> CONFIG_I2C_ALGOPCA=y
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
> CONFIG_I2C_CHT_WC=y
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
> CONFIG_I2C_CBUS_GPIO=y
> CONFIG_I2C_DESIGNWARE_CORE=y
> # CONFIG_I2C_DESIGNWARE_SLAVE is not set
> CONFIG_I2C_DESIGNWARE_PLATFORM=y
> # CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
> # CONFIG_I2C_DESIGNWARE_PCI is not set
> # CONFIG_I2C_EG20T is not set
> CONFIG_I2C_EMEV2=y
> # CONFIG_I2C_GPIO is not set
> CONFIG_I2C_OCORES=y
> CONFIG_I2C_PCA_PLATFORM=y
> CONFIG_I2C_PXA=y
> CONFIG_I2C_PXA_PCI=y
> # CONFIG_I2C_RK3X is not set
> # CONFIG_I2C_SIMTEC is not set
> CONFIG_I2C_XILINX=y
> 
> #
> # External I2C/SMBus adapter drivers
> #
> CONFIG_I2C_PARPORT=y
> # CONFIG_I2C_TAOS_EVM is not set
> 
> #
> # Other I2C/SMBus bus drivers
> #
> # CONFIG_I2C_ELEKTOR is not set
> # CONFIG_I2C_PCA_ISA is not set
> # CONFIG_SCx200_ACB is not set
> # CONFIG_I2C_FSI is not set
> # CONFIG_I2C_VIRTIO is not set
> # end of I2C Hardware Bus support
> 
> # CONFIG_I2C_STUB is not set
> CONFIG_I2C_SLAVE=y
> CONFIG_I2C_SLAVE_EEPROM=y
> # CONFIG_I2C_SLAVE_TESTUNIT is not set
> # CONFIG_I2C_DEBUG_CORE is not set
> # CONFIG_I2C_DEBUG_ALGO is not set
> # CONFIG_I2C_DEBUG_BUS is not set
> # end of I2C support
> 
> CONFIG_I3C=y
> # CONFIG_CDNS_I3C_MASTER is not set
> CONFIG_DW_I3C_MASTER=y
> # CONFIG_SVC_I3C_MASTER is not set
> # CONFIG_MIPI_I3C_HCI is not set
> # CONFIG_SPI is not set
> CONFIG_SPMI=y
> # CONFIG_SPMI_HISI3670 is not set
> CONFIG_HSI=y
> CONFIG_HSI_BOARDINFO=y
> 
> #
> # HSI controllers
> #
> 
> #
> # HSI clients
> #
> # CONFIG_HSI_CHAR is not set
> CONFIG_PPS=y
> # CONFIG_PPS_DEBUG is not set
> 
> #
> # PPS clients support
> #
> # CONFIG_PPS_CLIENT_KTIMER is not set
> # CONFIG_PPS_CLIENT_LDISC is not set
> CONFIG_PPS_CLIENT_PARPORT=y
> CONFIG_PPS_CLIENT_GPIO=y
> 
> #
> # PPS generators support
> #
> 
> #
> # PTP clock support
> #
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
> CONFIG_DEBUG_PINCTRL=y
> # CONFIG_PINCTRL_AXP209 is not set
> # CONFIG_PINCTRL_AMD is not set
> CONFIG_PINCTRL_DA9062=y
> CONFIG_PINCTRL_MCP23S08_I2C=y
> CONFIG_PINCTRL_MCP23S08=y
> # CONFIG_PINCTRL_SINGLE is not set
> CONFIG_PINCTRL_SX150X=y
> CONFIG_PINCTRL_STMFX=y
> # CONFIG_PINCTRL_MAX77620 is not set
> CONFIG_PINCTRL_RK805=y
> CONFIG_PINCTRL_OCELOT=y
> # CONFIG_PINCTRL_MICROCHIP_SGPIO is not set
> 
> #
> # Intel pinctrl drivers
> #
> # CONFIG_PINCTRL_BAYTRAIL is not set
> CONFIG_PINCTRL_CHERRYVIEW=y
> CONFIG_PINCTRL_LYNXPOINT=y
> CONFIG_PINCTRL_INTEL=y
> CONFIG_PINCTRL_ALDERLAKE=y
> CONFIG_PINCTRL_BROXTON=y
> # CONFIG_PINCTRL_CANNONLAKE is not set
> CONFIG_PINCTRL_CEDARFORK=y
> CONFIG_PINCTRL_DENVERTON=y
> # CONFIG_PINCTRL_ELKHARTLAKE is not set
> # CONFIG_PINCTRL_EMMITSBURG is not set
> CONFIG_PINCTRL_GEMINILAKE=y
> CONFIG_PINCTRL_ICELAKE=y
> CONFIG_PINCTRL_JASPERLAKE=y
> # CONFIG_PINCTRL_LAKEFIELD is not set
> # CONFIG_PINCTRL_LEWISBURG is not set
> # CONFIG_PINCTRL_SUNRISEPOINT is not set
> CONFIG_PINCTRL_TIGERLAKE=y
> # end of Intel pinctrl drivers
> 
> #
> # Renesas pinctrl drivers
> #
> # end of Renesas pinctrl drivers
> 
> CONFIG_PINCTRL_EQUILIBRIUM=y
> CONFIG_GPIOLIB=y
> CONFIG_GPIOLIB_FASTPATH_LIMIT=512
> CONFIG_OF_GPIO=y
> CONFIG_GPIO_ACPI=y
> CONFIG_GPIOLIB_IRQCHIP=y
> # CONFIG_DEBUG_GPIO is not set
> # CONFIG_GPIO_SYSFS is not set
> # CONFIG_GPIO_CDEV is not set
> CONFIG_GPIO_GENERIC=y
> 
> #
> # Memory mapped GPIO drivers
> #
> # CONFIG_GPIO_74XX_MMIO is not set
> CONFIG_GPIO_ALTERA=y
> CONFIG_GPIO_AMDPT=y
> CONFIG_GPIO_CADENCE=y
> # CONFIG_GPIO_DWAPB is not set
> # CONFIG_GPIO_EXAR is not set
> CONFIG_GPIO_FTGPIO010=y
> CONFIG_GPIO_GENERIC_PLATFORM=y
> CONFIG_GPIO_GRGPIO=y
> CONFIG_GPIO_HLWD=y
> CONFIG_GPIO_LOGICVC=y
> # CONFIG_GPIO_MB86S7X is not set
> CONFIG_GPIO_MENZ127=y
> CONFIG_GPIO_SAMA5D2_PIOBU=y
> CONFIG_GPIO_SIFIVE=y
> CONFIG_GPIO_SIOX=y
> CONFIG_GPIO_SYSCON=y
> # CONFIG_GPIO_VX855 is not set
> CONFIG_GPIO_WCD934X=y
> CONFIG_GPIO_XILINX=y
> CONFIG_GPIO_AMD_FCH=y
> # end of Memory mapped GPIO drivers
> 
> #
> # Port-mapped I/O GPIO drivers
> #
> CONFIG_GPIO_F7188X=y
> # CONFIG_GPIO_IT87 is not set
> # CONFIG_GPIO_SCH311X is not set
> CONFIG_GPIO_WINBOND=y
> CONFIG_GPIO_WS16C48=y
> # end of Port-mapped I/O GPIO drivers
> 
> #
> # I2C GPIO expanders
> #
> # CONFIG_GPIO_ADP5588 is not set
> # CONFIG_GPIO_ADNP is not set
> # CONFIG_GPIO_GW_PLD is not set
> # CONFIG_GPIO_MAX7300 is not set
> CONFIG_GPIO_MAX732X=y
> CONFIG_GPIO_MAX732X_IRQ=y
> CONFIG_GPIO_PCA953X=y
> # CONFIG_GPIO_PCA953X_IRQ is not set
> CONFIG_GPIO_PCA9570=y
> CONFIG_GPIO_PCF857X=y
> # CONFIG_GPIO_TPIC2810 is not set
> # end of I2C GPIO expanders
> 
> #
> # MFD GPIO expanders
> #
> CONFIG_GPIO_ARIZONA=y
> CONFIG_GPIO_BD70528=y
> CONFIG_GPIO_DA9052=y
> CONFIG_GPIO_LP873X=y
> CONFIG_GPIO_LP87565=y
> CONFIG_GPIO_MAX77620=y
> CONFIG_GPIO_MAX77650=y
> # CONFIG_GPIO_RC5T583 is not set
> # CONFIG_GPIO_TC3589X is not set
> CONFIG_GPIO_TPS65218=y
> CONFIG_GPIO_TPS65910=y
> # CONFIG_GPIO_TPS65912 is not set
> # CONFIG_GPIO_TWL6040 is not set
> # CONFIG_GPIO_WM831X is not set
> # CONFIG_GPIO_WM8350 is not set
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
> # Virtual GPIO drivers
> #
> CONFIG_GPIO_AGGREGATOR=y
> # CONFIG_GPIO_MOCKUP is not set
> # CONFIG_GPIO_VIRTIO is not set
> # end of Virtual GPIO drivers
> 
> CONFIG_W1=y
> 
> #
> # 1-wire Bus Masters
> #
> # CONFIG_W1_MASTER_MATROX is not set
> # CONFIG_W1_MASTER_DS2482 is not set
> CONFIG_W1_MASTER_DS1WM=y
> # CONFIG_W1_MASTER_GPIO is not set
> CONFIG_W1_MASTER_SGI=y
> # end of 1-wire Bus Masters
> 
> #
> # 1-wire Slaves
> #
> # CONFIG_W1_SLAVE_THERM is not set
> # CONFIG_W1_SLAVE_SMEM is not set
> # CONFIG_W1_SLAVE_DS2405 is not set
> CONFIG_W1_SLAVE_DS2408=y
> CONFIG_W1_SLAVE_DS2408_READBACK=y
> CONFIG_W1_SLAVE_DS2413=y
> # CONFIG_W1_SLAVE_DS2406 is not set
> CONFIG_W1_SLAVE_DS2423=y
> # CONFIG_W1_SLAVE_DS2805 is not set
> CONFIG_W1_SLAVE_DS2430=y
> CONFIG_W1_SLAVE_DS2431=y
> CONFIG_W1_SLAVE_DS2433=y
> # CONFIG_W1_SLAVE_DS2433_CRC is not set
> # CONFIG_W1_SLAVE_DS2438 is not set
> CONFIG_W1_SLAVE_DS250X=y
> CONFIG_W1_SLAVE_DS2780=y
> CONFIG_W1_SLAVE_DS2781=y
> # CONFIG_W1_SLAVE_DS28E04 is not set
> CONFIG_W1_SLAVE_DS28E17=y
> # end of 1-wire Slaves
> 
> # CONFIG_POWER_RESET is not set
> CONFIG_POWER_SUPPLY=y
> # CONFIG_POWER_SUPPLY_DEBUG is not set
> # CONFIG_POWER_SUPPLY_HWMON is not set
> CONFIG_PDA_POWER=y
> # CONFIG_MAX8925_POWER is not set
> CONFIG_WM831X_BACKUP=y
> # CONFIG_WM831X_POWER is not set
> CONFIG_WM8350_POWER=y
> # CONFIG_TEST_POWER is not set
> # CONFIG_CHARGER_ADP5061 is not set
> CONFIG_BATTERY_ACT8945A=y
> CONFIG_BATTERY_CW2015=y
> CONFIG_BATTERY_DS2760=y
> CONFIG_BATTERY_DS2780=y
> # CONFIG_BATTERY_DS2781 is not set
> CONFIG_BATTERY_DS2782=y
> CONFIG_BATTERY_SBS=y
> # CONFIG_CHARGER_SBS is not set
> # CONFIG_BATTERY_BQ27XXX is not set
> CONFIG_BATTERY_DA9030=y
> CONFIG_BATTERY_DA9052=y
> CONFIG_BATTERY_MAX17040=y
> # CONFIG_BATTERY_MAX17042 is not set
> CONFIG_BATTERY_MAX1721X=y
> CONFIG_CHARGER_PCF50633=y
> CONFIG_CHARGER_MAX8903=y
> # CONFIG_CHARGER_LP8727 is not set
> # CONFIG_CHARGER_GPIO is not set
> CONFIG_CHARGER_MANAGER=y
> CONFIG_CHARGER_LT3651=y
> # CONFIG_CHARGER_LTC4162L is not set
> CONFIG_CHARGER_DETECTOR_MAX14656=y
> CONFIG_CHARGER_MAX77650=y
> # CONFIG_CHARGER_MAX77693 is not set
> # CONFIG_CHARGER_MAX8997 is not set
> # CONFIG_CHARGER_MT6360 is not set
> CONFIG_CHARGER_BQ2415X=y
> CONFIG_CHARGER_BQ24190=y
> CONFIG_CHARGER_BQ24257=y
> # CONFIG_CHARGER_BQ24735 is not set
> CONFIG_CHARGER_BQ2515X=y
> CONFIG_CHARGER_BQ25890=y
> CONFIG_CHARGER_BQ25980=y
> # CONFIG_CHARGER_BQ256XX is not set
> CONFIG_CHARGER_SMB347=y
> CONFIG_CHARGER_TPS65090=y
> # CONFIG_CHARGER_TPS65217 is not set
> # CONFIG_BATTERY_GAUGE_LTC2941 is not set
> CONFIG_BATTERY_GOLDFISH=y
> # CONFIG_BATTERY_RT5033 is not set
> # CONFIG_CHARGER_RT9455 is not set
> # CONFIG_CHARGER_UCS1002 is not set
> CONFIG_CHARGER_BD99954=y
> CONFIG_HWMON=y
> CONFIG_HWMON_VID=y
> # CONFIG_HWMON_DEBUG_CHIP is not set
> 
> #
> # Native drivers
> #
> CONFIG_SENSORS_ABITUGURU=y
> CONFIG_SENSORS_ABITUGURU3=y
> CONFIG_SENSORS_AD7414=y
> CONFIG_SENSORS_AD7418=y
> CONFIG_SENSORS_ADM1021=y
> CONFIG_SENSORS_ADM1025=y
> # CONFIG_SENSORS_ADM1026 is not set
> CONFIG_SENSORS_ADM1029=y
> # CONFIG_SENSORS_ADM1031 is not set
> CONFIG_SENSORS_ADM1177=y
> CONFIG_SENSORS_ADM9240=y
> # CONFIG_SENSORS_ADT7410 is not set
> # CONFIG_SENSORS_ADT7411 is not set
> CONFIG_SENSORS_ADT7462=y
> # CONFIG_SENSORS_ADT7470 is not set
> CONFIG_SENSORS_ADT7475=y
> # CONFIG_SENSORS_AHT10 is not set
> CONFIG_SENSORS_AS370=y
> # CONFIG_SENSORS_ASC7621 is not set
> CONFIG_SENSORS_AXI_FAN_CONTROL=y
> # CONFIG_SENSORS_K8TEMP is not set
> CONFIG_SENSORS_APPLESMC=y
> # CONFIG_SENSORS_ASB100 is not set
> # CONFIG_SENSORS_ASPEED is not set
> CONFIG_SENSORS_ATXP1=y
> CONFIG_SENSORS_CORSAIR_CPRO=y
> # CONFIG_SENSORS_CORSAIR_PSU is not set
> # CONFIG_SENSORS_DS620 is not set
> # CONFIG_SENSORS_DS1621 is not set
> # CONFIG_SENSORS_DELL_SMM is not set
> # CONFIG_SENSORS_DA9052_ADC is not set
> # CONFIG_SENSORS_I5K_AMB is not set
> # CONFIG_SENSORS_F71805F is not set
> # CONFIG_SENSORS_F71882FG is not set
> CONFIG_SENSORS_F75375S=y
> CONFIG_SENSORS_GSC=y
> CONFIG_SENSORS_FSCHMD=y
> CONFIG_SENSORS_GL518SM=y
> # CONFIG_SENSORS_GL520SM is not set
> # CONFIG_SENSORS_G760A is not set
> CONFIG_SENSORS_G762=y
> CONFIG_SENSORS_GPIO_FAN=y
> CONFIG_SENSORS_HIH6130=y
> # CONFIG_SENSORS_I5500 is not set
> CONFIG_SENSORS_CORETEMP=y
> CONFIG_SENSORS_IT87=y
> CONFIG_SENSORS_JC42=y
> CONFIG_SENSORS_POWR1220=y
> CONFIG_SENSORS_LINEAGE=y
> CONFIG_SENSORS_LTC2945=y
> # CONFIG_SENSORS_LTC2947_I2C is not set
> CONFIG_SENSORS_LTC2990=y
> # CONFIG_SENSORS_LTC2992 is not set
> CONFIG_SENSORS_LTC4151=y
> CONFIG_SENSORS_LTC4215=y
> CONFIG_SENSORS_LTC4222=y
> CONFIG_SENSORS_LTC4245=y
> CONFIG_SENSORS_LTC4260=y
> CONFIG_SENSORS_LTC4261=y
> # CONFIG_SENSORS_MAX127 is not set
> CONFIG_SENSORS_MAX16065=y
> CONFIG_SENSORS_MAX1619=y
> CONFIG_SENSORS_MAX1668=y
> CONFIG_SENSORS_MAX197=y
> CONFIG_SENSORS_MAX31730=y
> # CONFIG_SENSORS_MAX6620 is not set
> # CONFIG_SENSORS_MAX6621 is not set
> # CONFIG_SENSORS_MAX6639 is not set
> CONFIG_SENSORS_MAX6642=y
> CONFIG_SENSORS_MAX6650=y
> # CONFIG_SENSORS_MAX6697 is not set
> CONFIG_SENSORS_MAX31790=y
> CONFIG_SENSORS_MCP3021=y
> # CONFIG_SENSORS_TC654 is not set
> # CONFIG_SENSORS_TPS23861 is not set
> CONFIG_SENSORS_MENF21BMC_HWMON=y
> CONFIG_SENSORS_MR75203=y
> CONFIG_SENSORS_LM63=y
> # CONFIG_SENSORS_LM73 is not set
> CONFIG_SENSORS_LM75=y
> CONFIG_SENSORS_LM77=y
> CONFIG_SENSORS_LM78=y
> CONFIG_SENSORS_LM80=y
> # CONFIG_SENSORS_LM83 is not set
> CONFIG_SENSORS_LM85=y
> CONFIG_SENSORS_LM87=y
> CONFIG_SENSORS_LM90=y
> CONFIG_SENSORS_LM92=y
> CONFIG_SENSORS_LM93=y
> CONFIG_SENSORS_LM95234=y
> CONFIG_SENSORS_LM95241=y
> CONFIG_SENSORS_LM95245=y
> CONFIG_SENSORS_PC87360=y
> CONFIG_SENSORS_PC87427=y
> # CONFIG_SENSORS_NTC_THERMISTOR is not set
> CONFIG_SENSORS_NCT6683=y
> # CONFIG_SENSORS_NCT6775 is not set
> CONFIG_SENSORS_NCT7802=y
> CONFIG_SENSORS_NPCM7XX=y
> CONFIG_SENSORS_PCF8591=y
> CONFIG_PMBUS=y
> CONFIG_SENSORS_PMBUS=y
> CONFIG_SENSORS_ADM1266=y
> # CONFIG_SENSORS_ADM1275 is not set
> # CONFIG_SENSORS_BEL_PFE is not set
> # CONFIG_SENSORS_BPA_RS600 is not set
> # CONFIG_SENSORS_FSP_3Y is not set
> # CONFIG_SENSORS_IBM_CFFPS is not set
> # CONFIG_SENSORS_DPS920AB is not set
> CONFIG_SENSORS_INSPUR_IPSPS=y
> # CONFIG_SENSORS_IR35221 is not set
> # CONFIG_SENSORS_IR36021 is not set
> CONFIG_SENSORS_IR38064=y
> CONFIG_SENSORS_IRPS5401=y
> # CONFIG_SENSORS_ISL68137 is not set
> # CONFIG_SENSORS_LM25066 is not set
> # CONFIG_SENSORS_LTC2978 is not set
> CONFIG_SENSORS_LTC3815=y
> # CONFIG_SENSORS_MAX15301 is not set
> # CONFIG_SENSORS_MAX16064 is not set
> CONFIG_SENSORS_MAX16601=y
> CONFIG_SENSORS_MAX20730=y
> CONFIG_SENSORS_MAX20751=y
> CONFIG_SENSORS_MAX31785=y
> CONFIG_SENSORS_MAX34440=y
> CONFIG_SENSORS_MAX8688=y
> # CONFIG_SENSORS_MP2888 is not set
> # CONFIG_SENSORS_MP2975 is not set
> # CONFIG_SENSORS_PIM4328 is not set
> # CONFIG_SENSORS_PM6764TR is not set
> CONFIG_SENSORS_PXE1610=y
> # CONFIG_SENSORS_Q54SJ108A2 is not set
> # CONFIG_SENSORS_STPDDC60 is not set
> # CONFIG_SENSORS_TPS40422 is not set
> CONFIG_SENSORS_TPS53679=y
> # CONFIG_SENSORS_UCD9000 is not set
> CONFIG_SENSORS_UCD9200=y
> # CONFIG_SENSORS_XDPE122 is not set
> CONFIG_SENSORS_ZL6100=y
> # CONFIG_SENSORS_PWM_FAN is not set
> # CONFIG_SENSORS_SBTSI is not set
> # CONFIG_SENSORS_SBRMI is not set
> CONFIG_SENSORS_SHT15=y
> CONFIG_SENSORS_SHT21=y
> # CONFIG_SENSORS_SHT3x is not set
> # CONFIG_SENSORS_SHT4x is not set
> CONFIG_SENSORS_SHTC1=y
> # CONFIG_SENSORS_SIS5595 is not set
> CONFIG_SENSORS_DME1737=y
> # CONFIG_SENSORS_EMC1403 is not set
> CONFIG_SENSORS_EMC2103=y
> # CONFIG_SENSORS_EMC6W201 is not set
> # CONFIG_SENSORS_SMSC47M1 is not set
> CONFIG_SENSORS_SMSC47M192=y
> CONFIG_SENSORS_SMSC47B397=y
> CONFIG_SENSORS_STTS751=y
> CONFIG_SENSORS_SMM665=y
> CONFIG_SENSORS_ADC128D818=y
> CONFIG_SENSORS_ADS7828=y
> CONFIG_SENSORS_AMC6821=y
> CONFIG_SENSORS_INA209=y
> CONFIG_SENSORS_INA2XX=y
> # CONFIG_SENSORS_INA3221 is not set
> # CONFIG_SENSORS_TC74 is not set
> CONFIG_SENSORS_THMC50=y
> # CONFIG_SENSORS_TMP102 is not set
> # CONFIG_SENSORS_TMP103 is not set
> # CONFIG_SENSORS_TMP108 is not set
> CONFIG_SENSORS_TMP401=y
> CONFIG_SENSORS_TMP421=y
> # CONFIG_SENSORS_TMP513 is not set
> CONFIG_SENSORS_VIA_CPUTEMP=y
> # CONFIG_SENSORS_VIA686A is not set
> # CONFIG_SENSORS_VT1211 is not set
> # CONFIG_SENSORS_VT8231 is not set
> # CONFIG_SENSORS_W83773G is not set
> CONFIG_SENSORS_W83781D=y
> CONFIG_SENSORS_W83791D=y
> CONFIG_SENSORS_W83792D=y
> # CONFIG_SENSORS_W83793 is not set
> CONFIG_SENSORS_W83795=y
> CONFIG_SENSORS_W83795_FANCTRL=y
> # CONFIG_SENSORS_W83L785TS is not set
> # CONFIG_SENSORS_W83L786NG is not set
> CONFIG_SENSORS_W83627HF=y
> CONFIG_SENSORS_W83627EHF=y
> CONFIG_SENSORS_WM831X=y
> CONFIG_SENSORS_WM8350=y
> 
> #
> # ACPI drivers
> #
> CONFIG_SENSORS_ACPI_POWER=y
> # CONFIG_SENSORS_ATK0110 is not set
> CONFIG_THERMAL=y
> # CONFIG_THERMAL_NETLINK is not set
> # CONFIG_THERMAL_STATISTICS is not set
> CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
> CONFIG_THERMAL_HWMON=y
> CONFIG_THERMAL_OF=y
> # CONFIG_THERMAL_WRITABLE_TRIPS is not set
> # CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
> # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
> CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=y
> CONFIG_THERMAL_GOV_FAIR_SHARE=y
> CONFIG_THERMAL_GOV_STEP_WISE=y
> CONFIG_THERMAL_GOV_BANG_BANG=y
> CONFIG_THERMAL_GOV_USER_SPACE=y
> CONFIG_CPU_THERMAL=y
> # CONFIG_CPU_FREQ_THERMAL is not set
> CONFIG_THERMAL_EMULATION=y
> CONFIG_THERMAL_MMIO=y
> CONFIG_MAX77620_THERMAL=y
> CONFIG_DA9062_THERMAL=y
> 
> #
> # Intel thermal drivers
> #
> CONFIG_INTEL_POWERCLAMP=y
> # CONFIG_INTEL_SOC_DTS_THERMAL is not set
> 
> #
> # ACPI INT340X thermal drivers
> #
> # CONFIG_INT340X_THERMAL is not set
> # end of ACPI INT340X thermal drivers
> 
> # CONFIG_INTEL_PCH_THERMAL is not set
> # CONFIG_INTEL_TCC_COOLING is not set
> # CONFIG_INTEL_MENLOW is not set
> # end of Intel thermal drivers
> 
> # CONFIG_WATCHDOG is not set
> CONFIG_SSB_POSSIBLE=y
> CONFIG_SSB=y
> CONFIG_SSB_SPROM=y
> CONFIG_SSB_PCIHOST_POSSIBLE=y
> CONFIG_SSB_PCIHOST=y
> CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
> # CONFIG_SSB_PCMCIAHOST is not set
> CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
> # CONFIG_SSB_DRIVER_PCICORE is not set
> CONFIG_SSB_DRIVER_GPIO=y
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
> CONFIG_MFD_ACT8945A=y
> CONFIG_MFD_AS3711=y
> # CONFIG_MFD_AS3722 is not set
> # CONFIG_PMIC_ADP5520 is not set
> # CONFIG_MFD_AAT2870_CORE is not set
> CONFIG_MFD_ATMEL_FLEXCOM=y
> CONFIG_MFD_ATMEL_HLCDC=y
> CONFIG_MFD_BCM590XX=y
> # CONFIG_MFD_BD9571MWV is not set
> CONFIG_MFD_AXP20X=y
> CONFIG_MFD_AXP20X_I2C=y
> # CONFIG_MFD_MADERA is not set
> CONFIG_PMIC_DA903X=y
> CONFIG_PMIC_DA9052=y
> CONFIG_MFD_DA9052_I2C=y
> # CONFIG_MFD_DA9055 is not set
> CONFIG_MFD_DA9062=y
> CONFIG_MFD_DA9063=y
> # CONFIG_MFD_DA9150 is not set
> CONFIG_MFD_GATEWORKS_GSC=y
> # CONFIG_MFD_MC13XXX_I2C is not set
> CONFIG_MFD_MP2629=y
> # CONFIG_MFD_HI6421_PMIC is not set
> # CONFIG_MFD_HI6421_SPMI is not set
> # CONFIG_HTC_PASIC3 is not set
> CONFIG_HTC_I2CPLD=y
> # CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
> # CONFIG_LPC_ICH is not set
> # CONFIG_LPC_SCH is not set
> # CONFIG_INTEL_SOC_PMIC is not set
> # CONFIG_INTEL_SOC_PMIC_BXTWC is not set
> CONFIG_INTEL_SOC_PMIC_CHTWC=y
> CONFIG_INTEL_SOC_PMIC_CHTDC_TI=y
> CONFIG_MFD_INTEL_LPSS=y
> CONFIG_MFD_INTEL_LPSS_ACPI=y
> # CONFIG_MFD_INTEL_LPSS_PCI is not set
> CONFIG_MFD_INTEL_PMC_BXT=y
> # CONFIG_MFD_INTEL_PMT is not set
> # CONFIG_MFD_IQS62X is not set
> # CONFIG_MFD_JANZ_CMODIO is not set
> # CONFIG_MFD_KEMPLD is not set
> CONFIG_MFD_88PM800=y
> CONFIG_MFD_88PM805=y
> # CONFIG_MFD_88PM860X is not set
> # CONFIG_MFD_MAX14577 is not set
> CONFIG_MFD_MAX77620=y
> CONFIG_MFD_MAX77650=y
> # CONFIG_MFD_MAX77686 is not set
> CONFIG_MFD_MAX77693=y
> CONFIG_MFD_MAX77843=y
> CONFIG_MFD_MAX8907=y
> CONFIG_MFD_MAX8925=y
> CONFIG_MFD_MAX8997=y
> # CONFIG_MFD_MAX8998 is not set
> CONFIG_MFD_MT6360=y
> CONFIG_MFD_MT6397=y
> CONFIG_MFD_MENF21BMC=y
> # CONFIG_MFD_NTXEC is not set
> CONFIG_MFD_RETU=y
> CONFIG_MFD_PCF50633=y
> CONFIG_PCF50633_ADC=y
> # CONFIG_PCF50633_GPIO is not set
> # CONFIG_MFD_RDC321X is not set
> # CONFIG_MFD_RT4831 is not set
> # CONFIG_MFD_RT5033 is not set
> CONFIG_MFD_RC5T583=y
> CONFIG_MFD_RK808=y
> CONFIG_MFD_RN5T618=y
> CONFIG_MFD_SEC_CORE=y
> CONFIG_MFD_SI476X_CORE=y
> # CONFIG_MFD_SM501 is not set
> # CONFIG_MFD_SKY81452 is not set
> # CONFIG_MFD_STMPE is not set
> CONFIG_MFD_SYSCON=y
> # CONFIG_MFD_TI_AM335X_TSCADC is not set
> # CONFIG_MFD_LP3943 is not set
> # CONFIG_MFD_LP8788 is not set
> # CONFIG_MFD_TI_LMU is not set
> # CONFIG_MFD_PALMAS is not set
> CONFIG_TPS6105X=y
> # CONFIG_TPS65010 is not set
> # CONFIG_TPS6507X is not set
> # CONFIG_MFD_TPS65086 is not set
> CONFIG_MFD_TPS65090=y
> CONFIG_MFD_TPS65217=y
> CONFIG_MFD_TI_LP873X=y
> CONFIG_MFD_TI_LP87565=y
> CONFIG_MFD_TPS65218=y
> # CONFIG_MFD_TPS6586X is not set
> CONFIG_MFD_TPS65910=y
> CONFIG_MFD_TPS65912=y
> CONFIG_MFD_TPS65912_I2C=y
> # CONFIG_TWL4030_CORE is not set
> CONFIG_TWL6040_CORE=y
> # CONFIG_MFD_WL1273_CORE is not set
> CONFIG_MFD_LM3533=y
> # CONFIG_MFD_TIMBERDALE is not set
> CONFIG_MFD_TC3589X=y
> # CONFIG_MFD_TQMX86 is not set
> # CONFIG_MFD_VX855 is not set
> # CONFIG_MFD_LOCHNAGAR is not set
> CONFIG_MFD_ARIZONA=y
> CONFIG_MFD_ARIZONA_I2C=y
> CONFIG_MFD_CS47L24=y
> # CONFIG_MFD_WM5102 is not set
> CONFIG_MFD_WM5110=y
> # CONFIG_MFD_WM8997 is not set
> # CONFIG_MFD_WM8998 is not set
> # CONFIG_MFD_WM8400 is not set
> CONFIG_MFD_WM831X=y
> CONFIG_MFD_WM831X_I2C=y
> CONFIG_MFD_WM8350=y
> CONFIG_MFD_WM8350_I2C=y
> # CONFIG_MFD_WM8994 is not set
> CONFIG_MFD_ROHM_BD718XX=y
> CONFIG_MFD_ROHM_BD70528=y
> # CONFIG_MFD_ROHM_BD71828 is not set
> # CONFIG_MFD_ROHM_BD957XMUF is not set
> # CONFIG_MFD_STPMIC1 is not set
> CONFIG_MFD_STMFX=y
> CONFIG_MFD_WCD934X=y
> # CONFIG_MFD_ATC260X_I2C is not set
> # CONFIG_MFD_QCOM_PM8008 is not set
> # CONFIG_MFD_RSMU_I2C is not set
> # end of Multifunction device drivers
> 
> CONFIG_REGULATOR=y
> CONFIG_REGULATOR_DEBUG=y
> CONFIG_REGULATOR_FIXED_VOLTAGE=y
> CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
> # CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
> # CONFIG_REGULATOR_88PG86X is not set
> CONFIG_REGULATOR_88PM800=y
> CONFIG_REGULATOR_ACT8865=y
> CONFIG_REGULATOR_ACT8945A=y
> CONFIG_REGULATOR_AD5398=y
> CONFIG_REGULATOR_ARIZONA_LDO1=y
> CONFIG_REGULATOR_ARIZONA_MICSUPP=y
> # CONFIG_REGULATOR_AS3711 is not set
> CONFIG_REGULATOR_AXP20X=y
> CONFIG_REGULATOR_BCM590XX=y
> CONFIG_REGULATOR_BD718XX=y
> CONFIG_REGULATOR_DA903X=y
> CONFIG_REGULATOR_DA9052=y
> # CONFIG_REGULATOR_DA9062 is not set
> # CONFIG_REGULATOR_DA9063 is not set
> # CONFIG_REGULATOR_DA9121 is not set
> CONFIG_REGULATOR_DA9210=y
> CONFIG_REGULATOR_DA9211=y
> CONFIG_REGULATOR_FAN53555=y
> CONFIG_REGULATOR_FAN53880=y
> CONFIG_REGULATOR_GPIO=y
> # CONFIG_REGULATOR_ISL9305 is not set
> # CONFIG_REGULATOR_ISL6271A is not set
> # CONFIG_REGULATOR_LP3971 is not set
> # CONFIG_REGULATOR_LP3972 is not set
> CONFIG_REGULATOR_LP872X=y
> # CONFIG_REGULATOR_LP873X is not set
> # CONFIG_REGULATOR_LP8755 is not set
> # CONFIG_REGULATOR_LP87565 is not set
> # CONFIG_REGULATOR_LTC3589 is not set
> # CONFIG_REGULATOR_LTC3676 is not set
> CONFIG_REGULATOR_MAX1586=y
> # CONFIG_REGULATOR_MAX77620 is not set
> CONFIG_REGULATOR_MAX77650=y
> # CONFIG_REGULATOR_MAX8649 is not set
> # CONFIG_REGULATOR_MAX8660 is not set
> # CONFIG_REGULATOR_MAX8893 is not set
> CONFIG_REGULATOR_MAX8907=y
> # CONFIG_REGULATOR_MAX8925 is not set
> # CONFIG_REGULATOR_MAX8952 is not set
> CONFIG_REGULATOR_MAX8973=y
> CONFIG_REGULATOR_MAX8997=y
> CONFIG_REGULATOR_MAX77693=y
> CONFIG_REGULATOR_MAX77826=y
> CONFIG_REGULATOR_MCP16502=y
> # CONFIG_REGULATOR_MP5416 is not set
> CONFIG_REGULATOR_MP8859=y
> CONFIG_REGULATOR_MP886X=y
> CONFIG_REGULATOR_MPQ7920=y
> CONFIG_REGULATOR_MT6311=y
> CONFIG_REGULATOR_MT6315=y
> CONFIG_REGULATOR_MT6323=y
> # CONFIG_REGULATOR_MT6358 is not set
> # CONFIG_REGULATOR_MT6359 is not set
> CONFIG_REGULATOR_MT6360=y
> CONFIG_REGULATOR_MT6397=y
> CONFIG_REGULATOR_PCA9450=y
> # CONFIG_REGULATOR_PCF50633 is not set
> # CONFIG_REGULATOR_PF8X00 is not set
> # CONFIG_REGULATOR_PFUZE100 is not set
> CONFIG_REGULATOR_PV88060=y
> CONFIG_REGULATOR_PV88080=y
> CONFIG_REGULATOR_PV88090=y
> CONFIG_REGULATOR_PWM=y
> # CONFIG_REGULATOR_QCOM_SPMI is not set
> # CONFIG_REGULATOR_QCOM_USB_VBUS is not set
> CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY=y
> CONFIG_REGULATOR_RC5T583=y
> # CONFIG_REGULATOR_RK808 is not set
> # CONFIG_REGULATOR_RN5T618 is not set
> CONFIG_REGULATOR_ROHM=y
> CONFIG_REGULATOR_RT4801=y
> # CONFIG_REGULATOR_RT6160 is not set
> # CONFIG_REGULATOR_RT6245 is not set
> # CONFIG_REGULATOR_RTQ2134 is not set
> CONFIG_REGULATOR_RTMV20=y
> # CONFIG_REGULATOR_RTQ6752 is not set
> CONFIG_REGULATOR_S2MPA01=y
> # CONFIG_REGULATOR_S2MPS11 is not set
> CONFIG_REGULATOR_S5M8767=y
> # CONFIG_REGULATOR_SLG51000 is not set
> CONFIG_REGULATOR_SY8106A=y
> CONFIG_REGULATOR_SY8824X=y
> # CONFIG_REGULATOR_SY8827N is not set
> CONFIG_REGULATOR_TPS51632=y
> # CONFIG_REGULATOR_TPS6105X is not set
> # CONFIG_REGULATOR_TPS62360 is not set
> # CONFIG_REGULATOR_TPS65023 is not set
> CONFIG_REGULATOR_TPS6507X=y
> CONFIG_REGULATOR_TPS65090=y
> # CONFIG_REGULATOR_TPS65132 is not set
> # CONFIG_REGULATOR_TPS65217 is not set
> CONFIG_REGULATOR_TPS65218=y
> CONFIG_REGULATOR_TPS65910=y
> CONFIG_REGULATOR_TPS65912=y
> CONFIG_REGULATOR_VCTRL=y
> # CONFIG_REGULATOR_WM831X is not set
> CONFIG_REGULATOR_WM8350=y
> CONFIG_REGULATOR_QCOM_LABIBB=y
> CONFIG_RC_CORE=y
> CONFIG_RC_MAP=y
> CONFIG_LIRC=y
> CONFIG_RC_DECODERS=y
> # CONFIG_IR_NEC_DECODER is not set
> CONFIG_IR_RC5_DECODER=y
> CONFIG_IR_RC6_DECODER=y
> CONFIG_IR_JVC_DECODER=y
> # CONFIG_IR_SONY_DECODER is not set
> CONFIG_IR_SANYO_DECODER=y
> CONFIG_IR_SHARP_DECODER=y
> # CONFIG_IR_MCE_KBD_DECODER is not set
> CONFIG_IR_XMP_DECODER=y
> # CONFIG_IR_IMON_DECODER is not set
> # CONFIG_IR_RCMM_DECODER is not set
> # CONFIG_RC_DEVICES is not set
> 
> #
> # CEC support
> #
> # CONFIG_MEDIA_CEC_SUPPORT is not set
> # end of CEC support
> 
> # CONFIG_MEDIA_SUPPORT is not set
> 
> #
> # Graphics support
> #
> # CONFIG_AGP is not set
> CONFIG_VGA_ARB=y
> CONFIG_VGA_ARB_MAX_GPUS=16
> # CONFIG_VGA_SWITCHEROO is not set
> # CONFIG_DRM is not set
> CONFIG_DRM_DEBUG_MODESET_LOCK=y
> 
> #
> # ARM devices
> #
> # end of ARM devices
> 
> #
> # Frame buffer Devices
> #
> CONFIG_FB_CMDLINE=y
> CONFIG_FB_NOTIFY=y
> CONFIG_FB=y
> # CONFIG_FIRMWARE_EDID is not set
> CONFIG_FB_CFB_FILLRECT=y
> CONFIG_FB_CFB_COPYAREA=y
> CONFIG_FB_CFB_IMAGEBLIT=y
> CONFIG_FB_SYS_FILLRECT=y
> CONFIG_FB_SYS_COPYAREA=y
> CONFIG_FB_SYS_IMAGEBLIT=y
> # CONFIG_FB_FOREIGN_ENDIAN is not set
> CONFIG_FB_SYS_FOPS=y
> CONFIG_FB_DEFERRED_IO=y
> CONFIG_FB_HECUBA=y
> CONFIG_FB_BACKLIGHT=y
> CONFIG_FB_MODE_HELPERS=y
> CONFIG_FB_TILEBLITTING=y
> 
> #
> # Frame buffer hardware drivers
> #
> # CONFIG_FB_CIRRUS is not set
> # CONFIG_FB_PM2 is not set
> # CONFIG_FB_CYBER2000 is not set
> CONFIG_FB_ARC=y
> # CONFIG_FB_ASILIANT is not set
> # CONFIG_FB_IMSTT is not set
> # CONFIG_FB_VGA16 is not set
> # CONFIG_FB_VESA is not set
> CONFIG_FB_N411=y
> # CONFIG_FB_HGA is not set
> CONFIG_FB_OPENCORES=y
> # CONFIG_FB_S1D13XXX is not set
> # CONFIG_FB_NVIDIA is not set
> # CONFIG_FB_RIVA is not set
> # CONFIG_FB_I740 is not set
> # CONFIG_FB_LE80578 is not set
> # CONFIG_FB_MATROX is not set
> # CONFIG_FB_RADEON is not set
> # CONFIG_FB_ATY128 is not set
> # CONFIG_FB_ATY is not set
> # CONFIG_FB_S3 is not set
> # CONFIG_FB_SAVAGE is not set
> # CONFIG_FB_SIS is not set
> # CONFIG_FB_VIA is not set
> # CONFIG_FB_NEOMAGIC is not set
> # CONFIG_FB_KYRO is not set
> # CONFIG_FB_3DFX is not set
> # CONFIG_FB_VOODOO1 is not set
> # CONFIG_FB_VT8623 is not set
> # CONFIG_FB_TRIDENT is not set
> # CONFIG_FB_ARK is not set
> # CONFIG_FB_PM3 is not set
> # CONFIG_FB_CARMINE is not set
> # CONFIG_FB_GEODE is not set
> # CONFIG_FB_IBM_GXT4500 is not set
> # CONFIG_FB_GOLDFISH is not set
> # CONFIG_FB_VIRTUAL is not set
> # CONFIG_FB_METRONOME is not set
> # CONFIG_FB_MB862XX is not set
> CONFIG_FB_SIMPLE=y
> CONFIG_FB_SSD1307=y
> # CONFIG_FB_SM712 is not set
> # end of Frame buffer Devices
> 
> #
> # Backlight & LCD device support
> #
> CONFIG_LCD_CLASS_DEVICE=y
> CONFIG_LCD_PLATFORM=y
> CONFIG_BACKLIGHT_CLASS_DEVICE=y
> # CONFIG_BACKLIGHT_KTD253 is not set
> # CONFIG_BACKLIGHT_LM3533 is not set
> CONFIG_BACKLIGHT_PWM=y
> CONFIG_BACKLIGHT_DA903X=y
> # CONFIG_BACKLIGHT_DA9052 is not set
> CONFIG_BACKLIGHT_MAX8925=y
> # CONFIG_BACKLIGHT_APPLE is not set
> CONFIG_BACKLIGHT_QCOM_WLED=y
> CONFIG_BACKLIGHT_SAHARA=y
> CONFIG_BACKLIGHT_WM831X=y
> CONFIG_BACKLIGHT_ADP8860=y
> CONFIG_BACKLIGHT_ADP8870=y
> # CONFIG_BACKLIGHT_PCF50633 is not set
> # CONFIG_BACKLIGHT_LM3630A is not set
> CONFIG_BACKLIGHT_LM3639=y
> CONFIG_BACKLIGHT_LP855X=y
> # CONFIG_BACKLIGHT_TPS65217 is not set
> CONFIG_BACKLIGHT_AS3711=y
> CONFIG_BACKLIGHT_GPIO=y
> # CONFIG_BACKLIGHT_LV5207LP is not set
> # CONFIG_BACKLIGHT_BD6107 is not set
> CONFIG_BACKLIGHT_ARCXCNN=y
> CONFIG_BACKLIGHT_LED=y
> # end of Backlight & LCD device support
> 
> # CONFIG_LOGO is not set
> # end of Graphics support
> 
> CONFIG_SOUND=y
> CONFIG_SND=y
> CONFIG_SND_TIMER=y
> CONFIG_SND_PCM=y
> CONFIG_SND_DMAENGINE_PCM=y
> CONFIG_SND_RAWMIDI=y
> CONFIG_SND_COMPRESS_OFFLOAD=y
> CONFIG_SND_JACK=y
> CONFIG_SND_JACK_INPUT_DEV=y
> # CONFIG_SND_OSSEMUL is not set
> CONFIG_SND_PCM_TIMER=y
> CONFIG_SND_HRTIMER=y
> CONFIG_SND_DYNAMIC_MINORS=y
> CONFIG_SND_MAX_CARDS=32
> # CONFIG_SND_SUPPORT_OLD_API is not set
> CONFIG_SND_PROC_FS=y
> # CONFIG_SND_VERBOSE_PROCFS is not set
> # CONFIG_SND_VERBOSE_PRINTK is not set
> CONFIG_SND_DEBUG=y
> CONFIG_SND_DEBUG_VERBOSE=y
> # CONFIG_SND_CTL_VALIDATION is not set
> # CONFIG_SND_JACK_INJECTION_DEBUG is not set
> CONFIG_SND_DMA_SGBUF=y
> # CONFIG_SND_SEQUENCER is not set
> CONFIG_SND_DRIVERS=y
> CONFIG_SND_PCSP=y
> # CONFIG_SND_DUMMY is not set
> # CONFIG_SND_ALOOP is not set
> # CONFIG_SND_MTPAV is not set
> CONFIG_SND_MTS64=y
> CONFIG_SND_SERIAL_U16550=y
> # CONFIG_SND_MPU401 is not set
> CONFIG_SND_PORTMAN2X4=y
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
> CONFIG_SND_INTEL_NHLT=y
> CONFIG_SND_INTEL_DSP_CONFIG=y
> CONFIG_SND_INTEL_SOUNDWIRE_ACPI=y
> # CONFIG_SND_PCMCIA is not set
> CONFIG_SND_SOC=y
> CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
> CONFIG_SND_SOC_COMPRESS=y
> CONFIG_SND_SOC_ACPI=y
> # CONFIG_SND_SOC_ADI is not set
> # CONFIG_SND_SOC_AMD_ACP is not set
> # CONFIG_SND_SOC_AMD_ACP3x is not set
> # CONFIG_SND_SOC_AMD_RENOIR is not set
> # CONFIG_SND_SOC_AMD_ACP5x is not set
> # CONFIG_SND_SOC_AMD_ACP6x is not set
> # CONFIG_SND_SOC_AMD_ACP_COMMON is not set
> CONFIG_SND_ATMEL_SOC=y
> CONFIG_SND_SOC_MIKROE_PROTO=y
> CONFIG_SND_BCM63XX_I2S_WHISTLER=y
> # CONFIG_SND_DESIGNWARE_I2S is not set
> 
> #
> # SoC Audio for Freescale CPUs
> #
> 
> #
> # Common SoC Audio options for Freescale CPUs:
> #
> # CONFIG_SND_SOC_FSL_ASRC is not set
> # CONFIG_SND_SOC_FSL_SAI is not set
> # CONFIG_SND_SOC_FSL_AUDMIX is not set
> # CONFIG_SND_SOC_FSL_SSI is not set
> CONFIG_SND_SOC_FSL_SPDIF=y
> # CONFIG_SND_SOC_FSL_ESAI is not set
> CONFIG_SND_SOC_FSL_MICFIL=y
> # CONFIG_SND_SOC_FSL_XCVR is not set
> # CONFIG_SND_SOC_FSL_RPMSG is not set
> # CONFIG_SND_SOC_IMX_AUDMUX is not set
> # end of SoC Audio for Freescale CPUs
> 
> CONFIG_SND_I2S_HI6210_I2S=y
> # CONFIG_SND_SOC_IMG is not set
> CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
> CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=y
> # CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI is not set
> CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=y
> # CONFIG_SND_SOC_INTEL_SKYLAKE is not set
> # CONFIG_SND_SOC_INTEL_SKL is not set
> # CONFIG_SND_SOC_INTEL_APL is not set
> # CONFIG_SND_SOC_INTEL_KBL is not set
> # CONFIG_SND_SOC_INTEL_GLK is not set
> # CONFIG_SND_SOC_INTEL_CNL is not set
> # CONFIG_SND_SOC_INTEL_CFL is not set
> # CONFIG_SND_SOC_INTEL_CML_H is not set
> # CONFIG_SND_SOC_INTEL_CML_LP is not set
> CONFIG_SND_SOC_ACPI_INTEL_MATCH=y
> CONFIG_SND_SOC_INTEL_MACH=y
> # CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES is not set
> # CONFIG_SND_SOC_MTK_BTCVSD is not set
> CONFIG_SND_SOC_SOF_TOPLEVEL=y
> # CONFIG_SND_SOC_SOF_PCI is not set
> CONFIG_SND_SOC_SOF_ACPI=y
> # CONFIG_SND_SOC_SOF_OF is not set
> # CONFIG_SND_SOC_SOF_DEBUG_PROBES is not set
> # CONFIG_SND_SOC_SOF_DEVELOPER_SUPPORT is not set
> # CONFIG_SND_SOC_SOF_INTEL_TOPLEVEL is not set
> 
> #
> # STMicroelectronics STM32 SOC audio support
> #
> # end of STMicroelectronics STM32 SOC audio support
> 
> # CONFIG_SND_SOC_XILINX_I2S is not set
> CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER=y
> CONFIG_SND_SOC_XILINX_SPDIF=y
> CONFIG_SND_SOC_XTFPGA_I2S=y
> CONFIG_SND_SOC_I2C_AND_SPI=y
> 
> #
> # CODEC drivers
> #
> # CONFIG_SND_SOC_AC97_CODEC is not set
> CONFIG_SND_SOC_ADAU_UTILS=y
> CONFIG_SND_SOC_ADAU1372=y
> CONFIG_SND_SOC_ADAU1372_I2C=y
> CONFIG_SND_SOC_ADAU1701=y
> CONFIG_SND_SOC_ADAU17X1=y
> CONFIG_SND_SOC_ADAU1761=y
> CONFIG_SND_SOC_ADAU1761_I2C=y
> # CONFIG_SND_SOC_ADAU7002 is not set
> # CONFIG_SND_SOC_ADAU7118_HW is not set
> # CONFIG_SND_SOC_ADAU7118_I2C is not set
> CONFIG_SND_SOC_AK4118=y
> CONFIG_SND_SOC_AK4458=y
> # CONFIG_SND_SOC_AK4554 is not set
> # CONFIG_SND_SOC_AK4613 is not set
> # CONFIG_SND_SOC_AK4642 is not set
> CONFIG_SND_SOC_AK5386=y
> # CONFIG_SND_SOC_AK5558 is not set
> CONFIG_SND_SOC_ALC5623=y
> CONFIG_SND_SOC_BD28623=y
> CONFIG_SND_SOC_BT_SCO=y
> CONFIG_SND_SOC_CS35L32=y
> CONFIG_SND_SOC_CS35L33=y
> CONFIG_SND_SOC_CS35L34=y
> # CONFIG_SND_SOC_CS35L35 is not set
> CONFIG_SND_SOC_CS35L36=y
> # CONFIG_SND_SOC_CS35L41_I2C is not set
> # CONFIG_SND_SOC_CS42L42 is not set
> CONFIG_SND_SOC_CS42L51=y
> CONFIG_SND_SOC_CS42L51_I2C=y
> CONFIG_SND_SOC_CS42L52=y
> CONFIG_SND_SOC_CS42L56=y
> CONFIG_SND_SOC_CS42L73=y
> # CONFIG_SND_SOC_CS4234 is not set
> # CONFIG_SND_SOC_CS4265 is not set
> CONFIG_SND_SOC_CS4270=y
> # CONFIG_SND_SOC_CS4271_I2C is not set
> CONFIG_SND_SOC_CS42XX8=y
> CONFIG_SND_SOC_CS42XX8_I2C=y
> CONFIG_SND_SOC_CS43130=y
> # CONFIG_SND_SOC_CS4341 is not set
> # CONFIG_SND_SOC_CS4349 is not set
> # CONFIG_SND_SOC_CS53L30 is not set
> CONFIG_SND_SOC_CX2072X=y
> # CONFIG_SND_SOC_DA7213 is not set
> CONFIG_SND_SOC_DMIC=y
> # CONFIG_SND_SOC_ES7134 is not set
> CONFIG_SND_SOC_ES7241=y
> # CONFIG_SND_SOC_ES8316 is not set
> CONFIG_SND_SOC_ES8328=y
> CONFIG_SND_SOC_ES8328_I2C=y
> CONFIG_SND_SOC_GTM601=y
> CONFIG_SND_SOC_ICS43432=y
> CONFIG_SND_SOC_INNO_RK3036=y
> CONFIG_SND_SOC_MAX98088=y
> CONFIG_SND_SOC_MAX98357A=y
> CONFIG_SND_SOC_MAX98504=y
> # CONFIG_SND_SOC_MAX9867 is not set
> # CONFIG_SND_SOC_MAX98927 is not set
> # CONFIG_SND_SOC_MAX98520 is not set
> CONFIG_SND_SOC_MAX98373=y
> # CONFIG_SND_SOC_MAX98373_I2C is not set
> CONFIG_SND_SOC_MAX98373_SDW=y
> CONFIG_SND_SOC_MAX98390=y
> # CONFIG_SND_SOC_MAX9860 is not set
> CONFIG_SND_SOC_MSM8916_WCD_ANALOG=y
> CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=y
> # CONFIG_SND_SOC_PCM1681 is not set
> CONFIG_SND_SOC_PCM1789=y
> CONFIG_SND_SOC_PCM1789_I2C=y
> # CONFIG_SND_SOC_PCM179X_I2C is not set
> CONFIG_SND_SOC_PCM186X=y
> CONFIG_SND_SOC_PCM186X_I2C=y
> # CONFIG_SND_SOC_PCM3060_I2C is not set
> CONFIG_SND_SOC_PCM3168A=y
> CONFIG_SND_SOC_PCM3168A_I2C=y
> CONFIG_SND_SOC_PCM5102A=y
> CONFIG_SND_SOC_PCM512x=y
> CONFIG_SND_SOC_PCM512x_I2C=y
> # CONFIG_SND_SOC_RK3328 is not set
> # CONFIG_SND_SOC_RK817 is not set
> CONFIG_SND_SOC_RL6231=y
> # CONFIG_SND_SOC_RT1308_SDW is not set
> # CONFIG_SND_SOC_RT1316_SDW is not set
> # CONFIG_SND_SOC_RT5616 is not set
> # CONFIG_SND_SOC_RT5631 is not set
> CONFIG_SND_SOC_RT5640=y
> CONFIG_SND_SOC_RT5659=y
> CONFIG_SND_SOC_RT5682=y
> CONFIG_SND_SOC_RT5682_SDW=y
> CONFIG_SND_SOC_RT700=y
> CONFIG_SND_SOC_RT700_SDW=y
> CONFIG_SND_SOC_RT711=y
> CONFIG_SND_SOC_RT711_SDW=y
> # CONFIG_SND_SOC_RT711_SDCA_SDW is not set
> CONFIG_SND_SOC_RT715=y
> CONFIG_SND_SOC_RT715_SDW=y
> # CONFIG_SND_SOC_RT715_SDCA_SDW is not set
> # CONFIG_SND_SOC_RT9120 is not set
> # CONFIG_SND_SOC_SDW_MOCKUP is not set
> CONFIG_SND_SOC_SGTL5000=y
> CONFIG_SND_SOC_SIGMADSP=y
> CONFIG_SND_SOC_SIGMADSP_I2C=y
> CONFIG_SND_SOC_SIGMADSP_REGMAP=y
> # CONFIG_SND_SOC_SIMPLE_AMPLIFIER is not set
> # CONFIG_SND_SOC_SIMPLE_MUX is not set
> CONFIG_SND_SOC_SPDIF=y
> # CONFIG_SND_SOC_SSM2305 is not set
> CONFIG_SND_SOC_SSM2518=y
> CONFIG_SND_SOC_SSM2602=y
> CONFIG_SND_SOC_SSM2602_I2C=y
> CONFIG_SND_SOC_SSM4567=y
> CONFIG_SND_SOC_STA32X=y
> CONFIG_SND_SOC_STA350=y
> CONFIG_SND_SOC_STI_SAS=y
> # CONFIG_SND_SOC_TAS2552 is not set
> # CONFIG_SND_SOC_TAS2562 is not set
> CONFIG_SND_SOC_TAS2764=y
> CONFIG_SND_SOC_TAS2770=y
> # CONFIG_SND_SOC_TAS5086 is not set
> # CONFIG_SND_SOC_TAS571X is not set
> CONFIG_SND_SOC_TAS5720=y
> # CONFIG_SND_SOC_TAS6424 is not set
> # CONFIG_SND_SOC_TDA7419 is not set
> CONFIG_SND_SOC_TFA9879=y
> # CONFIG_SND_SOC_TFA989X is not set
> CONFIG_SND_SOC_TLV320AIC23=y
> CONFIG_SND_SOC_TLV320AIC23_I2C=y
> # CONFIG_SND_SOC_TLV320AIC31XX is not set
> CONFIG_SND_SOC_TLV320AIC32X4=y
> CONFIG_SND_SOC_TLV320AIC32X4_I2C=y
> # CONFIG_SND_SOC_TLV320AIC3X_I2C is not set
> # CONFIG_SND_SOC_TLV320ADCX140 is not set
> CONFIG_SND_SOC_TS3A227E=y
> CONFIG_SND_SOC_TSCS42XX=y
> CONFIG_SND_SOC_TSCS454=y
> # CONFIG_SND_SOC_UDA1334 is not set
> CONFIG_SND_SOC_WCD9335=y
> CONFIG_SND_SOC_WCD_MBHC=y
> CONFIG_SND_SOC_WCD934X=y
> # CONFIG_SND_SOC_WCD938X_SDW is not set
> CONFIG_SND_SOC_WM8510=y
> # CONFIG_SND_SOC_WM8523 is not set
> CONFIG_SND_SOC_WM8524=y
> CONFIG_SND_SOC_WM8580=y
> CONFIG_SND_SOC_WM8711=y
> CONFIG_SND_SOC_WM8728=y
> CONFIG_SND_SOC_WM8731=y
> # CONFIG_SND_SOC_WM8737 is not set
> # CONFIG_SND_SOC_WM8741 is not set
> CONFIG_SND_SOC_WM8750=y
> CONFIG_SND_SOC_WM8753=y
> # CONFIG_SND_SOC_WM8776 is not set
> CONFIG_SND_SOC_WM8782=y
> CONFIG_SND_SOC_WM8804=y
> CONFIG_SND_SOC_WM8804_I2C=y
> # CONFIG_SND_SOC_WM8903 is not set
> # CONFIG_SND_SOC_WM8904 is not set
> CONFIG_SND_SOC_WM8960=y
> # CONFIG_SND_SOC_WM8962 is not set
> CONFIG_SND_SOC_WM8974=y
> # CONFIG_SND_SOC_WM8978 is not set
> # CONFIG_SND_SOC_WM8985 is not set
> CONFIG_SND_SOC_WSA881X=y
> # CONFIG_SND_SOC_MAX9759 is not set
> # CONFIG_SND_SOC_MT6351 is not set
> CONFIG_SND_SOC_MT6358=y
> # CONFIG_SND_SOC_MT6660 is not set
> # CONFIG_SND_SOC_NAU8315 is not set
> CONFIG_SND_SOC_NAU8540=y
> CONFIG_SND_SOC_NAU8810=y
> # CONFIG_SND_SOC_NAU8821 is not set
> CONFIG_SND_SOC_NAU8822=y
> CONFIG_SND_SOC_NAU8824=y
> CONFIG_SND_SOC_TPA6130A2=y
> # CONFIG_SND_SOC_LPASS_WSA_MACRO is not set
> CONFIG_SND_SOC_LPASS_VA_MACRO=y
> CONFIG_SND_SOC_LPASS_RX_MACRO=y
> CONFIG_SND_SOC_LPASS_TX_MACRO=y
> # end of CODEC drivers
> 
> CONFIG_SND_SIMPLE_CARD_UTILS=y
> CONFIG_SND_SIMPLE_CARD=y
> CONFIG_SND_AUDIO_GRAPH_CARD=y
> # CONFIG_SND_AUDIO_GRAPH_CARD2 is not set
> # CONFIG_SND_TEST_COMPONENT is not set
> CONFIG_SND_X86=y
> CONFIG_SND_VIRTIO=y
> 
> #
> # HID support
> #
> CONFIG_HID=y
> # CONFIG_HID_BATTERY_STRENGTH is not set
> CONFIG_HIDRAW=y
> CONFIG_UHID=y
> CONFIG_HID_GENERIC=y
> 
> #
> # Special HID drivers
> #
> # CONFIG_HID_A4TECH is not set
> CONFIG_HID_ACRUX=y
> # CONFIG_HID_ACRUX_FF is not set
> # CONFIG_HID_APPLE is not set
> # CONFIG_HID_AUREAL is not set
> # CONFIG_HID_BELKIN is not set
> CONFIG_HID_CHERRY=y
> CONFIG_HID_CHICONY=y
> CONFIG_HID_COUGAR=y
> CONFIG_HID_MACALLY=y
> # CONFIG_HID_PRODIKEYS is not set
> # CONFIG_HID_CMEDIA is not set
> CONFIG_HID_CYPRESS=y
> # CONFIG_HID_DRAGONRISE is not set
> CONFIG_HID_EMS_FF=y
> CONFIG_HID_ELECOM=y
> CONFIG_HID_EZKEY=y
> CONFIG_HID_GEMBIRD=y
> CONFIG_HID_GFRM=y
> CONFIG_HID_GLORIOUS=y
> # CONFIG_HID_VIVALDI is not set
> CONFIG_HID_KEYTOUCH=y
> CONFIG_HID_KYE=y
> # CONFIG_HID_WALTOP is not set
> CONFIG_HID_VIEWSONIC=y
> # CONFIG_HID_XIAOMI is not set
> CONFIG_HID_GYRATION=y
> # CONFIG_HID_ICADE is not set
> # CONFIG_HID_ITE is not set
> # CONFIG_HID_JABRA is not set
> # CONFIG_HID_TWINHAN is not set
> # CONFIG_HID_KENSINGTON is not set
> CONFIG_HID_LCPOWER=y
> CONFIG_HID_LED=y
> CONFIG_HID_LENOVO=y
> CONFIG_HID_LOGITECH=y
> # CONFIG_HID_LOGITECH_HIDPP is not set
> CONFIG_LOGITECH_FF=y
> # CONFIG_LOGIRUMBLEPAD2_FF is not set
> CONFIG_LOGIG940_FF=y
> # CONFIG_LOGIWHEELS_FF is not set
> CONFIG_HID_MAGICMOUSE=y
> # CONFIG_HID_MALTRON is not set
> CONFIG_HID_MAYFLASH=y
> CONFIG_HID_REDRAGON=y
> CONFIG_HID_MICROSOFT=y
> CONFIG_HID_MONTEREY=y
> # CONFIG_HID_MULTITOUCH is not set
> CONFIG_HID_NINTENDO=y
> # CONFIG_NINTENDO_FF is not set
> # CONFIG_HID_NTI is not set
> CONFIG_HID_ORTEK=y
> # CONFIG_HID_PANTHERLORD is not set
> # CONFIG_HID_PETALYNX is not set
> CONFIG_HID_PICOLCD=y
> # CONFIG_HID_PICOLCD_FB is not set
> CONFIG_HID_PICOLCD_BACKLIGHT=y
> # CONFIG_HID_PICOLCD_LCD is not set
> # CONFIG_HID_PICOLCD_LEDS is not set
> CONFIG_HID_PICOLCD_CIR=y
> CONFIG_HID_PLANTRONICS=y
> # CONFIG_HID_PRIMAX is not set
> # CONFIG_HID_SAITEK is not set
> CONFIG_HID_SAMSUNG=y
> # CONFIG_HID_SEMITEK is not set
> CONFIG_HID_SPEEDLINK=y
> CONFIG_HID_STEAM=y
> CONFIG_HID_STEELSERIES=y
> # CONFIG_HID_SUNPLUS is not set
> # CONFIG_HID_RMI is not set
> # CONFIG_HID_GREENASIA is not set
> CONFIG_HID_SMARTJOYPLUS=y
> CONFIG_SMARTJOYPLUS_FF=y
> CONFIG_HID_TIVO=y
> CONFIG_HID_TOPSEED=y
> # CONFIG_HID_THINGM is not set
> CONFIG_HID_UDRAW_PS3=y
> CONFIG_HID_WIIMOTE=y
> CONFIG_HID_XINMO=y
> # CONFIG_HID_ZEROPLUS is not set
> CONFIG_HID_ZYDACRON=y
> CONFIG_HID_SENSOR_HUB=y
> CONFIG_HID_SENSOR_CUSTOM_SENSOR=y
> CONFIG_HID_ALPS=y
> # end of Special HID drivers
> 
> #
> # I2C HID support
> #
> CONFIG_I2C_HID_ACPI=y
> # CONFIG_I2C_HID_OF is not set
> # CONFIG_I2C_HID_OF_GOODIX is not set
> # end of I2C HID support
> 
> CONFIG_I2C_HID_CORE=y
> # end of HID support
> 
> CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> CONFIG_USB_SUPPORT=y
> # CONFIG_USB_ULPI_BUS is not set
> # CONFIG_USB_CONN_GPIO is not set
> CONFIG_USB_ARCH_HAS_HCD=y
> # CONFIG_USB is not set
> CONFIG_USB_PCI=y
> 
> #
> # USB port drivers
> #
> 
> #
> # USB Physical Layer drivers
> #
> # CONFIG_NOP_USB_XCEIV is not set
> # CONFIG_USB_GPIO_VBUS is not set
> # CONFIG_TAHVO_USB is not set
> # end of USB Physical Layer drivers
> 
> # CONFIG_USB_GADGET is not set
> # CONFIG_TYPEC is not set
> # CONFIG_USB_ROLE_SWITCH is not set
> # CONFIG_MMC is not set
> # CONFIG_MEMSTICK is not set
> CONFIG_NEW_LEDS=y
> CONFIG_LEDS_CLASS=y
> CONFIG_LEDS_CLASS_FLASH=y
> # CONFIG_LEDS_CLASS_MULTICOLOR is not set
> # CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set
> 
> #
> # LED drivers
> #
> # CONFIG_LEDS_AN30259A is not set
> CONFIG_LEDS_APU=y
> CONFIG_LEDS_AW2013=y
> CONFIG_LEDS_BCM6328=y
> # CONFIG_LEDS_BCM6358 is not set
> # CONFIG_LEDS_LM3530 is not set
> CONFIG_LEDS_LM3532=y
> CONFIG_LEDS_LM3533=y
> # CONFIG_LEDS_LM3642 is not set
> CONFIG_LEDS_LM3692X=y
> CONFIG_LEDS_MT6323=y
> CONFIG_LEDS_PCA9532=y
> CONFIG_LEDS_PCA9532_GPIO=y
> CONFIG_LEDS_GPIO=y
> CONFIG_LEDS_LP3944=y
> CONFIG_LEDS_LP3952=y
> CONFIG_LEDS_LP50XX=y
> # CONFIG_LEDS_LP55XX_COMMON is not set
> # CONFIG_LEDS_LP8860 is not set
> # CONFIG_LEDS_CLEVO_MAIL is not set
> # CONFIG_LEDS_PCA955X is not set
> CONFIG_LEDS_PCA963X=y
> CONFIG_LEDS_WM831X_STATUS=y
> CONFIG_LEDS_WM8350=y
> # CONFIG_LEDS_DA903X is not set
> CONFIG_LEDS_DA9052=y
> # CONFIG_LEDS_PWM is not set
> CONFIG_LEDS_REGULATOR=y
> CONFIG_LEDS_BD2802=y
> # CONFIG_LEDS_INTEL_SS4200 is not set
> CONFIG_LEDS_LT3593=y
> CONFIG_LEDS_TCA6507=y
> CONFIG_LEDS_TLC591XX=y
> # CONFIG_LEDS_MAX77650 is not set
> CONFIG_LEDS_MAX8997=y
> CONFIG_LEDS_LM355x=y
> CONFIG_LEDS_OT200=y
> # CONFIG_LEDS_MENF21BMC is not set
> # CONFIG_LEDS_IS31FL319X is not set
> CONFIG_LEDS_IS31FL32XX=y
> 
> #
> # LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
> #
> # CONFIG_LEDS_BLINKM is not set
> # CONFIG_LEDS_SYSCON is not set
> CONFIG_LEDS_MLXCPLD=y
> CONFIG_LEDS_MLXREG=y
> CONFIG_LEDS_USER=y
> # CONFIG_LEDS_NIC78BX is not set
> # CONFIG_LEDS_TI_LMU_COMMON is not set
> CONFIG_LEDS_TPS6105X=y
> # CONFIG_LEDS_LGM is not set
> 
> #
> # Flash and Torch LED drivers
> #
> # CONFIG_LEDS_AAT1290 is not set
> # CONFIG_LEDS_AS3645A is not set
> CONFIG_LEDS_KTD2692=y
> # CONFIG_LEDS_LM3601X is not set
> CONFIG_LEDS_MAX77693=y
> # CONFIG_LEDS_RT4505 is not set
> # CONFIG_LEDS_RT8515 is not set
> # CONFIG_LEDS_SGM3140 is not set
> 
> #
> # LED Triggers
> #
> CONFIG_LEDS_TRIGGERS=y
> CONFIG_LEDS_TRIGGER_TIMER=y
> CONFIG_LEDS_TRIGGER_ONESHOT=y
> # CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
> # CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
> CONFIG_LEDS_TRIGGER_CPU=y
> CONFIG_LEDS_TRIGGER_ACTIVITY=y
> CONFIG_LEDS_TRIGGER_GPIO=y
> CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
> 
> #
> # iptables trigger is under Netfilter config (LED target)
> #
> CONFIG_LEDS_TRIGGER_TRANSIENT=y
> CONFIG_LEDS_TRIGGER_CAMERA=y
> CONFIG_LEDS_TRIGGER_PANIC=y
> # CONFIG_LEDS_TRIGGER_NETDEV is not set
> CONFIG_LEDS_TRIGGER_PATTERN=y
> CONFIG_LEDS_TRIGGER_AUDIO=y
> # CONFIG_LEDS_TRIGGER_TTY is not set
> CONFIG_ACCESSIBILITY=y
> 
> #
> # Speakup console speech
> #
> # end of Speakup console speech
> 
> # CONFIG_INFINIBAND is not set
> CONFIG_EDAC_ATOMIC_SCRUB=y
> CONFIG_EDAC_SUPPORT=y
> CONFIG_RTC_LIB=y
> CONFIG_RTC_MC146818_LIB=y
> CONFIG_RTC_CLASS=y
> CONFIG_RTC_HCTOSYS=y
> CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
> # CONFIG_RTC_SYSTOHC is not set
> # CONFIG_RTC_DEBUG is not set
> # CONFIG_RTC_LIB_KUNIT_TEST is not set
> CONFIG_RTC_NVMEM=y
> 
> #
> # RTC interfaces
> #
> CONFIG_RTC_INTF_SYSFS=y
> # CONFIG_RTC_INTF_PROC is not set
> CONFIG_RTC_INTF_DEV=y
> # CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
> CONFIG_RTC_DRV_TEST=y
> 
> #
> # I2C RTC drivers
> #
> CONFIG_RTC_DRV_88PM80X=y
> CONFIG_RTC_DRV_ABB5ZES3=y
> # CONFIG_RTC_DRV_ABEOZ9 is not set
> CONFIG_RTC_DRV_ABX80X=y
> CONFIG_RTC_DRV_DS1307=y
> # CONFIG_RTC_DRV_DS1307_CENTURY is not set
> # CONFIG_RTC_DRV_DS1374 is not set
> CONFIG_RTC_DRV_DS1672=y
> # CONFIG_RTC_DRV_HYM8563 is not set
> # CONFIG_RTC_DRV_MAX6900 is not set
> CONFIG_RTC_DRV_MAX8907=y
> # CONFIG_RTC_DRV_MAX8925 is not set
> # CONFIG_RTC_DRV_MAX8997 is not set
> # CONFIG_RTC_DRV_MAX77686 is not set
> # CONFIG_RTC_DRV_RK808 is not set
> CONFIG_RTC_DRV_RS5C372=y
> CONFIG_RTC_DRV_ISL1208=y
> # CONFIG_RTC_DRV_ISL12022 is not set
> CONFIG_RTC_DRV_ISL12026=y
> # CONFIG_RTC_DRV_X1205 is not set
> CONFIG_RTC_DRV_PCF8523=y
> CONFIG_RTC_DRV_PCF85063=y
> CONFIG_RTC_DRV_PCF85363=y
> CONFIG_RTC_DRV_PCF8563=y
> # CONFIG_RTC_DRV_PCF8583 is not set
> CONFIG_RTC_DRV_M41T80=y
> CONFIG_RTC_DRV_M41T80_WDT=y
> CONFIG_RTC_DRV_BQ32K=y
> # CONFIG_RTC_DRV_TPS65910 is not set
> # CONFIG_RTC_DRV_RC5T583 is not set
> CONFIG_RTC_DRV_RC5T619=y
> # CONFIG_RTC_DRV_S35390A is not set
> CONFIG_RTC_DRV_FM3130=y
> CONFIG_RTC_DRV_RX8010=y
> CONFIG_RTC_DRV_RX8581=y
> CONFIG_RTC_DRV_RX8025=y
> CONFIG_RTC_DRV_EM3027=y
> CONFIG_RTC_DRV_RV3028=y
> # CONFIG_RTC_DRV_RV3032 is not set
> CONFIG_RTC_DRV_RV8803=y
> # CONFIG_RTC_DRV_S5M is not set
> # CONFIG_RTC_DRV_SD3078 is not set
> 
> #
> # SPI RTC drivers
> #
> CONFIG_RTC_I2C_AND_SPI=y
> 
> #
> # SPI and I2C RTC drivers
> #
> CONFIG_RTC_DRV_DS3232=y
> CONFIG_RTC_DRV_DS3232_HWMON=y
> CONFIG_RTC_DRV_PCF2127=y
> CONFIG_RTC_DRV_RV3029C2=y
> CONFIG_RTC_DRV_RV3029_HWMON=y
> # CONFIG_RTC_DRV_RX6110 is not set
> 
> #
> # Platform RTC drivers
> #
> # CONFIG_RTC_DRV_CMOS is not set
> # CONFIG_RTC_DRV_DS1286 is not set
> CONFIG_RTC_DRV_DS1511=y
> # CONFIG_RTC_DRV_DS1553 is not set
> # CONFIG_RTC_DRV_DS1685_FAMILY is not set
> CONFIG_RTC_DRV_DS1742=y
> CONFIG_RTC_DRV_DS2404=y
> # CONFIG_RTC_DRV_DA9052 is not set
> CONFIG_RTC_DRV_DA9063=y
> CONFIG_RTC_DRV_STK17TA8=y
> CONFIG_RTC_DRV_M48T86=y
> # CONFIG_RTC_DRV_M48T35 is not set
> # CONFIG_RTC_DRV_M48T59 is not set
> CONFIG_RTC_DRV_MSM6242=y
> # CONFIG_RTC_DRV_BQ4802 is not set
> CONFIG_RTC_DRV_RP5C01=y
> # CONFIG_RTC_DRV_V3020 is not set
> CONFIG_RTC_DRV_WM831X=y
> # CONFIG_RTC_DRV_WM8350 is not set
> CONFIG_RTC_DRV_PCF50633=y
> CONFIG_RTC_DRV_ZYNQMP=y
> 
> #
> # on-CPU RTC drivers
> #
> # CONFIG_RTC_DRV_CADENCE is not set
> CONFIG_RTC_DRV_FTRTC010=y
> CONFIG_RTC_DRV_MT6397=y
> CONFIG_RTC_DRV_R7301=y
> 
> #
> # HID Sensor RTC drivers
> #
> CONFIG_RTC_DRV_GOLDFISH=y
> # CONFIG_DMADEVICES is not set
> 
> #
> # DMABUF options
> #
> # CONFIG_SYNC_FILE is not set
> # CONFIG_DMABUF_HEAPS is not set
> # end of DMABUF options
> 
> CONFIG_AUXDISPLAY=y
> CONFIG_CHARLCD=y
> CONFIG_LINEDISP=y
> CONFIG_HD44780_COMMON=y
> CONFIG_HD44780=y
> CONFIG_KS0108=y
> CONFIG_KS0108_PORT=0x378
> CONFIG_KS0108_DELAY=2
> CONFIG_CFAG12864B=y
> CONFIG_CFAG12864B_RATE=20
> CONFIG_IMG_ASCII_LCD=y
> CONFIG_HT16K33=y
> # CONFIG_LCD2S is not set
> CONFIG_PARPORT_PANEL=y
> CONFIG_PANEL_PARPORT=0
> CONFIG_PANEL_PROFILE=5
> # CONFIG_PANEL_CHANGE_MESSAGE is not set
> # CONFIG_CHARLCD_BL_OFF is not set
> # CONFIG_CHARLCD_BL_ON is not set
> CONFIG_CHARLCD_BL_FLASH=y
> CONFIG_PANEL=y
> CONFIG_UIO=y
> # CONFIG_UIO_CIF is not set
> CONFIG_UIO_PDRV_GENIRQ=y
> # CONFIG_UIO_DMEM_GENIRQ is not set
> # CONFIG_UIO_AEC is not set
> # CONFIG_UIO_SERCOS3 is not set
> # CONFIG_UIO_PCI_GENERIC is not set
> # CONFIG_UIO_NETX is not set
> CONFIG_UIO_PRUSS=y
> # CONFIG_UIO_MF624 is not set
> # CONFIG_VFIO is not set
> # CONFIG_VIRT_DRIVERS is not set
> CONFIG_VIRTIO=y
> # CONFIG_VIRTIO_MENU is not set
> CONFIG_VDPA=y
> CONFIG_VDPA_SIM=y
> # CONFIG_VDPA_SIM_NET is not set
> # CONFIG_VDPA_SIM_BLOCK is not set
> CONFIG_VHOST_IOTLB=y
> CONFIG_VHOST_RING=y
> CONFIG_VHOST_MENU=y
> # CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
> 
> #
> # Microsoft Hyper-V guest support
> #
> # end of Microsoft Hyper-V guest support
> 
> # CONFIG_GREYBUS is not set
> # CONFIG_COMEDI is not set
> # CONFIG_STAGING is not set
> CONFIG_X86_PLATFORM_DEVICES=y
> # CONFIG_ACPI_WMI is not set
> CONFIG_ACERHDF=y
> # CONFIG_ACER_WIRELESS is not set
> # CONFIG_AMD_PMC is not set
> # CONFIG_ADV_SWBUTTON is not set
> # CONFIG_APPLE_GMUX is not set
> # CONFIG_ASUS_LAPTOP is not set
> CONFIG_ASUS_WIRELESS=y
> # CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
> CONFIG_FUJITSU_LAPTOP=y
> CONFIG_FUJITSU_TABLET=y
> CONFIG_GPD_POCKET_FAN=y
> # CONFIG_HP_ACCEL is not set
> # CONFIG_WIRELESS_HOTKEY is not set
> # CONFIG_IBM_RTL is not set
> # CONFIG_SENSORS_HDAPS is not set
> # CONFIG_THINKPAD_ACPI is not set
> CONFIG_X86_PLATFORM_DRIVERS_INTEL=y
> CONFIG_INTEL_ATOMISP2_PDX86=y
> CONFIG_INTEL_ATOMISP2_LED=y
> # CONFIG_INTEL_ATOMISP2_PM is not set
> # CONFIG_INTEL_SAR_INT1092 is not set
> # CONFIG_INTEL_SKL_INT3472 is not set
> # CONFIG_INTEL_PMC_CORE is not set
> # CONFIG_INTEL_HID_EVENT is not set
> CONFIG_INTEL_VBTN=y
> CONFIG_INTEL_INT0002_VGPIO=y
> # CONFIG_INTEL_CHTDC_TI_PWRBTN is not set
> CONFIG_INTEL_PUNIT_IPC=y
> CONFIG_INTEL_RST=y
> CONFIG_INTEL_SMARTCONNECT=y
> # CONFIG_PCENGINES_APU2 is not set
> # CONFIG_BARCO_P50_GPIO is not set
> CONFIG_SAMSUNG_LAPTOP=y
> CONFIG_SAMSUNG_Q10=y
> CONFIG_TOSHIBA_BT_RFKILL=y
> CONFIG_TOSHIBA_HAPS=y
> CONFIG_ACPI_CMPC=y
> CONFIG_PANASONIC_LAPTOP=y
> CONFIG_SYSTEM76_ACPI=y
> CONFIG_TOPSTAR_LAPTOP=y
> CONFIG_I2C_MULTI_INSTANTIATE=y
> # CONFIG_MLX_PLATFORM is not set
> # CONFIG_TOUCHSCREEN_DMI is not set
> # CONFIG_INTEL_IPS is not set
> CONFIG_INTEL_SCU_IPC=y
> # CONFIG_INTEL_SCU_PCI is not set
> # CONFIG_INTEL_SCU_PLATFORM is not set
> CONFIG_PMC_ATOM=y
> CONFIG_GOLDFISH_PIPE=y
> # CONFIG_CHROME_PLATFORMS is not set
> # CONFIG_MELLANOX_PLATFORM is not set
> CONFIG_SURFACE_PLATFORMS=y
> CONFIG_SURFACE_3_POWER_OPREGION=y
> # CONFIG_SURFACE_GPE is not set
> # CONFIG_SURFACE_HOTPLUG is not set
> CONFIG_SURFACE_PRO3_BUTTON=y
> CONFIG_HAVE_CLK=y
> CONFIG_HAVE_CLK_PREPARE=y
> CONFIG_COMMON_CLK=y
> # CONFIG_COMMON_CLK_WM831X is not set
> CONFIG_COMMON_CLK_MAX77686=y
> # CONFIG_COMMON_CLK_MAX9485 is not set
> CONFIG_COMMON_CLK_RK808=y
> # CONFIG_COMMON_CLK_SI5341 is not set
> CONFIG_COMMON_CLK_SI5351=y
> CONFIG_COMMON_CLK_SI514=y
> # CONFIG_COMMON_CLK_SI544 is not set
> CONFIG_COMMON_CLK_SI570=y
> # CONFIG_COMMON_CLK_CDCE706 is not set
> CONFIG_COMMON_CLK_CDCE925=y
> # CONFIG_COMMON_CLK_CS2000_CP is not set
> CONFIG_COMMON_CLK_S2MPS11=y
> CONFIG_CLK_TWL6040=y
> CONFIG_COMMON_CLK_AXI_CLKGEN=y
> CONFIG_COMMON_CLK_PWM=y
> CONFIG_COMMON_CLK_VC5=y
> # CONFIG_COMMON_CLK_BD718XX is not set
> # CONFIG_COMMON_CLK_FIXED_MMIO is not set
> CONFIG_CLK_LGM_CGU=y
> CONFIG_XILINX_VCU=y
> # CONFIG_HWSPINLOCK is not set
> 
> #
> # Clock Source drivers
> #
> CONFIG_TIMER_OF=y
> CONFIG_TIMER_PROBE=y
> CONFIG_CLKSRC_I8253=y
> CONFIG_CLKEVT_I8253=y
> CONFIG_I8253_LOCK=y
> CONFIG_CLKBLD_I8253=y
> CONFIG_CLKSRC_MMIO=y
> CONFIG_MICROCHIP_PIT64B=y
> # end of Clock Source drivers
> 
> CONFIG_MAILBOX=y
> CONFIG_PLATFORM_MHU=y
> # CONFIG_PCC is not set
> CONFIG_ALTERA_MBOX=y
> # CONFIG_MAILBOX_TEST is not set
> CONFIG_IOMMU_IOVA=y
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
> # CONFIG_REMOTEPROC is not set
> # end of Remoteproc drivers
> 
> #
> # Rpmsg drivers
> #
> CONFIG_RPMSG=y
> # CONFIG_RPMSG_CHAR is not set
> CONFIG_RPMSG_NS=y
> CONFIG_RPMSG_QCOM_GLINK=y
> CONFIG_RPMSG_QCOM_GLINK_RPM=y
> CONFIG_RPMSG_VIRTIO=y
> # end of Rpmsg drivers
> 
> CONFIG_SOUNDWIRE=y
> 
> #
> # SoundWire Devices
> #
> CONFIG_SOUNDWIRE_CADENCE=y
> CONFIG_SOUNDWIRE_INTEL=y
> CONFIG_SOUNDWIRE_QCOM=y
> CONFIG_SOUNDWIRE_GENERIC_ALLOCATION=y
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
> # CONFIG_SOC_TI is not set
> 
> #
> # Xilinx SoC drivers
> #
> # end of Xilinx SoC drivers
> # end of SOC (System On Chip) specific Drivers
> 
> # CONFIG_PM_DEVFREQ is not set
> CONFIG_EXTCON=y
> 
> #
> # Extcon Device Drivers
> #
> # CONFIG_EXTCON_AXP288 is not set
> # CONFIG_EXTCON_FSA9480 is not set
> CONFIG_EXTCON_GPIO=y
> # CONFIG_EXTCON_INTEL_INT3496 is not set
> CONFIG_EXTCON_INTEL_CHT_WC=y
> # CONFIG_EXTCON_MAX3355 is not set
> CONFIG_EXTCON_MAX77693=y
> CONFIG_EXTCON_MAX77843=y
> CONFIG_EXTCON_MAX8997=y
> CONFIG_EXTCON_PTN5150=y
> CONFIG_EXTCON_RT8973A=y
> CONFIG_EXTCON_SM5502=y
> CONFIG_EXTCON_USB_GPIO=y
> # CONFIG_EXTCON_USBC_TUSB320 is not set
> CONFIG_MEMORY=y
> # CONFIG_IIO is not set
> # CONFIG_NTB is not set
> # CONFIG_VME_BUS is not set
> CONFIG_PWM=y
> CONFIG_PWM_SYSFS=y
> # CONFIG_PWM_DEBUG is not set
> CONFIG_PWM_ATMEL_HLCDC_PWM=y
> # CONFIG_PWM_ATMEL_TCB is not set
> # CONFIG_PWM_DWC is not set
> # CONFIG_PWM_FSL_FTM is not set
> # CONFIG_PWM_INTEL_LGM is not set
> CONFIG_PWM_LPSS=y
> # CONFIG_PWM_LPSS_PCI is not set
> CONFIG_PWM_LPSS_PLATFORM=y
> CONFIG_PWM_PCA9685=y
> 
> #
> # IRQ chip support
> #
> CONFIG_IRQCHIP=y
> CONFIG_AL_FIC=y
> # end of IRQ chip support
> 
> CONFIG_IPACK_BUS=y
> # CONFIG_BOARD_TPCI200 is not set
> # CONFIG_SERIAL_IPOCTAL is not set
> CONFIG_RESET_CONTROLLER=y
> # CONFIG_RESET_INTEL_GW is not set
> # CONFIG_RESET_TI_SYSCON is not set
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
> CONFIG_BCM_KONA_USB2_PHY=y
> # end of PHY drivers for Broadcom platforms
> 
> # CONFIG_PHY_CADENCE_TORRENT is not set
> CONFIG_PHY_CADENCE_DPHY=y
> CONFIG_PHY_CADENCE_SIERRA=y
> # CONFIG_PHY_CADENCE_SALVO is not set
> CONFIG_PHY_FSL_IMX8MQ_USB=y
> # CONFIG_PHY_MIXEL_MIPI_DPHY is not set
> CONFIG_PHY_PXA_28NM_HSIC=y
> CONFIG_PHY_PXA_28NM_USB2=y
> # CONFIG_PHY_MAPPHONE_MDM6600 is not set
> # CONFIG_PHY_OCELOT_SERDES is not set
> # CONFIG_PHY_INTEL_LGM_COMBO is not set
> CONFIG_PHY_INTEL_LGM_EMMC=y
> # end of PHY Subsystem
> 
> # CONFIG_POWERCAP is not set
> CONFIG_MCB=y
> # CONFIG_MCB_PCI is not set
> CONFIG_MCB_LPC=y
> 
> #
> # Performance monitor support
> #
> # end of Performance monitor support
> 
> # CONFIG_RAS is not set
> # CONFIG_USB4 is not set
> 
> #
> # Android
> #
> CONFIG_ANDROID=y
> CONFIG_ANDROID_BINDER_IPC=y
> # CONFIG_ANDROID_BINDERFS is not set
> CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
> # CONFIG_ANDROID_BINDER_IPC_SELFTEST is not set
> # end of Android
> 
> # CONFIG_DAX is not set
> CONFIG_NVMEM=y
> CONFIG_NVMEM_SYSFS=y
> CONFIG_NVMEM_SPMI_SDAM=y
> # CONFIG_NVMEM_RMEM is not set
> 
> #
> # HW tracing support
> #
> # CONFIG_STM is not set
> CONFIG_INTEL_TH=y
> # CONFIG_INTEL_TH_PCI is not set
> # CONFIG_INTEL_TH_ACPI is not set
> # CONFIG_INTEL_TH_GTH is not set
> CONFIG_INTEL_TH_MSU=y
> CONFIG_INTEL_TH_PTI=y
> # CONFIG_INTEL_TH_DEBUG is not set
> # end of HW tracing support
> 
> CONFIG_FPGA=y
> CONFIG_ALTERA_PR_IP_CORE=y
> # CONFIG_ALTERA_PR_IP_CORE_PLAT is not set
> # CONFIG_FPGA_MGR_ALTERA_CVP is not set
> CONFIG_FPGA_BRIDGE=y
> # CONFIG_ALTERA_FREEZE_BRIDGE is not set
> # CONFIG_XILINX_PR_DECOUPLER is not set
> CONFIG_FPGA_REGION=y
> CONFIG_OF_FPGA_REGION=y
> # CONFIG_FPGA_DFL is not set
> CONFIG_FSI=y
> # CONFIG_FSI_NEW_DEV_NODE is not set
> CONFIG_FSI_MASTER_GPIO=y
> # CONFIG_FSI_MASTER_HUB is not set
> CONFIG_FSI_MASTER_ASPEED=y
> # CONFIG_FSI_SCOM is not set
> # CONFIG_FSI_SBEFIFO is not set
> CONFIG_PM_OPP=y
> CONFIG_SIOX=y
> CONFIG_SIOX_BUS_GPIO=y
> CONFIG_SLIMBUS=y
> CONFIG_SLIM_QCOM_CTRL=y
> # CONFIG_INTERCONNECT is not set
> CONFIG_COUNTER=y
> # CONFIG_INTERRUPT_CNT is not set
> # CONFIG_FTM_QUADDEC is not set
> # CONFIG_MICROCHIP_TCB_CAPTURE is not set
> # CONFIG_INTEL_QEP is not set
> # CONFIG_MOST is not set
> # end of Device Drivers
> 
> #
> # File systems
> #
> CONFIG_DCACHE_WORD_ACCESS=y
> CONFIG_VALIDATE_FS_PARSER=y
> CONFIG_FS_POSIX_ACL=y
> CONFIG_EXPORTFS=y
> CONFIG_EXPORTFS_BLOCK_OPS=y
> CONFIG_FILE_LOCKING=y
> # CONFIG_FS_ENCRYPTION is not set
> # CONFIG_FS_VERITY is not set
> CONFIG_FSNOTIFY=y
> CONFIG_DNOTIFY=y
> CONFIG_INOTIFY_USER=y
> CONFIG_FANOTIFY=y
> # CONFIG_FANOTIFY_ACCESS_PERMISSIONS is not set
> CONFIG_QUOTA=y
> # CONFIG_QUOTA_NETLINK_INTERFACE is not set
> CONFIG_PRINT_QUOTA_WARNING=y
> # CONFIG_QUOTA_DEBUG is not set
> CONFIG_QFMT_V1=y
> # CONFIG_QFMT_V2 is not set
> CONFIG_QUOTACTL=y
> CONFIG_AUTOFS4_FS=y
> CONFIG_AUTOFS_FS=y
> CONFIG_FUSE_FS=y
> CONFIG_CUSE=y
> CONFIG_VIRTIO_FS=y
> CONFIG_OVERLAY_FS=y
> CONFIG_OVERLAY_FS_REDIRECT_DIR=y
> # CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
> # CONFIG_OVERLAY_FS_INDEX is not set
> # CONFIG_OVERLAY_FS_METACOPY is not set
> 
> #
> # Caches
> #
> CONFIG_NETFS_SUPPORT=y
> CONFIG_NETFS_STATS=y
> CONFIG_FSCACHE=y
> CONFIG_FSCACHE_STATS=y
> # CONFIG_FSCACHE_DEBUG is not set
> # end of Caches
> 
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> CONFIG_PROC_KCORE=y
> CONFIG_PROC_SYSCTL=y
> # CONFIG_PROC_PAGE_MONITOR is not set
> # CONFIG_PROC_CHILDREN is not set
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
> # end of Pseudo filesystems
> 
> CONFIG_MISC_FILESYSTEMS=y
> CONFIG_ORANGEFS_FS=y
> # CONFIG_ECRYPT_FS is not set
> CONFIG_CRAMFS=y
> # CONFIG_PSTORE is not set
> CONFIG_NETWORK_FILESYSTEMS=y
> CONFIG_NFS_FS=y
> CONFIG_NFS_V2=y
> CONFIG_NFS_V3=y
> # CONFIG_NFS_V3_ACL is not set
> CONFIG_NFS_V4=m
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
> CONFIG_NLS_CODEPAGE_437=y
> CONFIG_NLS_CODEPAGE_737=y
> # CONFIG_NLS_CODEPAGE_775 is not set
> # CONFIG_NLS_CODEPAGE_850 is not set
> # CONFIG_NLS_CODEPAGE_852 is not set
> CONFIG_NLS_CODEPAGE_855=y
> CONFIG_NLS_CODEPAGE_857=y
> CONFIG_NLS_CODEPAGE_860=y
> CONFIG_NLS_CODEPAGE_861=y
> CONFIG_NLS_CODEPAGE_862=y
> CONFIG_NLS_CODEPAGE_863=y
> CONFIG_NLS_CODEPAGE_864=y
> CONFIG_NLS_CODEPAGE_865=y
> CONFIG_NLS_CODEPAGE_866=y
> # CONFIG_NLS_CODEPAGE_869 is not set
> CONFIG_NLS_CODEPAGE_936=y
> # CONFIG_NLS_CODEPAGE_950 is not set
> CONFIG_NLS_CODEPAGE_932=y
> CONFIG_NLS_CODEPAGE_949=y
> CONFIG_NLS_CODEPAGE_874=y
> CONFIG_NLS_ISO8859_8=y
> CONFIG_NLS_CODEPAGE_1250=y
> CONFIG_NLS_CODEPAGE_1251=y
> CONFIG_NLS_ASCII=y
> CONFIG_NLS_ISO8859_1=y
> CONFIG_NLS_ISO8859_2=y
> CONFIG_NLS_ISO8859_3=y
> CONFIG_NLS_ISO8859_4=y
> CONFIG_NLS_ISO8859_5=y
> # CONFIG_NLS_ISO8859_6 is not set
> # CONFIG_NLS_ISO8859_7 is not set
> # CONFIG_NLS_ISO8859_9 is not set
> # CONFIG_NLS_ISO8859_13 is not set
> CONFIG_NLS_ISO8859_14=y
> CONFIG_NLS_ISO8859_15=y
> CONFIG_NLS_KOI8_R=y
> # CONFIG_NLS_KOI8_U is not set
> CONFIG_NLS_MAC_ROMAN=y
> # CONFIG_NLS_MAC_CELTIC is not set
> # CONFIG_NLS_MAC_CENTEURO is not set
> CONFIG_NLS_MAC_CROATIAN=y
> CONFIG_NLS_MAC_CYRILLIC=y
> CONFIG_NLS_MAC_GAELIC=y
> # CONFIG_NLS_MAC_GREEK is not set
> # CONFIG_NLS_MAC_ICELAND is not set
> CONFIG_NLS_MAC_INUIT=y
> # CONFIG_NLS_MAC_ROMANIAN is not set
> CONFIG_NLS_MAC_TURKISH=y
> # CONFIG_NLS_UTF8 is not set
> # CONFIG_DLM is not set
> CONFIG_UNICODE=y
> CONFIG_UNICODE_NORMALIZATION_SELFTEST=y
> CONFIG_IO_WQ=y
> # end of File systems
> 
> #
> # Security options
> #
> CONFIG_KEYS=y
> # CONFIG_KEYS_REQUEST_CACHE is not set
> CONFIG_PERSISTENT_KEYRINGS=y
> # CONFIG_BIG_KEYS is not set
> # CONFIG_TRUSTED_KEYS is not set
> CONFIG_ENCRYPTED_KEYS=y
> CONFIG_KEY_DH_OPERATIONS=y
> CONFIG_KEY_NOTIFICATIONS=y
> # CONFIG_SECURITY_DMESG_RESTRICT is not set
> CONFIG_SECURITY=y
> CONFIG_SECURITYFS=y
> CONFIG_SECURITY_NETWORK=y
> CONFIG_PAGE_TABLE_ISOLATION=y
> CONFIG_SECURITY_PATH=y
> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
> CONFIG_HARDENED_USERCOPY=y
> # CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
> CONFIG_FORTIFY_SOURCE=y
> # CONFIG_STATIC_USERMODEHELPER is not set
> # CONFIG_SECURITY_SMACK is not set
> # CONFIG_SECURITY_TOMOYO is not set
> # CONFIG_SECURITY_APPARMOR is not set
> CONFIG_SECURITY_YAMA=y
> CONFIG_SECURITY_SAFESETID=y
> # CONFIG_SECURITY_LOCKDOWN_LSM is not set
> # CONFIG_SECURITY_LANDLOCK is not set
> CONFIG_INTEGRITY=y
> CONFIG_INTEGRITY_SIGNATURE=y
> CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
> CONFIG_INTEGRITY_TRUSTED_KEYRING=y
> CONFIG_IMA=y
> CONFIG_IMA_MEASURE_PCR_IDX=10
> # CONFIG_IMA_TEMPLATE is not set
> CONFIG_IMA_NG_TEMPLATE=y
> # CONFIG_IMA_SIG_TEMPLATE is not set
> CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
> # CONFIG_IMA_DEFAULT_HASH_SHA1 is not set
> CONFIG_IMA_DEFAULT_HASH_SHA256=y
> # CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
> CONFIG_IMA_DEFAULT_HASH="sha256"
> # CONFIG_IMA_WRITE_POLICY is not set
> CONFIG_IMA_READ_POLICY=y
> CONFIG_IMA_APPRAISE=y
> CONFIG_IMA_ARCH_POLICY=y
> CONFIG_IMA_APPRAISE_BUILD_POLICY=y
> CONFIG_IMA_APPRAISE_REQUIRE_FIRMWARE_SIGS=y
> CONFIG_IMA_APPRAISE_REQUIRE_KEXEC_SIGS=y
> # CONFIG_IMA_APPRAISE_REQUIRE_MODULE_SIGS is not set
> CONFIG_IMA_APPRAISE_REQUIRE_POLICY_SIGS=y
> CONFIG_IMA_APPRAISE_BOOTPARAM=y
> CONFIG_IMA_APPRAISE_MODSIG=y
> # CONFIG_IMA_TRUSTED_KEYRING is not set
> CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
> CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
> # CONFIG_IMA_DISABLE_HTABLE is not set
> # CONFIG_EVM is not set
> CONFIG_DEFAULT_SECURITY_DAC=y
> CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,bpf"
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
> # CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
> # end of Memory initialization
> # end of Kernel hardening options
> # end of Security options
> 
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
> CONFIG_CRYPTO_RNG_DEFAULT=y
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
> CONFIG_CRYPTO_CRYPTD=y
> CONFIG_CRYPTO_AUTHENC=y
> # CONFIG_CRYPTO_TEST is not set
> CONFIG_CRYPTO_SIMD=y
> 
> #
> # Public-key cryptography
> #
> CONFIG_CRYPTO_RSA=y
> CONFIG_CRYPTO_DH=y
> CONFIG_CRYPTO_ECC=y
> CONFIG_CRYPTO_ECDH=y
> # CONFIG_CRYPTO_ECDSA is not set
> # CONFIG_CRYPTO_ECRDSA is not set
> # CONFIG_CRYPTO_SM2 is not set
> CONFIG_CRYPTO_CURVE25519=y
> 
> #
> # Authenticated Encryption with Associated Data
> #
> CONFIG_CRYPTO_CCM=y
> CONFIG_CRYPTO_GCM=y
> # CONFIG_CRYPTO_CHACHA20POLY1305 is not set
> CONFIG_CRYPTO_AEGIS128=y
> # CONFIG_CRYPTO_SEQIV is not set
> CONFIG_CRYPTO_ECHAINIV=y
> 
> #
> # Block modes
> #
> CONFIG_CRYPTO_CBC=y
> CONFIG_CRYPTO_CFB=y
> CONFIG_CRYPTO_CTR=y
> CONFIG_CRYPTO_CTS=y
> CONFIG_CRYPTO_ECB=y
> # CONFIG_CRYPTO_LRW is not set
> CONFIG_CRYPTO_OFB=y
> CONFIG_CRYPTO_PCBC=y
> CONFIG_CRYPTO_XTS=y
> CONFIG_CRYPTO_KEYWRAP=y
> CONFIG_CRYPTO_NHPOLY1305=y
> CONFIG_CRYPTO_ADIANTUM=y
> # CONFIG_CRYPTO_ESSIV is not set
> 
> #
> # Hash modes
> #
> CONFIG_CRYPTO_CMAC=m
> CONFIG_CRYPTO_HMAC=y
> # CONFIG_CRYPTO_XCBC is not set
> CONFIG_CRYPTO_VMAC=y
> 
> #
> # Digest
> #
> CONFIG_CRYPTO_CRC32C=y
> CONFIG_CRYPTO_CRC32C_INTEL=y
> CONFIG_CRYPTO_CRC32=y
> # CONFIG_CRYPTO_CRC32_PCLMUL is not set
> CONFIG_CRYPTO_XXHASH=y
> CONFIG_CRYPTO_BLAKE2B=y
> CONFIG_CRYPTO_BLAKE2S=y
> CONFIG_CRYPTO_CRCT10DIF=y
> CONFIG_CRYPTO_GHASH=y
> # CONFIG_CRYPTO_POLY1305 is not set
> CONFIG_CRYPTO_MD4=y
> CONFIG_CRYPTO_MD5=m
> CONFIG_CRYPTO_MICHAEL_MIC=y
> CONFIG_CRYPTO_RMD160=y
> CONFIG_CRYPTO_SHA1=y
> CONFIG_CRYPTO_SHA256=y
> CONFIG_CRYPTO_SHA512=y
> # CONFIG_CRYPTO_SHA3 is not set
> # CONFIG_CRYPTO_SM3 is not set
> CONFIG_CRYPTO_STREEBOG=y
> # CONFIG_CRYPTO_WP512 is not set
> 
> #
> # Ciphers
> #
> CONFIG_CRYPTO_AES=y
> CONFIG_CRYPTO_AES_TI=y
> CONFIG_CRYPTO_AES_NI_INTEL=y
> CONFIG_CRYPTO_BLOWFISH=y
> CONFIG_CRYPTO_BLOWFISH_COMMON=y
> CONFIG_CRYPTO_CAMELLIA=y
> CONFIG_CRYPTO_CAST_COMMON=y
> # CONFIG_CRYPTO_CAST5 is not set
> CONFIG_CRYPTO_CAST6=y
> CONFIG_CRYPTO_DES=y
> CONFIG_CRYPTO_FCRYPT=y
> CONFIG_CRYPTO_CHACHA20=y
> CONFIG_CRYPTO_SERPENT=y
> CONFIG_CRYPTO_SERPENT_SSE2_586=y
> CONFIG_CRYPTO_SM4=y
> CONFIG_CRYPTO_TWOFISH=y
> CONFIG_CRYPTO_TWOFISH_COMMON=y
> CONFIG_CRYPTO_TWOFISH_586=y
> 
> #
> # Compression
> #
> # CONFIG_CRYPTO_DEFLATE is not set
> CONFIG_CRYPTO_LZO=y
> # CONFIG_CRYPTO_842 is not set
> CONFIG_CRYPTO_LZ4=y
> # CONFIG_CRYPTO_LZ4HC is not set
> CONFIG_CRYPTO_ZSTD=y
> 
> #
> # Random Number Generation
> #
> CONFIG_CRYPTO_ANSI_CPRNG=y
> CONFIG_CRYPTO_DRBG_MENU=y
> CONFIG_CRYPTO_DRBG_HMAC=y
> # CONFIG_CRYPTO_DRBG_HASH is not set
> CONFIG_CRYPTO_DRBG_CTR=y
> CONFIG_CRYPTO_DRBG=y
> CONFIG_CRYPTO_JITTERENTROPY=y
> # CONFIG_CRYPTO_USER_API_HASH is not set
> # CONFIG_CRYPTO_USER_API_SKCIPHER is not set
> # CONFIG_CRYPTO_USER_API_RNG is not set
> # CONFIG_CRYPTO_USER_API_AEAD is not set
> CONFIG_CRYPTO_HASH_INFO=y
> 
> #
> # Crypto library routines
> #
> CONFIG_CRYPTO_LIB_AES=y
> CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
> CONFIG_CRYPTO_LIB_BLAKE2S=y
> CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
> CONFIG_CRYPTO_LIB_CHACHA=y
> CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
> # CONFIG_CRYPTO_LIB_CURVE25519 is not set
> CONFIG_CRYPTO_LIB_DES=y
> CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
> CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
> CONFIG_CRYPTO_LIB_POLY1305=y
> CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
> CONFIG_CRYPTO_LIB_SHA256=y
> CONFIG_CRYPTO_LIB_SM4=y
> # CONFIG_CRYPTO_HW is not set
> CONFIG_ASYMMETRIC_KEY_TYPE=y
> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
> CONFIG_X509_CERTIFICATE_PARSER=y
> CONFIG_PKCS8_PRIVATE_KEY_PARSER=y
> CONFIG_PKCS7_MESSAGE_PARSER=y
> CONFIG_PKCS7_TEST_KEY=y
> # CONFIG_SIGNED_PE_FILE_VERIFICATION is not set
> 
> #
> # Certificates for signature checking
> #
> CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
> CONFIG_MODULE_SIG_KEY_TYPE_RSA=y
> # CONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set
> CONFIG_SYSTEM_TRUSTED_KEYRING=y
> CONFIG_SYSTEM_TRUSTED_KEYS=""
> # CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
> # CONFIG_SECONDARY_TRUSTED_KEYRING is not set
> # CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
> # end of Certificates for signature checking
> 
> CONFIG_BINARY_PRINTF=y
> 
> #
> # Library routines
> #
> CONFIG_LINEAR_RANGES=y
> CONFIG_PACKING=y
> CONFIG_BITREVERSE=y
> CONFIG_GENERIC_STRNCPY_FROM_USER=y
> CONFIG_GENERIC_STRNLEN_USER=y
> CONFIG_GENERIC_NET_UTILS=y
> CONFIG_GENERIC_FIND_FIRST_BIT=y
> # CONFIG_CORDIC is not set
> CONFIG_PRIME_NUMBERS=y
> CONFIG_RATIONAL=y
> CONFIG_GENERIC_PCI_IOMAP=y
> CONFIG_GENERIC_IOMAP=y
> CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
> CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
> CONFIG_CRC_CCITT=y
> CONFIG_CRC16=y
> CONFIG_CRC_T10DIF=y
> # CONFIG_CRC_ITU_T is not set
> CONFIG_CRC32=y
> # CONFIG_CRC32_SELFTEST is not set
> # CONFIG_CRC32_SLICEBY8 is not set
> # CONFIG_CRC32_SLICEBY4 is not set
> CONFIG_CRC32_SARWATE=y
> # CONFIG_CRC32_BIT is not set
> CONFIG_CRC64=y
> CONFIG_CRC4=y
> CONFIG_CRC7=y
> CONFIG_LIBCRC32C=y
> CONFIG_CRC8=y
> CONFIG_XXHASH=y
> CONFIG_RANDOM32_SELFTEST=y
> CONFIG_ZLIB_INFLATE=y
> CONFIG_LZO_COMPRESS=y
> CONFIG_LZO_DECOMPRESS=y
> CONFIG_LZ4_COMPRESS=y
> CONFIG_LZ4_DECOMPRESS=y
> CONFIG_ZSTD_COMPRESS=y
> CONFIG_ZSTD_DECOMPRESS=y
> CONFIG_XZ_DEC=y
> # CONFIG_XZ_DEC_X86 is not set
> CONFIG_XZ_DEC_POWERPC=y
> CONFIG_XZ_DEC_IA64=y
> # CONFIG_XZ_DEC_ARM is not set
> CONFIG_XZ_DEC_ARMTHUMB=y
> # CONFIG_XZ_DEC_SPARC is not set
> # CONFIG_XZ_DEC_MICROLZMA is not set
> CONFIG_XZ_DEC_BCJ=y
> CONFIG_XZ_DEC_TEST=y
> CONFIG_DECOMPRESS_GZIP=y
> CONFIG_DECOMPRESS_LZMA=y
> CONFIG_GENERIC_ALLOCATOR=y
> CONFIG_XARRAY_MULTI=y
> CONFIG_ASSOCIATIVE_ARRAY=y
> CONFIG_HAS_IOMEM=y
> CONFIG_HAS_IOPORT_MAP=y
> CONFIG_HAS_DMA=y
> CONFIG_DMA_OPS=y
> CONFIG_NEED_SG_DMA_LENGTH=y
> CONFIG_NEED_DMA_MAP_STATE=y
> CONFIG_ARCH_DMA_ADDR_T_64BIT=y
> CONFIG_DMA_DECLARE_COHERENT=y
> CONFIG_SWIOTLB=y
> CONFIG_DMA_RESTRICTED_POOL=y
> # CONFIG_DMA_CMA is not set
> # CONFIG_DMA_API_DEBUG is not set
> # CONFIG_DMA_MAP_BENCHMARK is not set
> CONFIG_SGL_ALLOC=y
> CONFIG_CHECK_SIGNATURE=y
> CONFIG_DQL=y
> CONFIG_GLOB=y
> CONFIG_GLOB_SELFTEST=y
> CONFIG_NLATTR=y
> CONFIG_CLZ_TAB=y
> # CONFIG_IRQ_POLL is not set
> CONFIG_MPILIB=y
> CONFIG_SIGNATURE=y
> CONFIG_LIBFDT=y
> CONFIG_OID_REGISTRY=y
> CONFIG_HAVE_GENERIC_VDSO=y
> CONFIG_GENERIC_GETTIMEOFDAY=y
> CONFIG_GENERIC_VDSO_32=y
> CONFIG_GENERIC_VDSO_TIME_NS=y
> CONFIG_ARCH_STACKWALK=y
> CONFIG_STACKDEPOT=y
> CONFIG_STACK_HASH_ORDER=20
> # end of Library routines
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
> CONFIG_DYNAMIC_DEBUG=y
> CONFIG_DYNAMIC_DEBUG_CORE=y
> CONFIG_SYMBOLIC_ERRNAME=y
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
> # CONFIG_STRIP_ASM_SYMS is not set
> CONFIG_READABLE_ASM=y
> # CONFIG_HEADERS_INSTALL is not set
> CONFIG_DEBUG_SECTION_MISMATCH=y
> CONFIG_SECTION_MISMATCH_WARN_ONLY=y
> # CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not set
> CONFIG_FRAME_POINTER=y
> # CONFIG_VMLINUX_MAP is not set
> # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
> # end of Compile-time checks and compiler options
> 
> #
> # Generic Kernel Debugging Instruments
> #
> CONFIG_MAGIC_SYSRQ=y
> CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
> # CONFIG_MAGIC_SYSRQ_SERIAL is not set
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
> # CONFIG_UBSAN_UNREACHABLE is not set
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
> # Memory Debugging
> #
> CONFIG_PAGE_EXTENSION=y
> # CONFIG_DEBUG_PAGEALLOC is not set
> # CONFIG_PAGE_OWNER is not set
> # CONFIG_PAGE_POISONING is not set
> # CONFIG_DEBUG_PAGE_REF is not set
> CONFIG_DEBUG_RODATA_TEST=y
> CONFIG_ARCH_HAS_DEBUG_WX=y
> CONFIG_DEBUG_WX=y
> CONFIG_GENERIC_PTDUMP=y
> CONFIG_PTDUMP_CORE=y
> CONFIG_PTDUMP_DEBUGFS=y
> # CONFIG_DEBUG_OBJECTS is not set
> CONFIG_SLUB_DEBUG_ON=y
> CONFIG_SLUB_STATS=y
> CONFIG_HAVE_DEBUG_KMEMLEAK=y
> # CONFIG_DEBUG_KMEMLEAK is not set
> CONFIG_DEBUG_STACK_USAGE=y
> # CONFIG_SCHED_STACK_END_CHECK is not set
> # CONFIG_DEBUG_VM is not set
> CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
> CONFIG_DEBUG_VIRTUAL=y
> CONFIG_DEBUG_MEMORY_INIT=y
> CONFIG_DEBUG_KMAP_LOCAL=y
> CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
> CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP=y
> # CONFIG_DEBUG_HIGHMEM is not set
> CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
> CONFIG_DEBUG_STACKOVERFLOW=y
> CONFIG_CC_HAS_KASAN_GENERIC=y
> CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
> CONFIG_HAVE_ARCH_KFENCE=y
> CONFIG_KFENCE=y
> CONFIG_KFENCE_SAMPLE_INTERVAL=100
> CONFIG_KFENCE_NUM_OBJECTS=255
> CONFIG_KFENCE_STRESS_TEST_FAULTS=0
> # CONFIG_KFENCE_KUNIT_TEST is not set
> # end of Memory Debugging
> 
> CONFIG_DEBUG_SHIRQ=y
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
> # CONFIG_SCHED_DEBUG is not set
> CONFIG_SCHED_INFO=y
> CONFIG_SCHEDSTATS=y
> # end of Scheduler Debugging
> 
> CONFIG_DEBUG_TIMEKEEPING=y
> CONFIG_DEBUG_PREEMPT=y
> 
> #
> # Lock Debugging (spinlocks, mutexes, etc...)
> #
> CONFIG_LOCK_DEBUGGING_SUPPORT=y
> CONFIG_PROVE_LOCKING=y
> # CONFIG_PROVE_RAW_LOCK_NESTING is not set
> CONFIG_LOCK_STAT=y
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
> CONFIG_WW_MUTEX_SELFTEST=y
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
> CONFIG_DEBUG_LIST=y
> # CONFIG_DEBUG_PLIST is not set
> # CONFIG_DEBUG_SG is not set
> CONFIG_DEBUG_NOTIFIERS=y
> # CONFIG_BUG_ON_DATA_CORRUPTION is not set
> # end of Debug kernel data structures
> 
> CONFIG_DEBUG_CREDENTIALS=y
> 
> #
> # RCU Debugging
> #
> CONFIG_PROVE_RCU=y
> CONFIG_TORTURE_TEST=m
> CONFIG_RCU_SCALE_TEST=m
> CONFIG_RCU_TORTURE_TEST=m
> # CONFIG_RCU_REF_SCALE_TEST is not set
> CONFIG_RCU_CPU_STALL_TIMEOUT=21
> CONFIG_RCU_TRACE=y
> CONFIG_RCU_EQS_DEBUG=y
> # end of RCU Debugging
> 
> CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
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
> CONFIG_TRACER_MAX_TRACE=y
> CONFIG_TRACE_CLOCK=y
> CONFIG_RING_BUFFER=y
> CONFIG_EVENT_TRACING=y
> CONFIG_CONTEXT_SWITCH_TRACER=y
> CONFIG_RING_BUFFER_ALLOW_SWAP=y
> CONFIG_PREEMPTIRQ_TRACEPOINTS=y
> CONFIG_TRACING=y
> CONFIG_GENERIC_TRACER=y
> CONFIG_TRACING_SUPPORT=y
> CONFIG_FTRACE=y
> CONFIG_BOOTTIME_TRACING=y
> # CONFIG_FUNCTION_TRACER is not set
> # CONFIG_STACK_TRACER is not set
> CONFIG_IRQSOFF_TRACER=y
> # CONFIG_PREEMPT_TRACER is not set
> # CONFIG_SCHED_TRACER is not set
> CONFIG_HWLAT_TRACER=y
> # CONFIG_OSNOISE_TRACER is not set
> # CONFIG_TIMERLAT_TRACER is not set
> # CONFIG_MMIOTRACE is not set
> CONFIG_FTRACE_SYSCALLS=y
> CONFIG_TRACER_SNAPSHOT=y
> CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
> CONFIG_BRANCH_PROFILE_NONE=y
> # CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
> CONFIG_UPROBE_EVENTS=y
> CONFIG_DYNAMIC_EVENTS=y
> CONFIG_PROBE_EVENTS=y
> CONFIG_TRACING_MAP=y
> CONFIG_SYNTH_EVENTS=y
> CONFIG_HIST_TRIGGERS=y
> # CONFIG_TRACE_EVENT_INJECT is not set
> # CONFIG_TRACEPOINT_BENCHMARK is not set
> CONFIG_RING_BUFFER_BENCHMARK=y
> # CONFIG_TRACE_EVAL_MAP_FILE is not set
> CONFIG_GCOV_PROFILE_FTRACE=y
> # CONFIG_FTRACE_STARTUP_TEST is not set
> # CONFIG_RING_BUFFER_STARTUP_TEST is not set
> # CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
> # CONFIG_PREEMPTIRQ_DELAY_TEST is not set
> CONFIG_SYNTH_EVENT_GEN_TEST=y
> CONFIG_HIST_TRIGGERS_DEBUG=y
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
> # CONFIG_DEBUG_TLBFLUSH is not set
> CONFIG_HAVE_MMIOTRACE_SUPPORT=y
> # CONFIG_X86_DECODER_SELFTEST is not set
> # CONFIG_IO_DELAY_0X80 is not set
> CONFIG_IO_DELAY_0XED=y
> # CONFIG_IO_DELAY_UDELAY is not set
> # CONFIG_IO_DELAY_NONE is not set
> # CONFIG_DEBUG_BOOT_PARAMS is not set
> # CONFIG_CPA_DEBUG is not set
> CONFIG_DEBUG_ENTRY=y
> CONFIG_X86_DEBUG_FPU=y
> # CONFIG_PUNIT_ATOM_DEBUG is not set
> CONFIG_UNWINDER_FRAME_POINTER=y
> # end of x86 Debugging
> 
> #
> # Kernel Testing and Coverage
> #
> CONFIG_KUNIT=y
> CONFIG_KUNIT_DEBUGFS=y
> CONFIG_KUNIT_TEST=y
> CONFIG_KUNIT_EXAMPLE_TEST=y
> # CONFIG_KUNIT_ALL_TESTS is not set
> # CONFIG_NOTIFIER_ERROR_INJECTION is not set
> CONFIG_FAULT_INJECTION=y
> # CONFIG_FAILSLAB is not set
> CONFIG_FAIL_PAGE_ALLOC=y
> CONFIG_FAULT_INJECTION_USERCOPY=y
> CONFIG_FAIL_FUTEX=y
> CONFIG_FAULT_INJECTION_DEBUG_FS=y
> # CONFIG_FAULT_INJECTION_STACKTRACE_FILTER is not set
> CONFIG_CC_HAS_SANCOV_TRACE_PC=y
> CONFIG_RUNTIME_TESTING_MENU=y
> # CONFIG_LKDTM is not set
> # CONFIG_TEST_LIST_SORT is not set
> # CONFIG_TEST_MIN_HEAP is not set
> # CONFIG_TEST_SORT is not set
> # CONFIG_TEST_DIV64 is not set
> # CONFIG_BACKTRACE_SELF_TEST is not set
> # CONFIG_RBTREE_TEST is not set
> # CONFIG_REED_SOLOMON_TEST is not set
> # CONFIG_INTERVAL_TREE_TEST is not set
> # CONFIG_PERCPU_TEST is not set
> CONFIG_ATOMIC64_SELFTEST=y
> # CONFIG_TEST_HEXDUMP is not set
> CONFIG_STRING_SELFTEST=y
> # CONFIG_TEST_STRING_HELPERS is not set
> CONFIG_TEST_STRSCPY=y
> # CONFIG_TEST_KSTRTOX is not set
> CONFIG_TEST_PRINTF=y
> # CONFIG_TEST_SCANF is not set
> CONFIG_TEST_BITMAP=y
> # CONFIG_TEST_UUID is not set
> # CONFIG_TEST_XARRAY is not set
> # CONFIG_TEST_OVERFLOW is not set
> # CONFIG_TEST_RHASHTABLE is not set
> # CONFIG_TEST_HASH is not set
> # CONFIG_TEST_IDA is not set
> # CONFIG_TEST_LKM is not set
> # CONFIG_TEST_BITOPS is not set
> # CONFIG_TEST_VMALLOC is not set
> # CONFIG_TEST_USER_COPY is not set
> # CONFIG_TEST_BPF is not set
> # CONFIG_TEST_BLACKHOLE_DEV is not set
> # CONFIG_FIND_BIT_BENCHMARK is not set
> # CONFIG_TEST_FIRMWARE is not set
> # CONFIG_TEST_SYSCTL is not set
> # CONFIG_BITFIELD_KUNIT is not set
> # CONFIG_RESOURCE_KUNIT_TEST is not set
> CONFIG_SYSCTL_KUNIT_TEST=y
> CONFIG_LIST_KUNIT_TEST=y
> # CONFIG_LINEAR_RANGES_TEST is not set
> # CONFIG_CMDLINE_KUNIT_TEST is not set
> # CONFIG_BITS_TEST is not set
> # CONFIG_SLUB_KUNIT_TEST is not set
> # CONFIG_RATIONAL_KUNIT_TEST is not set
> # CONFIG_MEMCPY_KUNIT_TEST is not set
> # CONFIG_TEST_UDELAY is not set
> # CONFIG_TEST_STATIC_KEYS is not set
> # CONFIG_TEST_DEBUG_VIRTUAL is not set
> # CONFIG_TEST_MEMCAT_P is not set
> CONFIG_TEST_STACKINIT=y
> # CONFIG_TEST_MEMINIT is not set
> # CONFIG_TEST_FREE_PAGES is not set
> # CONFIG_TEST_FPU is not set
> # CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
> CONFIG_ARCH_USE_MEMTEST=y
> # CONFIG_MEMTEST is not set
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
> 	export queue_cmdline_keys=
> 	export queue='int'
> 	export testbox='vm-snb-i386-80'
> 	export tbox_group='vm-snb-i386'
> 	export branch='paulmck-rcu/dev.2021.11.30b'
> 	export commit='46faccd52724dc4f779da6c328b8d894846b8e30'
> 	export kconfig='i386-randconfig-a005-20211130'
> 	export nr_vm=160
> 	export submit_id='61a87e7f0b9a9379fdf20ef7'
> 	export job_file='/lkp/jobs/scheduled/vm-snb-i386-80/rcutorture-300s-default-srcu-debian-i386-20191205.cgz-46faccd52724dc4f779da6c328b8d894846b8e30-20211202-31229-1wvtapd-19.yaml'
> 	export id='3cf0584bb0944edc0e3b1e726f1d880eb30fedbb'
> 	export queuer_version='/lkp/xsang/.src-20211202-092226'
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
> 	export enqueue_time='2021-12-02 16:06:23 +0800'
> 	export _id='61a87e800b9a9379fdf20f0a'
> 	export _rt='/result/rcutorture/300s-default-srcu/vm-snb-i386/debian-i386-20191205.cgz/i386-randconfig-a005-20211130/gcc-9/46faccd52724dc4f779da6c328b8d894846b8e30'
> 	export user='lkp'
> 	export LKP_SERVER='internal-lkp-server'
> 	export result_root='/result/rcutorture/300s-default-srcu/vm-snb-i386/debian-i386-20191205.cgz/i386-randconfig-a005-20211130/gcc-9/46faccd52724dc4f779da6c328b8d894846b8e30/21'
> 	export scheduler_version='/lkp/lkp/.src-20211202-144518'
> 	export arch='i386'
> 	export max_uptime=2100
> 	export initrd='/osimage/debian/debian-i386-20191205.cgz'
> 	export bootloader_append='root=/dev/ram0
> user=lkp
> job=/lkp/jobs/scheduled/vm-snb-i386-80/rcutorture-300s-default-srcu-debian-i386-20191205.cgz-46faccd52724dc4f779da6c328b8d894846b8e30-20211202-31229-1wvtapd-19.yaml
> ARCH=i386
> kconfig=i386-randconfig-a005-20211130
> branch=paulmck-rcu/dev.2021.11.30b
> commit=46faccd52724dc4f779da6c328b8d894846b8e30
> BOOT_IMAGE=/pkg/linux/i386-randconfig-a005-20211130/gcc-9/46faccd52724dc4f779da6c328b8d894846b8e30/vmlinuz-5.16.0-rc1-00037-g46faccd52724
> vmalloc=128M initramfs_async=0 page_owner=on
> max_uptime=2100
> RESULT_ROOT=/result/rcutorture/300s-default-srcu/vm-snb-i386/debian-i386-20191205.cgz/i386-randconfig-a005-20211130/gcc-9/46faccd52724dc4f779da6c328b8d894846b8e30/21
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
> 	export modules_initrd='/pkg/linux/i386-randconfig-a005-20211130/gcc-9/46faccd52724dc4f779da6c328b8d894846b8e30/modules.cgz'
> 	export bm_initrd='/osimage/deps/debian-i386-20191205.cgz/lkp_20201203.cgz'
> 	export lkp_initrd='/osimage/user/lkp/lkp-i386.cgz'
> 	export site='inn'
> 	export LKP_CGI_PORT=80
> 	export LKP_CIFS_PORT=139
> 	export queue_at_least_once=1
> 	export schedule_notify_address=
> 	export kernel='/pkg/linux/i386-randconfig-a005-20211130/gcc-9/46faccd52724dc4f779da6c328b8d894846b8e30/vmlinuz-5.16.0-rc1-00037-g46faccd52724'
> 	export dequeue_time='2021-12-02 16:10:43 +0800'
> 	export job_initrd='/lkp/jobs/scheduled/vm-snb-i386-80/rcutorture-300s-default-srcu-debian-i386-20191205.cgz-46faccd52724dc4f779da6c328b8d894846b8e30-20211202-31229-1wvtapd-19.cgz'
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
> 	run_test test='default' torture_type='srcu' $LKP_SRC/tests/wrapper rcutorture
> }
> 
> extract_stats()
> {
> 	export stats_part_begin=
> 	export stats_part_end=
> 
> 	env test='default' torture_type='srcu' $LKP_SRC/stats/wrapper rcutorture
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


> 2021-12-02 08:12:08 modprobe rcutorture torture_type=srcu
> 2021-12-02 08:12:08 sleep 300
> 2021-12-02 08:17:14 rmmod rcutorture
> [   60.367261] srcu-torture:--- Start of test: nreaders=1 nfakewriters=4 stat_interval=60 verbose=1 test_no_idle_hz=1 shuffle_interval=3 stutter=5 irqreader=1 fqs_duration=0 fqs_holdoff=0 fqs_stutter=3 test_boost=1/0 test_boost_interval=7 test_boost_duration=4 shutdown_secs=0 stall_cpu=0 stall_cpu_holdoff=10 stall_cpu_irqsoff=0 stall_cpu_block=0 n_barrier_cbs=0 onoff_interval=0 onoff_holdoff=0 read_exit_delay=13 read_exit_burst=16 nocbs_nthreads=0 nocbs_toggle=1000
> [   60.383774] srcu-torture: Creating rcu_torture_writer task
> [   60.468221] srcu-torture: Creating rcu_torture_fakewriter task
> [   60.469768] srcu-torture: rcu_torture_writer task started
> [   60.471147] srcu-torture: Creating rcu_torture_fakewriter task
> [   60.478982] srcu-torture: rcu_torture_fakewriter task started
> [   60.495714] srcu-torture: Creating rcu_torture_fakewriter task
> [   60.502758] srcu-torture: rcu_torture_fakewriter task started
> [   60.504592] srcu-torture: Creating rcu_torture_fakewriter task
> [   60.506934] srcu-torture: rcu_torture_fakewriter task started
> [   60.527985] srcu-torture: Creating rcu_torture_reader task
> [   60.529515] srcu-torture: rcu_torture_fakewriter task started
> [   60.531123] srcu-torture: Creating rcu_torture_stats task
> [   60.539244] srcu-torture: rcu_torture_reader task started
> [   60.550794] srcu-torture: Creating torture_shuffle task
> [   60.558569] srcu-torture: rcu_torture_stats task started
> [   60.566582] srcu-torture: Creating torture_stutter task
> [   60.568686] srcu-torture: torture_shuffle task started
> [   60.579771] srcu-torture: rcu_torture_fwd_prog_init: Disabled, unsupported by RCU flavor under test
> [   60.581987] srcu-torture: Creating rcu_torture_read_exit task
> [   60.589092] srcu-torture: torture_stutter task started
> [   60.613680] srcu-torture: rcu_torture_read_exit: Start of test
> [   65.767790] srcu-torture: rcu_torture_read_exit: End of episode
> [   79.327652] srcu-torture: rcu_torture_read_exit: Start of episode
> [   79.519978] srcu-torture: rcu_torture_read_exit: End of episode
> [   93.023671] srcu-torture: rcu_torture_read_exit: Start of episode
> [   95.683706] srcu-torture: rcu_torture_read_exit: End of episode
> [  109.087657] srcu-torture: rcu_torture_read_exit: Start of episode
> [  109.102013] srcu-torture: rcu_torture_read_exit: End of episode
> [  122.496357] srcu-torture: rtc: f772b098 ver: 1380 tfle: 0 rta: 1380 rtaf: 0 rtf: 1371 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 417 barrier: 0/0:0 read-exits: 67 nocb-toggles: 0:0
> [  122.500914] srcu-torture: Reader Pipe:  802699 63 0 0 0 0 0 0 0 0 0
> [  122.502548] srcu-torture: Reader Batch:  802675 87 0 0 0 0 0 0 0 0 0
> [  122.504375] srcu-torture: Free-Block Circulation:  1379 1379 1378 1377 1376 1375 1374 1373 1372 1371 0
> [  122.506634] rcu: srcu-torture: Tree SRCU g14192 per-CPU(idx=0): 0(0,0 .) T(0,0)
> [  131.743719] srcu-torture: rcu_torture_read_exit: Start of episode
> [  132.655789] srcu-torture: rcu_torture_read_exit: End of episode
> [  165.215753] srcu-torture: rcu_torture_read_exit: Start of episode
> [  165.230279] srcu-torture: rcu_torture_read_exit: End of episode
> [  183.168944] srcu-torture: rtc: f772b124 ver: 2077 tfle: 0 rta: 2078 rtaf: 0 rtf: 2065 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 1461 barrier: 0/0:0 read-exits: 101 nocb-toggles: 0:0
> [  183.174751] srcu-torture: Reader Pipe:  3263363 136 0 0 0 0 0 0 0 0 0
> [  183.176434] srcu-torture: Reader Batch:  3263288 211 0 0 0 0 0 0 0 0 0
> [  183.178057] srcu-torture: Free-Block Circulation:  2077 2075 2073 2072 2071 2070 2069 2067 2066 2065 0
> [  183.180432] rcu: srcu-torture: Tree SRCU g21938 per-CPU(idx=1): 0(1,0 C) T(1,0)
> [  188.512143] srcu-torture: rcu_torture_read_exit: Start of episode
> [  188.521353] srcu-torture: rcu_torture_read_exit: End of episode
> [  212.287726] srcu-torture: rcu_torture_read_exit: Start of episode
> [  213.529734] srcu-torture: rcu_torture_read_exit: End of episode
> [  244.629913] srcu-torture: rtc: f772adc0 ver: 2844 tfle: 0 rta: 2845 rtaf: 0 rtf: 2835 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 2539 barrier: 0/0:0 read-exits: 135 nocb-toggles: 0:0
> [  244.634203] srcu-torture: Reader Pipe:  5685799 215 0 0 0 0 0 0 0 0 0
> [  244.636016] srcu-torture: Reader Batch:  5685663 351 0 0 0 0 0 0 0 0 0
> [  244.637531] srcu-torture: Free-Block Circulation:  2844 2843 2842 2841 2840 2839 2838 2837 2836 2835 0
> [  244.640166] rcu: srcu-torture: Tree SRCU g30377 per-CPU(idx=0): 0(0,0 C) T(0,0)
> [  245.856659] srcu-torture: rcu_torture_read_exit: Start of episode
> [  245.868563] srcu-torture: rcu_torture_read_exit: End of episode
> [  268.383641] srcu-torture: rcu_torture_read_exit: Start of episode
> [  269.067664] srcu-torture: rcu_torture_read_exit: End of episode
> [  291.455669] srcu-torture: rcu_torture_read_exit: Start of episode
> [  294.294172] srcu-torture: rcu_torture_read_exit: End of episode
> [  306.015965] srcu-torture: rtc: f772af9c ver: 3659 tfle: 0 rta: 3659 rtaf: 0 rtf: 3650 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 3587 barrier: 0/0:0 read-exits: 186 nocb-toggles: 0:0
> [  306.020675] srcu-torture: Reader Pipe:  8124133 287 0 0 0 0 0 0 0 0 0
> [  306.022334] srcu-torture: Reader Batch:  8123939 481 0 0 0 0 0 0 0 0 0
> [  306.024412] srcu-torture: Free-Block Circulation:  3658 3658 3657 3656 3655 3654 3653 3652 3651 3650 0
> [  306.026689] rcu: srcu-torture: Tree SRCU g38596 per-CPU(idx=1): 0(0,0 .) T(0,0)
> [  327.007751] srcu-torture: rcu_torture_read_exit: Start of episode
> [  327.020488] srcu-torture: rcu_torture_read_exit: End of episode
> [  350.303942] srcu-torture: rcu_torture_read_exit: Start of episode
> [  350.993501] srcu-torture: rcu_torture_read_exit: End of episode
> [  366.234332] srcu-torture: Stopping torture_shuffle task
> [  366.236255] srcu-torture: Stopping torture_shuffle
> [  366.237536] srcu-torture: Stopping torture_stutter task
> [  366.238784] srcu-torture: Stopping torture_stutter
> [  366.431888] srcu-torture: Stopping rcu_torture_fakewriter
> [  366.433171] srcu-torture: Stopping rcu_torture_writer
> [  366.434495] srcu-torture: Stopping rcu_torture_fakewriter
> [  366.436421] srcu-torture: Stopping rcu_torture_fakewriter
> [  366.437933] srcu-torture: Stopping rcu_torture_fakewriter
> [  366.439321] srcu-torture: Stopping rcu_torture_reader
> [  367.455705] srcu-torture: rtc: 00000000 VER: 4389 tfle: 0 rta: 4389 rtaf: 0 rtf: 4380 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 4508 barrier: 0/0:0 read-exits: 220 nocb-toggles: 0:0
> [  367.460333] srcu-torture: Reader Pipe:  10309685 350 0 0 0 0 0 0 0 0 0
> [  367.462039] srcu-torture: Reader Batch:  10309438 597 0 0 0 0 0 0 0 0 0
> [  367.464059] srcu-torture: Free-Block Circulation:  4388 4388 4387 4386 4385 4384 4383 4382 4381 4380 0
> [  367.466278] rcu: srcu-torture: Tree SRCU g46272 per-CPU(idx=0): 0(0,0 .) T(0,0)
> [  367.468355] srcu-torture: Stopping rcu_torture_stats
> [  367.470795] srcu-torture: Stopping rcu_torture_read_exit
> [  367.472456] srcu-torture: Stopping rcutorture_read_exit task
> [  367.497442] srcu-torture: Stopping rcu_torture_writer task
> [  367.498987] srcu-torture: Stopping rcu_torture_reader task
> [  367.505502] srcu-torture: Stopping rcu_torture_fakewriter task
> [  367.507076] srcu-torture: Stopping rcu_torture_fakewriter task
> [  367.513980] srcu-torture: Stopping rcu_torture_fakewriter task
> [  367.516052] srcu-torture: Stopping rcu_torture_fakewriter task
> [  367.519303] srcu-torture: Stopping rcu_torture_stats task
> [  367.760041] srcu-torture: rtc: 00000000 VER: 4389 tfle: 0 rta: 4389 rtaf: 0 rtf: 4380 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 4508 barrier: 0/0:0 read-exits: 220 nocb-toggles: 0:0
> [  367.764477] srcu-torture: Reader Pipe:  10309685 350 0 0 0 0 0 0 0 0 0
> [  367.766100] srcu-torture: Reader Batch:  10309438 597 0 0 0 0 0 0 0 0 0
> [  367.767990] srcu-torture: Free-Block Circulation:  4388 4388 4387 4386 4385 4384 4383 4382 4381 4380 0
> [  367.770279] rcu: srcu-torture: Tree SRCU g46272 per-CPU(idx=0): 0(0,0 .) T(0,0)
> [  367.772116] srcu-torture:--- End of test: SUCCESS: nreaders=1 nfakewriters=4 stat_interval=60 verbose=1 test_no_idle_hz=1 shuffle_interval=3 stutter=5 irqreader=1 fqs_duration=0 fqs_holdoff=0 fqs_stutter=3 test_boost=1/0 test_boost_interval=7 test_boost_duration=4 shutdown_secs=0 stall_cpu=0 stall_cpu_holdoff=10 stall_cpu_irqsoff=0 stall_cpu_block=0 n_barrier_cbs=0 onoff_interval=0 onoff_holdoff=0 read_exit_delay=13 read_exit_burst=16 nocbs_nthreads=0 nocbs_toggle=1000

