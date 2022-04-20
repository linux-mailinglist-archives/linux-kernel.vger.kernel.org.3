Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0C3508D5A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380589AbiDTQex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380524AbiDTQeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:34:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BCCD43AD1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 09:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650472322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uQi4xpiIAYwU9OKYp0XYlU7Icz7XCZVMarc/hg4eCFA=;
        b=EQrrJCOKpJoxiJYOADk18D5zKfenIsNJzNz12SnGy2OpOtPgDzwhr947ca22JTZluIAj1m
        Ls4MKVc1ED5I0ABRvGAMk+W/XkOTPNq3oHN/2Z9N73f2qKHg2arjFgg+c5JHMqOQyuenGt
        0uT/ytU3I/7taCYieu+1aPadnv27+q4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-352-98B5b5JYMIWV1OLAvFCwRQ-1; Wed, 20 Apr 2022 12:27:42 -0400
X-MC-Unique: 98B5b5JYMIWV1OLAvFCwRQ-1
Received: by mail-wm1-f71.google.com with SMTP id r204-20020a1c44d5000000b0038eaca2b8c9so3158058wma.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 09:27:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uQi4xpiIAYwU9OKYp0XYlU7Icz7XCZVMarc/hg4eCFA=;
        b=T90XTkj4SgUn1bpPrbFcAe0CznArDacgGMMaZW3jL9Jy1H9n6VKxHgYbO1xvPJB7k7
         JscFFDgul0fePpa7pIANmkco1lMQMh5rof8QOFscKFSFfDO1A6qNPMwqlgqavOsZ+w6t
         HMLOK2YYJT1oBSNPS+p4wXNhwS9zUPITIBNYjQpYeOv3IbkGGr6GrnVUYd2uoA4l9141
         tyQWAVyaaU146ZbFU+i2T2sqDrTx612Ge15bMNvAHXQXWgqt+r2ISbR95VfOgbe5Qb54
         v4YdxmAWAX0O4YEUh6LmeYwZI57z6xhxeq35fDq8/g0diQpYV9adMte58jUIAj6j/y4j
         IOMQ==
X-Gm-Message-State: AOAM531tbxu8vTJEBnNHKR3vjeszHgrqtPWnk0MpJfeB+EQy46emEYBb
        f3h2sctwRmSlYY/v/jqmDWeiFufcNYt8SNfJAiwnFRrCiEDq6ecPB+H04e8YEJsC6KMN8XFSLyl
        uHWonpcJMn+9gc0T0oryyNyeJ
X-Received: by 2002:a05:600c:3b28:b0:38e:bb86:d68d with SMTP id m40-20020a05600c3b2800b0038ebb86d68dmr4483029wms.135.1650472061257;
        Wed, 20 Apr 2022 09:27:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynjWWcQttb+aziN8pHptfqs3yGHSuwUSQnhkK4weL+KdnsI1r5xgng775oUvCczEZjZL9Qqg==
X-Received: by 2002:a05:600c:3b28:b0:38e:bb86:d68d with SMTP id m40-20020a05600c3b2800b0038ebb86d68dmr4483014wms.135.1650472061059;
        Wed, 20 Apr 2022 09:27:41 -0700 (PDT)
Received: from [192.168.1.129] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n12-20020a5d588c000000b0020a9e80d2b1sm315363wrf.107.2022.04.20.09.27.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 09:27:40 -0700 (PDT)
Message-ID: <47105042-bd53-98b2-e3e2-0141fb6561f8@redhat.com>
Date:   Wed, 20 Apr 2022 18:27:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v5 1/5] dt-bindings: display: ssd1307fb: Deprecate "-i2c"
 compatible strings
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <20220419214824.335075-1-javierm@redhat.com>
 <20220419214824.335075-2-javierm@redhat.com>
 <YmAxqNb7nKlypkqD@robh.at.kernel.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YmAxqNb7nKlypkqD@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

On 4/20/22 18:15, Rob Herring wrote:
> On Tue, 19 Apr 2022 23:48:19 +0200, Javier Martinez Canillas wrote:
>> The current compatible strings for SSD130x I2C controllers contain both an
>> "fb" and "-i2c" suffixes. It seems to indicate that are for a fbdev driver
>> and also that are for devices that can be accessed over an I2C bus.
>>
>> But a DT is supposed to describe the hardware and not Linux implementation
>> details. So let's deprecate those compatible strings and add new ones that
>> only contain the vendor and device name, without any of these suffixes.
>>
>> These will just describe the device and can be matched by both I2C and SPI
>> DRM drivers. The required properties should still be enforced for old ones.
>>
>> While being there, just drop the "sinowealth,sh1106-i2c" compatible string
>> since that was never present in a released Linux version.
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> Acked-by: Mark Brown <broonie@kernel.org>
>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>>
>> (no changes since v3)
>>
>> Changes in v3:
>> - Drop the "sinowealth,sh1106-i2c", wasn't in a released version (Chen-Yu Tsai)
>> - Continue enforcing required properties for deprecated strings (Maxime Ripard)
>>
>> Changes in v2:
>> - Drop the -i2c suffixes from the compatible strings too (Geert Uytterhoeven)
>>
>>  .../bindings/display/solomon,ssd1307fb.yaml   | 44 +++++++++++++------
>>  1 file changed, 31 insertions(+), 13 deletions(-)
>>
> 
> 
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
> 
> If a tag was not added on purpose, please state why and what changed.
> 

I meant to add your Acked-by but just forget before posting. Sorry about that.

I'll add it myself before pushing.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

