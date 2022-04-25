Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B047050DA56
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 09:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240657AbiDYHqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 03:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240256AbiDYHqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 03:46:06 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDA23D4BB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 00:43:00 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:c150:c4b6:d197:3811])
        by baptiste.telenet-ops.be with bizsmtp
        id Nviw2700S3M22MD01vix4W; Mon, 25 Apr 2022 09:42:59 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nitN2-0025Up-FP; Mon, 25 Apr 2022 09:42:56 +0200
Date:   Mon, 25 Apr 2022 09:42:56 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
X-X-Sender: geert@ramsan.of.borg
To:     linux-kernel@vger.kernel.org
cc:     Song Liu <song@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Rik van Riel <riel@surriel.com>, sparclinux@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-media@vger.kernel.org
Subject: Re: Build regressions/improvements in v5.18-rc4
In-Reply-To: <20220425073220.3491038-1-geert@linux-m68k.org>
Message-ID: <alpine.DEB.2.22.394.2204250939240.497673@ramsan.of.borg>
References: <CAHk-=whmtHMzjaVUF9bS+7vE_rrRctcCTvsAeB8fuLYcyYLN-g@mail.gmail.com> <20220425073220.3491038-1-geert@linux-m68k.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2022, Geert Uytterhoeven wrote:
> JFYI, when comparing v5.18-rc4[1] to v5.18-rc3[3], the summaries are:
>  - build errors: +6/-7

   + /kisskb/src/drivers/media/platform/nxp/imx-pxp.h: error: initializer element is not constant:  => 582:38

powerpc-gcc5/powerpc-allmodconfig

Seen before, looks like one more large 32-bit constant with bit 31 set
lacking the "U" suffix.

   + error: arch/sparc/kernel/head_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.init.text':  => (.head.text+0x5040), (.head.text+0x5100)
   + error: arch/sparc/kernel/head_32.o: relocation truncated to fit: R_SPARC_WDISP22 against symbol `leon_smp_cpu_startup' defined in .text section in arch/sparc/kernel/trampoline_32.o:  => (.init.text+0xa4)
   + error: arch/sparc/kernel/process_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text':  => (.fixup+0xc), (.fixup+0x4)
   + error: arch/sparc/kernel/signal_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text':  => (.fixup+0x4), (.fixup+0x10), (.fixup+0x34), (.fixup+0x1c), (.fixup+0x28)

sparc64/sparc-allmodconfig

   + error: page_alloc.c: undefined reference to `vmalloc_huge':  => .init.text+0x1458), .init.text+0x13de), .init.text+0x1466)

sh4-gcc10/se7619_defconfig
m68k-gcc8/m5272c3_defconfig
m68k-gcc11/m5272c3_defconfig

Anything with CONFIG_MMU=n, I guess.
vmalloc_huge() is provided by mm/vmalloc.c, which is not compiled if
CONFIG_MMU=n.

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/af2d861d4cd2a4da5137f795ee3509e6f944a25b/ (all 96 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/b2d229d4ddb17db541098b83524d901257e93845/ (all 96 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
