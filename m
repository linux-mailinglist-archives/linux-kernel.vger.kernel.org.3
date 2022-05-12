Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03757524257
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 04:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237827AbiELCKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 22:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237316AbiELCKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 22:10:34 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427F36D4E5;
        Wed, 11 May 2022 19:10:33 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-d39f741ba0so5005570fac.13;
        Wed, 11 May 2022 19:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=fQPyapFD5yK80jYccvbvTBqZpr7+hTPz6GZIBB/rNbA=;
        b=Ni3GZ9Qc0o3tjDRWDIeIxobqwxfiOAI7j7D0aepL2h5WqmHnZVW9IN9PMJV9D6MN3m
         JYzymJ6BdNipNzEKnCH7sh5v7o1sqUPhpm/9F/KRwsn6l9o+u/wU/sID9efPj97LR1T2
         VxiYchU7dJOlqU/FRK67LOBAMc9+BqQe2BF10NyUn+SnLShEVkTyPw8nWwNTtvqAedIm
         QaX8cGY9JfzeqNVmd63gjHJQCssHXcmbsPy1zKEXF1zDKQs+Y7D8g9XduPik/98ZMzoy
         +3fCHsjIdXZi2Bf2D/vCdn+00hjE9/0HBgYgKaBfum1tnCPj3agFpSpHZsUZ56zYyYKo
         dbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=fQPyapFD5yK80jYccvbvTBqZpr7+hTPz6GZIBB/rNbA=;
        b=t1RhQtP+RDIFZzX1Yz65b7Jo5m+/HFvr6EOE33gnILjk1qwwrllhDtq7MLYWEp7fVx
         QzGpC2VS1JY1/RH0bX2ksCELhhN7dsAQavv4FtNfmQrFNvkoCnnlpXFBqD232WFTcps+
         xZ39vdTopCxv18Hn0xXAzKsC2uebzLumEE1i7S3rJ0mF33on3nIqZX/hkO6ar6K9ykpm
         GxxHC00PMkf0FufcibXLhlMg5EWBsb0S91qhNNgqdGielrG6Q6vKdRwuS36SVI3WF7wW
         7AIpuVNTZ6BbCz+yLGnw+mVtRnF4HKjRSACUDOAFSiiPqBO4pcKD2qkJch2B5AO3eNY3
         CVfA==
X-Gm-Message-State: AOAM533iEngov2z8/ECyzJZ1etpNHXa/h4Kak5zHvDTnk3U6pac4xuEB
        yV7absZzC73/pZQtzQ4d6JA=
X-Google-Smtp-Source: ABdhPJwih7XGoH9aHoDALG7XhRniGayDQ/zJFlFdwZodO4DdCTjGWMpPmnclN9++nJeq/Nr2LEp8Pw==
X-Received: by 2002:a05:6870:b010:b0:e5:ff56:61d1 with SMTP id y16-20020a056870b01000b000e5ff5661d1mr4468918oae.47.1652321432596;
        Wed, 11 May 2022 19:10:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f6-20020a056830056600b006062836c4f4sm1459845otc.71.2022.05.11.19.10.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 19:10:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e5f6c712-efed-2126-de2b-9a0d09150e7b@roeck-us.net>
Date:   Wed, 11 May 2022 19:10:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Corentin Labbe <clabbe@baylibre.com>, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>
References: <20220509063010.3878134-1-clabbe@baylibre.com>
 <20220509063010.3878134-3-clabbe@baylibre.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 2/2] hwmon: acpi_power_meter: convert to
 hwmon_device_register_with_info
In-Reply-To: <20220509063010.3878134-3-clabbe@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Corentin,

On 5/8/22 23:30, Corentin Labbe wrote:
> Booting lead to a hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
> So let's convert the driver to use hwmon_device_register_with_info().
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
[ ... ]

> @@ -836,20 +740,20 @@ static void acpi_power_meter_notify(struct acpi_device *device, u32 event)
>   		if (res)
>   			break;
>   
> -		remove_attrs(resource);
> +		remove_domain_devices(resource);
>   		setup_attrs(resource);

Zhang Rui found an interesting problem with this code:
It needs a call to sysfs_update_groups(hwmon_dev->groups)
to update sysfs attribute visibility, probably between
remove_domain_devices() and setup_attrs().

>   		break;
>   	case METER_NOTIFY_TRIP:
> -		sysfs_notify(&device->dev.kobj, NULL, POWER_AVERAGE_NAME);
> +		hwmon_notify_event(&device->dev, hwmon_power, hwmon_power_average, 0);

... which makes realize: The notification device should be the hwmon device.
That would be resource->hwmon_dev, not the acpi device.

Thanks,
Guenter
