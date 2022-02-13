Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CBF4B38FD
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 03:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbiBMCqa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 12 Feb 2022 21:46:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiBMCq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 21:46:27 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A394760072
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 18:46:22 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-24-HG4q7pd-NqGU0GUpRUO8BQ-1; Sun, 13 Feb 2022 02:46:17 +0000
X-MC-Unique: HG4q7pd-NqGU0GUpRUO8BQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Sun, 13 Feb 2022 02:46:16 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Sun, 13 Feb 2022 02:46:16 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christophe Leroy' <christophe.leroy@csgroup.eu>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH v2] mm: Uninline copy_overflow()
Thread-Topic: [PATCH v2] mm: Uninline copy_overflow()
Thread-Index: AQHYHzBgIqINanSGXk+kH56ytNcFL6yQyJxg
Date:   Sun, 13 Feb 2022 02:46:16 +0000
Message-ID: <1301657af59b46858662c605edf795cf@AcuMS.aculab.com>
References: <1b19e3168b6bed6b9488d35e50a592f5229a2d45.1644574519.git.christophe.leroy@csgroup.eu>
In-Reply-To: <1b19e3168b6bed6b9488d35e50a592f5229a2d45.1644574519.git.christophe.leroy@csgroup.eu>
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

From: Christophe Leroy
> Sent: 11 February 2022 10:16
...
> copy_overflow() is a non conditional warning called by
> check_copy_size() on an error path.
> 
> check_copy_size() have to remain inlined in order to benefit
> from constant folding, but copy_overflow() is not worth inlining.
> 
> Uninline it.
> 
> This reduces the size of vmlinux by almost 4kbytes.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> v2: Added missing EXPORT_SYMBOL() and enhanced commit message
> ---
>  include/linux/thread_info.h | 5 +----
>  mm/maccess.c                | 6 ++++++
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
> index 73a6f34b3847..1087d1e2be5c 100644
> --- a/include/linux/thread_info.h
> +++ b/include/linux/thread_info.h
> @@ -209,10 +209,7 @@ __bad_copy_from(void);
>  extern void __compiletime_error("copy destination size is too small")
>  __bad_copy_to(void);
> 
> -static inline void copy_overflow(int size, unsigned long count)
> -{
> -	WARN(1, "Buffer overflow detected (%d < %lu)!\n", size, count);
> -}
> +void copy_overflow(int size, unsigned long count);
> 
>  static __always_inline __must_check bool
>  check_copy_size(const void *addr, size_t bytes, bool is_source)
> diff --git a/mm/maccess.c b/mm/maccess.c
> index d3f1a1f0b1c1..6b11a22f4b01 100644
> --- a/mm/maccess.c
> +++ b/mm/maccess.c
> @@ -335,3 +335,9 @@ long strnlen_user_nofault(const void __user *unsafe_addr, long count)
> 
>  	return ret;
>  }
> +
> +void copy_overflow(int size, unsigned long count)
> +{
> +	WARN(1, "Buffer overflow detected (%d < %lu)!\n", size, count);
> +}
> +EXPORT_SYMBOL_GPL(copy_overflow)

Can you remove the _GPL ????

I think that basically stops you compiling any non-gpl code if the
copy_protection is enabled in the kernel build.
I'm guessing that most of the inline wrappers calling this are non-FPL
functions.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

