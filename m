Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2346650E0EE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 14:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238540AbiDYNCm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 25 Apr 2022 09:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238933AbiDYNCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:02:31 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2489A13F1B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 05:59:27 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-246-RsRt4rMLMJSg1HNL0-UwSg-1; Mon, 25 Apr 2022 13:59:24 +0100
X-MC-Unique: RsRt4rMLMJSg1HNL0-UwSg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Mon, 25 Apr 2022 13:59:23 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Mon, 25 Apr 2022 13:59:23 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Mikulas Patocka' <mpatocka@redhat.com>
CC:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Andy Shevchenko <andy@kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Mike Snitzer <msnitzer@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Milan Broz <gmazyland@gmail.com>
Subject: RE: [PATCH] hex2bin: make the function hex_to_bin constant-time
Thread-Topic: [PATCH] hex2bin: make the function hex_to_bin constant-time
Thread-Index: AQHYWCRFXKVloRHnAkSgNzNf81l36q0AX1CggAAH/4CAAC5kEA==
Date:   Mon, 25 Apr 2022 12:59:23 +0000
Message-ID: <e8de034196df450cb352fa60a570acca@AcuMS.aculab.com>
References: <alpine.LRH.2.02.2204241648270.17244@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh+Z+OKH3jRttWGHbWSQq2wVMtdnA=ntDiadZu=VxAC7w@mail.gmail.com>
 <CAHk-=wibmkFz6dybsdpW_3kUnV20FhJazerWDcbm7yCp_Xv+CA@mail.gmail.com>
 <789f0463ce974e90a93f4dbf8c471156@AcuMS.aculab.com>
 <alpine.LRH.2.02.2204250701410.10912@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2204250701410.10912@file01.intranet.prod.int.rdu2.redhat.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikulas Patocka
> Sent: 25 April 2022 12:04
> 
> On Mon, 25 Apr 2022, David Laight wrote:
> 
> > From: Linus Torvalds
> > > Sent: 24 April 2022 22:42
> > >
> > > On Sun, Apr 24, 2022 at 2:37 PM Linus Torvalds
> > > <torvalds@linux-foundation.org> wrote:
> > > >
> > > > Finally, for the same reason - please don't use ">> 8".  Because I do
> > > > not believe that bit 8 is well-defined in your arithmetic. The *sign*
> > > > bit will be, but I'm not convinced bit 8 is.
> > >
> > > Hmm.. I think it's ok. It can indeed overflow in 'char' and change the
> > > sign in bit #7, but I suspect bit #8 is always fine.
> > >
> > > Still, If you want to just extend the sign bit, ">> 31" _is_ the
> > > obvious thing to use (yeah, yeah, properly "sizeof(int)*8-1" or
> > > whatever, you get my drift).
> >
> > Except that right shifts of signed values are UB.
> > In particular it has always been valid to do an unsigned
> > shift right on a 2's compliment negative number.
> >
> > 	David
> 
> Yes. All the standard versions (C89, C99, C11, C2X) say that right shift
> of a negative value is implementation-defined.
> 
> So, we should cast it to "unsigned" before shifting it.

Except that the intent appears to be to replicate the sign bit.

If it is 'implementation defined' (rather than suddenly being UB)
it might be that the linux kernel requires sign propagating
right shifts of negative values.
This is typically what happens on 2's compliment systems.
But not all small cpu have the required shift instruction.
OTOH all the ones bit enough to run Linux probably do.
(And gcc doesn't support '1's compliment' or 'sign overpunch' cpus.)

The problem is that the compiler writers seem to be entering
a mindset where they are optimising code based on UB behaviour.
So given:
void foo(int x)
{
	if (x >> 1 < 0)
		return;
	do_something();
}
they decide the test is UB, so can always be assumed to be true
and thus do_something() is compiled away.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

