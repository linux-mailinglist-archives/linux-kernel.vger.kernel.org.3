Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945284BEA62
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbiBUSkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 13:40:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbiBUSjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 13:39:05 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D58B195;
        Mon, 21 Feb 2022 10:38:41 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id d7so34157193qvk.2;
        Mon, 21 Feb 2022 10:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=RN31mHdSa5wYyQSVLhAEYvtn+xnOanN4vGFOLl7R7B0=;
        b=GdM6CDQL60eI3AHBnGebNcB+QkmJyOrwN7E1TWLw0qjkxf5D4ioQcnniehfJ4n4MMG
         XWypBmEqNbz6ScOOdyiWsrob0WScNUWOrCeN79a6AZmcOAo0ElvvA1jJR9DTLl4k6de3
         K6k5D6dlAsESvyC91bNBLzXR89PxF3swfSEjeDn/fjCQ+u67IhVYrh9JKDp3swk+xzld
         M+jdWbfIZG6rji1WXAfqfwFfFxBiFCTjHqsMeVGa2nCpr66PHztsdNCnObU7l6yHbbUc
         Mhw8B72LadlYXhWdFMrMFhsXjqJ3JdSTCjYv60gQhyLbxeh0Db/TbcJDeWrC3jkyabDS
         0Azg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=RN31mHdSa5wYyQSVLhAEYvtn+xnOanN4vGFOLl7R7B0=;
        b=lDsHDH+vgSJVuc5DhjU8wtKJTuhO4W2u4jzXnXbK8kA/Y5unBzAbYDLtqxtldB4WzS
         z5JtQOviEli9AvRbDiTONPzSupO73K4yCCvj4VdWF7LxYMpOWQftusnFK46EVtzK5kfn
         SnEkgh8zutDzxEg9OD4QcxiPOdfOwsTQRfj+Fcx8CBzX34km2fBotR6Cc5cCUnIq8Mur
         dKnE8G5gL7mVMVEGFRhOMKIsT1J7qFFllS/pCzg1nF0N7jtF6WOaJYZvcKHSejLWpD09
         J85bSdaGFLhUNMkp11mHNICikp6s5NicI+IU4oX15cweRgGzSc8VCTU+oXARI0C9Qj5D
         8N8Q==
X-Gm-Message-State: AOAM53194x8WjYkh+laRQwlyc/nKwHB97ztCGVHtMIMGN0m1Q5htoCZx
        QqKwypYDsqmBBKJOJ1cI6Cs=
X-Google-Smtp-Source: ABdhPJwADDy5QP1mBjAbLYzYSKO2QHI0N9Z1xnyVErkrXnybkR5RTq0By2lQ3/JYd/giBhL4IMi7Dg==
X-Received: by 2002:a05:6214:27c2:b0:42d:adf:ab1c with SMTP id ge2-20020a05621427c200b0042d0adfab1cmr16174650qvb.83.1645468720769;
        Mon, 21 Feb 2022 10:38:40 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n19sm20182350qtk.66.2022.02.21.10.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 10:38:40 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e776981b-e729-b027-7512-5d5555c2ff74@roeck-us.net>
Date:   Mon, 21 Feb 2022 10:38:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Jon Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20210618215455.19986-1-digetx@gmail.com>
 <20210618215455.19986-3-digetx@gmail.com>
 <9580f660-2a11-40e4-2986-f05703822d72@nvidia.com>
 <2aae3bac-c9b3-ab47-aae4-a3c7b6fb4bb5@roeck-us.net>
 <84ddad27-eb22-0ba6-594f-2fc6d098dc2a@nvidia.com>
 <bdb8b51f-93ac-9f99-914e-e1ce16c0076d@roeck-us.net>
 <20da6f55-682f-4b30-7be7-f425f8efa995@nvidia.com>
 <6b5e4dfd-ca60-b934-527a-8ccc994047dc@nvidia.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 2/4] hwmon: (lm90) Use hwmon_notify_event()
In-Reply-To: <6b5e4dfd-ca60-b934-527a-8ccc994047dc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/22 08:22, Jon Hunter wrote:
> 
> On 21/02/2022 16:16, Jon Hunter wrote:
>>
>> On 21/02/2022 16:02, Guenter Roeck wrote:
>>
>> ...
>>
>>>> The platform I see this on does use device-tree and it does have a node for the ti,tmp451 device which uses the lm90 device. This platform uses the device-tree source arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts and the tmp451 node is in arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi.
>>>>
>>>
>>> Interesting. It appears that the call to devm_thermal_zone_of_sensor_register()
>>> in the hwmon core nevertheless returns -ENODEV which is not handled properly
>>> in the hwmon core. I can see a number of reasons for this to happen:
>>> - there is no devicetree node for the lm90 device
>>> - there is no thermal-zones devicetree node
>>> - there is no thermal zone entry in the thermal-zones node which matches
>>>    the sensor
>>
>>
>> So we definitely have the node for the lm90 device and a thermal-zones node, but I do not see a thermal-sensor node. Maybe this is what we are missing?
> 
> Actually, that is not true. We do have thermal-sensor nodes in arch/arm64/boot/dts/nvidia/tegra194.dtsi.
> 

There is probably a zone to sensor id mismatch. hwmon sends the sensor index
as sensor_id to the thermal subsystem. Those sensor IDs would be 0, 1, and
possibly 2 for the lm90 driver. Assuming this should match the thermal-sensors
values in arch/arm64/boot/dts/nvidia/tegra194.dtsi, those start with 2,
so there would be a likely mismatch. Also, all those dtsi entries match
against pbmp/thermal, not against the lm90 sensor(s).

Thanks,
Guenter
