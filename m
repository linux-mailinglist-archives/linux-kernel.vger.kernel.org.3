Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC654A3202
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 22:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353229AbiA2VHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 16:07:49 -0500
Received: from m228-6.mailgun.net ([159.135.228.6]:44178 "EHLO
        m228-6.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346309AbiA2VHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 16:07:47 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=michaelkloos.com; q=dns/txt;
 s=k1; t=1643490466; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: From: References: Cc: To: Subject: MIME-Version: Date:
 Message-ID: Sender; bh=P7sy/Shl3iMY8p2MiNdl8zwqcGVIL54qKlYqjHUdWU0=; b=bsnRwHs9JfOqFEUpXhKpKgnFT3u8ofSIl260wu2CIRRek7Qj4+qbOQz9P73maT0i/JdrznAz
 eGWnKEm4rBtJ6ntF3uWHYYcoosE9d7ycmZTPCa1S0UUQFCqPGhY2vrYgkhDYiuczjejWLD6m
 4fdWII1YMmo9Dk11ORpyTyFUzPA=
X-Mailgun-Sending-Ip: 159.135.228.6
X-Mailgun-Sid: WyI5NjYzNiIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgIjQ4Y2MwIl0=
Received: from drop1.michaelkloos.com (drop1.michaelkloos.com
 [67.205.190.89]) by smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 61f5aca162864ab101bbda4e (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Sat, 29 Jan 2022 21:07:45 GMT
Sender: michael@michaelkloos.com
Received: from [192.168.0.104] (cpe-173-88-115-50.columbus.res.rr.com [173.88.115.50])
        by drop1.michaelkloos.com (Postfix) with ESMTPSA id 02C3F40249;
        Sat, 29 Jan 2022 21:07:44 +0000 (UTC)
Message-ID: <548c3f3a-bb32-6c7e-3eb2-850a512ed489@michaelkloos.com>
Date:   Sat, 29 Jan 2022 16:07:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4] riscv: Fixed misaligned memory access. Fixed pointer
 comparison.
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220129022448.37483-1-michael@michaelkloos.com>
 <7ef35550b4dd44ffabfd7ca1e0ee27fa@AcuMS.aculab.com>
From:   "Michael T. Kloos" <michael@michaelkloos.com>
In-Reply-To: <7ef35550b4dd44ffabfd7ca1e0ee27fa@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your feedback David.

> No point jumping to a conditional branch that jumps bak
> Make this a:
> 	bne	t3, t6, 1b
> and move 1: down one instruction.
> (Or is the 'beq' at the top even possible - there is likely to
> be an earlier test for zero length copies.)
There are 2 checks for length.  One returns if zero.  The other 
limits the copy to byte-copy if it is below SZREG.  It is possible 
for the 'beq' to be true on the first attempt.

This would happen with something like "memmove(0x02, 0x13, 5)" on 
32-bit.  At no point would there be the ability to do a full 
register width store.  So, misaligned copy would be jumped to 
because they are not co-aligned and size is greater than or equal 
to SZREG.  The misaligned copy would first call the byte-copy 
sub-function to bring dest into natural SZREG alignment.  From 
there, the misaligned copy loop would start, but it would 
immediately break on the 'beq' being true because there are not 
SZREG bytes left to copy.  So it would jump to byte copy which 
would again try to copy any remaining unaligned bytes (if any 
exist).

One alternative is to make the previous copy length check force 
byte-copy for any size less than 2 * SZREG, instead of just SZREG.  
This would guarantee that the loop would always be able to run at 
least once before breaking.  If you think I should make this change, 
let me know.

I also gave a lot of thought when implementing the register value 
rollover so that I would not accidentally page fault in the kernel.  
I needed to make sure that those first loads, since they occur 
before those conditional checks, would not try to load from 
anywhere outside of the page boundaries.  Given that the the code 
pathway would not have been taken unless the copy length is 
greater than zero and the low bits of dest are not equal to the low 
bits of src(they are not co-aligned), we can say that bytes would 
have to have been loaded from within that SZREG aligned bound 
anyway.  And since pages are aligned at minimum to 0x1000 
boundaries, I was confident that I would be within bounds even if 
right up against the edge.

I will make the change from j to bne instructions in the applicable 
loops.


> I also suspect it is worth unrolling the loop once.
> You lose the 'mv t1, t0' and one 'addi' for each word transferred.
I'll explore this possibility, but to my previous point, I need 
to be careful about bounds checking.  Until I try to write it, I 
can't be sure if it will make sense.  I'll see what I can come up 
with.  No promises.

> I think someone mentioned that there is a few clocks delay before
> the data from the memory read (REG_L) is actually available.
> On in-order cpu this is likely to be a full pipeline stall.
> So move the 'addi' up between the 'REG_L' and 'sll' instructions.
> (The offset will need to be -SZREG to match.)
I try to keep loads as far apart as reasonable from their usage to 
avoid this.  I'll make this change in the next version of the patch.

	Michael

On 1/29/22 08:41, David Laight wrote:

> From: michael@michaelkloos.com
> ...
>> [v4]
>>
>> I could not resist implementing the optimization I mentioned in
>> my v3 notes.  I have implemented the roll over of data by cpu
>> register in the misaligned fixup copy loops.  Now, only one load
>> from memory is required per iteration of the loop.
> I nearly commented...
>
> ...
>> +	/*
>> +	 * Fix Misalignment Copy Loop.
>> +	 * load_val1 = load_ptr[0];
>> +	 * while (store_ptr != store_ptr_end) {
>> +	 *   load_val0 = load_val1;
>> +	 *   load_val1 = load_ptr[1];
>> +	 *   *store_ptr = (load_val0 >> {a6}) | (load_val1 << {a7});
>> +	 *   load_ptr++;
>> +	 *   store_ptr++;
>> +	 * }
>> +	 */
>> +	REG_L t0, 0x000(a3)
>> +	1:
>> +	beq   t3, t6, 2f
>> +	mv    t1, t0
>> +	REG_L t0, SZREG(a3)
>> +	srl   t1, t1, a6
>> +	sll   t2, t0, a7
>> +	or    t1, t1, t2
>> +	REG_S t1, 0x000(t3)
>> +	addi  a3, a3, SZREG
>> +	addi  t3, t3, SZREG
>> +	j 1b
> No point jumping to a conditional branch that jumps bak
> Make this a:
> 	bne	t3, t6, 1b
> and move 1: down one instruction.
> (Or is the 'beq' at the top even possible - there is likely to
> be an earlier test for zero length copies.)
>> +	2:
> I also suspect it is worth unrolling the loop once.
> You lose the 'mv t1, t0' and one 'addi' for each word transferred.
>
> I think someone mentioned that there is a few clocks delay before
> the data from the memory read (REG_L) is actually available.
> On in-order cpu this is likely to be a full pipeline stall.
> So move the 'addi' up between the 'REG_L' and 'sll' instructions.
> (The offset will need to be -SZREG to match.)
>
> 	David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>
