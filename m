Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005B75260AB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 13:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379757AbiEMLGe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 13 May 2022 07:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379732AbiEMLG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 07:06:28 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5708027CC0
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 04:06:26 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-197-ASZCsPWJPluT1yty21qOXQ-1; Fri, 13 May 2022 12:06:24 +0100
X-MC-Unique: ASZCsPWJPluT1yty21qOXQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Fri, 13 May 2022 12:06:23 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Fri, 13 May 2022 12:06:23 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andrew Morton' <akpm@linux-foundation.org>,
        liqiong <liqiong@nfschina.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mm: change "char *bdi_unknown_name" to "char
 bdi_unknown_name[]"
Thread-Topic: [PATCH] mm: change "char *bdi_unknown_name" to "char
 bdi_unknown_name[]"
Thread-Index: AQHYZjsAqW5HazYh8E6shSZ+mswpua0cpDpg
Date:   Fri, 13 May 2022 11:06:23 +0000
Message-ID: <4b21dec7e98243b89daea96286c33434@AcuMS.aculab.com>
References: <20220512082637.24649-1-liqiong@nfschina.com>
 <20220512130051.94a0c53e5d1498292473975d@linux-foundation.org>
In-Reply-To: <20220512130051.94a0c53e5d1498292473975d@linux-foundation.org>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton
> Sent: 12 May 2022 21:01
> 
> On Thu, 12 May 2022 16:26:37 +0800 liqiong <liqiong@nfschina.com> wrote:
> 
> > "char bdi_unknown_nam[]" string form declares a single variable.
> > It is better then "char *bdi_unknown_name" which creates two
> > variables.
> >
> > ...
> >
> > --- a/mm/backing-dev.c
> > +++ b/mm/backing-dev.c
> > @@ -20,7 +20,7 @@ struct backing_dev_info noop_backing_dev_info;
> >  EXPORT_SYMBOL_GPL(noop_backing_dev_info);
> >
> >  static struct class *bdi_class;
> > -static const char *bdi_unknown_name = "(unknown)";
> > +static const char bdi_unknown_name[] = "(unknown)";
> >
> 
> heh, fun patch.  We actually do this quite a lot.
> 
> 	grep -r "^[a-z].*char \*[a-z].*= \"" .
> 
> is a pathetic pattern which catches a lot of them.
> 
> 
> However.  I expected your patch to shrink the kernel a bit, but it has
> the opposite effect:
> 
> hp2:/usr/src/25> size mm/backing-dev.o
>    text	   data	    bss	    dec	    hex	filename
>   21288	   9396	   3808	  34492	   86bc	mm/backing-dev.o-before
>   21300	   9428	   3808	  34536	   86e8	mm/backing-dev.o-after
> 
> Even .data became larger.  I didn't investigate why.

The linker can merge replicated strings
(ie data in .rodata.str1.n sections)
but I don't think the compiler puts variables into that section.

So if you have:
static const char *const foo_xxx = "foo";
in multiple source/object files you get lots of pointers
but only one string.
OTOH with:
static const char foo_xxx[] = "foo";
you get lots of copies of the string.
Which is smaller depends on the number of variables and the length
of the string.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

