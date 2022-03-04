Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204724CCB57
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 02:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237589AbiCDBcU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Mar 2022 20:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237571AbiCDBcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 20:32:18 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4F637EA0E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 17:31:31 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-405-_h_WcGdzNK2oICfGaye4nQ-1; Fri, 04 Mar 2022 01:31:28 +0000
X-MC-Unique: _h_WcGdzNK2oICfGaye4nQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Fri, 4 Mar 2022 01:31:27 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Fri, 4 Mar 2022 01:31:27 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Keith Busch' <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: RE: [PATCHv4 3/8] asm-generic: introduce be48 unaligned accessors
Thread-Topic: [PATCHv4 3/8] asm-generic: introduce be48 unaligned accessors
Thread-Index: AQHYLzsopbrJlbfcckWY1hd2yhpRTqyubXZA
Date:   Fri, 4 Mar 2022 01:31:26 +0000
Message-ID: <2d8895d24fff46738f98c2dae74fa440@AcuMS.aculab.com>
References: <20220303201312.3255347-1-kbusch@kernel.org>
 <20220303201312.3255347-4-kbusch@kernel.org>
In-Reply-To: <20220303201312.3255347-4-kbusch@kernel.org>
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

From: Keith Busch
> Sent: 03 March 2022 20:13
> 
> The NVMe protocol extended the data integrity fields with unaligned
> 48-bit reference tags.

If they are reference tags, are they only interpreted by the
sending system?
In which case they don't need to be big-endian since the
actual value doesn't really matter.

> Provide some helper accessors in preparation for these.
> 
...
> diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unaligned.h
> index 1c4242416c9f..8fc637379899 100644
> --- a/include/asm-generic/unaligned.h
> +++ b/include/asm-generic/unaligned.h
> @@ -126,4 +126,30 @@ static inline void put_unaligned_le24(const u32 val, void *p)
>  	__put_unaligned_le24(val, p);
>  }
> 
> +static inline void __put_unaligned_be48(const u64 val, __u8 *p)
> +{
> +	*p++ = val >> 40;
> +	*p++ = val >> 32;
> +	*p++ = val >> 24;
> +	*p++ = val >> 16;
> +	*p++ = val >> 8;
> +	*p++ = val;
> +}

Although that matches __put_unaligned_be24() I think I'd use
array indexing not pointer increments.
The compiler will probably generate the same code anyway.

However it is probably better to do:
	put_unaligned_be16(val >> 32, p);
	put_unaligned_be32(val, p + 2);
so you get 2 memory accesses on x86 (etc) instead of 6.

Similarly for __get_unaligned_be48() where it is likely
so make a bigger difference.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

