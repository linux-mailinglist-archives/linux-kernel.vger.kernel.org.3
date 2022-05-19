Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E0052DEF2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 23:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245022AbiESVGi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 19 May 2022 17:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244979AbiESVGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 17:06:36 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 30C8C5BE56
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 14:06:29 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-94-pLza9LL4PAeN7Tz7PiBzzA-1; Thu, 19 May 2022 22:06:25 +0100
X-MC-Unique: pLza9LL4PAeN7Tz7PiBzzA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Thu, 19 May 2022 22:06:24 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Thu, 19 May 2022 22:06:24 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Kent Overstreet' <kent.overstreet@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@vger.kernel.org" <linux-mm@vger.kernel.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>
CC:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "willy@infradead.org" <willy@infradead.org>
Subject: RE: [PATCH v2 03/28] vsprintf: %pf(%p)
Thread-Topic: [PATCH v2 03/28] vsprintf: %pf(%p)
Thread-Index: AQHYa6VkVQCoxy629k+LRSm5RxWDEq0mrmAQ
Date:   Thu, 19 May 2022 21:06:24 +0000
Message-ID: <141b17a257274fc38291cdb07e0e23b6@AcuMS.aculab.com>
References: <20220519172421.162394-1-kent.overstreet@gmail.com>
 <20220519172421.162394-4-kent.overstreet@gmail.com>
In-Reply-To: <20220519172421.162394-4-kent.overstreet@gmail.com>
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

From: Kent Overstreet
> Sent: 19 May 2022 18:24
> 
> This implements two new format strings: both do the same thing, one more
> compatible with current gcc format string checking, the other that we'd
> like to standardize:
> 
>  %p(%p) - more compatible
>  %(%p)  - more prettier
> 
> Both can take variable numbers of arguments, i.e. %(%p,%p,%p).
> 
> They're used to indicate that snprintf or pr_buf should interpret the
> next argument as a pretty-printer function to call, and subsequent
> arguments within the parentheses should be passed to the pretty-printer.

I suspect this a very good way to blow the kernel stack.
The highest stack use is already very likely to be inside
the printf code in an error path somewhere.

...
> The goal is to replace most of our %p format extensions with this
> interface, and to move pretty-printers out of the core vsprintf.c code -

One advantage of the current scheme is that is reasonably safe
and easy to use.
Perhaps too many extra formats have been added recently.
This all seems like a recipe for disaster with functions being
called with the wrong number of parameters
(I can't think how you can compile-time check it).

Double copying using a temporary buffer isn't the end of the world.
It is only a problem because pr_cont() is basically impossible.
But since kernel printf ought to be formatted to reasonable
line length that isn't really an issue.
printf() is expensive an extra memory copy is probably noise.

...
> Currently, we can only call pretty printers with pointer arguments. This
> could be changed to also allow at least integer arguments in the future
> by using libffi.

I'm sure I remember something else trying to use that.
IIRC it is basically broken by design.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

