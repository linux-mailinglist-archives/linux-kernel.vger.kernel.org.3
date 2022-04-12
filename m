Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DFA4FD81D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391253AbiDLJ25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358678AbiDLIcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 04:32:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A07D5C65B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649750468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yun2BU4GEvJ6pZF2R1wwCOG8a5Yady7UA0t+GMUdSTY=;
        b=fUpPgD/8rto0XCXD75TcNOumHT/cDF7x7SqA5qVpcA6V6A3l/h8WnZiykpHcYcZnlGZqlj
        gw8UG7t87lMO8FxgZNPrrdVEXzAWvAbIwVUNxO9eUUyiXV22GOGwW8aJ7Hc/vKeqcpdbra
        ByldzWmc6DUJAndMHhp/Po2YfOo+jzA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-145-YVf7wAFwM2e3g7EzCQp4jg-1; Tue, 12 Apr 2022 04:01:06 -0400
X-MC-Unique: YVf7wAFwM2e3g7EzCQp4jg-1
Received: by mail-wm1-f70.google.com with SMTP id h65-20020a1c2144000000b0038e9ce3b29cso945562wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:01:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Yun2BU4GEvJ6pZF2R1wwCOG8a5Yady7UA0t+GMUdSTY=;
        b=poUi32XbKI5pi5uFTZCl633Z25kGl5ZC6mg6IYdctK8g71PB4zo7eZfcsmsNxHJVzI
         qP1iMAFDHkI05m1KgjDYenEqrIEWtDmycH9qsPKKyrs3ix3pGOKdfALw/V714vvNk+Hp
         c12trJ8J4py1Qx0YotDcLr1zQeexC1tNPX0kpJDhaUUEU3cJJfg7j30w0qCGf+Lo+GkO
         bRiBg+1rGI54wFWNJITu+1kjFRSwsrUEnr4moxBOMrK6PfpXdypIU1pfs05vCXICzzKI
         p7jM1DlFMa/hx/464X3wPLq/kyUOQJ/EDP8P7OoL3x0IlIZ1MM47eqa6I8kjpf8KfugH
         IVMA==
X-Gm-Message-State: AOAM531Xq0mvsVVxRJoxtcATP8+x8YxMzGCFt9tAddkz+RvEEPbpvzvV
        +lXsgD4E7TjL3v9JFLlX4DQ7iUQwUhV05VKlvoE9gI09p2mwQ2GV2+z5Qr2sE7fv9CEpLuu66pN
        G5pQABylTWEHFW6bBxEgokVX0
X-Received: by 2002:a7b:c013:0:b0:38e:9edd:a44c with SMTP id c19-20020a7bc013000000b0038e9edda44cmr2843809wmb.122.1649750465615;
        Tue, 12 Apr 2022 01:01:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4xyJVcMPwaSHo28mAGHjTf3te+mbmf7aS3NcBbvG5DwIb2JGi3dRKgJeBadFNt9Ppg1fEeg==
X-Received: by 2002:a7b:c013:0:b0:38e:9edd:a44c with SMTP id c19-20020a7bc013000000b0038e9edda44cmr2843777wmb.122.1649750465293;
        Tue, 12 Apr 2022 01:01:05 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l2-20020a05600c4f0200b0038e8fb63293sm1694298wmq.22.2022.04.12.01.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 01:01:04 -0700 (PDT)
Message-ID: <d37de4b1-55f7-ff4d-6230-6f0b6e65799c@redhat.com>
Date:   Tue, 12 Apr 2022 10:01:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/5] dt-bindings: display: ssd1307fb: Extend schema for
 SPI controllers
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20220411211243.11121-1-javierm@redhat.com>
 <20220411211243.11121-3-javierm@redhat.com>
 <CAMuHMdVuivPSRooR5CqTX6GQtxO6RQYwKUqfOK36zsiN8-v6kg@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMuHMdVuivPSRooR5CqTX6GQtxO6RQYwKUqfOK36zsiN8-v6kg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On 4/12/22 09:16, Geert Uytterhoeven wrote:
> Hi Javier,
> 
> On Mon, Apr 11, 2022 at 11:12 PM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> The Solomon SSD130x OLED displays can either have an I2C or SPI interface,
>> add to the schema the properties and examples for OLED devices under SPI.
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> Acked-by: Mark Brown <broonie@kernel.org>
>> ---
>>
>> Changes in v2:
>> - Don't add compatible strings with an "-spi" suffix (Geert Uytterhoeven).
> 
> Thanks for the update!
>

You are welcome and thanks for your prompt review and feedback!
 
>> --- a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
>> +++ b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
>> @@ -39,9 +39,14 @@ properties:
>>    reset-gpios:
>>      maxItems: 1
>>
>> +  dc-gpios:
>> +    maxItems: 1
>> +
> 
> Perhaps add a description, and clarify this is for SPI only?
> 

I wondered how to make it required for SPI but couldn't find another binding
that did the same and I'm not that familiar with DT schemas to figure it out.

Before, when I had compatible strings just for SPI I could do the following:

  - if:
      properties:
        compatible:
          contains:
            enum:
              - sinowealth,sh1106-spi
              - solomon,ssd1305-spi
              - solomon,ssd1306-spi
              - solomon,ssd1307-spi
              - solomon,ssd1309-spi
    then:
      required:
        - spi-max-frequency
        - dc-gpios

but now that we are using the same compatible strings for I2C and SPI, the
compatible string can't be used anymore as an indication to make required.

Do you have any hints here on how I should enforce this in the schema ?

Or if you think that a comment is enough, then I will add it in v3.

> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>

Thanks!

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

