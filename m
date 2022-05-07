Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5817A51E63E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 12:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446210AbiEGKFA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 7 May 2022 06:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbiEGKE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 06:04:56 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AFD8D3AA67
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 03:01:07 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-285-a07I9tQYN4-ed0PF2CZy2w-1; Sat, 07 May 2022 11:01:04 +0100
X-MC-Unique: a07I9tQYN4-ed0PF2CZy2w-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Sat, 7 May 2022 11:01:03 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Sat, 7 May 2022 11:01:03 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jagdish Gediya' <jvgediya@linux.ibm.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>
Subject: RE: [PATCH] kobject: Refactor kobject_set_name_vargs()
Thread-Topic: [PATCH] kobject: Refactor kobject_set_name_vargs()
Thread-Index: AQHYYU3qLELCyca9fE2SaEK1v39Vvq0R6/5wgAAc1ACAASXE8A==
Date:   Sat, 7 May 2022 10:01:03 +0000
Message-ID: <97b8979ff52c4404bf74eeda574d6b23@AcuMS.aculab.com>
References: <20220506133309.36794-1-jvgediya@linux.ibm.com>
 <5902e26ef400451b966be2dd0fbd1575@AcuMS.aculab.com>
 <YnVZujpw0RZy3eVT@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
In-Reply-To: <YnVZujpw0RZy3eVT@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
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

From: Jagdish Gediya
> Sent: 06 May 2022 18:24
...
> > Are you sure this can ever work from a module?
> > This all relies on:
> >
> > static inline bool is_kernel_rodata(unsigned long addr)
> > {
> > 	return addr >= (unsigned long)__start_rodata &&
> > 	       addr < (unsigned long)__end_rodata;
> > }
> >
> > which isn't going to do anything sane given an "xxx" inside a module.
> >
> > Indeed can kobject_set_name_vargs() end up with a constant string
> > inside a module?
> 
> No, kobject_set_name_vargs() is not exported. I exported
> set_name_vargs() because it can have a broader use, but you are right
> it shouldn't be exported.

I was thinking that some function that creates a 'kobject'
could easily be called from a module - so you end up calling
the set_name code from a module and then end up calling
kfree() on a literal from a module.

Now it might be that it is impossible to actually the quoted
literal from a module into somewhere that is_kernel_rodata()
is applied to.

But, as i said, it is fragile.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

