Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2DC4AF46B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 15:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235233AbiBIOuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 09:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235232AbiBIOuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 09:50:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7BE87C061355
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 06:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644418218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GCdwEoIBITb866ZII/MklMSrfR+LqGATKN4cy7oWV0k=;
        b=Tz80JRVgzCJt1iWSVO0+IbvqfpexTrcYTsejKkYlUKToOOunUbAn/WbdvtU0jv+x1AC7mQ
        JlJkLr/cA5aP1QdpsP+y/MpLUBrSy15Zj8sDVMplJbbY8OtuCOH9XpcCKmFQLxCwMQewpP
        ifNPczo5aZm/pwGkbw5NCnrMCofW688=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-321-x4R4-UJ4NqaWm-2McJEmKQ-1; Wed, 09 Feb 2022 09:50:17 -0500
X-MC-Unique: x4R4-UJ4NqaWm-2McJEmKQ-1
Received: by mail-wm1-f69.google.com with SMTP id 125-20020a1c0283000000b0037bf720e6a8so405842wmc.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 06:50:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GCdwEoIBITb866ZII/MklMSrfR+LqGATKN4cy7oWV0k=;
        b=nXIuEcL+rqkS0lktvLYHptIdkAdgET5MWTJhzYtsCdjpThP3E6ZygktBdTQoxmmzgz
         juYuaGzHmzacTF1h49u7yf5xMhLSTxdughFIZPREdvZK/MUZowKv1Xa5JElorY+DZ+jb
         duxCb//umBgpRDE4hxaHb2Kz7JTQPh18PV+XSLxEwnu4AyTL4J21UXIOhQ8v+bIkrmlX
         Bv9rycQYKhcF5eJzGfgVViNux4WHem3wAgxV3genzOxEhd36ukbNW8pUOL/xy4E7pLSG
         SAvjltMEhJ+ZMDEVLQmcJOrovW7B8LnESpajdFulsxfL3YVDMc2zYW3lf1gXA+ASIywi
         +7QQ==
X-Gm-Message-State: AOAM532Z1AZ39F7IpEZ1+F0Va/X/U9adPZbZRcwQHy/LgrUDxHGtddLn
        w4Qn9FbZYSmtA08ugkV0QIVxFwQXVS9n108C/9HTwejemXvrSVY+r2LJbDmHfD6aqaMsR3jlwSJ
        +77zU/tTulPfId5XZlicRuKBy
X-Received: by 2002:adf:c74f:: with SMTP id b15mr2468796wrh.307.1644418216019;
        Wed, 09 Feb 2022 06:50:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzZ+aCmdyVfsqG8nX2yK7Vow4vj4dB6fQbmE3flM8O2RH71KLJgArlRFmLkg6F73kXfRljWzw==
X-Received: by 2002:adf:c74f:: with SMTP id b15mr2468781wrh.307.1644418215812;
        Wed, 09 Feb 2022 06:50:15 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t4sm15470023wro.71.2022.02.09.06.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 06:50:15 -0800 (PST)
Message-ID: <561e1f22-2741-b414-0267-14587d59d5de@redhat.com>
Date:   Wed, 9 Feb 2022 15:50:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 3/7] drm: Add driver for Solomon SSD130X OLED displays
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-pwm@vger.kernel.org
References: <20220209090314.2511959-1-javierm@redhat.com>
 <20220209090314.2511959-4-javierm@redhat.com>
 <YgPE8Z7HxU2wv7J/@sirena.org.uk>
 <d1025530-90e1-fbc5-c06b-f62ed83f2f19@redhat.com>
 <YgPOKf1QcOCtTisx@sirena.org.uk>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YgPOKf1QcOCtTisx@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/22 15:22, Mark Brown wrote:
> On Wed, Feb 09, 2022 at 03:17:06PM +0100, Javier Martinez Canillas wrote:
>> On 2/9/22 14:43, Mark Brown wrote:
> 
>>> Unless the device supports power being physically omitted regulator
>>> usage should not be optional, it's just more code and a recipie for poor
>>> error handling.
> 
>> The device has a VCC pin but in most cases this is just connected to a
>> power provided by the board in its pinout header. For example, I've it
>> connected to a rpi4 3.3v pin.
> 
> That sounds like a very common configuration.
>

Yep.
 
>> I guess in that case what we should do then is to just have a regulator
>> fixed as the vbat-supply in the Device Tree, that's regulator-always-on.
> 
> Generally I'd suggest labelling things with whatever the supply is
> called in the board's schematics/documentation, that tends to make
> things clearer and easier to follow.
> 

The display controller datasheet and schematics mention VBAT as the power
supply but the documentation says that it's just connected to VCC and the
label in the display says VCC.

But I understand why the Device Tree binding and fbdev driver used VBAT
since that's what the documentation mentions.

>> The old ssd1307fb fbdev driver also had this as optional and I wanted to
>> keep the new driver as backward compatible. But I understand now that is
>> not describing the hardware properly by making this regulator optional.
> 
> It is depressingly common to see broken code here, unfortunately
> graphics drivers seem like one of the most common offendors.

I'll include a patch for the existing DT binding and mark the vbat-supply
property as required. Probably we won't be able to change the fbdev driver
without causing regressions, and I'm not interested in that driver anyways.

Best regards,
--
Javier Martinez Canillas
Linux Engineering
Red Hat

