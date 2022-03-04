Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3624CE093
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 00:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiCDXJR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 4 Mar 2022 18:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiCDXJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 18:09:16 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E69ED1C65CB
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 15:08:26 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-79-s1JfIF8fNSGP8Xuomzx6qA-1; Fri, 04 Mar 2022 23:08:24 +0000
X-MC-Unique: s1JfIF8fNSGP8Xuomzx6qA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Fri, 4 Mar 2022 23:08:23 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Fri, 4 Mar 2022 23:08:23 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "joao@overdrivepizza.com" <joao@overdrivepizza.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alyssa.milburn@intel.com" <alyssa.milburn@intel.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
Subject: RE: [PATCH v3 18/39] x86/ibt,ftrace: Make function-graph play nice
Thread-Topic: [PATCH v3 18/39] x86/ibt,ftrace: Make function-graph play nice
Thread-Index: AQHYMAI0GSxiDHFGBEWPBcynSqueEKyv1g9g
Date:   Fri, 4 Mar 2022 23:08:23 +0000
Message-ID: <d995569898fb40609f2f73f7b29d96ed@AcuMS.aculab.com>
References: <20220303112321.422525803@infradead.org>
 <20220303112826.044301664@infradead.org>
 <20220304175154.l2otvmqd4r7ozsuy@treble>
 <20220304194853.GN11184@worktop.programming.kicks-ass.net>
In-Reply-To: <20220304194853.GN11184@worktop.programming.kicks-ass.net>
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

From: Peter Zijlstra
> Sent: 04 March 2022 19:49
> 
> On Fri, Mar 04, 2022 at 09:51:54AM -0800, Josh Poimboeuf wrote:
> > On Thu, Mar 03, 2022 at 12:23:39PM +0100, Peter Zijlstra wrote:
> > > +
> > > +	addq $16, %rsp
> > > +	ANNOTATE_INTRA_FUNCTION_CALL
> > > +	call .Ldo_rop
> > > +	int3
> > > +.Ldo_rop:
> > > +	mov %rdi, (%rsp)
> > > +	UNWIND_HINT_FUNC
> > > +	RET
> >
> > Why the int3?
> 
> Speculation trap :-) Either I'm too paranoid or not paranoid enough; but
> without it it's just too close to a retpoline and it doesn't feel right.

Isn't 'jmps .' good enough for a speculation trap?
I'm sure there is a potential issue using 'int 3' because
it is a slow instruction and might take some time to abort.

I actually remember something from a very old Intel doc that
told you not to mix code and data because you didn't want to
'accidentally' execute something like 'atan'.
I can't remember the full context - but it may have been
speculatively executing code after unconditional jumps!
There were certainly bigger problems because the cpu at that
time wouldn't abort the atan - so you had to wait for it to
finish.

I suspect you do need something between the call and label.
The sequence:
	call 1f
1:	pop %rax
is used to get the %pc (especially on 32bit) and is detected
so that it doesn't mess up the return stack.
So you probably want to avoid a call to the next instruction.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

