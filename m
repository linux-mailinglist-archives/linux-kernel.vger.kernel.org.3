Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BECF4E3FA9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235688AbiCVNj1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Mar 2022 09:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234214AbiCVNjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:39:25 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74B8C273E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 06:37:56 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-268-V_ky3gfUOuOFokGV86_QzA-1; Tue, 22 Mar 2022 13:37:54 +0000
X-MC-Unique: V_ky3gfUOuOFokGV86_QzA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Tue, 22 Mar 2022 13:37:54 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Tue, 22 Mar 2022 13:37:54 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Willy Tarreau' <w@1wt.eu>, Ammar Faizi <ammarfaizi2@gnuweeb.org>
CC:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: RE: [RFC PATCH v2 3/8] tools/nolibc: i386: Implement syscall with 6
 arguments
Thread-Topic: [RFC PATCH v2 3/8] tools/nolibc: i386: Implement syscall with 6
 arguments
Thread-Index: AQHYPdalMvftIu2CIkSH1LImoy2kmazLRP7AgAAL3z2AABVNYA==
Date:   Tue, 22 Mar 2022 13:37:54 +0000
Message-ID: <22fd9709b3a64a548226741b682ca155@AcuMS.aculab.com>
References: <20220322102115.186179-1-ammarfaizi2@gnuweeb.org>
 <20220322102115.186179-4-ammarfaizi2@gnuweeb.org>
 <8653f6784a9b4272a59a75a530663567@AcuMS.aculab.com>
 <a8eeec1d-656d-15a3-dde5-0f8cc8c5956b@gnuweeb.org>
 <20220322121338.GD10306@1wt.eu>
In-Reply-To: <20220322121338.GD10306@1wt.eu>
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willy Tarreau
> Sent: 22 March 2022 12:14
> 
> On Tue, Mar 22, 2022 at 07:02:53PM +0700, Ammar Faizi wrote:
> > I propose the
> > following macro (this is not so much different with other my_syscall macro),
> > expect the 6th argument can be in reg or mem.
> >
> > The "rm" constraint here gives the opportunity for the compiler to use %ebp
> > instead of memory if -fomit-frame-pointer is turned on.
> >
> > #define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6) \
> > ({                                                         \
> >     long _ret;                                             \
> >     register long _num asm("eax") = (num);                 \
> >     register long _arg1 asm("ebx") = (long)(arg1);         \
> >     register long _arg2 asm("ecx") = (long)(arg2);         \
> >     register long _arg3 asm("edx") = (long)(arg3);         \
> >     register long _arg4 asm("esi") = (long)(arg4);         \
> >     register long _arg5 asm("edi") = (long)(arg5);         \
> >     long _arg6 = (long)(arg6); /* Might be in memory */    \
> >                                                            \
> >     asm volatile (                                         \
> >         "pushl  %[_arg6]\n\t"                              \
> >         "pushl  %%ebp\n\t"                                 \
> >         "movl   4(%%esp), %%ebp\n\t"                       \
> >         "int    $0x80\n\t"                                 \
> >         "popl   %%ebp\n\t"                                 \
> >         "addl   $4,%%esp\n\t"                              \
> >         : "=a"(_ret)                                       \
> >         : "r"(_num), "r"(_arg1), "r"(_arg2), "r"(_arg3),   \
> >           "r"(_arg4),"r"(_arg5), [_arg6]"rm"(_arg6)        \
> >         : "memory", "cc"                                   \
> >     );                                                     \
> >     _ret;                                                  \
> > })
> >
> > What do you think?
> 
> Hmmm indeed that comes back to the existing constructs and is certainly
> more in line with the rest of the code (plus it will not be affected by
> -O0).

I'd add an 'always_inline' to the function.
That will force inline even with -O0.

> I seem to remember a register allocation issue which kept me away from
> implementing it this way on i386 back then, but given that my focus was
> not as much on i386 as it was on other platforms, it's likely that I have
> not insisted too much and not tried this one which looks like the way to
> go to me.

dunno, 'asm' register variables are rather more horrid and
should probably only be used (for asm statements) when there aren't
suitable register constraints.

(I'm sure there is a comment about that in the gcc docs.)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

