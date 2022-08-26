Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3B85A2538
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 11:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344055AbiHZJ5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 05:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343986AbiHZJ51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 05:57:27 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD7BD598E;
        Fri, 26 Aug 2022 02:57:23 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 5986C5C026E;
        Fri, 26 Aug 2022 05:57:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 26 Aug 2022 05:57:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1661507839; x=1661594239; bh=U0RbklUk4g
        Blw+Lx8FZx1cj1SwGiYGfyOa6LssZeaPc=; b=JM4TwRqeg+zsVxHQqpMLj1F3X8
        EkUg/6qZmYe6+nYoVeQzu5quchqijR+4GslZ0VLQI2xT2cEYdpQYk47lzc5DCH2b
        DZIGo5AQ+Fs7sz+opGfHL568X2ScwJmN86Gqb3cAyZcL1KlEJMLG1zQIZPGUKLex
        df+l7BPvZvLFuug7O9IPGhJLiWjJBypNl8i2NridLymjC3NAZ/oPtR8W4+9Rjdoi
        aoZaenUMVWwHjwkAuRvEDXQmGwjD4wpMWe4Y0BsuRllLdei6lHGBDHB1YVGn1h0L
        /5CRJoT+mu5w4S5L6Tv/evnbrYlaEDHAkantArW+nLTt/LDYzwpC0SZbzaXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1661507839; x=1661594239; bh=U0RbklUk4gBlw+Lx8FZx1cj1SwGi
        YGfyOa6LssZeaPc=; b=ZinNL7/DhJGG+HpWrqtcqyqYNzE38qjyN/gqA52jNTdh
        WDpGpyRsVs01kCJXxNhLAdxlakJhltb0zLIiKGbH7pSg3WJR8GpmceyXJ1DWFwp0
        0w7saOkSLAOoxDVE3L3hvFWRZ+yWXT1v2gnRwhfOaNItjKEdImvTilEA8nxhL75s
        1S2oZi/YqkuqiFtBy0bCpBNhB5Gn0BCaIlqBk6D6Uu1Xv9uXq0cghHYjQxyVxAoo
        QSXSAq2wZo3USHOZz+Ucqooix18oTisDNmsw2rnIIiQAzP+m6q8DgXD45Jz0SI4f
        CBEc62X/uQYDFcViBUH4rvVIfVCw1EL5tf2XH6VqZg==
X-ME-Sender: <xms:_pgIY7dMupzveqAgdi77_2aHMggeY1pI4qOidyjnNMpKD4UbAyqRiQ>
    <xme:_pgIYxMw6c5MyhBdsyZ9FudgqfP5hNqef2kiyb95pX1PzWXh0qE3215bLEFAZ02my
    hxZdKiYrR3TGzevVjc>
X-ME-Received: <xmr:_pgIY0jiXl2SyoabW-g0vpQWkhsng_xETBj-GIp8OPT73AdS-Gtspu374FBiEAu894wpvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejhedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhuffvvefkjghfofggtgesthdtredtredtvdenucfhrhhomhepnfhukhgv
    ucflohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnh
    epvddvgeeltdehfeeijefgveegfeeihfdtveetfeetudfhvedtfeeltefhteegledunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvse
    hljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:_pgIY8909k9JSxIs0CZQj0hCjhOeyu2vE4I0Fjax42RqbOdDqz8y-g>
    <xmx:_pgIY3t6-eWza1pVizORKYlBnKVoEuWdByR2j6JKIwqnPaKP8GKAVg>
    <xmx:_pgIY7FEjiOx_C1mRE6Vryqauiqqw1LoGEAfQ9MmRbpUIvLZl2lfJg>
    <xmx:_5gIYxI_xg5wU1j1BAP_3MyuvYxZMxAehVca2MvEyw_apbwoks0jlQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Aug 2022 05:57:12 -0400 (EDT)
Date:   Fri, 26 Aug 2022 21:56:57 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v4 1/2] asus-wmi: Implement TUF laptop keyboard LED modes
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
        pobrn@protonmail.com, pavel@ucw.cz
Message-Id: <XMV7HR.FTECLY4PXEQX@ljones.dev>
In-Reply-To: <0a45a991-4123-a76c-174f-435523f6d348@redhat.com>
References: <20220825232251.345893-1-luke@ljones.dev>
        <20220825232251.345893-2-luke@ljones.dev>
        <0a45a991-4123-a76c-174f-435523f6d348@redhat.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, Aug 26 2022 at 11:47:37 +0200, Hans de Goede 
<hdegoede@redhat.com> wrote:
> Hi Luke,
> 
> On 8/26/22 01:22, Luke D. Jones wrote:
>>  Adds support for changing the laptop keyboard LED mode and colour.
>> 
>>  The modes are visible effects such as static, rainbow, pulsing,
>>  colour cycles.
>> 
>>  These sysfs attributes are added to asus::kbd_backlight:
>>  - kbd_rgb_mode
>>  - kbd_rgb_mode_index
>> 
>>  Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>  ---
>>   drivers/platform/x86/asus-wmi.c            | 76 
>> +++++++++++++++++++++-
>>   include/linux/platform_data/x86/asus-wmi.h |  3 +
>>   2 files changed, 78 insertions(+), 1 deletion(-)
>> 
>>  diff --git a/drivers/platform/x86/asus-wmi.c 
>> b/drivers/platform/x86/asus-wmi.c
>>  index 0f9f79f249c7..92f16bb9b4ef 100644
>>  --- a/drivers/platform/x86/asus-wmi.c
>>  +++ b/drivers/platform/x86/asus-wmi.c
>>  @@ -237,6 +237,8 @@ struct asus_wmi {
>>   	bool dgpu_disable_available;
>>   	bool gpu_mux_mode_available;
>> 
>>  +	bool kbd_rgb_mode_available;
>>  +
>>   	bool throttle_thermal_policy_available;
>>   	u8 throttle_thermal_policy_mode;
>> 
>>  @@ -720,6 +722,69 @@ static ssize_t gpu_mux_mode_store(struct 
>> device *dev,
>>   }
>>   static DEVICE_ATTR_RW(gpu_mux_mode);
>> 
>>  +/* TUF Laptop Keyboard RGB Modes 
>> **********************************************/
>>  +static ssize_t kbd_rgb_mode_store(struct device *dev,
>>  +				 struct device_attribute *attr,
>>  +				 const char *buf, size_t count)
>>  +{
>>  +	u32 cmd, mode, r, g,  b,  speed;
>>  +	int err;
>>  +
>>  +	if (sscanf(buf, "%d %d %d %d %d %d", &cmd, &mode, &r, &g, &b, 
>> &speed) != 6)
>>  +		return -EINVAL;
>>  +
>>  +	cmd = !!cmd;
>>  +
>>  +	/* These are the known usable modes across all TUF/ROG */
>>  +	if (mode >= 12 || mode == 9)
>>  +		mode = 10;
>>  +
>>  +	switch (speed) {
>>  +	case 0:
>>  +		speed = 0xe1;
>>  +		break;
>>  +	case 1:
>>  +		speed = 0xeb;
>>  +		break;
>>  +	case 2:
>>  +		speed = 0xf5;
>>  +		break;
>>  +	default:
>>  +		speed = 0xeb;
>>  +	}
>>  +
>>  +	err = asus_wmi_evaluate_method3(ASUS_WMI_METHODID_DEVS, 
>> ASUS_WMI_DEVID_TUF_RGB_MODE,
>>  +			cmd | (mode << 8) | (r << 16) | (g << 24), b | (speed << 8), 
>> NULL);
>>  +	if (err)
>>  +		return err;
>>  +
>>  +	return count;
>>  +}
>>  +static DEVICE_ATTR_WO(kbd_rgb_mode);
>>  +
>>  +static ssize_t kbd_rgb_mode_index_show(struct device *device,
>>  +						 struct device_attribute *attr,
>>  +						 char *buf)
>>  +{
>>  +	return sysfs_emit(buf, "%s\n", "cmd mode red green blue speed");
>>  +}
>>  +static DEVICE_ATTR_RO(kbd_rgb_mode_index);
>>  +
>>  +static struct attribute *kbd_rgb_mode_attrs[] = {
>>  +	&dev_attr_kbd_rgb_mode.attr,
>>  +	&dev_attr_kbd_rgb_mode_index.attr,
>>  +	NULL,
>>  +};
>>  +
>>  +static const struct attribute_group kbd_rgb_mode_group = {
>>  +	.attrs = kbd_rgb_mode_attrs,
>>  +};
>>  +
>>  +const struct attribute_group *kbd_rgb_mode_groups[] = {
>>  +	NULL,
>>  +	NULL,
>>  +};
>>  +
>>   /* Battery 
>> ********************************************************************/
>> 
>>   /* The battery maximum charging percentage */
>>  @@ -1038,7 +1103,10 @@ static void asus_wmi_led_exit(struct 
>> asus_wmi *asus)
>> 
>>   static int asus_wmi_led_init(struct asus_wmi *asus)
>>   {
>>  -	int rv = 0, led_val;
>>  +	int rv = 0, num_rgb_groups = 0, led_val;
>>  +
>>  +	if (asus->kbd_rgb_mode_available)
>>  +		kbd_rgb_mode_groups[num_rgb_groups++] = &kbd_rgb_mode_group;
>> 
>>   	asus->led_workqueue = 
>> create_singlethread_workqueue("led_workqueue");
>>   	if (!asus->led_workqueue)
>>  @@ -1066,6 +1134,9 @@ static int asus_wmi_led_init(struct asus_wmi 
>> *asus)
>>   		asus->kbd_led.brightness_get = kbd_led_get;
>>   		asus->kbd_led.max_brightness = 3;
>> 
>>  +		if (num_rgb_groups != 0)
>>  +			asus->kbd_led.groups = kbd_rgb_mode_groups;
>>  +
>>   		rv = led_classdev_register(&asus->platform_device->dev,
>>   					   &asus->kbd_led);
>>   		if (rv)
>>  @@ -3253,6 +3324,8 @@ static umode_t asus_sysfs_is_visible(struct 
>> kobject *kobj,
>>   		ok = asus->egpu_enable_available;
>>   	else if (attr == &dev_attr_dgpu_disable.attr)
>>   		ok = asus->dgpu_disable_available;
>>  +	else if (attr == &dev_attr_dgpu_disable.attr)
>>  +		ok = asus->dgpu_disable_available;
>>   	else if (attr == &dev_attr_gpu_mux_mode.attr)
>>   		ok = asus->gpu_mux_mode_available;
>>   	else if (attr == &dev_attr_fan_boost_mode.attr)
> 
> This patch-hunk looks like it is a (mangled) leftover from previous 
> versions
> of the patch.

Do you mean:

 +	else if (attr == &dev_attr_dgpu_disable.attr)
 +		ok = asus->dgpu_disable_available;



> 
> Other then that this latest version of the series looks nice and 
> clean,
> so I've added the series to my review-hans branch minus this 
> patch-hunk.
> 
> One request can you do a follow up patch documenting the new
> attributes in Documentation/ABI/testing/sysfs-platform-asus-wmi
> I know the attributes sit under the LED class device, but this
> still seems the best place for documenting them.

Yes for sure. I wasn't actually certain where I should put the doc.

> 
> Regards,
> 
> Hans
> 
> 
> 
> 
>>  @@ -3519,6 +3592,7 @@ static int asus_wmi_add(struct 
>> platform_device *pdev)
>>   	asus->egpu_enable_available = asus_wmi_dev_is_present(asus, 
>> ASUS_WMI_DEVID_EGPU);
>>   	asus->dgpu_disable_available = asus_wmi_dev_is_present(asus, 
>> ASUS_WMI_DEVID_DGPU);
>>   	asus->gpu_mux_mode_available = asus_wmi_dev_is_present(asus, 
>> ASUS_WMI_DEVID_GPU_MUX);
>>  +	asus->kbd_rgb_mode_available = asus_wmi_dev_is_present(asus, 
>> ASUS_WMI_DEVID_TUF_RGB_MODE);
>>   	asus->panel_overdrive_available = asus_wmi_dev_is_present(asus, 
>> ASUS_WMI_DEVID_PANEL_OD);
>> 
>>   	err = fan_boost_mode_check_present(asus);
>>  diff --git a/include/linux/platform_data/x86/asus-wmi.h 
>> b/include/linux/platform_data/x86/asus-wmi.h
>>  index 6e8a95c10d17..3d861477cb20 100644
>>  --- a/include/linux/platform_data/x86/asus-wmi.h
>>  +++ b/include/linux/platform_data/x86/asus-wmi.h
>>  @@ -103,6 +103,9 @@
>>   /* gpu mux switch, 0 = dGPU, 1 = Optimus */
>>   #define ASUS_WMI_DEVID_GPU_MUX		0x00090016
>> 
>>  +/* TUF laptop RGB modes/colours */
>>  +#define ASUS_WMI_DEVID_TUF_RGB_MODE	0x00100056
>>  +
>>   /* DSTS masks */
>>   #define ASUS_WMI_DSTS_STATUS_BIT	0x00000001
>>   #define ASUS_WMI_DSTS_UNKNOWN_BIT	0x00000002
> 


