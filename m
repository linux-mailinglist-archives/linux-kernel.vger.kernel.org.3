Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595145480FB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 09:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237307AbiFMHz0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Jun 2022 03:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239562AbiFMHxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 03:53:37 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61BF11DA76
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 00:53:25 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-196-fmC_hegiM8eHASEyRoy8hA-1; Mon, 13 Jun 2022 08:53:21 +0100
X-MC-Unique: fmC_hegiM8eHASEyRoy8hA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Mon, 13 Jun 2022 08:53:19 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Mon, 13 Jun 2022 08:53:19 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Joe Damato' <jdamato@fastly.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC,iov_iter v2 3/8] iov_iter: add copyin_iovec helper
Thread-Topic: [RFC,iov_iter v2 3/8] iov_iter: add copyin_iovec helper
Thread-Index: AQHYfjsvbNyOWJFJ/E+wgYg8ABCKpa1M98Iw
Date:   Mon, 13 Jun 2022 07:53:19 +0000
Message-ID: <8f6771a01fe74cde86641e780d31a2ce@AcuMS.aculab.com>
References: <1655024280-23827-1-git-send-email-jdamato@fastly.com>
 <1655024280-23827-4-git-send-email-jdamato@fastly.com>
In-Reply-To: <1655024280-23827-4-git-send-email-jdamato@fastly.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Damato
> Sent: 12 June 2022 09:58
> 
> copyin_iovec is a helper which wraps copyin and selects the right copy
> method based on the iter_copy_type.

A pretty bad description.

> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  lib/iov_iter.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index d32d7e5..6720cb2 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -168,6 +168,15 @@ static int copyin(void *to, const void __user *from, size_t n)
>  	return n;
>  }
> 
> +static int copyin_iovec(void *to, const void __user *from, size_t n,
> +			struct iov_iter *i)
> +{
> +	if (unlikely(iov_iter_copy_is_nt(i)))
> +		return __copy_from_user_nocache(to, from, n);
> +	else
> +		return copyin(to, from, n);
> +}

Isn't this extra conditional going to have a measurable impact
on all the normal copy paths?

The additional costs of all the 'iovec' types is bad enough
already.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

