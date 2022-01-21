Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F169495FD6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 14:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350557AbiAUNeY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 21 Jan 2022 08:34:24 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:57526 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235175AbiAUNeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 08:34:23 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-158-ysBuzeI9M8SqWpb1UFyJlg-1; Fri, 21 Jan 2022 13:34:20 +0000
X-MC-Unique: ysBuzeI9M8SqWpb1UFyJlg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Fri, 21 Jan 2022 13:34:19 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Fri, 21 Jan 2022 13:34:19 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jiapeng Chong' <jiapeng.chong@linux.alibaba.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: RE: [PATCH] staging: pi433: using div64_u64() instead of do_div()
Thread-Topic: [PATCH] staging: pi433: using div64_u64() instead of do_div()
Thread-Index: AQHYDr0JeXBHu5JbA0ymi5sg9Q/cbqxteQpg
Date:   Fri, 21 Jan 2022 13:34:19 +0000
Message-ID: <03591933cc384d7e91ede82f0cdd76a8@AcuMS.aculab.com>
References: <20220121114955.96979-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20220121114955.96979-1-jiapeng.chong@linux.alibaba.com>
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

From: Jiapeng Chong
> Sent: 21 January 2022 11:50
> Subject: [PATCH] staging: pi433: using div64_u64() instead of do_div()
> 
> Clean the following coccicheck warning:
> 
> ./drivers/staging/pi433/rf69.c:286:1-7: WARNING: do_div() does a
> 64-by-32 division, please consider using div64_u64 instead.

That is one of patchcheck's worse warnings.

You need to check the domain of the divisor, not its type.

do_div() exists to avoid expensive 64bit divides when the
divisor is small.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

