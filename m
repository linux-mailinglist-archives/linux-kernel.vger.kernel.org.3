Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036E7495C66
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 09:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379591AbiAUI5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 03:57:05 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:33879 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbiAUI5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 03:57:04 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M9WiK-1nGJMv0rHY-005WIw; Fri, 21 Jan 2022 09:57:01 +0100
Received: by mail-oi1-f175.google.com with SMTP id x193so12786488oix.0;
        Fri, 21 Jan 2022 00:57:00 -0800 (PST)
X-Gm-Message-State: AOAM530JDR3GWqRtnL7inzM2TCJNCeLWB7HWJCYZCn4LdGrWw9ulABJu
        80ROBoJWSEwxEscNhLZajR5dzGehlCoGAtpcJkA=
X-Google-Smtp-Source: ABdhPJylnMQV70n0iz9SImQwsqAn8J+KL/hKoGrWF8c1XxnGFchA2qX7H9h0ZVY5igqqe7kHNmQOCuoQNmiaakrHJBA=
X-Received: by 2002:a05:6808:9a:: with SMTP id s26mr2365492oic.108.1642755419287;
 Fri, 21 Jan 2022 00:56:59 -0800 (PST)
MIME-Version: 1.0
References: <20220120073911.99857-9-guoren@kernel.org> <CAK8P3a0LxB3we9wHOa4OPmNow6wz5NP49zeYhh7QXNv-MiR8UA@mail.gmail.com>
 <CAJF2gTQVUF4LSO0a6_MV8x-UAiJw32pAFyS1oPNLXhcEaemzqg@mail.gmail.com>
In-Reply-To: <CAJF2gTQVUF4LSO0a6_MV8x-UAiJw32pAFyS1oPNLXhcEaemzqg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 21 Jan 2022 09:56:43 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1sOejkdOyoRUfw4ESS7ewX_8Wj9tQNrZ40OiuDqJnrmw@mail.gmail.com>
Message-ID: <CAK8P3a1sOejkdOyoRUfw4ESS7ewX_8Wj9tQNrZ40OiuDqJnrmw@mail.gmail.com>
Subject: Re: [PATCH V3 08/17] riscv: compat: syscall: Add compat_sys_call_table
 implementation
To:     Guo Ren <guoren@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        inux-parisc@vger.kernel.org,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:IRpQPv8WoAqPSucQu/tG6nYL/K7Y5OESJf7MTo7MX1bQCNjtbkX
 mgieNxFEqUu9XXdJHhk9CH4iJ3s3ba6aZc39s3BytPSR5sZ6og+VWElDBiG+lMGhIbu49Yp
 xtVVwqEsPyaFk7uAss600Ux+zMasvK/PRfcCfqNeu9pu93+kt8mebWFL8jk5zE+39N3e7Tu
 zMnPh760S6oQqgLLahT3Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6ZAe3wFVFro=:Mp2/8vZ841C8qpVmzjLTG0
 3vQdqDDuwG6NoS80SODh6gmJ2uPM1IRaO7AuVtu/xT/5X8+f0u6ySwlNYiQL1QVsU3CZyPIUi
 /1NFBGxq69oP20f9pbNLI1zdTT8hSS1prrdPud2GpYUNrh3WVBwNs66xEq0jQmDVHjX3+DKhF
 xmC6bw9mZD4qDoTAUgx1FEhmTiu8essyxPAIk2Ic2eVQR1iQf5FpCd0kZpeC9323LCQ4AKomY
 vfLiadMVIYuadOauUSqF34Tl9HpLGPWP+meTW42WettJkxSkIyi/yLRCaZlB2i7pHR0XzrTjw
 Cq7XXM3SpJvTQu3hRl7IRXUFAI0fyChieeyIbB2wqvkLE+zMGRy4vqYBMr1fUl/ugRwfc+cpV
 SL0merbPFUarMIFUZ7Jey8lgvtXqkEa7VyV8RFUEzGd7/RrwPY/+DhWgPr+YCLgaObT90w2xG
 wtL1L89mZjnn81YOIv5bP6jIXt0lipYrub7EJYxMMH15JpdU0ADmT1T5ldvoFutc3Pkal8p5Y
 J8dtSJQyYQeJlS3fIOforELqnqOxkyaTdQ0WWmXYbm3Occ8vyDwFKv/n8dy5L7Fqd0vZYNV+5
 W+/uszNEIo9OBqYkE4INiNDYqFd+aYu1gNAC7ZXgVkQz3CoKZunUoPog5g/VMGgP+fxh4HjAi
 zJb4r62U4DqDFrP5QF6AxI3uVCMPiSnLwENbQUDxlqsbeSyii6V96qaisw1/U5qchkM94r0kn
 56zkjZGV4vIQAIcgADkoZlBYQtue43EiL3WOjJ2J4w8zaAiLad6+WkRhegW2SmPnz0gdyh5ji
 QYNKtT8r1iGhiHF4pu1kB3SQOGESEDKIC41mA6nMQpDYGticy0=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 7:25 AM Guo Ren <guoren@kernel.org> wrote:
> On Thu, Jan 20, 2022 at 10:43 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thu, Jan 20, 2022 at 8:39 AM <guoren@kernel.org> wrote:

> > Are you sure these are the right calling conventions? According to [1],
> > I think the 64-bit argument should be in an aligned pair of registers,
> > which means you need an extra pad argument as in the arm64 version
> > of these functions. Same for ftruncate64, pread64, pwrite64, and
> > readahead.
>
> [1] has abandoned.
>
> See:
> https://github.com/riscv-non-isa/riscv-elf-psabi-doc/blob/master/riscv-cc.adoc

Ok, thanks for the reference, I picked the first one that came up in
a google search and didn't expect this to ever have changed.

> > I still feel like these should be the common implementations next to the
> > native handlers inside of an #ifdef CONFIG_COMPAT.
> >
> > The names clash with the custom versions defined for powerpc and sparc,
> > but the duplicates look compatible if you can account for the padded
> > argument and the lo/hi order of the pairs, so could just be removed here
> > (all other architectures use custom function names instead).
> I would try it later.

This becomes easier then, as powerpc and sparc already have the non-padded
calling conventions, so you could just generalize those without looking at
the other architectures or adding the padding. The powerpc version already
has the dual-endian version, so using that will work on big-endian sparc and
on little-endian riscv as well, though we may need to come up with a better name
for the arg_u32/arg_u64/merge_64 macros in order to put that into a global
header without namespace collisions.

         Arnd
