Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FAD52E6E1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 10:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235920AbiETIDh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 20 May 2022 04:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiETIDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 04:03:35 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E0206898F
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 01:03:32 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-231-j6MuEwWEOMq97IGnC72OWw-1; Fri, 20 May 2022 09:03:30 +0100
X-MC-Unique: j6MuEwWEOMq97IGnC72OWw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Fri, 20 May 2022 09:03:29 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Fri, 20 May 2022 09:03:29 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Matthew Wilcox' <willy@infradead.org>
CC:     'Kent Overstreet' <kent.overstreet@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@vger.kernel.org" <linux-mm@vger.kernel.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
Subject: RE: [PATCH v2 03/28] vsprintf: %pf(%p)
Thread-Topic: [PATCH v2 03/28] vsprintf: %pf(%p)
Thread-Index: AQHYa6VkVQCoxy629k+LRSm5RxWDEq0mrmAQ///0sICAAMIK4A==
Date:   Fri, 20 May 2022 08:03:29 +0000
Message-ID: <786516a0b71a4c6689592b89b146edec@AcuMS.aculab.com>
References: <20220519172421.162394-1-kent.overstreet@gmail.com>
 <20220519172421.162394-4-kent.overstreet@gmail.com>
 <141b17a257274fc38291cdb07e0e23b6@AcuMS.aculab.com>
 <Yoazbys+LiG0Uqcc@casper.infradead.org>
In-Reply-To: <Yoazbys+LiG0Uqcc@casper.infradead.org>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox
> Sent: 19 May 2022 22:15
> 
> On Thu, May 19, 2022 at 09:06:24PM +0000, David Laight wrote:
> > I suspect this a very good way to blow the kernel stack.
> > The highest stack use is already very likely to be inside
> > the printf code in an error path somewhere.
> 
> ...
> 
> > Double copying using a temporary buffer isn't the end of the world.
> 
> How can you hold both of these positions simultaneously?

Mostly you only need a short(ish) buffer to format a single item.
But even a full line buffer is probably less stack than a
nested printf call.
It certainly makes it possible for static analysis to determine
maximum stack depth.

That made me realise that one of the problems doing static
analysis of stack depth is indirect calls.
The hashes that (IIRC) fine-ibt add to indirect calls
and functions make it possible to tie these together.
So you can determine the worst one of the called functions
and use it for the stack depth at the call sites.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

