Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8014F62F3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235777AbiDFPMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235625AbiDFPLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:11:54 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFEA41A5DE;
        Wed,  6 Apr 2022 05:12:24 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id v75so2184515oie.1;
        Wed, 06 Apr 2022 05:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=XUCMZHvA32NVgMIdhMLnumEm8DgVyKPRqg3BU0uDa1o=;
        b=In93XZmgy9EURrXq2wy8Vc+CFbxUA1kCJ3+3BwBxUKxuamIuBf1eReQ9ppa9Ht51Ll
         uo7V9Oss+wis0AcJZfwVc6nwuljju4/6aZEByCwMiW6R0pJM/PMBoisBzFi5r3J8Iwvo
         2BzVdfOaWQKmIPwzU7L66q3NZCoRniRjP8xELbkcPrS+SVUJZTRCvj15k94BDfNLy1St
         HcSdC0d/DrpyFOiGpnRAW+dM5D/7cISi1+sFECMISJqyzF5prshNvgL7K544hMqsOiO8
         nxQ4OFcY4X0BkqSkU9LF8NgwNwm9nEsr740t7zUp486tEulD0czuseWtn51H7uWFlzqm
         YyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=XUCMZHvA32NVgMIdhMLnumEm8DgVyKPRqg3BU0uDa1o=;
        b=fipd77DfpUQ2OpO0L+CVOMyCueX/rT+gjenDK6n9Qs25zQfsN3OdQ3gUOdeQYI3Jm8
         5Lwi8TN4YT0RtqLKjXJUGXGJs/NtzG1sVXUl83qxnC0TsID6udxoefedlZMcfB1Sew8+
         kTMhU11Nq+9xR4r72GVbV4EImPOqQxYA5sNK8CttxzhP93oy8SBe2Lb3W1Pi5D+splpM
         VkAyXmQZ576xA+YQcgcEghxkk0AuxHE2O0lmsdZdZHIdRqOSRaqhGRyPgPVXsHDD5M13
         vqurd6BBJ/tkV81tSsk9JNn7GB2IrMpgtDmHXX8S61iE3gaVcE7arwTuzJM7okUjr8k8
         6hIA==
X-Gm-Message-State: AOAM530gc3wDqNvEEG6VHt7XOnonJY6JAPW+Y+rwXP0jZterF0o0rRCD
        exDmh9eXV1Qu3VEQHbBwfpDhaAGzzMQ=
X-Google-Smtp-Source: ABdhPJzuuqBeQlL7pH/ARTF1a3Ab2QjTuOfTMBZ0oTE90B7WZYsumazl+TKHfYDN/LWwjlruzhFxpw==
X-Received: by 2002:a05:6808:1d5:b0:2ec:977a:515d with SMTP id x21-20020a05680801d500b002ec977a515dmr3256188oic.79.1649247141483;
        Wed, 06 Apr 2022 05:12:21 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id li20-20020a056871421400b000deaa91898fsm6186669oab.40.2022.04.06.05.12.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 05:12:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c2a1776d-1499-8b84-15cd-b09908ebd0e5@roeck-us.net>
Date:   Wed, 6 Apr 2022 05:12:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Camel Guo <camel.guo@axis.com>, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     kernel@axis.com, Camel Guo <camelg@axis.com>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220406092901.408861-1-camel.guo@axis.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] hwmon: (tmp401) Support extended temperature range
In-Reply-To: <20220406092901.408861-1-camel.guo@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/22 02:29, Camel Guo wrote:
> From: Camel Guo <camelg@axis.com>
> 
> This patch only applies to tmp431 and devicetree configuration.
> 
> Signed-off-by: Camel Guo <camelg@axis.com>
> ---
>   Documentation/hwmon/tmp401.rst | 13 +++++++++++++
>   drivers/hwmon/tmp401.c         |  5 +++++
>   2 files changed, 18 insertions(+)
> 
> diff --git a/Documentation/hwmon/tmp401.rst b/Documentation/hwmon/tmp401.rst
> index 3aacf3d3bdf3..d12e9c9ba40f 100644
> --- a/Documentation/hwmon/tmp401.rst
> +++ b/Documentation/hwmon/tmp401.rst
> @@ -78,3 +78,16 @@ some additional features.
>   
>   TMP432 is compatible with TMP401 and TMP431. It supports two external
>   temperature sensors.
> +
> +Device tree
> +-----------
> +TMP431 has support for the device tree parameter "extended-range" which enables
> +the extended range in the chip.
> +

There is no practical reason to limit support for this to TMP431,
nor does the actual code make such a distinction.

> +Example:
> +
> +main-temp@4c {
> +  compatible = "ti,tmp431";
> +  reg = <0x4c>;
> +  extended-range;
> +};

This is not an acceptable way to describe devicetree properties.
You would have to write a bindings document
(Documentation/devicetree/bindings/hwmon/ti,tmp401.yaml)
and describe the property there.

Guenter

> diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
> index b86d9df7105d..6efd2475ffda 100644
> --- a/drivers/hwmon/tmp401.c
> +++ b/drivers/hwmon/tmp401.c
> @@ -557,6 +557,11 @@ static int tmp401_init_client(struct tmp401_data *data)
>   	config_orig = config;
>   	config &= ~TMP401_CONFIG_SHUTDOWN;
>   
> +	if (of_property_read_bool(data->client->dev.of_node, "extended-range")) {
> +		/* Enable extended range */
> +		config |= TMP401_CONFIG_RANGE;
> +	}
> +
>   	data->extended_range = !!(config & TMP401_CONFIG_RANGE);
>   
>   	if (config != config_orig)

