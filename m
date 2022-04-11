Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7854FB9E0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345667AbiDKKoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239248AbiDKKoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:44:24 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A40D3F897
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:42:10 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:b509:6862:2557:437a])
        by laurent.telenet-ops.be with bizsmtp
        id HNi82700A1G7NMJ01Ni8NX; Mon, 11 Apr 2022 12:42:08 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ndrUl-000A17-WE; Mon, 11 Apr 2022 12:42:08 +0200
Date:   Mon, 11 Apr 2022 12:42:07 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
X-X-Sender: geert@ramsan.of.borg
To:     linux-kernel@vger.kernel.org
cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>, sparclinux@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: Re: Build regressions/improvements in v5.18-rc2
In-Reply-To: <20220411103528.2187797-1-geert@linux-m68k.org>
Message-ID: <alpine.DEB.2.22.394.2204111240560.38484@ramsan.of.borg>
References: <CAHk-=wh0+DYC2+Aeu2=vfUtGaDqVuKxKrxyhwQFoG89rcynzww@mail.gmail.com> <20220411103528.2187797-1-geert@linux-m68k.org>
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

On Mon, 11 Apr 2022, Geert Uytterhoeven wrote:
> JFYI, when comparing v5.18-rc2[1] to v5.18-rc1[3], the summaries are:
>  - build warnings: +23/-0

   + /kisskb/src/arch/sparc/include/asm/cacheflush_32.h: error: 'struct page' declared inside parameter list [-Werror]:  => 38:37
   + /kisskb/src/arch/sparc/include/asm/cacheflush_32.h: error: its scope is only this definition or declaration, which is probably not what you want [-Werror]:  => 38:37

sparc64/sparc-allmodconfig

   + /kisskb/src/arch/sparc/mm/srmmu.c: error: cast between incompatible function types from 'void (*)(long unsigned int)' to 'void (*)(long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)' [-Werror=cast-function-type]:  => 1639:13, 1756:13
   + /kisskb/src/arch/sparc/mm/srmmu.c: error: cast between incompatible function types from 'void (*)(struct mm_struct *)' to 'void (*)(long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)' [-Werror=cast-function-type]:  => 1662:29, 1674:29
   + /kisskb/src/arch/sparc/mm/srmmu.c: error: cast between incompatible function types from 'void (*)(struct mm_struct *, long unsigned int)' to 'void (*)(long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)' [-Werror=cast-function-type]:  => 1767:21
   + /kisskb/src/arch/sparc/mm/srmmu.c: error: cast between incompatible function types from 'void (*)(struct vm_area_struct *, long unsigned int)' to 'void (*)(long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)' [-Werror=cast-function-type]:  => 1741:29, 1726:29
   + /kisskb/src/arch/sparc/mm/srmmu.c: error: cast between incompatible function types from 'void (*)(struct vm_area_struct *, long unsigned int,  long unsigned int)' to 'void (*)(long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)' [-Werror=cast-function-type]:  => 1711:29, 1694:29

sparc64-gcc11/sparc-allmodconfig

   + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_491' declared with attribute error: FIELD_PREP: mask is not constant:  => 352:38
   + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_520' declared with attribute error: FIELD_PREP: mask is not constant:  => 352:38

mipsel/mips-allmodconfig
arm64-gcc5.4/arm64-allmodconfig

Actual error is:

     /kisskb/src/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c: In function 'mt76x2e_probe':
     /kisskb/src/include/linux/compiler_types.h:352:38: error: call to '__compiletime_assert_520' declared with attribute error: FIELD_PREP: mask is not constant

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e/ (all 96 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/3123109284176b1532874591f7c81f3837bbdc17/ (all 96 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
