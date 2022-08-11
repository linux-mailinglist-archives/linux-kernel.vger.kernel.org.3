Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06D058FEC4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 17:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235505AbiHKPFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 11:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbiHKPFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 11:05:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A318D2228B
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 08:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660230337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lI/df67WWBQ+EHM94gejPAuozvytWTuVRy8OacQvMo0=;
        b=M9SqTNt9jgO3QCru/CrIY4Ir7do49mWarV8FycJBk0bqUuGHrepu2+ShAK5p/M3EEWPj4o
        AQZAeym9GHKwe0YJZDFvBzg0arzZMeVVG9SN5J3ao2ADlwCeSMvkJxTFd+XPGivJVt+FPS
        Y77ZL/hDkyC8NnfPdUN/eB/AUSiuZDU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-427-TcrneUvpNB-UDCu-To-fWw-1; Thu, 11 Aug 2022 11:05:36 -0400
X-MC-Unique: TcrneUvpNB-UDCu-To-fWw-1
Received: by mail-ed1-f70.google.com with SMTP id z6-20020a05640240c600b0043e1d52fd98so11272949edb.22
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 08:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=lI/df67WWBQ+EHM94gejPAuozvytWTuVRy8OacQvMo0=;
        b=fuI7U5JLwjjmwQBTzpXABExxAwEGOGSt0rHjfB3tPBKLNArph+AMPIYRGWFz1S+5m0
         0WmoAXSzgsxFQeSSTk/ROSbrNSvRznygfe9Apatwtaazs62GF7mJlJIoOl+f/QGy4RnG
         E5lDYY2j/dpgeSJMvaeEiaXkE+Ybrs7FFMTQ9jseJTeX8YxcxWg6YsPbdiwC/85NruaK
         usGh9C4wiY5hQ4wRgkYfhWctMSxF/xzCKzlpDhlkJfamIkgLsUhFDU6ieFcUFs1MdYOO
         vLg/aQVL1kE1wetQ4TP1KF/0xMR6fXKz/A0rxczl08rUKnheHvgqoZX2SPxgoFpAOwAD
         8jVg==
X-Gm-Message-State: ACgBeo1/W13/CGKaIgUgdNzAAM1gLoL+0pL/ZrGLliMTyawU4DrhUd7e
        HocEY1n4h4srXQ0WBKdO4TQUfeYSLc0DGRWiIvCp4tT1ljwlA+GW7hRThRh7ch5v/DiW5LmJ/7t
        phUSaDFc50wWb+syViTeiwXDp
X-Received: by 2002:a17:906:9c82:b0:6df:c5f0:d456 with SMTP id fj2-20020a1709069c8200b006dfc5f0d456mr24924907ejc.287.1660230335409;
        Thu, 11 Aug 2022 08:05:35 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4YCeVf+TSP0YhY+clKXcUmkOIn1X3nMS8oKPC6Nxfwe7liqRi7jVEcThB0LYnj7cftYnWNig==
X-Received: by 2002:a17:906:9c82:b0:6df:c5f0:d456 with SMTP id fj2-20020a1709069c8200b006dfc5f0d456mr24924882ejc.287.1660230335018;
        Thu, 11 Aug 2022 08:05:35 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id bx7-20020a0564020b4700b0043577da51f1sm9242630edb.81.2022.08.11.08.05.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 08:05:34 -0700 (PDT)
Message-ID: <af6b9480-5e33-ec1b-94cc-e51724db0716@redhat.com>
Date:   Thu, 11 Aug 2022 17:05:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 1/6] asus-wmi: Implement TUF laptop keyboard RGB
 control
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
To:     Luke Jones <luke@ljones.dev>, Pavel Machek <pavel@ucw.cz>
Cc:     andy.shevchenko@gmail.com, pobrn@protonmail.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220809025054.1626339-1-luke@ljones.dev>
 <20220809025054.1626339-2-luke@ljones.dev> <20220809105031.GA4971@duo.ucw.cz>
 <fcc7b7eb29abc1ac9053bce02fd9f705e5f06b0b.camel@ljones.dev>
 <f1ad35f6-acdf-0fc8-1ee1-99bd8c7a5e77@redhat.com>
In-Reply-To: <f1ad35f6-acdf-0fc8-1ee1-99bd8c7a5e77@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/11/22 17:01, Hans de Goede wrote:
> Hi,
> 
> On 8/10/22 06:44, Luke Jones wrote:
>> Hi Pavel, Andy, Hans,
>>
>>>>>>>>>> +               /*
>>>>>>>>>> +                * asus::kbd_backlight still controls a
>>>>>>>>>> base > > > > > > 3-level backlight and when
>>>>>>>>>> +                * it is on 0, the RGB is not visible
>>>>>>>>>> at all. > > > > RGB > > should be treated as
>>>>>>>>>> +                * an additional step.
>>>>>>>>>> +                */
>>>>>>
>>>>>> Ouch. Lets not do that? If rgb interface is available, hide the
>>>>>> 3
>>>>>> level one, or something.
>>>>>>
>>
>> I really don't think this is safe or sensible. There are some laptops
>> that default the 3-stage method to off, and this means that the LEDs
>> will not show regardless of multicolor brightness.
>>
>>
>>
>>>>>>>>>> +               mc_cdev->led_cdev.name =   > > > > > >
>>>>>>>>>> "asus::multicolour::kbd_backlight";
>>>>>>
>>>>>> Make this "rgb:kbd_backlight" or "inputX:rgb:kbd_backligh" and
>>>>>> document it in Documentation/leds/well-known-leds.txt.
>>
>> Will do.
>>
>> -- 4 hours later --
>>
>> I've spent a lot of time working on this now. I don't think multicolor
>> LED is suitable for use with the way these keyboards work.
>>
>> The biggest issue is related to the brightness setting.
>> 1. If the ASUS_WMI_DEVID_KBD_BACKLIGHT method defaults to 0 on boot
>> then RGB is not visible
> 
> Note to others following this thread I asked Luke to clarify this
> a bit in an unrelated 1:1 conversation we were having:
> 
> On 8/10/22 23:45, Luke Jones wrote:
>> On 8/10/22, Hans de Goede wrote:
>>> I plan to go through all the asus-wmi stuff you've posted tomorrow,
>>> so I'll reply to this then. One thing which is not entirely
>>> clear to me is that:
>>>
>>> 1. If I understand you correctly the laptops
>>> with the RGB keyboards have both the old mono-color
>>> "asus::kbd_backlight"
>>> as well as a new RGB interface and these somehow interact with each
>>> other, do I understand that correctly?
>>
>> Yes, and that is the problem. The "mono" switch takes precedence.
>>
>>> 2. If yes, then can you explain the interaction in a bit more detail,
>>> I see you say someting along the lines of the RGB controls only
>>> working when the old mono-color "asus::kbd_backlight" brightness
>>> is set to 3 (which is its max brightness) ?
>>
>> Adjusting this changes the overall keyboard brightness. So if this is
>> at 1, and all RGB is at 255, then when you switch 2, 3, the overall
>> brightness increases.
>>
>>> 3. So what happens e.g. if writing 2 to the old mono-color
>>> "asus::kbd_backlight" brightness after setting some RGB values ?
>>
>> If the brightness was 3, then the overall brightness decreases.
>> If it was at 1, then it increases.
> 
> I see, so the old (still present) mono-color "asus::kbd_backlight"
> brightness works as a master brightness control and the rgb values
> in the ASUS_WMI_DEVID_TUF_RGB_MODE WMI set commands are really
> just to set the color.
> 
> And I guess that the Fn + whatever kbd brightness hotkey also still
> modifies the old mono-color "asus::kbd_backlight"? Which means that
> the "asus::kbd_backlight" device is also the device on which the
> led_classdev_notify_brightness_hw_changed is done as you mention
> below.
> 
> (continued below.
> 
>> I worked around this by setting it to "3" by default in module if
>> ASUS_WMI_DEVID_TUF_RGB_MODE is found. And added a check in the button
>> events to adjust multicolor brightness (+/- 17). This works but now I
>> can't do led notify (led_classdev_notify_brightness_hw_changed).
>>
>> 2. Pattern trigger can't be used for these keyboard modes as the modes
>> are done entirely in hardware via a single switch in the complete
>> command packet.
>>
>> I don't see any way forward with this, and looking at the complexity I
>> don't have time either.
>>
>> 3. Nodes everywhere..
>>
>> To fully control control these keyboards there are two WMI methods, one
>> for mode/rgb, one for power-state. Splitting each of these parameters
>> out to individual nodes with sensible naming and expectations gives:
> 
> <snip>
> 
>> Quite frankly I would rather use the method I had in the first patch I
>> submitted where mode and state had two nodes each,
>> - keyboard_rgb_mode, WO = "n n n n n n"
>> - keyboard_rgb_mode_index, output = "save/apply, mode, r, g, b, speed"
>> - keyboard_rgb_state, WO = "n n n n n"
>> - keyboard_rgb_state_index, output = "save/apply, boot, awake, sleep,
>> keyboard"
>>
>> A big benefit of this structure is that not being able to read settings
>> back from the keyboard (not possible!) becomes a non-issue because
>> users have to write a full input, not partial, and it will apply right
>> away.
> 
> Right to me this not being able to read back the values shows that
> the firmware API here really is not suitable for doing a more
> fancy "nice" / standard sysfs API on top.
> 
> Since we cannot read back any of the r, g, b, mode or speed values
> we would need to pick defaults and then setting any of them would
> override the actual values the hw is using for the others, which
> is really not a good thing to do.
> 
> So that only leaves something akin to keyboard_rgb_mode[_index] +
> keyboard_rgb_state[_index] which sets all values at once, mirroring
> the limited WMI API as a good option here, I agree with you on this.
> 
> Sorry Pavel, I know you don't like custom sysfs attributes
> being added to LED class devices, but I have to agree with Luke
> that there really is not a good way to deal with this here and
> we did try!
> 
> Only request I have for the next version wrt the decision to
> circle all the way back to having:
> 
>> - keyboard_rgb_mode, WO = "n n n n n n"
>> - keyboard_rgb_mode_index, output = "save/apply, mode, r, g, b, speed"
>> - keyboard_rgb_state, WO = "n n n n n"
>> - keyboard_rgb_state_index, output = "save/apply, boot, awake, sleep,
> 
> Is please put these new attributes under the:
> /sys/class/leds/asus::kbd_backlight
> 
> Using the led_class_device.groups member as discussed before, now
> that we have decided to drop the multicolor LED stuff that should
> work :)
> 
> Although maybe Pavel prefers to have the new sysfs attributes
> under /sys/bus/platform/devices/asus-nb-wmi/ instead since they
> are non standard.
> 
> Pavel, to me having these under /sys/class/leds/asus::kbd_backlight
> seems more logical.

p.s.

Besides it being more logical to group these together with the
main brightness control for the kbd_backlight, I believe this
way the files will also be easier to discover for users
(users not using the asusctl utility that is).

> But since there are non-standard and since
> there already is a bunch of asus-wmi sysfs API under
> /sys/bus/platform/devices/asus-nb-wmi/ putting them there if you
> prefer that is fine with me too. So what do you prefer ?
> 
>> Hans, Andy, can I please revert back to the node + _index pairs taking
>> an array input. Everything will be cleaner and simpler.
> 
> Ack, see above. Thank you for at least trying to use the multi-color
> LED API. 
> 
> Regards,
> 
> Hans
> 

