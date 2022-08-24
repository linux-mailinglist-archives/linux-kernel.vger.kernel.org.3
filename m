Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B245E5A014A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 20:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240495AbiHXSXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 14:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236263AbiHXSXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 14:23:43 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A183874BBF;
        Wed, 24 Aug 2022 11:23:41 -0700 (PDT)
Received: from zn.tnic (p200300ea971b9859329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:9859:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 80B591EC0532;
        Wed, 24 Aug 2022 20:23:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1661365415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3M2iHzeydaSKbxeD+QXdjYzGlimzK3uw0BB9BUIRK+0=;
        b=ARSzkw5efkJpCAYXCrC/4jXB5FpD45wtUg4jx0fF16fdROM4rClMpoghfvXasZV3pWHDk4
        pja0yVXo+b2WdmnAJs+zBxMxLrWRR/CH7qOfRQeMxUNUz4SfC4z0dqNvKjYKPuZtmLffM1
        Zf3xBOIiBItN1ZeQeTqgg1WtnPI7aao=
Date:   Wed, 24 Aug 2022 20:23:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     X86 ML <x86@kernel.org>, Michael Matz <matz@suse.de>,
        linux-toolchains@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/sev: Mark snp_abort() noreturn
Message-ID: <YwZsolNWU129oRac@zn.tnic>
References: <20220824152420.20547-1-bp@alien8.de>
 <20220824172929.GA25951@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220824172929.GA25951@gate.crashing.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 12:29:29PM -0500, Segher Boessenkool wrote:
> Would -Wmissing-noreturn have caught this? 

Yes, see below. Current linus master allmodconfig with

gcc-12 (SUSE Linux) 12.1.1 20220517 [revision 325d82b08696da17fb26bd2e1b6ba607649357fb]

> It sounds like you need this (and then fix all resulting warnings) to
> not upset objtool?

Yep.

> It is nice to have this anyway (if there aren't a zillion false
> positives), but it seems objtool is very fragile.

Constant improvement, I'd guess.

So, I'd say someone needs to sit down and fix those and then as last
fix, enable the warning by default.

All those use cases would need proper analysis tho.

Thx.

arch/x86/coco/tdx/tdx.c: In function ‘__tdx_hypercall_failed’:
arch/x86/coco/tdx/tdx.c:56:6: warning: function might be candidate for attribute ‘noreturn’ [-Wsuggest-attribute=noreturn]
   56 | void __tdx_hypercall_failed(void)
      |      ^~~~~~~~~~~~~~~~~~~~~~
arch/x86/hyperv/ivm.c: In function ‘hv_ghcb_terminate’:
arch/x86/hyperv/ivm.c:130:6: warning: function might be candidate for attribute ‘noreturn’ [-Wsuggest-attribute=noreturn]
  130 | void hv_ghcb_terminate(unsigned int set, unsigned int reason)
      |      ^~~~~~~~~~~~~~~~~
arch/x86/platform/pvh/enlighten.c: In function ‘xen_pvh_init’:
arch/x86/platform/pvh/enlighten.c:104:20: warning: function might be candidate for attribute ‘noreturn’ [-Wsuggest-attribute=noreturn]
  104 | void __init __weak xen_pvh_init(struct boot_params *boot_params)
      |                    ^~~~~~~~~~~~
arch/x86/platform/pvh/enlighten.c: In function ‘mem_map_via_hcall’:
arch/x86/platform/pvh/enlighten.c:39:20: warning: function might be candidate for attribute ‘noreturn’ [-Wsuggest-attribute=noreturn]
   39 | void __init __weak mem_map_via_hcall(struct boot_params *ptr __maybe_unused)
      |                    ^~~~~~~~~~~~~~~~~
arch/x86/xen/smp_pv.c: In function ‘cpu_bringup_and_idle’:
arch/x86/xen/smp_pv.c:92:27: warning: function might be candidate for attribute ‘noreturn’ [-Wsuggest-attribute=noreturn]
   92 | asmlinkage __visible void cpu_bringup_and_idle(void)
      |                           ^~~~~~~~~~~~~~~~~~~~
init/main.c: In function ‘rest_init’:
init/main.c:681:21: warning: function might be candidate for attribute ‘noreturn’ [-Wsuggest-attribute=noreturn]
  681 | noinline void __ref rest_init(void)
      |                     ^~~~~~~~~
In file included from ./arch/x86/include/asm/traps.h:9,
                 from arch/x86/xen/enlighten_pv.c:61:
arch/x86/xen/enlighten_pv.c: In function ‘exc_xen_unknown_trap’:
arch/x86/xen/enlighten_pv.c:566:21: warning: function might be candidate for attribute ‘noreturn’ [-Wsuggest-attribute=noreturn]
  566 | DEFINE_IDTENTRY_RAW(exc_xen_unknown_trap)
      |                     ^~~~~~~~~~~~~~~~~~~~
./arch/x86/include/asm/idtentry.h:138:24: note: in definition of macro ‘DEFINE_IDTENTRY_RAW’
  138 | __visible noinstr void func(struct pt_regs *regs)
      |                        ^~~~
init/main.c: In function ‘arch_call_rest_init’:
init/main.c:881:20: warning: function might be candidate for attribute ‘noreturn’ [-Wsuggest-attribute=noreturn]
  881 | void __init __weak arch_call_rest_init(void)
      |                    ^~~~~~~~~~~~~~~~~~~
arch/x86/kernel/smpboot.c: In function ‘hlt_play_dead’:
arch/x86/kernel/smpboot.c:1815:6: warning: function might be candidate for attribute ‘noreturn’ [-Wsuggest-attribute=noreturn]
 1815 | void hlt_play_dead(void)
      |      ^~~~~~~~~~~~~
kernel/panic.c: In function ‘__stack_chk_fail’:
kernel/panic.c:703:24: warning: function might be candidate for attribute ‘noreturn’ [-Wsuggest-attribute=noreturn]
  703 | __visible noinstr void __stack_chk_fail(void)
      |                        ^~~~~~~~~~~~~~~~
kernel/panic.c: In function ‘panic_smp_self_stop’:
kernel/panic.c:112:13: warning: function might be candidate for attribute ‘noreturn’ [-Wsuggest-attribute=noreturn]
  112 | void __weak panic_smp_self_stop(void)
      |             ^~~~~~~~~~~~~~~~~~~
arch/x86/kernel/reboot.c: In function ‘nmi_panic_self_stop’:
arch/x86/kernel/reboot.c:885:6: warning: function might be candidate for attribute ‘noreturn’ [-Wsuggest-attribute=noreturn]
  885 | void nmi_panic_self_stop(struct pt_regs *regs)
      |      ^~~~~~~~~~~~~~~~~~~
In file included from ./include/linux/compat.h:34,
                 from ./arch/x86/include/asm/ftrace.h:111,
                 from ./include/linux/ftrace.h:23,
                 from ./include/linux/perf_event.h:51,
                 from ./include/linux/trace_events.h:10,
                 from ./include/trace/syscall.h:7,
                 from ./include/linux/syscalls.h:88,
                 from kernel/exit.c:42:
kernel/exit.c: In function ‘__x64_sys_exit’:
./arch/x86/include/asm/syscall_wrapper.h:77:14: warning: function might be candidate for attribute ‘noreturn’ [-Wsuggest-attribute=noreturn]
   77 |         long __##abi##_##name(const struct pt_regs *regs)               \
      |              ^~
./arch/x86/include/asm/syscall_wrapper.h:97:9: note: in expansion of macro ‘__SYS_STUBx’
   97 |         __SYS_STUBx(x64, sys##name,                                     \
      |         ^~~~~~~~~~~
./arch/x86/include/asm/syscall_wrapper.h:231:9: note: in expansion of macro ‘__X64_SYS_STUBx’
  231 |         __X64_SYS_STUBx(x, name, __VA_ARGS__)                           \
      |         ^~~~~~~~~~~~~~~
./include/linux/syscalls.h:228:9: note: in expansion of macro ‘__SYSCALL_DEFINEx’
  228 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
      |         ^~~~~~~~~~~~~~~~~
./include/linux/syscalls.h:217:36: note: in expansion of macro ‘SYSCALL_DEFINEx’
  217 | #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
      |                                    ^~~~~~~~~~~~~~~
kernel/exit.c:890:1: note: in expansion of macro ‘SYSCALL_DEFINE1’
  890 | SYSCALL_DEFINE1(exit, int, error_code)
      | ^~~~~~~~~~~~~~~
kernel/exit.c: In function ‘__ia32_sys_exit’:
./arch/x86/include/asm/syscall_wrapper.h:77:14: warning: function might be candidate for attribute ‘noreturn’ [-Wsuggest-attribute=noreturn]
   77 |         long __##abi##_##name(const struct pt_regs *regs)               \
      |              ^~
./arch/x86/include/asm/syscall_wrapper.h:117:9: note: in expansion of macro ‘__SYS_STUBx’
  117 |         __SYS_STUBx(ia32, sys##name,                                    \
      |         ^~~~~~~~~~~
./arch/x86/include/asm/syscall_wrapper.h:232:9: note: in expansion of macro ‘__IA32_SYS_STUBx’
  232 |         __IA32_SYS_STUBx(x, name, __VA_ARGS__)                          \
      |         ^~~~~~~~~~~~~~~~
./include/linux/syscalls.h:228:9: note: in expansion of macro ‘__SYSCALL_DEFINEx’
  228 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
      |         ^~~~~~~~~~~~~~~~~
./include/linux/syscalls.h:217:36: note: in expansion of macro ‘SYSCALL_DEFINEx’
  217 | #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
      |                                    ^~~~~~~~~~~~~~~
kernel/exit.c:890:1: note: in expansion of macro ‘SYSCALL_DEFINE1’
  890 | SYSCALL_DEFINE1(exit, int, error_code)
      | ^~~~~~~~~~~~~~~
kernel/exit.c: In function ‘__x64_sys_exit_group’:
./arch/x86/include/asm/syscall_wrapper.h:77:14: warning: function might be candidate for attribute ‘noreturn’ [-Wsuggest-attribute=noreturn]
   77 |         long __##abi##_##name(const struct pt_regs *regs)               \
      |              ^~
./arch/x86/include/asm/syscall_wrapper.h:97:9: note: in expansion of macro ‘__SYS_STUBx’
   97 |         __SYS_STUBx(x64, sys##name,                                     \
      |         ^~~~~~~~~~~
./arch/x86/include/asm/syscall_wrapper.h:231:9: note: in expansion of macro ‘__X64_SYS_STUBx’
  231 |         __X64_SYS_STUBx(x, name, __VA_ARGS__)                           \
      |         ^~~~~~~~~~~~~~~
./include/linux/syscalls.h:228:9: note: in expansion of macro ‘__SYSCALL_DEFINEx’
  228 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
      |         ^~~~~~~~~~~~~~~~~
./include/linux/syscalls.h:217:36: note: in expansion of macro ‘SYSCALL_DEFINEx’
  217 | #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
      |                                    ^~~~~~~~~~~~~~~
kernel/exit.c:934:1: note: in expansion of macro ‘SYSCALL_DEFINE1’
  934 | SYSCALL_DEFINE1(exit_group, int, error_code)
      | ^~~~~~~~~~~~~~~
kernel/exit.c: In function ‘__ia32_sys_exit_group’:
./arch/x86/include/asm/syscall_wrapper.h:77:14: warning: function might be candidate for attribute ‘noreturn’ [-Wsuggest-attribute=noreturn]
   77 |         long __##abi##_##name(const struct pt_regs *regs)               \
      |              ^~
./arch/x86/include/asm/syscall_wrapper.h:117:9: note: in expansion of macro ‘__SYS_STUBx’
  117 |         __SYS_STUBx(ia32, sys##name,                                    \
      |         ^~~~~~~~~~~
./arch/x86/include/asm/syscall_wrapper.h:232:9: note: in expansion of macro ‘__IA32_SYS_STUBx’
  232 |         __IA32_SYS_STUBx(x, name, __VA_ARGS__)                          \
      |         ^~~~~~~~~~~~~~~~
./include/linux/syscalls.h:228:9: note: in expansion of macro ‘__SYSCALL_DEFINEx’
  228 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
      |         ^~~~~~~~~~~~~~~~~
./include/linux/syscalls.h:217:36: note: in expansion of macro ‘SYSCALL_DEFINEx’
  217 | #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
      |                                    ^~~~~~~~~~~~~~~
kernel/exit.c:934:1: note: in expansion of macro ‘SYSCALL_DEFINE1’
  934 | SYSCALL_DEFINE1(exit_group, int, error_code)
      | ^~~~~~~~~~~~~~~
arch/x86/kernel/paravirt.c: In function ‘paravirt_BUG’:
arch/x86/kernel/paravirt.c:69:14: warning: function might be candidate for attribute ‘noreturn’ [-Wsuggest-attribute=noreturn]
   69 | noinstr void paravirt_BUG(void)
      |              ^~~~~~~~~~~~
arch/x86/kernel/devicetree.c: In function ‘early_init_dt_add_memory_arch’:
arch/x86/kernel/devicetree.c:34:13: warning: function might be candidate for attribute ‘noreturn’ [-Wsuggest-attribute=noreturn]
   34 | void __init early_init_dt_add_memory_arch(u64 base, u64 size)
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/x86/kernel/sev.c: In function ‘snp_abort’:
arch/x86/kernel/sev.c:2103:13: warning: function might be candidate for attribute ‘noreturn’ [-Wsuggest-attribute=noreturn]
 2103 | void __init snp_abort(void)
      |             ^~~~~~~~~
kernel/kthread.c: In function ‘kthreadd’:
kernel/kthread.c:717:5: warning: function might be candidate for attribute ‘noreturn’ [-Wsuggest-attribute=noreturn]
  717 | int kthreadd(void *unused)
      |     ^~~~~~~~
net/ipv4/ping.c: In function ‘ping_hash’:
net/ipv4/ping.c:144:5: warning: function might be candidate for attribute ‘noreturn’ [-Wsuggest-attribute=noreturn]
  144 | int ping_hash(struct sock *sk)
      |     ^~~~~~~~~
crypto/jitterentropy-kcapi.c: In function ‘jent_panic’:
crypto/jitterentropy-kcapi.c:62:6: warning: function might be candidate for attribute ‘noreturn’ [-Wsuggest-attribute=noreturn]
   62 | void jent_panic(char *s)
      |      ^~~~~~~~~~
drivers/message/fusion/mptbase.c: In function ‘mpt_halt_firmware’:
drivers/message/fusion/mptbase.c:6939:1: warning: function might be candidate for attribute ‘noreturn’ [-Wsuggest-attribute=noreturn]
 6939 | mpt_halt_firmware(MPT_ADAPTER *ioc)
      | ^~~~~~~~~~~~~~~~~
drivers/net/wireless/rsi/rsi_91x_sdio_ops.c: In function ‘rsi_sdio_rx_thread’:
drivers/net/wireless/rsi/rsi_91x_sdio_ops.c:65:6: warning: function might be candidate for attribute ‘noreturn’ [-Wsuggest-attribute=noreturn]
   65 | void rsi_sdio_rx_thread(struct rsi_common *common)
      |      ^~~~~~~~~~~~~~~~~~
drivers/net/wireless/rsi/rsi_91x_usb_ops.c: In function ‘rsi_usb_rx_thread’:
drivers/net/wireless/rsi/rsi_91x_usb_ops.c:28:6: warning: function might be candidate for attribute ‘noreturn’ [-Wsuggest-attribute=noreturn]
   28 | void rsi_usb_rx_thread(struct rsi_common *common)
      |      ^~~~~~~~~~~~~~~~~
drivers/clocksource/timer-ti-dm.c: In function ‘omap_dm_timer_modify_idlect_mask’:
drivers/clocksource/timer-ti-dm.c:600:7: warning: function might be candidate for attribute ‘noreturn’ [-Wsuggest-attribute=noreturn]
  600 | __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
      |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/staging/media/atomisp/pci/ia_css_device_access.c: In function ‘ia_css_device_load_uint64’:
drivers/staging/media/atomisp/pci/ia_css_device_access.c:51:1: warning: function might be candidate for attribute ‘noreturn’ [-Wsuggest-attribute=noreturn]
   51 | ia_css_device_load_uint64(const hrt_address addr)
      | ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/staging/media/atomisp/pci/ia_css_device_access.c: In function ‘ia_css_device_store_uint64’:
drivers/staging/media/atomisp/pci/ia_css_device_access.c:78:1: warning: function might be candidate for attribute ‘noreturn’ [-Wsuggest-attribute=noreturn]
   78 | ia_css_device_store_uint64(const hrt_address addr, const uint64_t data)
      | ^~~~~~~~~~~~~~~~~~~~~~~~~~
lib/ubsan.c: In function ‘__ubsan_handle_builtin_unreachable’:
lib/ubsan.c:329:6: warning: function might be candidate for attribute ‘noreturn’ [-Wsuggest-attribute=noreturn]
  329 | void __ubsan_handle_builtin_unreachable(void *_data)
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c: In function ‘otx2_sqe_flush’:
drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c:554:6: warning: function might be candidate for attribute ‘noreturn’ [-Wsuggest-attribute=noreturn]
  554 | void otx2_sqe_flush(void *dev, struct otx2_snd_queue *sq,
      |      ^~~~~~~~~~~~~~
drivers/gpu/drm/radeon/r100.c: In function ‘r100_semaphore_ring_emit’:
drivers/gpu/drm/radeon/r100.c:890:6: warning: function might be candidate for attribute ‘noreturn’ [-Wsuggest-attribute=noreturn]
  890 | bool r100_semaphore_ring_emit(struct radeon_device *rdev,
      |      ^~~~~~~~~~~~~~~~~~~~~~~~


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
