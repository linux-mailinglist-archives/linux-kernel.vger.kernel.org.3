Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C10B587B0E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 12:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236615AbiHBKwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 06:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236637AbiHBKwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 06:52:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 924173AE7B
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 03:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659437558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ONdY1uU26I/pqX90cMLtiDatv96YYKFzgzSpZbjXCSI=;
        b=WUDB+CR95Kc3NaSUdJgI6YseJZ3X/Djm5rdI5aBNUyO2xFUKWTADQP2HpoCpD6K/EMndkg
        Sp/J+FbUBWUygy1WuGv6NmPpvNQFpe9rWGWVr9AjX7zLtVXPNooAj5pLhr3gjJVxoD/ywv
        pTsBx5cHtJRGwAHIriSOBQ+JNLCDFiQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-KZ5HsrqrO9ionF4bZQbYSw-1; Tue, 02 Aug 2022 06:52:35 -0400
X-MC-Unique: KZ5HsrqrO9ionF4bZQbYSw-1
Received: by mail-ed1-f69.google.com with SMTP id h6-20020a05640250c600b0043d9964d2ceso3670099edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 03:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ONdY1uU26I/pqX90cMLtiDatv96YYKFzgzSpZbjXCSI=;
        b=amPDhQXdEK5kmW0XlM/4lM9Dt8w1uqCTrAKTlAFTKxrTjo5MSYhihD/zSZpVjHfjdR
         vo9BnSCY4oibepexJjzMjzzkPmT8idPwXb8vmEdr78NAxgqpoArs8unE6KTDyurC/2n9
         b1nRfb1iOuqHBJXNkdwzPoc82/pIUspiCWYR9h4YGhyeE3E7Z0CM57hY2N0gJ0H1PrLQ
         zUVYY3ddlCv0lgd+4rAw3zfRxIglwsjNUWIc7HD1zpeimEbrDc4z8TmjLMwjesgY/QpN
         yVTky3JhOjEFxqBvLjPDNJj6gSk0M6bsXAxshmYUaROV4Q32peEhBKiOao007rtyK2oF
         Bsig==
X-Gm-Message-State: ACgBeo0Jc5jYALz9hh+p1vGcP6aAq695Hbr7GBzs6qtlUPqcayFoJkyY
        /TJdq2lPwVDJK4JBkcR6u+0nqOaNobFe0Y06hJ5SeNqP2S3iEwm2Gr5Bkrs5fAEe4V09Yjrv/il
        ytx/MkmCrVezCCPelCrgj/dvX
X-Received: by 2002:a05:6402:268d:b0:43d:b9d0:9efc with SMTP id w13-20020a056402268d00b0043db9d09efcmr7481737edd.92.1659437554281;
        Tue, 02 Aug 2022 03:52:34 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6+oSfvV8yhZ6+wVMrVI1YAlOUICCAm7C/Wgk8tQ9rvCBPLUlUMMZEZjaO88o6wWcF5WBPqzg==
X-Received: by 2002:a05:6402:268d:b0:43d:b9d0:9efc with SMTP id w13-20020a056402268d00b0043db9d09efcmr7481721edd.92.1659437554076;
        Tue, 02 Aug 2022 03:52:34 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id cq27-20020a056402221b00b0043d482188b4sm5337166edb.29.2022.08.02.03.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 03:52:33 -0700 (PDT)
Message-ID: <ca747bd7-fe05-6b42-df0b-a6bc3bf0aa2b@redhat.com>
Date:   Tue, 2 Aug 2022 12:52:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] platform/x86: dell-privacy: convert to use dev_groups
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        platform-driver-x86@vger.kernel.org
Cc:     Perry Yuan <Perry.Yuan@dell.com>,
        Mark Gross <markgross@kernel.org>, Dell.Client.Kernel@dell.com,
        linux-kernel@vger.kernel.org
References: <20220729115302.2258296-1-gregkh@linuxfoundation.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220729115302.2258296-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/29/22 13:53, Greg Kroah-Hartman wrote:
> The driver core supports the ability to handle the creation and removal
> of device-specific sysfs files in a race-free manner.  Take advantage of
> that by converting this driver to use this by moving the sysfs
> attributes into a group and assigning the dev_groups pointer to it.
> 
> Cc: Perry Yuan <Perry.Yuan@dell.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Mark Gross <markgross@kernel.org>
> Cc: Dell.Client.Kernel@dell.com
> Cc: platform-driver-x86@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Patches which are added to review-hans now are intended for
the next rc1. This branch will get rebased to the next rc1 when
it is out and after the rebasing the contents of review-hans
will be pushed to the platform-drivers-x86/for-next branch.

Regards,

Hans

> ---
>  drivers/platform/x86/dell/dell-wmi-privacy.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-wmi-privacy.c b/drivers/platform/x86/dell/dell-wmi-privacy.c
> index 074b7e68c227..c82b3d6867c5 100644
> --- a/drivers/platform/x86/dell/dell-wmi-privacy.c
> +++ b/drivers/platform/x86/dell/dell-wmi-privacy.c
> @@ -174,15 +174,12 @@ static ssize_t dell_privacy_current_state_show(struct device *dev,
>  static DEVICE_ATTR_RO(dell_privacy_supported_type);
>  static DEVICE_ATTR_RO(dell_privacy_current_state);
>  
> -static struct attribute *privacy_attributes[] = {
> +static struct attribute *privacy_attrs[] = {
>  	&dev_attr_dell_privacy_supported_type.attr,
>  	&dev_attr_dell_privacy_current_state.attr,
>  	NULL,
>  };
> -
> -static const struct attribute_group privacy_attribute_group = {
> -	.attrs = privacy_attributes
> -};
> +ATTRIBUTE_GROUPS(privacy);
>  
>  /*
>   * Describes the Device State class exposed by BIOS which can be consumed by
> @@ -342,10 +339,6 @@ static int dell_privacy_wmi_probe(struct wmi_device *wdev, const void *context)
>  	if (ret)
>  		return ret;
>  
> -	ret = devm_device_add_group(&wdev->dev, &privacy_attribute_group);
> -	if (ret)
> -		return ret;
> -
>  	if (priv->features_present & BIT(DELL_PRIVACY_TYPE_AUDIO)) {
>  		ret = dell_privacy_leds_setup(&priv->wdev->dev);
>  		if (ret)
> @@ -374,6 +367,7 @@ static const struct wmi_device_id dell_wmi_privacy_wmi_id_table[] = {
>  static struct wmi_driver dell_privacy_wmi_driver = {
>  	.driver = {
>  		.name = "dell-privacy",
> +		.dev_groups = privacy_groups,
>  	},
>  	.probe = dell_privacy_wmi_probe,
>  	.remove = dell_privacy_wmi_remove,

