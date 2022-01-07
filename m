Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5008487491
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 10:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346416AbiAGJP6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 7 Jan 2022 04:15:58 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:38316 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346393AbiAGJP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 04:15:57 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-283-imPCMXOvPNuWtN3LA9tbww-1; Fri, 07 Jan 2022 09:15:55 +0000
X-MC-Unique: imPCMXOvPNuWtN3LA9tbww-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26; Fri, 7 Jan 2022 09:15:54 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.026; Fri, 7 Jan 2022 09:15:54 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'cgel.zte@gmail.com'" <cgel.zte@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: RE: [PATCH] mm/page_alloc.c: Use div64_ul instead of do_div
Thread-Topic: [PATCH] mm/page_alloc.c: Use div64_ul instead of do_div
Thread-Index: AQHYA2zM76VKweVeN0S3fxclkHxO96xXRvoA
Date:   Fri, 7 Jan 2022 09:15:54 +0000
Message-ID: <665a758a3bd5421ea7cf9c01d154f718@AcuMS.aculab.com>
References: <20220107021751.621522-1-deng.changcheng@zte.com.cn>
In-Reply-To: <20220107021751.621522-1-deng.changcheng@zte.com.cn>
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

From: cgel.zte@gmail.com
> Sent: 07 January 2022 02:18
> 
> do_div() does a 64-by-32 division. Here the divisor is an unsigned long
> which on some platforms is 64 bit wide. So use div64_ul instead of do_div
> to avoid a possible truncation.

You really need to check the domain of the divisor, not its type.
Just because the type is 64 bits doesn't mean that the value can be
anywhere near even 32 bits.

	David

> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
> ---
>  mm/page_alloc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 8dd6399bafb5..60469b616ac1 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8431,7 +8431,7 @@ static void __setup_per_zone_wmarks(void)
> 
>  		spin_lock_irqsave(&zone->lock, flags);
>  		tmp = (u64)pages_min * zone_managed_pages(zone);
> -		do_div(tmp, lowmem_pages);
> +		tmp = div64_ul(tmp, lowmem_pages);
>  		if (is_highmem(zone)) {
>  			/*
>  			 * __GFP_HIGH and PF_MEMALLOC allocations usually don't
> @@ -8804,7 +8804,7 @@ void *__init alloc_large_system_hash(const char *tablename,
>  	/* limit allocation size to 1/16 total memory by default */
>  	if (max == 0) {
>  		max = ((unsigned long long)nr_all_pages << PAGE_SHIFT) >> 4;
> -		do_div(max, bucketsize);
> +		max = div64_ul(max, bucketsize);
>  	}
>  	max = min(max, 0x80000000ULL);
> 
> --
> 2.25.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

