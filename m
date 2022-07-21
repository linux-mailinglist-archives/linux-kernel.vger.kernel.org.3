Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B28A57C3C8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 07:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiGUFit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 01:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiGUFis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 01:38:48 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD7C30F67
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 22:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1658381922; bh=j+rA8aG+kQUXpuMbzX1iQ2xDoWFCvZ/8ALjoVajgI+U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=D+daAD6j6jHm2a4Gm1ueSnGVZ2mZkK6LnELuC6OQM4NdSQV6x3LWnNm2jQVqc2EuF
         QBcAQMcKh79EuXkOSzx9xzntpY+DvcYU8xHoT2MLm/8N0/qKdqfdS9SSZIQNnrRGXr
         OfWk5UE1U8Tf2oow1BeKF3KBW2OiY0FTFBO8hu1o=
Received: from [100.100.35.250] (unknown [58.34.185.106])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id A8D9A60104;
        Thu, 21 Jul 2022 13:38:42 +0800 (CST)
Message-ID: <4a8f5963-28f1-7439-9b52-7084d51707b2@xen0n.name>
Date:   Thu, 21 Jul 2022 13:38:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:104.0)
 Gecko/20100101 Thunderbird/104.0a1
Subject: Re: [PATCH] LoongArch: Remove unused header compiler.h
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Jun Yi <yijun@loongson.cn>, loongarch@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20220721021127.1086628-1-yijun@loongson.cn>
 <CAAhV-H4YL-8tj+-329tWguwxrPaL7DpiTT2QkXBPh_feT7M5jA@mail.gmail.com>
 <dcfac9ad-d6e0-b157-4f11-cc2d3e2f1376@xen0n.name>
 <CAAhV-H6RGZwKjV4Shm9fvH_XJ1+yqq9KpxkXNEWwOaPRmahSLQ@mail.gmail.com>
Content-Language: en-US
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <CAAhV-H6RGZwKjV4Shm9fvH_XJ1+yqq9KpxkXNEWwOaPRmahSLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/21 11:22, Huacai Chen wrote:
> Hi, Xuerui,
>
> On Thu, Jul 21, 2022 at 11:17 AM WANG Xuerui <kernel@xen0n.name> wrote:
>> Hi YI Jun and Huacai,
>>
>> On 2022/7/21 10:52, Huacai Chen wrote:
>>> Hi, Jun,
>>>
>>> On Thu, Jul 21, 2022 at 10:11 AM Jun Yi <yijun@loongson.cn> wrote:
>>>> Loongarch not used arch-specific compiler.h
>>> I'm not sure whether compiler.h will be used in future. If it will be
>>> used, I want to keep it as is. Xuerui, what do you think about it?
>> I surveyed all the existing arch compiler.h in the tree:
>>
>> $ find ./arch -name compiler.h
>> ./arch/alpha/include/asm/compiler.h
>> ./arch/alpha/include/uapi/asm/compiler.h
>> ./arch/arm/include/asm/compiler.h
>> ./arch/arm64/include/asm/compiler.h
>> ./arch/mips/include/asm/compiler.h
>> ./arch/loongarch/include/asm/compiler.h
>>
>> Of all these occurrences:
>>
>> - alpha needs to ensure a certain insn is being emitted from time to
>> time, with plain C constructs (or built-ins) on compiler versions with
>> said support, falling back to inline asm otherwise;
>> - arm and arm64 both need some inline assembly help (of different sort),
>> with arm64 stuffing some pointer authentication helpers into this file too;
>> - mips, which is obviously what the loongarch version is based on, needs
>> (1) a kludge for older compilers to fix delay slot filling around
>> __builtin_unreachable, (2) definitions for explicit arch level
>> selection. There is also the historical GCC_OFF_SMALL_ASM() constraint
>> definition that was rendered redundant by commit 4abaacc704729 ("MIPS:
>> remove GCC < 4.9 support").
>>
>> For loongarch, the "ZC" constraint (I don't think it was a coincidence
>> BTW) should be usable for all present and future hardware, so I do think
>> the GCC_OFF_SMALL_ASM() here is redundant. We may want to remove the
>> mips one too. And the arch level thing is not currently needed either,
>> future revisions to the LoongArch ISA should be largely backwards
>> compatible, so it could be a long time before such explicit selection of
>> arch level is necessary, for exact control over emitted insn.
>>
>> So overall, I'm in favor of removing this header for now.
> Have you considered the new relocation types will be added in the near
> future? I think we need compiler.h at that time.

I assume you mean the proposal being discussed at [1] [2] and [3].

For new reloc types that affect module loading, asm/elf.h and 
kernel/module.c need modification to add awareness, but this doesn't 
involve compiler.h. The kernel image itself is not affected.

There is also the case of building LoongArch kernel sources without 
support for the new reloc types, but on a newer compiler that emits the 
new-style reloc records by default. In this case, a switch reverting the 
compiler to the old-style relocs is needed in CFLAGS, but (1) not all 
essential support are merged for LoongArch so practically we don't need 
to care about non-kernel-ABI compatibility at this time, and (2) CFLAGS 
tweaks don't involve compiler.h either.

[1]: https://sourceware.org/pipermail/binutils/2022-July/121849.html
[2]: https://sourceware.org/pipermail/binutils/2022-July/121933.html
[3]: https://github.com/loongson/LoongArch-Documentation/pull/57

