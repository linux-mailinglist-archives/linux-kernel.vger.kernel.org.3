Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F352B536B8D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 10:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbiE1IDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 04:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiE1IDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 04:03:32 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62284219
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 01:03:29 -0700 (PDT)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id DCC9E24000A;
        Sat, 28 May 2022 08:03:23 +0000 (UTC)
Message-ID: <fcb6d1aa-78bb-cfad-7655-cbab59f8d5c3@ghiti.fr>
Date:   Sat, 28 May 2022 10:03:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [syzbot] riscv/fixes test error: lost connection to test machine
Content-Language: en-US
To:     Dmitry Vyukov <dvyukov@google.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>
Cc:     syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+2c5da6a0a16a0c4f34aa@syzkaller.appspotmail.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
References: <000000000000d0437b05dffdd1de@google.com>
 <CACT4Y+Y8DOKJtwhRsyNT7G26C3Fx_oeibpXn43Ks0RtYYdZG3g@mail.gmail.com>
 <36f4745f-0e47-4f49-8f4e-ff7544f163d8n@googlegroups.com>
 <CACT4Y+Zy7wLdeRCa+ZH-swo9ut=U6pEk4rP461QE1m-gT6s-uQ@mail.gmail.com>
 <a55430c3-a0bc-4af6-b7e2-20f2e0d091b2n@googlegroups.com>
 <CACT4Y+ar18tcxx0tOthV0JBrmWsLXtXAjXVFX4sac5k1UGJ7Lw@mail.gmail.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <CACT4Y+ar18tcxx0tOthV0JBrmWsLXtXAjXVFX4sac5k1UGJ7Lw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/22 19:04, Dmitry Vyukov wrote:
> On Fri, 27 May 2022 at 16:01, Alexandre Ghiti
> <alexandre.ghiti@canonical.com> wrote:
>> On Friday, May 27, 2022 at 3:55:24 PM UTC+2 Dmitry Vyukov wrote:
>>> On Fri, 27 May 2022 at 15:50, Alexandre Ghiti
>>> <alexand...@canonical.com> wrote:
>>>> On Friday, May 27, 2022 at 3:02:01 PM UTC+2 Dmitry Vyukov wrote:
>>>>> On Fri, 27 May 2022 at 14:55, syzbot
>>>>> <syzbot+2c5da6...@syzkaller.appspotmail.com> wrote:
>>>>>> Hello,
>>>>>>
>>>>>> syzbot found the following issue on:
>>>>>>
>>>>>> HEAD commit: c932edeaf6d6 riscv: dts: microchip: fix gpio1 reg property..
>>>>>> git tree: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
>>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=1418add5f00000
>>>>>> kernel config: https://syzkaller.appspot.com/x/.config?x=aa6b5702bdf14a17
>>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=2c5da6a0a16a0c4f34aa
>>>>>> compiler: riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>>>>>> userspace arch: riscv64
>>>>>>
>>>>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>>>>> Reported-by: syzbot+2c5da6...@syzkaller.appspotmail.com
>>>>> The CONFIG_KASAN_VMALLOC allows riscv kernel to boot, but now Go
>>>>> processes started crashing with:
>>>>>
>>>>> 1970/01/01 00:06:55 fuzzer started
>>>>> runtime: lfstack.push invalid packing: node=0xffffff5908a940 cnt=0x1
>>>>> packed=0xffff5908a9400001 -> node=0xffff5908a940
>>>>> fatal error: lfstack.push
>>>>> runtime stack:
>>>>> runtime.throw({0x30884c, 0xc})
>>>>> /usr/local/go/src/runtime/panic.go:1198 +0x60
>>>>> runtime.(*lfstack).push(0xdb3850, 0xffffff5908a940)
>>>>> /usr/local/go/src/runtime/lfstack.go:30 +0x1a8
>>>>>
>>>>> Go runtime tries to shove some data into the upper 16 bits of pointers
>>>>> assuming they are unused.
>>>>> However, the original pointer node=0xffffff5908a940 suggest riscv now
>>>>> has 56-bit users-space address space?
>>>>
>>>> Yes, sv57 was merged recently.
>>>>
>>>>> Documentation/riscv/vm-layout.rst claims 48-bit pointers:
>>>>> "
>>>>> The RISC-V privileged architecture document states that the 64bit addresses
>>>>> "must have bits 63–48 all equal to bit 47, or else a page-fault exception will
>>>>> occur.":
>>>>
>>>> Thanks for pointing that, I extracted that from the specification before sv57 was specified, I'll fix that.
>>>>
>>>> The current kernel code will use sv57 as it is supported and advertised by qemu, and to my knowledge, you can't downgrade to sv48 unless by re-compiling qemu using the following:
>>>>
>>>> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>>>> index 6dbe9b541f..a64b50ed75 100644
>>>> --- a/target/riscv/csr.c
>>>> +++ b/target/riscv/csr.c
>>>> @@ -637,7 +637,7 @@ static const char valid_vm_1_10_64[16] = {
>>>> [VM_1_10_MBARE] = 1,
>>>> [VM_1_10_SV39] = 1,
>>>> [VM_1_10_SV48] = 1,
>>>> - [VM_1_10_SV57] = 1
>>>> + [VM_1_10_SV57] = 0
>>>> };
>>>>
>>>> /* Machine Information Registers */
>>>>
>>>>> ...
>>>>> 0000000000000000 | 0 | 0000003fffffffff | 256 GB |
>>>>> user-space virtual memory, different per mm
>>>>> "
>>> There is no kernel config to force SV48/39, right?
>>
>> No, we rely on what the hardware advertises, if it supports sv57, we'll go for sv57, if not, we'll try sv48...etc. I had some patches to force the downgrade by using the device tree but they never got merged though.
> +original CC list
>
> FTR sent Go runtime change to support SV57:
> https://go-review.googlesource.com/c/go/+/409055


Thank you for that, I'll pull that into Ubuntu when merged. Do you know 
if any other programming language does the same and would need a fix too?


>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
