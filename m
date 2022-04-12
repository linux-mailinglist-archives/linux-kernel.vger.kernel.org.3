Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022DF4FE18D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244247AbiDLNIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357306AbiDLNEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:04:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2AA264CD66
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649767733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7sDaKWcAgM2XIl9bdUk6bun++oBfH1mVBruEjkqdxaY=;
        b=ipGMV5hSB8jh9OpyTwjlW9jWGMI27rDRqiJUh/vM3OtILyrCeuBxSTmSZhkDIt1Qkp9Z3e
        4D79P4FJWJq38lJtGzMLtYdmQsUwyJuWrV8kjSpW/ITQgNKx5/FbM3jyfs9WmWODCBlWen
        HLeeQ2PmE9cDDseX7pcVueqIUo/qI+s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-400-s0_5Kg0pMN-wOAnGn201EQ-1; Tue, 12 Apr 2022 08:48:52 -0400
X-MC-Unique: s0_5Kg0pMN-wOAnGn201EQ-1
Received: by mail-wm1-f70.google.com with SMTP id l19-20020a05600c1d1300b0038e736f98faso5932393wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:48:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7sDaKWcAgM2XIl9bdUk6bun++oBfH1mVBruEjkqdxaY=;
        b=kRD+pCxFPfcaFJXWrlvWi23BOI8TaXBzbWOL02i1aGmKZcYLg7w5yj+Q9VPMiEkA08
         5RG7oQMj3bpeazuARL01426lBgcqbnGI2Byk6rFWrwPXs5kcyYl+LcN63MJde37K3v4t
         /f8YtJ9bQ+63p7wrweyHdR0gcHrDouHXYdh27DLQOfPYyYsEoMArrH6Jc4OZtQzXlupp
         aaKpeLvCdacd5xa8qOj9PDPlmGuT9CH952e+nms9U/m/rLV7x64Oxeyk3DkyFpLvn/a7
         MX6z2D2fSdJPWBPPRYy+F4PQPA06ICsLYXuch78r4i5sbH1OvMVxbQQ/1cVIPEOXvJOU
         cpxg==
X-Gm-Message-State: AOAM5301q5kIGUbbPILIpt7MbYUxevF7q3Ov/eZ+AYc6nT4AUYCwhDjd
        lKmUSiZabEd1PU+z8csDNv00h8zc+DS+jDO2A4gCsRirxHlfu+lhti1hbPkol+EFtYUP6CyqGOQ
        urmsXvdO19cXcMoHB+LuCYlK9
X-Received: by 2002:adf:e74a:0:b0:1f0:25cb:3ad5 with SMTP id c10-20020adfe74a000000b001f025cb3ad5mr29127157wrn.231.1649767731312;
        Tue, 12 Apr 2022 05:48:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5+Ddw+bigt24MEWgaP362cD4jvNRoenFXKs2B/0FJXlJzyo/PVEoLpDt5RoNn56qZNIA2XA==
X-Received: by 2002:adf:e74a:0:b0:1f0:25cb:3ad5 with SMTP id c10-20020adfe74a000000b001f025cb3ad5mr29127143wrn.231.1649767731066;
        Tue, 12 Apr 2022 05:48:51 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id b1-20020adfd1c1000000b002058537af75sm30602485wrd.104.2022.04.12.05.48.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 05:48:50 -0700 (PDT)
Message-ID: <d25cfc04-8ee5-ea6d-a353-6b0ac1fd58be@redhat.com>
Date:   Tue, 12 Apr 2022 14:48:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/5] dt-bindings: display: ssd1307fb: Deprecate "-i2c"
 compatible strings
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
References: <20220411211243.11121-1-javierm@redhat.com>
 <20220411211243.11121-2-javierm@redhat.com>
 <20220412112855.uccrkoqgjim2dbts@houat>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220412112855.uccrkoqgjim2dbts@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Maxime,

On 4/12/22 13:28, Maxime Ripard wrote:
> On Mon, Apr 11, 2022 at 11:12:39PM +0200, Javier Martinez Canillas wrote:

[snip]

>>  
>>    reg:
>>      maxItems: 1
>> @@ -136,7 +147,7 @@ allOf:
>>        properties:
>>          compatible:
>>            contains:
>> -            const: sinowealth,sh1106-i2c
>> +            const: sinowealth,sh1106
> 
> I think we should have both in the condition here, but it looks good
> otherwise.
>

Right, we want to keep enforcing for the deprecated compatible strings.
 
> Maxime
> 

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

