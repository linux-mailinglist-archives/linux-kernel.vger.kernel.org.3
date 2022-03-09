Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8A14D3ADE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 21:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237910AbiCIUPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 15:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236643AbiCIUPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 15:15:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 787D445539
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 12:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646856890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IbuX/KcuT6SLK06TjipzKmC4j8Z46swn7ffrS8FTipc=;
        b=WjtioXeFx0DGsVNcBks1pcxAt2iA5ou4fb5b1u1wWa0UQjY5JbL+jeq7ksrvNHlvseKAML
        rJEAjplc//Rvrp90cYftvTGouD2EpfvXaKiIb0V2IT4dDceYtP0x1oIxBbZFBlCmdicYHZ
        rlCoH0lhF36F/d6voBtCwtXEfHZ9xpI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-96-Gyxw8DB4PRe4kmJPeVkp9A-1; Wed, 09 Mar 2022 15:14:49 -0500
X-MC-Unique: Gyxw8DB4PRe4kmJPeVkp9A-1
Received: by mail-wm1-f72.google.com with SMTP id c126-20020a1c3584000000b00380dee8a62cso1201602wma.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 12:14:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IbuX/KcuT6SLK06TjipzKmC4j8Z46swn7ffrS8FTipc=;
        b=l9lm28mD5bUSTuXg7Btcf3eStK5pt5BO1hOQzzawbD1+HDa/olRrKk0FIkqHCNGNjp
         fs8qdYkpo3G6rQ/yEnvLNUzV2BQr06Da8bNuuDPT9/9QJo5CnwCCEVl3ZiIX3YsVf4T8
         ohR23tEGHI3eNoKuswDLqjqabVuSF9GY0wC3+OMfcXLo0rMdSMNi3YgTrpiDYvpcWFdt
         HCIL929YtHYBaj+FraCbnNaoMagv8Ud13OPTfEu8Yt1ZhDoxcpQsGc1b8tJts8F1WkFX
         KPeu9bVdqnF0BCsYKhpF9RTb38OLup91RN0U3xauycIzlzi6lRzd0XCgwt3ONxeLw4Qp
         BVWw==
X-Gm-Message-State: AOAM531n3oUkTNXmcLvVLCA9wSX93Holj0zum0giIgFyvywmR9IefqHf
        wf7BdC+ajm6y7oFdAic3Yf3vPO15HCoyEdoXkR8/wX6yk/eqNev/gRh2uClKgZbmq7b/o79z1Ld
        oQi4N7FNTSwwl80PDKS8OvFha
X-Received: by 2002:a05:600c:508:b0:389:8dfd:7994 with SMTP id i8-20020a05600c050800b003898dfd7994mr863597wmc.115.1646856887708;
        Wed, 09 Mar 2022 12:14:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyepWTtYPUTkB3MsGPzD36ku1cklArD4cEY/LhV7qmnXuX8mjfZUZo8/4jccrD5xCfv5ZW5kg==
X-Received: by 2002:a05:600c:508:b0:389:8dfd:7994 with SMTP id i8-20020a05600c050800b003898dfd7994mr863576wmc.115.1646856887407;
        Wed, 09 Mar 2022 12:14:47 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c124-20020a1c3582000000b00384d42a9638sm2742260wma.2.2022.03.09.12.13.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 12:14:28 -0800 (PST)
Message-ID: <8770f564-921e-b4e7-5ca4-ad05c46d2baf@redhat.com>
Date:   Wed, 9 Mar 2022 21:13:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 3/6] drm: Add driver for Solomon SSD130x OLED displays
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Lee Jones <lee.jones@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Linux PWM List <linux-pwm@vger.kernel.org>
References: <20220214133710.3278506-1-javierm@redhat.com>
 <20220214133710.3278506-4-javierm@redhat.com>
 <CAMuHMdUuTAsqpx4=WnosfyjLo-t9ryQPQMaE1OeMBk4Ws9DTpQ@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMuHMdUuTAsqpx4=WnosfyjLo-t9ryQPQMaE1OeMBk4Ws9DTpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Geert,

On 3/9/22 21:04, Geert Uytterhoeven wrote:

[snip]

>> +
>> +               /* Last page may be partial */
>> +               if (8 * (i + 1) > ssd130x->height)
>> +                       m = ssd130x->height % 8;
>> +               for (j = x; j < x + width; j++) {
>> +                       u8 data = 0;
>> +
>> +                       for (k = 0; k < m; k++) {
>> +                               u8 byte = buf[(8 * i + k) * line_length + j / 8];
> 
> As buf does not point to (0, 0), the above is not correct if rect.x1 !=
> 0 or rect.y1 != 0.  After fixing that, writing more than one text line
> to the console works, but I still see an issue with updates where the
> rectangle size and/or position are not aligned to 8 pixels horizontally.
> Will do more investigation, and send fixes...
>

Right, I believe this is a consequence of introducing shadow buffers at
some point and not adjusting the logic in this function.

Thanks a lot for tracking down the issues and working on fixes for them!
 -- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

