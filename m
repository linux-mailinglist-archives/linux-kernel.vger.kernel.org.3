Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F1A576816
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 22:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiGOUY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 16:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiGOUYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 16:24:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03C7F5F98F
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 13:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657916691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=puUwKs/uapaCvqGKE4ZR+Eb1cZy4rC5wzi3H3IGXfKc=;
        b=NF4Docxuibf8xW17pLNqmiwrPjERg+y8KQg16iOfXs2ey4+oo92mZh2oLcrYHMO21Qv0R5
        rs9Z82o8ihT8i2iTOvhLAGsFo7ykGJq6Jdb49CFkHOJOUjVORVgqD5HY/FQSVB+/MfGbjW
        cePQu+MLz3I4DR+stttLspBEwQwQzMw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-205-9y_cMDDrNbS7203lXrRThw-1; Fri, 15 Jul 2022 16:24:45 -0400
X-MC-Unique: 9y_cMDDrNbS7203lXrRThw-1
Received: by mail-qk1-f199.google.com with SMTP id az32-20020a05620a172000b006b58ce94435so4210091qkb.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 13:24:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=puUwKs/uapaCvqGKE4ZR+Eb1cZy4rC5wzi3H3IGXfKc=;
        b=dYXJC2iamkZ+JmBoQPwZ7fxgyI2Z1W/qjXk++tFZCchmPrzY9ggQg5BUd4WEJ7VUoy
         H6QlZ3FjDBErfv8XEVzqV78OC5QCBvkp1QYjKn8AGChV61BDoUjisGdKGmPxdiCklcPI
         +eUAHHyzthd4r7CtcI+hkPo0F97hTESWyfnbA9KX7an+cK32tYaJTH4kuypZVFZRFy5h
         91MPoyfC/FqYdbARdrklDk3kMfOOoFXTFQOCTiNurqUjD4U26UGPNWaGoso74cBS1yjj
         qPHj5vrNVIMqe+aPgDrYVHfOhZd8GJowbUpJv7MEGFtavt79Mym3Xq4vUpG+YWlY9fN5
         CF5A==
X-Gm-Message-State: AJIora82jyJZwQGnblkZ7IcpzQC8zXiSO2K0qmYoAMGwBQ7qYPh3Smlb
        dbAXsI9WojOyruJhb+C1/Vh2pLi+zRiA2PZT5nr8HQbLkXVFM28Rh2irH0K/TnuvKk5Qt7NWf95
        Iv5/YYu730pmpijjhOnHGI/Gn
X-Received: by 2002:a05:622a:144:b0:31d:428a:fdd5 with SMTP id v4-20020a05622a014400b0031d428afdd5mr13554024qtw.529.1657916684930;
        Fri, 15 Jul 2022 13:24:44 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v+kDYEmsZNCpJqhElMCI/kiibn3wjaahXsdxbRBjTE40s0SJKRoLNwukwRh59sXFKQjnDR0g==
X-Received: by 2002:a05:622a:144:b0:31d:428a:fdd5 with SMTP id v4-20020a05622a014400b0031d428afdd5mr13554013qtw.529.1657916684720;
        Fri, 15 Jul 2022 13:24:44 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id s27-20020a05622a1a9b00b0031d3996d304sm4516821qtc.17.2022.07.15.13.24.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 13:24:44 -0700 (PDT)
Subject: Re: [PATCH] drm/nouveau/bios: set info only when the return is not 0
To:     Lyude Paul <lyude@redhat.com>, bskeggs@redhat.com,
        kherbst@redhat.com, airlied@linux.ie, daniel@ffwll.ch,
        nathan@kernel.org, ndesaulniers@google.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20220702153904.1696595-1-trix@redhat.com>
 <91194b7190081545a8eeb10d20e24de864dfe259.camel@redhat.com>
 <44d6fc01654b16f9cdd6b517999ddec76038d547.camel@redhat.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <e21c527b-9f58-25ba-ce00-1bfccf048d1e@redhat.com>
Date:   Fri, 15 Jul 2022 13:24:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <44d6fc01654b16f9cdd6b517999ddec76038d547.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/15/22 12:09 PM, Lyude Paul wrote:
> On Mon, 2022-07-04 at 17:32 -0400, Lyude Paul wrote:
>> Reviewed-by: Lyude Paul <lyude@redhat.com>
>>
>> Currently on flakey internet in the back of a car, so I probably won't be
>> able
>> to push this until I get back tonight or early tomorrow
> Whoops! Slipped my mind when I got back, but I just remembered it now so I
> will go ahead and push :). apologies for the delay!

Thanks!

T

>
>> On Sat, 2022-07-02 at 11:39 -0400, Tom Rix wrote:
>>> clang static analysis reports
>>> drivers/gpu/drm/nouveau/nvkm/subdev/bios/pmu.c:68:17: warning: The right
>>> operand of '*' is a garbage value [core.UndefinedBinaryOperatorResult]
>>>          switch (!!data * *ver) {
>>>                         ^ ~~~~
>>> A switch statement with only a default should be reduced to an if.
>>>
>>> If nvbios_pmuEp() returns 0, via the data variable, the output info
>>> parameter
>>> is not used.  So set info only when data is not 0.
>>>
>>> The struct nvbios_pmuE only has the type and data elements.  Since both of
>>> these
>>> are explicitly set, memset is not needed.  So remove it.
>>>
>>> Signed-off-by: Tom Rix <trix@redhat.com>
>>> ---
>>>   drivers/gpu/drm/nouveau/nvkm/subdev/bios/pmu.c | 5 +----
>>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/pmu.c
>>> b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/pmu.c
>>> index b4a308f3cf7b..49e2664a734c 100644
>>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/pmu.c
>>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/pmu.c
>>> @@ -64,12 +64,9 @@ nvbios_pmuEp(struct nvkm_bios *bios, int idx, u8 *ver,
>>> u8
>>> *hdr,
>>>               struct nvbios_pmuE *info)
>>>   {
>>>          u32 data = nvbios_pmuEe(bios, idx, ver, hdr);
>>> -       memset(info, 0x00, sizeof(*info));
>>> -       switch (!!data * *ver) {
>>> -       default:
>>> +       if (data) {
>>>                  info->type = nvbios_rd08(bios, data + 0x00);
>>>                  info->data = nvbios_rd32(bios, data + 0x02);
>>> -               break;
>>>          }
>>>          return data;
>>>   }

