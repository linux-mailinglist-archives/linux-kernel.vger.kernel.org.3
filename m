Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2839586622
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 10:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiHAISg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 1 Aug 2022 04:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiHAISc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 04:18:32 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5CFE33A4A0
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 01:18:30 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-90-AvgrXkIoNm6f5CQVlFdnFQ-1; Mon, 01 Aug 2022 09:18:27 +0100
X-MC-Unique: AvgrXkIoNm6f5CQVlFdnFQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Mon, 1 Aug 2022 09:18:26 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Mon, 1 Aug 2022 09:18:26 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christophe JAILLET' <christophe.jaillet@wanadoo.fr>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH v2] timers: Optimize usleep_range()
Thread-Topic: [PATCH v2] timers: Optimize usleep_range()
Thread-Index: AQHYo4nvkYUHE4pe402s230iY96y4q2ZtPDg
Date:   Mon, 1 Aug 2022 08:18:26 +0000
Message-ID: <03c2bbe795fe4ddcab66eb852bae3715@AcuMS.aculab.com>
References: <a896e176f0f0b819f8ec5ab8935355d01a642506.1659126514.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <a896e176f0f0b819f8ec5ab8935355d01a642506.1659126514.git.christophe.jaillet@wanadoo.fr>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET
> Sent: 29 July 2022 21:29
> 
> Most of the time the 'min' and 'max' parameters of usleep_range() are
> constant. We can take advantage of it to pre-compute at compile time
> some values otherwise computer at run-time in usleep_range_state().
> 
> Replace usleep_range_state() by a new __nsleep_range_delta_state() function
> that takes as parameters the pre-computed values.
> 
> The main benefit is to save a few instructions, especially 2
> multiplications (x1000 when converting us to ns).
...
>   53                   	push   %rbx
>   48 89 fb             	mov    %rdi,%rbx
>   81 e5 cc 00 00 00    	and    $0xcc,%ebp
> - 49 29 dc             	sub    %rbx,%r12              ; (max - min)
> - 4d 69 e4 e8 03 00 00 	imul   $0x3e8,%r12,%r12       ; us --> ns (x 1000)
>   48 83 ec 68          	sub    $0x68,%rsp
>   48 c7 44 24 08 b3 8a 	movq   $0x41b58ab3,0x8(%rsp)
>   b5 41
> @@ -10721,18 +10719,16 @@
>   31 c0                	xor    %eax,%eax
>   e8 00 00 00 00       	call   ...
>   e8 00 00 00 00       	call   ...
> - 49 89 c0             	mov    %rax,%r8
> - 48 69 c3 e8 03 00 00 	imul   $0x3e8,%rbx,%rax       ; us --> ns (x 1000)
> + 48 01 d8             	add    %rbx,%rax
> + 48 89 44 24 28       	mov    %rax,0x28(%rsp)
>   65 48 8b 1c 25 00 00 	mov    %gs:0x0,%rbx
>   00 00
> - 4c 01 c0             	add    %r8,%rax
> - 48 89 44 24 28       	mov    %rax,0x28(%rsp)
>   e8 00 00 00 00       	call   ...
...

Is that really measurable in any test?
Integer multiply is one clock on almost every modern cpu.

By the time you've allowed for superscaler cpu there is
probably no difference at all on anything except the simplest
cpus.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

