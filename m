Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9725A9BCB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 17:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbiIAPe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 11:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbiIAPev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:34:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4952F5
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 08:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662046486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EdU6kcxk31+NfDy/R26HslGdp1j7dLdIqqiHO/JJmC8=;
        b=XUVMCgmIt7zgb1iQZn7DdvpuhJrMbmVssMFRazT7OQzsFvSO2M31mnm9UMiwfyF1ku4uay
        QIp13hWRg61FUeF5nIc6kds+VGfLT1OpQznMn96BArBP/ZrY2guSRcAeyUDu5QYPpST1UU
        cXvWuOHn4gjBh2IYnwYcq+S+2rzvi+I=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-341-f114iezFNdqHo0w8Tg7lpQ-1; Thu, 01 Sep 2022 11:34:45 -0400
X-MC-Unique: f114iezFNdqHo0w8Tg7lpQ-1
Received: by mail-ej1-f71.google.com with SMTP id sb14-20020a1709076d8e00b0073d48a10e10so7098545ejc.16
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 08:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=EdU6kcxk31+NfDy/R26HslGdp1j7dLdIqqiHO/JJmC8=;
        b=RuBrheUg6ZjMss4vyliSqKCjzAszdds0MPRr79bMxSZoH6dMDqIGXT09W6qqMC+qQb
         /rPiasfzUMHP94+zdrmqvBmyp8Xq9fzAObL0AislaketPHbvvFY3aCEs6t/xogq7eDGg
         IMrgJBRF9qt8l6M+YRBJ/75yOal3SWG/ba4GjoHH2+t316n84kifUHkLYecrO91L+U9/
         4l+ouRWJwghMxIEp+aJG+od6SN1EaihJAaS1L91v3a9s/N44C1vJDwrTH9c4WpKVlDdF
         1jAvwkaM93S+kMOty/hZQoh4LZM+EPKO/rZegcodpWN6S7/7x7aZsJMpENlRtlunV0HV
         VDPA==
X-Gm-Message-State: ACgBeo2Z8I8vt5FOt/BdvXZ2/KxyQ5powWjfA+32azUIvwt1QtUDp9pk
        hAktW3OHvPlgnK7fASRw1Ih1eQnemmWMeFcdqblQUAnKz6H0UC+R1xJuBk+5MuqJldK3j3OJrOK
        dGPPFTFp1M1G3ZJhcrEo4wPX9
X-Received: by 2002:a17:907:3e06:b0:733:693:600e with SMTP id hp6-20020a1709073e0600b007330693600emr22714944ejc.410.1662046484224;
        Thu, 01 Sep 2022 08:34:44 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6CGvsVadtU/FKpog77yx9E+0aH5YULUA3W4O38vGBKP5LbcMpEQQEm87QgPg9ZZYddq9+tLA==
X-Received: by 2002:a17:907:3e06:b0:733:693:600e with SMTP id hp6-20020a1709073e0600b007330693600emr22714935ejc.410.1662046484002;
        Thu, 01 Sep 2022 08:34:44 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id dy17-20020a05640231f100b0043cc66d7accsm1518518edb.36.2022.09.01.08.34.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 08:34:43 -0700 (PDT)
Message-ID: <c23819ae-f7be-d07d-65bc-ea2c56a85b58@redhat.com>
Date:   Thu, 1 Sep 2022 17:34:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] asus-wmi: Increase FAN_CURVE_BUF_LEN to 32
Content-Language: en-US
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, markgross@kernel.org
References: <20220828074638.5473-1-luke@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220828074638.5473-1-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/28/22 09:46, Luke D. Jones wrote:
> Fix for TUF laptops returning with an -ENOSPC on calling
> asus_wmi_evaluate_method_buf() when fetching default curves. The TUF method
> requires at least 32 bytes space.
> 
> This also moves and changes the pr_debug() in fan_curve_check_present() to
> pr_warn() in fan_curve_get_factory_default() so that there is at least some
> indication in logs of why it fails.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> ---
>  drivers/platform/x86/asus-wmi.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 3d9fd58573f9..11203213e00d 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -108,7 +108,7 @@ module_param(fnlock_default, bool, 0444);
>  #define WMI_EVENT_MASK			0xFFFF
>  
>  #define FAN_CURVE_POINTS		8
> -#define FAN_CURVE_BUF_LEN		(FAN_CURVE_POINTS * 2)
> +#define FAN_CURVE_BUF_LEN		32
>  #define FAN_CURVE_DEV_CPU		0x00
>  #define FAN_CURVE_DEV_GPU		0x01
>  /* Mask to determine if setting temperature or percentage */
> @@ -2383,8 +2383,10 @@ static int fan_curve_get_factory_default(struct asus_wmi *asus, u32 fan_dev)
>  	curves = &asus->custom_fan_curves[fan_idx];
>  	err = asus_wmi_evaluate_method_buf(asus->dsts_id, fan_dev, mode, buf,
>  					   FAN_CURVE_BUF_LEN);
> -	if (err)
> +	if (err) {
> +		pr_warn("%s (0x%08x) failed: %d\n", __func__, fan_dev, err);
>  		return err;
> +	}
>  
>  	fan_curve_copy_from_buf(curves, buf);
>  	curves->device_id = fan_dev;
> @@ -2402,9 +2404,6 @@ static int fan_curve_check_present(struct asus_wmi *asus, bool *available,
>  
>  	err = fan_curve_get_factory_default(asus, fan_dev);
>  	if (err) {
> -		pr_debug("fan_curve_get_factory_default(0x%08x) failed: %d\n",
> -			 fan_dev, err);
> -		/* Don't cause probe to fail on devices without fan-curves */
>  		return 0;
>  	}
>  

