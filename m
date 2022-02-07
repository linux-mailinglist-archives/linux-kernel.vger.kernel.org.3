Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B724AC6E9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 18:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386791AbiBGRJs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Feb 2022 12:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381140AbiBGRF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 12:05:28 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 01C12C0401D3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 09:05:26 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-126-qcGumv9DMZugvQ_BnlS8sQ-1; Mon, 07 Feb 2022 17:05:24 +0000
X-MC-Unique: qcGumv9DMZugvQ_BnlS8sQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Mon, 7 Feb 2022 17:05:21 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Mon, 7 Feb 2022 17:05:21 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Willy Tarreau' <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
CC:     Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 11/42] tools/nolibc/types: move the FD_* functions to
 macros in types.h
Thread-Topic: [PATCH 11/42] tools/nolibc/types: move the FD_* functions to
 macros in types.h
Thread-Index: AQHYHEAczsO4tjnh2E+1W1Xc08MG/qyIT4gw
Date:   Mon, 7 Feb 2022 17:05:21 +0000
Message-ID: <083fac943c8c422a9f667f6b0371153c@AcuMS.aculab.com>
References: <20220207162354.14293-1-w@1wt.eu>
 <20220207162354.14293-12-w@1wt.eu>
In-Reply-To: <20220207162354.14293-12-w@1wt.eu>
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

From: Willy Tarreau
> Sent: 07 February 2022 16:23
> 
> FD_SET, FD_CLR, FD_ISSET, FD_ZERO are supposed to be macros and not
> functions.

Are you sure?
I'd have thought they could be either.
There are certainly systems where they are functions.
They can be implemented as an array of fd numbers rather than a bitmap.

> In addition we already have a file dedicated to such macros
> and types used by syscalls, it's types.h, so let's move them
> there and turn them to macros. FD_CLR() and FD_ISSET() were missing,
> so they were added. FD_ZERO() now deals with its own loop so that it
> doesn't rely on memset() that sets one byte at a time.
> 
....
> +#define FD_CLR(fd, set) do {                                            \
> +		int __fd = (int)(fd);                                   \
> +		fd_set *__set = (fd_set *)(set);                        \

I'm not sure you really want either cast.
They are just likely to hide some horrid bugs.

+		if (__fd >= 0 && __fd < FD_SETSIZE)                     \
+			__set->fd32[__fd / 32] &= ~(1U << (__fd & 31)); \
+	} while (0)
+

Do you need the range check?
I don't think glibc has one.
Things just break in obscure ways when you use select on big fd.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

