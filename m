Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC234AA92F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 14:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380025AbiBENio convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 5 Feb 2022 08:38:44 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:53777 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1380015AbiBENin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 08:38:43 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-95-HcbmPPd0MRO8RZEsIYtPtQ-1; Sat, 05 Feb 2022 13:38:40 +0000
X-MC-Unique: HcbmPPd0MRO8RZEsIYtPtQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Sat, 5 Feb 2022 13:38:39 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Sat, 5 Feb 2022 13:38:39 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Yury Norov' <yury.norov@gmail.com>,
        Kees Cook <keescook@chromium.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH] iio: stmpe-adc: Use correctly sized arguments for bit
 field
Thread-Topic: [PATCH] iio: stmpe-adc: Use correctly sized arguments for bit
 field
Thread-Index: AQHYGX/W1vB0TJBlQkimao6oVwCSvqyE956A
Date:   Sat, 5 Feb 2022 13:38:39 +0000
Message-ID: <d8a79e103aaa40d2840e56a692762b23@AcuMS.aculab.com>
References: <20211215232513.2070158-1-keescook@chromium.org>
 <YfyrspBCYjH56xEU@yury-laptop>
In-Reply-To: <YfyrspBCYjH56xEU@yury-laptop>
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yury Norov
> Sent: 04 February 2022 04:30
> 
> On Wed, Dec 15, 2021 at 03:25:13PM -0800, Kees Cook wrote:
> > The find.h APIs are designed to be used only on unsigned long arguments.
> > This can technically result in a over-read, but it is harmless in this
> > case. Regardless, fix it to avoid the warning seen under -Warray-bounds,
> > which we'd like to enable globally:
> >
...
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  drivers/iio/adc/stmpe-adc.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/adc/stmpe-adc.c b/drivers/iio/adc/stmpe-adc.c
> > index fba659bfdb40..d2d405388499 100644
> > --- a/drivers/iio/adc/stmpe-adc.c
> > +++ b/drivers/iio/adc/stmpe-adc.c
> > @@ -256,6 +256,7 @@ static int stmpe_adc_probe(struct platform_device *pdev)
> >  	struct stmpe_adc *info;
> >  	struct device_node *np;
> >  	u32 norequest_mask = 0;
> > +	unsigned long bits;
> >  	int irq_temp, irq_adc;
> >  	int num_chan = 0;
> >  	int i = 0;
> > @@ -309,8 +310,8 @@ static int stmpe_adc_probe(struct platform_device *pdev)
> >
> >  	of_property_read_u32(np, "st,norequest-mask", &norequest_mask);
> >
> > -	for_each_clear_bit(i, (unsigned long *) &norequest_mask,
> > -			   (STMPE_ADC_LAST_NR + 1)) {
> > +	bits = norequest_mask;
> 
> This would not work on 64-bit BE architecture. It should use bitmap_from_arr32()

The old version was wrong on 64 bit BE, Kees version is probably ok.

But changing norequest_mask to 'unsigned long' is probably neater.
OTOH using the bitmap functions on single words is just bloat.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

