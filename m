Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD5248AB19
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 11:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348522AbiAKKNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 05:13:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40487 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237471AbiAKKNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 05:13:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641895987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WreWFaB4Gxto6/mYov8ZlQuAFaLTAqRUB+ETM8IIG10=;
        b=XoUKTzIP9dDTRYjyJ7zlldSo7swI9Gky/r+CbRpvUgdzvS2UYB9e4b0Nbf2oZqPzaLbTK8
        xFabbBu4zTBTXjGkphDPDY5yzYkA8qbJpK6j3fSvC3NrIr7vq5Rui2sCn/hI5CyYV7dl2+
        zRR5OEviGYHqw+zjLn2EHujQOM3++oI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-I0_iG93DPsClNj_3Olm8fg-1; Tue, 11 Jan 2022 05:13:04 -0500
X-MC-Unique: I0_iG93DPsClNj_3Olm8fg-1
Received: by mail-ed1-f71.google.com with SMTP id o20-20020a056402439400b003f83cf1e472so12886707edc.18
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 02:13:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WreWFaB4Gxto6/mYov8ZlQuAFaLTAqRUB+ETM8IIG10=;
        b=hk2dj06/PcNkklwB2SE1xasQt/t/sUAL1sRQEY53NgYLQcOWJQlLYl0AsQD0AW1OCQ
         PFFgXVZ0okXIwUkakgqfVOA2sBeNbHg+XKddzyxq1yluz9vW0Fl0RL4j6k4wrWQtHrhW
         hbfKpSDuHLmhUA8YZqapAu6AXxiYhVvwhrFHGPXjZw5s7YaEfufa0TvHWuhddm1kEXXc
         2tacFtsOMTavloKVv0LTr77+SNvvoOlW7lvzzxdVFznM2K+LvaXmaoSluZkQVl5OuYJg
         LG0u0zyPeTKH7wNZ+ilk/RLBuTxuWFYaRiD3N1uCdtZDf0hYNeWYgZ0wDp1XULxEWZgv
         fheQ==
X-Gm-Message-State: AOAM5304kDLrlvomNp9vVXC7yrO5gwKbexCJvxTxwjnRp4IeDjrckDPr
        WEO1bbeBfO/LjCTrphg1YguL9Ff9GI9ZF8gokI7QZErMN8Ijz+z3s8Pg41Ck8V7E2yeh1L/fZDc
        4K59hcPjBZW+gDa94SuNNzErK
X-Received: by 2002:a17:906:2bc3:: with SMTP id n3mr3139438ejg.332.1641895983202;
        Tue, 11 Jan 2022 02:13:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyAGo+oK7aHHoTUijgOi9Hkqbb1oeJJ7Np/sJSZtQfl8r8sP+C8yD00nvfGR8/QB3ztmWe6gw==
X-Received: by 2002:a17:906:2bc3:: with SMTP id n3mr3139421ejg.332.1641895983014;
        Tue, 11 Jan 2022 02:13:03 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id d17sm3397439ejd.217.2022.01.11.02.13.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 02:13:02 -0800 (PST)
Message-ID: <65f5e5de-6e16-f522-4c06-eb91e8be1250@redhat.com>
Date:   Tue, 11 Jan 2022 11:13:02 +0100
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

Thank you for your patches, I've applied both patches to
my review-hans  branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once 5.17-rc1 is out this branch will get rebased on top and
after I've run some tests on the rebased branch the patches there
will be added to the platform-drivers-x86/for-next branch and
eventually will be included in the pdx86 pull-request to Linus
for the next merge-window.

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

