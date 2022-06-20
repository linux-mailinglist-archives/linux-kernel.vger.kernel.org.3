Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DC85520B3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244253AbiFTPZS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Jun 2022 11:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243886AbiFTPYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:24:50 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC4472702
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 08:21:56 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-265-iuU6fljHOQqCeFZLSZgSgA-1; Mon, 20 Jun 2022 16:21:53 +0100
X-MC-Unique: iuU6fljHOQqCeFZLSZgSgA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Mon, 20 Jun 2022 16:21:51 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Mon, 20 Jun 2022 16:21:51 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Kent Overstreet' <kent.overstreet@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "enozhatsky@chromium.org" <enozhatsky@chromium.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "willy@infradead.org" <willy@infradead.org>
Subject: RE: [PATCH v4 00/34] Printbufs - new data structure for building
 strings
Thread-Topic: [PATCH v4 00/34] Printbufs - new data structure for building
 strings
Thread-Index: AQHYhD6oUJ9HZdIC7US1XHhH4yp3Qa1XsEIggAClXQCAABGg4A==
Date:   Mon, 20 Jun 2022 15:21:50 +0000
Message-ID: <ebfebd1bd01f43f099a4d08b4029013a@AcuMS.aculab.com>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
 <0a5901f8460f452a89c9b0cda32fb833@AcuMS.aculab.com>
 <20220620150514.3tjy5dv7pv5frcwd@moria.home.lan>
In-Reply-To: <20220620150514.3tjy5dv7pv5frcwd@moria.home.lan>
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
> Sent: 20 June 2022 16:07

> On Mon, Jun 20, 2022 at 04:19:31AM +0000, David Laight wrote:
> > From: Kent Overstreet
> > >   Rasmus pointed out that -fno-strict-aliasing is going to cause gcc to generate
> > >   nasty code, and indeed it unfortunately does but according to worst case
> > >   scenario microbenchmarks it's not a problem for actual performance.
> >
> > Just copy some of the structure members to local variables
> > and, if necessary, write them back at the end.
> 
> You must not have read any of the code - half the point of this patch series is
> implementing proper helpers for printing chars, strings of bytes, etc. and that
> doesn't work if we're not using actual types.

I'm talking about things like:
	out->buf[out->pos] = c;
(or whatever the field names are.)

Even without strict aliasing the compiler has to reread
'buf' and 'pos' every iteration.

Of course, you might find the compiler decides to 'optimise'
the loop to memcpy() or memset().

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

