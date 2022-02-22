Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65BE4C02DF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 21:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbiBVUJy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Feb 2022 15:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235138AbiBVUJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 15:09:52 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10F9910CF2F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 12:09:25 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-273-wA-OKjcrNlClFgeO-K9vQw-1; Tue, 22 Feb 2022 20:09:23 +0000
X-MC-Unique: wA-OKjcrNlClFgeO-K9vQw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Tue, 22 Feb 2022 20:09:22 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Tue, 22 Feb 2022 20:09:21 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Joe Perches' <joe@perches.com>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "colyli@suse.de" <colyli@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: RE: [PATCHv3 04/10] linux/kernel: introduce lower_48_bits macro
Thread-Topic: [PATCHv3 04/10] linux/kernel: introduce lower_48_bits macro
Thread-Index: AQHYKBwQyZzL6Kc8n0eksk5bzcXivKyf/Gmg
Date:   Tue, 22 Feb 2022 20:09:21 +0000
Message-ID: <65fd7d9525b443fcbb15468176fca16a@AcuMS.aculab.com>
References: <20220222163144.1782447-1-kbusch@kernel.org>
         <20220222163144.1782447-5-kbusch@kernel.org>
         <66a0c8210cf9e7dfcc3fa2d247de1eebd5a8acb7.camel@perches.com>
         <20220222165045.GA14168@lst.de>
         <20220222165613.GB1497257@dhcp-10-100-145-180.wdc.com>
 <603f9243bb9e1c4c50aaec83a527266b48ab9e20.camel@perches.com>
In-Reply-To: <603f9243bb9e1c4c50aaec83a527266b48ab9e20.camel@perches.com>
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

From: Joe Perches
> Sent: 22 February 2022 18:43
> 
> On Tue, 2022-02-22 at 08:56 -0800, Keith Busch wrote:
> > On Tue, Feb 22, 2022 at 05:50:45PM +0100, Christoph Hellwig wrote:
> > > On Tue, Feb 22, 2022 at 08:45:53AM -0800, Joe Perches wrote:
> > > > On Tue, 2022-02-22 at 08:31 -0800, Keith Busch wrote:
> > > > > +/ *
> > > > > + * lower_48_bits - return bits 0-47 of a number
> > > > > + * @n: the number we're accessing
> > > > > + */
> > > > > +#define lower_48_bits(n) ((u64)((n) & 0xffffffffffffull))
> > > >
> > > > why not make this a static inline function?
> > >
> > > Agreed.
> >
> > Sure, that sounds good to me. I only did it this way to match the
> > existing local convention, but I personally prefer the inline function
> > too.
> 
> The existing convention is used there to allow the compiler to
> avoid warnings and unnecessary conversions of a u32 to a u64 when
> shifting by 32 or more bits.
> 
> If it's possible to be used with an architecture dependent typedef
> like dma_addr_t, then perhaps it's reasonable to do something like:
> 
> #define lower_48_bits(val)					\
> ({								\
> 	typeof(val) high = lower_16_bits(upper_32_bits(val));	\
> 	typeof(val) low = lower_32_bits(val);			\
> 								\
> 	(high << 16 << 16) | low;				\
> })
> 
> and have the compiler have the return value be an appropriate type.

The compiler could make a real pigs breakfast of that.

For lower_46_bits() an integer promotion to u64 does no harm.
But for some other cases you get in a right mess when values
that should be unsigned get sign extended.

Although I think:
	(val) & (((typeof(val))1 << 48) - 1)
avoids any promotion if anyone tries lower_48_bits(int_var).
(It is even likely to be a compile error.)

Oh, did you look for GENMASK([^,]*,[ 0]*) ?
I'd only use something GENMASK() for bit ranges.
Even then it is often easier to just write the value in hex.

I think the only time I've written anything like that recently
(last 30 years) was for some hardware registers when the documentation
user 'bit 1' for the most significant bit.

It's rather like I just know that (x & (x - 1)) checks for 1 bit being set.
I have to lookup is_power_of_2() to see what it does.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

