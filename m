Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3520458A34B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 00:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbiHDWbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 18:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiHDWbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 18:31:19 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4895632B9C;
        Thu,  4 Aug 2022 15:31:18 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id A939D5C00BE;
        Thu,  4 Aug 2022 18:31:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 04 Aug 2022 18:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1659652277; x=1659738677; bh=172BWgXoJd
        OVGsCrLIASu8Immfji139GJibdT40ktT8=; b=nIiLrHCK+w9OfDuHBzslyZJv94
        kghvEdvcyX239BeyiY2OL8RaCNFvdhwt5JAwpd8bFVTbCkkCSUzEnCsxx5Gmh++l
        h3g1TNAfbDcTvWczx5Brtvo5Ng/99A5UBHKOXG53i3ZztAJNB0XBrcZ6EV/OyqF9
        duNGZENZJMIqbLj87nIsaum2WtLqWfhUVeJe1SfLOT7+ONSf8L1sQKcZZN9h4dSb
        t05G+g5bmf9K3h6ge3CUaq7XCCyUPgMbhN7Tighgl1I+JCxMJZPowNhpger7oNc6
        VNDZIGTWalSCwslcWL6pBY257NBAIj/TUhuM5Bvs/HM1vfK3wz6ESEo3NZ4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1659652277; x=1659738677; bh=172BWgXoJdOVGsCrLIASu8Immfji
        139GJibdT40ktT8=; b=sMYq/Uc4iPZTIrSaqfG5kopqGG8zl/0JQCbp3Qe87AEm
        IHHKm+PwxRe6jYPCCSBgqM5PC4B5J7OtXdmj2cWSkHecq5GydVLDK27ka/jMjw3d
        pAeYeR4AFGYUZRWDOXLBV25K8vjdHfccZakdlFz329QzajlhHlT1cZOoXX4kW5kz
        jRfSQudpr5U8K4j8mf7ieYsRDZjwxPwXuJRlIthT3/VvXBeenpEMHrLaThXcBOOJ
        akXRiKnmcv+wsHtcNBpPaBMnXAJ2SF9XKE+UGXQJ1sgtCjd2tUhfldMPUe6wY6zv
        6ozZnxiZXocnon601fxNT/A520ngWFvrYtaaydOKNw==
X-ME-Sender: <xms:tUjsYjvCEw_64tBDTpE_1f2R2qgoxto_orqcSMlIufhIu7PnceAspg>
    <xme:tUjsYkfRRKzAU8-i4KwcDNERPPKKhssXNg6Q4g4zTGi2_sS8D9YN5G11Xnylwidj7
    sMGG9huldfunCgwvp4>
X-ME-Received: <xmr:tUjsYmw9J6Rxo0eKON8COAX1G57fzWc5zU3LSxWpey2VfsN-BvfUjNbB9B7o1IgBwPTsvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeftddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhuffvvefkjghfofggtgesthdtredtredtvdenucfhrhhomhepnfhukhgv
    ucflohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnh
    epvddvgeeltdehfeeijefgveegfeeihfdtveetfeetudfhvedtfeeltefhteegledunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvse
    hljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:tUjsYiObV7IF3umPlfriTXNU-wtwbp6V95EzNzZ23ZGKV6cOIE_IRw>
    <xmx:tUjsYj9ENj90P5fnlNBHXW-i-N4b_hxBBcC94KyuIuyC1jy7TnyZxA>
    <xmx:tUjsYiVFZrjwu4JqzyZb8qIEPR0thPw4T83STCyvdPlte1rqTPYynQ>
    <xmx:tUjsYtnHC6vjl0jPYeZqavWJLSo6oe6_WmWQjKNB8cNsXnj9AD0e_A>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Aug 2022 18:31:14 -0400 (EDT)
Date:   Fri, 05 Aug 2022 10:31:00 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v2 1/1] asus-wmi: Add support for TUF laptop keyboard
 states
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <OV34GR.32DKOU56FBLD2@ljones.dev>
In-Reply-To: <db7f33c8-404d-6e41-73af-370e148a4eed@redhat.com>
References: <20220803231331.48788-1-luke@ljones.dev>
        <20220803231331.48788-2-luke@ljones.dev>
        <db7f33c8-404d-6e41-73af-370e148a4eed@redhat.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

Thanks for the valuable review,

On Thu, Aug 4 2022 at 15:22:00 +0200, Hans de Goede 
<hdegoede@redhat.com> wrote:
> Hi Luke,
> 
> On 8/4/22 01:13, Luke D. Jones wrote:
>>  Adds support for the TUF series laptop power states. This means
>>  control of if the LED's are on while awake, or an animation is
>>  shown while booting or suspended.
>> 
>>  /sys/devices/platform/asus-nb-wmi/tuf_krgb_state_index provides
>>  labels for the index fields as "save boot awake sleep keyboard"
>> 
>>  /sys/devices/platform/asus-nb-wmi/tuf_krgb_state has the following
>>  as input options via boolean "b b b b b":
>>  - Save or set, if set, then settings revert on cold boot
>>  - Boot, if true, the keyboard displays animation on boot
>>  - Awake, if true, the keyboard LED's are on while device is awake
>>  - Sleep, if true, the keyboard shows animation while device is 
>> suspended
>>  - Keybaord, appears to have no effect
> 
> Keybaord typo / spelling issue.
> 
> Please make this an extra attribute for the led_class_device,
> you can do this by adding this attribute to a separate
> attribute_group, lets say e.g. "tuf_rgb_attributes" and then
> in the "[PATCH] asus-wmi: Add support for TUF laptop keyboard RGB"
> code add:
> 
> 	mc_cdev->led_cdev.groups = tuf_rgb_attributes;
> 
> and then the "tuf_krgb_state" file should show up as:
> /sys/class/leds/asus::multicolour/tuf_krgb_state

Oh this is very cool! I was honestly wondering about if that could be
done but was unsure how and finding the right docs isn't always easy.

> 
> Also I'm not sure what to think of the tuf_krgb_state_index file,
> having a sysfs file just to show some help text feels weird / wrong.

I modelled that after the multicolor version in led-class-multicolor.c:

static ssize_t multi_index_show(struct device *dev,
			      struct device_attribute *multi_index_attr,
			      char *buf)
{
	struct led_classdev *led_cdev = dev_get_drvdata(dev);
	struct led_classdev_mc *mcled_cdev = lcdev_to_mccdev(led_cdev);
	int len = 0;
	int index;
	int i;

	for (i = 0; i < mcled_cdev->num_colors; i++) {
		index = mcled_cdev->subled_info[i].color_index;
		len += sprintf(buf + len, "%s", led_colors[index]);
		if (i < mcled_cdev->num_colors - 1)
			len += sprintf(buf + len, " ");
	}

	buf[len++] = '\n';
	return len;
}
static DEVICE_ATTR_RO(multi_index);

Since it was done there it seemed okay?


> 
> Please instead document the expected format in the existing:
> Documentation/ABI/testing/sysfs-platform-asus-wmi
> 
> file; and talking about that file, it seems that this file
> could use some love to document other recently addes asus-wmi
> features too.
> 

Oof, yep I'll hop on that.

> Related to the tuf_krgb_state_index file, please use the
> new sysfs_emit helper for all new show functions. And bonus
> points for a patch (series?) converting old show functions
> over to it.

For sure I'll do both. I guess this will turn in to a series of
patches now. If only I could get paid for the work..


Many thanks,
Luke.

> 
> Regards,
> 
> Hans
> 
> 
> 
> 
> 
>>  Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>  ---
>>   drivers/platform/x86/asus-wmi.c            | 95 
>> ++++++++++++++++++++++
>>   include/linux/platform_data/x86/asus-wmi.h |  3 +
>>   2 files changed, 98 insertions(+)
>> 
>>  diff --git a/drivers/platform/x86/asus-wmi.c 
>> b/drivers/platform/x86/asus-wmi.c
>>  index 0e7fbed8a50d..bbfb054ff3b2 100644
>>  --- a/drivers/platform/x86/asus-wmi.c
>>  +++ b/drivers/platform/x86/asus-wmi.c
>>  @@ -234,6 +234,8 @@ struct asus_wmi {
>>   	bool dgpu_disable_available;
>>   	bool dgpu_disable;
>> 
>>  +	bool tuf_krgb_state_available;
>>  +
>>   	bool throttle_thermal_policy_available;
>>   	u8 throttle_thermal_policy_mode;
>> 
>>  @@ -734,6 +736,86 @@ static ssize_t egpu_enable_store(struct device 
>> *dev,
>> 
>>   static DEVICE_ATTR_RW(egpu_enable);
>> 
>>  +/* TUF Laptop Keyboard RGB States 
>> *********************************************/
>>  +static int tuf_krgb_state_check_present(struct asus_wmi *asus)
>>  +{
>>  +	u32 result;
>>  +	int err;
>>  +
>>  +	asus->tuf_krgb_state_available = false;
>>  +
>>  +	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_TUF_RGB_STATE, 
>> &result);
>>  +	if (err) {
>>  +		if (err == -ENODEV)
>>  +			return 0;
>>  +		return err;
>>  +	}
>>  +
>>  +	if (result & ASUS_WMI_DSTS_PRESENCE_BIT)
>>  +		asus->tuf_krgb_state_available = true;
>>  +
>>  +	return 0;
>>  +}
>>  +
>>  +static ssize_t tuf_krgb_state_store(struct device *dev,
>>  +				   struct device_attribute *attr,
>>  +				   const char *buf, size_t count)
>>  +{
>>  +	int err;
>>  +	u32 ret;
>>  +	bool tmp;
>>  +	char *data, *part, *end;
>>  +	u8 save, flags, res, arg_num;
>>  +
>>  +	save = flags = arg_num = 0;
>>  +	data = end = kstrdup(buf, GFP_KERNEL);
>>  +
>>  +	while ((part = strsep(&end, " ")) != NULL) {
>>  +		if (part == NULL)
>>  +			return -1;
>>  +
>>  +		res = kstrtobool(part, &tmp);
>>  +		if (res)
>>  +			return -1;
>>  +
>>  +		if (tmp) {
>>  +			if (arg_num == 0) // save  :  set
>>  +				save = tmp == 0 ? 0x0100 : 0x0000;
>>  +			else if (arg_num == 1)
>>  +				flags |= 0x02; // boot
>>  +			else if (arg_num == 2)
>>  +				flags |= 0x08; // awake
>>  +			else if (arg_num == 3)
>>  +				flags |= 0x20; // sleep
>>  +			else if (arg_num == 4)
>>  +				flags |= 0x80; // keyboard
>>  +		}
>>  +
>>  +		arg_num += 1;
>>  +	}
>>  +
>>  +	err = asus_wmi_evaluate_method3(ASUS_WMI_METHODID_DEVS,
>>  +			ASUS_WMI_DEVID_TUF_RGB_STATE, 0xBD | save | (flags << 16), 0, 
>> &ret);
>>  +	if (err) {
>>  +			return err;
>>  +	}
>>  +
>>  +	kfree(data);
>>  +	return count;
>>  +}
>>  +
>>  +static DEVICE_ATTR_WO(tuf_krgb_state);
>>  +
>>  +static ssize_t tuf_krgb_state_index_show(struct device *device,
>>  +						 struct device_attribute *attr,
>>  +						 char *buf)
>>  +{
>>  +	int len = sprintf(buf, "%s", "save boot awake sleep keyboard\n");
>>  +	return len;
>>  +}
>>  +
>>  +static DEVICE_ATTR_RO(tuf_krgb_state_index);
>>  +
>>   /* Battery 
>> ********************************************************************/
>> 
>>   /* The battery maximum charging percentage */
>>  @@ -3258,6 +3340,8 @@ static struct attribute 
>> *platform_attributes[] = {
>>   	&dev_attr_touchpad.attr,
>>   	&dev_attr_egpu_enable.attr,
>>   	&dev_attr_dgpu_disable.attr,
>>  +	&dev_attr_tuf_krgb_state.attr,
>>  +	&dev_attr_tuf_krgb_state_index.attr,
>>   	&dev_attr_lid_resume.attr,
>>   	&dev_attr_als_enable.attr,
>>   	&dev_attr_fan_boost_mode.attr,
>>  @@ -3286,6 +3370,12 @@ static umode_t asus_sysfs_is_visible(struct 
>> kobject *kobj,
>>   		devid = ASUS_WMI_DEVID_ALS_ENABLE;
>>   	else if (attr == &dev_attr_egpu_enable.attr)
>>   		ok = asus->egpu_enable_available;
>>  +	else if (attr == &dev_attr_tuf_krgb_state.attr)
>>  +		ok = asus->tuf_krgb_state_available;
>>  +	else if (attr == &dev_attr_tuf_krgb_state_index.attr)
>>  +		ok = asus->tuf_krgb_state_available;
>>  +	else if (attr == &dev_attr_dgpu_disable.attr)
>>  +		ok = asus->dgpu_disable_available;
>>   	else if (attr == &dev_attr_dgpu_disable.attr)
>>   		ok = asus->dgpu_disable_available;
>>   	else if (attr == &dev_attr_fan_boost_mode.attr)
>>  @@ -3557,6 +3647,10 @@ static int asus_wmi_add(struct 
>> platform_device *pdev)
>>   	if (err)
>>   		goto fail_dgpu_disable;
>> 
>>  +	err = tuf_krgb_state_check_present(asus);
>>  +	if (err)
>>  +		goto fail_tuf_krgb_state;
>>  +
>>   	err = fan_boost_mode_check_present(asus);
>>   	if (err)
>>   		goto fail_fan_boost_mode;
>>  @@ -3671,6 +3765,7 @@ static int asus_wmi_add(struct 
>> platform_device *pdev)
>>   fail_fan_boost_mode:
>>   fail_egpu_enable:
>>   fail_dgpu_disable:
>>  +fail_tuf_krgb_state:
>>   fail_platform:
>>   fail_panel_od:
>>   	kfree(asus);
>>  diff --git a/include/linux/platform_data/x86/asus-wmi.h 
>> b/include/linux/platform_data/x86/asus-wmi.h
>>  index a571b47ff362..a95b37385e66 100644
>>  --- a/include/linux/platform_data/x86/asus-wmi.h
>>  +++ b/include/linux/platform_data/x86/asus-wmi.h
>>  @@ -98,6 +98,9 @@
>>   /* dgpu on/off */
>>   #define ASUS_WMI_DEVID_DGPU		0x00090020
>> 
>>  +/* TUF laptop RGB power/state */
>>  +#define ASUS_WMI_DEVID_TUF_RGB_STATE	0x00100057
>>  +
>>   /* DSTS masks */
>>   #define ASUS_WMI_DSTS_STATUS_BIT	0x00000001
>>   #define ASUS_WMI_DSTS_UNKNOWN_BIT	0x00000002
> 


