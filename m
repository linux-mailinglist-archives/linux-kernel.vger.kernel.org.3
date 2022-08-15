Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1F8592DA0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbiHOK7l convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 15 Aug 2022 06:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiHOK7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 06:59:31 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0ECE21260
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 03:59:29 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-67-rcu_PtKqP8eoCWaPzqMOGA-1; Mon, 15 Aug 2022 11:59:26 +0100
X-MC-Unique: rcu_PtKqP8eoCWaPzqMOGA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.38; Mon, 15 Aug 2022 11:59:26 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.040; Mon, 15 Aug 2022 11:59:26 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Pavel Machek' <pavel@ucw.cz>,
        Yu-Jen Chang <arthurchang09@gmail.com>
CC:     "andy@kernel.org" <andy@kernel.org>,
        "akinobu.mita@gmail.com" <akinobu.mita@gmail.com>,
        "jserv@ccns.ncku.edu.tw" <jserv@ccns.ncku.edu.tw>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/2] Optimize memchr()
Thread-Topic: [PATCH 0/2] Optimize memchr()
Thread-Index: AQHYrn6nxbqvf/0XNUiVCIKBvUkbVq2vzrlA
Date:   Mon, 15 Aug 2022 10:59:26 +0000
Message-ID: <e234b9e1314b48ac9940644616a9757a@AcuMS.aculab.com>
References: <20220710142822.52539-1-arthurchang09@gmail.com>
 <20220812190631.GA1347@bug>
In-Reply-To: <20220812190631.GA1347@bug>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Machek
> Sent: 12 August 2022 20:07
> 
> Hi!
> 
> > This patche series optimized "memchr()" and add a macro for
> > "memchr_inv()" so that both funtions can use it to generate bit mask.
> >
> > The original implementaion of "memchr()" is based on byte-wise comparison,
> > which do not fully use 64-bit or 32-bit register in CPU. We implement a
> > word-wise comparison so that at least 4 bytes can be compared at the same
> > time. The optimized "memchr()" is nearly 4x faster than the original one
> > for long strings. In Linux Kernel, we find that the length of the string
> 
> Well... how much slower is it for short strings?

And cold cache??

	David

> > searched by "memchr()" is up to 512 bytes in drivers/misc/lkdtm/heap.c.
> > In our test, the optimized version is about 20% faster if the target
> > character is at the end of the string when going through a 512-byte
> > string.
> 
> "What is the average length passed to memchr" would be more useful question.
> 
> Best regards,
> 								Pavel

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

