Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B8A4B7F31
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 05:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343608AbiBPEPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 23:15:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343562AbiBPEPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 23:15:05 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E136D84E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 20:14:53 -0800 (PST)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id B6207240002;
        Wed, 16 Feb 2022 04:14:48 +0000 (UTC)
Message-ID: <a0769218-c84a-a1d3-71e7-aefd40bf54fe@ghiti.fr>
Date:   Wed, 16 Feb 2022 05:14:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [syzbot] riscv/fixes boot error: can't ssh into the instance
Content-Language: en-US
To:     Dmitry Vyukov <dvyukov@google.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>
Cc:     Aleksandr Nogikh <nogikh@google.com>,
        linux-riscv@lists.infradead.org,
        kasan-dev <kasan-dev@googlegroups.com>, palmer@dabbelt.com,
        syzbot <syzbot+330a558d94b58f7601be@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
References: <00000000000038779505d5d8b372@google.com>
 <CANp29Y7WjwXwgxPrNq0XXjXPu+wGFqTreh9gry=O6aE7+cKpLQ@mail.gmail.com>
 <CA+zEjCvu76yW7zfM+qJUe+t5y23oPdzR4KDV1mOdqH8bB4GmTw@mail.gmail.com>
 <CACT4Y+arufrRgwmN66wUU+_FGxMy-sTkjMQnRN8U2H2tQuhB7A@mail.gmail.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <CACT4Y+arufrRgwmN66wUU+_FGxMy-sTkjMQnRN8U2H2tQuhB7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On 2/15/22 18:12, Dmitry Vyukov wrote:
> On Wed, 2 Feb 2022 at 14:18, Alexandre Ghiti
> <alexandre.ghiti@canonical.com> wrote:
>> Hi Aleksandr,
>>
>> On Wed, Feb 2, 2022 at 12:08 PM Aleksandr Nogikh <nogikh@google.com> wrote:
>>> Hello,
>>>
>>> syzbot has already not been able to fuzz its RISC-V instance for 97
>> That's a longtime, I'll take a look more regularly.
>>
>>> days now because the compiled kernel cannot boot. I bisected the issue
>>> to the following commit:
>>>
>>> commit 54c5639d8f507ebefa814f574cb6f763033a72a5
>>> Author: Alexandre Ghiti <alexandre.ghiti@canonical.com>
>>> Date:   Fri Oct 29 06:59:27 2021 +0200
>>>
>>>      riscv: Fix asan-stack clang build
>>>
>>> Apparently, the problem appears on GCC-built RISC-V kernels with KASAN
>>> enabled. In the previous message syzbot mentions
>>> "riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU
>>> Binutils for Debian) 2.35.2", but the issue also reproduces finely on
>>> a newer GCC compiler: "riscv64-linux-gnu-gcc (Debian 11.2.0-10)
>>> 11.2.0, GNU ld (GNU Binutils for Debian) 2.37".
>>> For convenience, I also duplicate the .config file from the bot's
>>> message: https://syzkaller.appspot.com/x/.config?x=522544a2e0ef2a7d
>>>
>>> Can someone with KASAN and RISC-V expertise please take a look?
>> I'll take a look at that today.
>>
>> Thanks for reporting the issue,
>

I took a quick look, not enough to fix it but I know the issue comes 
from the inline instrumentation, I have no problem with the outline 
instrumentation. I need to find some cycles to work on this, my goal is 
to fix this for 5.17.

Sorry about the delay,

Alex


>
>
>>> --
>>> Best Regards,
>>> Aleksandr
>>>
>>>
>>> On Tue, Jan 18, 2022 at 11:26 AM syzbot
>>> <syzbot+330a558d94b58f7601be@syzkaller.appspotmail.com> wrote:
>>>> Hello,
>>>>
>>>> syzbot found the following issue on:
>>>>
>>>> HEAD commit:    f6f7fbb89bf8 riscv: dts: sifive unmatched: Link the tmp451..
>>>> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=1095f85bb00000
>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=522544a2e0ef2a7d
>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=330a558d94b58f7601be
>>>> compiler:       riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>>>> userspace arch: riscv64
>>>>
>>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>>> Reported-by: syzbot+330a558d94b58f7601be@syzkaller.appspotmail.com
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
