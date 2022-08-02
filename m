Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2E3588434
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 00:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbiHBW1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 18:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbiHBW1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 18:27:15 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51AA49B50;
        Tue,  2 Aug 2022 15:27:13 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 4E13A32008FF;
        Tue,  2 Aug 2022 18:27:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 02 Aug 2022 18:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1659479229; x=1659565629; bh=is0apWac7y
        dGa2bHB+TmuMSe828wp4HrZEnlQsG/Qqo=; b=l0aIr3SjwxElX7t9mA6cz+Cz/a
        XcVVLHHGSP7E6eoX5cStpHWMVkeF6CEA5PYPuHEGktBlDnsWNOeGj04vca/FzX/7
        KU9qhRuRr+Q8ezf91puYaJ8zL8J+E7Ux21ERar02BENuv67LSvL+aiEXosVWDNMQ
        mWALBtXM6xrDXbk5JUs2fBZfe29U+lF+D8ibnmkSynyrb38VFcpG8rtWm/qMDyKa
        X2MUiSZDPLg20hSr8cBEsEtY0atQE4akNZKyIjnX5wlHT/YPgkM34F8OnJMB/M9t
        qTiuHomBMhgNEuQx187MLIaYOXi/VO0K+NCZVLqMvqYxCOWdPT1NjR/D2z+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1659479229; x=1659565629; bh=is0apWac7ydGa2bHB+TmuMSe828w
        p4HrZEnlQsG/Qqo=; b=mNfoDs2+4CD+SlJkodCojmRZhNqlQHGi5Xnu7XAIPUSj
        jmw28TWYreXA56OuB/wvZRGqEwSKjeGuN+y2jH5vVrAtcoj7FhTaWU0/dkSO6S6y
        2Y8JLpOOoZHhbWvf7aNigETHyD6kJH6NGPl+0uEsJFM3YrLItHw0Fmt97NbVfMe5
        tL2c0kzHf6GnvceMYoppBAdcgrQUwlDfW1Oix5mrAarkSk82Vmn+pXxinuUsNV6V
        4Z/7CEnazpVSDY1tzSQ2XZCFsZJlJo4e7ypZldIh2falZeuOSmqarDGvama4qpBH
        UsC3OE0dRecPfCuE+0OKuNITOHUQoZJsjKAZ6ocTeA==
X-ME-Sender: <xms:vaTpYhwpo2KknXxP6uXC3pzM-VJG9M8RR3MVne-UIn0AcK4gtBFcrw>
    <xme:vaTpYhTFLQzV0VtJ5-q0Zmr6uVoIcQKvYcV_s8L6ECmujk8BoSsTLQk_s9zev_0Py
    O5COt9z3EAobm5GQEk>
X-ME-Received: <xmr:vaTpYrU5XUxsKepgHhrSE8Ag0kLNbfLZCzNYXZrO-MCDyRR5j6JaxKuwNxoz9xvqL5QeKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddviedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhuffvvefkjghfofggtgesthdtredtredtvdenucfhrhhomhepnfhukhgv
    ucflohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnh
    epuefggeefkeduheduhfetuddugfefkeelgeeuhfegteettdetvdffvefggeevffegnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghdpphhhohhrohhnihigrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhho
    nhgvshdruggvvh
X-ME-Proxy: <xmx:vaTpYjicSbNGr5fHXjtIpV4TLg9xyMB_2rJJl-dVlq-lNOT-RdGjZw>
    <xmx:vaTpYjCYlUjdjhAeU9eutXCglbGNjxciPsk9yA-uAYE_Sh0F-ohpMw>
    <xmx:vaTpYsKIk7vl2lgzv3tjBNjX-w9J1Se7fHJp_lINLIJVCIp83TMu4g>
    <xmx:vaTpYmN7idDy69TZA1rfawLT-SC830WTFbHbvAy7EcXq1DLWVtGAVA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Aug 2022 18:27:06 -0400 (EDT)
Date:   Wed, 03 Aug 2022 10:26:52 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH] asus-wmi: Add support for TUF laptop keyboard RGB
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     corentin.chary@gmail.com, markgross@kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Message-Id: <SCE0GR.PE33MM569SDQ3@ljones.dev>
In-Reply-To: <4cb33604-28c6-ac51-0162-2e5a027f02a0@redhat.com>
References: <20220802045942.1565559-1-luke@ljones.dev>
        <e6c0ca61-97d3-328b-f50e-7cdac50eb083@redhat.com>
        <4cb33604-28c6-ac51-0162-2e5a027f02a0@redhat.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

Not a problem at all mate (it didn't take long to write), I was 
expecting this and intended the patch more as a "let's see where we go".

Thank you for the information on how to handle proper bring-up, it 
seems I should be able to use this for both the TUF ACPI controlled 
keyboard along with the ROG USB connected keyboards - which would be 
excellent for everyone using these laptops. The TUF series of laptops 
are relatively nice and simple to work with due to the limited 
feature-set, so this is a great starting point.

To ensure I am on the correct footing, using the information provided, 
the goal would be to provide the following?

Base RGB setting under:
/sys/class/leds/multicolor:status/multi_index
/sys/class/leds/multicolor:status/multi_intensity
/sys/class/leds/multicolor:status/max_brightness

Extra features under:
/sys/class/leds/asus::kbd_backlight/mode
/sys/class/leds/asus::kbd_backlight/speed
/sys/class/leds/asus::kbd_backlight/direction

Some questions I have:
1. If there is more than one RGB capable keyboard, what happens to 
/sys/class/leds/multicolor:status ?
2. There is no way to fetch the current values from the keyboard and 
multicolor seems to expect that the current settings can be read - the 
issue here I think is that if the keyboard is changed perhaps by 
Windows dual-boot then these settings won't match. How would this be 
handled?
3. I'm still relatively new to sysfs. Is it possible for sysfs to save 
these values (e.g, multicolour) and re-apply on boot?
4. In the case of the ROG USB connected laptop keyboards, some models 
have per-key control. How would I enable this using the multicolour 
API? Something like:

/sys/class/leds/multicolor:status/multi_a_index
/sys/class/leds/multicolor:status/multi_a_intensity
/sys/class/leds/multicolor:status/multi_left_ctrl_index
/sys/class/leds/multicolor:status/multi_left_ctrl_intensity
/sys/class/leds/multicolor:status/multi_spacebar_index
/sys/class/leds/multicolor:status/multi_spacebar_intensity
/sys/class/leds/multicolor:status/max_brightness (individual or all?)

For these keyboards the USB takes 9-12 packets of 64 bytes, and I've 
indexed the locations of colours in each. To be honest I'd very much 
like to work out how to do this for per-key as it can potentially save 
a lot of time in writing each packet if the kernel is able to batch 
writes internally. A single packet for half a row is ~1ms, but can vary 
up to 5ms..

4. I'm unsure of how to structure the USB-RGB code.. Would I need to 
write an extra driver perhaps?

Kind regards,
Luke.

On Tue, Aug 2 2022 at 14:13:06 +0200, Hans de Goede 
<hdegoede@redhat.com> wrote:
> Hi,
> 
> On 8/2/22 13:09, Hans de Goede wrote:
>>  Hi Luke,
>> 
>>  On 8/2/22 06:59, Luke D. Jones wrote:
>>>  Adds support for TUF laptop RGB control. This creates two sysfs
>>>  paths to add control of basic keyboard LEDs, and power states.
>>> 
>>>  /sys/devices/platform/asus-nb-wmi/tuf_krgb_mode has the following
>>>  as input options via U8 "n n n n n n":
>>>  - Save or set, if set, then settings revert on cold boot
>>>  - Mode, 0-8 for regular modes (if supported), 10-12 for "warning" 
>>> styles
>>>  - Red, 0-255
>>>  - Green, 0-255
>>>  - Blue, 0-255
>>>  - Speed, 0 = Slow, 1 = Medium, 2 = Fast
>>> 
>>>  /sys/devices/platform/asus-nb-wmi/tuf_krgb_state has the following
>>>  as input options via boolean "b b b b b":
>>>  - Save or set, if set, then settings revert on cold boot
>>>  - Boot, if true, the keyboard displays animation on boot
>>>  - Awake, if true, the keyboard LED's are on while device is awake
>>>  - Sleep, if true, the keyboard shows animation while device is 
>>> suspended
>>>  - Keybaord, appears to have no effect
>> 
>>  Typo in Keybaord here.
>> 
>>  Thank you for your patch. I really appreciate your continued
>>  efforts to make Asus laptops work well with Linux.
>> 
>>  For keyboard backlight support Linux has standardized on
>>  using the /sys/class/leds API. So I'm afraid that this patch
>>  will need to be rewritten to use the standard LED API
>>  and then specifically the somewhat new multicolor LED API
>>  at least for setting the RGB values (within the current mode)
>> 
>>  Any extra functionality can then be added as extra sysfs
>>  attributes under the /sys/class/leds/asus::kbd_backlight
>>  device, see e.g. the use of kbd_led_groups in:
>>  drivers/platform/x86/dell/dell-laptop.c
>> 
>>  Note the kbd_backlight part of the name is important this
>>  will allow upower to recognize this as a keyboard backlight
>>  and will then enable desktop-environments which use
>>  upower for kbd backlight control to at least control
>>  the overall brightness of the kbd-backlight.
>> 
>>  I realize that this means that you need to redo a whole
>>  bunch of work here; and I presume also in your
>>  asusctl userspace utility, sorry about that. But it
>>  really is important that standard userspace APIs are
>>  used for things like this where ever possible.
>> 
>>  Regards,
>> 
>>  Hans
> 
> p.s.
> 
> For more info on the multi-color LED API see:
> 
> https://www.kernel.org/doc/html/latest/leds/leds-class-multicolor.html
> https://www.phoronix.com/scan.php?page=news_item&px=Linux-5.9-Multi-Color-LEDs
> 
> 
> 
>> 
>> 
>> 
>> 
>>> 
>>>  Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>>  ---
>>>   drivers/platform/x86/asus-wmi.c            | 168 
>>> +++++++++++++++++++++
>>>   include/linux/platform_data/x86/asus-wmi.h |   6 +
>>>   2 files changed, 174 insertions(+)
>>> 
>>>  diff --git a/drivers/platform/x86/asus-wmi.c 
>>> b/drivers/platform/x86/asus-wmi.c
>>>  index 62ce198a3463..09277bd98249 100644
>>>  --- a/drivers/platform/x86/asus-wmi.c
>>>  +++ b/drivers/platform/x86/asus-wmi.c
>>>  @@ -234,6 +234,9 @@ struct asus_wmi {
>>>   	bool dgpu_disable_available;
>>>   	bool dgpu_disable;
>>> 
>>>  +	bool tuf_kb_rgb_mode_available;
>>>  +	bool tuf_kb_rgb_state_available;
>>>  +
>>>   	bool throttle_thermal_policy_available;
>>>   	u8 throttle_thermal_policy_mode;
>>> 
>>>  @@ -734,6 +737,153 @@ static ssize_t egpu_enable_store(struct 
>>> device *dev,
>>> 
>>>   static DEVICE_ATTR_RW(egpu_enable);
>>> 
>>>  +/* TUF Laptop Keyboard RGB Modes 
>>> **********************************************/
>>>  +static int tuf_kb_rgb_mode_check_present(struct asus_wmi *asus)
>>>  +{
>>>  +	u32 result;
>>>  +	int err;
>>>  +
>>>  +	asus->tuf_kb_rgb_mode_available = false;
>>>  +
>>>  +	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_TUF_RGB_MODE, 
>>> &result);
>>>  +	if (err) {
>>>  +		if (err == -ENODEV)
>>>  +			return 0;
>>>  +		return err;
>>>  +	}
>>>  +
>>>  +	if (result & ASUS_WMI_DSTS_PRESENCE_BIT)
>>>  +		asus->tuf_kb_rgb_mode_available = true;
>>>  +
>>>  +	return 0;
>>>  +}
>>>  +
>>>  +static ssize_t tuf_kb_rgb_mode_store(struct device *dev,
>>>  +				 struct device_attribute *attr,
>>>  +				 const char *buf, size_t count)
>>>  +{
>>>  +	int err;
>>>  +	u32 ret;
>>>  +	u8 res, tmp, arg_num;
>>>  +	char *data, *part, *end;
>>>  +	u8 cmd, mode, r, g,  b,  speed;
>>>  +
>>>  +	data = end = kstrdup(buf, GFP_KERNEL);
>>>  +	cmd = mode = r = g = b = speed = arg_num = 0;
>>>  +
>>>  +	while ((part = strsep(&end, " ")) != NULL) {
>>>  +		if (part == NULL)
>>>  +			return -1;
>>>  +
>>>  +		res = kstrtou8(part, 10, &tmp);
>>>  +		if (res)
>>>  +			return -1;
>>>  +
>>>  +		if (arg_num == 0)
>>>  +			// apply : set
>>>  +			cmd = tmp == 1 ? 0xb5 : 0xb4;
>>>  +		else if (arg_num == 1)
>>>  +			// From 0-8 are valid modes with 10-12 being "warning"
>>>  +			// style modes. All models have "pulse" mode 10.
>>>  +			mode = (tmp <= 12 && tmp != 9) ? tmp : 10;
>>>  +		else if (arg_num == 2)
>>>  +			r = tmp;
>>>  +		else if (arg_num == 3)
>>>  +			g = tmp;
>>>  +		else if (arg_num == 4)
>>>  +			b = tmp;
>>>  +		else if (arg_num == 5) {
>>>  +			if (tmp == 0)
>>>  +				speed = 0xe1;
>>>  +			else if (tmp == 1)
>>>  +				speed = 0xeb;
>>>  +			else if (tmp == 2)
>>>  +				speed = 0xf5;
>>>  +		}
>>>  +
>>>  +		arg_num += 1;
>>>  +	}
>>>  +
>>>  +	err = asus_wmi_evaluate_method3(ASUS_WMI_METHODID_DEVS, 
>>> ASUS_WMI_DEVID_TUF_RGB_MODE,
>>>  +			cmd | (mode << 8) | (r << 16) | (g << 24), (b) | (speed << 8), 
>>> &ret);
>>>  +	if (err)
>>>  +		return err;
>>>  +
>>>  +	kfree(data);
>>>  +	return count;
>>>  +}
>>>  +
>>>  +static DEVICE_ATTR_WO(tuf_kb_rgb_mode);
>>>  +
>>>  +/* TUF Laptop Keyboard RGB States 
>>> *********************************************/
>>>  +static int tuf_kb_rgb_state_check_present(struct asus_wmi *asus)
>>>  +{
>>>  +	u32 result;
>>>  +	int err;
>>>  +
>>>  +	asus->tuf_kb_rgb_state_available = false;
>>>  +
>>>  +	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_TUF_RGB_STATE, 
>>> &result);
>>>  +	if (err) {
>>>  +		if (err == -ENODEV)
>>>  +			return 0;
>>>  +		return err;
>>>  +	}
>>>  +
>>>  +	if (result & ASUS_WMI_DSTS_PRESENCE_BIT)
>>>  +		asus->tuf_kb_rgb_state_available = true;
>>>  +
>>>  +	return 0;
>>>  +}
>>>  +
>>>  +static ssize_t tuf_kb_rgb_state_store(struct device *dev,
>>>  +				   struct device_attribute *attr,
>>>  +				   const char *buf, size_t count)
>>>  +{
>>>  +	int err;
>>>  +	u32 ret;
>>>  +	bool tmp;
>>>  +	char *data, *part, *end;
>>>  +	u8 save, flags, res, arg_num;
>>>  +
>>>  +	save = flags = arg_num = 0;
>>>  +	data = end = kstrdup(buf, GFP_KERNEL);
>>>  +
>>>  +	while ((part = strsep(&end, " ")) != NULL) {
>>>  +		if (part == NULL)
>>>  +			return -1;
>>>  +
>>>  +		res = kstrtobool(part, &tmp);
>>>  +		if (res)
>>>  +			return -1;
>>>  +
>>>  +		if (tmp) {
>>>  +			if (arg_num == 0) // save  :  set
>>>  +				save = tmp == 0 ? 0x0100 : 0x0000;
>>>  +			else if (arg_num == 1)
>>>  +				flags |= 0x02; // boot
>>>  +			else if (arg_num == 2)
>>>  +				flags |= 0x08; // awake
>>>  +			else if (arg_num == 3)
>>>  +				flags |= 0x20; // sleep
>>>  +			else if (arg_num == 4)
>>>  +				flags |= 0x80; // keyboard
>>>  +		}
>>>  +
>>>  +		arg_num += 1;
>>>  +	}
>>>  +
>>>  +	err = asus_wmi_evaluate_method3(ASUS_WMI_METHODID_DEVS,
>>>  +			ASUS_WMI_DEVID_TUF_RGB_STATE, 0xBD | save | (flags << 16), 0, 
>>> &ret);
>>>  +	if (err)
>>>  +		return err;
>>>  +
>>>  +	kfree(data);
>>>  +	return count;
>>>  +}
>>>  +
>>>  +static DEVICE_ATTR_WO(tuf_kb_rgb_state);
>>>  +
>>>   /* Battery 
>>> ********************************************************************/
>>> 
>>>   /* The battery maximum charging percentage */
>>>  @@ -3258,6 +3408,8 @@ static struct attribute 
>>> *platform_attributes[] = {
>>>   	&dev_attr_touchpad.attr,
>>>   	&dev_attr_egpu_enable.attr,
>>>   	&dev_attr_dgpu_disable.attr,
>>>  +	&dev_attr_tuf_kb_rgb_mode.attr,
>>>  +	&dev_attr_tuf_kb_rgb_state.attr,
>>>   	&dev_attr_lid_resume.attr,
>>>   	&dev_attr_als_enable.attr,
>>>   	&dev_attr_fan_boost_mode.attr,
>>>  @@ -3286,6 +3438,12 @@ static umode_t asus_sysfs_is_visible(struct 
>>> kobject *kobj,
>>>   		devid = ASUS_WMI_DEVID_ALS_ENABLE;
>>>   	else if (attr == &dev_attr_egpu_enable.attr)
>>>   		ok = asus->egpu_enable_available;
>>>  +	else if (attr == &dev_attr_tuf_kb_rgb_mode.attr)
>>>  +		ok = asus->tuf_kb_rgb_mode_available;
>>>  +	else if (attr == &dev_attr_tuf_kb_rgb_state.attr)
>>>  +		ok = asus->tuf_kb_rgb_state_available;
>>>  +	else if (attr == &dev_attr_dgpu_disable.attr)
>>>  +		ok = asus->dgpu_disable_available;
>>>   	else if (attr == &dev_attr_dgpu_disable.attr)
>>>   		ok = asus->dgpu_disable_available;
>>>   	else if (attr == &dev_attr_fan_boost_mode.attr)
>>>  @@ -3557,6 +3715,14 @@ static int asus_wmi_add(struct 
>>> platform_device *pdev)
>>>   	if (err)
>>>   		goto fail_dgpu_disable;
>>> 
>>>  +	err = tuf_kb_rgb_mode_check_present(asus);
>>>  +	if (err)
>>>  +		goto fail_tuf_kb_rgb_mode;
>>>  +
>>>  +	err = tuf_kb_rgb_state_check_present(asus);
>>>  +	if (err)
>>>  +		goto fail_tuf_kb_rgb_state;
>>>  +
>>>   	err = fan_boost_mode_check_present(asus);
>>>   	if (err)
>>>   		goto fail_fan_boost_mode;
>>>  @@ -3671,6 +3837,8 @@ static int asus_wmi_add(struct 
>>> platform_device *pdev)
>>>   fail_fan_boost_mode:
>>>   fail_egpu_enable:
>>>   fail_dgpu_disable:
>>>  +fail_tuf_kb_rgb_mode:
>>>  +fail_tuf_kb_rgb_state:
>>>   fail_platform:
>>>   fail_panel_od:
>>>   	kfree(asus);
>>>  diff --git a/include/linux/platform_data/x86/asus-wmi.h 
>>> b/include/linux/platform_data/x86/asus-wmi.h
>>>  index a571b47ff362..af4191fb0508 100644
>>>  --- a/include/linux/platform_data/x86/asus-wmi.h
>>>  +++ b/include/linux/platform_data/x86/asus-wmi.h
>>>  @@ -98,6 +98,12 @@
>>>   /* dgpu on/off */
>>>   #define ASUS_WMI_DEVID_DGPU		0x00090020
>>> 
>>>  +/* TUF laptop RGB modes/colours */
>>>  +#define ASUS_WMI_DEVID_TUF_RGB_MODE	0x00100056
>>>  +
>>>  +/* TUF laptop RGB power/state */
>>>  +#define ASUS_WMI_DEVID_TUF_RGB_STATE	0x00100057
>>>  +
>>>   /* DSTS masks */
>>>   #define ASUS_WMI_DSTS_STATUS_BIT	0x00000001
>>>   #define ASUS_WMI_DSTS_UNKNOWN_BIT	0x00000002
> 


