Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB87527074
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 12:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbiENKAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 06:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbiENKAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 06:00:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF2D3E0C5
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 03:00:29 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652522427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r2r8Dhwt+P9oHmhE2QNEFdOczht/CbbzdZrk8SRBVls=;
        b=zdsW6aQXqr/phm3mkPZpI6reAnroeq6p5pd6LswaQwwdRUuDnFJEHmdTCVK/jBHN6tLl1m
        wYNCYjnMoJgZRZYf+TxyeZP+N29uTAoe5rrP17g5glsSr6UBmV/Sl/0flpLmcFpqjdrHtC
        MAFDwgRm54RyzZ8ltgG56002crsTNz4OOvvHTtuk0PZ2MRW1uJAgwtIHqLwlET4A0FphAi
        Z9EkOJXG1WeeW5sJpJd259t0tUh4dJ/B5q4kmism91bzcu4pZZXBUjRgkoRb8xrJMifsIT
        t/mUzFchBacEFcFWn4LlHdbBaprz+JRKSX+7qsuIj8mwX9ey8esB5oIgGzSnVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652522427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r2r8Dhwt+P9oHmhE2QNEFdOczht/CbbzdZrk8SRBVls=;
        b=pDDJjVOGt+lkMXz8zCE0A3goezFNggKNl1iLjY+BkZKKzMl/WjHOAMJkxiKxBKga5O1Iwz
        lcjcfOGvXBrrlLAg==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFCv2 00/10] Linear Address Masking enabling
In-Reply-To: <20220513230123.wmb4ia3r72snfpwj@black.fi.intel.com>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511064943.GR76023@worktop.programming.kicks-ass.net>
 <20bada85-9203-57f4-2502-57a6fd11f3ea@intel.com> <875ymav8ul.ffs@tglx>
 <55176b79-90af-4a47-dc06-9f5f2f2c123d@intel.com>
 <CAG_fn=URUve59ZPWRawW+BN-bUy7U3QmFsfOz_7L8ndsL4kQFQ@mail.gmail.com>
 <20220513230123.wmb4ia3r72snfpwj@black.fi.intel.com>
Date:   Sat, 14 May 2022 12:00:27 +0200
Message-ID: <87ee0wsabo.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14 2022 at 02:01, Kirill A. Shutemov wrote:
> On Fri, May 13, 2022 at 01:07:43PM +0200, Alexander Potapenko wrote:
>> On Thu, May 12, 2022 at 11:51 PM Dave Hansen <dave.hansen@intel.com> wrote:
>> >
>> > On 5/12/22 12:39, Thomas Gleixner wrote:
>> > >> It's OK for a debugging build that runs on one kind of hardware.  But,
>> > >> if we want LAM-using binaries to be portable, we have to do something
>> > >> different.
>> > >>
>> > >> One of the stated reasons for adding LAM hardware is that folks want to
>> > >> use sanitizers outside of debugging environments.  To me, that means
>> > >> that LAM is something that the same binary might run with or without.
>> > > On/off yes, but is there an actual use case where such a mechanism would
>> > > at start time dynamically chose the number of bits?
>> >
>> > I'd love to hear from folks doing the userspace side of this.  Will
>> > userspace be saying: "Give me all the bits you can!".  Or, will it
>> > really just be looking for 6 bits only, and it doesn't care whether it
>> > gets 6 or 15, it will use only 6?
>> 
>> (speaking more or less on behalf of the userspace folks here)
>> I think it is safe to assume that in the upcoming year or two HWASan
>> will be fine having just 6 bits for the tags on x86 machines.
>> We are interested in running it on kernels with and without
>> CONFIG_X86_5LEVEL=y, so U48 is not an option in some cases anyway.
>
> Just to be clear: LAM_U48 works on machine with 5-level paging enabled as
> long as the process doesn't map anything above 47-bit.

That's the whole point. If you use LAM_U48 in one thread for some
obscure reason, you prevent the whole process from utilizing the full
virtual address space. The other way round is also weird. If one thread
manages to have a virtual address above bit 47 then you can't get U48
for the other anymore.

Aside of that the whole per-thread approach can only ever work when an
application is crafted carefully to handle it. Think about shared data
structures with pointers inside. This surely can be made work, but is it
something which is generally safe? No.

Plus it comes with inconsistent behaviour in the kthread_use_mm() case.

What could work is a mechanism which tells the loader that it should apply
U48 and restrict the address space randomization to 47 bits, but
anything else is going to create more problems than it solves.

Thanks,

        tglx


