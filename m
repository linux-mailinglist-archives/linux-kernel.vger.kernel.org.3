Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B559F516B01
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 08:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358171AbiEBG5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 02:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238801AbiEBG51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 02:57:27 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD8B381B9
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 23:53:57 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:194e:5782:c420:7f87])
        by albert.telenet-ops.be with bizsmtp
        id Ritu2700P28fWK506ituFL; Mon, 02 May 2022 08:53:55 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nlPwQ-002l6W-Je
        for linux-kernel@vger.kernel.org; Mon, 02 May 2022 08:53:54 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nlPwP-00B9ju-Jo
        for linux-kernel@vger.kernel.org; Mon, 02 May 2022 08:53:53 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v5.18-rc5
Date:   Mon,  2 May 2022 08:53:53 +0200
Message-Id: <20220502065353.2658957-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAHk-=wjUhfhaes6_hMYDQFTbGjkmA-j2ZSeXZ32H66ufRfYrmQ@mail.gmail.com>
References: <CAHk-=wjUhfhaes6_hMYDQFTbGjkmA-j2ZSeXZ32H66ufRfYrmQ@mail.gmail.com>
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
v5.18-rc5[1] compared to v5.17[2].

Summarized:
  - build errors: +14/-6
  - build warnings: +37/-21

JFYI, when comparing v5.18-rc5[1] to v5.18-rc4[3], the summaries are:
  - build errors: +6/-21
  - build warnings: +18/-5

Note that there may be false regressions, as some logs are incomplete.
Still, they're build errors/warnings.

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/672c0c5173427e6b3e2a9bbb7be51ceeec78093a/ (all 138 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/f443e374ae131c168a065ea1748feac6b2e76613/ (96 out of 138 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/af2d861d4cd2a4da5137f795ee3509e6f944a25b/ (96 out of 138 configs)


*** ERRORS ***

14 error regressions:
  + /kisskb/src/arch/m68k/include/asm/bitops.h: error: array subscript 2 is above array bounds of 'long unsigned int[1]' [-Werror=array-bounds]:  => 329:20
  + /kisskb/src/arch/sh/kernel/machvec.c: error: array subscript 'struct sh_machine_vector[0]' is partly outside array bounds of 'long int[1]' [-Werror=array-bounds]:  => 105:33
  + /kisskb/src/arch/sparc/kernel/irq_32.c: error: array subscript [16, 79] is outside array bounds of 'struct tt_entry[1]' [-Werror=array-bounds]:  => 262:14, 263:14, 259:14, 261:46, 258:14
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

6 error improvements:
  - /kisskb/src/crypto/blake2b_generic.c: error: the frame size of 2288 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]: 109:1 => 
  - /kisskb/src/drivers/vfio/pci/vfio_pci_rdwr.c: error: assignment makes pointer from integer without a cast [-Werror=int-conversion]: 317:9, 324:9 => 
  - /kisskb/src/drivers/vfio/pci/vfio_pci_rdwr.c: error: implicit declaration of function 'ioport_map' [-Werror=implicit-function-declaration]: 317:11 => 
  - /kisskb/src/drivers/vfio/pci/vfio_pci_rdwr.c: error: implicit declaration of function 'ioport_unmap' [-Werror=implicit-function-declaration]: 338:15 => 
  - error: arch/powerpc/kvm/book3s_64_entry.o: relocation truncated to fit: R_PPC64_REL14 (stub) against symbol `machine_check_common' defined in .text section in arch/powerpc/kernel/head_64.o: (.text+0x3e4) => 
  - error: arch/powerpc/kvm/book3s_64_entry.o: relocation truncated to fit: R_PPC64_REL14 (stub) against symbol `system_reset_common' defined in .text section in arch/powerpc/kernel/head_64.o: (.text+0x3ec) => 


*** WARNINGS ***

37 warning regressions:
  + ./.config.32r1_defconfig: warning: override: CPU_BIG_ENDIAN changes choice state:  => 94
  + ./.config.32r2_defconfig: warning: override: CPU_BIG_ENDIAN changes choice state:  => 94
  + ./.config.32r6_defconfig: warning: override: CPU_BIG_ENDIAN changes choice state:  => 96
  + ./.config.64r1_defconfig: warning: override: CPU_BIG_ENDIAN changes choice state:  => 97
  + ./.config.64r2_defconfig: warning: override: CPU_BIG_ENDIAN changes choice state:  => 97
  + ./.config.64r6_defconfig: warning: override: CPU_BIG_ENDIAN changes choice state:  => 99
  + ./.config.micro32r2_defconfig: warning: override: CPU_BIG_ENDIAN changes choice state:  => 95
  + .config: warning: override: CPU_BIG_ENDIAN changes choice state:  => 95, 96, 93, 98, 94
  + .config: warning: override: reassigning to symbol MIPS_CPS_NS16550_SHIFT: 13516, 13503 => 13758, 13769, 13763
  + /kisskb/src/arch/m68k/include/asm/string.h: warning: '__builtin_memset' offset [0, 11] is out of the bounds [0, 0] [-Warray-bounds]:  => 68:25
  + /kisskb/src/arch/sh/kernel/cpu/sh2/../../entry-common.S: Warning: overflow in branch to __restore_all; converted into longer instruction sequence:  => 85
  + /kisskb/src/arch/sh/kernel/cpu/sh2/../../entry-common.S: Warning: overflow in branch to syscall_exit_work; converted into longer instruction sequence:  => 360, 357
  + /kisskb/src/arch/sh/kernel/machvec.c: warning: array subscript 'struct sh_machine_vector[0]' is partly outside array bounds of 'long int[1]' [-Warray-bounds]:  => 105:33
  + /kisskb/src/drivers/net/ethernet/i825xx/sun3_82586.c: warning: array subscript 1 is above array bounds of 'volatile struct transmit_cmd_struct *[1]' [-Warray-bounds]:  => 989:108, 989:122
  + /kisskb/src/drivers/scsi/mpt3sas/mpt3sas_base.c: warning: array subscript 'Mpi2SasIOUnitPage1_t {aka struct _MPI2_CONFIG_PAGE_SASIOUNIT_1}[0]' is partly outside array bounds of 'unsigned char[20]' [-Warray-bounds]:  => 5403:43, 5396:40, 5400:40
  + /kisskb/src/drivers/tty/serial/sh-sci.c: warning: unused variable 'sport' [-Wunused-variable]: 2651:19 => 2651:19, 2651:26
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
  - /opt/cross/kisskb/br-aarch64-glibc-2016.08-613-ge98b4dd/bin/../lib/gcc/aarch64-buildroot-linux-gnu/5.4.0/plugin/include/config/elfos.h: warning: invalid suffix on literal; C++11 requires a space between literal and string macro [-Wliteral-suffix]: 102:21, 170:24 => 
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
