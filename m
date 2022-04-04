Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE594F18D2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 17:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378680AbiDDPuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 11:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378663AbiDDPuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 11:50:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D096A60E7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 08:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649087298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ACaAB1t0vMWb3pX2ELgBqL+jg9CnsBzljXi5Wr6J60o=;
        b=ahQIZJveoaR+Y6dsDE5k2DBuix4glwxgmWuUbkU0t6K4znyfEdZbQU0DnSa5F71Xd5sait
        JYdGNQBlf25YwkWQPb2M6fY5lX/sqaQucXMv7nxKHSdttWiCSza4IweLIWkf7wOz7rCqeN
        W5yW13uy+n5yMyAAHFYJZPiq4Sals0o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-yjwlPog5NYGEaFUPCdV_gg-1; Mon, 04 Apr 2022 11:48:17 -0400
X-MC-Unique: yjwlPog5NYGEaFUPCdV_gg-1
Received: by mail-wr1-f70.google.com with SMTP id e4-20020adfa444000000b002060b7347f8so986263wra.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 08:48:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ACaAB1t0vMWb3pX2ELgBqL+jg9CnsBzljXi5Wr6J60o=;
        b=PiIxbbsfc6Ikq9gaOCcYpL/TFewqWJOjQNJVje0NwfaU+t0GRIlSru/DN63L8MjfP5
         WzzMSEhfw17jmbywLFK/fU9SLcxRdG8gx9rQgC6b5t++OinhSW0cmSEWEiIixyrXlO7t
         FMdKMjTKTWMAKFaWLFSgvYk9zJzaeHFJNM8A45pZwdqo7jnVUCBMcKBkCwAXeZn8In8Z
         6/YWsSfNLqvq6tzAZusOFrXTdeCEZtiZDyqoAZnSv3Ndvr8k9FtBOH7rvUzKQwhOXRhK
         zx5xa+wq4KK0zqXIAvjvQO+GvBL7wCMK65arwI1kNvKyjA28D0YtOj4RzIKJc8xvx/QF
         6zSg==
X-Gm-Message-State: AOAM531YEoS+4MKpukkimLug+mGlNz6dIU+YUNjuEh8xMbFzp7t201IB
        Phwl005QYLQNKYRKm8GwazCTWuCBGPMe07busjOj3Ri6QWD2ZcrexlTZajekb/uO66BSXs4O/0e
        Cl0rz8VyXswbbuyh2Z2QOtKrF
X-Received: by 2002:adf:f188:0:b0:206:e20:1b65 with SMTP id h8-20020adff188000000b002060e201b65mr259493wro.363.1649087296377;
        Mon, 04 Apr 2022 08:48:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+jBXSnytEUbHzPD7PrJYBhDtVRIkCeBYl9hIqrrHNXMn+EkEqSV4Kzkt4zlwuYyU9ugLZaA==
X-Received: by 2002:adf:f188:0:b0:206:e20:1b65 with SMTP id h8-20020adff188000000b002060e201b65mr259479wro.363.1649087296112;
        Mon, 04 Apr 2022 08:48:16 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v14-20020a7bcb4e000000b0034492fa24c6sm9737099wmj.34.2022.04.04.08.48.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 08:48:15 -0700 (PDT)
Message-ID: <92a46ea2-e23e-b7c8-ea5f-35d458ee1b76@redhat.com>
Date:   Mon, 4 Apr 2022 17:48:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/4] dt-bindings: display: ssd1307fb: Add entry for SINO
 WEALTH SH1106
Content-Language: en-US
To:     wens@kernel.org, Javier Martinez Canillas <javier@dowhile0.org>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <20220330190846.13997-1-wens@kernel.org>
 <20220330190846.13997-3-wens@kernel.org>
 <CABxcv==csvqsxM46ce2LecDh4E-UxxD2DG+3E-hCFoyrdtRv7A@mail.gmail.com>
 <CAGb2v64VQPjan=EUkd8UhRZfV0g1GqBwPqhxQakS=7YhgvVDQA@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAGb2v64VQPjan=EUkd8UhRZfV0g1GqBwPqhxQakS=7YhgvVDQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chen-Yu,

On 4/4/22 17:06, Chen-Yu Tsai wrote:

[snip]

>>>      enum:
>>> +      - sinowealth,sh1106-i2c
>>
>> I like that you didn't include a "fb" suffix for this, the existing
>> ones are cargo culting from the previous fbdev driver to make existing
>> DTBs compatible with the DRM driver.
>>
>> I've been thinking if I should post a patch to compatible strings
>> without the "fb" and mark the current ones as deprecated...
>>
>> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> I also thought about dropping the "-i2c" suffix, but then thought
> there might be a case where someone wanted to search the device
> tree specifically for an I2C connected node using said compatible
> string.
> 
> What do you think?
> 
>

tl; dr: unfortunately we can't do it due how SPI and I2C report module
aliases. Otherwise module auto loading will not work. I wrote a much
longer explanation with some details not so long ago:

https://patchwork.kernel.org/project/dri-devel/patch/20220209091204.2513437-1-javierm@redhat.com/#24730793

BTW, I bought a SSD1306 SPI controller and go it working this weekend.

I plan to post the patches once yours land, to avoid in-flight series
that may conflict. And what I did is mark the -fb as deprecated, then
added "ssd130x-i2c" and "ssd130x-spi" compatibles strings.

The WIP patches can be found here in case you are interested:

https://github.com/martinezjavier/linux/tree/drm-ssd130x-spi

> ChenYu
> 

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

