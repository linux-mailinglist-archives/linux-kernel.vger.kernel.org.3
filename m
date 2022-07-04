Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBAB5653C7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 13:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234428AbiGDLgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 07:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbiGDLgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:36:23 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C9511A04
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 04:36:14 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lc3fM0X09z4xbT;
        Mon,  4 Jul 2022 21:36:11 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Erhard Furtner <erhard_f@mailbox.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <e8b4eb82a126c3c6c352173a544fe94609ff660b.1654261687.git.christophe.leroy@csgroup.eu>
References: <e8b4eb82a126c3c6c352173a544fe94609ff660b.1654261687.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] powerpc/irq: Increase stack_overflow detection limit when KASAN is enabled
Message-Id: <165693439802.9954.361439982234083073.b4-ty@ellerman.id.au>
Date:   Mon, 04 Jul 2022 21:33:18 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jun 2022 15:08:14 +0200, Christophe Leroy wrote:
> When KASAN is enabled, as shown by the Oops below, the 2k limit is not
> enough to allow stack dump after a stack overflow detection when
> CONFIG_DEBUG_STACKOVERFLOW is selected:
> 
> 	do_IRQ: stack overflow: 1984
> 	CPU: 0 PID: 126 Comm: systemd-udevd Not tainted 5.18.0-gentoo-PMacG4 #1
> 	Call Trace:
> 	Oops: Kernel stack overflow, sig: 11 [#1]
> 	BE PAGE_SIZE=4K MMU=Hash SMP NR_CPUS=2 PowerMac
> 	Modules linked in: sr_mod cdrom radeon(+) ohci_pci(+) hwmon i2c_algo_bit drm_ttm_helper ttm drm_dp_helper snd_aoa_i2sbus snd_aoa_soundbus snd_pcm ehci_pci snd_timer ohci_hcd snd ssb ehci_hcd 8250_pci soundcore drm_kms_helper pcmcia 8250 pcmcia_core syscopyarea usbcore sysfillrect 8250_base sysimgblt serial_mctrl_gpio fb_sys_fops usb_common pkcs8_key_parser fuse drm drm_panel_orientation_quirks configfs
> 	CPU: 0 PID: 126 Comm: systemd-udevd Not tainted 5.18.0-gentoo-PMacG4 #1
> 	NIP:  c02e5558 LR: c07eb3bc CTR: c07f46a8
> 	REGS: e7fe9f50 TRAP: 0000   Not tainted  (5.18.0-gentoo-PMacG4)
> 	MSR:  00001032 <ME,IR,DR,RI>  CR: 44a14824  XER: 20000000
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/irq: Increase stack_overflow detection limit when KASAN is enabled
      https://git.kernel.org/powerpc/c/41f20d6db2b64677225bb0b97df956241c353ef8

cheers
