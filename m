Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBE6512BE0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 08:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244387AbiD1Guy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 02:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244368AbiD1Guw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 02:50:52 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776DB9859D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 23:47:38 -0700 (PDT)
Received: from mail-yw1-f173.google.com ([209.85.128.173]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mrwnt-1oGEIf2PxN-00o2RR for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022
 08:47:36 +0200
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-2f7b815ac06so42606057b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 23:47:36 -0700 (PDT)
X-Gm-Message-State: AOAM532MpVdDRrqeramj4EPdrarTLgFMEtuskQ6KX97KZrSZtShYiEST
        U2x0F8JGGiBgFsOrHOQDu6HyQAfbJBQT/BssuoM=
X-Google-Smtp-Source: ABdhPJxhNX6zLSNm8P/7MqjasgKqTDILF3r8peSc716/bmognn9jO+1JGw/yPAyuk3IvpRavz9bK4HFywgkZXKmSCB0=
X-Received: by 2002:a0d:d101:0:b0:2eb:4bd7:bcc1 with SMTP id
 t1-20020a0dd101000000b002eb4bd7bcc1mr31657396ywd.495.1651128455387; Wed, 27
 Apr 2022 23:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220427121413.168468-1-wangkefeng.wang@huawei.com>
 <20220427121413.168468-3-wangkefeng.wang@huawei.com> <CAK8P3a1E1vP-vS=-aH-XP=5taSTy8EUTfNSpQk9x47WLRMCOzQ@mail.gmail.com>
 <a0e058a5-3f46-1d05-5007-d339fa50e957@huawei.com>
In-Reply-To: <a0e058a5-3f46-1d05-5007-d339fa50e957@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 28 Apr 2022 08:47:19 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3=A1Ow2WoyW9_i6nTr85M11N85OkW-ShX5fU-zX+F2aA@mail.gmail.com>
Message-ID: <CAK8P3a3=A1Ow2WoyW9_i6nTr85M11N85OkW-ShX5fU-zX+F2aA@mail.gmail.com>
Subject: Re: [PATCH 2/4] mm: ioremap: Add arch_ioremap/iounmap_check()
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:LNrC2yPUqQrAB+EoaRjeNmQlfiBEuCwx9c+9SF54La7r0XQHUBk
 XRpLAvqK9ndUgCe/a1+CEI8wdwJXmnQFcLTtEQCzjoJ1z2gbdm9ASh9nKp0ZE67vq/c68cc
 fzEKSfg1gwjpKaNWHCfDSlMnzrrSOA1kXDV0/iA9gCuafrOXfq2AQzyRecsJ+u8Pkvks/ut
 ZULqsWBWI2KyztHomqjuQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8lZby8Iqvb4=:8TyY/9b1btLkorD0wx2E69
 koL25gZGPwe3Cyfw4rYNP41GcmuKI1lLMAVwOtfT75P/2EZrZ+IoYCmBeCjAv97Ef/Stln3sv
 9LgoiplNiC2zIklVddSKo+x42xLxzbab+Ae3/umd6/trvplqVAiAtW5MIWItl0uFFWjpHR0Y8
 OuXoxR0zInZJfxcNt4eW9Bx1UKjrq2eO+ck7J0NPVOLPIVzetljxqNhs5gfHEqhjCicw+Vq7h
 irbrC2NRvctqKyxOHgVjIrk8XVGlXoUCqH8B76nRdBsWVuVq6FDpFDpZlZHaLr15z2Ej5RYdB
 /e9XmB/LAg45tt6Xjfo2dr5G9Z34XSCLDsMWAirIE1r5N3mFLNnEmNstQFCN9E4drYO3xx/kc
 TOzrGElsWZbkxzlEMtbG5K7J2pibKqGaCQiRiT9FyT/kHsazcaIOG9iPVqlTIJK6pRtTF9uH1
 c+5qx57zkgMCAbk87nf2sb5sSgk3/cfutCxP4hgE2XwI77T0x/Nh8cPAhAKRd5CGTaVIJ3t8g
 ArOid8T+Tkfm4bA9ERrXJvYcWSzC7ZnmQhn2yYNo3I1EDD+XpCUcBwf6QHgsp3D4ykrzB5ETE
 tiosHD+d4+tLQ2dMauUft0/76lL/lICnbLucYvWgh5CfBn8+5F9k+aTBppm1pVQwxKlyMbb4F
 mI9R8kCNdJ9HQFfuW76y4euG0NKQKkHBVVb7of4nivUQJzEeE5ze07wO1vCgqkl2Tx3F4l8N0
 bry6jiOuDc6KSEByDOP9jwWYU4/sWtfgxAzaYS96b/SeLj+M9xPuz6zmAozpRBOYnGimpL9KF
 bC4qoJyoC39aJ3o86UPCD93bg0QdbLRS5524C93RQ2aEmjVpL0=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 8:20 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> On 2022/4/28 2:20, Arnd Bergmann wrote:
> > On Wed, Apr 27, 2022 at 2:14 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> >
> > bool arch_ioremap_check(phys_addr_t addr, size_t size, unsigned long prot);
> > #define arch_ioremap_check arch_ioremap_check
> Ok, I could use this way, and keep consistent with others definitions in
> asm/io.h
> > (or alternatively an extern declaration, if the implementation is nontrivial)
> >
> > It may be worth pointing out that either way requires including
> > asm-generic/io.h,
> > which most architectures don't. This is probably fine, as only csky, riscv and
> > now arm64 use CONFIG_GENERIC_IOREMAP, and we can probably require
> > that any further architectures using this symbol also have to use
> > asm-generic/io.h.
>
> It looks the arch is already include it,
>
> $ git grep "asm-generic/io.h" arch/
>
> arch/arc/include/asm/io.h:#include <asm-generic/io.h>
> arch/arm/include/asm/io.h:#include <asm-generic/io.h>
> arch/arm64/include/asm/io.h:#include <asm-generic/io.h>
> arch/csky/include/asm/io.h:#include <asm-generic/io.h>
> arch/h8300/include/asm/io.h:#include <asm-generic/io.h>
> arch/ia64/include/asm/io.h:#include <asm-generic/io.h>
> arch/m68k/include/asm/io.h:#include <asm-generic/io.h>
> arch/m68k/include/asm/io_no.h: * that behavior here first before we
> include asm-generic/io.h.
> arch/microblaze/include/asm/io.h:#include <asm-generic/io.h>
> arch/nios2/include/asm/io.h:#include <asm-generic/io.h>
> arch/openrisc/include/asm/io.h:#include <asm-generic/io.h>
> arch/powerpc/include/asm/io.h:#include <asm-generic/io.h>
> arch/riscv/include/asm/io.h:#include <asm-generic/io.h>
> arch/s390/include/asm/io.h:#include <asm-generic/io.h>
> arch/sparc/include/asm/io_32.h:#include <asm-generic/io.h>
> arch/um/include/asm/io.h:#include <asm-generic/io.h>
> arch/x86/include/asm/io.h:#include <asm-generic/io.h>
> arch/xtensa/include/asm/io.h:#include <asm-generic/io.h>

Right, it's mostly the older architectures that never started using
asm-generic/io.h:

$ git grep -L asm-generic/io.h arch/*/include/asm/io.h
arch/alpha/include/asm/io.h
arch/hexagon/include/asm/io.h
arch/mips/include/asm/io.h
arch/parisc/include/asm/io.h
arch/sh/include/asm/io.h
arch/sparc/include/asm/io.h # it is used on sparc32

That's actually less than I expected, and most of these are not
seeing a lot of upstream work any more.

        Arnd
