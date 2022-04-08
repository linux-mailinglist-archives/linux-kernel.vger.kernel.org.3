Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6764F9070
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 10:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiDHINq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 Apr 2022 04:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiDHINn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:13:43 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF4913BA51
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 01:11:39 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-148-Svnn6zolP_-zt7pXcvy9uw-1; Fri, 08 Apr 2022 09:11:37 +0100
X-MC-Unique: Svnn6zolP_-zt7pXcvy9uw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Fri, 8 Apr 2022 09:11:35 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Fri, 8 Apr 2022 09:11:35 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Jason A. Donenfeld'" <Jason@zx2c4.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "tytso@mit.edu" <tytso@mit.edu>,
        "sultan@kerneltoast.com" <sultan@kerneltoast.com>,
        Jann Horn <jannh@google.com>
Subject: RE: [PATCH v2] random: allow partial reads if later user copies fail
Thread-Topic: [PATCH v2] random: allow partial reads if later user copies fail
Thread-Index: AQHYStia62LV1RpflEWlDISfQ8tDQqzlqpzQ
Date:   Fri, 8 Apr 2022 08:11:35 +0000
Message-ID: <8d652dac67754a308b270c453b3032d2@AcuMS.aculab.com>
References: <20220407193433.523299-1-Jason@zx2c4.com>
 <20220407233558.3369-1-Jason@zx2c4.com>
In-Reply-To: <20220407233558.3369-1-Jason@zx2c4.com>
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

From: Jason A. Donenfeld
> Sent: 08 April 2022 00:36
> 
> Rather than failing entirely if a copy_to_user() fails at some point,
> instead we should return a partial read for the amount that succeeded
> prior, unless none succeeded at all, in which case we return -EFAULT as
> before.

I think you now return -EFAULT for a zero length read.

	David

> 
> This makes it consistent with other reader interfaces. For example, the
> following snippet for /dev/zero outputs "4" followed by "1":
> 
>   int fd;
>   void *x = mmap(NULL, 4096, PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
>   assert(x != MAP_FAILED);
>   fd = open("/dev/zero", O_RDONLY);
>   assert(fd >= 0);
>   printf("%zd\n", read(fd, x, 4));
>   printf("%zd\n", read(fd, x + 4095, 4));
>   close(fd);
> 
> This brings that same standard behavior to the various RNG reader
> interfaces.
> 
> While we're at it, we can streamline the loop logic a little bit.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Jann Horn <jannh@google.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> Changes v1->v2:
> - Do partial copies within individual blocks, not just per-block, also
>   following how /dev/zero and ordinary filesystem files work.
> 
>  drivers/char/random.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index e15063d61460..df43c5060f00 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -523,8 +523,7 @@ EXPORT_SYMBOL(get_random_bytes);
> 
>  static ssize_t get_random_bytes_user(void __user *buf, size_t nbytes)
>  {
> -	ssize_t ret = 0;
> -	size_t len;
> +	size_t len, left, ret = 0;
>  	u32 chacha_state[CHACHA_STATE_WORDS];
>  	u8 output[CHACHA_BLOCK_SIZE];
> 
> @@ -543,37 +542,40 @@ static ssize_t get_random_bytes_user(void __user *buf, size_t nbytes)
>  	 * the user directly.
>  	 */
>  	if (nbytes <= CHACHA_KEY_SIZE) {
> -		ret = copy_to_user(buf, &chacha_state[4], nbytes) ? -EFAULT : nbytes;
> +		ret = nbytes - copy_to_user(buf, &chacha_state[4], nbytes);
>  		goto out_zero_chacha;
>  	}
> 
> -	do {
> +	for (;;) {
>  		chacha20_block(chacha_state, output);
>  		if (unlikely(chacha_state[12] == 0))
>  			++chacha_state[13];
> 
>  		len = min_t(size_t, nbytes, CHACHA_BLOCK_SIZE);
> -		if (copy_to_user(buf, output, len)) {
> -			ret = -EFAULT;
> +		left = copy_to_user(buf, output, len);
> +		if (left) {
> +			ret += len - left;
>  			break;
>  		}
> 
> -		nbytes -= len;
>  		buf += len;
>  		ret += len;
> +		nbytes -= len;
> +		if (!nbytes)
> +			break;
> 
>  		BUILD_BUG_ON(PAGE_SIZE % CHACHA_BLOCK_SIZE != 0);
> -		if (!(ret % PAGE_SIZE) && nbytes) {
> +		if (ret % PAGE_SIZE == 0) {
>  			if (signal_pending(current))
>  				break;
>  			cond_resched();
>  		}
> -	} while (nbytes);
> +	}
> 
>  	memzero_explicit(output, sizeof(output));
>  out_zero_chacha:
>  	memzero_explicit(chacha_state, sizeof(chacha_state));
> -	return ret;
> +	return ret ? ret : -EFAULT;
>  }
> 
>  /*
> --
> 2.35.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

