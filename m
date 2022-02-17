Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CD54B9BD4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 10:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238465AbiBQJOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 04:14:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiBQJOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 04:14:02 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DB9279093;
        Thu, 17 Feb 2022 01:13:47 -0800 (PST)
Received: from mail-wm1-f49.google.com ([209.85.128.49]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MbBUc-1nrlkP3FMG-00ba8D; Thu, 17 Feb 2022 10:13:45 +0100
Received: by mail-wm1-f49.google.com with SMTP id k127-20020a1ca185000000b0037bc4be8713so5642392wme.3;
        Thu, 17 Feb 2022 01:13:45 -0800 (PST)
X-Gm-Message-State: AOAM530cXqInqFnRZrNHPv8F9Bv9ZU/6Nrbg1+9ZyKwZgp/QWCzhK7q4
        a8jtrAnR1/f9sa2bnwNcvcjPnvgEc/kRcs1balk=
X-Google-Smtp-Source: ABdhPJwu2NVHGHLxx29UDj0eC2QtTDz9ABoGgqvKd5FtPXFo3D/c1j3IHxwDsslquGRbQQhg+y3kZFZQ6qJy+rJ75Go=
X-Received: by 2002:a05:600c:1d27:b0:37c:74bb:2b4d with SMTP id
 l39-20020a05600c1d2700b0037c74bb2b4dmr4990966wms.82.1645085639420; Thu, 17
 Feb 2022 00:13:59 -0800 (PST)
MIME-Version: 1.0
References: <20220216131332.1489939-1-arnd@kernel.org>
In-Reply-To: <20220216131332.1489939-1-arnd@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 17 Feb 2022 09:13:43 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3QBWDYjr6VpPdjTBGFg88DdH3SHVgxEowgScgJOkNguQ@mail.gmail.com>
Message-ID: <CAK8P3a3QBWDYjr6VpPdjTBGFg88DdH3SHVgxEowgScgJOkNguQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/18] clean up asm/uaccess.h, kill set_fs for good
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@codeaurora.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Rich Felker <dalias@libc.org>,
        David Miller <davem@davemloft.net>,
        Richard Weinberger <richard@nod.at>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>, linux-csky@vger.kernel.org,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:DWw8/YboN0VA6d+k6fSV83nQbC/ZW2wmQtyWyNvQRDOztud3WQ1
 AnIMws496a5T5xk4vOXJvIH3ubEyigceAA3MZmosjx3t/8wYb2bAkyFAHAnlH/gXyXoO4MC
 6OXbGHp0kRSDSXaSqC/pBLsY/XbPRAn4510M1I/nBvX1e+0Sh7I2brZBCtBQBKMNI/DlCeC
 ATdzznqt6hmKNtUzV76jA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bCDoBw/rSs4=:7ZpiywYHjbn9ofMCGDNfAY
 ZmaKOeukHz/i1FvEWeUnFD0+Ss3VsIj+ifgbYRpWCti0Gh1IkbQlObrmQEtIgfRfm09n5f5H4
 juKvdnlr6upa6dkn0Kj1+Mjv86NpYedKVeAEuDu5MmJ4Uled5HrF9cMkpAK/McqYRWq65wjK2
 40dWs0HF+wIXDWq+qoskgDMIWBSlXVlHAUSamn5ghAWxS0kcMHW5ns/O2yCI0+XAI4Ra4U5qY
 HEaJOLhW0PC35eAPWAU3/ztD54YhNmPLbODiw0iipIV0rBLsFx5ZxvJaiZnQte52YfmeUFgUa
 k3PaKnQXm27l+0veXT+nctw37AC5BwVknsgEXLNPiKJIol6HbJ8J5t5PcZ1D/QOmTdjGeO4AR
 0g9GN43ocXW4LVZkCjdxmPh1EG9Dk93/krP1UZogxKLIuXKk9uiaeM2q5KYryQPPC0eBnERKW
 3aoGe/Vd2e1PtAgwFISoQ2Mc60EDRajfVEmwNsc+ZJ6F5QuDc3GVdc3LMXbLgXPuJp/Bk1T54
 uug2aTPCPctCC0Kjkmvd9xxC4jsLMx7x9CtymMugFg8Eje946mauR1ArtzUQgTpwn/vFVpWsa
 6zHXLMQg52xS3vcAZUlA9niqd26IcwOShz2/29sRFEZzp0qYv8frWdS2Wk7OX3BZ3GUjJgKsz
 BqJiQVW7t8fuf17y2qd8J7A5Sh8nQIpBxE9ZqAULMxjdpJ8zdo1SRttVQbE6L29lIFc94t+fu
 X7JFQ1XAR4JQV5MIV4VE+QhO0Utkv4QnwYspZJXM10rUIJe63cIUNIri6hGTrZoHv8NGMVgCk
 n8pRSzEIvcv/sRuJ686AST0gjiFHSTP64ColJil/N3M5h5gr6sojMyFYJXE6I+FXI0acF0k
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 2:13 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Christoph Hellwig and a few others spent a huge effort on removing
> set_fs() from most of the important architectures, but about half the
> other architectures were never completed even though most of them don't
> actually use set_fs() at all.
>
> I did a patch for microblaze at some point, which turned out to be fairly
> generic, and now ported it to most other architectures, using new generic
> implementations of access_ok() and __{get,put}_kernel_nocheck().
>
> Three architectures (sparc64, ia64, and sh) needed some extra work,
> which I also completed.
>
> The final series contains extra cleanup changes that touch all
> architectures. Please review and test these, so we can merge them
> for v5.18.
>
> The series is available at
> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/log/?h=set_fs-2
> for testing.

I've added the updated contents to my asm-generic tree now to put them
into linux-next.

         Arnd
