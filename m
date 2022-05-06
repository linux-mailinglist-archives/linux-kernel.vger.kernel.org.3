Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CE051D53C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 12:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390831AbiEFKOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 06:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245391AbiEFKO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 06:14:28 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59A9E18B05
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 03:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651831844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yNzXFFqULcro2Xm8jKzvPPNgAioEvCfNrUO5846hy+E=;
        b=YBhPivDggm/IU7YsAIFlRUN+3m2rkZUr30MGvXH299VpRMks2Yzdw39/oFWSj29AB9MZiG
        zd+wsQ8ug+1Gri73G9Mym1i+xbpy509kbSX8qS9QT74YGSi54deJ9xsPn0Cd1SO/aCsY0j
        tCaRJihcNoHXkUJNQq/8Nk0XeNg32ss=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135-giUpH6hMOTOz3eB4DiYKAg-1; Fri, 06 May 2022 06:10:42 -0400
X-MC-Unique: giUpH6hMOTOz3eB4DiYKAg-1
Received: by mail-ed1-f71.google.com with SMTP id cw28-20020a056402229c00b00425dda4b67dso3764521edb.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 03:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yNzXFFqULcro2Xm8jKzvPPNgAioEvCfNrUO5846hy+E=;
        b=4agtwF/FkgUWmIsYjVnb80Yeu0ystHMc7C82gqpwYuqTa+KMvTAGmRgA82LiA+5s/Z
         A7UWvmPBhw01qTIjFdwOBvhY1leoohAJGbVf0ogK/5UNsc2e73h4ts+YE+vycJTUukDC
         TqtddRzA3hBqVtIxiKakwj/j6KUpvMjxyAHPQ1/cVFHowNPhUOP6pzf9646q7k+9FrBP
         RGTUo8S4xLCA93ifxhpQeiCuiwmdBezVYo5lQHFHTCzf9I3NTZEG3hKlqbNksUP85hJ2
         gz2Bdl9FcijKCdA70jgemstKiFkHyEJhbww3l0NRcrEa6rJhiRy6zxKXt+pDmiL0pysM
         A/Mg==
X-Gm-Message-State: AOAM530tDkqe4ThK58PrNPVHeYyEfkQnLiH82QVOIgQqar8bwlmSfXmF
        +rQ6wEjA0/dSObBcJE+pOonx4D6tAF1G8QLBwgE8d7RBNKAIsYPOFMW8klLaPVomb2Mnh4UDNjY
        NoWCVHYLAyvottBigOVKbvkbm
X-Received: by 2002:aa7:cb4d:0:b0:425:e24f:96ba with SMTP id w13-20020aa7cb4d000000b00425e24f96bamr2640517edt.214.1651831841742;
        Fri, 06 May 2022 03:10:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyls/i/youBNjCIOSYH3hCA02MQVRuzS9ke3DkaRFVfIB53dB51/nYO/tu9/7fJlAhIOAdqhA==
X-Received: by 2002:aa7:cb4d:0:b0:425:e24f:96ba with SMTP id w13-20020aa7cb4d000000b00425e24f96bamr2640500edt.214.1651831841539;
        Fri, 06 May 2022 03:10:41 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id er22-20020a170907739600b006f4fc3850a5sm1494716ejc.32.2022.05.06.03.10.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 03:10:41 -0700 (PDT)
Message-ID: <b1ec2822-64dd-fef6-45b7-62f2518b1944@redhat.com>
Date:   Fri, 6 May 2022 12:10:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Add a few more models to
 s2idle quirk list
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Mark Pearson <markpearson@lenovo.com>
Cc:     Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Gross <mgross@linux.intel.com>,
        "open list:THINKPAD ACPI EXTRAS DRIVER" 
        <ibm-acpi-devel@lists.sourceforge.net>,
        "open list:THINKPAD ACPI EXTRAS DRIVER" 
        <platform-driver-x86@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220503183420.348-1-mario.limonciello@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220503183420.348-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/3/22 20:34, Mario Limonciello wrote:
> Users have reported that there are a few other DMI strings that T14 can
> go by, and so these models should also pick up the quirk to avoid the s2idle
> firmware bug.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Thanks, since the original patch was still in my review-hans
branch (and not yet in for-next) I've squashed this fix into
the original patch.

This squashing will hopefully make backporting these fixes
easier.

Regards,

Hans





> ---
>  drivers/platform/x86/thinkpad_acpi.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 2833609fade7..f3554068dd1e 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -4463,6 +4463,22 @@ static const struct dmi_system_id fwbug_list[] __initconst = {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "20UD"),
>  		}
>  	},
> +	{
> +		.ident = "T14 Gen1 AMD",
> +		.driver_data = &quirk_s2idle_bug,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "20UE"),
> +		}
> +	},
> +	{
> +		.ident = "T14s Gen1 AMD",
> +		.driver_data = &quirk_s2idle_bug,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "20UH"),
> +		}
> +	},
>  	{
>  		.ident = "P14s Gen1 AMD",
>  		.driver_data = &quirk_s2idle_bug,

