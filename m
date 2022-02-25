Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD194C50F7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 22:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbiBYVvg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 25 Feb 2022 16:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbiBYVv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 16:51:29 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E36672118E4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 13:50:55 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-112-w1ITZkChPlS7OAK-8FapSw-1; Fri, 25 Feb 2022 21:50:53 +0000
X-MC-Unique: w1ITZkChPlS7OAK-8FapSw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Fri, 25 Feb 2022 21:50:51 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Fri, 25 Feb 2022 21:50:51 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Michal Simek' <michal.simek@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "git@xilinx.com" <git@xilinx.com>
CC:     Mahesh Bodapati <mbodapat@xilinx.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: RE: [PATCH v2 2/3] microblaze: Do loop unrolling for optimized memset
 implementation
Thread-Topic: [PATCH v2 2/3] microblaze: Do loop unrolling for optimized
 memset implementation
Thread-Index: AQHYKk9znCG7mUdB/U+6GgVbIJ8zwqykzU1g
Date:   Fri, 25 Feb 2022 21:50:50 +0000
Message-ID: <a3621a76457646b58a9deef3e861d362@AcuMS.aculab.com>
References: <cover.1645797329.git.michal.simek@xilinx.com>
 <10a432e269a6d3349cf458e4f5792522779cba0d.1645797329.git.michal.simek@xilinx.com>
In-Reply-To: <10a432e269a6d3349cf458e4f5792522779cba0d.1645797329.git.michal.simek@xilinx.com>
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

From: Michal Simek
> Sent: 25 February 2022 13:56
> 
> Align implementation with memcpy and memmove where also remaining bytes are
> copied via final switch case instead of using simple implementations which
> loop. But this alignment has much stronger reason and definitely aligning
> implementation is not the key point here. It is just good to have in mind
> that the same technique is used already there.
> 
> In GCC 10, now -ftree-loop-distribute-patterns optimization is on at O2.
> This optimization causes GCC to convert the while loop in memset.c into a
> call to memset.

Gah...
That is nearly as brain dead as another compiler that would convert
any byte copy loop (on x86) into 'rep movsb'.

If I want to call memcpy() I'll call memcpy.
If I'm copying a few bytes I might write the loop to avoid
the cost of the call and all the conditional tests for
buffer length and alignment.

Don't the compiler writers have better things to do?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

