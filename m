Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7BF4FBF8D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347481AbiDKOuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347475AbiDKOuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:50:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FB25220DC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649688509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=23gHevVrroOIYzFgSputvPyAa/4Ktzn0dvOFX/eCoLE=;
        b=IP+gNK1KMRc73LYuC49haEHu+Vcn2Dr5mssDbV/EomJ76ovL5Lbxtl2q5c4mgB6muqrawr
        /fRjDpQScG5OXRgiqqgR7J0jqrIhYVLpKFPJsLmMWQ5l0N6JW62XcBO0wFVsb6FEnO/aea
        8reP/2a6OH67PzWwyMVvQPqtLCjIqOg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-509-NqdAAj7tPIKfYfCLuhp7Zw-1; Mon, 11 Apr 2022 10:48:27 -0400
X-MC-Unique: NqdAAj7tPIKfYfCLuhp7Zw-1
Received: by mail-wm1-f69.google.com with SMTP id g13-20020a1c4e0d000000b0038eba16aa46so2226971wmh.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:48:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=23gHevVrroOIYzFgSputvPyAa/4Ktzn0dvOFX/eCoLE=;
        b=Zw5E+AEK0S33MymO11ls0pnHXpA32dMO5JwuqQ/jjni4ahPru334rPGf/d5FYew/PZ
         c6jT93D5zNPQ5+KVFUqeETuBYxLVQRkEwB28bvYjK3xbCTyfwsLzBvH9QVl2+GzHo5jq
         qeAQ1y92JstsWICULQ9FFXc3N8L85wXPKLwJ4isAqtYy21t2RVga+ZBHBQeeYnkV9vw9
         ctMRvCafJIVLC1ISwdoy/24Gd4K0kq6DEJCvyWf1LZkj+mdk2uz62yEafuBEh+IoEff9
         Gb9bjPyND56G2kF1smOuhWC9cWPIb9MQIA6f6tusPvCPyvOAMAyY6BRUIfx4CD+9Omh0
         q9dQ==
X-Gm-Message-State: AOAM533gzpIggZfBV2sUcthn3U3/M3ptopCFLthq5Az/SN/M77H13hJI
        0VRrr3WlIRY7SUiaIHubo0NgLWq1u/u+nFImp/GtpfYSO9ErCrucwcsw10/qtuIVL6rEr+d/0zd
        xX5FVCf7IprJxwqQ4ZaJB2ZM+
X-Received: by 2002:a05:600c:25cd:b0:38e:715e:d9b6 with SMTP id 13-20020a05600c25cd00b0038e715ed9b6mr29405423wml.63.1649688506632;
        Mon, 11 Apr 2022 07:48:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxulV+PmBoci9B8dGS1eRwND5+wEOgNayliPAYXAVTwZj2JV3nKrI1I662hg1YD8X6EMDanug==
X-Received: by 2002:a05:600c:25cd:b0:38e:715e:d9b6 with SMTP id 13-20020a05600c25cd00b0038e715ed9b6mr29405403wml.63.1649688506398;
        Mon, 11 Apr 2022 07:48:26 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id s1-20020adfb781000000b002060d4a8bd9sm22107168wre.17.2022.04.11.07.48.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 07:48:25 -0700 (PDT)
Message-ID: <a422b984-6d2a-a307-7b4d-a4fec08e87c2@redhat.com>
Date:   Mon, 11 Apr 2022 16:48:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/5] dt-bindings: display: ssd1307fb: Deprecate fbdev
 compatible strings
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20220407200205.28838-1-javierm@redhat.com>
 <20220407200205.28838-2-javierm@redhat.com>
 <CAMuHMdUGQ6qabs_xD6kQeDruQLG-OX17UEVrgeGu3Eo6C2dEgw@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMuHMdUGQ6qabs_xD6kQeDruQLG-OX17UEVrgeGu3Eo6C2dEgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Geert,

On 4/11/22 15:47, Geert Uytterhoeven wrote:
> Hi Javier,
> 
> On Thu, Apr 7, 2022 at 10:03 PM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> The current compatible strings for SSD130x I2C controllers contain an -fb
>> suffix, this seems to indicate that are for a fbdev driver. But the DT is
>> supposed to describe the hardware and not Linux implementation details.
>>
>> Let's deprecate those compatible strings and add a new enum that contains
>> compatible strings that don't have a -fb suffix. These will be matched by
>> the ssd130x-i2c DRM driver.
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
>> --- a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
>> +++ b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
>> @@ -12,12 +12,24 @@ maintainers:
>>
>>  properties:
>>    compatible:
>> -    enum:
>> -      - sinowealth,sh1106-i2c
>> -      - solomon,ssd1305fb-i2c
>> -      - solomon,ssd1306fb-i2c
>> -      - solomon,ssd1307fb-i2c
>> -      - solomon,ssd1309fb-i2c
>> +    oneOf:
>> +      # Deprecated compatible strings
>> +      - items:
>> +          - enum:
>> +              - solomon,ssd1305fb-i2c
>> +              - solomon,ssd1306fb-i2c
>> +              - solomon,ssd1307fb-i2c
>> +              - solomon,ssd1309fb-i2c
> 
> Please drop the "-i2c" suffixes, too.
> We already have plenty of IIO sensors and audio codecs using the
> same compatible value for spi and i2c, cfr.
> 'git grep compatible -- "*-[si][p2][ic].c"'
>

Yes, I know but was worried about the potential issues that mentioned in a
previous email in this thread. But after the discussion we had over IRC, I
think that is safe to assume that the SPI subsystem won't change how the
modaliases are reported, so there won't be conflict between I2C and SPI.

And if that is ever changed, there's a plan to add the bus type to the data
reported by the modalias uevent so user-space could figure out what to load.

So I'll go ahead with Rob and yours suggestion, and just deprecate the old
ones and drop both the "fb" and "-i2c" part of the compatible strings, to
use the same compatible strings for both the I2C and SPI drivers.

After all, that's the correct way to describe the hardware and not encode
any Linux implementation details in the DT binding.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

