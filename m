Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABF7577596
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 11:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbiGQJp0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 17 Jul 2022 05:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiGQJpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 05:45:24 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA67E165BD
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 02:45:23 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-281-I-MzlVIbOMG4FSaYKBHZTw-1; Sun, 17 Jul 2022 10:45:19 +0100
X-MC-Unique: I-MzlVIbOMG4FSaYKBHZTw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Sun, 17 Jul 2022 10:45:17 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Sun, 17 Jul 2022 10:45:17 +0100
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
Thread-Index: AQHYmWozi03gNC/QIkePUsvbFv4MOq2CTJVg
Date:   Sun, 17 Jul 2022 09:45:17 +0000
Message-ID: <f9fd86acac4f49bc8f90b403978e9df3@AcuMS.aculab.com>
References: <20220716230344.239749011@linutronix.de>
In-Reply-To: <20220716230344.239749011@linutronix.de>
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
> Sent: 17 July 2022 00:17
> Folks!
> 
> Back in the good old spectre v2 days (2018) we decided to not use
> IBRS. In hindsight this might have been the wrong decision because it did
> not force people to come up with alternative approaches.
> 
> It was already discussed back then to try software based call depth
> accounting and RSB stuffing on underflow for Intel SKL[-X] systems to avoid
> the insane overhead of IBRS.
> 
> This has been tried in 2018 and was rejected due to the massive overhead
> and other shortcomings of the approach to put the accounting into each
> function prologue:
> 
>   1) Text size increase which is inflicted on everyone.  While CPUs are
>      good in ignoring NOPs they still pollute the I-cache.
> 
>   2) That results in tail call over-accounting which can be exploited.
> 
> Disabling tail calls is not an option either and adding a 10 byte padding
> in front of every direct call is even worse in terms of text size and
> I-cache impact. We also could patch calls past the accounting in the
> function prologue but that becomes a nightmare vs. ENDBR.
> 
> As IBRS is a performance horror show, Peter Zijstra and me revisited the
> call depth tracking approach and implemented it in a way which is hopefully
> more palatable and avoids the downsides of the original attempt.
> 
> We both unsurprisingly hate the result with a passion...
> 
> The way we approached this is:
> 
>  1) objtool creates a list of function entry points and a list of direct
>     call sites into new sections which can be discarded after init.
> 
>  2) On affected machines, use the new sections, allocate module memory
>     and create a call thunk per function (16 bytes without
>     debug/statistics). Then patch all direct calls to invoke the thunk,
>     which does the call accounting and then jumps to the original call
>     site.
> 
>  3) Utilize the retbleed return thunk mechanism by making the jump
>     target run-time configurable. Add the accounting counterpart and
>     stuff RSB on underflow in that alternate implementation.

What happens to indirect calls?
The above would imply that they miss the function entry thunk, but
get the return one.
Won't this lead to mis-counting of the RSB?

I also thought that retpolines would trash the return stack?
Using a single retpoline thunk would pretty much ensure that
they are never correctly predicted from the BTB, but it only
gives a single BTB entry that needs 'setting up' to get mis-
prediction.

I'm also sure I managed to infer from a document of instruction
timings and architectures that some x86 cpu actually used the BTB
for normal conditional jumps?
Possibly to avoid passing the full %ip value all down the
cpu pipeline.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

