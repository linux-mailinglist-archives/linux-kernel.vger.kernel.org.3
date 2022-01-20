Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77EC94950AE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 15:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357807AbiATO5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 09:57:49 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:42733 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356745AbiATO5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 09:57:47 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MHndY-1n7lap2Jvi-00Es1l; Thu, 20 Jan 2022 15:57:45 +0100
Received: by mail-oi1-f181.google.com with SMTP id t9so9168099oie.12;
        Thu, 20 Jan 2022 06:57:44 -0800 (PST)
X-Gm-Message-State: AOAM532ur7kb+ZJ3gkm0JgO0s8P5UWnOgJaBPq7evKhod0Uk0ONZn2C/
        nXJDWfIBAjEUHqIChtcKEYQKjBJDBXi85nHgFSY=
X-Google-Smtp-Source: ABdhPJwjtLdN6iyHNeRuxhdvl9Y6OeJzbUgAsOZS1tuaBlnRH/pfBDfrQe9jdzUZRHtHuLOgUQesyOgPAeGaNPDH+P4=
X-Received: by 2002:a05:6808:9a:: with SMTP id s26mr7926312oic.108.1642690663723;
 Thu, 20 Jan 2022 06:57:43 -0800 (PST)
MIME-Version: 1.0
References: <20220120073911.99857-8-guoren@kernel.org> <CAK8P3a1UvqsS-D7cVXBkp4KCRWDfquQ6QTkvrQ=FqLxhsAi7Rw@mail.gmail.com>
 <f16cf10425a14c2e8183d5c90667ce72@AcuMS.aculab.com> <CAJF2gTRwh40xDBkoRJWZEUketKFDAy7_z=-WW7E=T46yH4zPvw@mail.gmail.com>
In-Reply-To: <CAJF2gTRwh40xDBkoRJWZEUketKFDAy7_z=-WW7E=T46yH4zPvw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 20 Jan 2022 15:57:27 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3FLnqibdXCGR8c+mm92HSiuvocZDeW8MyoTO_L1sYT=w@mail.gmail.com>
Message-ID: <CAK8P3a3FLnqibdXCGR8c+mm92HSiuvocZDeW8MyoTO_L1sYT=w@mail.gmail.com>
Subject: Re: [PATCH V3 07/17] riscv: compat: Re-implement TASK_SIZE for COMPAT_32BIT
To:     Guo Ren <guoren@kernel.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "inux-parisc@vger.kernel.org" <inux-parisc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ebq+f8qblaxd9E/WdJgeKxnEvzsD5T+KESng71vOs/CWvdRMDlH
 NkzD0RmyN8eSV4KFIA7QtXifTjrQqboztxcBuvgGrnrhQyc3CXAiweVRT3N4SGZbkQpU1RK
 c/MQoab7YcK4IKxNzDnIBOEcQSW/NfJtQzz03FrWhfbjodQcezVr3JOKqdquhdOqrtDIJyh
 LaXQmo0QAPULP2HCb1zrQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ja7xTabe8b4=:rOkAX4N/fElJ9mRJ1qbsTv
 /CLiyFtBXVu7wVnESukj51MjR0Su+7KjNooXiyCuMsYKBa/suOX/6xED3vHQfsy5Ko73zLOPo
 JOrPPFQeqMONk3jWn7UNFkOxmP3gvynqIdzvnnAhUl+NJE9O2rXUZzMnR5cEAFswgmF4+43p1
 MH22WI0HeDMg97CbAQGQ9MEoQN81BNzhqqebKpT7g8a4crXrzb1UDVmZFg5kaMI6X05Rq+yJZ
 V27Ws40orOduuzBVb9/XePF3WrNLMsJU8H6IT+pn6bVcOlC6hOu8FOWudLprPT3s65NPNmkAq
 drGEG4WFOei0mj2R8t5rxicizUmHC6I+Z3vShqSnSw3KcCICpmExzUSvCqWtP+ZgK0Yqz/cbS
 BWvifAK/rjqJj/QAVvfpdNdQNl422rx5XOhO1ftmUMkS6MK7QRW3qKx+YMizyavtJatszuOmN
 Ef1wzw5neeRaeJuJiFBcEbTTJKl4uBeAsfdpiuj8QHlfbwb/8hzF8MrXKi9TgFD088+fWDjwV
 6IPf2MbZng+MWfg6BbIx9DVrqo5XgUy0K30hWcOhdpih4KfOkKhCfruICqG5hrQcVPPnQqGKj
 MX+uj4tlit+dsAnW41X9KDnEahpWqlMPKKDWPbqeAQJAaoMzN1a5XvZH0SGG9/sjbuNeO+gq1
 BGkwDsQew29OnF49WnZfzxTXOZFfTJIkDmVflXVoG0DLq6UjQ8p/yFexOKQ28RUanYvm/jp6I
 9uj4ePgs6wlM1o2NOU/BqQg9JYng+bUPaX50zsHimewZAIMGHJWrs9kHXOXrvr3AwjtPI+v68
 /34uGlgUXshE5Ckncx1XJWF/Vk+4gke4OEGECWQD5jOFxqwaVw=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 2:27 PM Guo Ren <guoren@kernel.org> wrote:
> On Thu, Jan 20, 2022 at 8:53 PM David Laight <David.Laight@aculab.com> wrote:
> > I think the x86-64 32bit compat code even puts the boundary at 4GB.
> Yes, we could give rv32 compat for 4GB with some effort. But it's unnecessary.
>
> There are no history issues for rv32, we use compat mode to reduce
> memory footprint. eg: only 64MB memory available.
>
> At end compat for 4GB is another topic, let's give the initial compat
> for 2GB support to riscv.

I think it's fine either way. Having the entire 4GB space available is nice
when you are trying to build 32-bit software natively rather then using a
cross-compiler, as you can just do it on a larger machine that supports both.

One example of software that runs into virtual memory size limitations is
the gnu linker when building large applications, but it's unlikely that you'll
actually need to run applications that run into this, while also needing to
build them natively.

Using the same limit as on native 32-bit machines can help with compatibility
of certain software, but again this is rarely a problem and I have not seen any
reports of issues with the 4GB TASK_SIZE_32 on arm64. On x86, there
is an option to use the native 3GB TASK_SIZE for compat tasks. This was
introduced to work around buggy applications a long time ago, but is
probably not used any more in practice.

       Arnd
