Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03AFB48C7A6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 16:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354834AbiALPx5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 12 Jan 2022 10:53:57 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:37760 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354828AbiALPxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 10:53:55 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-170-LR7s-IWrOjeZPtZqGrTbpA-1; Wed, 12 Jan 2022 15:53:52 +0000
X-MC-Unique: LR7s-IWrOjeZPtZqGrTbpA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26; Wed, 12 Jan 2022 15:53:52 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.026; Wed, 12 Jan 2022 15:53:52 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>
CC:     'Mathieu Desnoyers' <mathieu.desnoyers@efficios.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, carlos <carlos@redhat.com>
Subject: RE: [RFC PATCH v2 1/2] rseq: x86: implement abort-at-ip extension
Thread-Topic: [RFC PATCH v2 1/2] rseq: x86: implement abort-at-ip extension
Thread-Index: AdgHxNJPmHALYHCBSGGqQq0pyoAGXDSYsRN7NJggl0D8toN7AP///DpQ
Date:   Wed, 12 Jan 2022 15:53:52 +0000
Message-ID: <d3276adfc6b34cf0a9a4497f276c4bf0@AcuMS.aculab.com>
References: <20220110171611.8351-1-mathieu.desnoyers@efficios.com>
 <20220111110556.inteixgtl5vpmka7@wittgenstein>
 <1626924888.21447.1641922985771.JavaMail.zimbra@efficios.com>
 <20220112084617.32bjjo774n7vvyct@wittgenstein>
 <1475639366.24565.1641998849957.JavaMail.zimbra@efficios.com>
 <71e7d09733df4a899d12b7ef25198bbc@AcuMS.aculab.com>
 <1953851780.24610.1641999934047.JavaMail.zimbra@efficios.com>
 <0088806280f54211b3f90b2c1a82a140@AcuMS.aculab.com>
 <Yd708EjQNEa9dFXZ@hirez.programming.kicks-ass.net>
In-Reply-To: <Yd708EjQNEa9dFXZ@hirez.programming.kicks-ass.net>
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra 
> Sent: 12 January 2022 15:34
> 
> On Wed, Jan 12, 2022 at 03:15:27PM +0000, David Laight wrote:
> > From: Mathieu Desnoyers
> > > Sent: 12 January 2022 15:06
> > >
> > > ----- On Jan 12, 2022, at 9:58 AM, David Laight David.Laight@ACULAB.COM wrote:
> > >
> > > >>  * [*] The openrisc, powerpc64 and x86-64 architectures define a "redzone" as a
> > > >>  *     stack area beyond the stack pointer which can be used by the compiler
> > > >>  *     to store local variables in leaf functions.
> > > >
> > > > I wonder if that is really worth the trouble it causes!
> > > > By the time a function is spilling values to stack the cost
> > > > of a %sp update is almost certainly noise.
> > > >
> > > > Someone clearly thought it was a 'good idea (tm)'.
> > >
> > > I must admit that I've been surprised to learn about these redzones. Thanks for
> > > pointing them out to me, it was clearly a blind spot. I suspect it would be useful
> > > to introduce per-architecture KERNEL_REDZONE, USER_REDZONE and COMPAT_USER_REDZONE
> > > with a asm-generic version defining them to 0, with proper documentation. It would
> > > make it clearer to kernel developers working on stuff similar to signal handler
> > > delivery that they need to consider these carefully.
> >
> > They can never be used in kernel - any ISR would overwrite them.
> 
> That depends on how the architecture does exceptions;

True, many newer ones don't actually write anything to the stack.
Makes the cpu simpler.

> also consider:
> 
>   https://www.intel.com/content/www/us/en/develop/download/flexible-return-and-event-delivery-
> specification.html

That contains the snippet:
	The SWAPGS instruction supports efficient updates of the GS base address.

Which is just so horribly not true...
Even FRED is always doing a GS swap - so you can easily lose the kernel GS value.

I remember fixing all the 'in kernel' faults in the netbsd x86-64 return to user path.
Entirely horrid...

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

