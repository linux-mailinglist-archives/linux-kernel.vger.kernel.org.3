Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3E14691C6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 09:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239746AbhLFIxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 03:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239729AbhLFIxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 03:53:50 -0500
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DEBC061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 00:50:21 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:bdf8:dd2e:c345:9a09])
        by xavier.telenet-ops.be with bizsmtp
        id SwqJ2600S0eFvHC01wqJzs; Mon, 06 Dec 2021 09:50:18 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mu9hS-003Cxs-8X
        for linux-kernel@vger.kernel.org; Mon, 06 Dec 2021 09:50:18 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mu9hR-009MLP-Ob
        for linux-kernel@vger.kernel.org; Mon, 06 Dec 2021 09:50:17 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v5.16-rc4
Date:   Mon,  6 Dec 2021 09:50:17 +0100
Message-Id: <20211206085017.2230734-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v5.16-rc4[1] compared to v5.15[2].

Summarized:
  - build errors: +10/-13
  - build warnings: +16/-29

JFYI, when comparing v5.16-rc4[1] to v5.16-rc3[3], the summaries are:
  - build errors: +0/-0
  - build warnings: +0/-0

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1/ (all 90 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/8bb7eca972ad531c9b149c0a51ab43a417385813/ (all 90 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/d58071a8a76d779eedab38033ae4c821c30295a5/ (all 90 configs)


*** ERRORS ***

10 error regressions:
  + /kisskb/src/drivers/mtd/nand/raw/mpc5121_nfc.c: error: unused variable 'mtd' [-Werror=unused-variable]:  => 294:19
  + error: arch/sparc/kernel/head_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.init.text':  => (.head.text+0x5040), (.head.text+0x5100)
  + error: arch/sparc/kernel/head_32.o: relocation truncated to fit: R_SPARC_WDISP22 against symbol `leon_smp_cpu_startup' defined in .text section in arch/sparc/kernel/trampoline_32.o:  => (.init.text+0xa4)
  + error: arch/sparc/kernel/process_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text':  => (.fixup+0xc), (.fixup+0x4)
  + error: arch/sparc/kernel/signal_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text':  => (.fixup+0x34), (.fixup+0x28), (.fixup+0x4), (.fixup+0x10), (.fixup+0x1c)
  + error: modpost: "mips_cm_is64" [drivers/pci/controller/pcie-mt7621.ko] undefined!:  => N/A
  + error: modpost: "mips_cm_lock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!:  => N/A
  + error: modpost: "mips_cm_unlock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!:  => N/A
  + error: modpost: "mips_cpc_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!:  => N/A
  + error: modpost: "mips_gcr_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!:  => N/A

13 error improvements:
  - /kisskb/src/drivers/pci/controller/vmd.c: error: 'X86_MSI_BASE_ADDRESS_HIGH' undeclared (first use in this function): 151:20 => 
  - /kisskb/src/drivers/pci/controller/vmd.c: error: 'X86_MSI_BASE_ADDRESS_LOW' undeclared (first use in this function): 152:35 => 
  - /kisskb/src/drivers/pci/controller/vmd.c: error: 'arch_msi_msg_addr_lo_t {aka struct arch_msi_msg_addr_lo}' has no member named 'base_address': 152:19 => 
  - /kisskb/src/drivers/pci/controller/vmd.c: error: 'arch_msi_msg_addr_lo_t {aka struct arch_msi_msg_addr_lo}' has no member named 'destid_0_7': 153:19 => 
  - /kisskb/src/drivers/pci/controller/vmd.c: error: control reaches end of non-void function [-Werror=return-type]: 128:1 => 
  - /kisskb/src/drivers/pci/controller/vmd.c: error: dereferencing pointer to incomplete type 'struct pci_sysdata': 751:4 => 
  - /kisskb/src/drivers/pci/controller/vmd.c: error: field 'sysdata' has incomplete type: 117:21 => 
  - /kisskb/src/drivers/tty/serial/cpm_uart/cpm_uart_core.c: error: 'udbg_cpm_getc' defined but not used [-Werror=unused-function]: 1109:12 => 
  - /kisskb/src/drivers/tty/serial/cpm_uart/cpm_uart_core.c: error: 'udbg_cpm_putc' defined but not used [-Werror=unused-function]: 1095:13 => 
  - /kisskb/src/drivers/tty/serial/sunzilog.c: error: 'sunzilog_putchar' defined but not used [-Werror=unused-function]: 1128:13 => 
  - /kisskb/src/drivers/usb/gadget/udc/fsl_qe_udc.c: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]: 970:41, 842:13, 842:41, 1496:12, 1496:33, 970:13 => 
  - /kisskb/src/drivers/usb/gadget/udc/fsl_qe_udc.c: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]: 843:28, 843:56, 971:28, 971:56, 1497:27, 1497:48 => 
  - /kisskb/src/lib/xxhash.c: error: the frame size of 1624 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]: 236:1 => 


*** WARNINGS ***

16 warning regressions:
  + arch/m68k/configs/multi_defconfig: warning: symbol value 'm' invalid for MCTP:  => 322
  + arch/m68k/configs/sun3_defconfig: warning: symbol value 'm' invalid for MCTP:  => 295
  + modpost: WARNING: modpost: EXPORT symbol "___rw_read_enter" [vmlinux] version ...:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "___rw_read_exit" [vmlinux] version ...:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "___rw_read_try" [vmlinux] version ...:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "___rw_write_enter" [vmlinux] version ...:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__ashldi3" [vmlinux] version ...:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__ashrdi3" [vmlinux] version ...:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__copy_1page" [vmlinux] version ...:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__divdi3" [vmlinux] version ...:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__lshrdi3" [vmlinux] version ...:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__muldi3" [vmlinux] version ...:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__ndelay" [vmlinux] version ...:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__udelay" [vmlinux] version ...:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "bzero_1page" [vmlinux] version ...:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "empty_zero_page" [vmlinux] version ...:  => N/A

29 warning improvements:
  - /kisskb/src/arch/m68k/include/asm/string.h: warning: '__builtin_memcpy' reading 6 bytes from a region of size 0 [-Wstringop-overread]: 72:25 => 
  - /kisskb/src/block/genhd.c: warning: the frame size of 1640 bytes is larger than 1536 bytes [-Wframe-larger-than=]: 1194:1 => 
  - /kisskb/src/block/genhd.c: warning: the frame size of 1672 bytes is larger than 1536 bytes [-Wframe-larger-than=]: 1194:1 => 
  - /kisskb/src/lib/xxhash.c: warning: the frame size of 1616 bytes is larger than 1536 bytes [-Wframe-larger-than=]: 236:1 => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x3570): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x3588): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x35a0): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x35b8): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x35d0): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x35e8): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x3600): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x3618): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x3630): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x3648): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x3660): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x3678): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x3690): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x36a8): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x36c0): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x36d8): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x108): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x120): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x138): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x150): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x168): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x180): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x198): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: lib/find_bit_benchmark.o(.text.unlikely+0x0): Section mismatch in reference from the (unknown reference) (unknown) to the variable .init.data:bitmap2: N/A => 
  - modpost: WARNING: modpost: lib/test_bitmap.o(.text.unlikely+0x58): Section mismatch in reference from the function bitmap_equal() to the variable .init.rodata:test_print: N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
