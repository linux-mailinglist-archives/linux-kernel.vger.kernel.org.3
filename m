Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CFF4D2C90
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbiCIJyJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Mar 2022 04:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiCIJyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:54:07 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 861D85C675
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 01:53:08 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-170-C9CSPsPAP3CiGXY-2Cczvg-1; Wed, 09 Mar 2022 09:53:06 +0000
X-MC-Unique: C9CSPsPAP3CiGXY-2Cczvg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Wed, 9 Mar 2022 09:53:04 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Wed, 9 Mar 2022 09:53:04 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christophe Leroy' <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>
CC:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] powerpc: Use rol32() instead of opencoding in csum_fold()
Thread-Topic: [PATCH] powerpc: Use rol32() instead of opencoding in
 csum_fold()
Thread-Index: AQHYM4tAZCIa7HBaKU201H+8JgoYL6y2y/IA
Date:   Wed, 9 Mar 2022 09:53:04 +0000
Message-ID: <d7840750e3694b30951540b4298da208@AcuMS.aculab.com>
References: <794337eff7bb803d2c4e67d9eee635390c4c48fe.1646812553.git.christophe.leroy@csgroup.eu>
In-Reply-To: <794337eff7bb803d2c4e67d9eee635390c4c48fe.1646812553.git.christophe.leroy@csgroup.eu>
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
> Sent: 09 March 2022 07:56
...
> diff --git a/arch/powerpc/include/asm/checksum.h b/arch/powerpc/include/asm/checksum.h
> index 8321f6053a67..4b573a3b7e17 100644
> --- a/arch/powerpc/include/asm/checksum.h
> +++ b/arch/powerpc/include/asm/checksum.h
> @@ -38,14 +38,15 @@ extern __wsum csum_and_copy_to_user(const void *src, void __user *dst,
>   */
>  static inline __sum16 csum_fold(__wsum sum)
>  {
> +	u32 tmp = (__force u32)sum;
> +
> +	/*
> +	 * swap the two 16-bit halves of sum
> +	 * if there is a carry from adding the two 16-bit halves,
> +	 * it will carry from the lower half into the upper half,
> +	 * giving us the correct sum in the upper half.
> +	 */
> +	return (__force __sum16)(~(tmp + rol32(tmp, 16)) >> 16);
>  }
> 
>  static inline u32 from64to32(u64 x)
> --
> 2.34.1

On the face of it that is pretty generic.
Two shifts and an add (plus the invert and mask).

I suspect it generates better code than the current x86 version
which is:

static inline __sum16 csum_fold(__wsum sum)
{
	asm("addl %1, %0		;\n"
	    "adcl $0xffff, %0	;\n"
	    : "=r" (sum)
	    : "r" ((__force u32)sum << 16),
	      "0" ((__force u32)sum & 0xffff0000));
	return (__force __sum16)(~(__force u32)sum >> 16);
}

Which looks like 2 shifts, a mask, add, adc..
(Oh and the adc is two clocks on anything prior to Haswell.)
Quite why it doesn't use 16bit add and adc is anybodies guess.
Would still be shift, add, adc.
So shift, add, shift is no worse.

I wonder if any of the asm versions are actually better?
Some are the same algorithm, some are a lot worse.

Generic is:
static inline __sum16 csum_fold(__wsum csum)
{
	u32 sum = (__force u32)csum;
	sum = (sum & 0xffff) + (sum >> 16);
	sum = (sum & 0xffff) + (sum >> 16);
	return (__force __sum16)~sum;
}
Clearly can be improved.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

