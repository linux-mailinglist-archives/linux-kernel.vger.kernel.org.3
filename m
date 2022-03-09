Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDD14D2683
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbiCIBqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiCIBqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:46:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0BCDB1516
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 17:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646790346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SoSjGNV88MG8vTOWxA+NDnTl5MshzRww6v3Ri4neFBo=;
        b=Di/XAU/7UCbNx3IHpFCjVjoDoTmgv4dgHOUfxBXkuQjEwNKBd5NkYLGR4PrnhWop8XhDAI
        /Z9PaRxAqQ0ebiqZxpNlPNUsocQpJSR37mDFt0shfWH1qrMZitfwRs5TRqT+b1dN3c8YhK
        vkCVircHwImCb5g2Pm58fETWQTyihkw=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-346-YXsLv1IKP5iLMbm2LLZ_3A-1; Tue, 08 Mar 2022 20:45:45 -0500
X-MC-Unique: YXsLv1IKP5iLMbm2LLZ_3A-1
Received: by mail-il1-f200.google.com with SMTP id 3-20020a056e020ca300b002c2cf74037cso459781ilg.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 17:45:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=SoSjGNV88MG8vTOWxA+NDnTl5MshzRww6v3Ri4neFBo=;
        b=bo2cGSavHFcycwNw8ActfzdSCi3S4ZWd6anFF/v8gk+ML681LHCvvGAn3KjVQMJs9V
         Qz2IdFEHVrNiQzPHq4Uis428WzhUKjdPZ537oejAnsdoQqZsGnDrGKFLN7sNLtIXuXFG
         S/DPFRm404Ov6K+D3Y3cC+NQ4Iz/uun33/3uxJnsMOWQ1fCLiXotooRA1zNogrlOLEWj
         aBH4XNs6LNZoknXKH7APwDa0bjnCJab1zrlimx9u5mTLFF+lecsitjWjnfJfWt8EPsQm
         os2eImPwRMznPOB1YZ/FqKYpmgcijtR3BaP0iTXQ7Sz5YuKg1r6unSQeKT26ub0HS8Pz
         gf5g==
X-Gm-Message-State: AOAM533obnQm34RXMdhCQ0aVawdBxYOIXqwcEls77O6zI3MyIi/3Xup0
        SvhKr4FWkFujHOWgDjk5+heIuiCQexqvNF+UqfVlsIaa1pfe7kHqqUuQqJudXbHr5GwDsGeZX/d
        ik5n/Px9K2EjxcyMWHmJfvDDm
X-Received: by 2002:a05:6638:408:b0:313:f2bd:2d2 with SMTP id q8-20020a056638040800b00313f2bd02d2mr18041834jap.110.1646790344952;
        Tue, 08 Mar 2022 17:45:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzS8AzsMXjFYL+igfxZixZE0Qq62nR7+uTTQrLwMYMJvP3DkjKhEFaYhZPtj7W2LUu1X5ok/g==
X-Received: by 2002:a05:6638:408:b0:313:f2bd:2d2 with SMTP id q8-20020a056638040800b00313f2bd02d2mr18041820jap.110.1646790344764;
        Tue, 08 Mar 2022 17:45:44 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id p4-20020a92d284000000b002c64436fa71sm281578ilp.72.2022.03.08.17.45.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 17:45:44 -0800 (PST)
Subject: Re: [PATCH] drm/bridge: anx7625: check the return on
 anx7625_aux_trans
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     andrzej.hajda@intel.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, nathan@kernel.org, xji@analogixsemi.com,
        sam@ravnborg.org, tzungbi@google.com, pihsun@chromium.org,
        maxime@cerno.tech, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        hsinyi@chromium.org
References: <20220303201943.501746-1-trix@redhat.com>
 <CAKwvOdnoV_SsFuWWJd4nOOd1vGG6_-gg-KvdOg4_NHuRp7_WfA@mail.gmail.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <5b6a10bd-5650-2924-d1cc-e4664a0e7255@redhat.com>
Date:   Tue, 8 Mar 2022 17:45:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAKwvOdnoV_SsFuWWJd4nOOd1vGG6_-gg-KvdOg4_NHuRp7_WfA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/8/22 2:57 PM, Nick Desaulniers wrote:
> On Thu, Mar 3, 2022 at 12:19 PM <trix@redhat.com> wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> Clang static analysis reports this issue
>> anx7625.c:876:13: warning: The left operand of '&' is
>>    a garbage value
>>    if (!(bcap & 0xOA01)) {
>>          ~~~~ ^
>>
>> bcap is only set by a successful call to
>> anx7625_aux_trans().  So check.
>>
>> Fixes: cd1637c7e480 ("drm/bridge: anx7625: add HDCP support")
> Is this the correct Fixes tag?
yes
> I think it should be
>
> Fixes: adca62ec370c ("drm/bridge: anx7625: Support reading edid
> through aux channel")

This one changes the name of the function

-       anx7625_aux_dpcd_trans(ctx, DP_AUX_NATIVE_READ, 0x68028, 1, &bcap);
+       anx7625_aux_trans(ctx, DP_AUX_NATIVE_READ, 0x68028, 1, &bcap);

A return check from the earlier commit, when this block of code came 
into existence, is when it was first needed.

Tom

>
> instead.
>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>   drivers/gpu/drm/bridge/analogix/anx7625.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
>> index 633618bafd75d..f02ac079ed2ec 100644
>> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
>> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
>> @@ -872,7 +872,10 @@ static int anx7625_hdcp_enable(struct anx7625_data *ctx)
>>          }
>>
>>          /* Read downstream capability */
>> -       anx7625_aux_trans(ctx, DP_AUX_NATIVE_READ, 0x68028, 1, &bcap);
>> +       ret = anx7625_aux_trans(ctx, DP_AUX_NATIVE_READ, 0x68028, 1, &bcap);
>> +       if (ret < 0)
>> +               return ret;
>> +
>>          if (!(bcap & 0x01)) {
>>                  pr_warn("downstream not support HDCP 1.4, cap(%x).\n", bcap);
>>                  return 0;
>> --
>> 2.26.3
>>
>

