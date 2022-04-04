Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D8B4F1F11
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380933AbiDDVtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379332AbiDDRAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 13:00:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F06C1E5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 09:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649091517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xfXVG2LWmlhxvH9mQkRRvHM6oog3iVL1XZEsuBNjm/c=;
        b=FkabnPyzuQY1gBbj5C9GUgZTRhhOwwSb/xionwfjJ1CPRxT+Adn+PmKdir4KF6GlMfXYhd
        BAbKbNkihJ2RjPL5vHzaiMmH+AdAlgAzCMYaup0NgULA0Jht6ccKAA1P/wX3eYCWVAOhwC
        s2zqOBmW4L2c0XAkb6LRmiZ31BPfICs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-171-2QF1NC0nM0aq3MLC5g2CbQ-1; Mon, 04 Apr 2022 12:58:36 -0400
X-MC-Unique: 2QF1NC0nM0aq3MLC5g2CbQ-1
Received: by mail-wr1-f72.google.com with SMTP id u30-20020adfa19e000000b00206153b3cceso728515wru.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 09:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xfXVG2LWmlhxvH9mQkRRvHM6oog3iVL1XZEsuBNjm/c=;
        b=b5RjYM703EaMXmnuYeGWCV7wYmhqTMyPfBjjm5Zvpjy/1HG8C18qPS8tdIqTTUadK6
         Ps9Adx/66D/JIj+nVKxsF4BsNr9S90Hw68nGn6yF2qHWi4qRnrCb+Zwb2df3MXSDXL0i
         yj7hiFHEK/m3WReh8huZawuXspJ/hUs+/EgX1d5XtJE9WovEWxwdKhdVlFn5CjEdBPhl
         27xAtdjSg9Fg5vO17nEHuCeEr4DkhI76hj4Cgrn01xpXCXMwcwYrg1MD0jz9IlUQZlqY
         BAogcB6PSvk29JsZkp4VzP1FDRobhb6rMdwGBViSLuWMnRDeZUmLkmfQXM7wl2edcJYQ
         nNGg==
X-Gm-Message-State: AOAM532XINsAazdbRnVDATphhQzhYb105uqT7WiJPl1N2LD8C5oYbttb
        l1lYWbNUHrbmTvGRhkGy3h+wZHW8x3l8MFHR+bmsbISBEbakrYkuyErLulOpQZTkHThAKPOQP+W
        /H9PEO2YLH2nREa6LNqM9zi/3
X-Received: by 2002:a5d:410c:0:b0:206:b5c:65c7 with SMTP id l12-20020a5d410c000000b002060b5c65c7mr534237wrp.94.1649091514694;
        Mon, 04 Apr 2022 09:58:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKDTMoBjJ4f1T5UNl+SpGUCBQjk0UlUhzCd3D6qnO9zx/TbihX+oajM7/ljMLrCcySTKcPAQ==
X-Received: by 2002:a5d:410c:0:b0:206:b5c:65c7 with SMTP id l12-20020a5d410c000000b002060b5c65c7mr534220wrp.94.1649091514448;
        Mon, 04 Apr 2022 09:58:34 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r14-20020a05600c35ce00b0038c9f469979sm38126wmq.40.2022.04.04.09.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 09:58:33 -0700 (PDT)
Message-ID: <0d296685-0769-d669-b3fd-d5ca26717c64@redhat.com>
Date:   Mon, 4 Apr 2022 18:58:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/4] dt-bindings: display: ssd1307fb: Add entry for SINO
 WEALTH SH1106
Content-Language: en-US
To:     wens@kernel.org
Cc:     Javier Martinez Canillas <javier@dowhile0.org>,
        Maxime Ripard <mripard@kernel.org>,
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
 <92a46ea2-e23e-b7c8-ea5f-35d458ee1b76@redhat.com>
 <CAGb2v66zj4x7zx4ht+6ojjKRxEe+M4bTc_mKRgf8wd_TK+Wf4g@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAGb2v66zj4x7zx4ht+6ojjKRxEe+M4bTc_mKRgf8wd_TK+Wf4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/22 18:11, Chen-Yu Tsai wrote:

[snip]

>>>
>>
>> tl; dr: unfortunately we can't do it due how SPI and I2C report module
>> aliases. Otherwise module auto loading will not work. I wrote a much
>> longer explanation with some details not so long ago:
>>
>> https://patchwork.kernel.org/project/dri-devel/patch/20220209091204.2513437-1-javierm@redhat.com/#24730793
> 
> Right. I think that crossed my mind at some point, but didn't stick.
> Thanks for raising it again. :)
> 
>> BTW, I bought a SSD1306 SPI controller and go it working this weekend.
>>
>> I plan to post the patches once yours land, to avoid in-flight series
>> that may conflict. And what I did is mark the -fb as deprecated, then
>> added "ssd130x-i2c" and "ssd130x-spi" compatibles strings.
>>
>> The WIP patches can be found here in case you are interested:
>>
>> https://github.com/martinezjavier/linux/tree/drm-ssd130x-spi
> 
> I took a quick look and a couple things stood out:
> 
> 1. Would 3-wire SPI ever be considered? If so, might want to
>    rename some of variables/functions as *_spi_4wire_* to
>    begin with.
>

That's a good question and something that I considered too. I have to
admit that never had a SPI device that uses the 3-wire scheme though
so I don't know how common that is.

The ssd1306 datasheet mentions that the chip supports it but I could
not find one to buy. Read that should be able to do it by soldering
some pads in the board but that wold be more hustle that would like.

For that reason I just went with only supporting 4-wire and someone
if really like could provide patches for 3-wire SPI.

> 2. Maybe we should move the ssd130x_deviceinfo stuff into the
>    core module, and define an enum to use for matching compatible
>    strings across the modules to their respective device info
>    entries? FYI we are doing this in drivers/mfd/axp20x* .
> 

Yes, that's a good idea. I'll add that refactoring as a part of the
SPI series. Thanks a lot for the suggestion, it was very useful.

> I think a friend of mine has a SPI based SH1106 module that I
> could borrow and test/work on, but that's a big if.
> 
>

Cool. If it uses 4-wire too then I believe that would mostly work
out-of-the-box if you add a compatible string for it. I didn't
have to do any change in the core ssd103x driver for the ssd1306
SPI to work.

> Regards
> ChenYu
> 

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

