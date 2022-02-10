Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27CD4B09E5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 10:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239013AbiBJJs5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 10 Feb 2022 04:48:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239025AbiBJJss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 04:48:48 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC204138
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 01:48:48 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-48-zq-35qpQOqaQZ_cZnG8zjw-1; Thu, 10 Feb 2022 09:48:45 +0000
X-MC-Unique: zq-35qpQOqaQZ_cZnG8zjw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Thu, 10 Feb 2022 09:48:44 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Thu, 10 Feb 2022 09:48:44 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     =?iso-8859-1?Q?=27Uwe_Kleine-K=F6nig=27?= 
        <u.kleine-koenig@pengutronix.de>, Qing Wang <wangqing@vivo.com>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] pwm: use div64_u64() instead of do_div()
Thread-Topic: [PATCH] pwm: use div64_u64() instead of do_div()
Thread-Index: AQHYHclpMmDYeR7Hx0KRNkbIRj4HSKyMibOg
Date:   Thu, 10 Feb 2022 09:48:44 +0000
Message-ID: <9273cd6497354dd882faf55b194ff590@AcuMS.aculab.com>
References: <1644395998-4397-1-git-send-email-wangqing@vivo.com>
 <20220209152609.gqeivcehkuzgz3sk@pengutronix.de>
In-Reply-To: <20220209152609.gqeivcehkuzgz3sk@pengutronix.de>
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

From: Uwe Kleine-König
> Sent: 09 February 2022 15:26
...
> > -	do_div(cycles, period_ns);
> > +	div64_u64(cycles, period_ns);
> 
> This is wrong, div64_u64() has a different calling convention than do_div().
> 
> The issue however is real. Please add

Not really although I can't see a check I'd assume that period_ns
is expected to be much less than a second - so well under 32 bits
There is certainly a general expectation that multiplying by
other 'largish' values won't exceed 64 bits.

Plausible the pwm 'period' should actually be a u32.
But then care would be needed to ensure the multiplies have
64bit results.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

