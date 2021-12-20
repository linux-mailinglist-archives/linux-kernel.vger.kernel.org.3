Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E0247A7B3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 11:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhLTKXU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Dec 2021 05:23:20 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:44227 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231187AbhLTKXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 05:23:19 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-1-5ELj3wkrPNSGHHm-pqNVkA-1; Mon, 20 Dec 2021 10:23:17 +0000
X-MC-Unique: 5ELj3wkrPNSGHHm-pqNVkA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26; Mon, 20 Dec 2021 10:23:16 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.026; Mon, 20 Dec 2021 10:23:16 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jason Wang' <wangborong@cdjrlc.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>
CC:     "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] powerpc: use strscpy to copy strings
Thread-Topic: [PATCH] powerpc: use strscpy to copy strings
Thread-Index: AQHX9VEUZ6FjgeLc1kWSeYk5lSMsIaw7KVuQ
Date:   Mon, 20 Dec 2021 10:23:16 +0000
Message-ID: <c82f01143a174c8281930158e4804a4b@AcuMS.aculab.com>
References: <20211220032402.630240-1-wangborong@cdjrlc.com>
In-Reply-To: <20211220032402.630240-1-wangborong@cdjrlc.com>
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

From: Jason Wang
> Sent: 20 December 2021 03:24
> 
> The strlcpy should not be used because it doesn't limit the source
> length. So that it will lead some potential bugs.
> 
> But the strscpy doesn't require reading memory from the src string
> beyond the specified "count" bytes, and since the return value is
> easier to error-check than strlcpy()'s. In addition, the implementation
> is robust to the string changing out from underneath it, unlike the
> current strlcpy() implementation.
> 
> Thus, replace strlcpy with strscpy.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  arch/powerpc/platforms/pasemi/misc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/pasemi/misc.c b/arch/powerpc/platforms/pasemi/misc.c
> index 1bf65d02d3ba..06a1ffd43bfe 100644
> --- a/arch/powerpc/platforms/pasemi/misc.c
> +++ b/arch/powerpc/platforms/pasemi/misc.c
> @@ -35,7 +35,7 @@ static int __init find_i2c_driver(struct device_node *node,
>  	for (i = 0; i < ARRAY_SIZE(i2c_devices); i++) {
>  		if (!of_device_is_compatible(node, i2c_devices[i].of_device))
>  			continue;
> -		if (strlcpy(info->type, i2c_devices[i].i2c_type,
> +		if (strscpy(info->type, i2c_devices[i].i2c_type,
>  			    I2C_NAME_SIZE) >= I2C_NAME_SIZE)
>  			return -ENOMEM;

Isn't that the wrong overflow check?
Doesn't strscpy() return a -ve errno value on failure
(just to cause a different buffer overflow issue?)

Not that any kind of overflow is actually possible in that over-engineered
code fragment.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

