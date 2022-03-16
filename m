Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF094DB6E0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 18:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352867AbiCPRG1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 16 Mar 2022 13:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbiCPRG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 13:06:26 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5505446B25
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 10:05:11 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-40-kHM77aNRMluU0HPtzKF3Hw-1; Wed, 16 Mar 2022 17:05:08 +0000
X-MC-Unique: kHM77aNRMluU0HPtzKF3Hw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Wed, 16 Mar 2022 17:05:07 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Wed, 16 Mar 2022 17:05:07 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Kees Cook' <keescook@chromium.org>,
        James Jones <linux@theinnocuous.com>
CC:     "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86: Remove a.out support
Thread-Topic: [PATCH] x86: Remove a.out support
Thread-Index: AQHYOVBkiI2rWSVwnUW0pCDz/QTpF6zCOwVw
Date:   Wed, 16 Mar 2022 17:05:07 +0000
Message-ID: <8e9db4d6ff614006869eaa412a536fa0@AcuMS.aculab.com>
References: <4c449fab-8135-5057-7d2c-7b948ce130cc@theinnocuous.com>
 <0b31b1d3-852d-6cab-82ae-5eecaec05679@theinnocuous.com>
 <202203151150.1CDB1D8DA@keescook>
 <bfbd9394-161b-0e70-00c5-79d0dd722e08@theinnocuous.com>
 <202203160909.B1A022B@keescook>
In-Reply-To: <202203160909.B1A022B@keescook>
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
> Sent: 16 March 2022 16:11
> 
> On Wed, Mar 16, 2022 at 05:06:10AM +0000, James Jones wrote:
> > I dug the scripts up in the state they were in when I gave up (September
> > 2020 according to mtime), and put them on github in case anyone wants to
> > have a go at it:
> >
> > https://github.com/cubanismo/aout-to-elf/
> >
> > It was an interesting problem in its own right, and I'd be curious to
> > know what I missed.
> 
> Yeah, this is a good start. I think the main problem is with how program
> entry works, specifically that %esp is pointing to argc (with all the
> args in memory above there), which isn't the way ELF sets %esp.
> 
> It might be possible to make a userspace loader, though. Hmm.

Could it be fixed up by a small bit of code that the elf interpreter
runs just before jumping the a.out entry point?

Depending on the elf layout it might be enough to just reset %esp.
But if the strings are the wrong side of argv[] and enpv[] the
vectors themselves might need copying further down the stack.

Should be possible to do it as PIC code.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

