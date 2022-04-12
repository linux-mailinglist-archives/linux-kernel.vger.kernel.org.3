Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9AB4FD7EA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239493AbiDLJat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384691AbiDLImO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 04:42:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84A8A517D7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649750875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c1YyOBaSlUAB1FecJdXpHWi3Q4lLTndl19zr2Spu2No=;
        b=eRdoo+y+hlBPwFuOePOY7KPDNS1muoytKvzxkWfK3R+LLM9GNbUhr/TaIqCa0/fjr91+s+
        IZwFYrPEYnlT7XQ6H3y9Mdz5YXJG121ksTRaW9B/Jg4QxR0Zy0BRC286pCmzM4G8s7Iq+q
        fGzb76fKUWw4XEoCon+tcgy2e5QoKds=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-vaoLSJYSN02V-7011k6g5g-1; Tue, 12 Apr 2022 04:07:54 -0400
X-MC-Unique: vaoLSJYSN02V-7011k6g5g-1
Received: by mail-wm1-f69.google.com with SMTP id i184-20020a1c3bc1000000b0038e4c5968b5so964379wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=c1YyOBaSlUAB1FecJdXpHWi3Q4lLTndl19zr2Spu2No=;
        b=SVUxcCBBfaewcQy3ThoU7N6xBKZTCkIVJj6PvI6cYRmYE3dkvSRck9Jrmh5Wt7p2Z7
         56/W3mQNxFCDCBicGaLlJLiVm0fxR4G0o6kIl5nwBZ2c8wWU8vZMCUF9cQdgRqPt3l7n
         uxfSPcxSnMK39tVIg88j1Ev+wxKIpTW++0RUPRV94vGaPCpaXk6VPygqoT0AuYJFqHva
         /C6aBM5QzCGGsoYE2OUKBvT/lgFGkH6hVWm8VYudJb0IKV8R6Q17w8MxN6J2W+sqbM6+
         O9m9PtR32bLu6cnhBqDFdOXiPf729DTV8PnZ0u3kMl7R22xFPjQlNSaws69gW0XVeMFt
         vM9A==
X-Gm-Message-State: AOAM530KO+Q0rAS5zK34ZUaRw3xs4u5L4mcvgk2PcZVD+/nYi/bYLaLc
        1iGcXgL6L5AApcXxQl3XGc2shHEUv9S/LBzXjm1Ez+6YXeiMFxc8eGg2KrOGtXWSSUAnbWGys1a
        itn4k5sdJoVkHE+5nAqj3+5Aj
X-Received: by 2002:a05:600c:3487:b0:38c:9a42:4d49 with SMTP id a7-20020a05600c348700b0038c9a424d49mr2952294wmq.29.1649750872749;
        Tue, 12 Apr 2022 01:07:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDglW+gKXgj96dHt92B2SeHkQs0c4KFSOD9iFaRTxgb+0c2t9/xh8a8ox8ht2X97EXHVi9og==
X-Received: by 2002:a05:600c:3487:b0:38c:9a42:4d49 with SMTP id a7-20020a05600c348700b0038c9a424d49mr2952269wmq.29.1649750872365;
        Tue, 12 Apr 2022 01:07:52 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z5-20020a05600c0a0500b0037fa93193a8sm1922805wmp.44.2022.04.12.01.07.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 01:07:51 -0700 (PDT)
Message-ID: <6be74110-a65b-7b77-ceac-9da640964ba0@redhat.com>
Date:   Tue, 12 Apr 2022 10:07:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 5/5] drm/solomon: Add SSD130x OLED displays SPI support
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chen-Yu Tsai <wens@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <maxime@cerno.tech>,
        YueHaibing <yuehaibing@huawei.com>
References: <20220411211243.11121-1-javierm@redhat.com>
 <20220411211243.11121-6-javierm@redhat.com>
 <CAMuHMdWsmtBdcV=LL4yqprtbum4f9cSu8orjoPACECa5QENmsg@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMuHMdWsmtBdcV=LL4yqprtbum4f9cSu8orjoPACECa5QENmsg@mail.gmail.com>
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

On 4/12/22 09:31, Geert Uytterhoeven wrote:

[snip]

>> +
>> +       t->spi = spi;
>> +
>> +       t->dc = ssd130x_spi_get_dc(&spi->dev);
>> +       if (IS_ERR(t->dc))
>> +               return PTR_ERR(t->dc);
> 
> This can be simplified (no need for the PTR_ERR(ERR_PTR(...) dance)
> by open-coding ssd130x_spi_get_dc() here.
>

Right, that will be better indeed.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

