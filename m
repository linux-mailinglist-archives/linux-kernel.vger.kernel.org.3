Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A58E4A4062
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 11:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358297AbiAaKm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 05:42:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52609 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358150AbiAaKm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 05:42:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643625777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=waACmT46OiuhleipVSG827YMwJfmjplg9I6riihu+nY=;
        b=g5O487piP03JhzhxrlJFTgWxIwEOA3zV4h7+Gz6CzN7Mx5Or7jJDEE1ALTqUNnyaJisSNF
        aKNsgl7q8rtLFs5GiZtWJBCbg2ZTL1lnOJDByGWBK/U+eNlwdJnlcf2IG+pmeszUhcqvXt
        kX9Hmd0bPd/hU4BB3qD7Wmun7fdu7gI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-4_ijksI5MIGbCAHrGDx0YQ-1; Mon, 31 Jan 2022 05:42:55 -0500
X-MC-Unique: 4_ijksI5MIGbCAHrGDx0YQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE5B41853024;
        Mon, 31 Jan 2022 10:42:54 +0000 (UTC)
Received: from starship (unknown [10.40.192.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 52A5779593;
        Mon, 31 Jan 2022 10:42:53 +0000 (UTC)
Message-ID: <a6916dea7c771b04d8c97d25214b6918524ab9ea.camel@redhat.com>
Subject: Re: gdb switches to __sysvec_apic_timer_interrupt or
 __default_send_IPI_dest_field with KVM enabled
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Vasyl Vavrychuk <vvavrychuk@gmail.com>, qemu-discuss@nongnu.org,
        linux-kernel@vger.kernel.org, gdb@sourceware.org
Date:   Mon, 31 Jan 2022 12:42:52 +0200
In-Reply-To: <CAGj4m+4QPE7uHzbsQbG6Fp3Ke2eQRQQ2z2-1rsKDPtXqs-vpGg@mail.gmail.com>
References: <CAGj4m+4QPE7uHzbsQbG6Fp3Ke2eQRQQ2z2-1rsKDPtXqs-vpGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-01-29 at 23:06 +0200, Vasyl Vavrychuk wrote:
> Hello,
> 
> I run Linux kernel under qemu-system-x86_64 via the "-kernel" option.
> 
> Also, I added the "-s" option to accept the gdb connection.
> 
> After Linux boot up I connect with gdb and set a breakpoint in some
> function, for example "device_del", does not matter really.
> 
> The problem is if I also use "--enable-kvm", then after breakpoint
> triggered and sending "n" from gdb, it switches to
> 
>     __sysvec_apic_timer_interrupt (regs=0xffffc90000297de8) at
> arch/x86/kernel/apic/apic.c:1102
>     1102            trace_local_timer_entry(LOCAL_TIMER_VECTOR);
> 
> or to
> 
>     __default_send_IPI_dest_field (mask=<optimized out>,
> vector=<optimized out>, dest=dest@entry=2048) at
> arch/x86/kernel/apic/ipi.c:161
>     161             cfg = __prepare_ICR2(mask);
> 
> I am stepping over kernel code that does not perform any waiting or blocking.
> 
> Everything works fine with "--enable-kvm" removed.

I recently fixed that, and the code AFAIK is upstream, but probably, the qemu
side of it didn't yet made it to the release.

The problem you are seeing is that every time you single step, an interrupt
occures because you are not as fast as computer is - timer interrupt happens
like 1000 times in a second, so after each single step you do it will be pending.

That makes GDB land you in the interrupt handler, which is correct
technically but makes single stepping pretty much impossible.

The solution is to tell kernel to mask interrupts regardless
if they are masked by the guest, something that qemu even does when TCCG 
is used but was not implemented for KVM.

Best regards,
	Maxim Levitsky

PS: you might also want to patch kernel's lx-symbols gdb script to fix loadable module support,
which currently doesn't work well - I run out of time to upstream it,  I'll get to it
someday.

There problem here is that kernel's gdb script uses a breakpoint in the function that
loads modules and when it hits, it reloads gdb symbols - that is frowned upon in gdb docs,
but pretty much the only way to do it.

I patched the lx-symbols script to at least work with recent gdb, but this no doubt relies on at least some undefined
behavier in gdb, therefore I didn't push this futher.

https://patchwork.kernel.org/project/kvm/patch/20210811122927.900604-5-mlevitsk@redhat.com/



> 
> Thanks,
> Vasyl
> 


