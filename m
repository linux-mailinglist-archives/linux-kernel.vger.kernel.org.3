Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F392489675
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 11:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244015AbiAJKfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 05:35:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24930 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243947AbiAJKfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 05:35:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641810934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E4kpJY+fWYZlv3zEbR6eWYKWRjET+O+ZJM7TtUKBQKc=;
        b=VBaTs8zYr02RIOSuNnRY0LlkbT2YnWFl8Y5kAlitFyRJUvNaIiGyqBLvI7rloxwKE4mCzf
        7O3sxuVDShd9/1GZwSPngO2EL3UZ+OB/edPRUzRWLCLNMhVx0SFYp9UwkN7qzDKe/OApue
        Zwe3rH2U7RC0BogvldO5UCdH24SQs7Q=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-151-slZTGeLdNbOOcb7YPN_lbQ-1; Mon, 10 Jan 2022 05:35:32 -0500
X-MC-Unique: slZTGeLdNbOOcb7YPN_lbQ-1
Received: by mail-ed1-f70.google.com with SMTP id t1-20020a056402524100b003f8500f6e35so9798870edd.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 02:35:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=E4kpJY+fWYZlv3zEbR6eWYKWRjET+O+ZJM7TtUKBQKc=;
        b=rUdBOg1I4W+ODTwgRoBJ0YKVv2bsWTxs3V7TVkd15DQUOf4eYqOWxbIcVdeGRV+8iO
         G2uU+8vdlZLXyIvaPSy8fimmBwInRSh7QQE1aVUirOhfX95alOM20Otuwg8jtOxzJetx
         PBXLJikHnzFXbEg8NMII0o8Y1dgzjibzq3rl2aUYfY+d5KVSdgT85YMezIIEkSdarB63
         JtyM5uoPakcWpN7uxCRxDfKLj9uiN79BqLaCnn2hpnxhIY0czcxTWbrRlDkhIi//kFs+
         v3eZLUKhV0AsBH3k444hEaUg++4yiwCJ1JUlNWUcZ687dq3fYFNt22ttE/WB2O+w0TDL
         A0TA==
X-Gm-Message-State: AOAM533wOcvbUCvwBGLR/2dDR8tZ0MCzSd62LFKx+Uapnj8O4pTUSar+
        lG9AwBZsIIVzitK2AVnJ2Sb9RlPNl9DuTybXOvXes5h3X0OfjTMa1Muq/czWgbH03X9zcG7R1tU
        UHIJYI3oNcy1TFBt1EbzAwIUy
X-Received: by 2002:aa7:c151:: with SMTP id r17mr14853235edp.351.1641810931227;
        Mon, 10 Jan 2022 02:35:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzImcSKUBrZZ7RKRrpG9G9kOCJpBLrSILCeBEGF+UJIoRcruiKac3PsZALcBM+hAOvsWhKO9A==
X-Received: by 2002:aa7:c151:: with SMTP id r17mr14853221edp.351.1641810931065;
        Mon, 10 Jan 2022 02:35:31 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id f18sm3360182edf.95.2022.01.10.02.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 02:35:30 -0800 (PST)
Message-ID: <70ac5af2-d5ee-1fd9-6091-9ae61c9e6446@redhat.com>
Date:   Mon, 10 Jan 2022 11:35:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] platform/x86: x86-android-tablets: Fix the buttons on CZC
 P10T tablet
Content-Language: en-US
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220110063512.273252-1-lkundrak@v3.sk>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220110063512.273252-1-lkundrak@v3.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/10/22 07:35, Lubomir Rintel wrote:
> This switches the P10T tablet to "Android" mode, where the Home button
> sends a single sancode instead of a Windows-specific key combination and
> the other button doesn't disable the Wi-Fi.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Guess I better send out the patch adding the init() callback from
my WIP tree then, to give that one a chance to get some comments
from others, so that I can apply these in the right order :)

Regards,

Hans



> ---
> This applies on top of v5.16-rc8-792-gf3a343366741, commit
> f3a3433667418e ("platform/x86: x86-android-tablets: Workaround Lenovo
> Yoga Tablet 2 1050 poweroff hang) from
> <https://github.com/jwrdegoede/linux-sunxi>.
> 
>  drivers/platform/x86/x86-android-tablets.c | 51 ++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/drivers/platform/x86/x86-android-tablets.c b/drivers/platform/x86/x86-android-tablets.c
> index 9333bbec33e9..c3d0714b588a 100644
> --- a/drivers/platform/x86/x86-android-tablets.c
> +++ b/drivers/platform/x86/x86-android-tablets.c
> @@ -776,6 +776,39 @@ static const struct x86_dev_info xiaomi_mipad2_info __initconst = {
>  	.i2c_client_count = ARRAY_SIZE(xiaomi_mipad2_i2c_clients),
>  };
>  
> +#define CZC_EC_EXTRA_PORT	0x68
> +#define CZC_EC_ANDROID_KEYS	0x63
> +
> +static int __init x86_czc_p10t_init(void)
> +{
> +	/*
> +	 * The device boots up in "Windows 7" mode, when the home button sends a
> +	 * Windows specific key sequence (Left Meta + D) and the second button
> +	 * sends an unknown one while also toggling the Radio Kill Switch.
> +	 * This is a surprising behavior when the second button is labeled "Back".
> +	 *
> +	 * The vendor-supplied Android-x86 build switches the device to a "Android"
> +	 * mode by writing value 0x63 to the I/O port 0x68. This just seems to just
> +	 * set bit 6 on address 0x96 in the EC region; switching the bit directly
> +	 * seems to achieve the same result. It uses a "p10t_switcher" to do the
> +	 * job. It doesn't seem to be able to do anything else, and no other use
> +	 * of the port 0x68 is known.
> +	 *
> +	 * In the Android mode, the home button sends just a single scancode,
> +	 * which can be handled in Linux userspace more reasonably and the back
> +	 * button only sends a scancode without toggling the kill switch.
> +	 * The scancode can then be mapped either to Back or RF Kill functionality
> +	 * in userspace, depending on how the button is labeled on that particular
> +	 * model.
> +	 */
> +	outb(CZC_EC_ANDROID_KEYS, CZC_EC_EXTRA_PORT);
> +	return 0;
> +}
> +
> +static const struct x86_dev_info czc_p10t __initconst = {
> +	.init = x86_czc_p10t_init,
> +};
> +
>  static const struct dmi_system_id x86_android_tablet_ids[] __initconst = {
>  	{
>  		/* Asus MeMO Pad 7 ME176C */
> @@ -803,6 +836,24 @@ static const struct dmi_system_id x86_android_tablet_ids[] __initconst = {
>  		},
>  		.driver_data = (void *)&chuwi_hi8_info,
>  	},
> +	{
> +		/* CZC P10T */
> +		.ident = "CZC ODEON TPC-10 (\"P10T\")",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "CZC"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "ODEON*TPC-10"),
> +		},
> +		.driver_data = (void *)&czc_p10t,
> +	},
> +	{
> +		/* A variant of CZC P10T */
> +		.ident = "ViewSonic ViewPad 10",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ViewSonic"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "VPAD10"),
> +		},
> +		.driver_data = (void *)&czc_p10t,
> +	},
>  	{
>  		/* Lenovo Yoga Tablet 1050F/L */
>  		.matches = {
> 

