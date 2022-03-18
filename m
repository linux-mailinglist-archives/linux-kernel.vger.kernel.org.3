Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994C94DE4A7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 00:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241573AbiCRXx3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 18 Mar 2022 19:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239217AbiCRXx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 19:53:26 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85D7814A900
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 16:52:05 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mtapsc-7-vQC6cHK1MJW3GTkXq5uV1A-1; Fri, 18 Mar 2022 23:52:02 +0000
X-MC-Unique: vQC6cHK1MJW3GTkXq5uV1A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Fri, 18 Mar 2022 23:52:02 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Fri, 18 Mar 2022 23:52:01 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Segher Boessenkool' <segher@kernel.crashing.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Bill Wendling <morbo@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Juergen Gross" <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Andy Lutomirski" <luto@kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-toolchains <linux-toolchains@vger.kernel.org>
Subject: RE: [PATCH v5] x86: use builtins to read eflags
Thread-Topic: [PATCH v5] x86: use builtins to read eflags
Thread-Index: AQHYOxyCBe9clLf+8ESM+1cEdgpAzqzFyeaQ
Date:   Fri, 18 Mar 2022 23:52:01 +0000
Message-ID: <04f65d1a90f640d4943c810f37016b01@AcuMS.aculab.com>
References: <20220210223134.233757-1-morbo@google.com>
 <20220301201903.4113977-1-morbo@google.com>
 <CAGG=3QWh90r5C3gmTj9zxiJb-mwD=PGqGwZZTjAfyi1NCb1_9w@mail.gmail.com>
 <AC3D873E-A28B-41F1-8BF4-2F6F37BCEEB4@zytor.com>
 <CAGG=3QVu5QjQK8m2FWiYn-XQuVBjUGXcbznSbK22jVMB5GAutw@mail.gmail.com>
 <F5296439-4CA3-4F31-BD91-5ED1510BC382@zytor.com>
 <CAKwvOdkk-C8HMemKs4+yoxvNDgTLmvZG1rmwjVXBqhsQ-cED5g@mail.gmail.com>
 <CAHk-=whJfKN8Jag=8DS=pbZR3TY90znUOP6Km+TLRJ9dZEgNqw@mail.gmail.com>
 <fd89333f-e470-a295-baf6-a736c55caeb5@citrix.com>
 <CAHk-=wj47CG0Y9GOFmGg4AYFvXhRFDX9x7E2Uxo9k-UX2wgR4g@mail.gmail.com>
 <20220318230425.GT614@gate.crashing.org>
In-Reply-To: <20220318230425.GT614@gate.crashing.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Segher Boessenkool
> Sent: 18 March 2022 23:04
...
> The vast majority of compiler builtins are for simple transformations
> that the machine can do, for example with vector instructions.  Using
> such builtins does *not* instruct the compiler to use those machine
> insns, even if the builtin name would suggest that; instead, it asks to
> have code generated that has such semantics.  So it can be optimised by
> the compiler, much more than what can be done with inline asm.

Bah.
I wrote some small functions to convert blocks of 80 audio
samples between C 'float' and the 8-bit u-law and A-law floating
point formats - one set use the F16C conversions for denormalised
values.
I really want the instructions I've asked for in the order
I've asked for them.
I don't want the compiler doing stupid things.
(Like deciding to try to vectorise the bit of code at the end
that handled non 80 byte blocks.)

> It also can be optimised better by the compiler than if you would
> open-code the transforms (if you ask to frobnicate something, the
> compiler will know you want to frobnicate that thing, and it will not
> always recognise that is what you want if you just write it out in more
> general code).

Yep.
If I write 'for (i = 0; i < n; i++) foo[i] = bar[i]'
I want a loop - not a call to memcpy().
If I want a memcpy() I'll call memcpy().

And if I write:
	do {
		sum64a += buff32[0];
		sum64b += buff32[1];
		sum64a += buff32[2];
		sum64b += buff32[3];
		buff += 4;
	} while (buff != lim);
I don't want to see 'buff[1] + buff[2]' anywhere!
That loop has half a chance of running at 8 bytes/clock.
But not how gcc compiles it.

> Well-chosen builtin names are also much more readable than the best
> inline asm can ever be, and it can express much more in a much smaller
> space, without so much opportunity to make mistakes, either.

Hmmm...
Trying to write that SSE2/AVX code was a nightmare.
Chase through the cpu instruction set trying to sort out
the name of the required instruction.
Then search through the 'intrinsic' header to find the
name of the builtin.
Then disassemble the code to check the I'd got the right one.
I'm pretty sure the asm would have been shorter
and needed just as many comments.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

