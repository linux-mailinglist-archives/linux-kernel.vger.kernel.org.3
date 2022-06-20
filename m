Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29565521A0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242252AbiFTPxs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Jun 2022 11:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiFTPxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:53:45 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94BE81D31B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 08:53:44 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-405-7RBaScP0Muydi72A4Eiqlw-1; Mon, 20 Jun 2022 16:53:41 +0100
X-MC-Unique: 7RBaScP0Muydi72A4Eiqlw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Mon, 20 Jun 2022 16:53:38 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Mon, 20 Jun 2022 16:53:38 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Kent Overstreet' <kent.overstreet@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "enozhatsky@chromium.org" <enozhatsky@chromium.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "willy@infradead.org" <willy@infradead.org>
Subject: RE: [PATCH v4 01/34] lib/printbuf: New data structure for printing
 strings
Thread-Topic: [PATCH v4 01/34] lib/printbuf: New data structure for printing
 strings
Thread-Index: AQHYhD6p9ckAsWkCSk+0B0i5FtmPu61XsWoggACqvYCAABJf0A==
Date:   Mon, 20 Jun 2022 15:53:38 +0000
Message-ID: <5156ce6a38ab4f9c87ddf29ee05a266a@AcuMS.aculab.com>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
 <20220620004233.3805-2-kent.overstreet@gmail.com>
 <f0808aaee9ac4b088121c0fbe7e18f0d@AcuMS.aculab.com>
 <20220620153043.vgtfrltebiyprufz@moria.home.lan>
In-Reply-To: <20220620153043.vgtfrltebiyprufz@moria.home.lan>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kent Overstreet
> Sent: 20 June 2022 16:31
> 
> On Mon, Jun 20, 2022 at 04:44:10AM +0000, David Laight wrote:
> > From: Kent Overstreet
> > > Sent: 20 June 2022 01:42
> > >
> > > This adds printbufs: a printbuf points to a char * buffer and knows the
> > > size of the output buffer as well as the current output position.
> > >
> > > Future patches will be adding more features to printbuf, but initially
> > > printbufs are targeted at refactoring and improving our existing code in
> > > lib/vsprintf.c - so this initial printbuf patch has the features
> > > required for that.
> > >
> > > Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> > > Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > ---
> > >  include/linux/printbuf.h | 122 +++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 122 insertions(+)
> > >  create mode 100644 include/linux/printbuf.h
> > >
> > > diff --git a/include/linux/printbuf.h b/include/linux/printbuf.h
> > > new file mode 100644
> > > index 0000000000..8186c447ca
> > > --- /dev/null
> > > +++ b/include/linux/printbuf.h
> > > @@ -0,0 +1,122 @@
> > > +/* SPDX-License-Identifier: LGPL-2.1+ */
> > > +/* Copyright (C) 2022 Kent Overstreet */
> > > +
> > > +#ifndef _LINUX_PRINTBUF_H
> > > +#define _LINUX_PRINTBUF_H
> > > +
> > > +#include <linux/kernel.h>
> > > +#include <linux/string.h>
> > > +
> > > +/*
> > > + * Printbufs: String buffer for outputting (printing) to, for vsnprintf
> > > + */
> > > +
> > > +struct printbuf {
> > > +	char			*buf;
> > > +	unsigned		size;
> > > +	unsigned		pos;
> >
> > No naked unsigneds.
> 
> This is the way I've _always_ written kernel code - single word type names.

I'm pretty sure the coding standards require 'int'.

> >
> > > +};
> > > +
> > > +/*
> > > + * Returns size remaining of output buffer:
> > > + */
> > > +static inline unsigned printbuf_remaining_size(struct printbuf *out)
> > > +{
> > > +	return out->pos < out->size ? out->size - out->pos : 0;
> > > +}
> > > +
> > > +/*
> > > + * Returns number of characters we can print to the output buffer - i.e.
> > > + * excluding the terminating nul:
> > > + */
> > > +static inline unsigned printbuf_remaining(struct printbuf *out)
> > > +{
> > > +	return out->pos < out->size ? out->size - out->pos - 1 : 0;
> > > +}
> >
> > Those two are so similar mistakes will be make.
> 
> If you've got ideas for better names I'd be happy to hear them - we discussed
> this and this was what we came up with.
> 
> > You can also just return negatives when the buffer has overlowed
> > and get the callers to test < or <= as required.
> 
> Yeesh, no.

Why not?
All the callers are internal.
It saves a test and branch (or cmove).

> > I also wonder it is necessary to count the total length
> > when the buffer isn't long enough?
> > Unless there is a real pressing need for it I'd not bother.
> > Setting pos == size (after writing the '\0') allows
> > overflow be detected without most of the dangers.
> 
> Because that's what snprintf() needs.
> 
> > > +
> > > +static inline unsigned printbuf_written(struct printbuf *out)
> > > +{
> > > +	return min(out->pos, out->size);
> >
> > That excludes the '\0' for short buffers but includes
> > it for overlong ones.
> 
> It actually doesn't.

If size is 2 it goes 0, 1, 2, 2, 2 as bytes are added.
But the string is "" "a" "a" "a" - never 2 characters. 

...
> > > +static inline void prt_bytes(struct printbuf *out, const void *b, unsigned n)
> > > +{
> > > +	unsigned i, can_print = min(n, printbuf_remaining(out));
> > > +
> > > +	for (i = 0; i < can_print; i++)
> > > +		out->buf[out->pos++] = ((char *) b)[i];
> > > +	out->pos += n - can_print;
> > > +
> > > +	printbuf_nul_terminate(out);
> >
> > jeepers - that can be written so much better.
> > Something like:
> > 	unsigned int i, pos = out->pos;
> > 	int space = pos - out->size - 1;
> > 	char *tgt = out->buf + pos;
> > 	const char *src = b;
> > 	out->pos = pos + n;
> >
> > 	if (space <= 0)
> > 		return;
> > 	if (n > space)
> > 		n = space;
> >
> > 	for (i = 0; i < n; i++)
> > 		tgt[i] = src[i];
> > 	tgt[1] = 0;
> >
> 
> I find your version considerably harder to read, and I've stared at enough
> assembly that I trust the compiler to generate pretty equivalent code.

It can't because it can't assume that out->buf doesn't overlap 'out'.
I'm also pretty sure it can't optimise out the test before adding the '\0'.

> 
> > > +}
> > > +
> > > +static inline void prt_str(struct printbuf *out, const char *str)
> > > +{
> > > +	prt_bytes(out, str, strlen(str));
> >
> > Do you really need to call strlen() and then process
> > the buffer byte by byte?
> 
> Versus introducing a branch to check for nul into the inner loop of prt_bytes()?
> You're not serious, are you?

As opposed to the one in strlen() ?
I realise that there are shift and mask algorithms from strlen()
that are likely faster than a byte scan on 64 bit systems.
But they are likely slower than the check when you have a loop
that is scanning byte by byte.
This is especially true on out of order superscaler cpu when
the copy loop won't be using all the execution blocks.

What might be faster on cpu (like x86) where misaligned memory
access are almost entirely free is to copy 8 bytes at a time
while checking for a zero at the same time.

Remember kernel strings are quite often short, the overhead
costs for 'fast' routines slow things down.
(As you found when calling memcpy() and memset().)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

