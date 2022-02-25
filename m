Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA2D4C4580
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238394AbiBYNKP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 25 Feb 2022 08:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbiBYNKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:10:13 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF2901E7A42
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:09:39 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-193-m8Ucn2YQO66D-19VMlzn2A-1; Fri, 25 Feb 2022 13:09:36 +0000
X-MC-Unique: m8Ucn2YQO66D-19VMlzn2A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Fri, 25 Feb 2022 13:09:34 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Fri, 25 Feb 2022 13:09:34 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "joao@overdrivepizza.com" <joao@overdrivepizza.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alyssa.milburn@intel.com" <alyssa.milburn@intel.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
Subject: RE: [PATCH v2 11/39] x86/ibt,kvm: Add ENDBR to fastops
Thread-Topic: [PATCH v2 11/39] x86/ibt,kvm: Add ENDBR to fastops
Thread-Index: AQHYKjHx/OqvS/l8EkSgTXDB8+1fEqykPQ7w
Date:   Fri, 25 Feb 2022 13:09:34 +0000
Message-ID: <88414f3498d84e76ba358119d633d62a@AcuMS.aculab.com>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.656194153@infradead.org> <202202241651.B5FB7DBE@keescook>
 <YhiuZJpwq/bMZYgn@hirez.programming.kicks-ass.net>
In-Reply-To: <YhiuZJpwq/bMZYgn@hirez.programming.kicks-ass.net>
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
> Sent: 25 February 2022 10:25
> 
> On Thu, Feb 24, 2022 at 04:54:04PM -0800, Kees Cook wrote:
> > On Thu, Feb 24, 2022 at 03:51:49PM +0100, Peter Zijlstra wrote:
> > >
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  arch/x86/kvm/emulate.c |    6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > --- a/arch/x86/kvm/emulate.c
> > > +++ b/arch/x86/kvm/emulate.c
> > > @@ -189,7 +189,7 @@
> > >  #define X16(x...) X8(x), X8(x)
> > >
> > >  #define NR_FASTOP (ilog2(sizeof(ulong)) + 1)
> > > -#define FASTOP_SIZE 8
> > > +#define FASTOP_SIZE (8 * (1 + HAS_KERNEL_IBT))

Defining as:
		(8 + HAS_KERNEL_IBT * 8)
would probably be easier to read when half asleep.

	David

> >
> > Err, is this right? FASTOP_SIZE is used both as a size and an alignment.
> > But the ENDBR instruction is 4 bytes? Commit log maybe needed to
> > describe this.
> 
> Note how that comes out as 8*1 or 8*2, iow 8 or 16. Does that clarify?
> That is, 8+4 being 12 is ovbiuosly a fail for alignment.

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

