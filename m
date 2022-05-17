Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F87529C60
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243196AbiEQI1p convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 17 May 2022 04:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243014AbiEQI0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:26:48 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BFC8433E8E
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 01:26:46 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-206-u0rpxtwWMv-63K0ptBJSiA-1; Tue, 17 May 2022 09:26:43 +0100
X-MC-Unique: u0rpxtwWMv-63K0ptBJSiA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Tue, 17 May 2022 09:26:42 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Tue, 17 May 2022 09:26:42 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        Mikulas Patocka <mpatocka@redhat.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] objtool: fix objtool regression on x32 systems
Thread-Topic: [PATCH] objtool: fix objtool regression on x32 systems
Thread-Index: AQHYaWt5OldbokCz9EWxs3iZW4E54K0iu3XQ
Date:   Tue, 17 May 2022 08:26:42 +0000
Message-ID: <738a941ba2ff4e2db8f2268b281d9bd5@AcuMS.aculab.com>
References: <alpine.LRH.2.02.2205161041260.11556@file01.intranet.prod.int.rdu2.redhat.com>
 <YoJwtCeVzYUm6Uhg@hirez.programming.kicks-ass.net>
 <alpine.LRH.2.02.2205161145070.30905@file01.intranet.prod.int.rdu2.redhat.com>
 <20220516212517.GP76023@worktop.programming.kicks-ass.net>
In-Reply-To: <20220516212517.GP76023@worktop.programming.kicks-ass.net>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra
> Sent: 16 May 2022 22:25
...
> A quick look seems to suggest at least all the 'offset' fields should be
> u64 or something. The only reason that works is because -mcmodel=kernel
> keeps everything in the 2G range to make s32 immediates work. But it
> isn't right.

Offsets in instructions are only 8bit or 32bit.
The mod/reg/rm and SiB encodings don't support anything else.
If offsets might be large then they have to be loaded into
registers - which will slow things down.

Immediates can be 64bit (but not if the addressing mode
includes an offset).

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

