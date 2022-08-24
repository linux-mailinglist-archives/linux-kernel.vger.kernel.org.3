Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D8B59FCF1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 16:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237168AbiHXOMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 10:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237850AbiHXOMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 10:12:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44ACE97529
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 07:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661350367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yCkPSzN/cwsCtf3kYco4CiqtD7edlWebFhcM0DlPaBI=;
        b=OD7KgqRyBkLrsuoMcpXW+dldbxZa9cvEadB9fR4WHbMDlKHG/cbSqh1wRDF/o5FXJqfe6p
        5PbVPPItvaJrdJ6wpeEFGpmR1O+SjRkEznFxjiHjvz76YlSuMYM8uLv3yZqZxfZfO3Y9Cd
        5ztBP0F9mRJkvpl/10letQKPfJhUE/Y=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-479-Wix4RwChNPmd_Yz4YaN4Gw-1; Wed, 24 Aug 2022 10:12:46 -0400
X-MC-Unique: Wix4RwChNPmd_Yz4YaN4Gw-1
Received: by mail-ej1-f70.google.com with SMTP id hb37-20020a170907162500b0073d7f7fbbbfso3086104ejc.17
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 07:12:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=yCkPSzN/cwsCtf3kYco4CiqtD7edlWebFhcM0DlPaBI=;
        b=XTgxcKoQfIvtVa4rSy1Ne4pDtmap451+o2Jgg50TS+pgB6RSNrb63QiSpPumUFaBEU
         sY53QrYiJA83dNWruNqbd+F/fCiUbxTpiceCxdIIQuMP/pZdp3MXjj+GW1RjM0m6t0p8
         CIc3csGYD7BMUyXxbesBOND6zPWEccr7tyX0mv/ChrbqU9FkP+oZgkvktIJzJPumOdwA
         H6d2s/3MekX1LIbCNnobUlT8FbYXrFqbTJ4LrE+sARa9Eh04Li0lB1G15GC1fbO+nwym
         vN1/jFEoy1bjoBzZ8JxggiLVn92X7rUI6xxKCAvRqkly+MRrHzy4IzGMRacVv1pvtny9
         cEnA==
X-Gm-Message-State: ACgBeo2jvxQ/xVfVGpesfewVodhJ+aW136uchJKSoJ+jQetwGM/AWPmv
        TSrb/OEpFIzdpCS98seLdhntmZufM+7hqQV7bnL81WhWSmcBLFFyjzAYnoDotCRZAvprojdqkOv
        rYQHLiqkatlbVT43O0J0iPyrb
X-Received: by 2002:a17:907:808:b0:730:54cc:b597 with SMTP id wv8-20020a170907080800b0073054ccb597mr2985282ejb.434.1661350364079;
        Wed, 24 Aug 2022 07:12:44 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7ZdzW3McIYOgkJWgU5B4o8yxCDFDqU2e+Hks72wJw0+TwESjmYyLmaMHvttgGx9y0Skf8+Wg==
X-Received: by 2002:a17:907:808:b0:730:54cc:b597 with SMTP id wv8-20020a170907080800b0073054ccb597mr2985272ejb.434.1661350363776;
        Wed, 24 Aug 2022 07:12:43 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id k15-20020a1709063e0f00b0073c1e339a37sm1209290eji.149.2022.08.24.07.12.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 07:12:43 -0700 (PDT)
Message-ID: <b2ce575a-470c-5a56-2cd0-9f3e7dbac1ad@redhat.com>
Date:   Wed, 24 Aug 2022 16:12:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/2] asus-wmi: Adjust tablet/lidflip handling to use enum
Content-Language: en-US
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220813092753.6635-1-luke@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220813092753.6635-1-luke@ljones.dev>
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

Hi,

On 8/13/22 11:27, Luke D. Jones wrote:
> Due to multiple types of tablet/lidflip, the existing code for
> handling these events is refactored to use an enum for each type.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>

Thank you for the patch, I've merged this but with one change:

> ---
>  drivers/platform/x86/asus-nb-wmi.c | 13 +++---
>  drivers/platform/x86/asus-wmi.c    | 67 ++++++++++++++++++++----------
>  drivers/platform/x86/asus-wmi.h    |  9 +++-
>  3 files changed, 58 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
> index a81dc4b191b7..3a93e056c4e1 100644
> --- a/drivers/platform/x86/asus-nb-wmi.c
> +++ b/drivers/platform/x86/asus-nb-wmi.c
> @@ -115,12 +115,12 @@ static struct quirk_entry quirk_asus_forceals = {
>  };
>  
>  static struct quirk_entry quirk_asus_use_kbd_dock_devid = {
> -	.use_kbd_dock_devid = true,
> +	.tablet_switch_mode = asus_wmi_kbd_dock_devid,
>  };
>  
>  static struct quirk_entry quirk_asus_use_lid_flip_devid = {
>  	.wmi_backlight_set_devstate = true,
> -	.use_lid_flip_devid = true,
> +	.tablet_switch_mode = asus_wmi_lid_flip_devid,
>  };
>  
>  static int dmi_matched(const struct dmi_system_id *dmi)
> @@ -492,16 +492,13 @@ static void asus_nb_wmi_quirks(struct asus_wmi_driver *driver)
>  
>  	switch (tablet_mode_sw) {
>  	case 0:
> -		quirks->use_kbd_dock_devid = false;
> -		quirks->use_lid_flip_devid = false;
> +		quirks->tablet_switch_mode = asus_wmi_no_tablet_switch;
>  		break;
>  	case 1:
> -		quirks->use_kbd_dock_devid = true;
> -		quirks->use_lid_flip_devid = false;
> +		quirks->tablet_switch_mode = asus_wmi_kbd_dock_devid;
>  		break;
>  	case 2:
> -		quirks->use_kbd_dock_devid = false;
> -		quirks->use_lid_flip_devid = true;
> +		quirks->tablet_switch_mode = asus_wmi_lid_flip_devid;
>  		break;
>  	}
>  
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 0421ffb81927..b4690ac39147 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -485,8 +485,11 @@ static bool asus_wmi_dev_is_present(struct asus_wmi *asus, u32 dev_id)
>  
>  static int asus_wmi_input_init(struct asus_wmi *asus)
>  {
> +	struct device *dev;
>  	int err, result;
>  
> +	dev = &asus->platform_device->dev;
> +
>  	asus->inputdev = input_allocate_device();
>  	if (!asus->inputdev)
>  		return -ENOMEM;
> @@ -494,35 +497,38 @@ static int asus_wmi_input_init(struct asus_wmi *asus)
>  	asus->inputdev->name = asus->driver->input_name;
>  	asus->inputdev->phys = asus->driver->input_phys;
>  	asus->inputdev->id.bustype = BUS_HOST;
> -	asus->inputdev->dev.parent = &asus->platform_device->dev;
> +	asus->inputdev->dev.parent = dev;
>  	set_bit(EV_REP, asus->inputdev->evbit);
>  
>  	err = sparse_keymap_setup(asus->inputdev, asus->driver->keymap, NULL);
>  	if (err)
>  		goto err_free_dev;
>  
> -	if (asus->driver->quirks->use_kbd_dock_devid) {
> +	switch (asus->driver->quirks->tablet_switch_mode) {
> +	case asus_wmi_no_tablet_switch:
> +		break;
> +	case asus_wmi_kbd_dock_devid:
>  		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_KBD_DOCK);
>  		if (result >= 0) {
>  			input_set_capability(asus->inputdev, EV_SW, SW_TABLET_MODE);
>  			input_report_switch(asus->inputdev, SW_TABLET_MODE, !result);
>  		} else if (result != -ENODEV) {
> -			pr_err("Error checking for keyboard-dock: %d\n", result);
> +			dev_err(dev, "Error checking for keyboard-dock: %d\n", result);
>  		}
> -	}
> -
> -	if (asus->driver->quirks->use_lid_flip_devid) {
> +		break;
> +	case asus_wmi_lid_flip_devid:
>  		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_LID_FLIP);
>  		if (result < 0)
> -			asus->driver->quirks->use_lid_flip_devid = 0;
> +			asus->driver->quirks->tablet_switch_mode = asus_wmi_no_tablet_switch;
>  		if (result >= 0) {
>  			input_set_capability(asus->inputdev, EV_SW, SW_TABLET_MODE);
>  			input_report_switch(asus->inputdev, SW_TABLET_MODE, result);
>  		} else if (result == -ENODEV) {
> -			pr_err("This device has lid_flip quirk but got ENODEV checking it. This is a bug.");
> +			dev_err(dev, "This device has lid_flip quirk but got ENODEV checking it. This is a bug.");
>  		} else {
> -			pr_err("Error checking for lid-flip: %d\n", result);
> +			dev_err(dev, "Error checking for lid-flip: %d\n", result);
>  		}
> +		break;
>  	}
>  
>  	err = input_register_device(asus->inputdev);
> @@ -548,8 +554,9 @@ static void asus_wmi_input_exit(struct asus_wmi *asus)
>  
>  static void lid_flip_tablet_mode_get_state(struct asus_wmi *asus)
>  {
> -	int result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_LID_FLIP);
> +	int result;
>  
> +	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_LID_FLIP);
>  	if (result >= 0) {
>  		input_report_switch(asus->inputdev, SW_TABLET_MODE, result);
>  		input_sync(asus->inputdev);
> @@ -3044,20 +3051,26 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
>  		return;
>  	}
>  
> -	if (asus->driver->quirks->use_kbd_dock_devid && code == NOTIFY_KBD_DOCK_CHANGE) {

Given that we need to check for both the tablet_switch_mode as well as
different event codes, I believe that keep using something like:

	if (asus->driver->quirks->tablet_switch_mode == asus_wmi_kbd_dock_devid &&
	    code == NOTIFY_KBD_DOCK_CHANGE) {

here is better then doing a switch-case with the code checkes nested under

> -		result = asus_wmi_get_devstate_simple(asus,
> -						      ASUS_WMI_DEVID_KBD_DOCK);
> +	switch (asus->driver->quirks->tablet_switch_mode) {
> +	case asus_wmi_no_tablet_switch:
> +		break;
> +	case asus_wmi_kbd_dock_devid:
> +		if (code == NOTIFY_KBD_DOCK_CHANGE) {
> +			result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_KBD_DOCK);
>  		if (result >= 0) {
>  			input_report_switch(asus->inputdev, SW_TABLET_MODE,

Note the indent of these 2 lines is wrong now, it should be indentend one
extra step because it is inside the if (code == NOTIFY_KBD_DOCK_CHANGE) {
block now, sticking with a:

	if (asus->driver->quirks->tablet_switch_mode == asus_wmi_kbd_dock_devid &&
	    code == NOTIFY_KBD_DOCK_CHANGE) {

is style instead of nesting avoids the need for this extra indentation.

I have fixed this up while merging the patches.

Regards,

Hans




> -					    !result);
> +						!result);
>  			input_sync(asus->inputdev);
>  		}
>  		return;
> -	}
> -
> -	if (asus->driver->quirks->use_lid_flip_devid && code == NOTIFY_LID_FLIP) {
> -		lid_flip_tablet_mode_get_state(asus);
> -		return;
> +		}
> +		break;
> +	case asus_wmi_lid_flip_devid:
> +		if (code == NOTIFY_LID_FLIP) {
> +			lid_flip_tablet_mode_get_state(asus);
> +			return;
> +		}
> +		break;
>  	}
>  
>  	if (asus->fan_boost_mode_available && code == NOTIFY_KBD_FBM) {
> @@ -3700,8 +3713,14 @@ static int asus_hotk_resume(struct device *device)
>  	if (asus_wmi_has_fnlock_key(asus))
>  		asus_wmi_fnlock_update(asus);
>  
> -	if (asus->driver->quirks->use_lid_flip_devid)
> +	switch (asus->driver->quirks->tablet_switch_mode) {
> +	case asus_wmi_no_tablet_switch:
> +	case asus_wmi_kbd_dock_devid:
> +		break;
> +	case asus_wmi_lid_flip_devid:
>  		lid_flip_tablet_mode_get_state(asus);
> +		break;
> +	}
>  
>  	return 0;
>  }
> @@ -3742,8 +3761,14 @@ static int asus_hotk_restore(struct device *device)
>  	if (asus_wmi_has_fnlock_key(asus))
>  		asus_wmi_fnlock_update(asus);
>  
> -	if (asus->driver->quirks->use_lid_flip_devid)
> +	switch (asus->driver->quirks->tablet_switch_mode) {
> +	case asus_wmi_no_tablet_switch:
> +	case asus_wmi_kbd_dock_devid:
> +		break;
> +	case asus_wmi_lid_flip_devid:
>  		lid_flip_tablet_mode_get_state(asus);
> +		break;
> +	}
>  
>  	return 0;
>  }
> diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-wmi.h
> index b302415bf1d9..413920bad0c6 100644
> --- a/drivers/platform/x86/asus-wmi.h
> +++ b/drivers/platform/x86/asus-wmi.h
> @@ -25,6 +25,12 @@ struct module;
>  struct key_entry;
>  struct asus_wmi;
>  
> +enum asus_wmi_tablet_switch_mode {
> +	asus_wmi_no_tablet_switch,
> +	asus_wmi_kbd_dock_devid,
> +	asus_wmi_lid_flip_devid,
> +};
> +
>  struct quirk_entry {
>  	bool hotplug_wireless;
>  	bool scalar_panel_brightness;
> @@ -33,8 +39,7 @@ struct quirk_entry {
>  	bool wmi_backlight_native;
>  	bool wmi_backlight_set_devstate;
>  	bool wmi_force_als_set;
> -	bool use_kbd_dock_devid;
> -	bool use_lid_flip_devid;
> +	enum asus_wmi_tablet_switch_mode tablet_switch_mode;
>  	int wapf;
>  	/*
>  	 * For machines with AMD graphic chips, it will send out WMI event

