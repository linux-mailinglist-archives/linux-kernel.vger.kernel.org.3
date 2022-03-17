Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60F64DBD08
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 03:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358443AbiCQCdx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 16 Mar 2022 22:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbiCQCdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 22:33:49 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31DF11FA4E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 19:32:34 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-28-TfXkqhZKOkGnjBRqD1P3bg-1; Thu, 17 Mar 2022 02:32:31 +0000
X-MC-Unique: TfXkqhZKOkGnjBRqD1P3bg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Thu, 17 Mar 2022 02:32:30 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Thu, 17 Mar 2022 02:32:29 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Kees Cook' <keescook@chromium.org>,
        James Jones <linux@theinnocuous.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86: Remove a.out support
Thread-Topic: [PATCH] x86: Remove a.out support
Thread-Index: AQHYOYVhiI2rWSVwnUW0pCDz/QTpF6zC2QRw
Date:   Thu, 17 Mar 2022 02:32:29 +0000
Message-ID: <5161ace381a74a63b58b0a2a2a2cb57d@AcuMS.aculab.com>
References: <4c449fab-8135-5057-7d2c-7b948ce130cc@theinnocuous.com>
 <0b31b1d3-852d-6cab-82ae-5eecaec05679@theinnocuous.com>
 <202203151150.1CDB1D8DA@keescook>
 <bfbd9394-161b-0e70-00c5-79d0dd722e08@theinnocuous.com>
 <CAK8P3a28dpyEM2+vM+ePZzeFc539b7w_8FDEoRke-j+3AQVZAA@mail.gmail.com>
 <202203161523.857B469@keescook>
In-Reply-To: <202203161523.857B469@keescook>
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

From: Kees Cook
> Sent: 16 March 2022 22:30
> 
> On Wed, Mar 16, 2022 at 01:38:31PM +0100, Arnd Bergmann wrote:
> > is in the end, but it's likely easier than a standalone a.out loader
> > in user space, or a conversion to ELF format.
> 
> Yeah, the exec format is really simple. The only tricky bit was preparing
> the stack and making sure everything landed in the right place for text
> and data. James, can you try this? aln and mac run for me, but I'm not
> actually exercising them beyond dumping argument lists, etc:

Doesn't that restrict the a.out program to the address space below
the normal base address for elf programs?
So you'll only be able to load small programs - which might be ok here.

OTOH it might be possible to link the 'loader program' to a high
address - the elf loader will probably just load it.
Best to link it static to avoid shared lib mmaps
and probably try to avoid libc calls.

I was wondering what happens when malloc() starts using
sbrk() - but I guess it sees the top of the bss for the
loaded and it all works fine.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

