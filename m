Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9859D53CA6C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 15:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244520AbiFCNIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 09:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiFCNIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 09:08:36 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9452D1C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 06:08:34 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4LF39F0wZDz9t45;
        Fri,  3 Jun 2022 15:08:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lF_iJMp3a-XF; Fri,  3 Jun 2022 15:08:33 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4LF39D74YQz9t3h;
        Fri,  3 Jun 2022 15:08:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E182F8B7B0;
        Fri,  3 Jun 2022 15:08:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ckdADoihYxs8; Fri,  3 Jun 2022 15:08:32 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.6.36])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9B08B8B76D;
        Fri,  3 Jun 2022 15:08:32 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 253D8JIO1041553
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 3 Jun 2022 15:08:19 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 253D8FEU1041552;
        Fri, 3 Jun 2022 15:08:15 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Erhard Furtner <erhard_f@mailbox.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2] powerpc/irq: Increase stack_overflow detection limit when KASAN is enabled
Date:   Fri,  3 Jun 2022 15:08:14 +0200
Message-Id: <e8b4eb82a126c3c6c352173a544fe94609ff660b.1654261687.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1654261694; l=3850; s=20211009; h=from:subject:message-id; bh=Oa8LJrFPcXOQ0zvnRaIeT/fwAZFNzRdcXco0Fj1xSO4=; b=EmXmfVumULC2rYCIeJyJTeLSZWcQWO6ZSLi5jFwfAzuFOqgxFDOgG860ZQzPMIyzMPNx2Puq8U4h 4CsIxhh5CEE37Qot54BnPf26PvDdlFAZ5yIm4hgUJryFj9qzn/cS
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When KASAN is enabled, as shown by the Oops below, the 2k limit is not
enough to allow stack dump after a stack overflow detection when
CONFIG_DEBUG_STACKOVERFLOW is selected:

	do_IRQ: stack overflow: 1984
	CPU: 0 PID: 126 Comm: systemd-udevd Not tainted 5.18.0-gentoo-PMacG4 #1
	Call Trace:
	Oops: Kernel stack overflow, sig: 11 [#1]
	BE PAGE_SIZE=4K MMU=Hash SMP NR_CPUS=2 PowerMac
	Modules linked in: sr_mod cdrom radeon(+) ohci_pci(+) hwmon i2c_algo_bit drm_ttm_helper ttm drm_dp_helper snd_aoa_i2sbus snd_aoa_soundbus snd_pcm ehci_pci snd_timer ohci_hcd snd ssb ehci_hcd 8250_pci soundcore drm_kms_helper pcmcia 8250 pcmcia_core syscopyarea usbcore sysfillrect 8250_base sysimgblt serial_mctrl_gpio fb_sys_fops usb_common pkcs8_key_parser fuse drm drm_panel_orientation_quirks configfs
	CPU: 0 PID: 126 Comm: systemd-udevd Not tainted 5.18.0-gentoo-PMacG4 #1
	NIP:  c02e5558 LR: c07eb3bc CTR: c07f46a8
	REGS: e7fe9f50 TRAP: 0000   Not tainted  (5.18.0-gentoo-PMacG4)
	MSR:  00001032 <ME,IR,DR,RI>  CR: 44a14824  XER: 20000000

	GPR00: c07eb3bc eaa1c000 c26baea0 eaa1c0a0 00000008 00000000 c07eb3bc eaa1c010
	GPR08: eaa1c0a8 04f3f3f3 f1f1f1f1 c07f4c84 44a14824 0080f7e4 00000005 00000010
	GPR16: 00000025 eaa1c154 eaa1c158 c0dbad64 00000020 fd543810 eaa1c0a0 eaa1c29e
	GPR24: c0dbad44 c0db8740 05ffffff fd543802 eaa1c150 c0c9a3c0 eaa1c0a0 c0c9a3c0
	NIP [c02e5558] kasan_check_range+0xc/0x2b4
	LR [c07eb3bc] format_decode+0x80/0x604
	Call Trace:
	[eaa1c000] [c07eb3bc] format_decode+0x80/0x604 (unreliable)
	[eaa1c070] [c07f4dac] vsnprintf+0x128/0x938
	[eaa1c110] [c07f5788] sprintf+0xa0/0xc0
	[eaa1c180] [c0154c1c] __sprint_symbol.constprop.0+0x170/0x198
	[eaa1c230] [c07ee71c] symbol_string+0xf8/0x260
	[eaa1c430] [c07f46d0] pointer+0x15c/0x710
	[eaa1c4b0] [c07f4fbc] vsnprintf+0x338/0x938
	[eaa1c550] [c00e8fa0] vprintk_store+0x2a8/0x678
	[eaa1c690] [c00e94e4] vprintk_emit+0x174/0x378
	[eaa1c6d0] [c00ea008] _printk+0x9c/0xc0
	[eaa1c750] [c000ca94] show_stack+0x21c/0x260
	[eaa1c7a0] [c07d0bd4] dump_stack_lvl+0x60/0x90
	[eaa1c7c0] [c0009234] __do_IRQ+0x170/0x174
	[eaa1c800] [c0009258] do_IRQ+0x20/0x34
	[eaa1c820] [c00045b4] HardwareInterrupt_virt+0x108/0x10c
...

An investigation shows that on PPC32, calling dump_stack() requires
more than 1k when KASAN is not selected and a bit more than 2k bytes
when KASAN is selected.

On PPC64 the registers are twice the size of PPC32 registers, so the
need should be approximately twice the need on PPC32.

In the meantime we have THREAD_SIZE which is twice larger on PPC64
than PPC32, and twice larger when KASAN is selected.

So we can easily use the value of THREAD_SIZE to set the limit.

On PPC32, THREAD_SIZE is 8k without KASAN and 16k with KASAN.
On PPC64, THREAD_SIZE is 16k without KASAN.

To be on the safe side, leave 2k on PPC32 without KASAN, 4k with
KASAN, and 4k on PPC64 without KASAN. It means the limit should be
one fourth of THREAD_SIZE.

Reported-by: Erhard Furtner <erhard_f@mailbox.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Use a ratio of THREAD_SIZE
---
 arch/powerpc/kernel/irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 32409cdcbed0..72abf438a22e 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -191,8 +191,8 @@ static inline void check_stack_overflow(unsigned long sp)
 
 	sp = current_stack_pointer & (THREAD_SIZE - 1);
 
-	/* check for stack overflow: is there less than 2KB free? */
-	if (unlikely(sp < 2048)) {
+	/* check for stack overflow: is there less than 1/4th free? */
+	if (unlikely(sp < THREAD_SIZE / 4)) {
 		pr_err("do_IRQ: stack overflow: %ld\n", sp);
 		dump_stack();
 	}
-- 
2.35.3

