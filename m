Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EADF493BD8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 15:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355104AbiASOSK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 19 Jan 2022 09:18:10 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:32883 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354883AbiASOSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 09:18:10 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-243-kEKB9QAQOeyRAULQtHiVnQ-1; Wed, 19 Jan 2022 14:18:04 +0000
X-MC-Unique: kEKB9QAQOeyRAULQtHiVnQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Wed, 19 Jan 2022 14:18:04 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Wed, 19 Jan 2022 14:18:03 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jens Wiklander' <jens.wiklander@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>
CC:     Sumit Garg <sumit.garg@linaro.org>
Subject: RE: [PATCH] optee: add error checks in optee_ffa_do_call_with_arg()
Thread-Topic: [PATCH] optee: add error checks in optee_ffa_do_call_with_arg()
Thread-Index: AQHYDQuoEhzAP+30x0KhL4kws6vao6xqZH0A
Date:   Wed, 19 Jan 2022 14:18:03 +0000
Message-ID: <bf3c1583f8d7466a96bab8feb462bb36@AcuMS.aculab.com>
References: <20220119080736.2940906-1-jens.wiklander@linaro.org>
In-Reply-To: <20220119080736.2940906-1-jens.wiklander@linaro.org>
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

From: Jens Wiklander
> Sent: 19 January 2022 08:08
> 
> Adds error checking in optee_ffa_do_call_with_arg() for correctness.
> 
> Fixes: 4615e5a34b95 ("optee: add FF-A support")
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/optee/ffa_abi.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> index d8c8683863aa..d88bd2e41572 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -619,9 +619,18 @@ static int optee_ffa_do_call_with_arg(struct tee_context *ctx,
>  		.data2 = (u32)(shm->sec_world_id >> 32),
>  		.data3 = shm->offset,
>  	};
> -	struct optee_msg_arg *arg = tee_shm_get_va(shm, 0);
> -	unsigned int rpc_arg_offs = OPTEE_MSG_GET_ARG_SIZE(arg->num_params);
> -	struct optee_msg_arg *rpc_arg = tee_shm_get_va(shm, rpc_arg_offs);
> +	struct optee_msg_arg *arg;
> +	unsigned int rpc_arg_offs;
> +	struct optee_msg_arg *rpc_arg;
> +
> +	arg = tee_shm_get_va(shm, 0);
> +	if (IS_ERR(arg))
> +		return PTR_ERR(arg);
> +
> +	rpc_arg_offs = OPTEE_MSG_GET_ARG_SIZE(arg->num_params);
> +	rpc_arg = tee_shm_get_va(shm, rpc_arg_offs);
> +	if (IS_ERR(arg))
> +		return PTR_ERR(arg);

What's this duplicate test for?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

