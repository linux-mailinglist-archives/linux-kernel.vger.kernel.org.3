Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDAD474B8C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 20:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237331AbhLNTJT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Dec 2021 14:09:19 -0500
Received: from aposti.net ([89.234.176.197]:52218 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237319AbhLNTJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 14:09:17 -0500
Date:   Tue, 14 Dec 2021 19:09:06 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/3] MIPS: boot/compressed: Disable abicalls
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        list@opendingux.net, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Message-Id: <67D44R.5C6XHAZPCYVU3@crapouillou.net>
In-Reply-To: <YbjdQfrC+EjeJjRV@archlinux-ax161>
References: <20211213224914.1501303-1-paul@crapouillou.net>
        <20211213224914.1501303-2-paul@crapouillou.net>
        <YbjdQfrC+EjeJjRV@archlinux-ax161>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

Le mar., déc. 14 2021 at 11:06:57 -0700, Nathan Chancellor 
<nathan@kernel.org> a écrit :
> On Mon, Dec 13, 2021 at 10:49:12PM +0000, Paul Cercueil wrote:
>>  Avoid complaints from Clang/LLVM by building the decompress program 
>> with
>>  -mno-abicalls.
> 
> What is the message?

ld.lld: warning: lto.tmp: linking abicalls code with non-abicalls code 
arch/mips/kernel/head.o

Cheers,
-Paul

> 
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   arch/mips/boot/compressed/Makefile | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>>  diff --git a/arch/mips/boot/compressed/Makefile 
>> b/arch/mips/boot/compressed/Makefile
>>  index f27cf31b4140..4c9ecfbb0ef4 100644
>>  --- a/arch/mips/boot/compressed/Makefile
>>  +++ b/arch/mips/boot/compressed/Makefile
>>  @@ -27,10 +27,10 @@ ifdef CONFIG_CPU_LOONGSON64
>>   KBUILD_CFLAGS := $(filter-out -march=loongson3a, $(KBUILD_CFLAGS)) 
>> -march=mips64r2
>>   endif
>> 
>>  -KBUILD_CFLAGS := $(KBUILD_CFLAGS) -D__KERNEL__ -D__DISABLE_EXPORTS 
>> \
>>  +KBUILD_CFLAGS := $(KBUILD_CFLAGS) -mno-abicalls -D__KERNEL__ 
>> -D__DISABLE_EXPORTS \
>>   	-DBOOT_HEAP_SIZE=$(BOOT_HEAP_SIZE) 
>> -D"VMLINUX_LOAD_ADDRESS_ULL=$(VMLINUX_LOAD_ADDRESS)ull"
>> 
>>  -KBUILD_AFLAGS := $(KBUILD_AFLAGS) -D__ASSEMBLY__ \
>>  +KBUILD_AFLAGS := $(KBUILD_AFLAGS) -mno-abicalls -D__ASSEMBLY__ \
>>   	-DBOOT_HEAP_SIZE=$(BOOT_HEAP_SIZE) \
>>   	-DKERNEL_ENTRY=$(VMLINUX_ENTRY_ADDRESS)
>> 
>>  --
>>  2.33.0
>> 
>> 


