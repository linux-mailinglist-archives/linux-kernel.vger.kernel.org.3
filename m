Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E257D51F779
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237244AbiEII6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 04:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237051AbiEIIoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 04:44:03 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C4F1A5386
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 01:40:08 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:7048:8ec9:5f5b:8cb])
        by michel.telenet-ops.be with bizsmtp
        id UYg62700D1UlgJi06Yg60U; Mon, 09 May 2022 10:40:06 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nnyw2-003Vxt-2J
        for linux-kernel@vger.kernel.org; Mon, 09 May 2022 10:40:06 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nnyw1-00HLRE-FB
        for linux-kernel@vger.kernel.org; Mon, 09 May 2022 10:40:05 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v5.18-rc6
Date:   Mon,  9 May 2022 10:40:05 +0200
Message-Id: <20220509084005.4133902-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAHk-=wi0vqZQUAS67tBsJQW+dtt89m+dqA-Z4bOs8CH-mm8u2w@mail.gmail.com>
References: <CAHk-=wi0vqZQUAS67tBsJQW+dtt89m+dqA-Z4bOs8CH-mm8u2w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v5.18-rc6[1] compared to v5.17[2].

Summarized:
  - build errors: +14/-5
  - build warnings: +36/-21

JFYI, when comparing v5.18-rc6[1] to v5.18-rc5[3], the summaries are:
  - build errors: +1/-0
  - build warnings: +0/-1

Note that there may be false regressions, as some logs are incomplete.
Still, they're build errors/warnings.

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/c5eb0a61238dd6faf37f58c9ce61c9980aaffd7a/ (131 out of 138 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/f443e374ae131c168a065ea1748feac6b2e76613/ (96 out of 138 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/672c0c5173427e6b3e2a9bbb7be51ceeec78093a/ (all 138 configs)


*** ERRORS ***

14 error regressions:
  + /kisskb/src/arch/m68k/include/asm/bitops.h: error: array subscript 2 is above array bounds of 'long unsigned int[1]' [-Werror=array-bounds]:  => 329:20
  + /kisskb/src/arch/sh/kernel/machvec.c: error: array subscript 'struct sh_machine_vector[0]' is partly outside array bounds of 'long int[1]' [-Werror=array-bounds]:  => 105:33
  + /kisskb/src/arch/sparc/kernel/irq_32.c: error: array subscript [16, 79] is outside array bounds of 'struct tt_entry[1]' [-Werror=array-bounds]:  => 261:46, 262:14, 259:14, 258:14, 263:14
  + /kisskb/src/drivers/gpu/drm/r128/r128_cce.c: error: case label does not reduce to an integer constant:  => 417:2, 418:2
  + /kisskb/src/drivers/infiniband/hw/qib/qib_wc_x86_64.c: error: 'X86_VENDOR_AMD' undeclared (first use in this function):  => 149:37
  + /kisskb/src/drivers/infiniband/hw/qib/qib_wc_x86_64.c: error: 'struct cpuinfo_um' has no member named 'x86_vendor':  => 149:22
  + /kisskb/src/drivers/infiniband/hw/qib/qib_wc_x86_64.c: error: control reaches end of non-void function [-Werror=return-type]:  => 150:1
  + /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: 'struct cpuinfo_um' has no member named 'x86_cache_size':  => 88:22
  + /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: control reaches end of non-void function [-Werror=return-type]:  => 89:1
  + /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: implicit declaration of function '__copy_user_nocache' [-Werror=implicit-function-declaration]:  => 100:2
  + /kisskb/src/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c: error: case label does not reduce to an integer constant:  => 4917:4
  + /kisskb/src/drivers/scsi/aacraid/commsup.c: error: case label does not reduce to an integer constant:  => 1983:2
  + /kisskb/src/include/linux/sh_intc.h: error: division 'sizeof (void *) / sizeof (void)' does not compute the number of array elements [-Werror=sizeof-pointer-div]:  => 100:63
  + {standard input}: Error: branch to a symbol in another ISA mode:  => 1295

5 error improvements:
  - /kisskb/src/drivers/vfio/pci/vfio_pci_rdwr.c: error: assignment makes pointer from integer without a cast [-Werror=int-conversion]: 324:9, 317:9 => 
  - /kisskb/src/drivers/vfio/pci/vfio_pci_rdwr.c: error: implicit declaration of function 'ioport_map' [-Werror=implicit-function-declaration]: 317:11 => 
  - /kisskb/src/drivers/vfio/pci/vfio_pci_rdwr.c: error: implicit declaration of function 'ioport_unmap' [-Werror=implicit-function-declaration]: 338:15 => 
  - error: arch/powerpc/kvm/book3s_64_entry.o: relocation truncated to fit: R_PPC64_REL14 (stub) against symbol `machine_check_common' defined in .text section in arch/powerpc/kernel/head_64.o: (.text+0x3e4) => 
  - error: arch/powerpc/kvm/book3s_64_entry.o: relocation truncated to fit: R_PPC64_REL14 (stub) against symbol `system_reset_common' defined in .text section in arch/powerpc/kernel/head_64.o: (.text+0x3ec) => 


*** WARNINGS ***

36 warning regressions:
  + ./.config.32r1_defconfig: warning: override: CPU_BIG_ENDIAN changes choice state:  => 94
  + ./.config.32r2_defconfig: warning: override: CPU_BIG_ENDIAN changes choice state:  => 94
  + ./.config.32r6_defconfig: warning: override: CPU_BIG_ENDIAN changes choice state:  => 96
  + ./.config.64r1_defconfig: warning: override: CPU_BIG_ENDIAN changes choice state:  => 97
  + ./.config.64r2_defconfig: warning: override: CPU_BIG_ENDIAN changes choice state:  => 97
  + ./.config.64r6_defconfig: warning: override: CPU_BIG_ENDIAN changes choice state:  => 99
  + ./.config.micro32r2_defconfig: warning: override: CPU_BIG_ENDIAN changes choice state:  => 95
  + .config: warning: override: CPU_BIG_ENDIAN changes choice state:  => 93, 98, 96, 95, 94
  + .config: warning: override: reassigning to symbol MIPS_CPS_NS16550_SHIFT: 13516, 13503 => 13758, 13763, 13769
  + /kisskb/src/arch/m68k/include/asm/string.h: warning: '__builtin_memset' offset [0, 11] is out of the bounds [0, 0] [-Warray-bounds]:  => 68:25
  + /kisskb/src/arch/sh/kernel/cpu/sh2/../../entry-common.S: Warning: overflow in branch to __restore_all; converted into longer instruction sequence:  => 85
  + /kisskb/src/arch/sh/kernel/cpu/sh2/../../entry-common.S: Warning: overflow in branch to syscall_exit_work; converted into longer instruction sequence:  => 360, 357
  + /kisskb/src/arch/sh/kernel/machvec.c: warning: array subscript 'struct sh_machine_vector[0]' is partly outside array bounds of 'long int[1]' [-Warray-bounds]:  => 105:33
  + /kisskb/src/drivers/net/ethernet/i825xx/sun3_82586.c: warning: array subscript 1 is above array bounds of 'volatile struct transmit_cmd_struct *[1]' [-Warray-bounds]:  => 989:122, 989:108
  + /kisskb/src/drivers/scsi/mpt3sas/mpt3sas_base.c: warning: array subscript 'Mpi2SasIOUnitPage1_t {aka struct _MPI2_CONFIG_PAGE_SASIOUNIT_1}[0]' is partly outside array bounds of 'unsigned char[20]' [-Warray-bounds]:  => 5396:40, 5400:40, 5403:43
  + /kisskb/src/fs/ext4/readpage.c: warning: the frame size of 1136 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 407:1
  + /kisskb/src/fs/mpage.c: warning: the frame size of 1088 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 303:1
  + /kisskb/src/fs/mpage.c: warning: the frame size of 1148 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 636:1
  + /opt/cross/kisskb/korg/gcc-5.5.0-nolibc/aarch64-linux/bin/../lib/gcc/aarch64-linux/5.5.0/plugin/include/config/elfos.h: warning: invalid suffix on literal; C++11 requires a space between literal and string macro [-Wliteral-suffix]:  => 102:21, 170:24
  + /opt/cross/kisskb/korg/gcc-5.5.0-nolibc/aarch64-linux/bin/../lib/gcc/aarch64-linux/5.5.0/plugin/include/defaults.h: warning: invalid suffix on literal; C++11 requires a space between literal and string macro [-Wliteral-suffix]:  => 126:24
  + modpost: WARNING: modpost: EXPORT symbol "___rw_read_enter" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "___rw_read_exit" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "___rw_read_try" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "___rw_write_enter" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__ashldi3" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__ashrdi3" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__copy_1page" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__divdi3" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__lshrdi3" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__muldi3" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__ndelay" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__udelay" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "bzero_1page" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "empty_zero_page" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x45d4): Section mismatch in reference from the function __trace_event_discard_commit() to the variable .init.data:initcall_level_names:  => N/A

21 warning improvements:
  - /kisskb/src/samples/seccomp/user-trap.c: warning: dereferencing type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]: 83:2, 50:2 => 
  - /opt/cross/kisskb/br-aarch64-glibc-2016.08-613-ge98b4dd/bin/../lib/gcc/aarch64-buildroot-linux-gnu/5.4.0/plugin/include/config/elfos.h: warning: invalid suffix on literal; C++11 requires a space between literal and string macro [-Wliteral-suffix]: 170:24, 102:21 => 
  - /opt/cross/kisskb/br-aarch64-glibc-2016.08-613-ge98b4dd/bin/../lib/gcc/aarch64-buildroot-linux-gnu/5.4.0/plugin/include/defaults.h: warning: invalid suffix on literal; C++11 requires a space between literal and string macro [-Wliteral-suffix]: 126:24 => 
  - modpost: WARNING: modpost: EXPORT symbol "___rw_read_enter" [vmlinux] version ...: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "___rw_read_exit" [vmlinux] version ...: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "___rw_read_try" [vmlinux] version ...: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "___rw_write_enter" [vmlinux] version ...: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "__ashldi3" [vmlinux] version ...: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "__ashrdi3" [vmlinux] version ...: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "__copy_1page" [vmlinux] version ...: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "__divdi3" [vmlinux] version ...: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "__lshrdi3" [vmlinux] version ...: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "__muldi3" [vmlinux] version ...: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "__ndelay" [vmlinux] version ...: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "__udelay" [vmlinux] version ...: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version ...: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "bzero_1page" [vmlinux] version ...: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "empty_zero_page" [vmlinux] version ...: N/A => 
  - modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x4530): Section mismatch in reference from the function __trace_event_discard_commit() to the variable .init.data:initcall_level_names: N/A => 
  - warning: LSE atomics not supported by binutils: N/A => 
  - warning: ld does not support --fix-cortex-a53-843419; kernel may be susceptible to erratum: N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
