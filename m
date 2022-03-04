Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D784CCF52
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 08:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238995AbiCDHyl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 4 Mar 2022 02:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238559AbiCDHyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 02:54:38 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E7D2918CC0E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 23:53:49 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-89-FYvCFpCMOBqyNx07Jia5EQ-1; Fri, 04 Mar 2022 07:53:46 +0000
X-MC-Unique: FYvCFpCMOBqyNx07Jia5EQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Fri, 4 Mar 2022 07:53:44 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Fri, 4 Mar 2022 07:53:44 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Keith Busch' <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>
Subject: RE: [PATCHv4 5/8] lib: add rocksoft model crc64
Thread-Topic: [PATCHv4 5/8] lib: add rocksoft model crc64
Thread-Index: AQHYLzsrMRdzY3NFeE6gsrcF0wQhN6yu0OzA
Date:   Fri, 4 Mar 2022 07:53:44 +0000
Message-ID: <30e059eca211460780442e2ded092722@AcuMS.aculab.com>
References: <20220303201312.3255347-1-kbusch@kernel.org>
 <20220303201312.3255347-6-kbusch@kernel.org>
In-Reply-To: <20220303201312.3255347-6-kbusch@kernel.org>
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
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Busch
> Sent: 03 March 2022 20:13
> 
> The NVM Express specification extended data integrity fields to 64 bits
> using the Rocksoft parameters. Add the poly to the crc64 table
> generation, and provide a generic library routine implementing the
> algorithm.
> 
> The Rocksoft 64-bit CRC model parameters are as follows:
>     Poly: 0xAD93D23594C93659
>     Initial value: 0xFFFFFFFFFFFFFFFF
>     Reflected Input: True
>     Reflected Output: True
>     Xor Final: 0xFFFFFFFFFFFFFFFF
> 
> Since this model used reflected bits, the implementation generates the
> reflected table so the result is ordered consistently.

Since the data is processed least significant bit first the
table must be setup slightly differently.

...
> + * crc64rocksoft[256] table is from the Rocksoft specification polynomial
> + * defined as,
> + *
> + * x^64 + x^63 + x^61 + x^59 + x^58 + x^56 + x^55 + x^52 + x^49 + x^48 + x^47 +
> + * x^46 + x^44 + x^41 + x^37 + x^36 + x^34 + x^32 + x^31 + x^28 + x^26 + x^23 +
> + * x^22 + x^19 + x^16 + x^13 + x^12 + x^10 + x^9 + x^6 + x^4 + x^3 + 1

Which matches the Poly: 0xAD93D23594C93659 above.

...
> +#define CRC64_ROCKSOFT_POLY 0x9A6C9329AC4BC9B5ULL

But that value is clearly different.

You really ought to add a comment that each byte of the constant
has to be bit reversed from the polynomial coefficients.

> -static void generate_crc64_table(void)
> +static void generate_reflected_crc64_table(uint64_t table[256], uint64_t poly)
> +{
> +	uint64_t i, j, c, crc;
> +
> +	for (i = 0; i < 256; i++) {
> +		crc = 0ULL;
> +		c = i;
> +
> +		for (j = 0; j < 8; j++) {
> +			if ((crc ^ (c >> j)) & 1)
> +				crc = (crc >> 1) ^ poly;
> +			else
> +				crc >>= 1;
> +		}
> +		table[i] = crc;
> +	}
> +}

That can be speeded up by using the identity:
	table[x ^ y] == table[x] ^ table[y]

something like:
	crc = poly;  /* actually crc(1) */
	table[0] = 0;
	table[1] = crc;
	for (i = 2; i < 8; i++) [
		crc = crc & 1 ? (crc >> 1) ^ poly : crc >> 1;
		for (j = 0; j < 1u << i; j++)
			table[j + (1i << i)] = table[j] ^ crc;
	}

I think the same code can be used for a normal MSB first crc
provided both the polynomial and crc(1) are passed in.

OTOH initialisation speed may not matter.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

