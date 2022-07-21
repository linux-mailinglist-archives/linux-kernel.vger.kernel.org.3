Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4ABA57C968
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 12:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbiGUK4w convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 21 Jul 2022 06:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiGUK4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 06:56:50 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0501E7E803
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 03:56:49 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-320-fQeKd-7MMEaPmiYsKAFFNQ-1; Thu, 21 Jul 2022 11:56:46 +0100
X-MC-Unique: fQeKd-7MMEaPmiYsKAFFNQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Thu, 21 Jul 2022 11:56:45 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Thu, 21 Jul 2022 11:56:45 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        'Sami Tolvanen' <samitolvanen@google.com>
CC:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        'Thomas Gleixner' <tglx@linutronix.de>,
        'Joao Moreira' <joao@overdrivepizza.com>,
        'LKML' <linux-kernel@vger.kernel.org>,
        'the arch/x86 maintainers' <x86@kernel.org>,
        'Tim Chen' <tim.c.chen@linux.intel.com>,
        'Josh Poimboeuf' <jpoimboe@kernel.org>,
        "'Cooper, Andrew'" <andrew.cooper3@citrix.com>,
        'Pawan Gupta' <pawan.kumar.gupta@linux.intel.com>,
        'Johannes Wikner' <kwikner@ethz.ch>,
        'Alyssa Milburn' <alyssa.milburn@linux.intel.com>,
        "'Jann Horn'" <jannh@google.com>,
        "'H.J. Lu'" <hjl.tools@gmail.com>,
        "'Moreira, Joao'" <joao.moreira@intel.com>,
        "'Nuzman, Joseph'" <joseph.nuzman@intel.com>,
        'Steven Rostedt' <rostedt@goodmis.org>,
        "'Gross, Jurgen'" <jgross@suse.com>,
        'Masami Hiramatsu' <mhiramat@kernel.org>,
        'Alexei Starovoitov' <ast@kernel.org>,
        'Daniel Borkmann' <daniel@iogearbox.net>,
        'Peter Collingbourne' <pcc@google.com>,
        'Kees Cook' <keescook@chromium.org>
Subject: RE: [patch 00/38] x86/retbleed: Call depth tracking mitigation
Thread-Topic: [patch 00/38] x86/retbleed: Call depth tracking mitigation
Thread-Index: AQHYnH2Hi03gNC/QIkePUsvbFv4MOq2Ie8qwgAAqTiA=
Date:   Thu, 21 Jul 2022 10:56:45 +0000
Message-ID: <fa299b6078b643f29fbc2ab488118491@AcuMS.aculab.com>
References: <87lesqukm5.ffs@tglx>
 <2f7f899cb75b79b08b0662ff4d2cb877@overdrivepizza.com>
 <CABCJKudvSv9bAOrDLHki5XPYNJK6=PS-x8v=E08es8w4LJpxBw@mail.gmail.com>
 <87fsiyuhyz.ffs@tglx>
 <CAHk-=wjEDJ4+xg0CWR7CaCKnO6Nhzn+vjJy7CjaVmf9R+g_3ag@mail.gmail.com>
 <CAHk-=wj6U3UamfLLV+rPu1WmKG_w3p0Bg=YbQcG1DxHpmP40Ag@mail.gmail.com>
 <YtXzgWnbTQH48JGR@worktop.programming.kicks-ass.net>
 <CAHk-=wiJNViWKCCrDPByGWmVVXuEKhRGykx4q8diXSxEqGfOMw@mail.gmail.com>
 <CAHk-=wjmUeB=_s6jcBUNoAT4GHv-aF1Mzqa6G1X4k+dcHDs1Mg@mail.gmail.com>
 <Ytbnlms90+LBLbrY@google.com>
 <Ythv7NqofIAHp3bf@worktop.programming.kicks-ass.net>
 <8177b804cfcb461d9f1f40d242cd84db@AcuMS.aculab.com>
In-Reply-To: <8177b804cfcb461d9f1f40d242cd84db@AcuMS.aculab.com>
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

From: David Laight
> Sent: 21 July 2022 09:22
> 
> From: Peter Zijlstra
> > Sent: 20 July 2022 22:13
> ...
> > The prettiest option to obscure the immediate at the callsite I could
> > conjure up is something like:
> >
> > kcfi_caller_linus:
> > 	movl	$0x12345600, %r10d
> > 	movb	$0x78, %r10b
> > 	cmpl	%r10d, -OFFSET(%r11)
> > 	je	1f
> > 	ud2
> > 1:	call	__x86_thunk_indirect_r11
> >
> > Which comes to around 22 bytes (+5 over the original).
> 
> You'd be better doing:
> 	movl $0x12345678-0xaa, %r10d
> 	addl $0xaa, %r10d
> so that the immediate is obscured even if the low bits are zero.

Actually, can't you use %eax instead of %r10d?
IIRC it is only used for the number of FP registers in a varargs
call - and that isn't used in the kernel.
That removes the 3 'REG' prefixes and lets you use the
2-byte 04-xx instruction to add to %al.

Although I'm sure I remember something about a penalty for
accessing %al just after the full register.
So the 3-byte sign extending add may be better.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

