Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4CE5549E00
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343893AbiFMTrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241716AbiFMTqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:46:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 600A037A15
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 11:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655144265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lUrbBgi3LSd4ND0XNRavmhKQAJhduQvPQp5t4kVdiFU=;
        b=A/Bvx2G3f+f5rytWeSlMG0usfiGYhAi8D5jf0l6IzL6om4kOwIzZ0tAjKsE8PBkQFZkzfv
        AcKxL+9YksPkzln1aNnKNPbR0FB9Szs4ib14XWBuonHZGsi/eZmKUAbsN3PAJMGYZsvVm8
        8fVoZhDmlr3CRhqvu8R4uCphppyydPA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-326-UamvXR0ZMqCe6urgpGS71w-1; Mon, 13 Jun 2022 14:17:43 -0400
X-MC-Unique: UamvXR0ZMqCe6urgpGS71w-1
Received: by mail-wm1-f69.google.com with SMTP id c125-20020a1c3583000000b003978decffedso6257177wma.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 11:17:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lUrbBgi3LSd4ND0XNRavmhKQAJhduQvPQp5t4kVdiFU=;
        b=tyH8Dkego4LorvGhA/MhgkgrDAogV6QHzZZJ9Y3afunlotplTL24ZHJj9ZJHqQaB2V
         EaUCHzesR3V1bNglHg+YbNUr5r3xsYkq43ZtcuMBYLp5LSq8VQJdobuOEhRYUZQxIDFz
         WYZRs6+AhDWmDnQLnm1muCnwYh/Eh+7dNoh6ZEyYaZ7dj3CZV0lwiNXolvSff/PTehqb
         1dMiqRhVKZVsTaca5JixZGKH6swym8pxnk/nRu/Bxd9spBZMk/DIqcdviQb00/hyia+d
         qK605yu8UgNybqG/aIZQc14HUXwmdJToWMhmhjVV6838rK0KIf0N8eCnRUFxLLz99JS2
         i3pw==
X-Gm-Message-State: AJIora92gyRN3fjRT7XU44c4qkLN53riQMc6SSw0neddp+/ZQwzYLKcQ
        uzVdQwG0h4HbGLYVLt4oKcpeP7cawv1xZzw2aRQsaP7Vnwh9l6OYXje3LEM9vDP5NtPrc7ySlbO
        iPBSUfCPe/tn3nYphruM6D+a9
X-Received: by 2002:a5d:5888:0:b0:217:fffd:6aae with SMTP id n8-20020a5d5888000000b00217fffd6aaemr1048213wrf.330.1655144262366;
        Mon, 13 Jun 2022 11:17:42 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tp9ncPvOt7Y13/zNoeRC0TC4NujogoolYUDyUUEVuG1KDdBvNRsFOAEBVTpKybMh0EllQpqA==
X-Received: by 2002:a5d:5888:0:b0:217:fffd:6aae with SMTP id n8-20020a5d5888000000b00217fffd6aaemr1048183wrf.330.1655144262045;
        Mon, 13 Jun 2022 11:17:42 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id a21-20020a05600c069500b0039c54bb28f2sm9945877wmn.36.2022.06.13.11.17.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 11:17:41 -0700 (PDT)
Message-ID: <71492744-faf9-3e73-4a32-cb62968b0324@redhat.com>
Date:   Mon, 13 Jun 2022 20:17:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 3/6] drm: Add driver for Solomon SSD130x OLED displays
Content-Language: en-US
To:     Dominik Kierner <dkierner@dh-electronics.com>
Cc:     "airlied@linux.ie" <airlied@linux.ie>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "maxime@cerno.tech" <maxime@cerno.tech>,
        "noralf@tronnes.org" <noralf@tronnes.org>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>
References: <7a78d57342754a5d9bd3ce7c7bf3fa47@dh-electronics.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <7a78d57342754a5d9bd3ce7c7bf3fa47@dh-electronics.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dominik,

On 6/13/22 13:39, Dominik Kierner wrote:

Removed the regmap part since Andy already commented and I agree with him.

>>> Splitting in VCC/VBAT and VDD and enforcing their presence is of
>>> course compatibility breaking.
>>>
>>> https://github.com/dh-electronics/panel-solomon-ssd130x-draft/blob/drm
>>> -ssd130x/drivers/gpu/drm/panel/panel-solomon-ssd130x.h#L85
>>> https://github.com/dh-electronics/panel-solomon-ssd130x-draft/blob/drm
>>> -ssd130x/drivers/gpu/drm/panel/panel-solomon-ssd130x.c#L80
>>>
>>
>> It is a break in the DT binding indeed but on the other hand it seems that the
>> regulator story is lacking in the current solomon,ssd1307fb.yaml anyways.
>>
>> That is, the binding schema only mentions a "vbat-supply" but the DRM driver is not
>> looking for that but instead for "vcc-supply" (I think that was changed due some
>> feedback I got on some revisions, but didn't update the DT binding). The fbdev
>> drivers/video/fbdev/ssd1307fb.c driver does lookup "vbat-supply" but all the DTS and
>> DTS overlays I find don't set one.
>>
>> Also the "vbat-supply" is not a required property in the current binding. One thing to
>> notice is that regulator_get() and regulator_get_optional() semantics are confusing
>> (at least for me). Since doesn't mean whether the regulator must be present or not
>> but rather if a dummy regulator must be provided if a supply is not found.
> 
> I always understood regulator_get_optional() as a way of not having to rely on a dummy,
> when a regulator is not present, but please correct me, if I am wrong on this.
> The dummies would only be necessary for the mandatory supplies VCC and VDD. 
> 

Yes, that's what I tried to say. That's regulator_get() and not _optional()
the function that will provide a dummy regulator if isn't physically present:

https://elixir.bootlin.com/linux/latest/source/drivers/regulator/core.c#L2067

> You mean this part of the documentation of regulator_get_optional(), correct?:
> 
>> * This is intended for use by consumers for devices which can have
>> * some supplies unconnected in normal use, such as some MMC devices.
>> * It can allow the regulator core to provide stub supplies for other
>> * supplies requested using normal regulator_get() calls without
>> * disrupting the operation of drivers that can handle absent
>> * supplies.
>
> 
>> In other words, I don't think that any of these supplies should be made required in
>> the DT binding but just leave the current "vbat-supply" and add properties for "vcc-
>> supply" and explain the relationship between these and just make the logic in the
>> driver to override struct ssd130x_deviceinfo .need_chargepump if are present.
> 
> My idea was to require these supplies, so that the binding correctly
> reflects the manuals. Driving supply VCC and logic supply VDD, are
> present throughout the SSD130x family. Only the VBAT supply is an
> optional SSD1306 specific and would therefore use an optional
> regulator.
> 
> The only other device specific supply is the SSD1305's VDDIO supply,
> which is mandatory and seems to be commonly connected to VDD,
> so including that is likely unnecessary.
> I Just wanted to mention it for completeness.
> 
> If the device isn't controllable by Linux, a dummy would be connected
> instead, just like the dummy regulator documentation states:
> 
>> * This is useful for systems with mixed controllable and
>> * non-controllable regulators, as well as for allowing testing on
>> * systems with no controllable regulators.
> 
> Which would be the case, with the SSD130x controllers.
> Sometimes they are connected to external, non-controllable regulators.
> 
> I figured that the kernel developers might be more open to a compatibility
> breaking change, under the circumstance, that this is more or less a new
> driver for DRM, that it provides atomic charge pump configuration for the
> SSD1306 and that some (embedded) user space software might need to be
> rewritten to accommodate for the transition from fbdev to DRM anyway.
> But I might be wrong on this.
> 

So for example when you just use a voltage rail in let's say a board pin header
then you will need to define supply nodes with compatible = "regulator-fixed" ?

That is indeed more accurate from a hardware description point of view but I'm
not convinced that this is something worth to break DT backward compatibility.

You also mentioned (IIUC) that the regulators could be made optional and their
presence be used as an indication that an atomic charge pump configuration can
be made instead of using the current ssd130x->display_settings.use_charge_pump.

I think that would prefer that the latter option, but will let others to chime
in since maybe I'm not correct on the preferred approach.

> 
>>> # Static or Dynamic Configuration for SPI-Modes 3-Wire and 4-Wire
>>>
>>> For the SPI-protocol drivers I see two possible approaches:
>>> * Dynamic configuration by determining the presence/absence of the
>>>   D/C-GPIO and assigning the functions accordingly.
>>>   This way a single driver file for both SPI modes could be sufficient.
>>> * Static configuration by using the device-tree names
>>>   (ssd130x-spi-3wire/-4wire) to differentiate between the SPI protocol
>>>   drivers.
>>>   This would obviously necessitate two drivers files.
>>>
>>> Which one do you think would be the best approach for this?
>>>
>>
>> I think that prefer the first approach. As mentioned the staging driver has a
>> "buswidth" property but as you said we could just use the "dc-gpios" presence as
>> indication on whether is a 4-wire or 3-wire SPI mode.
> 
> You are correct, I do prefer the first approach.
> It would cut the additional file and code required for the second
> approach and eliminate an additional device tree name,
> that would have been necessary otherwise.
>

Great that we are on the same page here.

> 
>>> What is Your opinion on using drm_panel for Your driver?
>>>
>>
>> I can't remember exactly why I decided to stop using drm_panel, but I think that
>> was because struct drm_panel doesn't have a DRM device and so couldn't use any of
>> the helper functions that needed one?
> 
> I likely hit the same roadblock.
> I would say, this approach should be revisited, when appropriate
> helpers for this approach exist, as it would further clean up and
> generify the ssd130x device configuration.
>

It's unlikely that drm_panel will get a drm_device since that was the case
but was changed by commit aa6c43644bc5 ("drm/panel: drop drm_device from
drm_panel"). But yes, I agree that we could revisit if there are helpers in
the future to manage a backlight device that is handled by a DRM driver.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

