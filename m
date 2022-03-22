Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C144E3DDB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 12:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbiCVLyk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Mar 2022 07:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234665AbiCVLyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 07:54:21 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4075985675
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 04:52:46 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-401-rM2dEyRPOySuFi2zcClhJw-1; Tue, 22 Mar 2022 11:52:43 +0000
X-MC-Unique: rM2dEyRPOySuFi2zcClhJw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Tue, 22 Mar 2022 11:52:43 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Tue, 22 Mar 2022 11:52:43 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Ammar Faizi' <ammarfaizi2@gnuweeb.org>, Willy Tarreau <w@1wt.eu>
CC:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: RE: [RFC PATCH v2 6/8] tools/nolibc/stdlib: Implement `malloc()`,
 `calloc()`, `realloc()` and `free()`
Thread-Topic: [RFC PATCH v2 6/8] tools/nolibc/stdlib: Implement `malloc()`,
 `calloc()`, `realloc()` and `free()`
Thread-Index: AQHYPdaybn74E+3FG0GW9mJht1aJxazLSY+g
Date:   Tue, 22 Mar 2022 11:52:43 +0000
Message-ID: <56935393241242adab6f32c50dd74c23@AcuMS.aculab.com>
References: <20220322102115.186179-1-ammarfaizi2@gnuweeb.org>
 <20220322102115.186179-7-ammarfaizi2@gnuweeb.org>
In-Reply-To: <20220322102115.186179-7-ammarfaizi2@gnuweeb.org>
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

From: Ammar Faizi
> Sent: 22 March 2022 10:21
> 
> Implement basic dynamic allocator functions. These functions are
> currently only available on architectures that have nolibc mmap()
> syscall implemented. These are not a super-fast memory allocator,
> but at least they can satisfy basic needs for having heap without
> libc.
> 
> Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> ---
> 
> @@ Changelog:
> 
>    Link: https://lore.kernel.org/lkml/20220320093750.159991-6-ammarfaizi2@gnuweeb.org
>    RFC v1 -> RFC v2:
>     - Move container_of() and offsetof() macro to types.h with a
>       separate patch (comment from Willy).
> ---
>  tools/include/nolibc/stdlib.h | 68 +++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
> index aca8616335e3..a0ed75431e0a 100644
> --- a/tools/include/nolibc/stdlib.h
> +++ b/tools/include/nolibc/stdlib.h
> @@ -11,7 +11,12 @@
>  #include "arch.h"
>  #include "types.h"
>  #include "sys.h"
> +#include "string.h"
> 
> +struct nolibc_heap {
> +	size_t	len;
> +	char	user_p[] __attribute__((__aligned__));

Doesn't that need (number) in the attribute?

> +};
> 
>  /* Buffer used to store int-to-ASCII conversions. Will only be implemented if
>   * any of the related functions is implemented. The area is large enough to
> @@ -60,6 +65,18 @@ int atoi(const char *s)
>  	return atol(s);
>  }
> 
> +static __attribute__((unused))
> +void free(void *ptr)
> +{
> +	struct nolibc_heap *heap;
> +
> +	if (!ptr)
> +		return;
> +
> +	heap = container_of(ptr, struct nolibc_heap, user_p);
> +	munmap(heap, heap->len);
> +}
> +
>  /* Tries to find the environment variable named <name> in the environment array
>   * pointed to by global variable "environ" which must be declared as a char **,
>   * and must be terminated by a NULL (it is recommended to set this variable to
> @@ -205,6 +222,57 @@ char *ltoa(long in)
>  	return itoa_buffer;
>  }
> 
> +static __attribute__((unused))
> +void *malloc(size_t len)
> +{
> +	struct nolibc_heap *heap;

If you do (say):
	len = ROUNDUP(len + sizeof *heap, 4096)
you can optimise a lot of the realloc() calls.

I actually wonder if compiling a mini-libc.a
and then linking the programs against it might
be better than all these static functions?
-ffunction-sections can help a bit (where supported).

	David
	
> +
> +	heap = mmap(NULL, sizeof(*heap) + len, PROT_READ|PROT_WRITE,
> +		    MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
> +	if (__builtin_expect(heap == MAP_FAILED, 0))
> +		return NULL;
> +
> +	heap->len = sizeof(*heap) + len;
> +	return heap->user_p;
> +}
> +
> +static __attribute__((unused))
> +void *calloc(size_t size, size_t nmemb)
> +{
> +	void *orig;
> +	size_t res = 0;
> +
> +	if (__builtin_expect(__builtin_mul_overflow(nmemb, size, &res), 0)) {
> +		SET_ERRNO(ENOMEM);
> +		return NULL;
> +	}
> +
> +	/*
> +	 * No need to zero the heap, the MAP_ANONYMOUS in malloc()
> +	 * already does it.
> +	 */
> +	return malloc(res);
> +}
> +
> +static __attribute__((unused))
> +void *realloc(void *old_ptr, size_t new_size)
> +{
> +	struct nolibc_heap *heap;
> +	void *ret;
> +
> +	ret = malloc(new_size);
> +	if (__builtin_expect(!ret, 0))
> +		return NULL;
> +
> +	if (!old_ptr)
> +		return ret;
> +
> +	heap = container_of(old_ptr, struct nolibc_heap, user_p);
> +	memcpy(ret, heap->user_p, heap->len);
> +	munmap(heap, heap->len);
> +	return ret;
> +}
> +
>  /* converts unsigned long integer <in> to a string using the static itoa_buffer
>   * and returns the pointer to that string.
>   */
> --
> Ammar Faizi

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

