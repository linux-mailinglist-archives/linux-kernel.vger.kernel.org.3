Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A07C4E1BCA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 14:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245121AbiCTNMC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 20 Mar 2022 09:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235848AbiCTNL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 09:11:59 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 756F51F614
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 06:10:36 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-319-oFCxxHf5MgGGf8WvpDCCEg-1; Sun, 20 Mar 2022 13:10:33 +0000
X-MC-Unique: oFCxxHf5MgGGf8WvpDCCEg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Sun, 20 Mar 2022 13:10:33 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Sun, 20 Mar 2022 13:10:33 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Ammar Faizi' <ammarfaizi2@gnuweeb.org>, Willy Tarreau <w@1wt.eu>
CC:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: RE: [RFC PATCH v1 3/6] tools/nolibc: i386: Implement syscall with 6
 arguments
Thread-Topic: [RFC PATCH v1 3/6] tools/nolibc: i386: Implement syscall with 6
 arguments
Thread-Index: AQHYPD5aHmXDAqFOcUemVcZ8MoFj5azIOuNw
Date:   Sun, 20 Mar 2022 13:10:33 +0000
Message-ID: <2e335ac54db44f1d8496583d97f9dab0@AcuMS.aculab.com>
References: <20220320093750.159991-1-ammarfaizi2@gnuweeb.org>
 <20220320093750.159991-4-ammarfaizi2@gnuweeb.org>
In-Reply-To: <20220320093750.159991-4-ammarfaizi2@gnuweeb.org>
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
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ammar Faizi
> Sent: 20 March 2022 09:38
> 
> In i386, the 6th argument of syscall goes in %ebp. However, both Clang
> and GCC cannot use %ebp in the clobber list and in the "r" constraint
> without using -fomit-frame-pointer. To make it always available for any
> kind of compilation, the below workaround is implemented.
> 
> For clang (the Assembly statement can't clobber %ebp):
>   1) Save the %ebp value to the redzone area -4(%esp).

i386 doesn't have a redzone.
If you get a signal it will trash -4(%sp)

>   2) Load the 6-th argument from memory to %ebp.
>   3) Subtract the %esp by 4.
>   4) Do the syscall (int $0x80).
>   5) Pop %ebp.
> 
> For GCC, fortunately it has a #pragma that can force a specific function
> to be compiled with -fomit-frame-pointer, so it can always use "r"(var)
> where `var` is a variable bound to %ebp.

How is that going to work for an inlined functon?

And using xchg is slow - it is always locked.

One possibility might be to do:
	push arg6
	push %ebp
	mov  %ebp, 4(%sp)
	int  0x80
	pop  %ebp
	add  %esp,4

Although I'm not sure you really want to allocate 4k pages
for every malloc() call.

Probably better to write a mini 'libc' that uses sbrk()
and a best fit scan of a linear free list.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

