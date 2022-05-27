Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164385366A2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 19:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353792AbiE0RjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 13:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349687AbiE0RjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 13:39:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA3EB33E80
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 10:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653673135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XH8JceMnzACPxOVYRi5rGL9yBlbFn5ESC6LUPE3+e88=;
        b=gT7M6hBdJuwt9/JDUNNbzdg6LYIqPvTsGsajpkgVK2gFxnx9Aqf4fhLziMTDPhDwCofEps
        Yi4lf8ZICvvlGqgxi4x8vc3OkNjsciCzsMhhMrx7P25xReDmGeeeDbWYmW43xubQpOoMp3
        DrgUhHHXevUbkrLv1Si5n832tBPPYYs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-46-tqWtD_v0PJe3d8QwPlbgMg-1; Fri, 27 May 2022 13:38:46 -0400
X-MC-Unique: tqWtD_v0PJe3d8QwPlbgMg-1
Received: by mail-ej1-f71.google.com with SMTP id lf18-20020a170906ae5200b006fec8de9f0cso2728148ejb.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 10:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:date:mime-version:user-agent:cc
         :subject:content-language:to:references:in-reply-to
         :content-transfer-encoding;
        bh=XH8JceMnzACPxOVYRi5rGL9yBlbFn5ESC6LUPE3+e88=;
        b=yhbC/EbymMt3PGmupzFSrUv/nEvvNuGcCjsicoD/nC4c/fhPAtQPGNsMeeXuyIMRwY
         ife1rLtMWNo+tKSmIRz+fQd6jo5reW36ESt6DgT6kgdhIAePFH20S0GI0N5ysA9mGhA+
         cVFiVF5W4o4y+K1ag3L0wdQy1Qp/U2ki4AdqENmO3Ydwckm/pBNPew5Mc4rq4Z8AJ8CH
         Z4teKq7yAoverVE4M2W+CVEVZcOH6f9b1+vvgVqxBOAmqCcQKGHHWhWPNRrpFDj/F+mb
         Q9Zk9SHX+2BZghvV7ddT+6cICEPpU7nqF1QmLEWDTvzC+mRlV0tW5MtASSLQs76NVFWh
         KV3Q==
X-Gm-Message-State: AOAM530+7yKAs7wKWBlX99WUM5zjLuC9WSN85ZbjN/mvhkXVeDUiUutM
        4KHgULQz1aBB3H+xf2e7qjgb1YmQtiBdV2O9Y0JSUdbKAdQSEe34MX5LLmACsK675bw8u/yvUmN
        LnzKLjTYzpI1LDDFMyD/LXydw
X-Received: by 2002:a17:907:3f89:b0:6fe:e7a7:c038 with SMTP id hr9-20020a1709073f8900b006fee7a7c038mr23489288ejc.730.1653673125047;
        Fri, 27 May 2022 10:38:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfq/KHum1beI0pgS8zFIy4p88rHKII0qWsjSMtxoomkBINIhFL+w4teXgASOhFb6U+XLzhsQ==
X-Received: by 2002:a17:907:3f89:b0:6fe:e7a7:c038 with SMTP id hr9-20020a1709073f8900b006fee7a7c038mr23489277ejc.730.1653673124823;
        Fri, 27 May 2022 10:38:44 -0700 (PDT)
Received: from [192.168.0.50] (87-59-106-155-cable.dk.customer.tdc.net. [87.59.106.155])
        by smtp.gmail.com with ESMTPSA id bg17-20020a170906a05100b006fef5088792sm1645631ejb.108.2022.05.27.10.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 May 2022 10:38:43 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <2e34593e-65e3-df74-1280-5db6dc948130@redhat.com>
Date:   Fri, 27 May 2022 19:38:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Cc:     brouer@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
        jonathan.lemon@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: xdp: Directly use ida_alloc()/free()
Content-Language: en-US
To:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        keliu <liuke94@huawei.com>
References: <20220527064609.2358482-1-liuke94@huawei.com>
 <YpEFpVkxRRFi+Cs8@boxer>
In-Reply-To: <YpEFpVkxRRFi+Cs8@boxer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/05/2022 19.08, Maciej Fijalkowski wrote:
> On Fri, May 27, 2022 at 06:46:09AM +0000, keliu wrote:
>> Use ida_alloc()/ida_free() instead of deprecated
>> ida_simple_get()/ida_simple_remove() .
>>
>> Signed-off-by: keliu <liuke94@huawei.com>

Could you use your full name with capital letters?

> 
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> For future AF_XDP related patches please specify the bpf-next tree in the
> patch subject (or bpf if it's a fix).

I agree.

Could you also take care of net/core/xdp.c ?

Patch LGTM

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>


>> ---
>>   net/xdp/xdp_umem.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
>> index f01ef6bda390..869b9b9b9fad 100644
>> --- a/net/xdp/xdp_umem.c
>> +++ b/net/xdp/xdp_umem.c
>> @@ -57,7 +57,7 @@ static int xdp_umem_addr_map(struct xdp_umem *umem, struct page **pages,
>>   static void xdp_umem_release(struct xdp_umem *umem)
>>   {
>>   	umem->zc = false;
>> -	ida_simple_remove(&umem_ida, umem->id);
>> +	ida_free(&umem_ida, umem->id);
>>   
>>   	xdp_umem_addr_unmap(umem);
>>   	xdp_umem_unpin_pages(umem);
>> @@ -242,7 +242,7 @@ struct xdp_umem *xdp_umem_create(struct xdp_umem_reg *mr)
>>   	if (!umem)
>>   		return ERR_PTR(-ENOMEM);
>>   
>> -	err = ida_simple_get(&umem_ida, 0, 0, GFP_KERNEL);
>> +	err = ida_alloc(&umem_ida, GFP_KERNEL);
>>   	if (err < 0) {
>>   		kfree(umem);
>>   		return ERR_PTR(err);
>> @@ -251,7 +251,7 @@ struct xdp_umem *xdp_umem_create(struct xdp_umem_reg *mr)
>>   
>>   	err = xdp_umem_reg(umem, mr);
>>   	if (err) {
>> -		ida_simple_remove(&umem_ida, umem->id);
>> +		ida_free(&umem_ida, umem->id);
>>   		kfree(umem);
>>   		return ERR_PTR(err);
>>   	}
>> -- 
>> 2.25.1
>>
> 

