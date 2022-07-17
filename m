Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB0457779B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 19:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiGQR4i convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 17 Jul 2022 13:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiGQR4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 13:56:36 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA39213D5C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 10:56:33 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-103-sQvoyu-PNDWk0UHk7-hF4g-1; Sun, 17 Jul 2022 18:56:31 +0100
X-MC-Unique: sQvoyu-PNDWk0UHk7-hF4g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Sun, 17 Jul 2022 18:56:28 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Sun, 17 Jul 2022 18:56:28 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Thomas Gleixner' <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Josh Poimboeuf" <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: RE: [patch 00/38] x86/retbleed: Call depth tracking mitigation
Thread-Topic: [patch 00/38] x86/retbleed: Call depth tracking mitigation
Thread-Index: AQHYmWozi03gNC/QIkePUsvbFv4MOq2CTJVggABNmoCAADzr8A==
Date:   Sun, 17 Jul 2022 17:56:28 +0000
Message-ID: <24673619e9e2411bb1d5f287aab2aa87@AcuMS.aculab.com>
References: <20220716230344.239749011@linutronix.de>
 <f9fd86acac4f49bc8f90b403978e9df3@AcuMS.aculab.com> <8735ezye00.ffs@tglx>
In-Reply-To: <8735ezye00.ffs@tglx>
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

From: Thomas Gleixner
> Sent: 17 July 2022 16:07
> 
> On Sun, Jul 17 2022 at 09:45, David Laight wrote:
> > From: Thomas Gleixner
> >>
> >>  3) Utilize the retbleed return thunk mechanism by making the jump
> >>     target run-time configurable. Add the accounting counterpart and
> >>     stuff RSB on underflow in that alternate implementation.
> >
> > What happens to indirect calls?
> > The above would imply that they miss the function entry thunk, but
> > get the return one.
> > Won't this lead to mis-counting of the RSB?
> 
> That's accounted in the indirect call thunk. This mitigation requires
> retpolines enabled.

Thanks, that wasn't in the summary.

> > I also thought that retpolines would trash the return stack?
> 
> No. They prevent that the CPU misspeculates an indirect call due to a
> mistrained BTB.
> 
> > Using a single retpoline thunk would pretty much ensure that
> > they are never correctly predicted from the BTB, but it only
> > gives a single BTB entry that needs 'setting up' to get mis-
> > prediction.
> 
>   BTB != RSB

I was thinking about what happens after the RSB has underflowed.
Which is when (I presume) the BTB based speculation happens.

> The intra function call in the retpoline is of course adding a RSB entry
> which points to the speculation trap, but that gets popped immediately
> after that by the return which goes to the called function.

I'm remembering the 'active' instructions in a retpoline being 'push; ret'.
Which is an RSB imbalance.

...
> > I'm also sure I managed to infer from a document of instruction
> > timings and architectures that some x86 cpu actually used the BTB
> > for normal conditional jumps?
> 
> That's relevant to the problem at hand in which way?

The next problem :-)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

