Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C3E4D2ED7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 13:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbiCIMPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 07:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiCIMP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 07:15:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D23CCA312
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 04:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646828069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Kl3CbAiIPf88g8wafhD6r4bIq/M8sPBvoSh/EABNic=;
        b=ifIXb1CxpAHM/v6TIiVgzqAzW6q99B3G0fyHOJ0llFT8IJbimoJ4zP+T2iiOknzsSXFczf
        b/1cPzwQLTVH3xi0sfG3PqC0U2lCljsorf6uZ5efRhVpi7OJVFEJxn0eU1GrOsO4m03GNw
        EA7txhwfdnwBjJ3bYxNwWeYvnQvkdGM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-148-ms-FKMVfNhijyTAZXwktyA-1; Wed, 09 Mar 2022 07:14:28 -0500
X-MC-Unique: ms-FKMVfNhijyTAZXwktyA-1
Received: by mail-wm1-f70.google.com with SMTP id 20-20020a05600c231400b00389886f6b23so890179wmo.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 04:14:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8Kl3CbAiIPf88g8wafhD6r4bIq/M8sPBvoSh/EABNic=;
        b=ko3KykIamA7wYDzck+qtSeXNH5NV/LCJ83kly9IqW7LyQE6z9OYAyLgz4ABQsOI4hn
         AC5Df2p+NUb/9IhxT4zx688RhnyUkWKRBiVlWk/FZw0dOhW2R19typ+tfnO6vx7VSG0Q
         KdlBzAlUj57NHxdY1YKhYl9aPcOjaKFAeqHDhojadgLF0YtNeb37dXJXlAM21JRNYTR2
         921ohc93GC6njNqU87QVV/WdmQxbmvRQyRru3lltjgC24VBxeV0wIVNoZrpcpAIybLIX
         xVmUmYFI9esl3P9K+X52doHzmhIhpVxYyKSVcCU7KxqFBKwXOdZ45lBwNohM+17GQAGr
         pdgQ==
X-Gm-Message-State: AOAM530zdb3CmtZta4gxGWgEYHN6XKgFtn1JcZ1Vo2n/Kun6cBq7MAUZ
        6HC70grcQIt7wXRVnCVf9aOvyzpWt+3WzcwqQJRvlq4X3EANd43hz2XI9XoT5iLVE+mlEUhDxLt
        2M3lZXzO89immS1ejYTM2txti
X-Received: by 2002:a5d:648c:0:b0:1ed:b04d:300 with SMTP id o12-20020a5d648c000000b001edb04d0300mr13166106wri.347.1646828066930;
        Wed, 09 Mar 2022 04:14:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx3UMGGyzhv+uJG0YcGPT0R4FgUq8Duwca8TEkpNAynB28fPmXTqBLd6qfLu7hu31ClWemckA==
X-Received: by 2002:a5d:648c:0:b0:1ed:b04d:300 with SMTP id o12-20020a5d648c000000b001edb04d0300mr13166094wri.347.1646828066722;
        Wed, 09 Mar 2022 04:14:26 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m185-20020a1c26c2000000b003899ed333ffsm4684434wmm.47.2022.03.09.04.14.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 04:14:17 -0800 (PST)
Message-ID: <fd6ec463-f46d-0813-5d87-a00c07739e01@redhat.com>
Date:   Wed, 9 Mar 2022 13:14:13 +0100
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
 <CAMuHMdU+29x4ZHLAiPiReyLKw_VYBCCLw0bCoQmw9s6sQ4Bxcw@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMuHMdU+29x4ZHLAiPiReyLKw_VYBCCLw0bCoQmw9s6sQ4Bxcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 3/8/22 17:30, Geert Uytterhoeven wrote:
> Hi Javier,
> 
> On Mon, Feb 14, 2022 at 2:37 PM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> This adds a DRM driver for SSD1305, SSD1306, SSD1307 and SSD1309 Solomon
>> OLED display controllers.
>>
>> It's only the core part of the driver and a bus specific driver is needed
>> for each transport interface supported by the display controllers.
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> Thanks for your patch, which is now commit a61732e808672cfa ("drm:
> Add driver for Solomon SSD130x OLED displays") in drm/drm-next
> 
> Sorry for the delay, but finally I gave it a try on my Adafruit
> FeatherWing 128x32 OLED.
> Some of the weird issues (cursor disappears after printing some text,
> more text also doesn't appear until I clear the display) are still there.

I see. Thought that I tested using it as a console and it did work
correctly for me. I'll do more tests again.

> Unfortunately a regression was introduced since your v3: printed
> text is mirrored upside-down. I.e. "E" is rendered correctly, but "L"
> turns into "Γ" (Greek Gamma).
> I suspect something went wrong with the display initialization
> sequence.
>

Could you please try Chen-Yu's fix for the COM scan direction mask ?

https://lists.freedesktop.org/archives/dri-devel/2022-March/345915.html

I made a mistake when converting to use the GENMASK() and FIELD_PREP()
macros in v4 as suggested by Andy. The SSD130X_SET_COM_SCAN_DIR_MASK
wasn't correct which would explain the output to be vertically flipped.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

