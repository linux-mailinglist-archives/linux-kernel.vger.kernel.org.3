Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E918A559B86
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 16:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbiFXO3D convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 24 Jun 2022 10:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiFXO3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:29:02 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F57D54BF8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 07:29:00 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-118-bG_zLhqYP3-nJdlCra2C_g-1; Fri, 24 Jun 2022 15:28:57 +0100
X-MC-Unique: bG_zLhqYP3-nJdlCra2C_g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Fri, 24 Jun 2022 15:28:55 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Fri, 24 Jun 2022 15:28:55 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Joe Perches' <joe@perches.com>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
CC:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 01/12] regmap-irq: Convert bool bitfields to unsigned
 int
Thread-Topic: [PATCH v2 01/12] regmap-irq: Convert bool bitfields to unsigned
 int
Thread-Index: AQHYh9CnysjgLv0l70Wg+yJVLCyDEK1enHCA
Date:   Fri, 24 Jun 2022 14:28:55 +0000
Message-ID: <b9da7e05ce96443cacc1df9b2672eb51@AcuMS.aculab.com>
References: <20220623211420.918875-1-aidanmacdonald.0x0@gmail.com>
         <20220623211420.918875-2-aidanmacdonald.0x0@gmail.com>
         <CAHp75VfTqTfMsrdqyqRj61JAAJ4a_h3rrFriY2d+rrqpVviy=w@mail.gmail.com>
         <YrWqAqGUuy8Z0F3x@sirena.org.uk>
         <4937c0cc9dbc9d06cb626465bd37cbcf76c80a0b.camel@perches.com>
         <Z2ggoG49naOiT1BMxPbsMc2zOjAUEnha@localhost>
 <ca26910886a765dd7edc4815ef90bedbd0f99a95.camel@perches.com>
In-Reply-To: <ca26910886a765dd7edc4815ef90bedbd0f99a95.camel@perches.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Perches 
> Sent: 24 June 2022 14:45
...
> I'm trying to show that conversions of bool:1->unsigned int:1
> as being trivial are not so trivial after all.
> 
> It's fairly common to have code like:
> 
> 	[bool] foo.bar = some_value & SETTING;
> 
> where some value is tested for a mask/bit and a non-zero is true.
> 
> So conversions of foo.bar from bool:1 to unsigned int:1 are not
> wise unless all possible side effects are known.

I can never decide whether:
	bool_c = bool_a & bool_b;
can be compiled to a simple 'and' instruction, or requires a
load of instructions in case bool_a and/or bool_b has a non-zero
value without the bottom bit set.

All other C types are cpu register types - so you know what happens.
IMHO bool is an abomination and should not be used :-)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

