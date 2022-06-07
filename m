Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56DF54013A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245418AbiFGOXm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 7 Jun 2022 10:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244855AbiFGOXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:23:36 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5C2866CA7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 07:23:30 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-160-GwpNDfyfMIKAFzFYkoJBmA-1; Tue, 07 Jun 2022 15:23:27 +0100
X-MC-Unique: GwpNDfyfMIKAFzFYkoJBmA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Tue, 7 Jun 2022 15:23:26 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Tue, 7 Jun 2022 15:23:25 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Michael Ellerman' <mpe@ellerman.id.au>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
CC:     Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: RE: outside array bounds error on ppc64_defconfig, GCC 12.1.0
Thread-Topic: outside array bounds error on ppc64_defconfig, GCC 12.1.0
Thread-Index: AQHYehMfGrZ1ohRgvU+RLIptsHpWBK1D/qnw
Date:   Tue, 7 Jun 2022 14:23:25 +0000
Message-ID: <d38aeb0d6f2040369256ee640b44fafe@AcuMS.aculab.com>
References: <YpbUcPrm61RLIiZF@debian.me> <87mtepns81.fsf@mpe.ellerman.id.au>
In-Reply-To: <87mtepns81.fsf@mpe.ellerman.id.au>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman
> Sent: 07 June 2022 03:05
> 
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
> > Hi,
> >
> > I'm trying to verify Drop ppc_inst_as_str() patch on [1] by performing
> > ppc64_defconfig build with powerpc64-unknown-linux-gnu-gcc (GCC 12.1.0).
> > The patch is applied on top of powerpc tree, next branch.
> 
> Yeah I see it too.
> 
> > I got outside array bounds error:
> >
> >   CC      arch/powerpc/kernel/dbell.o
> > In function 'do_byte_reverse',
> >     inlined from 'do_vec_store' at arch/powerpc/lib/sstep.c:722:3,
> >     inlined from 'emulate_loadstore' at arch/powerpc/lib/sstep.c:3509:9:
> > arch/powerpc/lib/sstep.c:286:25: error: array subscript [3, 4] is outside array bounds of 'union
> <anonymous>[1]' [-Werror=array-bounds]
> >   286 |                 up[0] = byterev_8(up[3]);
> >       |                         ^~~~~~~~~~~~~~~~
> >
> > arch/owerpc/lib/sstep.c: In function 'emulate_loadstore':
> > arch/powerpc/lib/sstep.c:708:11: note: at offset [24, 39] into object 'u' of size 16
> >   708 |         } u;
> >       |           ^
> > In function 'do_byte_reverse',
> >     inlined from 'do_vec_store' at arch/powerpc/lib/sstep.c:722:3,
> >     inlined from 'emulate_loadstore' at arch/powerpc/lib/sstep.c:3509:9:
> > arch/powerpc/lib/sstep.c:287:23: error: array subscript [3, 4] is outside array bounds of 'union
> <anonymous>[1]' [-Werror=array-bounds]
> >   287 |                 up[3] = tmp;
> >       |                 ~~~~~~^~~~~
> 
> This happens because we have a generic byte reverse function
> (do_byte_reverse()), that takes a size as a parameter. So it will
> reverse 8, 16, 32 bytes etc.
> 
> In some cases the compiler can see that we're passing a pointer to
> storage that is smaller than 32 bytes, but it isn't convinced that the
> size parameter is also smaller than 32 bytes.
> 
> Which I think is reasonable, the code that sets the size is separate
> from this code, so the compiler can't really deduce that it's safe.
> 
> I don't see a really simple fix. I tried clamping the size parameter to
> do_byte_reverse() with max(), but that didn't work :/

I had a quick look at the code - it is somewhat horrid!
Not really surprising the compiler is confused.
Although it shouldn't be outputting that error message
unless it is certain.

Could it be re-written to read the data into an __u128
(or whatever the compiler type is).
Optionally byteswap the entire thing (swap the words and
then byteswap each word).
The do a put_user_8/16/32/64() to write out the value.

I think that would remove all the memory accesses and make
it a lot faster as well.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

