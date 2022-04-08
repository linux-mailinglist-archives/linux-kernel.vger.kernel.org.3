Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9235E4F9DA5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 21:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239230AbiDHT1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 15:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239251AbiDHT1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 15:27:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6EA201FDFF4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 12:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649445927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UGrov/V4uOu3LT5x6dwFAgilRHaV8cu7rkG7AUn9KTY=;
        b=h5cJ5V2Q8G5FWDMZJr6M2jJ59Jrq8M4UHC+cg3Ftpa4GD/yT08sutXH/Pngr52KwIrtKX1
        OF31gA59XEd62zAu8dDG0OYLuQ4PGfjBw9QpfJH59O7Ovm5lDIg+H8aAvAlBN5rF/PHgaI
        QTXm64b2pX00KkmtQbw8UbILJRplhPc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-471-PGtfn4IcNTimw3KdW2hVIQ-1; Fri, 08 Apr 2022 15:25:26 -0400
X-MC-Unique: PGtfn4IcNTimw3KdW2hVIQ-1
Received: by mail-wr1-f69.google.com with SMTP id v3-20020adf8b43000000b00205e463b017so2423749wra.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 12:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=UGrov/V4uOu3LT5x6dwFAgilRHaV8cu7rkG7AUn9KTY=;
        b=79tjx2KcTGcLg7fRot0HbFZHYl6M0gCbAILs/fd3T2+Q7R/EXZ9mickVcW1pEitnq3
         QHVxcbJ2WmoHfMeJESyjLrmnZKR/3mQYOMNLCC/tMneGEaCOGRZmHJ5VH8QDzadeOe2t
         +x4eqAAY/+lfAkqmsdDi+P6fWlN/Q+I+mqWYlUVZAiItO1piWWi4jl4U6VfFGKALzHCe
         ZXUkQNpFVGmqbJcFY0cGxYfWC3oDUCf/CxWi/596jswfv5UO/Ma6Nla51JgoegFDjbr5
         IwS0PwckmSfZW6Anx+K3SvZu4lhlO9T596Jy1KusJNVRH2yesivbEENN3M0itPlHtVfk
         4pAA==
X-Gm-Message-State: AOAM531SWMS6HJkHGTWj5cZ2O68DtOXihwbRRlGTPh0uin1rG0D2vkk+
        SS/Ca3cXPJkKhdccfK+grcbkyOxfhiy/SJ26zfdJ0aVM/loXKEhyVYsMU+mvibnYp06Z/4J/nxq
        lHZc8UnbOyw0lYkEIhfzVpFuI
X-Received: by 2002:a5d:6a0b:0:b0:207:9e23:8b4b with SMTP id m11-20020a5d6a0b000000b002079e238b4bmr45497wru.337.1649445925313;
        Fri, 08 Apr 2022 12:25:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtpxhv4RA2iFT06aQJ6jH2+mBKBrcJL3FNdxAkbV0UH3rboulTNyoMaM+1BcHn/wT4wRNyKg==
X-Received: by 2002:a5d:6a0b:0:b0:207:9e23:8b4b with SMTP id m11-20020a5d6a0b000000b002079e238b4bmr45485wru.337.1649445925090;
        Fri, 08 Apr 2022 12:25:25 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m7-20020adfe0c7000000b002060e7bbe49sm19704733wri.45.2022.04.08.12.25.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 12:25:24 -0700 (PDT)
Message-ID: <dfc438ab-29fd-881d-f019-7223cae60e88@redhat.com>
Date:   Fri, 8 Apr 2022 21:25:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/5] dt-bindings: display: ssd1307fb: Deprecate fbdev
 compatible strings
Content-Language: en-US
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Brown <broonie@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org
References: <20220407200205.28838-1-javierm@redhat.com>
 <20220407200205.28838-2-javierm@redhat.com>
 <YlB9TsbhoQblo1H8@robh.at.kernel.org>
 <ffe5c7d4-d27f-ccb6-932e-e027e1ae14da@redhat.com>
In-Reply-To: <ffe5c7d4-d27f-ccb6-932e-e027e1ae14da@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/22 21:19, Javier Martinez Canillas wrote:

[snip]

>>
>> There's also no reason to put the bus interface into the compatible as 
>> the same compatible will work on different buses. But since you want to 
>> add SPI, just using the 'i2c' one will confuse people. For that reason 
>> you could add 'solomon,ssd1305', etc. for both SPI support and I2C DRM.
> 
> That's not really true. There's a reason to add per bus compatible strings
> at least in Linux. And is that there's no information about the bus types
> in module aliases that are reported to user-space for module auto-loading.
>

Forgot to mention that in this particular case it will work but just because
the SPI subsystem always report a module alias of the form "spi:device" even
for devices that are registered through OF.

So having a single "solomon,ssd1306" would work because for I2C the module
alias will be "of:NoledT(null)Csolomon,ssd1306" and for SPI it will be
"spi:ssd1306".

But if ever the SPI subsystem is fixed to report proper OF module aliases
things will break. And since the DT bindings is an ABI, it's safer to have
"-i2c" and "-spi" compatible strings variants.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

