Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37EB4F6601
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237832AbiDFQxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238433AbiDFQwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:52:51 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16087287A04
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 07:56:40 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id dr20so4800448ejc.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 07:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rlY4KHSQuSWJ6+c5NPPa6AObOciU4SZOuy8LXluxVrg=;
        b=j2dztHvM+ou/RPadGfgGmoGDsQVrNAezyM2BwMa8TnIksZPHmH4ztCZYVNyh98wZBI
         KdvJmTCfMW09uUny7vOzBwuFFdFqGQuiMzI52x9cfxl4F/+4Opx5mAjnhu7fDZSFW8TF
         WkIsE7epHxsZ8+zxFLqPT4nL5av1+K3o7C6FCnX5fcKdyYt5TtdzvXck4LbH0gKxbUc+
         SOKn+iWWMA4Hd5WAZdQfkbIdofj9CtElpApI3A2JgJxxk7vtk5wn5M/MUu8C6FykxpPg
         iCoE7Uhj+s93Wse3FPlbJK/T6HKM1ZroXRvkJi2BA23QiEFEVNpmBPuBtbxkq9D4JKzu
         FTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rlY4KHSQuSWJ6+c5NPPa6AObOciU4SZOuy8LXluxVrg=;
        b=Ke3ZJwH2bsU8t+rHJQuEcNoT4OPDOPXGq5759SO5dfllhUm/hg3QrjYrpCbRvpElL1
         FOe0G8792Q16oT7zjIQ4UG9omjJo5Po5qJi7C66/ZV1w2+pvLuss5Yq5rk1bcjML7OYI
         Hiu/VYVolBHZ9ZdfiGkMa3xbpaMxO2ABfQSYCwk3ziJasLcuUra3xASxy+5D1GQaf/ty
         vSBZ//oIlIZSSSJxVtwk03Xhpw/eRCl2roUuLQKqjHTL6eTQcCljU0hx2mP4YhQ3qtMC
         vNaMqzx+mbhx4o0nDni7Y83Z29oinhroHm8umnbeeUkNHOsjC1tXyZFjtbP/b2m4F7NR
         EDyQ==
X-Gm-Message-State: AOAM530IOdc0NJO23hjJT2PkedybMxOAdBwTqavFMyM9pntJg7kiQzDX
        kR2YMl8lH2tQhroyqtf2FPtJK9mjwnk=
X-Google-Smtp-Source: ABdhPJy3sEcLDR4B3Kd8dpO4zY04GaCQ++ce6gaGLezsna6AFa2rk5W7BBxQ122G6DAt+byOAv8i0A==
X-Received: by 2002:a17:906:6a1a:b0:6e1:87a:151f with SMTP id qw26-20020a1709066a1a00b006e1087a151fmr8518916ejc.715.1649256998471;
        Wed, 06 Apr 2022 07:56:38 -0700 (PDT)
Received: from [192.168.0.253] (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id e7-20020a170906648700b006e7f08fe590sm3542760ejm.198.2022.04.06.07.56.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 07:56:37 -0700 (PDT)
Message-ID: <9d80845a-0ccb-b94f-a9c2-84559dcc0adc@gmail.com>
Date:   Wed, 6 Apr 2022 16:56:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/5] staging: r8188eu: use round_up() instead of RND4()
Content-Language: en-US
To:     Joe Perches <joe@perches.com>, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220406061859.9011-1-straube.linux@gmail.com>
 <20220406061859.9011-2-straube.linux@gmail.com>
 <e56d9ca89544ad015c6cfabaf2859027c0dd50e5.camel@perches.com>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <e56d9ca89544ad015c6cfabaf2859027c0dd50e5.camel@perches.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/22 11:54, Joe Perches wrote:
> On Wed, 2022-04-06 at 08:18 +0200, Michael Straube wrote:
>> Use in-kernel round_up() instead of custom RND4().
> []
>> diff --git a/drivers/staging/r8188eu/core/rtw_security.c b/drivers/staging/r8188eu/core/rtw_security.c
> []
>> @@ -63,7 +63,7 @@ void rtw_wep_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe)
>>   				arc4_crypt(ctx, payload + length, crc.f1, 4);
>>   
>>   				pframe += pxmitpriv->frag_len;
>> -				pframe = (u8 *)RND4((size_t)(pframe));
>> +				pframe = (u8 *)round_up((size_t)pframe, 4);
> 
> Perhaps use PTR_ALIGN
> 
> 				pframe = PTR_ALIGN(pframe, 4);
> 
> etc...

Sounds reasonable, I'll send v2 soon.

Thanks,
Michael

