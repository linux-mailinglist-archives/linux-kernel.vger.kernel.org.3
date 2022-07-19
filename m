Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8677D5792F8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 08:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236929AbiGSGIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 02:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiGSGIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 02:08:18 -0400
Received: from smtp.smtpout.orange.fr (smtp01.smtpout.orange.fr [80.12.242.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86DFD2B8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 23:08:17 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id DgHgoxPJ53kbdDgHgotvMM; Tue, 19 Jul 2022 08:00:45 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Tue, 19 Jul 2022 08:00:45 +0200
X-ME-IP: 90.11.190.129
Message-ID: <00da8a58-e4d0-40c9-0b4a-011ca0754c77@wanadoo.fr>
Date:   Tue, 19 Jul 2022 08:00:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] crypto: hisilicon/zip: Use the bitmap API to allocate
 bitmaps
Content-Language: en-US
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Yang Shen <shenyang39@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-crypto@vger.kernel.org
References: <49a1b5bf6e8f7c2ad06a0e2dbc35e00169d4ebe2.1657383385.git.christophe.jaillet@wanadoo.fr>
 <YtEmS//eV3Ok08BD@gondor.apana.org.au>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <YtEmS//eV3Ok08BD@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 15/07/2022 à 10:33, Herbert Xu a écrit :
> On Sat, Jul 09, 2022 at 06:16:46PM +0200, Christophe JAILLET wrote:
>> Use bitmap_zalloc()/bitmap_free() instead of hand-writing them.
>>
>> It is less verbose and it improves the semantic.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   drivers/crypto/hisilicon/zip/zip_crypto.c | 9 ++++-----
>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/crypto/hisilicon/zip/zip_crypto.c b/drivers/crypto/hisilicon/zip/zip_crypto.c
>> index 67869513e48c..7bf53877e508 100644
>> --- a/drivers/crypto/hisilicon/zip/zip_crypto.c
>> +++ b/drivers/crypto/hisilicon/zip/zip_crypto.c
>> @@ -606,8 +606,7 @@ static int hisi_zip_create_req_q(struct hisi_zip_ctx *ctx)
>>   		req_q = &ctx->qp_ctx[i].req_q;
>>   		req_q->size = QM_Q_DEPTH;
>>   
>> -		req_q->req_bitmap = kcalloc(BITS_TO_LONGS(req_q->size),
>> -					    sizeof(long), GFP_KERNEL);
>> +		req_q->req_bitmap = bitmap_zalloc(req_q->size, GFP_KERNEL);
>>   		if (!req_q->req_bitmap) {
>>   			ret = -ENOMEM;
>>   			if (i == 0)
> 
> You should add an include for linux/bitmap.h instead of relying
> on implicit inclusion through some random header file.

Hi, most of the patches are accepted as-is, so I will not resend all of 
them.
I'll only add the #include if a v2 is needed or for new patches.

Thanks for the review and comment.

CJ

> 
> The same goes for all your other patches too.
> 
> Thanks,

