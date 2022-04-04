Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C874F1E6E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbiDDVvk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Apr 2022 17:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379415AbiDDRJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 13:09:14 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 69EB340A22
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 10:07:17 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-170-mCYWs2NyMrqY9YLkljzOvg-1; Mon, 04 Apr 2022 18:07:14 +0100
X-MC-Unique: mCYWs2NyMrqY9YLkljzOvg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Mon, 4 Apr 2022 18:07:11 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Mon, 4 Apr 2022 18:07:11 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Maciej W. Rozycki'" <macro@orcam.me.uk>,
        Kees Cook <keescook@chromium.org>
CC:     James Jones <linux@theinnocuous.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86: Remove a.out support
Thread-Topic: [PATCH] x86: Remove a.out support
Thread-Index: AQHYSBOog1urTOlT506l8VY6NMoEJKzf++oQ
Date:   Mon, 4 Apr 2022 17:07:11 +0000
Message-ID: <08c095230941445f9139ab89bc70da43@AcuMS.aculab.com>
References: <4c449fab-8135-5057-7d2c-7b948ce130cc@theinnocuous.com>
 <0b31b1d3-852d-6cab-82ae-5eecaec05679@theinnocuous.com>
 <202203151150.1CDB1D8DA@keescook>
 <bfbd9394-161b-0e70-00c5-79d0dd722e08@theinnocuous.com>
 <alpine.DEB.2.21.2204022255430.47162@angie.orcam.me.uk>
 <67CF27C5-5013-4EF4-B24C-8D9EB52536FB@chromium.org>
 <alpine.DEB.2.21.2204041135210.47162@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2204041135210.47162@angie.orcam.me.uk>
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

From: Maciej W. Rozycki
> Sent: 04 April 2022 12:04
> 
> On Sat, 2 Apr 2022, Kees Cook wrote:
> 
> > > Chiming in late as I'm scanning outstanding mailing list traffic: if this
> > >is as you say all statically linked stuff, then converting from a.out to
> > >ELF might be as easy as:
> > >
> > >$ objcopy -I a.out-i386-linux -O elf32-i386 a.out-binary elf-binary
> >
> > Based on my research (and the wrapper I ended up writing), I don't think
> > this is sufficient because entry point handling is different between ELF
> > and a.out (specifically the stack layout and initial sp register value).
> 
>  Fair enough.  I guess the exact value of %esp doesn't matter that much
> (why would it?), but the arguments and environment may well be structured
> differently (and indeed based on a glance over binfmt_aout.c there's extra
> indirection involved compared to the ELF i386 psABI).

You could write a custom 'elf interpreter'.
Hacking at those isn't for the faint-hearted :-)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

