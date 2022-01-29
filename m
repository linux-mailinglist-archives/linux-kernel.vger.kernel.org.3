Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1F44A2FD6
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 14:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349021AbiA2NmA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 29 Jan 2022 08:42:00 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:27588 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237017AbiA2Nl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 08:41:57 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-132-kl2_1KnEM5W2_GB7pgWbZw-1; Sat, 29 Jan 2022 13:41:53 +0000
X-MC-Unique: kl2_1KnEM5W2_GB7pgWbZw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Sat, 29 Jan 2022 13:41:52 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Sat, 29 Jan 2022 13:41:52 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'michael@michaelkloos.com'" <michael@michaelkloos.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] riscv: Fixed misaligned memory access.  Fixed pointer
 comparison.
Thread-Topic: [PATCH v4] riscv: Fixed misaligned memory access.  Fixed pointer
 comparison.
Thread-Index: AQHYFLeJevYJAUdx80uZ5JrJ5hRdzqx5/qSg
Date:   Sat, 29 Jan 2022 13:41:52 +0000
Message-ID: <7ef35550b4dd44ffabfd7ca1e0ee27fa@AcuMS.aculab.com>
References: <20220129022448.37483-1-michael@michaelkloos.com>
In-Reply-To: <20220129022448.37483-1-michael@michaelkloos.com>
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: michael@michaelkloos.com
...
> [v4]
> 
> I could not resist implementing the optimization I mentioned in
> my v3 notes.  I have implemented the roll over of data by cpu
> register in the misaligned fixup copy loops.  Now, only one load
> from memory is required per iteration of the loop.

I nearly commented...

...
> +	/*
> +	 * Fix Misalignment Copy Loop.
> +	 * load_val1 = load_ptr[0];
> +	 * while (store_ptr != store_ptr_end) {
> +	 *   load_val0 = load_val1;
> +	 *   load_val1 = load_ptr[1];
> +	 *   *store_ptr = (load_val0 >> {a6}) | (load_val1 << {a7});
> +	 *   load_ptr++;
> +	 *   store_ptr++;
> +	 * }
> +	 */
> +	REG_L t0, 0x000(a3)
> +	1:
> +	beq   t3, t6, 2f
> +	mv    t1, t0
> +	REG_L t0, SZREG(a3)
> +	srl   t1, t1, a6
> +	sll   t2, t0, a7
> +	or    t1, t1, t2
> +	REG_S t1, 0x000(t3)
> +	addi  a3, a3, SZREG
> +	addi  t3, t3, SZREG
> +	j 1b

No point jumping to a conditional branch that jumps bak
Make this a:
	bne	t3, t6, 1b
and move 1: down one instruction.
(Or is the 'beq' at the top even possible - there is likely to
be an earlier test for zero length copies.)
> +	2:

I also suspect it is worth unrolling the loop once.
You lose the 'mv t1, t0' and one 'addi' for each word transferred.

I think someone mentioned that there is a few clocks delay before
the data from the memory read (REG_L) is actually available.
On in-order cpu this is likely to be a full pipeline stall.
So move the 'addi' up between the 'REG_L' and 'sll' instructions.
(The offset will need to be -SZREG to match.)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

