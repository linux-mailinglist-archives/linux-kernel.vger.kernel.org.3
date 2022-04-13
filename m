Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D0D4FF40F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbiDMJrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbiDMJrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:47:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DA0C3BBE7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649843079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=foBzhikXuCLjtC6Ari8RZkx+1wS4aS+fCUlhb35KDqw=;
        b=gZpluGCWJZK3LHHwsiFT9cwJwhTeZscyEoEWO52Kt64QV15jUtVqSfrphi2GbaWyPLeU0E
        jx1Ent/KoGGqJMlTKDsztsu6C/podWLih8LST3T3sTm+txpGrhVBRcup7x3wPTNvR8OBhs
        NKBSid9zbHCgjG7h8fW+tUm0OzuOfLs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-209--xIIS360PYa_FsWy7V197A-1; Wed, 13 Apr 2022 05:44:37 -0400
X-MC-Unique: -xIIS360PYa_FsWy7V197A-1
Received: by mail-wm1-f72.google.com with SMTP id n17-20020a05600c501100b0038e731cf5e1so616818wmr.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=foBzhikXuCLjtC6Ari8RZkx+1wS4aS+fCUlhb35KDqw=;
        b=SKLFHScVD7kbq+vmFCyvpuOFjjnPZ6lvFhbsXjVjNYSJIEHhKUKD1gUXnF5EyxY30i
         U65quEitjlA2AcQZO638/X6j0jyC5VSJulIl0WGg/Hke1jhm/hJ0v1PAJL8sWlsHvKVr
         6JPsZ62dAwMtBqmsVT7nDrdAxZQuN3wiwew5F5SvCZJUvKBHMIcy5kOhCfQwimYEwHRR
         JPK7NpQqXMjyShBBLfE340Ad9nuEDHtxBOApJaAvHus2I7ayEPr1WdyMKOqVAeio0tHj
         lD+vHLwds7qjuhAsmlBFOvsV3ONXGClr8smQt+8nui25hBR0JHixyHO3MC0lnD5hRXyi
         Zs+A==
X-Gm-Message-State: AOAM530UW2c6q39naCk7vTQ7tqEzHQdxhwlhdG8+Rye5oDdq21BZin7v
        bSmV75xyN8Smq0QcPnmNIqscfxqAu/WAw1hj2yku1AgTdSlTeb1NyZlLTqlCevAio/NErMObJxJ
        ixihPujdQoyhWisKTbtNPkujV
X-Received: by 2002:a05:600c:3ca4:b0:38e:54d0:406d with SMTP id bg36-20020a05600c3ca400b0038e54d0406dmr7706533wmb.199.1649843076509;
        Wed, 13 Apr 2022 02:44:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0HXRzJbUNXpEFfAtNGvrG9B9JzK/eHK2ZSXSccHuCPbF3oaO1WosnYsBkWkBzF47eXcT4NQ==
X-Received: by 2002:a05:600c:3ca4:b0:38e:54d0:406d with SMTP id bg36-20020a05600c3ca400b0038e54d0406dmr7706513wmb.199.1649843076247;
        Wed, 13 Apr 2022 02:44:36 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o10-20020a5d47ca000000b00203fb25165esm37150569wrc.6.2022.04.13.02.44.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 02:44:35 -0700 (PDT)
Message-ID: <ddf107c7-5108-f366-45a8-e7244cdcd209@redhat.com>
Date:   Wed, 13 Apr 2022 11:44:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 2/5] dt-bindings: display: ssd1307fb: Extend schema for
 SPI controllers
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Mark Brown <broonie@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20220412162729.184783-1-javierm@redhat.com>
 <20220412162729.184783-3-javierm@redhat.com>
 <CAMuHMdUDxexqsGjb3B37jW_xZU1TBLq8gK5hctA+PKjL+LhQGQ@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMuHMdUDxexqsGjb3B37jW_xZU1TBLq8gK5hctA+PKjL+LhQGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Geert,

On 4/13/22 10:04, Geert Uytterhoeven wrote:
> Hi Javier,
> 
> On Tue, Apr 12, 2022 at 6:27 PM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> The Solomon SSD130x OLED displays can either have an I2C or SPI interface,
>> add to the schema the properties and examples for OLED devices under SPI.
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> Acked-by: Mark Brown <broonie@kernel.org>
>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>>
>> Changes in v3:
>> - Add a comment to the properties required for SPI (Geert Uytterhoeven)
> 
> Thanks for the update!
> 
>> --- a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
>> +++ b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
>> @@ -38,9 +38,16 @@ properties:
>>    reset-gpios:
>>      maxItems: 1
>>
>> +  # Only required for SPI
>> +  dc-gpios:
>> +    maxItems: 1
> 
> Actually I meant to also add a description, like for vbat-supply below,
> to explain the meaning of "dc".
>

Ahh, sorry for misunderstanding you! Something like the following looks good ?

  # Only required for SPI
  dc-gpios:
    description:
      GPIO connected to the controller's D/C# (Data/Command) pin,
      that is needed for 4-wire SPI to tell the controller if the
      data sent is for a command register or the display data RAM
    maxItems: 1

If you agree with that, then can squash before pushing or add it to a v4
if another revision is needed.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

