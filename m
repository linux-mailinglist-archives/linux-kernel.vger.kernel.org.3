Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B815A1ABD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 23:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbiHYVCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 17:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243646AbiHYVB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 17:01:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A40B14F1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 14:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661461306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZccaYkMry3RxMZ99ND8Fk/NXsxoLv+/F79ThHFopAZE=;
        b=VIOdyTkpmFvoqzWmZa5X0aS7mXznimd96C/1EODPnXKkB/xzRErUTQX+8JpT9+1Wud6Eic
        b2AZ3OVJP61TrYkzr+pTkgIT4kOFy2ZXVW44nz5ham+EqSZjVgZtfUPI/icLXYHQJxsEsQ
        LuTx/hCktLoGf7SR3vPlG03trQXsqf0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-70-Mq6USaZKNJuHgZs3fGhRog-1; Thu, 25 Aug 2022 17:01:44 -0400
X-MC-Unique: Mq6USaZKNJuHgZs3fGhRog-1
Received: by mail-ed1-f69.google.com with SMTP id y14-20020a056402440e00b0044301c7ccd9so13479708eda.19
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 14:01:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ZccaYkMry3RxMZ99ND8Fk/NXsxoLv+/F79ThHFopAZE=;
        b=xG5A6re0WASN5MuwPilhbfoKtAHmoRPo0c2ux1LClWiFehMZqWnhsx1iPvOu7uFdBP
         nMgosMWWzP0B7Ii20T3ECdd1eEZ/ZgBT0KxiS5a4DXo0Qf47EkaQKQIJUuvZ+A+UFHV2
         KK4c9mG1zUlVd7MnRE6UDkFQZvxzMfH/JwrqvLJstIGY7QHWdn8gw5qlIIpadisoxRiM
         PHcw5EeVWYqV1iRwWHMMklR2yjgoXfkN+SKDEI76hbeGBCFzNFFr1wQe5CY48TFkOylD
         PWI9M1vH99x4oIgDLfopFPNXK+l2cmlwqvJAtDevSQlLDOg1If/10OI5zTIG/H+Js8NF
         B4jw==
X-Gm-Message-State: ACgBeo1rOWA2Dhpi9KQ988KHpGM9aaypCigsT0fGFaYZTimyktIucp9O
        IHlLwD11Gu7pKZwZT/8vkRCZSk4Ldk/4t2WQCFAV6xHrJl/7f3YnLfd6QiKM5thoXF7DeDJv2lR
        BP2R61frv2Uuctav3sWb91n7F
X-Received: by 2002:aa7:cdcc:0:b0:447:bac0:4c20 with SMTP id h12-20020aa7cdcc000000b00447bac04c20mr3492220edw.183.1661461303248;
        Thu, 25 Aug 2022 14:01:43 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5LSFnJRE+1rcn7cDkRpGQA4Ro3QfLFXht+CWSKYX9oE8D98shMiJUsBEtxye3/sIY6D1CePA==
X-Received: by 2002:aa7:cdcc:0:b0:447:bac0:4c20 with SMTP id h12-20020aa7cdcc000000b00447bac04c20mr3492208edw.183.1661461302952;
        Thu, 25 Aug 2022 14:01:42 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id z3-20020a170906668300b0073d796a1043sm86983ejo.123.2022.08.25.14.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 14:01:42 -0700 (PDT)
Message-ID: <737e34f6-298d-fcf9-ef81-cd81fb0279e3@redhat.com>
Date:   Thu, 25 Aug 2022 23:01:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/2] asus-wmi: Adjust tablet/lidflip handling to use enum
Content-Language: en-US
To:     Luke Jones <luke@ljones.dev>
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220813092753.6635-1-luke@ljones.dev>
 <b2ce575a-470c-5a56-2cd0-9f3e7dbac1ad@redhat.com>
 <G7V6HR.3WZF23WP4MCJ3@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <G7V6HR.3WZF23WP4MCJ3@ljones.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/25/22 22:50, Luke Jones wrote:
> 
> 
> On Wed, Aug 24 2022 at 16:12:42 +0200, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 8/13/22 11:27, Luke D. Jones wrote:
>>>  Due to multiple types of tablet/lidflip, the existing code for
>>>  handling these events is refactored to use an enum for each type.
>>>
>>>  Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>
>> Thank you for the patch, I've merged this but with one change:
>>
>>>  ---
>>>   drivers/platform/x86/asus-nb-wmi.c | 13 +++---
>>>   drivers/platform/x86/asus-wmi.c    | 67 ++++++++++++++++++++----------
>>>   drivers/platform/x86/asus-wmi.h    |  9 +++-
>>>   3 files changed, 58 insertions(+), 31 deletions(-)
>>>
>>>  diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
>>>  index a81dc4b191b7..3a93e056c4e1 100644
>>>  --- a/drivers/platform/x86/asus-nb-wmi.c
>>>  +++ b/drivers/platform/x86/asus-nb-wmi.c
>>>  @@ -115,12 +115,12 @@ static struct quirk_entry quirk_asus_forceals = {
>>>   };
>>>
>>>   static struct quirk_entry quirk_asus_use_kbd_dock_devid = {
>>>  -    .use_kbd_dock_devid = true,
>>>  +    .tablet_switch_mode = asus_wmi_kbd_dock_devid,
>>>   };
>>>
>>>   static struct quirk_entry quirk_asus_use_lid_flip_devid = {
>>>       .wmi_backlight_set_devstate = true,
>>>  -    .use_lid_flip_devid = true,
>>>  +    .tablet_switch_mode = asus_wmi_lid_flip_devid,
>>>   };
>>>
>>>   static int dmi_matched(const struct dmi_system_id *dmi)
>>>  @@ -492,16 +492,13 @@ static void asus_nb_wmi_quirks(struct asus_wmi_driver *driver)
>>>
>>>       switch (tablet_mode_sw) {
>>>       case 0:
>>>  -        quirks->use_kbd_dock_devid = false;
>>>  -        quirks->use_lid_flip_devid = false;
>>>  +        quirks->tablet_switch_mode = asus_wmi_no_tablet_switch;
>>>           break;
>>>       case 1:
>>>  -        quirks->use_kbd_dock_devid = true;
>>>  -        quirks->use_lid_flip_devid = false;
>>>  +        quirks->tablet_switch_mode = asus_wmi_kbd_dock_devid;
>>>           break;
>>>       case 2:
>>>  -        quirks->use_kbd_dock_devid = false;
>>>  -        quirks->use_lid_flip_devid = true;
>>>  +        quirks->tablet_switch_mode = asus_wmi_lid_flip_devid;
>>>           break;
>>>       }
>>>
>>>  diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
>>>  index 0421ffb81927..b4690ac39147 100644
>>>  --- a/drivers/platform/x86/asus-wmi.c
>>>  +++ b/drivers/platform/x86/asus-wmi.c
>>>  @@ -485,8 +485,11 @@ static bool asus_wmi_dev_is_present(struct asus_wmi *asus, u32 dev_id)
>>>
>>>   static int asus_wmi_input_init(struct asus_wmi *asus)
>>>   {
>>>  +    struct device *dev;
>>>       int err, result;
>>>
>>>  +    dev = &asus->platform_device->dev;
>>>  +
>>>       asus->inputdev = input_allocate_device();
>>>       if (!asus->inputdev)
>>>           return -ENOMEM;
>>>  @@ -494,35 +497,38 @@ static int asus_wmi_input_init(struct asus_wmi *asus)
>>>       asus->inputdev->name = asus->driver->input_name;
>>>       asus->inputdev->phys = asus->driver->input_phys;
>>>       asus->inputdev->id.bustype = BUS_HOST;
>>>  -    asus->inputdev->dev.parent = &asus->platform_device->dev;
>>>  +    asus->inputdev->dev.parent = dev;
>>>       set_bit(EV_REP, asus->inputdev->evbit);
>>>
>>>       err = sparse_keymap_setup(asus->inputdev, asus->driver->keymap, NULL);
>>>       if (err)
>>>           goto err_free_dev;
>>>
>>>  -    if (asus->driver->quirks->use_kbd_dock_devid) {
>>>  +    switch (asus->driver->quirks->tablet_switch_mode) {
>>>  +    case asus_wmi_no_tablet_switch:
>>>  +        break;
>>>  +    case asus_wmi_kbd_dock_devid:
>>>           result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_KBD_DOCK);
>>>           if (result >= 0) {
>>>               input_set_capability(asus->inputdev, EV_SW, SW_TABLET_MODE);
>>>               input_report_switch(asus->inputdev, SW_TABLET_MODE, !result);
>>>           } else if (result != -ENODEV) {
>>>  -            pr_err("Error checking for keyboard-dock: %d\n", result);
>>>  +            dev_err(dev, "Error checking for keyboard-dock: %d\n", result);
>>>           }
>>>  -    }
>>>  -
>>>  -    if (asus->driver->quirks->use_lid_flip_devid) {
>>>  +        break;
>>>  +    case asus_wmi_lid_flip_devid:
>>>           result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_LID_FLIP);
>>>           if (result < 0)
>>>  -            asus->driver->quirks->use_lid_flip_devid = 0;
>>>  +            asus->driver->quirks->tablet_switch_mode = asus_wmi_no_tablet_switch;
>>>           if (result >= 0) {
>>>               input_set_capability(asus->inputdev, EV_SW, SW_TABLET_MODE);
>>>               input_report_switch(asus->inputdev, SW_TABLET_MODE, result);
>>>           } else if (result == -ENODEV) {
>>>  -            pr_err("This device has lid_flip quirk but got ENODEV checking it. This is a bug.");
>>>  +            dev_err(dev, "This device has lid_flip quirk but got ENODEV checking it. This is a bug.");
>>>           } else {
>>>  -            pr_err("Error checking for lid-flip: %d\n", result);
>>>  +            dev_err(dev, "Error checking for lid-flip: %d\n", result);
>>>           }
>>>  +        break;
>>>       }
>>>
>>>       err = input_register_device(asus->inputdev);
>>>  @@ -548,8 +554,9 @@ static void asus_wmi_input_exit(struct asus_wmi *asus)
>>>
>>>   static void lid_flip_tablet_mode_get_state(struct asus_wmi *asus)
>>>   {
>>>  -    int result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_LID_FLIP);
>>>  +    int result;
>>>
>>>  +    result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_LID_FLIP);
>>>       if (result >= 0) {
>>>           input_report_switch(asus->inputdev, SW_TABLET_MODE, result);
>>>           input_sync(asus->inputdev);
>>>  @@ -3044,20 +3051,26 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
>>>           return;
>>>       }
>>>
>>>  -    if (asus->driver->quirks->use_kbd_dock_devid && code == NOTIFY_KBD_DOCK_CHANGE) {
>>
>> Given that we need to check for both the tablet_switch_mode as well as
>> different event codes, I believe that keep using something like:
>>
>>     if (asus->driver->quirks->tablet_switch_mode == asus_wmi_kbd_dock_devid &&
>>         code == NOTIFY_KBD_DOCK_CHANGE) {
>>
>> here is better then doing a switch-case with the code checkes nested under
> 
> I think I recall that Andy requested use of the switch/case but I might be wrong.

Yeah, or maybe it was me even who asked that :)  The code is not really
ideal in either form.

So as you've probably seen from the Cc I've done some further cleanup
unifying the handling of all 3 tablet-mode-switch types.

Those extra cleanup patches are also in my review-hans branch now.

Regards,

Hans





> 
>>
>>>  -        result = asus_wmi_get_devstate_simple(asus,
>>>  -                              ASUS_WMI_DEVID_KBD_DOCK);
>>>  +    switch (asus->driver->quirks->tablet_switch_mode) {
>>>  +    case asus_wmi_no_tablet_switch:
>>>  +        break;
>>>  +    case asus_wmi_kbd_dock_devid:
>>>  +        if (code == NOTIFY_KBD_DOCK_CHANGE) {
>>>  +            result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_KBD_DOCK);
>>>           if (result >= 0) {
>>>               input_report_switch(asus->inputdev, SW_TABLET_MODE,
>>
>> Note the indent of these 2 lines is wrong now, it should be indentend one
>> extra step because it is inside the if (code == NOTIFY_KBD_DOCK_CHANGE) {
>> block now, sticking with a:
>>
>>     if (asus->driver->quirks->tablet_switch_mode == asus_wmi_kbd_dock_devid &&
>>         code == NOTIFY_KBD_DOCK_CHANGE) {
>>
>> is style instead of nesting avoids the need for this extra indentation.
>>
>> I have fixed this up while merging the patches.
>>
>> Regards,
>>
>> Hans
>>
>>
>>
>>
>>>  -                        !result);
>>>  +                        !result);
>>>               input_sync(asus->inputdev);
>>>           }
>>>           return;
>>>  -    }
>>>  -
>>>  -    if (asus->driver->quirks->use_lid_flip_devid && code == NOTIFY_LID_FLIP) {
>>>  -        lid_flip_tablet_mode_get_state(asus);
>>>  -        return;
>>>  +        }
>>>  +        break;
>>>  +    case asus_wmi_lid_flip_devid:
>>>  +        if (code == NOTIFY_LID_FLIP) {
>>>  +            lid_flip_tablet_mode_get_state(asus);
>>>  +            return;
>>>  +        }
>>>  +        break;
>>>       }
>>>
>>>       if (asus->fan_boost_mode_available && code == NOTIFY_KBD_FBM) {
>>>  @@ -3700,8 +3713,14 @@ static int asus_hotk_resume(struct device *device)
>>>       if (asus_wmi_has_fnlock_key(asus))
>>>           asus_wmi_fnlock_update(asus);
>>>
>>>  -    if (asus->driver->quirks->use_lid_flip_devid)
>>>  +    switch (asus->driver->quirks->tablet_switch_mode) {
>>>  +    case asus_wmi_no_tablet_switch:
>>>  +    case asus_wmi_kbd_dock_devid:
>>>  +        break;
>>>  +    case asus_wmi_lid_flip_devid:
>>>           lid_flip_tablet_mode_get_state(asus);
>>>  +        break;
>>>  +    }
>>>
>>>       return 0;
>>>   }
>>>  @@ -3742,8 +3761,14 @@ static int asus_hotk_restore(struct device *device)
>>>       if (asus_wmi_has_fnlock_key(asus))
>>>           asus_wmi_fnlock_update(asus);
>>>
>>>  -    if (asus->driver->quirks->use_lid_flip_devid)
>>>  +    switch (asus->driver->quirks->tablet_switch_mode) {
>>>  +    case asus_wmi_no_tablet_switch:
>>>  +    case asus_wmi_kbd_dock_devid:
>>>  +        break;
>>>  +    case asus_wmi_lid_flip_devid:
>>>           lid_flip_tablet_mode_get_state(asus);
>>>  +        break;
>>>  +    }
>>>
>>>       return 0;
>>>   }
>>>  diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-wmi.h
>>>  index b302415bf1d9..413920bad0c6 100644
>>>  --- a/drivers/platform/x86/asus-wmi.h
>>>  +++ b/drivers/platform/x86/asus-wmi.h
>>>  @@ -25,6 +25,12 @@ struct module;
>>>   struct key_entry;
>>>   struct asus_wmi;
>>>
>>>  +enum asus_wmi_tablet_switch_mode {
>>>  +    asus_wmi_no_tablet_switch,
>>>  +    asus_wmi_kbd_dock_devid,
>>>  +    asus_wmi_lid_flip_devid,
>>>  +};
>>>  +
>>>   struct quirk_entry {
>>>       bool hotplug_wireless;
>>>       bool scalar_panel_brightness;
>>>  @@ -33,8 +39,7 @@ struct quirk_entry {
>>>       bool wmi_backlight_native;
>>>       bool wmi_backlight_set_devstate;
>>>       bool wmi_force_als_set;
>>>  -    bool use_kbd_dock_devid;
>>>  -    bool use_lid_flip_devid;
>>>  +    enum asus_wmi_tablet_switch_mode tablet_switch_mode;
>>>       int wapf;
>>>       /*
>>>        * For machines with AMD graphic chips, it will send out WMI event
>>
> 
> 

