Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863E54FBE74
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347001AbiDKOP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbiDKOPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:15:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4ECF32068
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649686419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0SNHqyoujE1GhBLe1zLEQWUOV0WCvLfbwgxIMJwWNvQ=;
        b=QrQNfVUiiT84RBbUzp2UlM0cZMJWVYi6QDxzh8NOWffWx+dKQ0avqor1oFULW21/kgyyDH
        ksswtFffDdpjwcuV/nQfccInglRPT1iCKz2+cjyh8B8gfW0RIiZ36KGzmJqJVbW7jLUyea
        f0FuP5vH3u/vaZjVHF7sSVniKvPRztc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-OfKBIF1ROASMFS3oImhQVA-1; Mon, 11 Apr 2022 10:13:38 -0400
X-MC-Unique: OfKBIF1ROASMFS3oImhQVA-1
Received: by mail-wr1-f69.google.com with SMTP id s8-20020adfc548000000b00207a28e0583so883737wrf.23
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0SNHqyoujE1GhBLe1zLEQWUOV0WCvLfbwgxIMJwWNvQ=;
        b=pHewt4SyMHVyEHQB4kCpHXvQgs0QssHvvuiWB+ua7RQbFOGI0j5fLMyRTY4uRJEVdI
         qGE0sSaIjVRf6DsWzsT8LBAo6HycQaTML4Y0S/EnBbHfbutLStVZIFnIwHBOfHV36hhe
         EnSrYFg2m2iQuGjOScIQsdZaYqq5stcGtmUkThj3t0cpBHKTXvU1LhVIM1+YQYfa8zLc
         xfVDe89Bi2Gha4r5YsHD8jNq8Q05At4lpSFlCpW8Z4rCI9Kas7oCjHAyYJ6MoCDvzCba
         Ddh7z6FYwkBTxF3XVvaasW0J0/gX8wg1wzwmkruw5WIXnubGcfCE3Pr8mefHtYUna5VX
         nKsw==
X-Gm-Message-State: AOAM531E/PD+k924k0GqVDKOYoSJ4jsZNW3xBCUI48W+Ry5E6TgpGvQl
        mHtc41GJjFLOC2tofx4rT29rulX8sZgtTwga37SkMLCT8DioYmPOjsQjOjCdnbATN4GcjHLrZcN
        r5wFTsGgbl0sbdxK+X81enudd
X-Received: by 2002:a1c:721a:0:b0:38e:c24d:7b8d with SMTP id n26-20020a1c721a000000b0038ec24d7b8dmr1682798wmc.83.1649686416942;
        Mon, 11 Apr 2022 07:13:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypN8mGgqi50Hob/p+VhbodRxqFTy9Fb8P7XpksOj9p2Bu5RgSHmeLyVffabHvq+u9lP8hzqA==
X-Received: by 2002:a1c:721a:0:b0:38e:c24d:7b8d with SMTP id n26-20020a1c721a000000b0038ec24d7b8dmr1682771wmc.83.1649686416724;
        Mon, 11 Apr 2022 07:13:36 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q17-20020adff951000000b00205c1b97ac4sm26117938wrr.20.2022.04.11.07.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 07:13:36 -0700 (PDT)
Message-ID: <5c00d6cf-ab0c-850b-821c-36413d894773@redhat.com>
Date:   Mon, 11 Apr 2022 16:13:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/4] dt-bindings: display: ssd1307fb: Add entry for
 SINO WEALTH SH1106
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Chen-Yu Tsai <wens@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220406172956.3953-1-wens@kernel.org>
 <20220406172956.3953-3-wens@kernel.org>
 <CAMuHMdUMc35MrWwbDXvsRNx9qSRf1bACNrhsGpeFcLCETsL4dw@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMuHMdUMc35MrWwbDXvsRNx9qSRf1bACNrhsGpeFcLCETsL4dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Geert,

On 4/11/22 15:35, Geert Uytterhoeven wrote:
> Hi Chen-Yu,

[snip]

>> --- a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
>> +++ b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
>> @@ -13,6 +13,7 @@ maintainers:
>>  properties:
>>    compatible:
>>      enum:
>> +      - sinowealth,sh1106-i2c
> 
> Please don't introduce new compatible values including the bus type.
> There is no need for that, and this will only lead to more deprecated
> compatible values soon...
> 
> Oops, this is already commit 97a40c23cda5d64a ("dt-bindings:
> display: ssd1307fb: Add entry for SINO WEALTH SH1106") in
> drm-misc/for-linux-next...
> 

Yeah, too late :/ I didn't think it would be controversial at the time.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

