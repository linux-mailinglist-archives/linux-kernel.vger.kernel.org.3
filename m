Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0794AF4F2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 16:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235643AbiBIPRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 10:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235639AbiBIPRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 10:17:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1222C0613CA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 07:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644419825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JZD9dCqlbkWPQFIsrIeQChrUtyGkYhsH8g7u08/+oBc=;
        b=aiDfb9LSX2OpigVgFbQBkga+Fl1j5JJW1QSsAxd554Sp1wCxKlYf5Qs0PN9H9hkVa4F3Is
        fFMXcsE95+lq+NdVrZ4Xyt97arskmaEHPU4pnIQtqcx11oqVuF7DUqTkAj9ZF7qWUtYoyO
        rbhvrxI3Uf5mlNXdqWhK+e1aUVvj9Io=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-403-Hh2T5j28OjWiRQnHaCynqQ-1; Wed, 09 Feb 2022 10:17:04 -0500
X-MC-Unique: Hh2T5j28OjWiRQnHaCynqQ-1
Received: by mail-wm1-f71.google.com with SMTP id bg23-20020a05600c3c9700b0034bb19dfdc0so229386wmb.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 07:17:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JZD9dCqlbkWPQFIsrIeQChrUtyGkYhsH8g7u08/+oBc=;
        b=UnIgccon9B793Rd1F7eAd37oa34En/VpAoamoka8iKyLMCP7iV3fi4KCWfqoyLSY6B
         o4xgUaMP795CUGFd6aBWOuq96Evlr+gfPMkOQdBIcc/DCafGe/aFIXPkxDRjN8ty/llz
         heK6jBmOHBZgxg+Toc25+/2RCISt631ac5/eVkzo2D3HZFIyA/dVPW76Ebw15WfrblMa
         l9P/QsQ/2YvSYjfh1hKmlkSARQWs1KYa8nQrlUWCGLroG7M8yFB23VntnJqYJWfoihvr
         xygkSeppdRD+4WYCVLBWyxYQjuZr5NPuKtz9S+Zur5sSOlrJJcZbKkMpx5zlEDF4TeYP
         p+lg==
X-Gm-Message-State: AOAM531h12yzSwSlaM4g2yCraLyg/T7VLscZpQaO1+1RggXEEGsbJFS9
        VZvy63K2BdIvUxf+kk7QPwmMuSQ0WxtDdDc5NcVIyuFqtKA9GGX/43NNJV7s5zQcPnPzvDfoQ4J
        r23oTsT5fQ4fImVURqL16QTG1
X-Received: by 2002:a5d:400a:: with SMTP id n10mr2558449wrp.603.1644419823608;
        Wed, 09 Feb 2022 07:17:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzwBI5JHyrlxNbjKeheaShrdmdoiXX+Yt+7r3vslDt7sGcUMaDwOeXIfrlF8TXqbtzjMD2TuQ==
X-Received: by 2002:a5d:400a:: with SMTP id n10mr2558428wrp.603.1644419823415;
        Wed, 09 Feb 2022 07:17:03 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p8sm18149378wrr.16.2022.02.09.07.17.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 07:17:03 -0800 (PST)
Message-ID: <600f0f72-4af8-1c43-33a5-a0b5ef97c3c7@redhat.com>
Date:   Wed, 9 Feb 2022 16:17:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 3/7] drm: Add driver for Solomon SSD130X OLED displays
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sam Ravnborg <sam@ravnborg.org>
References: <20220209090314.2511959-1-javierm@redhat.com>
 <20220209090314.2511959-4-javierm@redhat.com>
 <YgPE8Z7HxU2wv7J/@sirena.org.uk>
 <d1025530-90e1-fbc5-c06b-f62ed83f2f19@redhat.com>
 <YgPOKf1QcOCtTisx@sirena.org.uk>
 <561e1f22-2741-b414-0267-14587d59d5de@redhat.com>
 <YgPX3WZRvnWBuV18@sirena.org.uk>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YgPX3WZRvnWBuV18@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/22 16:03, Mark Brown wrote:
> On Wed, Feb 09, 2022 at 03:50:13PM +0100, Javier Martinez Canillas wrote:

[snip]

> 
>> But I understand why the Device Tree binding and fbdev driver used VBAT
>> since that's what the documentation mentions.
> 
> What is "the documentation" in this context and how is that distinct
> from the datasheet for the display controller?  In general the consumer
> driver should be using the name from the datasheet and the regulator
> itself should get a regulator-name reflecting the name in the schematic.
>

For "documentation" I meant the datasheet that mentions VBAT but I got
what you mean and will also propose a change to the binding to rename
the property to vcc-supply instead to match the pin name in the device.

>>> It is depressingly common to see broken code here, unfortunately
>>> graphics drivers seem like one of the most common offendors.
> 
>> I'll include a patch for the existing DT binding and mark the vbat-supply
>> property as required. Probably we won't be able to change the fbdev driver
>> without causing regressions, and I'm not interested in that driver anyways.
> 
> There should be little danger of causing regressions given that a dummy
> regualtor will be provided when one is missing.

Right, I forgot that a dummy regulator is provided in that case. Perfect.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

