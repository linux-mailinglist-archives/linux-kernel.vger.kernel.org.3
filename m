Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9720446D416
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 14:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbhLHNKw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 8 Dec 2021 08:10:52 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:30597 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232257AbhLHNKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 08:10:52 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-185-ThzMD2xUPfu0lG4avvF8wA-1; Wed, 08 Dec 2021 13:07:14 +0000
X-MC-Unique: ThzMD2xUPfu0lG4avvF8wA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26; Wed, 8 Dec 2021 13:07:13 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.026; Wed, 8 Dec 2021 13:07:13 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Yury Norov' <yury.norov@gmail.com>,
        Kees Cook <keescook@chromium.org>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>
Subject: RE: [PATCH] find: Do not read beyond variable boundaries on small
 sizes
Thread-Topic: [PATCH] find: Do not read beyond variable boundaries on small
 sizes
Thread-Index: AQHX68OzWcvG0uwHEUyl9NiXTvoG0KwojuWA
Date:   Wed, 8 Dec 2021 13:07:13 +0000
Message-ID: <1f9ab8b9e4ac4c8f9099ec77ad598fef@AcuMS.aculab.com>
References: <20211203100846.3977195-1-keescook@chromium.org>
 <YaoN6wnNezMvyyd5@smile.fi.intel.com> <20211203182638.GA450223@lapt>
 <202112031450.EFE7B7B4A@keescook> <20211207233930.GA3955@lapt>
In-Reply-To: <20211207233930.GA3955@lapt>
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

From: Yury Norov
> Sent: 07 December 2021 23:40
> 
> On Fri, Dec 03, 2021 at 03:01:30PM -0800, Kees Cook wrote:
> > On Fri, Dec 03, 2021 at 10:26:38AM -0800, Yury Norov wrote:
> > > On Fri, Dec 03, 2021 at 02:30:35PM +0200, Andy Shevchenko wrote:
> > > > On Fri, Dec 03, 2021 at 02:08:46AM -0800, Kees Cook wrote:
> > > > > It's common practice to cast small variable arguments to the find_*_bit()
> > >
> > > Not that common - I found 19 examples of this cast, and most of them
> > > are in drivers.
> >
> > I find 51 (most are in the for_each_* wrappers):
> >
> > $ RE=$(echo '\b('$(echo $(grep -E '^(unsigned long find|#define for_each)_' include/linux/find.h |
> cut -d'(' -f1 | awk '{print $NF}') | tr ' ' '|')')\(.*\(unsigned long \*\)')
> > $ git grep -E "$RE" | wc -l
> > 51
> >
> > > > > This leads to the find helper dereferencing a full unsigned long,
> > > > > regardless of the size of the actual variable. The unwanted bits
> > > > > get masked away, but strictly speaking, a read beyond the end of
> > > > > the target variable happens. Builds under -Warray-bounds complain
> > > > > about this situation, for example:
> > > > >
> > > > > In file included from ./include/linux/bitmap.h:9,
> > > > >                  from drivers/iommu/intel/iommu.c:17:
> > > > > drivers/iommu/intel/iommu.c: In function 'domain_context_mapping_one':
> > > > > ./include/linux/find.h:119:37: error: array subscript 'long unsigned int[0]' is partly outside
> array bounds of 'int[1]' [-Werror=array-bounds]
> > > > >   119 |                 unsigned long val = *addr & GENMASK(size - 1, 0);
> > > > >       |                                     ^~~~~
> > > > > drivers/iommu/intel/iommu.c:2115:18: note: while referencing 'max_pde'
> > > > >  2115 |         int pds, max_pde;
> > > > >       |                  ^~~~~~~
> > >
> > > The driver should be fixed. I would suggest using one of ffs/fls/ffz from
> > > include/asm/bitops.h
> >
> > I don't think it's a good API design to make developers choose between
> > functions based on the size of their target.
> 
> Bitmap functions work identically for all sizes from 0 to INT_MAX - 1.
> Users don't 'choose between functions based on the size of their target'.
> 
> Can you explain more what you mean?
> 
> > This also doesn't work well
> > for the main problem which is the for_each_* usage.
> 
> for_each_*_bit() requires a pointer to an array of unsigned longs. If
> it's provided with something else, this is an error on a caller side.
> 
> > The existing API is totally fine: it already diverts the constant
> > expression small sizes to ffs/etc, and this change is only to that
> > part.
> 
> If you want to allow passing types other than unsigned long *, you need
> to be consistent and propagate this change to other bitmap functions.
> This is much more work than just fixing at most 48 wrong callers.
> (48 because I inspected some callers manually, and they are fine.)

The type must be 'unsigned long *'.
You must not use the bitmap functions on smaller types (eg int) if you know
the maximum size is smaller.
The code will do completely the wrong thing on BE systems.

Even on x86-86 there have been issues with 8n+4 aligned int[]
being passed and generating slow locked accesses when the buffer
crosses a page boundary.

So code that casts the argument to any of the bitmap function
is really inherently broken.

I think you'll also find code that is using the bitmap functions
where it doesn't need locked updates.
The implied locked updates are horribly inefficient on some
architectures (hashed global locks have to be used).

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

