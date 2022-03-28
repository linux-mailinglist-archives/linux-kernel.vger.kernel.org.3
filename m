Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877894E965A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 14:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242348AbiC1MSM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Mar 2022 08:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240810AbiC1MRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 08:17:38 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43AE04CD74
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 05:15:56 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-27-TcnwqCKnMxai5DN2Awq6DQ-1; Mon, 28 Mar 2022 13:15:53 +0100
X-MC-Unique: TcnwqCKnMxai5DN2Awq6DQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Mon, 28 Mar 2022 13:15:49 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Mon, 28 Mar 2022 13:15:49 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Haowen Bai' <baihaowen@meizu.com>,
        "hca@linux.ibm.com" <hca@linux.ibm.com>,
        "gor@linux.ibm.com" <gor@linux.ibm.com>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
        "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
        "svens@linux.ibm.com" <svens@linux.ibm.com>
CC:     "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] s390: Simplify the calculation of variables
Thread-Topic: [PATCH] s390: Simplify the calculation of variables
Thread-Index: AQHYQkyh2V0uApXDj0OeQmyHV3vyOqzUtGdw
Date:   Mon, 28 Mar 2022 12:15:49 +0000
Message-ID: <9ab80e670fb341ddaba51a9cd78203fe@AcuMS.aculab.com>
References: <1648434982-28862-1-git-send-email-baihaowen@meizu.com>
In-Reply-To: <1648434982-28862-1-git-send-email-baihaowen@meizu.com>
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
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haowen Bai
> Sent: 28 March 2022 03:36
> 
> Fix the following coccicheck warnings:
> ./arch/s390/include/asm/scsw.h:695:47-49: WARNING
>  !A || A && B is equivalent to !A || B
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  arch/s390/include/asm/scsw.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/s390/include/asm/scsw.h b/arch/s390/include/asm/scsw.h
> index a7c3ccf..f2baac8 100644
> --- a/arch/s390/include/asm/scsw.h
> +++ b/arch/s390/include/asm/scsw.h
> @@ -692,8 +692,7 @@ static inline int scsw_tm_is_valid_pno(union scsw *scsw)
>  	return (scsw->tm.fctl != 0) &&
>  	       (scsw->tm.stctl & SCSW_STCTL_STATUS_PEND) &&
>  	       (!(scsw->tm.stctl & SCSW_STCTL_INTER_STATUS) ||
> -		 ((scsw->tm.stctl & SCSW_STCTL_INTER_STATUS) &&
> -		  (scsw->tm.actl & SCSW_ACTL_SUSPENDED)));
> +	       (scsw->tm.actl & SCSW_ACTL_SUSPENDED))
>  }

I'd split that impenetrable boolean expression up.

I think this is equivalent:
	if (!scsw->tm.fctl)
		return 0;
	if (!(scsw->tm.stctl & SCSW_STCTL_STATUS_PEND))
		return 0;
	if (!(scsw->tm.stctl & SCSW_STCTL_INTER_STATUS))
		return 1
	if (scsw->tm.actl & SCSW_ACTL_SUSPENDED)
		return 1;
	return 0;

The generated code could even be the same.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

