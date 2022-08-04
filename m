Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1A4589D11
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 15:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239979AbiHDNvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 09:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239970AbiHDNvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 09:51:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC81433366
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 06:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659621087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p8+RdXb3SVSCQE0FoiCgn19MOlLWR1wWbMmC0Jpc63c=;
        b=a3ZJSvLaO6LNMnDIMCaUhVJPz4+CjzpeNRqbSRL+ZPNq5pKuYvk9vNLCPmwgVDg9OvRHfn
        F6L9GZ2OHKO4S1TqMeDLe4jlY0AyLLkB5PoKQqSeQttwz2MTH3XMmTf3eVfQ2PDuquM3hn
        e6/YekfeF3NqJU2GYsx364TT58DUWyQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-572-j8RWL-y2N_iiU9Hjwc5mJQ-1; Thu, 04 Aug 2022 09:51:26 -0400
X-MC-Unique: j8RWL-y2N_iiU9Hjwc5mJQ-1
Received: by mail-ed1-f72.google.com with SMTP id n8-20020a05640205c800b00434fb0c150cso13084555edx.19
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 06:51:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=p8+RdXb3SVSCQE0FoiCgn19MOlLWR1wWbMmC0Jpc63c=;
        b=kxuo/iPfBI1UBYg1CNgibtM2MMj5tkfiCSzpe7saUSnqMbyXvZGSAoo0JnmxwYEdvu
         a9U4+XSw9JGfBVbVeFUrKrEArKFeM5pZ1qDdIQVWhXBNkOljdJ3nXZUuoR5pbU/AagKC
         bGMBkZB+VqZx11grjgI8mn59Qk1wWBAn9p+jYitxoxAk9BDsFOrBA8kgK+MPCJxOOSLF
         wJWGUhEwADyKuF6UOVzCbA9fKhmfhQ6jmuhl+NhzBl94sKo7cqDT0ED7DpaqDbtab5ua
         bLvsDsFdZVIPWwn8S4T1GDzBoBByTW1vyMoj1ohRcovUJ3JaSZKbgM/R9Y3gbiYQZkqc
         CGoA==
X-Gm-Message-State: ACgBeo1VB5zrG05IQSfo/dzMtoIlZP4qPvjl/tls5Xoo2rW+7cKBGP/b
        om+3GwKfc0u/YRpGEvadpzO9fWhSh4Fiw7DbVvzM5wNfZUoHMT+u8DltMIVCFJImd9vM3gGR2Tq
        RH/nXbrORONGiTnxzx6Ji56Er
X-Received: by 2002:a05:6402:520e:b0:43d:df14:fbed with SMTP id s14-20020a056402520e00b0043ddf14fbedmr2166728edd.16.1659621084938;
        Thu, 04 Aug 2022 06:51:24 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5oCIwyTmXQG2eF5PzBUmTe6O6UYPtELn2RAcd1jX3AYGDvD6y5A2cpBfw7lB8bBAwJEmrBDQ==
X-Received: by 2002:a05:6402:520e:b0:43d:df14:fbed with SMTP id s14-20020a056402520e00b0043ddf14fbedmr2166704edd.16.1659621084709;
        Thu, 04 Aug 2022 06:51:24 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id fj19-20020a0564022b9300b0043bbbaa323dsm712071edb.0.2022.08.04.06.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 06:51:23 -0700 (PDT)
Message-ID: <d9d79f9b-f3ab-c07e-9e18-5760ff828487@redhat.com>
Date:   Thu, 4 Aug 2022 15:51:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/1] asus-wmi: Add support for ROG X13 tablet mode
Content-Language: en-US
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220803063734.765614-1-luke@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220803063734.765614-1-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/3/22 08:37, Luke D. Jones wrote:
> Add quirk for ASUS ROG X13 Flow 2-in-1 to enable tablet mode with
> lid flip (all screen rotations).
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/platform/x86/asus-nb-wmi.c         | 16 ++++++++++++++++
>  drivers/platform/x86/asus-wmi.c            | 16 +++++++++++++++-
>  drivers/platform/x86/asus-wmi.h            |  1 +
>  include/linux/platform_data/x86/asus-wmi.h |  1 +
>  4 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
> index 478dd300b9c9..1ce8924d0474 100644
> --- a/drivers/platform/x86/asus-nb-wmi.c
> +++ b/drivers/platform/x86/asus-nb-wmi.c
> @@ -123,6 +123,12 @@ static struct quirk_entry quirk_asus_use_lid_flip_devid = {
>  	.use_lid_flip_devid = true,
>  };
>  
> +static struct quirk_entry quirk_asus_gv301 = {
> +	.wmi_backlight_set_devstate = true,
> +	.use_lid_flip_devid = true,
> +	.enodev_as_tablet_mode = true,
> +};
> +
>  static int dmi_matched(const struct dmi_system_id *dmi)
>  {
>  	pr_info("Identified laptop model '%s'\n", dmi->ident);
> @@ -471,6 +477,15 @@ static const struct dmi_system_id asus_quirks[] = {
>  		},
>  		.driver_data = &quirk_asus_use_lid_flip_devid,
>  	},
> +	{
> +		.callback = dmi_matched,
> +		.ident = "ASUS ROG FLOW X13",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "GV301Q"),
> +		},
> +		.driver_data = &quirk_asus_gv301,
> +	},
>  	{},
>  };
>  
> @@ -581,6 +596,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
>  	{ KE_KEY, 0xC5, { KEY_KBDILLUMDOWN } },
>  	{ KE_IGNORE, 0xC6, },  /* Ambient Light Sensor notification */
>  	{ KE_KEY, 0xFA, { KEY_PROG2 } },           /* Lid flip action */
> +	{ KE_KEY, 0xBD, { KEY_PROG2 } },           /* Lid flip action on rog flow laptops */

asus_wmi_handle_event_code() will never get to the part where it parses
the keymap since it has:

	if (asus->driver->quirks->use_lid_flip_devid &&
			(code == NOTIFY_LID_FLIP || code == NOTIFY_LID_FLIP_GV301)) {
 		lid_flip_tablet_mode_get_state(asus);
  		return;
  	}

after this patch. The old 0xFA mapping is there from before we had LID switch
reporting on devices using ASUS_WMI_DEVID_LID_FLIP. I don't believe adding
an extra entry for this is necessary; nor is it a good idea since then
userspace might become to rely on these events which we don't want.



>  	{ KE_END, 0},
>  };
>  
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 62ce198a3463..0458e9107ca7 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -68,6 +68,7 @@ module_param(fnlock_default, bool, 0444);
>  #define NOTIFY_KBD_FBM			0x99
>  #define NOTIFY_KBD_TTP			0xae
>  #define NOTIFY_LID_FLIP			0xfa
> +#define NOTIFY_LID_FLIP_GV301	0xbd
>  
>  #define ASUS_WMI_FNLOCK_BIOS_DISABLED	BIT(0)
>  
> @@ -516,6 +517,12 @@ static int asus_wmi_input_init(struct asus_wmi *asus)
>  
>  	if (asus->driver->quirks->use_lid_flip_devid) {
>  		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_LID_FLIP);
> +		if (result < 0)
> +			result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_GV301_LID_FLIP);
> +
> +		if (result == -ENODEV && asus->driver->quirks->enodev_as_tablet_mode)
> +			result = 1;
> +

Looking at the handling of this here.

>  		if (result < 0)
>  			asus->driver->quirks->use_lid_flip_devid = 0;
>  		if (result >= 0) {
> @@ -553,6 +560,12 @@ static void lid_flip_tablet_mode_get_state(struct asus_wmi *asus)
>  {
>  	int result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_LID_FLIP);
>  
> +	if (result < 0)
> +		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_GV301_LID_FLIP);
> +
> +	if (result == -ENODEV && asus->driver->quirks->enodev_as_tablet_mode)
> +		result = 1;
> +

And here.

>  	if (result >= 0) {
>  		input_report_switch(asus->inputdev, SW_TABLET_MODE, result);
>  		input_sync(asus->inputdev);
> @@ -3094,7 +3107,8 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
>  		return;
>  	}
>  
> -	if (asus->driver->quirks->use_lid_flip_devid && code == NOTIFY_LID_FLIP) {
> +	if (asus->driver->quirks->use_lid_flip_devid &&
> +			(code == NOTIFY_LID_FLIP || code == NOTIFY_LID_FLIP_GV301)) {
>  		lid_flip_tablet_mode_get_state(asus);
>  		return;
>  	}

and here. This really just is an entirely different code flow from the
devices using ASUS_WMI_DEVID_LID_FLIP.

I think it would be better to instead of the enodev_as_tablet_mode quirk, to
do a preparation patch 1/2 adding a:

enum asus_wmi_tablet_switch_mode {
	asus_wmi_no_tablet_switch,
	asus_wmi_kbd_dock_devid,
	asus_Wmi_lid_flip_devid,
	asus_wmi_gv301_lid_flip_devid, /* to be added in patch 2/2 */
};

and then in the quirks struct replace:

  	bool use_kbd_dock_devid;
  	bool use_lid_flip_devid;

with:

	enum asus_wmi_tablet_switch_mode tablet_switch_mode;

Adjust the quirks to set this to the right value and then where
the current code has the following pattern:

        if (asus->driver->quirks->use_kbd_dock_devid) {
		<kbd_dock_devid handling>;
	}
	
        if (asus->driver->quirks->use_lid_flip_devid) {
		<lid_flip_devid handling>;
	}

replace this with:

        switch (asus->driver->quirks->tablet_switch_mode) {
	case asus_wmi_no_tablet_switch:
		break;
	case asus_wmi_kbd_dock_devid:
		<kbd_dock_devid handling>;
		break;
	case asus_Wmi_lid_flip_devid:
		<lid_flip_devid handling>;
		break;
	}

And then in patch 2/2 add asus_wmi_gv301_lid_flip_devid to the enum
and extend the switch-cases with the necessary handling for the new
tablet-mode-switch type.

Regards,

Hans



> diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-wmi.h
> index b302415bf1d9..ac9023aae838 100644
> --- a/drivers/platform/x86/asus-wmi.h
> +++ b/drivers/platform/x86/asus-wmi.h
> @@ -35,6 +35,7 @@ struct quirk_entry {
>  	bool wmi_force_als_set;
>  	bool use_kbd_dock_devid;
>  	bool use_lid_flip_devid;
> +	bool enodev_as_tablet_mode;
>  	int wapf;
>  	/*
>  	 * For machines with AMD graphic chips, it will send out WMI event
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index a571b47ff362..79bd06628a8b 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -64,6 +64,7 @@
>  #define ASUS_WMI_DEVID_PANEL_OD		0x00050019
>  #define ASUS_WMI_DEVID_CAMERA		0x00060013
>  #define ASUS_WMI_DEVID_LID_FLIP		0x00060062
> +#define ASUS_WMI_DEVID_GV301_LID_FLIP	0x00060077
>  
>  /* Storage */
>  #define ASUS_WMI_DEVID_CARDREADER	0x00080013

