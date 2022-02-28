Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8564C6CA5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236453AbiB1MgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbiB1MgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:36:18 -0500
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D959E7560C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:35:35 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:a4f2:4931:edd0:99e3])
        by xavier.telenet-ops.be with bizsmtp
        id 0cbY2700a5QlnJa01cbZbE; Mon, 28 Feb 2022 13:35:33 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nOeo2-002DOq-5V
        for linux-kernel@vger.kernel.org; Mon, 28 Feb 2022 13:07:10 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nOcKA-003Q2q-9K
        for linux-kernel@vger.kernel.org; Mon, 28 Feb 2022 10:28:10 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v5.17-rc6
Date:   Mon, 28 Feb 2022 10:28:10 +0100
Message-Id: <20220228092810.815034-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
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
v5.17-rc6[1] compared to v5.16[2].

Summarized:
  - build errors: +15/-3
  - build warnings: +24/-25

JFYI, when comparing v5.17-rc6[1] to v5.17-rc5[3], the summaries are:
  - build errors: +1/-2
  - build warnings: +1/-1

Note that there may be false regressions, as some logs are incomplete.
Still, they're build errors/warnings.

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3/ (all 99 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/df0cc57e057f18e44dac8e6c18aba47ab53202f9/ (98 out of 99 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/cfb92440ee71adcc2105b0890bb01ac3cddb8507/ (all 99 configs)


*** ERRORS ***

15 error regressions:
  + /kisskb/src/arch/powerpc/kernel/stacktrace.c: error: implicit declaration of function 'nmi_cpu_backtrace' [-Werror=implicit-function-declaration]:  => 171:2
  + /kisskb/src/arch/powerpc/kernel/stacktrace.c: error: implicit declaration of function 'nmi_trigger_cpumask_backtrace' [-Werror=implicit-function-declaration]:  => 226:2
  + /kisskb/src/arch/sparc/mm/srmmu.c: error: cast between incompatible function types from 'void (*)(long unsigned int)' to 'void (*)(long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)' [-Werror=cast-function-type]:  => 1756:13, 1639:13
  + /kisskb/src/arch/sparc/mm/srmmu.c: error: cast between incompatible function types from 'void (*)(struct mm_struct *)' to 'void (*)(long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)' [-Werror=cast-function-type]:  => 1674:29, 1662:29
  + /kisskb/src/arch/sparc/mm/srmmu.c: error: cast between incompatible function types from 'void (*)(struct mm_struct *, long unsigned int)' to 'void (*)(long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)' [-Werror=cast-function-type]:  => 1767:21
  + /kisskb/src/arch/sparc/mm/srmmu.c: error: cast between incompatible function types from 'void (*)(struct vm_area_struct *, long unsigned int)' to 'void (*)(long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)' [-Werror=cast-function-type]:  => 1726:29, 1741:29
  + /kisskb/src/arch/sparc/mm/srmmu.c: error: cast between incompatible function types from 'void (*)(struct vm_area_struct *, long unsigned int,  long unsigned int)' to 'void (*)(long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)' [-Werror=cast-function-type]:  => 1711:29, 1694:29
  + /kisskb/src/arch/um/include/asm/processor-generic.h: error: called object is not a function or function pointer:  => 103:18
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c: error: control reaches end of non-void function [-Werror=return-type]:  => 1560:1
  + /kisskb/src/drivers/vfio/pci/vfio_pci_rdwr.c: error: assignment makes pointer from integer without a cast [-Werror=int-conversion]:  => 324:9, 317:9
  + /kisskb/src/drivers/vfio/pci/vfio_pci_rdwr.c: error: implicit declaration of function 'ioport_map' [-Werror=implicit-function-declaration]:  => 317:11
  + /kisskb/src/drivers/vfio/pci/vfio_pci_rdwr.c: error: implicit declaration of function 'ioport_unmap' [-Werror=implicit-function-declaration]:  => 338:15
  + error: arch/powerpc/kvm/book3s_64_entry.o: relocation truncated to fit: R_PPC64_REL14 (stub) against symbol `system_reset_common' defined in .text section in arch/powerpc/kernel/head_64.o:  => (.text+0x3ec)
  + error: omap-gpmc.c: undefined reference to `of_platform_device_create':  => .text.unlikely+0x14c4), .text.unlikely+0x1628)
  + error: verifier.c: relocation truncated to fit: R_NDS32_WORD_9_PCREL_RELA against `.text':  => (.text+0x10228)

3 error improvements:
  - /kisskb/src/crypto/blake2b_generic.c: error: the frame size of 2288 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]: 109:1 => 
  - /kisskb/src/drivers/mtd/nand/raw/mpc5121_nfc.c: error: unused variable 'mtd' [-Werror=unused-variable]: 294:19 => 
  - /kisskb/src/drivers/video/fbdev/riva/fbdev.c: error: passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type [-Werror=discarded-qualifiers]: 2095:11, 2062:11 => 


*** WARNINGS ***

24 warning regressions:
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14410): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14428): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14440): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14458): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14470): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14488): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x144a0): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x144f0): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14508): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14520): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14538): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14550): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14568): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14580): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14598): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x4790): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x47a8): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x47c0): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x47d8): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x47f0): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x4808): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x4820): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x4530): Section mismatch in reference from the function __trace_event_discard_commit() to the variable .init.data:initcall_level_names:  => N/A
  + warning: unmet direct dependencies detected for OMAP_GPMC:  => N/A

25 warning improvements:
  - arch/m68k/configs/multi_defconfig: warning: symbol value 'm' invalid for MCTP: 322 => 
  - arch/m68k/configs/sun3_defconfig: warning: symbol value 'm' invalid for MCTP: 295 => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x136d0): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x136e8): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x13700): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x13718): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x13730): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x13748): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x13760): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x137b0): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x137c8): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x137e0): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x137f8): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x13810): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x13828): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x13840): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x13858): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x4610): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x4628): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x4640): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x4658): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x4670): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x4688): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x46a0): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x45e4): Section mismatch in reference from the function __trace_event_discard_commit() to the variable .init.data:initcall_level_names: N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
