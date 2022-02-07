Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445514AB408
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241862AbiBGFvb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Feb 2022 00:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiBGDgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 22:36:05 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CFADC061A73
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 19:36:02 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-286-N5GTcCNKP6q1uY-4a4dHUg-1; Mon, 07 Feb 2022 03:35:57 +0000
X-MC-Unique: N5GTcCNKP6q1uY-4a4dHUg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Mon, 7 Feb 2022 03:35:55 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Mon, 7 Feb 2022 03:35:55 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jisheng Zhang' <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH] riscv: reduce THREAD_SIZE from 16KB to 8KB for RV64
Thread-Topic: [RFC PATCH] riscv: reduce THREAD_SIZE from 16KB to 8KB for RV64
Thread-Index: AQHYG4I1cWK2Agm31k+W40NUWVDrs6yHbd8Q
Date:   Mon, 7 Feb 2022 03:35:55 +0000
Message-ID: <04326e1a50fa46eaa08df3a5df6f14f6@AcuMS.aculab.com>
References: <20220206174359.2986-1-jszhang@kernel.org>
In-Reply-To: <20220206174359.2986-1-jszhang@kernel.org>
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
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang
> Sent: 06 February 2022 17:44
> 
> After irq stack is supported, it's possible to use small THREAD_SIZE.
> In fact, I tested this patch on a Lichee RV board, looks good so far.

Is riscv using vmalloc with a guard page?

You won't find the deepest kernel stack use with trivial tests.
I'd hazard a guess that it is inside printk() in some error path.
Debugging stack overflow is horrid.

With no alloca() no recursion and limited indirect calls it is
technically possible to statically calculate maximum stack use.
But I don't think anyone has tried to do it for the linux kernel.
I did do it for an embedded system (that had almost no indirect calls)
and found we didn't have enough memory for the required stacks!

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

