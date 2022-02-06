Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE484AB111
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 18:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345174AbiBFRv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 12:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236478AbiBFRvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 12:51:21 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7768CC06173B;
        Sun,  6 Feb 2022 09:51:20 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id r27so14759689oiw.4;
        Sun, 06 Feb 2022 09:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=8d4aoAMxSo7HSTaBUTBVt7QQDEWKLHoC2XmqWjCbM1s=;
        b=NJ8Ne+eOf4mOuh9t+V3b7sHoIaQ9e5iye2gnHPM1kP7Dtv9H4iTmymPzkDyXyy55x4
         wWpOm3l8NRbJZH/39+oiZ6zCTSIPorZMjqH8EDlG/BHMvkz45wptFIS+hg8q/zv3pm/u
         0c+6M8Et5mpgtgynPP7b4K7y5JFVxuA81gY+OV7mROzwGlGBS9L1TeJB+rT/l68DgOE9
         oAwHyLLiMcvAWXK/cVDqvkeFZWDb7RiAXJIsqkSp5ZaeaDIgv57uyD/IsXK/qHJLsAV6
         GhcEQUgS11Te7Xa916V9H3RwOX7CBmv+EDf3W5mCvO9QwvlFUYIhWkGM/ZXUFOaNqc8A
         fJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=8d4aoAMxSo7HSTaBUTBVt7QQDEWKLHoC2XmqWjCbM1s=;
        b=j3de3RQH3aRezdooqMebcIMY72UrHIaNTyxkQGuzmdbDZ6H1simdBXUe/J/rbwB1Ec
         ZnOxGgSMVtTY9tPcJ2Uk8u+MdkECi8SjgDWW66xdojCjy0gIbEq71/UAHqFPQRj3za27
         NAB6psC4iI46+LD+bW88jRqpPGFmKI/KwBUVu28fp4fBFKfhzSp11eWDeCr30PAxZP0v
         NKcnf+H/BzCMmTmCW2hpklmPy0XgT1YIN0gNX9DY358bQBHbvmdPO4NiHv04Gt/z0KNl
         qPLyP+ab8SuqqshtUbfcgYibZoFacmdunOVmMy7kjDHpLnYIeCeCHGUrFdD5iVm17dPy
         0KQg==
X-Gm-Message-State: AOAM531TuvzuHUtApPCgGhM1zXy7b+9IpFovVkBu+cGvVx4BOoiYODLj
        MTWBDKzDAjtoolLzcawTEz4=
X-Google-Smtp-Source: ABdhPJzO5VM3ko/6A7BUyOiMIr3hpCZ6njtpOYiBH3wHupxEo0yu2HFJiFFSO7VFCIi09cPwEv5vMA==
X-Received: by 2002:a05:6808:e89:: with SMTP id k9mr5705620oil.263.1644169879745;
        Sun, 06 Feb 2022 09:51:19 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z40sm3139056oap.37.2022.02.06.09.51.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Feb 2022 09:51:19 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <258c224c-c543-1756-4c1e-fe9d81e24e4c@roeck-us.net>
Date:   Sun, 6 Feb 2022 09:51:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        platform-driver-x86@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
References: <20220206022023.376142-1-andrew.smirnov@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] platform/x86: Add Steam Deck driver
In-Reply-To: <20220206022023.376142-1-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2/5/22 18:20, Andrey Smirnov wrote:
> Add a driver exposing various bits and pieces of functionality
> provided by Steam Deck specific VLV0100 device presented by EC
> firmware. This includes but not limited to:
> 
>      - CPU/device's fan control
>      - Read-only access to DDIC registers
>      - Battery tempreature measurements
>      - Various display related control knobs
>      - USB Type-C connector event notification
> 
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Mark Gross <markgross@kernel.org>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-kernel@vger.kernel.org (open list)
> Cc: platform-driver-x86@vger.kernel.org
> Cc: linux-hwmon@vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
> 
...

 > +config STEAMDECK
 > +       tristate "Valve Steam Deck platform driver"
 > +       depends on X86_64
 > +       help
 > +         Driver exposing various bits and pieces of functionality
 > +	 provided by Steam Deck specific VLV0100 device presented by
 > +	 EC firmware. This includes but not limited to:

There seems to be some indentation issue.

 > +	     - CPU/device's fan control
 > +	     - Read-only access to DDIC registers
 > +	     - Battery tempreature measurements
 > +	     - Various display related control knobs
 > +	     - USB Type-C connector event notification
 > +
 > +	 Say N unless you are running on a Steam Deck.
 > +

This doesn't depend on hwmon, yet it fails if devm_hwmon_device_register_with_info()
returns an eror. That has a couple of problems: if HWMON=n, it won't compile,
and if STEAMDECK=y and HWMON=m it won't compile either. You'll have to provide
some dependency against HWMON to make this work.

...

> +
> +static int steamdeck_read_fan_speed(struct steamdeck *jup, long *speed)
> +{
> +	unsigned long long val;
> +
> +	if (ACPI_FAILURE(acpi_evaluate_integer(jup->adev->handle,
> +					       "FANR", NULL, &val)))
> +		return -EIO;
> +
> +	*speed = val;
> +	return 0;
> +}
> +
> +static int
> +steamdeck_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> +		     u32 attr, int channel, long *out)
> +{
> +	struct steamdeck *sd = dev_get_drvdata(dev);
> +	unsigned long long val;
> +
> +	switch (type) {
> +	case hwmon_temp:
> +		if (attr != hwmon_temp_input)
> +			return -EOPNOTSUPP;
> +
> +		if (ACPI_FAILURE(acpi_evaluate_integer(sd->adev->handle,
> +						       "BATT", NULL, &val)))
> +			return -EIO;
> +		/*
> +		 * Assuming BATT returns deg C we need to mutiply it
> +		 * by 1000 to convert to mC
> +		 */
> +		*out = val * 1000;
> +		break;
> +	case hwmon_fan:
> +		switch (attr) {
> +		case hwmon_fan_input:
> +			return steamdeck_read_fan_speed(sd, out);

There is a bit of inconsistency here: All other atributes are handled directly,
except for this one, yet there isn't really a difference in the actual operation.
Maybe I am missing something. What is the reason for using a function here
but not for the other attributes ?

> +		case hwmon_fan_target:
> +			*out = sd->fan_target;
> +			break;
> +		case hwmon_fan_fault:
> +			if (ACPI_FAILURE(acpi_evaluate_integer(
> +						 sd->adev->handle,
> +						 "FANC", NULL, &val)))
> +				return -EIO;
> +			/*
> +			 * FANC (Fan check):
> +			 * 0: Abnormal
> +			 * 1: Normal
> +			 */
> +			*out = !val;
> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static int
> +steamdeck_hwmon_read_string(struct device *dev, enum hwmon_sensor_types type,
> +			    u32 attr, int channel, const char **str)
> +{
> +	switch (type) {
> +	case hwmon_temp:
> +		*str = "Battery Temp";
> +		break;
> +	case hwmon_fan:
> +		*str = "System Fan";
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static int
> +steamdeck_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
> +		      u32 attr, int channel, long val)
> +{
> +	struct steamdeck *sd = dev_get_drvdata(dev);
> +
> +	if (type != hwmon_fan ||
> +	    attr != hwmon_fan_target)
> +		return -EOPNOTSUPP;
> +
> +	if (val > U16_MAX)
> +		return -EINVAL;

This accepts negative values, and it expects the user to find
valid ranges. I suggest to use clamp_val() instead.

Guenter
