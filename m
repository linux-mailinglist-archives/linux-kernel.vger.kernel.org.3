Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE204D9854
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346912AbiCOKGq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 15 Mar 2022 06:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346904AbiCOKGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:06:40 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CF1A6254
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 03:05:28 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-304-uWX6q3UgNeCPTFM2ROAnlw-1; Tue, 15 Mar 2022 10:05:25 +0000
X-MC-Unique: uWX6q3UgNeCPTFM2ROAnlw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Tue, 15 Mar 2022 10:05:24 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Tue, 15 Mar 2022 10:05:24 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Haowen Bai' <baihaowen@meizu.com>,
        "freude@linux.ibm.com" <freude@linux.ibm.com>,
        "hca@linux.ibm.com" <hca@linux.ibm.com>,
        "gor@linux.ibm.com" <gor@linux.ibm.com>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>
CC:     "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] s390: crypto: Use min() instead of doing it manually
Thread-Topic: [PATCH v2] s390: crypto: Use min() instead of doing it manually
Thread-Index: AQHYOELYjbjSeN2P+kqBKqCPXkmb6KzANxKg
Date:   Tue, 15 Mar 2022 10:05:24 +0000
Message-ID: <cc26b079f808420592cfea19580e34f5@AcuMS.aculab.com>
References: <1647331264-13853-1-git-send-email-baihaowen@meizu.com>
In-Reply-To: <1647331264-13853-1-git-send-email-baihaowen@meizu.com>
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

From: Haowen Bai
> Sent: 15 March 2022 08:01
> 
> Fix following coccicheck warning:
> drivers/s390/crypto/zcrypt_ep11misc.c:1112:25-26: WARNING opportunity for min()
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  drivers/s390/crypto/zcrypt_ep11misc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
> index 9ce5a71..bb2a527 100644
> --- a/drivers/s390/crypto/zcrypt_ep11misc.c
> +++ b/drivers/s390/crypto/zcrypt_ep11misc.c
> @@ -1109,7 +1109,7 @@ static int ep11_wrapkey(u16 card, u16 domain,
>  	if (kb->head.type == TOKTYPE_NON_CCA &&
>  	    kb->head.version == TOKVER_EP11_AES) {
>  		has_header = true;
> -		keysize = kb->head.len < keysize ? kb->head.len : keysize;
> +		keysize = min((size_t)kb->head.len, keysize);

I'm sure that would look better as:
		if (keysize > kb->head.len)
			keysize = kb->head.len;
which makes it much more obvious that the existing value
is being limited by a new bound.

	David

>  	}
> 
>  	/* request cprb and payload */
> --
> 2.7.4

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

