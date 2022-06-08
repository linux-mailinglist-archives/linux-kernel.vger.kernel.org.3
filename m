Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E895429D6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbiFHItu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 8 Jun 2022 04:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbiFHItb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:49:31 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B119622C2D7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 01:06:33 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-26-kLYbn_LXNMeR_Z6g1CkFtw-1; Wed, 08 Jun 2022 09:02:31 +0100
X-MC-Unique: kLYbn_LXNMeR_Z6g1CkFtw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Wed, 8 Jun 2022 09:02:30 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Wed, 8 Jun 2022 09:02:30 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jiri Slaby' <jslaby@suse.cz>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 16/36] tty/vt: consolemap: check put_user() in
 con_get_unimap()
Thread-Topic: [PATCH 16/36] tty/vt: consolemap: check put_user() in
 con_get_unimap()
Thread-Index: AQHYelzbvgE+yO9BWkaH8hQ5VjstKK1FJorQ
Date:   Wed, 8 Jun 2022 08:02:30 +0000
Message-ID: <5bf366cc45334bb9a9c3d186ef8d6933@AcuMS.aculab.com>
References: <20220607104946.18710-1-jslaby@suse.cz>
 <20220607104946.18710-16-jslaby@suse.cz>
In-Reply-To: <20220607104946.18710-16-jslaby@suse.cz>
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
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Slaby
> Sent: 07 June 2022 11:49
> 
> Only the return value of copy_to_user() is checked in con_get_unimap().
> Do the same for put_user() of the count too.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
>  drivers/tty/vt/consolemap.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
> index 831450f2bfd1..92b5dddb00d9 100644
> --- a/drivers/tty/vt/consolemap.c
> +++ b/drivers/tty/vt/consolemap.c
> @@ -813,7 +813,8 @@ int con_get_unimap(struct vc_data *vc, ushort ct, ushort __user *uct,
>  	console_unlock();
>  	if (copy_to_user(list, unilist, min(ect, ct) * sizeof(*unilist)))
>  		ret = -EFAULT;
> -	put_user(ect, uct);
> +	if (put_user(ect, uct))
> +		ret = -EFAULT;
>  	kvfree(unilist);
>  	return ret ? ret : (ect <= ct) ? 0 : -ENOMEM;
>  }

How is the user expected to check the result of this code?

AFAICT -ENOMEM is returned if either kmalloc() fails or
the user buffer is too short?
Looks pretty hard to detect which.

I've not looked at the effect of all the patches, but setting
'ret = -ENOMEM' and breaking the loop when the array is too
small would simplify things.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

