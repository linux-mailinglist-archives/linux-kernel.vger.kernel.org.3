Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C804BBD15
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 17:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237529AbiBRQKz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 18 Feb 2022 11:10:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237518AbiBRQKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:10:50 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7D6313C9FD
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:10:33 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-56-O3XU_dwdNqmADcxbKhNOfQ-1; Fri, 18 Feb 2022 16:10:31 +0000
X-MC-Unique: O3XU_dwdNqmADcxbKhNOfQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Fri, 18 Feb 2022 16:10:28 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Fri, 18 Feb 2022 16:10:28 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Hyeonggon Yoo' <42.hyeyoo@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
CC:     Christoph Lameter <cl@gentwo.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@gentwo.de>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: RE: Do we really need SLOB nowdays?
Thread-Topic: Do we really need SLOB nowdays?
Thread-Index: AQHYJLAyvH6iV8tqykeD7oCpMSL3UayZeSGA
Date:   Fri, 18 Feb 2022 16:10:28 +0000
Message-ID: <7829ee15074448d5a7cec1a0e3c352d4@AcuMS.aculab.com>
References: <YWw1n6y/AGED14HD@casper.infradead.org>
 <CAB=+i9Tor-tmZuB8YjATT_rv68nnF2W_TvMvyGp55AGaSyKynw@mail.gmail.com>
 <alpine.DEB.2.22.394.2110251016260.3145@gentwo.de>
 <20211028100414.GA2928@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
 <YXqSoo+b9RTclW/2@casper.infradead.org> <20211210110835.GA632811@odroid>
 <alpine.DEB.2.22.394.2112101305500.290446@gentwo.de>
 <cbfaeb40-13c7-15b6-177d-07b3f3c4a0a9@suse.cz>
 <20211215062904.GA1150813@odroid>
 <54c6fff8-8c79-463b-a359-96e37bd13674@suse.cz>
 <Yg9xSWEaTZLA+hYt@ip-172-31-19-208.ap-northeast-1.compute.internal>
In-Reply-To: <Yg9xSWEaTZLA+hYt@ip-172-31-19-208.ap-northeast-1.compute.internal>
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

From: Hyeonggon Yoo
> Sent: 18 February 2022 10:13
...
> I think SLUB can be memory-efficient as SLOB.
> Is SLOB (Address-Ordered next^Wfirst fit) stronger to fragmentation than SLUB?

Dunno, but I had to patch the vxworks malloc to use 'best fit'
because 'first fit' based on a fifo free list was really horrid.

I can't imagine an address ordered 'first fit' really being that much better.

There are probably a lot more allocs and frees than the kernel used to have.

Also isn't the performance of a 'first fit' going to get horrid
when there are a lot of small items on the free list.

Does SLUB split pages into 3s and 5s (on cache lime boundaries)
as well as powers of 2?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

