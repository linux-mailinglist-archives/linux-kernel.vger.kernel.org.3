Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2846946360A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241989AbhK3OJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:09:36 -0500
Received: from pegase2.c-s.fr ([93.17.235.10]:38695 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236182AbhK3OJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:09:35 -0500
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4J3PCB6cJjz9sSB;
        Tue, 30 Nov 2021 15:06:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LQKXb2njL5qF; Tue, 30 Nov 2021 15:06:14 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4J3PCB5PW1z9sS9;
        Tue, 30 Nov 2021 15:06:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A8A3B8B77A;
        Tue, 30 Nov 2021 15:06:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id I-eqQ3NtGZFL; Tue, 30 Nov 2021 15:06:14 +0100 (CET)
Received: from [192.168.232.93] (unknown [192.168.232.93])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 476CC8B763;
        Tue, 30 Nov 2021 15:06:14 +0100 (CET)
Message-ID: <c8cbdc08-f37f-5be5-f9ca-68fcd2dc1621@csgroup.eu>
Date:   Tue, 30 Nov 2021 15:06:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] powerpc/powermac: Add missing lockdep_register_key()
Content-Language: fr-FR
To:     "Erhard F." <erhard_f@mailbox.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <69e4f55565bb45ebb0843977801b245af0c666fe.1638264741.git.christophe.leroy@csgroup.eu>
 <20211130145318.5fcdf633@yea>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20211130145318.5fcdf633@yea>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 30/11/2021 à 14:53, Erhard F. a écrit :
> On Tue, 30 Nov 2021 10:32:42 +0100
> Christophe Leroy <christophe.leroy@csgroup.eu> wrote:
> 
>> KeyWest i2c @0xf8001003 irq 42 /uni-n@f8000000/i2c@f8001000
>> BUG: key c2d00cbc has not been registered!
>> ------------[ cut here ]------------
>> DEBUG_LOCKS_WARN_ON(1)
>> WARNING: CPU: 0 PID: 1 at kernel/locking/lockdep.c:4801 lockdep_init_map_type+0x4c0/0xb4c
>> Modules linked in:
>> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.15.5-gentoo-PowerMacG4 #9
>> NIP:  c01a9428 LR: c01a9428 CTR: 00000000
>> REGS: e1033cf0 TRAP: 0700   Not tainted  (5.15.5-gentoo-PowerMacG4)
>> MSR:  00029032 <EE,ME,IR,DR,RI>  CR: 24002002  XER: 00000000
>>
>> GPR00: c01a9428 e1033db0 c2d1cf20 00000016 00000004 00000001 c01c0630 e1033a73
>> GPR08: 00000000 00000000 00000000 e1033db0 24002004 00000000 f8729377 00000003
>> GPR16: c1829a9c 00000000 18305357 c1416fc0 c1416f80 c006ac60 c2d00ca8 c1416f00
>> GPR24: 00000000 c21586f0 c2160000 00000000 c2d00cbc c2170000 c216e1a0 c2160000
>> NIP [c01a9428] lockdep_init_map_type+0x4c0/0xb4c
>> LR [c01a9428] lockdep_init_map_type+0x4c0/0xb4c
>> Call Trace:
>> [e1033db0] [c01a9428] lockdep_init_map_type+0x4c0/0xb4c (unreliable)
>> [e1033df0] [c1c177b8] kw_i2c_add+0x334/0x424
>> [e1033e20] [c1c18294] pmac_i2c_init+0x9ec/0xa9c
>> [e1033e80] [c1c1a790] smp_core99_probe+0xbc/0x35c
>> [e1033eb0] [c1c03cb0] kernel_init_freeable+0x190/0x5a4
>> [e1033f10] [c000946c] kernel_init+0x28/0x154
>> [e1033f30] [c0035148] ret_from_kernel_thread+0x14/0x1c
>>
>> Add missing lockdep_register_key()
>>
>> Reported-by: Erhard Furtner <erhard_f@mailbox.org>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>   arch/powerpc/platforms/powermac/low_i2c.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
>> index f77a59b5c2e1..de34fa34c42d 100644
>> --- a/arch/powerpc/platforms/powermac/low_i2c.c
>> +++ b/arch/powerpc/platforms/powermac/low_i2c.c
>> @@ -582,6 +582,7 @@ static void __init kw_i2c_add(struct pmac_i2c_host_kw *host,
>>   	bus->close = kw_i2c_close;
>>   	bus->xfer = kw_i2c_xfer;
>>   	mutex_init(&bus->mutex);
>> +	lockdep_register_key(&bus->lock_key);
>>   	lockdep_set_class(&bus->mutex, &bus->lock_key);
>>   	if (controller == busnode)
>>   		bus->flags = pmac_i2c_multibus;
>> -- 
>> 2.33.1
>>
> 
> The patch applied on 5.15.5 but unfortunately was not enough to fix the lockdep bug.
> 
> Originally was bug #200055 (https://bugzilla.kernel.org/show_bug.cgi?id=200055).
> 

Is that still exactly the same backtrace , ie still pointing to 
kw_i2c_add() ?

Because I see from original bug that in fact the offending commit added 
lockdep_set_class() at 3 places. So it is likely that 
lockdep_register_key() also needs to be added at the two other places.

So if the call trace now gives pmu_i2c_probe() or smu_i2c_probe() then 
you could try and add lockdep_register_key() also there and see if it 
fixes things.

Christophe
