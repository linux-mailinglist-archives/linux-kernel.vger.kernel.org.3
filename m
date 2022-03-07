Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D334D014C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243222AbiCGOdi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Mar 2022 09:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243228AbiCGOdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:33:35 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D81622AE39
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 06:32:40 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-90-h5M8wZQmO6yot19GRlHRaQ-1; Mon, 07 Mar 2022 14:32:37 +0000
X-MC-Unique: h5M8wZQmO6yot19GRlHRaQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Mon, 7 Mar 2022 14:32:34 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Mon, 7 Mar 2022 14:32:34 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jisheng Zhang' <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] riscv: add irq stack support
Thread-Topic: [PATCH v2] riscv: add irq stack support
Thread-Index: AQHYMi3k+WYJFHSO9UyI1q+ElBcqo6yz+IIw
Date:   Mon, 7 Mar 2022 14:32:34 +0000
Message-ID: <f7f46323619e4084b4cfc551cdb47dd0@AcuMS.aculab.com>
References: <20220307140804.1400-1-jszhang@kernel.org>
In-Reply-To: <20220307140804.1400-1-jszhang@kernel.org>
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

From: Jisheng Zhang
> Sent: 07 March 2022 14:08
> Currently, IRQs are still handled on the kernel stack of the current
> task on riscv platforms. If the task has a deep call stack at the time
> of interrupt, and handling the interrupt also requires a deep stack,
> it's possible to see stack overflow.
> 
...
I'd have thought that a single page is (probably) enough for the
IRQ stack.
Certainly its sizing isn't really related to the normal thread
stack size.

> From another side, after this patch, it's possible to reduce the
> THREAD_SIZE to 8KB for RV64 platforms. This is especially useful for
> those systems with small memory size, e.g the Allwinner D1S platform
> which is RV64 but only has 64MB DDR.

Are you sure?
Is the stack use likely to be very much less than that of x86-64?
The real problem isn't the stack use of the test you are doing,
but the horrid worst case stack of some path that has multiple
1k+ buffers on stack.

Apart from compiler fubar (which usually hit KASAN) that stack
is actually likely to be architecture independent.
(The difference between 32bit and 64bit is also likely to be
relatively small - unless there are on-stack arrays of 'long'.)

For VMAP stacks is there a 'guard' KVA page allocated below
all of the stacks?
64bit systems should have lots of KVA so this shouldn't be
a problem.
Then stack overruns will fault and panic rather than trashing
another data area - which is really hard to debug.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

