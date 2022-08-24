Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC20359FD15
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 16:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238308AbiHXOSu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 Aug 2022 10:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236375AbiHXOSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 10:18:47 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F3E99241
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 07:18:45 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-278-NAqDrFa6OFK4f2CDO1KAlQ-1; Wed, 24 Aug 2022 15:18:42 +0100
X-MC-Unique: NAqDrFa6OFK4f2CDO1KAlQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.38; Wed, 24 Aug 2022 15:18:40 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.040; Wed, 24 Aug 2022 15:18:40 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Yury Norov' <yury.norov@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Dennis Zhou" <dennis@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexey Klimov <aklimov@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Whitcroft <apw@canonical.com>
Subject: RE: [PATCH v2 1/3] lib/find_bit: introduce FIND_FIRST_BIT() macro
Thread-Topic: [PATCH v2 1/3] lib/find_bit: introduce FIND_FIRST_BIT() macro
Thread-Index: AQHYt7wjkucH+HuwAkOnYFo2ww3faK2+F4Aw
Date:   Wed, 24 Aug 2022 14:18:40 +0000
Message-ID: <eed65809f99d49acbbbf3ba3ce6568a0@AcuMS.aculab.com>
References: <20220824012624.2826445-1-yury.norov@gmail.com>
 <20220824012624.2826445-2-yury.norov@gmail.com>
 <CAHp75VcB08oTrB8R9Zyo4Ja=c_XqybqdCw46fY4_MNqvSSCtLQ@mail.gmail.com>
 <YwYlWjlWO3fFrtQp@yury-laptop>
In-Reply-To: <YwYlWjlWO3fFrtQp@yury-laptop>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
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

...
> And generated code looks almost the same, except that
> on x86_64 your version is bigger. Compare before:
> 0000000000000000 <_find_first_bit>:
>    0:   mov    %rsi,%rax
>    3:   test   %rsi,%rsi
>    6:   je     35 <_find_first_bit+0x35>
>    8:   xor    %edx,%edx
>    a:   jmp    19 <_find_first_bit+0x19>
>    c:   add    $0x40,%rdx               // Track bits and
>   10:   add    $0x8,%rdi                // index separately

That add is free - happens in parallel with other instrutcions

>   14:   cmp    %rax,%rdx
>   17:   jae    35 <_find_first_bit+0x35>

The instructions below will (probably/hopefully) be
speculatively executed in parallel with the cmp/jae above

>   19:   mov    (%rdi),%rcx
>   1c:   test   %rcx,%rcx
>   1f:   je     c <_find_first_bit+0xc>
>   21:   tzcnt  %rcx,%rcx
>   26:   add    %rdx,%rcx
>   29:   cmp    %rcx,%rax
>   2c:   cmova  %rcx,%rax
>   30:   jmp    35 <_find_first_bit+0x35>
>   35:   jmp    3a <_find_first_bit+0x3a>
>   3a:   nopw   0x0(%rax,%rax,1)
> 
> And after:
> 0000000000000000 <_find_first_bit>:
>    0:   mov    %rsi,%rax
>    3:   test   %rsi,%rsi
>    6:   je     39 <_find_first_bit+0x39>
>    8:   xor    %edx,%edx
>    a:   jmp    15 <_find_first_bit+0x15>
>    c:   add    $0x40,%rdx               // Track bits only
>   10:   cmp    %rdx,%rax
>   13:   jbe    39 <_find_first_bit+0x39>
>   15:   mov    %rdx,%rcx
>   18:   shr    $0x6,%rcx                // But divide here
>   1c:   mov    (%rdi,%rcx,8),%rcx
>   20:   test   %rcx,%rcx

That is a long register dependency chain involving %cx.
It will limit the execution speed to (at least 6) clocks/iteration.
The older version might be 3 clocks/iteration.
So this could easily run at half the speed.

	David

>   23:   je     c <_find_first_bit+0xc>
>   25:   tzcnt  %rcx,%rcx
>   2a:   add    %rcx,%rdx
>   2d:   cmp    %rdx,%rax
>   30:   cmova  %rdx,%rax
>   34:   jmp    39 <_find_first_bit+0x39>
>   39:   jmp    3e <_find_first_bit+0x3e>
>   3e:   xchg   %ax,%ax                  // Which adds 4 bytes to .text
> 
> Thanks,
> Yury
> 
> > > +               val = (EXPRESSION);                                             \
> > > +               if (val) {                                                      \
> > > +                       sz = min(idx * BITS_PER_LONG + __ffs(word_op(val)), sz);\
> >
> > sz = min(idx + __ffs(...));
> >
> > > +                       break;                                                  \
> > > +               }                                                               \
> > > +       }                                                                       \
> > > +                                                                               \
> > > +       sz;                                                                     \
> > > +})
> >
> >
> > --
> > With Best Regards,
> > Andy Shevchenko

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

