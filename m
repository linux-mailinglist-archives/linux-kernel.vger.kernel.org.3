Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A55513830
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 17:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345655AbiD1PY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiD1PYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:24:53 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2887B139;
        Thu, 28 Apr 2022 08:21:38 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-e93ff05b23so5453971fac.9;
        Thu, 28 Apr 2022 08:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OFFg5eQqMiGW3c0oPod8aaqpn3LpIrDy41kx5aDk/iM=;
        b=XwfsYLOt9M7yYw4ztazXclSKi1ouBEXvSMbufVSaLQBkIHGKYkpTsVw4yqk2x3Kve8
         NHcKUZXW0OX7hh1MsUxRiXTS6bLXw9sRWBcUMhB7c0tNOBoD9NmFgX8S7hqn6Y1CKWAz
         XnZoikQBNU4emKbJAbHmSQz7NS3acXKncIfoZmUWUP2LML70i43a2pltBww5aC9CogRQ
         2gotXAU9wdwrLTHMude+Od4IzngpqmHVw7a3Pffha1XzWVYVDmgmwhUq3P5yg/SDA7cc
         Lsd0yw+aTZF5mg4cjF6Bei1TYtlSBc+3TfFlqulEueIOcpsCvHrAx5Gsgau1hAAdXCiD
         h22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OFFg5eQqMiGW3c0oPod8aaqpn3LpIrDy41kx5aDk/iM=;
        b=K7AMvZnsqzIaVtT9jhnEn0eoopR8iCvzAZCZlqyV+YmhnT14GQ+mwfS9dGBBe18F4P
         tmBm8IpU2VsSWMGezUc5GJSeOmdZMTN5HHSjuCF2rTGdXWgwqKyRPaY/3a7RgPZaqNUR
         CP0ve4XDfo+kvfrv/IUFNgmVJgkvPTeyUxQSd2QVTZc2XLIYf97YSd1T+x9PcS1CwQuF
         uzCWqidDjPM2lKliOSzYHzKHC+bLM6ROdRUNwIUAEMCinL0qY0lrg9kzOygUoCZ9RArY
         TNkkkMtsbJc0U5LKwr3xnV5XjhPie2VGTlbKOIG1drJKGk2NyXZ191QZ3gj41hma6jyg
         /p0g==
X-Gm-Message-State: AOAM5329jdc23L5tlTDVlXsy27pCzRQgz4xBUJb+N4e3hv9sFq/n18cP
        Ckv/w7mW6MbTY4oUmGlsxX5G83fpWoU=
X-Google-Smtp-Source: ABdhPJzb3heSphbt/uXkPz4blBLGiN7RNpjXSnFoCcbu3Mj1Y+8AnOa/qQUmko54oggyD4Hahc1VgA==
X-Received: by 2002:a05:6870:538f:b0:e1:def7:7640 with SMTP id h15-20020a056870538f00b000e1def77640mr13552356oan.34.1651159298273;
        Thu, 28 Apr 2022 08:21:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e4-20020a0568301e4400b006054dca5442sm82443otj.28.2022.04.28.08.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 08:21:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f8ba6a46-bbdb-b8ba-7b27-d43f2e05426d@roeck-us.net>
Date:   Thu, 28 Apr 2022 08:21:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] hwmon: (pmbus) add missing definitions of pmbus registers
Content-Language: en-US
To:     Adam Wujek <dev_public@wujek.eu>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220428134634.1610241-1-dev_public@wujek.eu>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220428134634.1610241-1-dev_public@wujek.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/22 06:46, Adam Wujek wrote:
> Definitions are taken from the table 31 of the PMBUS specification
> revision 1.3.1, 13 March 2015.
> 

Do you plan to do anything with those registers, or a subset of it ?

Guenter

> Signed-off-by: Adam Wujek <dev_public@wujek.eu>
> ---
>   drivers/hwmon/pmbus/pmbus.h | 145 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 145 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
> index e74b6ef070f3..902bb9cce950 100644
> --- a/drivers/hwmon/pmbus/pmbus.h
> +++ b/drivers/hwmon/pmbus/pmbus.h
> @@ -21,11 +21,29 @@ enum pmbus_regs {
>   	PMBUS_ON_OFF_CONFIG		= 0x02,
>   	PMBUS_CLEAR_FAULTS		= 0x03,
>   	PMBUS_PHASE			= 0x04,
> +	PMBUS_PAGE_PLUS_WRITE		= 0x05,
> +	PMBUS_PAGE_PLUS_READ		= 0x06,
> +	PMBUS_ZONE_CONFIG		= 0x07,
> +	PMBUS_ZONE_ACTIVE		= 0x08,
> +
> +	/* 0x09 - 0x0F are reserved */
> 
>   	PMBUS_WRITE_PROTECT		= 0x10,
> +	PMBUS_STORE_DEFAULT_ALL		= 0x11,
> +	PMBUS_RESTORE_DEFAULT_ALL	= 0x12,
> +	PMBUS_STORE_DEFAULT_CODE	= 0x13,
> +	PMBUS_RESTORE_DEFAULT_CODE	= 0x14,
> +	PMBUS_STORE_USER_ALL		= 0x15,
> +	PMBUS_RESTORE_USER_ALL		= 0x16,
> +	PMBUS_STORE_USER_CODE		= 0x17,
> +	PMBUS_RESTORE_USER_CODE		= 0x18,
> 
>   	PMBUS_CAPABILITY		= 0x19,
> +
>   	PMBUS_QUERY			= 0x1A,
> +	PMBUS_SMBALERT_MASK		= 0x1B,
> +
> +	/* 0x1C - 0x1F are reserved */
> 
>   	PMBUS_VOUT_MODE			= 0x20,
>   	PMBUS_VOUT_COMMAND		= 0x21,
> @@ -38,10 +56,22 @@ enum pmbus_regs {
>   	PMBUS_VOUT_DROOP		= 0x28,
>   	PMBUS_VOUT_SCALE_LOOP		= 0x29,
>   	PMBUS_VOUT_SCALE_MONITOR	= 0x2A,
> +	PMBUS_VOUT_MIN			= 0x2B,
> +
> +	/* 0x2C - 0x2F are reserved */
> 
>   	PMBUS_COEFFICIENTS		= 0x30,
>   	PMBUS_POUT_MAX			= 0x31,
> 
> +	PMBUS_MAX_DUTY			= 0x32,
> +	PMBUS_FREQUENCY_SWITCH		= 0x33,
> +	PMBUS_POWER_MODE		= 0x34,
> +	PMBUS_VIN_ON			= 0x35,
> +	PMBUS_VIN_OFF			= 0x36,
> +	PMBUS_INTERLEAVE		= 0x37,
> +	PMBUS_IOUT_CAL_GAIN		= 0x38,
> +	PMBUS_IOUT_CAL_OFFSET		= 0x39,
> +
>   	PMBUS_FAN_CONFIG_12		= 0x3A,
>   	PMBUS_FAN_COMMAND_1		= 0x3B,
>   	PMBUS_FAN_COMMAND_2		= 0x3C,
> @@ -63,6 +93,9 @@ enum pmbus_regs {
>   	PMBUS_IOUT_UC_FAULT_LIMIT	= 0x4B,
>   	PMBUS_IOUT_UC_FAULT_RESPONSE	= 0x4C,
> 
> +	/* 0x4D is reserved */
> +	/* 0x4E is reserved */
> +
>   	PMBUS_OT_FAULT_LIMIT		= 0x4F,
>   	PMBUS_OT_FAULT_RESPONSE		= 0x50,
>   	PMBUS_OT_WARN_LIMIT		= 0x51,
> @@ -74,14 +107,28 @@ enum pmbus_regs {
>   	PMBUS_VIN_OV_WARN_LIMIT		= 0x57,
>   	PMBUS_VIN_UV_WARN_LIMIT		= 0x58,
>   	PMBUS_VIN_UV_FAULT_LIMIT	= 0x59,
> +	PMBUS_VIN_UV_FAULT_RESPONSE	= 0x5A,
> 
>   	PMBUS_IIN_OC_FAULT_LIMIT	= 0x5B,
>   	PMBUS_IIN_OC_WARN_LIMIT		= 0x5D,
> 
> +	PMBUS_POWER_GOOD_ON		= 0x5E,
> +	PMBUS_POWER_GOOD_OFF		= 0x5F,
> +	PMBUS_TON_DELAY			= 0x60,
> +	PMBUS_TON_RISE			= 0x61,
> +	PMBUS_TON_MAX_FAULT_LIMIT	= 0x62,
> +	PMBUS_TON_MAX_FAULT_RESPONSE	= 0x63,
> +	PMBUS_TOFF_DELAY		= 0x64,
> +	PMBUS_TOFF_FALL			= 0x65,
> +	PMBUS_TOFF_MAX_WARN_LIMIT	= 0x66,
> +	/* 0x67 is reserved (Was Used In PMBUS Revision 1.0) */
>   	PMBUS_POUT_OP_FAULT_LIMIT	= 0x68,
> +	PMBUS_POUT_OP_FAULT_RESPONSE	= 0x69,
>   	PMBUS_POUT_OP_WARN_LIMIT	= 0x6A,
>   	PMBUS_PIN_OP_WARN_LIMIT		= 0x6B,
> 
> +	/* 0x6C - 0x77 are reserved */
> +
>   	PMBUS_STATUS_BYTE		= 0x78,
>   	PMBUS_STATUS_WORD		= 0x79,
>   	PMBUS_STATUS_VOUT		= 0x7A,
> @@ -94,6 +141,11 @@ enum pmbus_regs {
>   	PMBUS_STATUS_FAN_12		= 0x81,
>   	PMBUS_STATUS_FAN_34		= 0x82,
> 
> +	PMBUS_READ_KWH_IN		= 0x83,
> +	PMBUS_READ_KWH_OUT		= 0x84,
> +	PMBUS_READ_KWH_CONFIG		= 0x85,
> +	PMBUS_READ_EIN			= 0x86,
> +	PMBUS_READ_EOUT			= 0x87,
>   	PMBUS_READ_VIN			= 0x88,
>   	PMBUS_READ_IIN			= 0x89,
>   	PMBUS_READ_VCAP			= 0x8A,
> @@ -118,6 +170,7 @@ enum pmbus_regs {
>   	PMBUS_MFR_LOCATION		= 0x9C,
>   	PMBUS_MFR_DATE			= 0x9D,
>   	PMBUS_MFR_SERIAL		= 0x9E,
> +	PMBUS_APP_PROFILE_SUPPORT	= 0x9F,
> 
>   	PMBUS_MFR_VIN_MIN		= 0xA0,
>   	PMBUS_MFR_VIN_MAX		= 0xA1,
> @@ -128,13 +181,105 @@ enum pmbus_regs {
>   	PMBUS_MFR_IOUT_MAX		= 0xA6,
>   	PMBUS_MFR_POUT_MAX		= 0xA7,
> 
> +	PMBUS_MFR_TAMBIENT_MAX		= 0xA8,
> +	PMBUS_MFR_TAMBIENT_MIN		= 0xA9,
> +	PMBUS_MFR_EFFICIENCY_LL		= 0xAA,
> +	PMBUS_MFR_EFFICIENCY_HL		= 0xAB,
> +	PMBUS_MFR_PIN_ACCURACY		= 0xAC,
> +
>   	PMBUS_IC_DEVICE_ID		= 0xAD,
>   	PMBUS_IC_DEVICE_REV		= 0xAE,
> 
> +	/* 0xAF is reserved */
> +
> +	PMBUS_USER_DATA_00		= 0xB0,
> +	PMBUS_USER_DATA_01		= 0xB1,
> +	PMBUS_USER_DATA_02		= 0xB2,
> +	PMBUS_USER_DATA_03		= 0xB3,
> +	PMBUS_USER_DATA_04		= 0xB4,
> +	PMBUS_USER_DATA_05		= 0xB5,
> +	PMBUS_USER_DATA_06		= 0xB6,
> +	PMBUS_USER_DATA_07		= 0xB7,
> +	PMBUS_USER_DATA_08		= 0xB8,
> +	PMBUS_USER_DATA_09		= 0xB9,
> +	PMBUS_USER_DATA_10		= 0xBA,
> +	PMBUS_USER_DATA_11		= 0xBB,
> +	PMBUS_USER_DATA_12		= 0xBC,
> +	PMBUS_USER_DATA_13		= 0xBD,
> +	PMBUS_USER_DATA_14		= 0xBE,
> +	PMBUS_USER_DATA_15		= 0xBF,
> +
>   	PMBUS_MFR_MAX_TEMP_1		= 0xC0,
>   	PMBUS_MFR_MAX_TEMP_2		= 0xC1,
>   	PMBUS_MFR_MAX_TEMP_3		= 0xC2,
> 
> +	/* 0xC3 is reserved */
> +
> +	PMBUS_MFR_SPECIFIC_C4		= 0xC4,
> +	PMBUS_MFR_SPECIFIC_C5		= 0xC5,
> +	PMBUS_MFR_SPECIFIC_C6		= 0xC6,
> +	PMBUS_MFR_SPECIFIC_C7		= 0xC7,
> +	PMBUS_MFR_SPECIFIC_C8		= 0xC8,
> +	PMBUS_MFR_SPECIFIC_C9		= 0xC9,
> +	PMBUS_MFR_SPECIFIC_CA		= 0xCA,
> +	PMBUS_MFR_SPECIFIC_CB		= 0xCB,
> +	PMBUS_MFR_SPECIFIC_CC		= 0xCC,
> +	PMBUS_MFR_SPECIFIC_CD		= 0xCD,
> +	PMBUS_MFR_SPECIFIC_CE		= 0xCE,
> +	PMBUS_MFR_SPECIFIC_CF		= 0xCF,
> +
> +	PMBUS_MFR_SPECIFIC_D0		= 0xD0,
> +	PMBUS_MFR_SPECIFIC_D1		= 0xD1,
> +	PMBUS_MFR_SPECIFIC_D2		= 0xD2,
> +	PMBUS_MFR_SPECIFIC_D3		= 0xD3,
> +	PMBUS_MFR_SPECIFIC_D4		= 0xD4,
> +	PMBUS_MFR_SPECIFIC_D5		= 0xD5,
> +	PMBUS_MFR_SPECIFIC_D6		= 0xD6,
> +	PMBUS_MFR_SPECIFIC_D7		= 0xD7,
> +	PMBUS_MFR_SPECIFIC_D8		= 0xD8,
> +	PMBUS_MFR_SPECIFIC_D9		= 0xD9,
> +	PMBUS_MFR_SPECIFIC_DA		= 0xDA,
> +	PMBUS_MFR_SPECIFIC_DB		= 0xDB,
> +	PMBUS_MFR_SPECIFIC_DC		= 0xDC,
> +	PMBUS_MFR_SPECIFIC_DD		= 0xDD,
> +	PMBUS_MFR_SPECIFIC_DE		= 0xDE,
> +	PMBUS_MFR_SPECIFIC_DF		= 0xDF,
> +
> +	PMBUS_MFR_SPECIFIC_E0		= 0xE0,
> +	PMBUS_MFR_SPECIFIC_E1		= 0xE1,
> +	PMBUS_MFR_SPECIFIC_E2		= 0xE2,
> +	PMBUS_MFR_SPECIFIC_E3		= 0xE3,
> +	PMBUS_MFR_SPECIFIC_E4		= 0xE4,
> +	PMBUS_MFR_SPECIFIC_E5		= 0xE5,
> +	PMBUS_MFR_SPECIFIC_E6		= 0xE6,
> +	PMBUS_MFR_SPECIFIC_E7		= 0xE7,
> +	PMBUS_MFR_SPECIFIC_E8		= 0xE8,
> +	PMBUS_MFR_SPECIFIC_E9		= 0xE9,
> +	PMBUS_MFR_SPECIFIC_EA		= 0xEA,
> +	PMBUS_MFR_SPECIFIC_EB		= 0xEB,
> +	PMBUS_MFR_SPECIFIC_EC		= 0xEC,
> +	PMBUS_MFR_SPECIFIC_ED		= 0xED,
> +	PMBUS_MFR_SPECIFIC_EE		= 0xEE,
> +	PMBUS_MFR_SPECIFIC_EF		= 0xEF,
> +
> +	PMBUS_MFR_SPECIFIC_F0		= 0xF0,
> +	PMBUS_MFR_SPECIFIC_F1		= 0xF1,
> +	PMBUS_MFR_SPECIFIC_F2		= 0xF2,
> +	PMBUS_MFR_SPECIFIC_F3		= 0xF3,
> +	PMBUS_MFR_SPECIFIC_F4		= 0xF4,
> +	PMBUS_MFR_SPECIFIC_F5		= 0xF5,
> +	PMBUS_MFR_SPECIFIC_F6		= 0xF6,
> +	PMBUS_MFR_SPECIFIC_F7		= 0xF7,
> +	PMBUS_MFR_SPECIFIC_F8		= 0xF8,
> +	PMBUS_MFR_SPECIFIC_F9		= 0xF9,
> +	PMBUS_MFR_SPECIFIC_FA		= 0xFA,
> +	PMBUS_MFR_SPECIFIC_FB		= 0xFB,
> +	PMBUS_MFR_SPECIFIC_FC		= 0xFC,
> +	PMBUS_MFR_SPECIFIC_FD		= 0xFD,
> +
> +	PMBUS_MFR_SPECIFIC_COMMAND_EXT	= 0xFE,
> +	PMBUS_COMMAND_EXT		= 0xFF,
> +
>   /*
>    * Virtual registers.
>    * Useful to support attributes which are not supported by standard PMBus
> --
> 2.25.1
> 
> 

