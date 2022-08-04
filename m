Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E56E589C1A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 15:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238189AbiHDNDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 09:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbiHDNDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 09:03:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 20CC613DF4
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 06:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659618222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NHDkM33+Eyq8G8GfM9ob+sKTn18trPXewk/ZTi54akU=;
        b=h2mPaJ1w0Lu70tz7GTnTgMem2fvjVceG6c6yMJ713ua15Fz2IcoBaQ+2+dPmAtkQfX6zSU
        MNqEG9WFkmUPKGbrP/Z3OPW7N1bQnu5al89KPU7a8Bl/GrGZaYt8l852at2yh9VSLo13x4
        EGCD+5JgFBNx6VopTC8vPlII1PDcoMU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-413-ZvLZEXFPNnyYiv2PDuxQgg-1; Thu, 04 Aug 2022 09:03:41 -0400
X-MC-Unique: ZvLZEXFPNnyYiv2PDuxQgg-1
Received: by mail-ej1-f71.google.com with SMTP id hr32-20020a1709073fa000b00730a39f36ddso2400521ejc.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 06:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NHDkM33+Eyq8G8GfM9ob+sKTn18trPXewk/ZTi54akU=;
        b=cp106+NRXJdp6+yLOy6haGmX/eTKrTVHnJkFIkNyqjcCMzVVFgN+fXwmRVzeOwI0b6
         asdiUB1S2iu9rci++vOjT/+JzgusIpYcWWLpcw/PplqTDIeoj2Zxg64o63xwX6F1E+zo
         vcR1wD5fxIc2+QsTh3EFEci++luRtymExtbs/EgzhCZr2LN7Xd4UCNIRy9DJlDmzQXx4
         eeqEmtNxzd4p0Lkf6nUtWgspUtypHnYWt8i7JYn7FCs/0JalkwYpelBqCXBL1Ppw4roU
         LimmlZh//Ma4bocdv1zoAPzVVnHi8uc//Mwa/1veugTKBJqsGZdPtmGCdA2yjjoczTT9
         iObg==
X-Gm-Message-State: ACgBeo2BayNyvOBZDAyJYpyTRf/9VaQnMjbLDZy315ps2Q2LZRMkA/jS
        cFzCrBmhd8LX9bwtpvr3ZDM4PiTsRuh7jxbgQ5q2nR4+IQ/xtJGR4OzTTKdUFw7E/nEdwkwDMix
        s1KvKODowvIpD+TXF0KJyvzVQ
X-Received: by 2002:a17:907:6890:b0:72e:d01f:b889 with SMTP id qy16-20020a170907689000b0072ed01fb889mr1363735ejc.669.1659618219920;
        Thu, 04 Aug 2022 06:03:39 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6rH+0g+HZgeafFVtqNvDcJomIBdh9/k7wp9BZBmRS5rtxtlqHYECFhoJFesmfyYupySWTMjg==
X-Received: by 2002:a17:907:6890:b0:72e:d01f:b889 with SMTP id qy16-20020a170907689000b0072ed01fb889mr1363699ejc.669.1659618219489;
        Thu, 04 Aug 2022 06:03:39 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id r11-20020aa7d58b000000b0043acddee068sm629356edq.83.2022.08.04.06.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 06:03:38 -0700 (PDT)
Message-ID: <3fc3540f-2bf0-bbe7-293c-ab11c42528c7@redhat.com>
Date:   Thu, 4 Aug 2022 15:03:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] asus-wmi: Add support for TUF laptop keyboard RGB
Content-Language: en-US
To:     Luke Jones <luke@ljones.dev>
Cc:     corentin.chary@gmail.com, markgross@kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20220802045942.1565559-1-luke@ljones.dev>
 <e6c0ca61-97d3-328b-f50e-7cdac50eb083@redhat.com>
 <4cb33604-28c6-ac51-0162-2e5a027f02a0@redhat.com>
 <SCE0GR.PE33MM569SDQ3@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <SCE0GR.PE33MM569SDQ3@ljones.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luke,

On 8/3/22 00:26, Luke Jones wrote:
> Hi Hans,
> 
> Not a problem at all mate (it didn't take long to write), I was expecting this and intended the patch more as a "let's see where we go".
> 
> Thank you for the information on how to handle proper bring-up, it seems I should be able to use this for both the TUF ACPI controlled keyboard along with the ROG USB connected keyboards - which would be excellent for everyone using these laptops. The TUF series of laptops are relatively nice and simple to work with due to the limited feature-set, so this is a great starting point.

Cool, thank you.

> To ensure I am on the correct footing, using the information provided, the goal would be to provide the following?
> 
> Base RGB setting under:
> /sys/class/leds/multicolor:status/multi_index
> /sys/class/leds/multicolor:status/multi_intensity
> /sys/class/leds/multicolor:status/max_brightness
> 
> Extra features under:
> /sys/class/leds/asus::kbd_backlight/mode
> /sys/class/leds/asus::kbd_backlight/speed
> /sys/class/leds/asus::kbd_backlight/direction

Erm, no the multicolor:status thing is just an example from the docs. You can
pick your own name for the LED class device in the driver and it should end
with ::kbd_backlight to make clear that it is a keyboard backlight (existing
userspace code checks for this postfix).

So you would just have everything under /sys/class/leds/asus::kbd_backlight/;
or maybe even better since you mentioned you also want to support USB keyboards
(presumably through drivers/hid/hid-asus.c ?) avoid a possible conflict there
by using: /sys/class/leds/asus_wmi::kbd_backlight/ so you would get:

Everything in one place:
/sys/class/leds/asus_wmi::kbd_backlight/multi_index
/sys/class/leds/asus_wmi::kbd_backlight/multi_intensity
/sys/class/leds/asus_wmi::kbd_backlight/max_brightness
/sys/class/leds/asus_wmi::kbd_backlight/mode
/sys/class/leds/asus_wmi::kbd_backlight/speed
/sys/class/leds/asus_wmi::kbd_backlight/direction

Note I must admit I don't have any experience with the multi-color
LED API. But for a non RGB (so single color) example see the
dell-laptop code:

/* whole bunch of show/store functions */

static struct attribute *kbd_led_attrs[] = {
        &dev_attr_stop_timeout.attr,
        &dev_attr_start_triggers.attr,
        NULL,
};

static const struct attribute_group kbd_led_group = {
        .attrs = kbd_led_attrs,
};

static struct attribute *kbd_led_als_attrs[] = {
        &dev_attr_als_enabled.attr,
        &dev_attr_als_setting.attr,
        NULL,
};

static const struct attribute_group kbd_led_als_group = {
        .attrs = kbd_led_als_attrs,
};

static const struct attribute_group *kbd_led_groups[] = {
        &kbd_led_group,
        &kbd_led_als_group,
        NULL,
};

static enum led_brightness kbd_led_level_get(struct led_classdev *led_cdev)
{
	return <current-brightness>
}

static int kbd_led_level_set(struct led_classdev *led_cdev,
                             enum led_brightness value)
{
	<write value to hw>;
}

static struct led_classdev kbd_led = {
        .name           = "dell::kbd_backlight",
        .brightness_set_blocking = kbd_led_level_set,
        .brightness_get = kbd_led_level_get,
        .groups         = kbd_led_groups,
};

static int __init kbd_led_init(struct device *dev)
{
       return led_classdev_register(dev, &kbd_led);
}

Notice how the name is chosen to be "dell::kbd_backlight" and
additional attributes for handling special features are
passed in the led_classdev.groups attribute.

> Some questions I have:
> 1. If there is more than one RGB capable keyboard, what happens to /sys/class/leds/multicolor:status ?

See above, you should pick a unique name for the asus_wmi supported
RGB keyboard, of which there will presumably be only one.

> 2. There is no way to fetch the current values from the keyboard and multicolor seems to expect that the current settings can be read - the issue here I think is that if the keyboard is changed perhaps by Windows dual-boot then these settings won't match. How would this be handled?

Yes I've seen this problem before with some USB keyboards with
backlight support.

Can you read back the "saved" profile at least ? Then I would just
default to that. Otherwise maybe default to the factory default settings?

And then I would expect any userspace daemon like code using this
interface to save/restore settings over reboot; and after the first
write the driver can just cache the last written values.

> 3. I'm still relatively new to sysfs. Is it possible for sysfs to save these values (e.g, multicolour) and re-apply on boot?

This would require userspace support. systemd already does something
like this for the display panel backlight. I can imagine a similar
small helper + udev rules to trigger it being part of asusctl
(since you also want to save/restore some Asus special settings) ?

> 4. In the case of the ROG USB connected laptop keyboards, some models have per-key control. How would I enable this using the multicolour API? Something like:
> 
> /sys/class/leds/multicolor:status/multi_a_index
> /sys/class/leds/multicolor:status/multi_a_intensity
> /sys/class/leds/multicolor:status/multi_left_ctrl_index
> /sys/class/leds/multicolor:status/multi_left_ctrl_intensity
> /sys/class/leds/multicolor:status/multi_spacebar_index
> /sys/class/leds/multicolor:status/multi_spacebar_intensity
> /sys/class/leds/multicolor:status/max_brightness (individual or all?)
> 
> For these keyboards the USB takes 9-12 packets of 64 bytes, and I've indexed the locations of colours in each. To be honest I'd very much like to work out how to do this for per-key as it can potentially save a lot of time in writing each packet if the kernel is able to batch writes internally. A single packet for half a row is ~1ms, but can vary up to 5ms..

This really needs to be discussed on the linux-leds@vger.kernel.org
list (please Cc me).

ATM AFAIK most Linux tools to program USB keyboards with per key
settings just use /dev/hidraw to directly talk to the kernel,
so there is no existing kernel API for this at all yet.

> 4. I'm unsure of how to structure the USB-RGB code.. Would I need to write an extra driver perhaps?

Normally the HID subsystem tries to stick to one driver per vendor,
so that would make drivers/hid/hid-asus.c the right place to stick
this. But if it is big and does not share much code with the rest
a new driver under say drivers/hid/hid-asus-rog.c might make sense...

Regards,

Hans



> On Tue, Aug 2 2022 at 14:13:06 +0200, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 8/2/22 13:09, Hans de Goede wrote:
>>>  Hi Luke,
>>>
>>>  On 8/2/22 06:59, Luke D. Jones wrote:
>>>>  Adds support for TUF laptop RGB control. This creates two sysfs
>>>>  paths to add control of basic keyboard LEDs, and power states.
>>>>
>>>>  /sys/devices/platform/asus-nb-wmi/tuf_krgb_mode has the following
>>>>  as input options via U8 "n n n n n n":
>>>>  - Save or set, if set, then settings revert on cold boot
>>>>  - Mode, 0-8 for regular modes (if supported), 10-12 for "warning" styles
>>>>  - Red, 0-255
>>>>  - Green, 0-255
>>>>  - Blue, 0-255
>>>>  - Speed, 0 = Slow, 1 = Medium, 2 = Fast
>>>>
>>>>  /sys/devices/platform/asus-nb-wmi/tuf_krgb_state has the following
>>>>  as input options via boolean "b b b b b":
>>>>  - Save or set, if set, then settings revert on cold boot
>>>>  - Boot, if true, the keyboard displays animation on boot
>>>>  - Awake, if true, the keyboard LED's are on while device is awake
>>>>  - Sleep, if true, the keyboard shows animation while device is suspended
>>>>  - Keybaord, appears to have no effect
>>>
>>>  Typo in Keybaord here.
>>>
>>>  Thank you for your patch. I really appreciate your continued
>>>  efforts to make Asus laptops work well with Linux.
>>>
>>>  For keyboard backlight support Linux has standardized on
>>>  using the /sys/class/leds API. So I'm afraid that this patch
>>>  will need to be rewritten to use the standard LED API
>>>  and then specifically the somewhat new multicolor LED API
>>>  at least for setting the RGB values (within the current mode)
>>>
>>>  Any extra functionality can then be added as extra sysfs
>>>  attributes under the /sys/class/leds/asus::kbd_backlight
>>>  device, see e.g. the use of kbd_led_groups in:
>>>  drivers/platform/x86/dell/dell-laptop.c
>>>
>>>  Note the kbd_backlight part of the name is important this
>>>  will allow upower to recognize this as a keyboard backlight
>>>  and will then enable desktop-environments which use
>>>  upower for kbd backlight control to at least control
>>>  the overall brightness of the kbd-backlight.
>>>
>>>  I realize that this means that you need to redo a whole
>>>  bunch of work here; and I presume also in your
>>>  asusctl userspace utility, sorry about that. But it
>>>  really is important that standard userspace APIs are
>>>  used for things like this where ever possible.
>>>
>>>  Regards,
>>>
>>>  Hans
>>
>> p.s.
>>
>> For more info on the multi-color LED API see:
>>
>> https://www.kernel.org/doc/html/latest/leds/leds-class-multicolor.html
>> https://www.phoronix.com/scan.php?page=news_item&px=Linux-5.9-Multi-Color-LEDs
>>
>>
>>
>>>
>>>
>>>
>>>
>>>>
>>>>  Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>>>  ---
>>>>   drivers/platform/x86/asus-wmi.c            | 168 +++++++++++++++++++++
>>>>   include/linux/platform_data/x86/asus-wmi.h |   6 +
>>>>   2 files changed, 174 insertions(+)
>>>>
>>>>  diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
>>>>  index 62ce198a3463..09277bd98249 100644
>>>>  --- a/drivers/platform/x86/asus-wmi.c
>>>>  +++ b/drivers/platform/x86/asus-wmi.c
>>>>  @@ -234,6 +234,9 @@ struct asus_wmi {
>>>>       bool dgpu_disable_available;
>>>>       bool dgpu_disable;
>>>>
>>>>  +    bool tuf_kb_rgb_mode_available;
>>>>  +    bool tuf_kb_rgb_state_available;
>>>>  +
>>>>       bool throttle_thermal_policy_available;
>>>>       u8 throttle_thermal_policy_mode;
>>>>
>>>>  @@ -734,6 +737,153 @@ static ssize_t egpu_enable_store(struct device *dev,
>>>>
>>>>   static DEVICE_ATTR_RW(egpu_enable);
>>>>
>>>>  +/* TUF Laptop Keyboard RGB Modes **********************************************/
>>>>  +static int tuf_kb_rgb_mode_check_present(struct asus_wmi *asus)
>>>>  +{
>>>>  +    u32 result;
>>>>  +    int err;
>>>>  +
>>>>  +    asus->tuf_kb_rgb_mode_available = false;
>>>>  +
>>>>  +    err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_TUF_RGB_MODE, &result);
>>>>  +    if (err) {
>>>>  +        if (err == -ENODEV)
>>>>  +            return 0;
>>>>  +        return err;
>>>>  +    }
>>>>  +
>>>>  +    if (result & ASUS_WMI_DSTS_PRESENCE_BIT)
>>>>  +        asus->tuf_kb_rgb_mode_available = true;
>>>>  +
>>>>  +    return 0;
>>>>  +}
>>>>  +
>>>>  +static ssize_t tuf_kb_rgb_mode_store(struct device *dev,
>>>>  +                 struct device_attribute *attr,
>>>>  +                 const char *buf, size_t count)
>>>>  +{
>>>>  +    int err;
>>>>  +    u32 ret;
>>>>  +    u8 res, tmp, arg_num;
>>>>  +    char *data, *part, *end;
>>>>  +    u8 cmd, mode, r, g,  b,  speed;
>>>>  +
>>>>  +    data = end = kstrdup(buf, GFP_KERNEL);
>>>>  +    cmd = mode = r = g = b = speed = arg_num = 0;
>>>>  +
>>>>  +    while ((part = strsep(&end, " ")) != NULL) {
>>>>  +        if (part == NULL)
>>>>  +            return -1;
>>>>  +
>>>>  +        res = kstrtou8(part, 10, &tmp);
>>>>  +        if (res)
>>>>  +            return -1;
>>>>  +
>>>>  +        if (arg_num == 0)
>>>>  +            // apply : set
>>>>  +            cmd = tmp == 1 ? 0xb5 : 0xb4;
>>>>  +        else if (arg_num == 1)
>>>>  +            // From 0-8 are valid modes with 10-12 being "warning"
>>>>  +            // style modes. All models have "pulse" mode 10.
>>>>  +            mode = (tmp <= 12 && tmp != 9) ? tmp : 10;
>>>>  +        else if (arg_num == 2)
>>>>  +            r = tmp;
>>>>  +        else if (arg_num == 3)
>>>>  +            g = tmp;
>>>>  +        else if (arg_num == 4)
>>>>  +            b = tmp;
>>>>  +        else if (arg_num == 5) {
>>>>  +            if (tmp == 0)
>>>>  +                speed = 0xe1;
>>>>  +            else if (tmp == 1)
>>>>  +                speed = 0xeb;
>>>>  +            else if (tmp == 2)
>>>>  +                speed = 0xf5;
>>>>  +        }
>>>>  +
>>>>  +        arg_num += 1;
>>>>  +    }
>>>>  +
>>>>  +    err = asus_wmi_evaluate_method3(ASUS_WMI_METHODID_DEVS, ASUS_WMI_DEVID_TUF_RGB_MODE,
>>>>  +            cmd | (mode << 8) | (r << 16) | (g << 24), (b) | (speed << 8), &ret);
>>>>  +    if (err)
>>>>  +        return err;
>>>>  +
>>>>  +    kfree(data);
>>>>  +    return count;
>>>>  +}
>>>>  +
>>>>  +static DEVICE_ATTR_WO(tuf_kb_rgb_mode);
>>>>  +
>>>>  +/* TUF Laptop Keyboard RGB States *********************************************/
>>>>  +static int tuf_kb_rgb_state_check_present(struct asus_wmi *asus)
>>>>  +{
>>>>  +    u32 result;
>>>>  +    int err;
>>>>  +
>>>>  +    asus->tuf_kb_rgb_state_available = false;
>>>>  +
>>>>  +    err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_TUF_RGB_STATE, &result);
>>>>  +    if (err) {
>>>>  +        if (err == -ENODEV)
>>>>  +            return 0;
>>>>  +        return err;
>>>>  +    }
>>>>  +
>>>>  +    if (result & ASUS_WMI_DSTS_PRESENCE_BIT)
>>>>  +        asus->tuf_kb_rgb_state_available = true;
>>>>  +
>>>>  +    return 0;
>>>>  +}
>>>>  +
>>>>  +static ssize_t tuf_kb_rgb_state_store(struct device *dev,
>>>>  +                   struct device_attribute *attr,
>>>>  +                   const char *buf, size_t count)
>>>>  +{
>>>>  +    int err;
>>>>  +    u32 ret;
>>>>  +    bool tmp;
>>>>  +    char *data, *part, *end;
>>>>  +    u8 save, flags, res, arg_num;
>>>>  +
>>>>  +    save = flags = arg_num = 0;
>>>>  +    data = end = kstrdup(buf, GFP_KERNEL);
>>>>  +
>>>>  +    while ((part = strsep(&end, " ")) != NULL) {
>>>>  +        if (part == NULL)
>>>>  +            return -1;
>>>>  +
>>>>  +        res = kstrtobool(part, &tmp);
>>>>  +        if (res)
>>>>  +            return -1;
>>>>  +
>>>>  +        if (tmp) {
>>>>  +            if (arg_num == 0) // save  :  set
>>>>  +                save = tmp == 0 ? 0x0100 : 0x0000;
>>>>  +            else if (arg_num == 1)
>>>>  +                flags |= 0x02; // boot
>>>>  +            else if (arg_num == 2)
>>>>  +                flags |= 0x08; // awake
>>>>  +            else if (arg_num == 3)
>>>>  +                flags |= 0x20; // sleep
>>>>  +            else if (arg_num == 4)
>>>>  +                flags |= 0x80; // keyboard
>>>>  +        }
>>>>  +
>>>>  +        arg_num += 1;
>>>>  +    }
>>>>  +
>>>>  +    err = asus_wmi_evaluate_method3(ASUS_WMI_METHODID_DEVS,
>>>>  +            ASUS_WMI_DEVID_TUF_RGB_STATE, 0xBD | save | (flags << 16), 0, &ret);
>>>>  +    if (err)
>>>>  +        return err;
>>>>  +
>>>>  +    kfree(data);
>>>>  +    return count;
>>>>  +}
>>>>  +
>>>>  +static DEVICE_ATTR_WO(tuf_kb_rgb_state);
>>>>  +
>>>>   /* Battery ********************************************************************/
>>>>
>>>>   /* The battery maximum charging percentage */
>>>>  @@ -3258,6 +3408,8 @@ static struct attribute *platform_attributes[] = {
>>>>       &dev_attr_touchpad.attr,
>>>>       &dev_attr_egpu_enable.attr,
>>>>       &dev_attr_dgpu_disable.attr,
>>>>  +    &dev_attr_tuf_kb_rgb_mode.attr,
>>>>  +    &dev_attr_tuf_kb_rgb_state.attr,
>>>>       &dev_attr_lid_resume.attr,
>>>>       &dev_attr_als_enable.attr,
>>>>       &dev_attr_fan_boost_mode.attr,
>>>>  @@ -3286,6 +3438,12 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
>>>>           devid = ASUS_WMI_DEVID_ALS_ENABLE;
>>>>       else if (attr == &dev_attr_egpu_enable.attr)
>>>>           ok = asus->egpu_enable_available;
>>>>  +    else if (attr == &dev_attr_tuf_kb_rgb_mode.attr)
>>>>  +        ok = asus->tuf_kb_rgb_mode_available;
>>>>  +    else if (attr == &dev_attr_tuf_kb_rgb_state.attr)
>>>>  +        ok = asus->tuf_kb_rgb_state_available;
>>>>  +    else if (attr == &dev_attr_dgpu_disable.attr)
>>>>  +        ok = asus->dgpu_disable_available;
>>>>       else if (attr == &dev_attr_dgpu_disable.attr)
>>>>           ok = asus->dgpu_disable_available;
>>>>       else if (attr == &dev_attr_fan_boost_mode.attr)
>>>>  @@ -3557,6 +3715,14 @@ static int asus_wmi_add(struct platform_device *pdev)
>>>>       if (err)
>>>>           goto fail_dgpu_disable;
>>>>
>>>>  +    err = tuf_kb_rgb_mode_check_present(asus);
>>>>  +    if (err)
>>>>  +        goto fail_tuf_kb_rgb_mode;
>>>>  +
>>>>  +    err = tuf_kb_rgb_state_check_present(asus);
>>>>  +    if (err)
>>>>  +        goto fail_tuf_kb_rgb_state;
>>>>  +
>>>>       err = fan_boost_mode_check_present(asus);
>>>>       if (err)
>>>>           goto fail_fan_boost_mode;
>>>>  @@ -3671,6 +3837,8 @@ static int asus_wmi_add(struct platform_device *pdev)
>>>>   fail_fan_boost_mode:
>>>>   fail_egpu_enable:
>>>>   fail_dgpu_disable:
>>>>  +fail_tuf_kb_rgb_mode:
>>>>  +fail_tuf_kb_rgb_state:
>>>>   fail_platform:
>>>>   fail_panel_od:
>>>>       kfree(asus);
>>>>  diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
>>>>  index a571b47ff362..af4191fb0508 100644
>>>>  --- a/include/linux/platform_data/x86/asus-wmi.h
>>>>  +++ b/include/linux/platform_data/x86/asus-wmi.h
>>>>  @@ -98,6 +98,12 @@
>>>>   /* dgpu on/off */
>>>>   #define ASUS_WMI_DEVID_DGPU        0x00090020
>>>>
>>>>  +/* TUF laptop RGB modes/colours */
>>>>  +#define ASUS_WMI_DEVID_TUF_RGB_MODE    0x00100056
>>>>  +
>>>>  +/* TUF laptop RGB power/state */
>>>>  +#define ASUS_WMI_DEVID_TUF_RGB_STATE    0x00100057
>>>>  +
>>>>   /* DSTS masks */
>>>>   #define ASUS_WMI_DSTS_STATUS_BIT    0x00000001
>>>>   #define ASUS_WMI_DSTS_UNKNOWN_BIT    0x00000002
>>
> 
> 

