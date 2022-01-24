Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E827F497BC7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 10:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbiAXJV2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 Jan 2022 04:21:28 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:58646 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231851AbiAXJV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 04:21:27 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-252-Qk4L0YCwNj64dPMhnPks7Q-1; Mon, 24 Jan 2022 09:21:24 +0000
X-MC-Unique: Qk4L0YCwNj64dPMhnPks7Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Mon, 24 Jan 2022 09:21:21 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Mon, 24 Jan 2022 09:21:21 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'michael@michaelkloos.com'" <michael@michaelkloos.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] Fixed: Misaligned memory access.  Fixed pointer
 comparison.
Thread-Topic: [PATCH v2] Fixed: Misaligned memory access.  Fixed pointer
 comparison.
Thread-Index: AQHYEAxftwhRlaAJzU+hPBmorjaluqxx5R9A
Date:   Mon, 24 Jan 2022 09:21:21 +0000
Message-ID: <4fa1c4bbf27242cf9835dde0abdc89d5@AcuMS.aculab.com>
References: <20220123034518.3717116-1-michael@michaelkloos.com>
In-Reply-To: <20220123034518.3717116-1-michael@michaelkloos.com>
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
> Sent: 23 January 2022 03:45
> 
> Rewrote the riscv memmove() assembly implementation.  The
> previous implementation did not check memory alignment and it
> compared 2 pointers with a signed comparison.  The misaligned
> memory access would cause the kernel to crash on systems that
> did not emulate it in firmware and did not support it in hardware.
> Firmware emulation is slow and may not exist.  Additionally,
> hardware support may not exist and would likely still run slower
> than aligned accesses even if it did.

That may not be true.
On x86 the cost of misaligned accesses only just measurable.
It isn't even one clock per cache line for reads (eg ipcsum).

> The RISC-V spec does not
> guarantee that support for misaligned memory accesses will exist.
> It should not be depended on.
> 
> This patch now checks for the maximum granularity of co-alignment
> between the pointers and copies them with that, using single-byte
> copy for any unaligned data at their terminations.  It also now uses
> unsigned comparison for the pointers.

If the performance of misaligned copies ever matters it is probably
better to use:
	*dst++ = src[0] >> n | src[1] << (64 - n);
for the body of the misaligned loop.
You can always read the aligned src[] even if outside the buffer.
So the only difficult part is writing the odd bytes
and getting 'n' and the direction of the shifts right!

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

