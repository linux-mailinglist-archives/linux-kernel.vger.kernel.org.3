Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488234B9A29
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 08:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236698AbiBQHxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 02:53:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiBQHxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 02:53:02 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F841178386;
        Wed, 16 Feb 2022 23:52:47 -0800 (PST)
Received: from mail-wr1-f54.google.com ([209.85.221.54]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MTRhS-1nhaUr1zAK-00TmQM; Thu, 17 Feb 2022 08:52:45 +0100
Received: by mail-wr1-f54.google.com with SMTP id x5so2599562wrg.13;
        Wed, 16 Feb 2022 23:52:45 -0800 (PST)
X-Gm-Message-State: AOAM531TqIZdxzgjKe4IT23BQjAj1r63uuynd0Qg8QWg7OVn4Y2HxdBL
        jgNv3OGPn/PBpOvnautqsDKZ5B1nfPHZOSMxt4U=
X-Google-Smtp-Source: ABdhPJwQLFNR2EKsG8wmZOAHPh9E9pyoICR3LxZT862dIjr2W4W3Sw6yF+ayzR5i5e/QGR8IN4+3KhdYVHoGFF4fNyc=
X-Received: by 2002:adf:ea01:0:b0:1e4:b3e6:1f52 with SMTP id
 q1-20020adfea01000000b001e4b3e61f52mr1268592wrm.317.1645084364936; Wed, 16
 Feb 2022 23:52:44 -0800 (PST)
MIME-Version: 1.0
References: <20220216131332.1489939-1-arnd@kernel.org> <20220216131332.1489939-14-arnd@kernel.org>
In-Reply-To: <20220216131332.1489939-14-arnd@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 17 Feb 2022 08:52:29 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2T1Xr80GeM-3p1riyq=gKDJGeKVz_c5=r5=s14tXimLw@mail.gmail.com>
Message-ID: <CAK8P3a2T1Xr80GeM-3p1riyq=gKDJGeKVz_c5=r5=s14tXimLw@mail.gmail.com>
Subject: Re: [PATCH v2 13/18] uaccess: generalize access_ok()
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
X-Provags-ID: V03:K1:6qcGhdTsQQvMIjB+11ipNF1DrG+OLInVcjYi4AXjSR4T+7w4a4G
 tvj/SU8V3XwoOWQPVG9LxfZPKnFfLZip/Q4k4pg7UiCm4QGSGIJG0sIDDl9GKfICP6+qAIY
 2+TUcn5VnZN+i0sxBK5Yt242p2TWzmOaCg69Dt9OeqZlWdjtizeah9g/3PjyvE9B+9lCD1L
 cKNv6Z/s/LgftziOoQUwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CT/jrqtcU4M=:Zv3JDSyXiRmqHqKodZslB7
 3QItAyZqGrrdujTkgjWTe2nLVFia6DNQFSxqyuKIbAZbvNq2qVE/eFLvQySB221PHtHXwneUV
 jDNmJ+8IvxTUh9sQ2tvEo798diQK/aMGpLb6zIxR3+FmT27CYi3O72DzVWnceCXZK/Ab97tjl
 7yNpRfe9rseliofEBesnhBMlkoPAA3BkpAufttUG/1+JHNedB9jjpLNOTjRRTqx+xpCAe8TJu
 bekYeD49xY2n6gC6aMUr1P3If+IrOGrkCuU+Y/JgmVOzXR49gdzM1pvgLMeEh+IxznNF700YJ
 NSfkg3nwCztUCEcq4QrM0rYqRzo9VVeLE8clBCyFNwIBEK2h7V47gFGJU/jh1/OIgX+QDG1Bd
 ykoa0T4/6JAO1tRyeVLtwu5V4+O8XmfcIe/0HFAgKMomfIUv5z0TRjCBRPfVEgUT1z26sY8eZ
 V2FyUYhGL4T8niOYM0VMElPrWbPXCpkDTc32CTxUG4FtnLAUm5q0YtY8UCB5SfPmEvs872UcB
 JYG5FhZ6yvlju0HgBfXV5Ij6tGi8f6vs1Iul27i8PJDCX7NblHy1jMjIeeYujTJZOKGNZYuZF
 9WygKkgt0tYdxs3IY9w1y1O6q5aO9ej6sDRdevCJ9Mgs53y7tapePFZlQFEK4n/xyuefbw+aG
 ONLsNcA4Js6RituaMOzRoHSki8u9w79atqtmfMMpr447tcY8vA0gG/lY1+mAY1SIShQrJuVPW
 IgaumcQOhFBhQLK33pRh20IdKBdAI/f98rh2rbS91AVhB4stYLN5lwF+Lp20cvEnO84Wlgc2W
 zPr4qrp2w7NFLOSP4dAsGZuNUvSWeaUnvz85A2q/N5hU7F34V4=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 2:13 PM Arnd Bergmann <arnd@kernel.org> wrote:

> + * limit and catch all possible overflows.
> + * On architectures with separate user address space (m68k, s390, parisc,
> + * sparc64) or those without an MMU, this should always return true.
...
> +static inline int __access_ok(const void __user *ptr, unsigned long size)
> +{
> +       unsigned long limit = user_addr_max();
> +       unsigned long addr = (unsigned long)ptr;
> +
> +       if (IS_ENABLED(CONFIG_ALTERNATE_USER_ADDRESS_SPACE))
> +               return true;

I noticed that I'm missing the check for !CONFIG_MMU here, despite
mentioning that in the comment above it. I've added it now.

        Arnd
