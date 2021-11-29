Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539C7461D46
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 19:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346747AbhK2SFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 13:05:40 -0500
Received: from pegase2.c-s.fr ([93.17.235.10]:59725 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351068AbhK2SD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 13:03:29 -0500
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4J2tMd0Vyhz9sSk;
        Mon, 29 Nov 2021 18:56:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wIaaJJgUXFna; Mon, 29 Nov 2021 18:56:44 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4J2tMc6sPwz9sSQ;
        Mon, 29 Nov 2021 18:56:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DC8988B7AB;
        Mon, 29 Nov 2021 18:56:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id CSQCMsIcCIMH; Mon, 29 Nov 2021 18:56:44 +0100 (CET)
Received: from [192.168.232.92] (unknown [192.168.232.92])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 91B118B763;
        Mon, 29 Nov 2021 18:56:44 +0100 (CET)
Message-ID: <0b901c6f-9d42-11f6-4e44-df3bb1587456@csgroup.eu>
Date:   Mon, 29 Nov 2021 18:56:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] recordmcount: Support empty section from recent binutils
Content-Language: fr-FR
To:     Steven Rostedt <rostedt@goodmis.org>,
        Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <cd0f6bdfdf1ee096fb2c07e7b38940921b8e9118.1637764848.git.christophe.leroy@csgroup.eu>
 <efc0e15e-fc93-fb59-068d-602f96ec7431@csgroup.eu>
 <20211129124355.52474d90@gandalf.local.home>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20211129124355.52474d90@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 29/11/2021 à 18:43, Steven Rostedt a écrit :
> On Fri, 26 Nov 2021 08:43:23 +0000
> LEROY Christophe <christophe.leroy@csgroup.eu> wrote:
> 
>> Le 24/11/2021 à 15:43, Christophe Leroy a écrit :
>>> Looks like recent binutils (2.36 and over ?) may empty some section,
>>> leading to failure like:
>>>
>>> 	Cannot find symbol for section 11: .text.unlikely.
>>> 	kernel/kexec_file.o: failed
>>> 	make[1]: *** [scripts/Makefile.build:287: kernel/kexec_file.o] Error 1
>>>
>>> In order to avoid that, ensure that the section has a content before
>>> returning it's name in has_rel_mcount().
>>
>> This patch doesn't work, on PPC32 I get the following message with this
>> patch applied:
>>
>> [    0.000000] ftrace: No functions to be traced?
>>
>> Without the patch I get:
>>
>> [    0.000000] ftrace: allocating 22381 entries in 66 pages
>> [    0.000000] ftrace: allocated 66 pages with 2 groups
> 
> Because of this report, I have not applied this patch (even though I was
> about to push it to Linus).
> 
> I'm pulling it from my queue until this gets resolved.
> 

I have no idea on how to fix that for the moment.

With GCC 10 (binutils 2.36) an objdump -x on kernel/kexec_file.o gives:

0000000000000000 l    d  .text.unlikely	0000000000000000 .text.unlikely
0000000000000000  w    F .text.unlikely	0000000000000038 
.arch_kexec_apply_relocations_add
0000000000000038  w    F .text.unlikely	0000000000000038 
.arch_kexec_apply_relocations


With GCC 11 (binutils 2.37) the same gives:

0000000000000000  w    F .text.unlikely	0000000000000038 
.arch_kexec_apply_relocations_add
0000000000000038  w    F .text.unlikely	0000000000000038 
.arch_kexec_apply_relocations


The problem is that recordmcount drops weak symbols, and it doesn't find 
any non-weak symbol in .text.unlikely

Explication given at 
https://elixir.bootlin.com/linux/v5.16-rc2/source/scripts/recordmcount.h#L506

I have no idea on what to do.

Thanks
Christophe
