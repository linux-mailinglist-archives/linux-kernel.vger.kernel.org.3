Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7438B577CDA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 09:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiGRHvy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 18 Jul 2022 03:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiGRHvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 03:51:52 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4FDAB140A0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 00:51:51 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-252-gbDn5GdWMXeh8y7fCCM7XA-1; Mon, 18 Jul 2022 08:51:48 +0100
X-MC-Unique: gbDn5GdWMXeh8y7fCCM7XA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Mon, 18 Jul 2022 08:51:45 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Mon, 18 Jul 2022 08:51:45 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Michael Ellerman' <mpe@ellerman.id.au>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Kees Cook <keescook@chromium.org>
CC:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Subject: RE: mainline build failure of powerpc allmodconfig for
 prom_init_check
Thread-Topic: mainline build failure of powerpc allmodconfig for
 prom_init_check
Thread-Index: AQHYmmCqgiI6vbQbKkWuMJXdAKKy2K2Dv4mw
Date:   Mon, 18 Jul 2022 07:51:45 +0000
Message-ID: <72a95f0949d149d1b07bd161f3d59cc1@AcuMS.aculab.com>
References: <Ys/aDKZNhhsENH9S@debian>
 <CADVatmO9XzFnX+N0TuOtr0FYyxKr1oe5RAhCEJjmnvjteT5QNw@mail.gmail.com>
 <87cze3docs.fsf@mpe.ellerman.id.au>
In-Reply-To: <87cze3docs.fsf@mpe.ellerman.id.au>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman
> Sent: 18 July 2022 05:41
...
> So we're memsetting all of args to 254, not zero.
> 
> That's happening because allmodconfig with gcc 12 enables
> CONFIG_INIT_STACK_ALL_PATTERN, whereas gcc 11 doesn't.

I can't help feeling it would be better if that generated
a call to a memset64() function.
Saving loads of tests at the top of the function,
and (most of?) the constant expansion to 64bit.

Although and explicit 'stack clear' function would be better
for the kernel - since it would give the option of patching
it away at startup.

I really can't help feeling that initialising on-stack
arrays will kill performance.
While kernel stack frames have to be relatively small,
in userspace very large on-stack arrays can be allocated
(and correctly bound checked) knowing that the cost is
minimal (maybe a TLB miss).

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

