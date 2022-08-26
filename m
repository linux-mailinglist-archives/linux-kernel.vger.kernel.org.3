Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2070A5A2557
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245304AbiHZKCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343653AbiHZKB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:01:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8A1D570D
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661508082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NuQxKCRACYMuhvoslJjsX82dVs3K5Bc7MVUK4nimAtA=;
        b=PwHeXnIv4+z/dvM7yI90iHu0tc+sINTBhYO2C07ES0c1KpuRlw/4zoa9cohZnPOkKE3DWu
        VI4jAcoJQzPwfYilo8bxBwFzEYT+hcTLnKVUk44vFw/QiQ/XPYPHZEoYdQNEiAz/ZEiFB8
        YBunRG/2FYZMYJBSf2iNZdU3aFxPO/4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-481-kPMFSkmiOyKKaUxGIYmXzA-1; Fri, 26 Aug 2022 06:01:21 -0400
X-MC-Unique: kPMFSkmiOyKKaUxGIYmXzA-1
Received: by mail-ed1-f70.google.com with SMTP id p4-20020a056402500400b00447e8b6f62bso834703eda.17
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:01:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=NuQxKCRACYMuhvoslJjsX82dVs3K5Bc7MVUK4nimAtA=;
        b=H3Moi2RcufCb81WJDfTZ/cSkjJYiItPlxdFWOEX/FX4E68sP0gB9L0UBsfbqnyLZCC
         oWHXeAkrI0MVEG/7VoFkFZY2PvpYo3Jp2VgcNOfci//bwXpcHRYlYVfgO7YUBe2udpa5
         j8OkPMVawFfH+dXPV1DMjAAddHR5/3rXCRMwyGfGoBUYdlr/jLJPFTdaIXUE637o61dU
         KPmnPepNV8h4CTBatrirRSgeB1vRbJ+TSSy9UIaWcqsBwv7G6uaCuAeDd5EZNjO81rMW
         K8eY2pLAHYL8rwETvsn7f+3ChuuQYW3ND+gbaNWF8f1Wyy9b0s0q54yWrOf1rd1pmvJa
         ssGw==
X-Gm-Message-State: ACgBeo1B1XmWOeBx4JLOvvfARzaTO2aCnQZXVPIhtzdn9ob85jmLVeTq
        60iy39CfbHeWM04CBVVLxjxklHgNgN2WouUyeovkT2Q0oUNzQIulJyzs0wwv+4OHD+qjleX7x6h
        7D1pgi3271+2fMD2csYkql+xv
X-Received: by 2002:a17:907:d08:b0:72f:b107:c07a with SMTP id gn8-20020a1709070d0800b0072fb107c07amr5080408ejc.340.1661508080120;
        Fri, 26 Aug 2022 03:01:20 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5rLpuvk4e9zX9oMu00zx556BESJ4F7cOoQCb3jzdcWsWsHCzorutO71yjsgkCLPN8rdpHPMQ==
X-Received: by 2002:a17:907:d08:b0:72f:b107:c07a with SMTP id gn8-20020a1709070d0800b0072fb107c07amr5080384ejc.340.1661508079855;
        Fri, 26 Aug 2022 03:01:19 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id 6-20020a170906310600b0073c10031dc9sm208866ejx.80.2022.08.26.03.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 03:01:19 -0700 (PDT)
Message-ID: <b0d54cbc-ea5d-4cad-5017-c4afd4462942@redhat.com>
Date:   Fri, 26 Aug 2022 12:01:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] platform: move from strlcpy with unused retval to strscpy
Content-Language: en-US
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Cc:     Mark Gross <markgross@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Divya Bharathi <divya.bharathi@dell.com>,
        Prasanth Ksr <prasanth.ksr@dell.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com,
        ibm-acpi-devel@lists.sourceforge.net
References: <20220818210058.7229-1-wsa+renesas@sang-engineering.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220818210058.7229-1-wsa+renesas@sang-engineering.com>
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

On 8/18/22 23:00, Wolfram Sang wrote:
> Follow the advice of the below link and prefer 'strscpy' in this
> subsystem. Conversion is 1:1 because the return value is not used.
> Generated by a coccinelle script.
> 
> Link: https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com/
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

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
>  drivers/platform/surface/surface3_power.c          | 2 +-
>  drivers/platform/x86/dell/dell-wmi-sysman/sysman.c | 2 +-
>  drivers/platform/x86/intel/chtwc_int33fe.c         | 6 +++---
>  drivers/platform/x86/thinkpad_acpi.c               | 4 ++--
>  4 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/platform/surface/surface3_power.c b/drivers/platform/surface/surface3_power.c
> index 444ec81ba02d..4c53d116d59b 100644
> --- a/drivers/platform/surface/surface3_power.c
> +++ b/drivers/platform/surface/surface3_power.c
> @@ -519,7 +519,7 @@ static int mshw0011_probe(struct i2c_client *client)
>  	i2c_set_clientdata(client, data);
>  
>  	memset(&board_info, 0, sizeof(board_info));
> -	strlcpy(board_info.type, "MSHW0011-bat0", I2C_NAME_SIZE);
> +	strscpy(board_info.type, "MSHW0011-bat0", I2C_NAME_SIZE);
>  
>  	bat0 = i2c_acpi_new_device(dev, 1, &board_info);
>  	if (IS_ERR(bat0))
> diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
> index 636bdfa83284..0a6411a8a104 100644
> --- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
> +++ b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
> @@ -270,7 +270,7 @@ void strlcpy_attr(char *dest, char *src)
>  	size_t len = strlen(src) + 1;
>  
>  	if (len > 1 && len <= MAX_BUFF)
> -		strlcpy(dest, src, len);
> +		strscpy(dest, src, len);
>  
>  	/*len can be zero because any property not-applicable to attribute can
>  	 * be empty so check only for too long buffers and log error
> diff --git a/drivers/platform/x86/intel/chtwc_int33fe.c b/drivers/platform/x86/intel/chtwc_int33fe.c
> index c52ac23e2331..1ea989df513c 100644
> --- a/drivers/platform/x86/intel/chtwc_int33fe.c
> +++ b/drivers/platform/x86/intel/chtwc_int33fe.c
> @@ -270,7 +270,7 @@ cht_int33fe_register_max17047(struct device *dev, struct cht_int33fe_data *data)
>  	}
>  
>  	memset(&board_info, 0, sizeof(board_info));
> -	strlcpy(board_info.type, "max17047", I2C_NAME_SIZE);
> +	strscpy(board_info.type, "max17047", I2C_NAME_SIZE);
>  	board_info.dev_name = "max17047";
>  	board_info.fwnode = fwnode;
>  	data->battery_fg = i2c_acpi_new_device(dev, 1, &board_info);
> @@ -361,7 +361,7 @@ static int cht_int33fe_typec_probe(struct platform_device *pdev)
>  	}
>  
>  	memset(&board_info, 0, sizeof(board_info));
> -	strlcpy(board_info.type, "typec_fusb302", I2C_NAME_SIZE);
> +	strscpy(board_info.type, "typec_fusb302", I2C_NAME_SIZE);
>  	board_info.dev_name = "fusb302";
>  	board_info.fwnode = fwnode;
>  	board_info.irq = fusb302_irq;
> @@ -381,7 +381,7 @@ static int cht_int33fe_typec_probe(struct platform_device *pdev)
>  	memset(&board_info, 0, sizeof(board_info));
>  	board_info.dev_name = "pi3usb30532";
>  	board_info.fwnode = fwnode;
> -	strlcpy(board_info.type, "pi3usb30532", I2C_NAME_SIZE);
> +	strscpy(board_info.type, "pi3usb30532", I2C_NAME_SIZE);
>  
>  	data->pi3usb30532 = i2c_acpi_new_device(dev, 3, &board_info);
>  	if (IS_ERR(data->pi3usb30532)) {
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 22d4e8633e30..8dad0428a83c 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -7623,9 +7623,9 @@ static int __init volume_create_alsa_mixer(void)
>  	data = card->private_data;
>  	data->card = card;
>  
> -	strlcpy(card->driver, TPACPI_ALSA_DRVNAME,
> +	strscpy(card->driver, TPACPI_ALSA_DRVNAME,
>  		sizeof(card->driver));
> -	strlcpy(card->shortname, TPACPI_ALSA_SHRTNAME,
> +	strscpy(card->shortname, TPACPI_ALSA_SHRTNAME,
>  		sizeof(card->shortname));
>  	snprintf(card->mixername, sizeof(card->mixername), "ThinkPad EC %s",
>  		 (thinkpad_id.ec_version_str) ?

