Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000F54CAEBA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 20:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238062AbiCBTcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 14:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbiCBTcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 14:32:06 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F93BD64F4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:31:23 -0800 (PST)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 221F73F07E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 19:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646249482;
        bh=h7zoiHroALo7RM2Ucqc+edums/unXH0DNAll2z0zzoI=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=ni+aXlkowli1/cMc2XxZcdEpnfoCXecPMDooQlGNr7UU7dk4xGQloLDOIPnUCXYVR
         zdAoV2aWi++fgXailw6BTsUp1D8Lt/W34Mr4dXynyi1vVzIDPbNGzuYHZjTuCuNLjf
         ncLI7PAbcWCasYr3HG6ikOtD6AjLnzmsEsrP4boz8RV79Gi6Z1pG3YoKTk3yLNkp8o
         qYWHnhTU6SWOD9xbI2Oy9jhkugwrYY6POTUH0r93dEVk6kDUVU1EADNqtmoLQw7aCZ
         6QpzCJcF+/3NWAUOZ+IBNAQXmbNZm7QRmDVjXLwTLz41swENH0HM/6ajs8rCvaRKAe
         a0UWn5kV6yotQ==
Received: by mail-wm1-f69.google.com with SMTP id o21-20020a05600c511500b003818c4b98b5so793500wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 11:31:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=h7zoiHroALo7RM2Ucqc+edums/unXH0DNAll2z0zzoI=;
        b=VLPTCRqCDQ53fa4+QgjTTpzvCjoqjkCLYWKWk8gL5HsanXgqNX6X5Mjy/VzANNQyF0
         YWThz0sMn4m1UrIzQG/iOVeCohMomAYuxDMBZEoKMQrK8lc7M14Lo1y2PxArrOHjvHLJ
         Bj2lYrLcZex+rluvKySr4PlH0tFjaXB3YhD6riR8PdSRjWMsLeWQQgGW+aSV/nFi/2O5
         jNG+R/7nUUQW1QryIg1TW3SiWyv0E51T09nUXENTA5fO7lBcI0YDjZvsNEfsixIw0FP5
         8FHabd8ztz04PugM09LD1mzwyK34SqWTIFEZHHobOyfc3+ZtZRxXUT1AZ7Otsy3el+UI
         41hw==
X-Gm-Message-State: AOAM530mbtwKafNWS7HacarDoW7T77Qi9Vy4+NUoLHdcbGxdsi3Ny5tQ
        eAVoYOOukbkPswveWbpbDpnZSCDC5KR1NexVBrjBxFLrvkxmoCmUuJ4JXyh39aPl/BNNXYr1Ktk
        E0rffMA90bVXIl2cruieHtEZ+3/0lXpUvCOY8jpR/Jw==
X-Received: by 2002:a05:6000:508:b0:1e4:a027:d147 with SMTP id a8-20020a056000050800b001e4a027d147mr24344771wrf.315.1646249481829;
        Wed, 02 Mar 2022 11:31:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwacERm1jqXGVZsAJ8yvmRStyZfoO559hV3UUAuxRuYbfDu3w787ac8/2QnUb/1f7xbH8Keeg==
X-Received: by 2002:a05:6000:508:b0:1e4:a027:d147 with SMTP id a8-20020a056000050800b001e4a027d147mr24344763wrf.315.1646249481644;
        Wed, 02 Mar 2022 11:31:21 -0800 (PST)
Received: from [192.168.0.137] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id c12-20020a05600c0a4c00b00381141f4967sm10016714wmq.35.2022.03.02.11.31.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 11:31:20 -0800 (PST)
Message-ID: <b7f68054-707c-8b76-23ab-027a8aab41f0@canonical.com>
Date:   Wed, 2 Mar 2022 20:31:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Patch v4 2/4] dt-bindings: memory: Update reg maxitems for
 tegra186
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Ashish Mhetre <amhetre@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, digetx@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, vdumpa@nvidia.com, Snikam@nvidia.com
References: <1646210609-21943-1-git-send-email-amhetre@nvidia.com>
 <1646210609-21943-3-git-send-email-amhetre@nvidia.com>
 <Yh+um1TSNWK8P6GY@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <Yh+um1TSNWK8P6GY@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2022 18:51, Rob Herring wrote:
> On Wed, Mar 02, 2022 at 02:13:27PM +0530, Ashish Mhetre wrote:
>> >From tegra186 onwards, memory controller support multiple channels.
>> Reg items are updated with address and size of these channels.
>> Tegra186 has overall 5 memory controller channels. Tegra194 and tegra234
>> have overall 17 memory controller channels each.
>> There is 1 reg item for memory controller stream-id registers.
>> So update the reg maxItems to 18 in tegra186 devicetree documentation.
> 
> Some of this needs to be in 'description' for 'reg'.
> 
>>
>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>> ---
>>  .../devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml      | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>> index 13c4c82..eb7ed00 100644
>> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>> @@ -35,7 +35,7 @@ properties:
>>  
>>    reg:
>>      minItems: 1
>> -    maxItems: 3
>> +    maxItems: 18
>>  

...and with "if:" block constraining these on different hardware.


Best regards,
Krzysztof
