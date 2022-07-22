Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E16857E24D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 15:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbiGVN2F convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 22 Jul 2022 09:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbiGVN16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 09:27:58 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE4C89B186
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 06:27:56 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-45-ONyrBzjjM6S2RqhK5NzQ_A-1; Fri, 22 Jul 2022 14:27:53 +0100
X-MC-Unique: ONyrBzjjM6S2RqhK5NzQ_A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Fri, 22 Jul 2022 14:27:50 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Fri, 22 Jul 2022 14:27:50 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>
CC:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joao Moreira <joao@overdrivepizza.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Josh Poimboeuf" <jpoimboe@kernel.org>,
        "Cooper, Andrew" <andrew.cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "Nuzman, Joseph" <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Gross, Jurgen" <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Collingbourne <pcc@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: RE: [patch 00/38] x86/retbleed: Call depth tracking mitigation
Thread-Topic: [patch 00/38] x86/retbleed: Call depth tracking mitigation
Thread-Index: AQHYnSyhi03gNC/QIkePUsvbFv4MOq2JW8MQgADObYCAADMmIA==
Date:   Fri, 22 Jul 2022 13:27:50 +0000
Message-ID: <4a0a9639ce41498e8116dc56a9083955@AcuMS.aculab.com>
References: <CAHk-=wj6U3UamfLLV+rPu1WmKG_w3p0Bg=YbQcG1DxHpmP40Ag@mail.gmail.com>
 <YtXzgWnbTQH48JGR@worktop.programming.kicks-ass.net>
 <CAHk-=wiJNViWKCCrDPByGWmVVXuEKhRGykx4q8diXSxEqGfOMw@mail.gmail.com>
 <CAHk-=wjmUeB=_s6jcBUNoAT4GHv-aF1Mzqa6G1X4k+dcHDs1Mg@mail.gmail.com>
 <Ytbnlms90+LBLbrY@google.com>
 <Ythv7NqofIAHp3bf@worktop.programming.kicks-ass.net>
 <Ytl2vg15Hc0fh8Dl@worktop.programming.kicks-ass.net>
 <YtmTK93vHWQUFinE@worktop.programming.kicks-ass.net>
 <CAHk-=whLGENEkjME_v_3P1SwhwjzH4GK2RLA3fn=yQNuyKLBkg@mail.gmail.com>
 <d0597f7096344b10bfcd95a0ffdbad17@AcuMS.aculab.com>
 <YtqD96Kq4/Wg+LXQ@worktop.programming.kicks-ass.net>
In-Reply-To: <YtqD96Kq4/Wg+LXQ@worktop.programming.kicks-ass.net>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra
> Sent: 22 July 2022 12:03
> 
> On Thu, Jul 21, 2022 at 10:01:12PM +0000, David Laight wrote:
> 
> > Since: "If the callee is a variadic function, then the number of floating
> > point arguments passed to the function in vector registers must be provided
> > by the caller in the AL register."
> >
> > And that that never happens in the kernel you can use %eax instead
> > of %r10d.
> 
> Except there's the AMD BTC thing and we should (compiler patch seems
> MIA) have an unconditional: 'xor %eax,%eax' in front of every function
> call.

I've just read https://www.amd.com/system/files/documents/technical-guidance-for-mitigating-branch-type-confusion_v7_20220712.pdf

It doesn't seem to suggest clearing registers except as a vague
'might help' before a function return (to limit what the speculated
code can do.

The only advantage I can think of for 'xor ax,ax' is that it is done as
a register rename - and isn't dependant on older instructions.
So it might reduce some pipeline stalls.

I'm guessing that someone might find a 'gadget' that depends on %eax
and it may be possible to find somewhere that leaves an arbitrary
value in it.
It is also about the only register that isn't live!

> (The official mitigation strategy was CALL; LFENCE IIRC, but that's so
> horrible nobody is actually considering that)
> 
> Yes, the suggested sequence ends with rax being zero, but since we start
> the speculation before that result is computed that's not good enough I
> suspect.

The speculated code can't use the 'wrong' %eax value.
The only problem is that reading from -4(%r11) is likely to be a
D$ miss giving plenty of time for the cpu to execute 'crap'.
But I'm not sure a later 'xor ax,ax' helps.
(OTOH this is all horrid and makes my brian hurt.)

AFAICT with BTC you 'just lose'.
I thought it was bad enough that some cpu used the BTB for predicted
conditional jumps - but using it to decide 'this must be a branch
instruction' seems especially broken.

Seems the best thing to do with those cpu is to run an embedded
system with a busybox+buildroot userspace where almost everything
runs as root :-)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

