Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B281D49BE50
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 23:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbiAYWRn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Jan 2022 17:17:43 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:46023 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233633AbiAYWRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 17:17:42 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-64-8G7QQxJmMpexI7aZc5095w-1; Tue, 25 Jan 2022 22:17:40 +0000
X-MC-Unique: 8G7QQxJmMpexI7aZc5095w-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Tue, 25 Jan 2022 22:17:39 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Tue, 25 Jan 2022 22:17:39 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Miles Chen' <miles.chen@mediatek.com>,
        Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kiran Kumar S <kiran.kumar1.s@intel.com>
CC:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Subject: RE: [PATCH] pinctrl: fix a discarded-qualifiers build error
Thread-Topic: [PATCH] pinctrl: fix a discarded-qualifiers build error
Thread-Index: AQHYEhUH+MbwXf5NQkuzulFLQ312/qx0Tidg
Date:   Tue, 25 Jan 2022 22:17:38 +0000
Message-ID: <693a71e17b364afd987f2d2178b7e5cb@AcuMS.aculab.com>
References: <20220125175457.23728-1-miles.chen@mediatek.com>
In-Reply-To: <20220125175457.23728-1-miles.chen@mediatek.com>
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

From: Miles Chen
> Sent: 25 January 2022 17:55
> 
> Fix COMPILER=gcc ARCH=arm64 DEFCONFIG=allyesconfig build:
> 
> log:
> drivers/pinctrl/pinctrl-thunderbay.c:815:29: error: assignment discards
> 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
> 
> Fixes: 12422af8194d ("pinctrl: Add Intel Thunder Bay pinctrl driver")
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> ---
>  drivers/pinctrl/pinctrl-thunderbay.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-thunderbay.c b/drivers/pinctrl/pinctrl-thunderbay.c
> index b5b47f4dd774..4e6d718c03fc 100644
> --- a/drivers/pinctrl/pinctrl-thunderbay.c
> +++ b/drivers/pinctrl/pinctrl-thunderbay.c
> @@ -812,7 +812,7 @@ static int thunderbay_add_functions(struct thunderbay_pinctrl *tpc, struct funct
>  				}
>  			}
> 
> -			grp = func->group_names;
> +			grp = (const char **)func->group_names;

You should change the type of 'grp' not add a cast.
The compiler can warn about casts removing 'const' as well.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

