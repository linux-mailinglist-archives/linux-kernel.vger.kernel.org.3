Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0759853EB77
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbiFFJIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 05:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbiFFJIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 05:08:17 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF64410FC6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 02:08:15 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:4ddc:2f16:838f:9c0c])
        by albert.telenet-ops.be with bizsmtp
        id fl8C270034e6eDr06l8Cbl; Mon, 06 Jun 2022 11:08:14 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ny8iZ-002urS-KO; Mon, 06 Jun 2022 11:08:11 +0200
Date:   Mon, 6 Jun 2022 11:08:11 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
X-X-Sender: geert@ramsan.of.borg
To:     linux-kernel@vger.kernel.org
cc:     Kees Cook <keescook@chromium.org>, nvdimm@lists.linux.dev,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-scsi@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: Build regressions/improvements in v5.19-rc1
In-Reply-To: <20220606082201.2792145-1-geert@linux-m68k.org>
Message-ID: <alpine.DEB.2.22.394.2206061104510.695137@ramsan.of.borg>
References: <CAHk-=wgZt-YDSKfdyES2p6A_KJoG8DwQ0mb9CeS8jZYp+0Y2Rw@mail.gmail.com> <20220606082201.2792145-1-geert@linux-m68k.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jun 2022, Geert Uytterhoeven wrote:
> Below is the list of build error/warning regressions/improvements in
> v5.19-rc1[1] compared to v5.18[2].
>
> Summarized:
>  - build errors: +9/-10

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/f2906aa863381afb0015a9eb7fefad885d4e5a56/ (all 135 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/4b0986a3613c92f4ec1bdc7f60ec66fea135991f/ (131 out of 135 configs)

> 9 error regressions:
>  + /kisskb/src/arch/um/include/asm/page.h: error: too few arguments to function 'to_phys':  => 105:20
>  + /kisskb/src/drivers/nvdimm/pmem.c: error: conflicting types for 'to_phys':  => 48:20
>  + /kisskb/src/drivers/nvdimm/pmem.c: error: control reaches end of non-void function [-Werror=return-type]:  => 324:1

um-x86_64/um-allyesconfig

>  + /kisskb/src/arch/xtensa/kernel/entry.S: Error: unknown pseudo-op: `.bss':  => 2176

xtensa-gcc11/xtensa-allmodconfig

>  + /kisskb/src/drivers/tty/serial/sh-sci.c: error: unused variable 'sport' [-Werror=unused-variable]:  => 2655:26

sh4-gcc11/se7619_defconfig
sh4-gcc11/sh-allmodconfig

Fix available
https://lore.kernel.org/all/4ed0a7a0d3fa912a5b44c451884818f2c138ef42.1644914600.git.geert+renesas@glider.be

>  + /kisskb/src/include/linux/fortify-string.h: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]:  => 344:25

powerpc-gcc11/ppc64_book3e_allmodconfig

>  + /kisskb/src/include/ufs/ufshci.h: error: initializer element is not constant:  => 245:36

mipsel-gcc5/mips-allmodconfig
powerpc-gcc5/powerpc-allmodconfig

FTR, include/ufs/ufshci.h lacks a MAINTAINERS entry.

>  + error: relocation truncated to fit: R_SPARC_WDISP22 against `.init.text':  => (.head.text+0x5100), (.head.text+0x5040)
>  + error: relocation truncated to fit: R_SPARC_WDISP22 against symbol `leon_smp_cpu_startup' defined in .text section in arch/sparc/kernel/trampoline_32.o:  => (.init.text+0xa4)

sparc64-gcc5/sparc-allmodconfig

> 3 warning regressions:

>  + arch/m68k/configs/multi_defconfig: warning: symbol value 'm' invalid for ZPOOL:  => 61
>  + arch/m68k/configs/sun3_defconfig: warning: symbol value 'm' invalid for ZPOOL:  => 37

Will be fixed by the m68k defconfig update for v5.20.

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
