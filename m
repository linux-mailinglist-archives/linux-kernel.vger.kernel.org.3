Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54F958D46A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 09:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236280AbiHIHUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 03:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiHIHUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 03:20:08 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB0120F51;
        Tue,  9 Aug 2022 00:20:07 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 8BF405C0170;
        Tue,  9 Aug 2022 03:20:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 09 Aug 2022 03:20:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1660029604; x=1660116004; bh=z/lji6THp5
        ab2brVrRyTIX82V15XNK/C/xKYsvsBkFE=; b=Hgg8hhY/Q/+ZqoO1JCqtJ/VIvJ
        y64B6uokNA7Jxpm4bGtWxB5F1wmcDp8yhnKazApSduF8A+YbTSkGHah2hCxpdQZE
        qZ+CWEH0DGYNfdASi9EnbTGuEveLacMwvqFVyql6pHsMlmTHu4f9fqfgAlngC2pZ
        /i6IRRG7A8rBzE7ibASqSmIq0OaheyUtMQ05KRqAeICZwenBCx5OaGBIvphxuo4i
        BYZ1MQmBdv/14lC7BCA/QV2mqZZFkXVNp1MdhlNdXpNw1wHdhdRH1sDJwlTbKxoi
        HlOu7jXiwNk3YEs43shCDuVwOD0/TMlZG8h6EmAeisXwgRwL5KOjmzS4OFLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660029604; x=1660116004; bh=z/lji6THp5ab2brVrRyTIX82V15X
        NK/C/xKYsvsBkFE=; b=fd75fArrHTd/QLAFElQGomCliUUdju0Z6P1UTvaYhtiG
        Qwp8DQJ2hIRT1WOjacjwcKyok/eNO3W2PGXQ4iAHPqzlL8FmNytaMBBqtOHL26LF
        DFvs1QHEjUyrCWoyskL4+4oJyObi8hQ0TgHgRkxUcN/jcXPEsqEeRSw/tVnKL427
        AW8VN4Xbp3Lq9FbkI8d4UfrNmb2fCX+V0itQVMcgyrWVQvHxTRFX+IUhqaHsi9aI
        YKMM0r4s5UhNQ4GdUC6yDyaTN41ISgg/kWqNh0CLQdXGJXxpu5XlS702n6l4cm3y
        F3labeW1rkWqlo6TJyfY69VdQxz4dwU9ri9KaW7FPQ==
X-ME-Sender: <xms:pAryYkkLcdfy7ugLpa3ADlzgHSzh2IhD6ZD-kCOU63qZhlUYeQtETQ>
    <xme:pAryYj2Ah0jU8UdxwBuSAnvpgzaW9jiT1jQtkqkPhxKyQjhcK8Z9r5-_yaNwDh8LI
    n6MijAujU7CGNPCH-U>
X-ME-Received: <xmr:pAryYirAhLTwogM77eJi8EtdwByxzCWTPhHD9LaFrDUsQvn38FFSfT-aS7UOkl8fkKMQ6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefledguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhuffvvefkjghfofggtgesth
    dtredtredtvdenucfhrhhomhepnfhukhgvucflohhnvghsuceolhhukhgvsehljhhonhgv
    shdruggvvheqnecuggftrfgrthhtvghrnhepvddvgeeltdehfeeijefgveegfeeihfdtve
    etfeetudfhvedtfeeltefhteegledunecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:pAryYgn6xvixcmNVxHuHzwvLw6Xr4uUMOoxRhwQS9b9se4MNzN_17Q>
    <xmx:pAryYi1Q7DtsAqnjwlOVqxSorfwfinFhpm_CExoG6Wg86tGRdaBtwA>
    <xmx:pAryYnstCUTgNgodZdh8SyydHEXRq1OHaUQSHzcGutDm1Qqi7sG0gA>
    <xmx:pAryYnyn3VUsqp6cmf5s0dWj3rmcEPuz8kC10lQGMYxnW1jUGXz3Ng>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Aug 2022 03:19:59 -0400 (EDT)
Date:   Tue, 09 Aug 2022 19:19:43 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v3 6/6] asus-wmi: Support the hardware GPU MUX on some
 laptops
To:     hdegoede@redhat.com
Cc:     andy.shevchenko@gmail.com, pobrn@protonmail.com, pavel@ucw.cz,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <V07CGR.EVA9B3D6MNUI@ljones.dev>
In-Reply-To: <20220809025054.1626339-7-luke@ljones.dev>
References: <20220809025054.1626339-1-luke@ljones.dev>
        <20220809025054.1626339-7-luke@ljones.dev>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch still needs some work. I've been analysing the various dumps 
I've collected over the past 2 years.

Some laptops return a `0xFFFFFFFE` in response to query of this method, 
and do not have a corresponding set method. To work around it I was 
using `if (result == 0xFFFFFFFE) return 0;`, but, I'm unsure if 
`0xFFFFFFFE` is actually a valid response in the first place. Is it?

Additionally to this, I should have been reading the devstate in the 
related _show(), not returning the stored value. And this should be 
done for the egpu_enable and dgpu_disable attributes also.

Lastly, some laptops have a valid return for the getter, but no setter 
method.. I'm not sure what to do about this.

Are there any issues with me adding more patches to this series? In 
particular I think I need to add patches for the above mentioned 
things, and I should add the "asus-wmi: Modify behaviour of Fn+F5 fan 
key" patches too, I'm beginning to get merge conflicts in testing, and 
all the work I'm doing is becoming unwieldy.

Kind regards,
Luke.


On Tue, Aug 9 2022 at 14:50:54 +1200, Luke D. Jones <luke@ljones.dev> 
wrote:
> Support the hardware GPU MUX switch available on some models. This
> switch can toggle the MUX between:
> 
> - 0, Dedicated mode
> - 1, Optimus mode
> 
> Optimus mode is the regular iGPU + dGPU available, while dedicated
> mode switches the system to have only the dGPU available.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  .../ABI/testing/sysfs-platform-asus-wmi       |  9 ++
>  drivers/platform/x86/asus-wmi.c               | 91 
> +++++++++++++++++++
>  include/linux/platform_data/x86/asus-wmi.h    |  3 +
>  3 files changed, 103 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi 
> b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> index 541dbfbbbb26..d483bc3cb2e6 100644
> --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
> +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> @@ -67,6 +67,15 @@ Description:
>  			* 0 - Disable,
>  			* 1 - Enable,
> 
> +What:		/sys/devices/platform/<platform>/gpu_mux_mode
> +Date:		Aug 2022
> +KernelVersion:	6.0
> +Contact:	"Luke Jones" <luke@ljones.dev>
> +Description:
> +		Switch the GPU used by the hardware MUX:
> +			* 0 - Dedicated GPU,
> +			* 1 - Optimus mode,
> +
>  What:		/sys/devices/platform/<platform>/panel_od
>  Date:		Aug 2022
>  KernelVersion:	5.17
> diff --git a/drivers/platform/x86/asus-wmi.c 
> b/drivers/platform/x86/asus-wmi.c
> index 78f1f3af1b12..c5fa21370481 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -246,6 +246,9 @@ struct asus_wmi {
>  	bool dgpu_disable_available;
>  	bool dgpu_disable;
> 
> +	bool gpu_mux_mode_available;
> +	bool gpu_mux_mode;
> +
>  	bool keyboard_rgb_state_available;
>  	bool keyboard_rgb_mode_available;
>  	struct keyboard_rgb_led keyboard_rgb_led;
> @@ -750,6 +753,86 @@ static ssize_t egpu_enable_store(struct device 
> *dev,
> 
>  static DEVICE_ATTR_RW(egpu_enable);
> 
> +/* gpu mux switch 
> *************************************************************/
> +static int gpu_mux_mode_check_present(struct asus_wmi *asus)
> +{
> +	u32 result;
> +	int err;
> +
> +	asus->gpu_mux_mode_available = false;
> +
> +	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_GPU_MUX, &result);
> +	if (err) {
> +		if (err == -ENODEV)
> +			return 0;
> +		return err;
> +	}
> +
> +	if (result & ASUS_WMI_DSTS_PRESENCE_BIT) {
> +		asus->gpu_mux_mode_available = true;
> +		asus->gpu_mux_mode = result & ASUS_WMI_DSTS_STATUS_BIT;
> +	}
> +
> +	return 0;
> +}
> +
> +static int gpu_mux_mode_write(struct asus_wmi *asus)
> +{
> +	u32 retval;
> +	u8 value;
> +	int err;
> +
> +	/* Don't rely on type conversion */
> +	value = asus->gpu_mux_mode ? 1 : 0;
> +
> +	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_GPU_MUX, value, &retval);
> +	if (err) {
> +		pr_warn("Failed to set dGPU-only mode: %d\n", err);
> +		return err;
> +	}
> +
> +	if (retval > 1) {
> +		pr_warn("Failed to set dGPU-only mode (retval): 0x%x\n", retval);
> +		return -EIO;
> +	}
> +
> +	sysfs_notify(&asus->platform_device->dev.kobj, NULL, 
> "gpu_mux_mode");
> +
> +	return 0;
> +}
> +
> +static ssize_t gpu_mux_mode_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct asus_wmi *asus = dev_get_drvdata(dev);
> +	u8 mode = asus->gpu_mux_mode;
> +
> +	return sysfs_emit(buf, "%d\n", mode);
> +}
> +
> +static ssize_t gpu_mux_mode_store(struct device *dev,
> +				    struct device_attribute *attr,
> +				    const char *buf, size_t count)
> +{
> +	bool optimus;
> +	int result;
> +
> +	struct asus_wmi *asus = dev_get_drvdata(dev);
> +
> +	result = kstrtobool(buf, &optimus);
> +	if (result)
> +		return result;
> +
> +	asus->gpu_mux_mode = optimus;
> +
> +	result = gpu_mux_mode_write(asus);
> +	if (result)
> +		return result;
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RW(gpu_mux_mode);
> +
>  /* TUF Laptop Keyboard RGB Modes 
> **********************************************/
>  static int keyboard_rgb_check_present(struct asus_wmi *asus)
>  {
> @@ -3496,6 +3579,7 @@ static struct attribute *platform_attributes[] 
> = {
>  	&dev_attr_touchpad.attr,
>  	&dev_attr_egpu_enable.attr,
>  	&dev_attr_dgpu_disable.attr,
> +	&dev_attr_gpu_mux_mode.attr,
>  	&dev_attr_keyboard_rgb_save.attr,
>  	&dev_attr_keyboard_rgb_mode.attr,
>  	&dev_attr_keyboard_rgb_speed.attr,
> @@ -3531,6 +3615,8 @@ static umode_t asus_sysfs_is_visible(struct 
> kobject *kobj,
>  		ok = asus->egpu_enable_available;
>  	else if (attr == &dev_attr_dgpu_disable.attr)
>  		ok = asus->dgpu_disable_available;
> +	else if (attr == &dev_attr_gpu_mux_mode.attr)
> +		ok = asus->gpu_mux_mode_available;
>  	else if (attr == &dev_attr_keyboard_rgb_save.attr)
>  		ok = asus->keyboard_rgb_mode_available;
>  	else if (attr == &dev_attr_keyboard_rgb_mode.attr)
> @@ -3810,6 +3896,10 @@ static int asus_wmi_add(struct platform_device 
> *pdev)
>  	if (err)
>  		goto fail_dgpu_disable;
> 
> +	err = gpu_mux_mode_check_present(asus);
> +	if (err)
> +		goto fail_gpu_mux_mode;
> +
>  	err = keyboard_rgb_check_present(asus);
>  	if (err)
>  		goto fail_keyboard_rgb_mode;
> @@ -3932,6 +4022,7 @@ static int asus_wmi_add(struct platform_device 
> *pdev)
>  fail_fan_boost_mode:
>  fail_egpu_enable:
>  fail_dgpu_disable:
> +fail_gpu_mux_mode:
>  fail_keyboard_rgb_mode:
>  fail_keyboard_rgb_state:
>  fail_platform:
> diff --git a/include/linux/platform_data/x86/asus-wmi.h 
> b/include/linux/platform_data/x86/asus-wmi.h
> index b5c966798ef8..3faeb98f6ea9 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -98,6 +98,9 @@
>  /* dgpu on/off */
>  #define ASUS_WMI_DEVID_DGPU		0x00090020
> 
> +/* gpu mux switch, 0 = dGPU, 1 = Optimus */
> +#define ASUS_WMI_DEVID_GPU_MUX	0x00090016
> +
>  /* TUF laptop RGB control */
>  #define ASUS_WMI_DEVID_TUF_RGB_MODE	0x00100056
>  /* TUF laptop RGB state control */
> --
> 2.37.1
> 


