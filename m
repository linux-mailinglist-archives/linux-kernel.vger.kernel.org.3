Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1935C52C962
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 03:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbiESBog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 21:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiESBoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 21:44:32 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E020AA2069;
        Wed, 18 May 2022 18:44:31 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id v11so3789131pff.6;
        Wed, 18 May 2022 18:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mbuJI+gNNsnapQt0Qvv9iNuwu+eovYf9lVgBCCJI78U=;
        b=ajqher2YgxmqQDroR/4zR9r610S3kUlQUa1mN1h6PXbd5/MiFWfKmYTFEBNy+rMG3H
         DxJyfpelPc4A4dccxm0+aoh3wI8bnXL1iVNtNk1AJStRVU/xNcTo7qCqpDTNRYMJPCNU
         K1HRec/pdXuA3/wiarxTxYaxU0z7yY/LL8ckFv74rhUpfMpDH1IPyOIKXWZOTJ2sH8VB
         ov8G2USxMnctVB3CcHTuKU+GpOIUPBnQefs7tzUZy41zlOQvy4H7dQJlsOZ5Q3Ph+GhL
         uFrUCJvrKPGkQHRa6s4g7axZYw/SvdHoi4M2IME+BrQwzhA0UZ6JrSIzJh/WNFdfCwyk
         mYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mbuJI+gNNsnapQt0Qvv9iNuwu+eovYf9lVgBCCJI78U=;
        b=W5LsaTLFARhSTOIs4OURIrro8jf8px8UCfrv69oilUL9qlXlQBHm0j2jdUFSwKQ65j
         BJSbk+LqHWDmcm9DuqvfPSM64FEOfdGnzb4VwzaOXDDT3FLFLeh3p3zqiueDblC607Dh
         hrDcz7D5rSY2n5ooCCWo1hH8doeDSP9WBqPmg/VIYhbUNC/QiAoisED3WysKCxwaEcUu
         6H056aQipgm2+31eC8kGa3F/2uCGI0LeU9ZmQrEbCLvgKXhu5Y9BDM7VhYgBrVEHDfKU
         9rD7/oYn9HoJIo1Dir3tC74uCcwcnA+H3sYc+HK/FyTgkEJCjcXPmVH+qVGKOahdGPPB
         sFXw==
X-Gm-Message-State: AOAM5322CFVLzLYRDgpJ1IGpgDAYdYbagX65lKehhnoUlti89l8qvlSL
        /NVJAuAkust/3XRxtklZG2f2wIyixff8lw==
X-Google-Smtp-Source: ABdhPJyXp33osGU/XElJ8aueGhNR3/ULXgWIydhzmtY9mRPqBDYwiLG0KvoV1gyszppaZ62klFArQg==
X-Received: by 2002:a65:6552:0:b0:3db:772a:2465 with SMTP id a18-20020a656552000000b003db772a2465mr1923492pgw.225.1652924671390;
        Wed, 18 May 2022 18:44:31 -0700 (PDT)
Received: from [192.168.50.247] ([103.84.139.165])
        by smtp.gmail.com with ESMTPSA id c16-20020a056a00249000b0050dc76281f8sm2698419pfv.210.2022.05.18.18.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 18:44:30 -0700 (PDT)
Message-ID: <1b34dc88-ac62-af5e-2893-363948368eca@gmail.com>
Date:   Thu, 19 May 2022 09:44:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] media: dvb_vb2: fix possible out of bound access
Content-Language: en-US
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>, mchehab@kernel.org,
        senozhatsky@chromium.org, caihuoqing@baidu.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220324080119.40133-1-hbh25y@gmail.com>
 <32fac87b-0e57-8cf1-ac1e-38e2bee82af2@xs4all.nl>
From:   Hangyu Hua <hbh25y@gmail.com>
In-Reply-To: <32fac87b-0e57-8cf1-ac1e-38e2bee82af2@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/18 18:44, Hans Verkuil wrote:
> Hi Hangyu,
> 
> It appears this patch fell through the cracks. It's certainly useful to
> have.
> 
> On 3/24/22 09:01, Hangyu Hua wrote:
>> vb2_core_qbuf and vb2_core_querybuf don't check the range of b->index
>> controlled by the user.
>>
>> Fix this by adding range checking code before using them.
>>
>> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
>> ---
>>   drivers/media/dvb-core/dvb_vb2.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/media/dvb-core/dvb_vb2.c b/drivers/media/dvb-core/dvb_vb2.c
>> index a1bd6d9c9223..f410800b92e7 100644
>> --- a/drivers/media/dvb-core/dvb_vb2.c
>> +++ b/drivers/media/dvb-core/dvb_vb2.c
>> @@ -354,6 +354,12 @@ int dvb_vb2_reqbufs(struct dvb_vb2_ctx *ctx, struct dmx_requestbuffers *req)
>>   
>>   int dvb_vb2_querybuf(struct dvb_vb2_ctx *ctx, struct dmx_buffer *b)
>>   {
>> +	struct vb2_queue *q = &ctx->vb_q;
>> +
>> +	if (b->index >= q->num_buffers) {
>> +		dprintk(q, 1, "buffer index out of range\n");
> 
> However, this patch doesn't compile: dprintk in this source doesn't
> have a 'q' argument!

Oops, i will fix this out.

> 
>> +		return -EINVAL;
>> +	}
>>   	vb2_core_querybuf(&ctx->vb_q, b->index, b);
>>   	dprintk(3, "[%s] index=%d\n", ctx->name, b->index);
> 
> Also, to help debugging it prefixes the warnings with the ctx-name.
> 
> Can you post a v2 of this patch?
> 
> Regards,
> 
> 	Hans

I will send a v2 later.

Thanks,
Hangyu

> 
>>   	return 0;
>> @@ -378,8 +384,13 @@ int dvb_vb2_expbuf(struct dvb_vb2_ctx *ctx, struct dmx_exportbuffer *exp)
>>   
>>   int dvb_vb2_qbuf(struct dvb_vb2_ctx *ctx, struct dmx_buffer *b)
>>   {
>> +	struct vb2_queue *q = &ctx->vb_q;
>>   	int ret;
>>   
>> +	if (b->index >= q->num_buffers) {
>> +		dprintk(q, 1, "buffer index out of range\n");
>> +		return -EINVAL;
>> +	}
>>   	ret = vb2_core_qbuf(&ctx->vb_q, b->index, b, NULL);
>>   	if (ret) {
>>   		dprintk(1, "[%s] index=%d errno=%d\n", ctx->name,
