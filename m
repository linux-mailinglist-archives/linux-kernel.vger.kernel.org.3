Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B761350BC0B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449512AbiDVPuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234254AbiDVPuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:50:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 220EF5DA06
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 08:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650642428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OlUy6l6p+0482ZzVUfRyqGdQTewbaSoYgyNY1zTmabI=;
        b=fKV61xVDn+Dq4cPSjSyhMHx5QdgVos90DbiX7DkOXbvPmbHxSQilCoIjKtgtEzXwmjvn/w
        WNP1nEhDfSmzqkj+xhGinmxo95t9q6SrLvrvZSS90MPCwIUE5XdC8hQu3bC8MjOiA5mCno
        5hmob25OS8vYpjFb4/Q0q0aJEr52b74=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-Gt8e-HzJPFyMPF4Zwb9FEQ-1; Fri, 22 Apr 2022 11:47:06 -0400
X-MC-Unique: Gt8e-HzJPFyMPF4Zwb9FEQ-1
Received: by mail-ed1-f72.google.com with SMTP id dk9-20020a0564021d8900b00425a9c3d40cso2698764edb.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 08:47:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OlUy6l6p+0482ZzVUfRyqGdQTewbaSoYgyNY1zTmabI=;
        b=fdJHGMrgrpV1l4/4MALuOrUAomBNmFs43y+MzDAWxgnLyuEZcL5JuW3nVcGCvZR/vv
         cJ8attr19himlKrXIL3UiXWdP4BVQ+pikcUgXA1dxTIbQkxn2qrI+9wXU36k++b/PCvt
         1J62IKSx5PE9k23UCpKEynWTdD2KPQ/1EXeVlnkrrfKH0pNxL/sq2qL9lg9zq6nJ88OR
         Bg+8ZWJ2Ye+b/MTOyekxLIrhbEpBOFcyR0Xsdt8VzmDMGzxLbAPyPCl9Z94EQ6VjPKz7
         p0DqAJH58m3OeAZNdzVqNVCeWJBggnw5rG/Vd2HkaquvppwKHCYWsxFxj0KUjwKQKq8s
         OzVw==
X-Gm-Message-State: AOAM532ZH3MdYISvOJ5IodCnjBgnrzAeHZE/i4B+QVIgiridlveFVtwp
        sv3sMFua6Xrw43gqlsmjH7ARRl2No49R3rDyM42ekQKMvGfcIE+loXUhBFIvG3xxAkmQDghe31s
        GRP2+5OQ9Rd1rFdesRzS7zAY=
X-Received: by 2002:aa7:dc49:0:b0:41d:72e2:d34e with SMTP id g9-20020aa7dc49000000b0041d72e2d34emr5507178edu.385.1650642425640;
        Fri, 22 Apr 2022 08:47:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFAEE1VI+rkI2TiIlFRwMgrd+6Gm1qiHH/aaBKToMrAJsFJRrIiqTZsXd/t0p6TRHUNMoGiw==
X-Received: by 2002:aa7:dc49:0:b0:41d:72e2:d34e with SMTP id g9-20020aa7dc49000000b0041d72e2d34emr5507163edu.385.1650642425483;
        Fri, 22 Apr 2022 08:47:05 -0700 (PDT)
Received: from [192.168.9.10] (net-188-152-140-108.cust.vodafonedsl.it. [188.152.140.108])
        by smtp.gmail.com with ESMTPSA id j4-20020a170906278400b006e99f136c78sm859368ejc.23.2022.04.22.08.47.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 08:47:04 -0700 (PDT)
Message-ID: <736b71d7-1e07-f5c3-d8ad-c3e1b1595d5c@redhat.com>
Date:   Fri, 22 Apr 2022 17:47:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] fpga: altera-pr-ip: fix unsigned comparison with less
 than zero
Content-Language: en-US
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220405185349.220607-1-marpagan@redhat.com>
 <Yl+K789ZUWd5Si0B@archbook>
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <Yl+K789ZUWd5Si0B@archbook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-20 06:24, Moritz Fischer wrote:
> Marco,
> 
> On Tue, Apr 05, 2022 at 08:53:49PM +0200, Marco Pagani wrote:
>> Fix the "comparison with less than zero" warning reported by
>> cppcheck for the unsigned (size_t) parameter "count" of the
>> "alt_pr_fpga_write()" function.
>>
> Should this have a Reported-by: tag?

I found this problem using the "cppcheck" tool, as reported in the
commit log. I did not find any previous report of this. Am I missing
something?

>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
>> ---
>>  drivers/fpga/altera-pr-ip-core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/altera-pr-ip-core.c
>> index be0667968d33..2ff3d8e46a0c 100644
>> --- a/drivers/fpga/altera-pr-ip-core.c
>> +++ b/drivers/fpga/altera-pr-ip-core.c
>> @@ -108,7 +108,7 @@ static int alt_pr_fpga_write(struct fpga_manager *mgr, const char *buf,
>>  	u32 *buffer_32 = (u32 *)buf;
>>  	size_t i = 0;
>>  
>> -	if (count <= 0)
>> +	if (count == 0)
>>  		return -EINVAL;
> 
> if (!count)
> 	return -EINVAL?

Ok, I'll change that in v2.

>>  
>>  	/* Write out the complete 32-bit chunks */
>> -- 
>> 2.35.1
> 
> Cheers,
> Moritz
>>
> 

Cheers,
Marco

