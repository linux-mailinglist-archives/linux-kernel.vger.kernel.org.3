Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD80498D31
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 20:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbiAXT2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 14:28:43 -0500
Received: from m228-4.mailgun.net ([159.135.228.4]:44881 "EHLO
        m228-4.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348712AbiAXTTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 14:19:38 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=michaelkloos.com; q=dns/txt;
 s=k1; t=1643051978; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: From: References: Cc: To: Subject: MIME-Version: Date:
 Message-ID: Sender; bh=RTodLktL3fNAjheW8U0upEQdJu2uLplUIyzBCEj09YA=; b=cF05KFg5tyH8uIlazoZiHqScEu8+sbt3Zq7skpmpqfiuevXd5HMfQjsCb4hhzy4LKhsK/XnJ
 /4L9Js2zS2vkl8CHK9LcLbKoKTHeMMa2HYzkuZlktp3C8+TcrcXJHlyKhPVI+Lvy9cL8KCkm
 BoCMbU78FAgQHfQMZS4NzHb1K5Y=
X-Mailgun-Sending-Ip: 159.135.228.4
X-Mailgun-Sid: WyI5NjYzNiIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgIjQ4Y2MwIl0=
Received: from drop1.michaelkloos.com (drop1.michaelkloos.com
 [67.205.190.89]) by smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 61eefbb98a34df816bef9458 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Mon, 24 Jan 2022 19:19:21 GMT
Sender: michael@michaelkloos.com
Received: from [192.168.0.104] (cpe-173-88-115-50.columbus.res.rr.com [173.88.115.50])
        by drop1.michaelkloos.com (Postfix) with ESMTPSA id 661DA40266;
        Mon, 24 Jan 2022 19:19:20 +0000 (UTC)
Message-ID: <fdbf6e1c-6ed1-bb82-1a56-f7188de7f83f@michaelkloos.com>
Date:   Mon, 24 Jan 2022 14:19:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] Fixed: Misaligned memory access. Fixed pointer
 comparison.
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
Cc:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220123034518.3717116-1-michael@michaelkloos.com>
 <4fa1c4bbf27242cf9835dde0abdc89d5@AcuMS.aculab.com>
From:   "Michael T. Kloos" <michael@michaelkloos.com>
In-Reply-To: <4fa1c4bbf27242cf9835dde0abdc89d5@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> That may not be true.
> On x86 the cost of misaligned accesses only just measurable.
> It isn't even one clock per cache line for reads (eg ipcsum).
I know that the Intel manuals still recommend alignment on x86.  I
haven't tried to measure performance differences yet.

I think the issue here is that RISC-V is designed as a modular
architecture.  Unlike x86, we don't know that misaligned accesses
will or will not be supported.  I will grant you that if they are
supported by hardware, it will probably be faster to let the hardware
natively take care of it.  However, if the hardware doesn't support
it, the kernel won't be compatible with that hardware.

Now this could be worked around by having the firmware emulate it.
This is not specified in the RISC-V SBI spec.  So depending on this
would mean that the Linux kernel needs additional support from the
firmware than the bare SBI specifies.  The counter argument for this
is that it is a hardware implementation detail and that the firmware
should therefore handle the translation.  This is already the case
for the time CSRs where the CSRs are implemented in memory rather
than as CSRs.  However I don't think that this can be considered 
the same thing as memory accesses, which in my opinion, are a much
more common and primitive operation.  The RISC-V Privileged spec
also lists the time CSRs with the associated CSR addresses.
The CSRs provide needed special functionality that can not be
achieved without specific driver support for alternative
implementations.  I would consider memory accesses and the stuff
controlled by CSRs to be in very different categories.  Memory 
accesses are considered a basic part of a program, listed in the
base rv32i implementation specs.

Firmware emulation would also be dramatically slower.  We are
talking about trapping the exception, saving context, determining
cause, checking permissions, emulating behavior, restoring context,
and finally returning from the trap.  I would be strongly opposed to
requiring this for misaligned memory accesses where the hardware
doesn't support it.  It is likely that we are already dealing with
slower, less capable hardware in that case anyway.  So I would not
recommend adding the additional overhead.

If people are strongly in favor of allowing native handing of
misaligned memory accesses, a possible compromise is the addition
of a CONFIG option such as "Allow Kernel Misaligned Memory Access",
probably under the "Platform Type" section in menuconfig.  This
could be enabled for hardware which supported it, turning on
alternative code-paths that didn't care about alignment, allowing
the hardware or firmware to handle it as needed.  I would
recommend, at least until RISC-V hardware matures, this CONFIG
option default to disabled.

Anyone who has feedback on this, please let me know.

> If the performance of misaligned copies ever matters it is probably
> better to use:
> 	*dst++ = src[0] >> n | src[1] << (64 - n);
> for the body of the misaligned loop.
> You can always read the aligned src[] even if outside the buffer.
> So the only difficult part is writing the odd bytes
> and getting 'n' and the direction of the shifts right!
I had considered this.  I wondered if it would really be faster due
to the additional instructions required on each iteration and avoided
shifts due to the possible use of a barrel shifter vs a clocked shift
register in hardware.  But you are probably correct.  It would
probably still be faster.  Using that instead would also greatly
simplify my code since I wouldn't need a bunch of different loops
for each level of granularity.  I would just do it at the native
XLEN size.  I'll start working on this change.

	Michael

On 1/24/22 04:21, David Laight wrote:

> From: michael@michaelkloos.com
>> Sent: 23 January 2022 03:45
>>
>> Rewrote the riscv memmove() assembly implementation.  The
>> previous implementation did not check memory alignment and it
>> compared 2 pointers with a signed comparison.  The misaligned
>> memory access would cause the kernel to crash on systems that
>> did not emulate it in firmware and did not support it in hardware.
>> Firmware emulation is slow and may not exist.  Additionally,
>> hardware support may not exist and would likely still run slower
>> than aligned accesses even if it did.
> That may not be true.
> On x86 the cost of misaligned accesses only just measurable.
> It isn't even one clock per cache line for reads (eg ipcsum).
>
>> The RISC-V spec does not
>> guarantee that support for misaligned memory accesses will exist.
>> It should not be depended on.
>>
>> This patch now checks for the maximum granularity of co-alignment
>> between the pointers and copies them with that, using single-byte
>> copy for any unaligned data at their terminations.  It also now uses
>> unsigned comparison for the pointers.
> If the performance of misaligned copies ever matters it is probably
> better to use:
> 	*dst++ = src[0] >> n | src[1] << (64 - n);
> for the body of the misaligned loop.
> You can always read the aligned src[] even if outside the buffer.
> So the only difficult part is writing the odd bytes
> and getting 'n' and the direction of the shifts right!
>
> 	David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>
