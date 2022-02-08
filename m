Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B584AD7D4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358213AbiBHLu7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 8 Feb 2022 06:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358551AbiBHLu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 06:50:28 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 882FEC0302C6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 03:45:41 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-70-nKD5K5YQP-CRRdtrR-hd-w-1; Tue, 08 Feb 2022 11:45:39 +0000
X-MC-Unique: nKD5K5YQP-CRRdtrR-hd-w-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Tue, 8 Feb 2022 11:45:38 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Tue, 8 Feb 2022 11:45:38 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Hugh Dickins' <hughd@google.com>, Borislav Petkov <bp@suse.de>
CC:     Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: x86: should clear_user() have alternatives?
Thread-Topic: x86: should clear_user() have alternatives?
Thread-Index: AQHYHK8l5MEK9qlbxkOnyE8hF1HtfqyJhs7w
Date:   Tue, 8 Feb 2022 11:45:38 +0000
Message-ID: <9fc41af45fcb40e3ae607eb4f52d7ef9@AcuMS.aculab.com>
References: <2f5ca5e4-e250-a41c-11fb-a7f4ebc7e1c9@google.com>
In-Reply-To: <2f5ca5e4-e250-a41c-11fb-a7f4ebc7e1c9@google.com>
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

From: Hugh Dickins
> Sent: 08 February 2022 05:46
> 
> I've noticed that clear_user() is slower than it need be:
> 
> dd if=/dev/zero of=/dev/null bs=1M count=1M
> 1099511627776 bytes (1.1 TB) copied, 45.9641 s, 23.9 GB/s
> whereas with the hacked patch below
> 1099511627776 bytes (1.1 TB) copied, 33.4 s, 32.9 GB/s
> 
> That was on some Intel machine: IIRC an AMD went faster.
> 
> It's because clear_user() lacks alternatives, and uses a
> nowadays suboptimal implementation; whereas clear_page()
> and copy_user() do support alternatives.
> 
...
> +SYM_FUNC_START(__clear_user)
> +	ASM_STAC
> +	movl %esi,%ecx
> +	xorq %rax,%rax
> +1:	rep stosb
> +2:	movl %ecx,%eax
> +	ASM_CLAC
> +	ret

You only want to even consider than version for long copies
(and possibly only for aligned ones).

The existing code (I've not quoted) does look sub-optimal though.
It should be easy to obtain a write every clock.
But I suspect the loop is too long.
The code gcc generates might even be better!

Note that for copies longer than 8 bytes 'odd' lengths can
be handled by a single misaligned write to the end of the buffer.
No need for a byte copy loop.

I've not experimented with misaligned writes - they might take two clocks.
So it might be worth aligning them - but they may not happen often
enough for it to be an overall gain.
Misaligned reads usually don't make any difference.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

