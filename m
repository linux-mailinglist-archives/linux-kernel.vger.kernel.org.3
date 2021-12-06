Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B49C46AE35
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 00:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377903AbhLFXG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 18:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351313AbhLFXGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 18:06:21 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25625C061746;
        Mon,  6 Dec 2021 15:02:52 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id w6-20020a9d77c6000000b0055e804fa524so15677157otl.3;
        Mon, 06 Dec 2021 15:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=st/asTmkM7F4+B0Newb37k11WjuAfycVbozvK69HWmk=;
        b=N6GOlVN7WA1CsGUtbGkabHO4qZaZbbYZTecXoIOrd1NTpa2nAbZKuZ1Do/aOqfSZy1
         SL8DSZHazNSclyGlAy0u9pG/etgxnf4lNUhMLNB/8A9DaMDv4ojURi1hf3eehH28D6tc
         PbiNWCWoftTQAPOPP5Hz/nQqxPRZ6avV1bn9CVbS3doVRPjzFEVCfKlHezyd7uxuKCaa
         RzbnPXbNIuzW80ahY3FlXkVIhUA+x5s8AUbNAwGyftK0+/CBS4tVOPosckxDP/p0tVZR
         11Wmp3oZKWG3JdKoyBCcq73KaJIjEh/ixF8ihA/fnzJx2S5rWehkSk7wNNC9p3Ij6v5c
         FUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=st/asTmkM7F4+B0Newb37k11WjuAfycVbozvK69HWmk=;
        b=d46pB/BTJVVegKiGxj1bTME3E9ZQvMU3/h0bn7ENFMuS62Dnh1Lygnkvb0ETDITDAd
         agpP/qfJzfkXIFWJgWQvlQ9KkLu5wzKwASNyqr/JJCH72vCjxygfKfUVv4qkuataSXUa
         TMIucCPfZfb+zwojvCAV2Ml0tcmkQsBOU35JhWkaTmavTB4I+EW/gOU2tQRUzWhegJsE
         skRzTwSPCGG07l43Kf8YOiJn60fkg5nyDJyiT53om2HJEcJhNeMdTy+ItGXTgP/ggK/t
         3I4/1BrXSQUZWqdKyaZ8j6foGpxQAhV+WH3CmA3NHHPSe3RWSO7fvMZFI2BtUFK88FQI
         9BDw==
X-Gm-Message-State: AOAM530EulPH7FNpYYr9Bd3xxLYeahN7owfvlHniQRAfnmQNUiXAxx9V
        A5uT9D0MKXvOMw9LksFQEuBJIdl4w0A=
X-Google-Smtp-Source: ABdhPJzRoKS9iNc5l+MR6V6YE5ct0vASm3U+GcljPR7GR6SX76+T2cLitEMDeJc5IC0eBJaAz3wEWQ==
X-Received: by 2002:a05:6830:2042:: with SMTP id f2mr31007837otp.89.1638831771221;
        Mon, 06 Dec 2021 15:02:51 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w4sm3177411oiv.37.2021.12.06.15.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 15:02:50 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 1/2] hwmon: add Delta AHE-50DC fan control module driver
To:     Zev Weiss <zev@bewilderbeest.net>, linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20211206224419.15736-1-zev@bewilderbeest.net>
 <20211206224419.15736-2-zev@bewilderbeest.net>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <28719505-ace1-bb04-bbc2-043c56b0db7d@roeck-us.net>
Date:   Mon, 6 Dec 2021 15:02:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211206224419.15736-2-zev@bewilderbeest.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/21 2:44 PM, Zev Weiss wrote:
> This device is an integrated module of the Delta AHE-50DC Open19 power
> shelf.  For lack of proper documentation, this driver has been developed
> referencing an existing (GPL) driver that was included in a code release
> from LinkedIn [1].  It provides four fan speeds, four temperatures, and
> one voltage reading, as well as a handful of warning and fault
> indicators.
> 
> [1] https://github.com/linkedin/o19-bmc-firmware/blob/master/meta-openbmc/meta-linkedin/meta-deltapower/recipes-kernel/fancontrol-mod/files/fancontrol.c
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---

[ ... ]

> +
> +static const u8 AHE50DC_FAN_TEMP_REGS[] = { 0x8d, 0x8e, 0x8f, 0xd0 };
> +static const u8 AHE50DC_FAN_SPEED_REGS[] = { 0x90, 0x91, 0x92, 0x93 };
> +static const u8 AHE50DC_FAN_FAN_STATUS_REGS[] = { 0x81, 0x82 };
> +#define AHE50DC_FAN_VIN_REG 0x88
> +#define AHE50DC_FAN_CHIP_STATUS_REG 0x79

PMBus registers:

	PMBUS_STATUS_WORD               = 0x79,

	PMBUS_STATUS_FAN_12             = 0x81,
	PMBUS_STATUS_FAN_34             = 0x82,

	PMBUS_READ_VIN                  = 0x88,

         PMBUS_READ_TEMPERATURE_1        = 0x8D,
         PMBUS_READ_TEMPERATURE_2        = 0x8E,
         PMBUS_READ_TEMPERATURE_3        = 0x8F,
         PMBUS_READ_FAN_SPEED_1          = 0x90,
         PMBUS_READ_FAN_SPEED_2          = 0x91,
         PMBUS_READ_FAN_SPEED_3          = 0x92,
         PMBUS_READ_FAN_SPEED_4          = 0x93,

This is quite obviously a PMBus device. Why not use the PMBus driver ?

Guenter
