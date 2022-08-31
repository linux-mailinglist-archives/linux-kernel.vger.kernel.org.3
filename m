Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739775A8572
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiHaSZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbiHaSYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:24:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D942A5730
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661969968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fuWmRIFXw6Kcx2QVIeEOdLQrgVopjQQArfDzeESZeK0=;
        b=Z82mZ2tBIu14J1xwdIsMU1n6OhuXslBlMnBjXTNxh1/5sXkuDHcOfhT3BRnBONlC0AyPaP
        53HtSleqhwzxNsmNF9Bb18fPPOSYJTCKqdxcvYpzi8VnHTmOMlu+05KNJZM6iQlbQF7ZTv
        W8LhmZ3RLRvmwtudQhYbKL9erTuP0lU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-140-wOgOFFnbN4ayrMb6z0MpDg-1; Wed, 31 Aug 2022 14:19:27 -0400
X-MC-Unique: wOgOFFnbN4ayrMb6z0MpDg-1
Received: by mail-ed1-f69.google.com with SMTP id h6-20020aa7de06000000b004483647900fso8010928edv.21
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:19:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=fuWmRIFXw6Kcx2QVIeEOdLQrgVopjQQArfDzeESZeK0=;
        b=D0x2XVbts76HY7D13vDtQrKXt5tsLZmWdaq6PfvNdmzpJgLq+uTcTQO+vNtLhBjVvt
         ZQLL+siZxMPlRLBMmwKWl6e/9Ua+MG1WXhZt/gsNdQnnEf6dBUP9QDHecPOgyYaxj086
         eiWAztunQ9GJPTdNBv6Kw0aqKVexYKZZsNCrziGZnwd6uGD25yhWwh/47WL8j21xRftV
         BdROaQ3vHkAPi91P+H3xtrsh3q3ZbTdlI4Fz8xugQx362lDfkaNbcCl2v/N6/RGYgjWw
         LCUEEETW2u9ZURXph31Z4weRU2K39+9WsLivb7tbUFHihxRcnK7pBiffS6/LMlF1nsOR
         drWw==
X-Gm-Message-State: ACgBeo3v/RBbAYQygn+svoZ62N6rqa2UR8XxBX4AcuOghPBD3+6AQ6oN
        ZZPdjxZeMgUDKzcdUe+cEyq/Nbpudh49kKBaGFxQFBA/MSSAXDb2TehBuSu6qCG+nD92TWrNGp9
        IWzTE8gRZhPuuwFCciSqLV7TC
X-Received: by 2002:a17:907:271b:b0:730:aa8e:74eb with SMTP id w27-20020a170907271b00b00730aa8e74ebmr21498423ejk.478.1661969965347;
        Wed, 31 Aug 2022 11:19:25 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6QPZk+7Ics045VzKPECvzAAPIToksBM93AHo5H6j0ow5wPCe8uGoWPAWEdacvZugQ4Y4ZWpw==
X-Received: by 2002:a17:907:271b:b0:730:aa8e:74eb with SMTP id w27-20020a170907271b00b00730aa8e74ebmr21498411ejk.478.1661969965088;
        Wed, 31 Aug 2022 11:19:25 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id z23-20020aa7d417000000b0044687e93f74sm9340737edq.43.2022.08.31.11.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 11:19:24 -0700 (PDT)
Message-ID: <4f388bda-b991-0ab6-4098-4f5dbabe57fb@redhat.com>
Date:   Wed, 31 Aug 2022 20:19:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 2/3] ACPI: PMIC: Replace open coded be16_to_cpu()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20220831135749.78743-1-andriy.shevchenko@linux.intel.com>
 <20220831135749.78743-2-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220831135749.78743-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/31/22 15:57, Andy Shevchenko wrote:
> It's easier to understand the nature of a data type when
> it's written explicitly. With that, replace open coded
> endianess conversion.
> 
> As a side effect it fixes the returned value of
> intel_crc_pmic_update_aux() since ACPI PMIC core code
> expects negative or zero and never uses positive one.
> 
> While at it, use macros from bits.h to reduce a room for mistake.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
> v3: added tag (Mika)
>  drivers/acpi/pmic/intel_pmic_bxtwc.c    | 50 +++++++++++--------------
>  drivers/acpi/pmic/intel_pmic_bytcrc.c   | 20 +++++++---
>  drivers/acpi/pmic/intel_pmic_chtdc_ti.c | 13 ++++---
>  drivers/acpi/pmic/intel_pmic_xpower.c   | 10 +++--
>  4 files changed, 51 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/acpi/pmic/intel_pmic_bxtwc.c b/drivers/acpi/pmic/intel_pmic_bxtwc.c
> index e247615189fa..90a2e62a37e4 100644
> --- a/drivers/acpi/pmic/intel_pmic_bxtwc.c
> +++ b/drivers/acpi/pmic/intel_pmic_bxtwc.c
> @@ -7,19 +7,20 @@
>  
>  #include <linux/init.h>
>  #include <linux/acpi.h>
> +#include <linux/bits.h>
> +#include <linux/byteorder/generic.h>
>  #include <linux/mfd/intel_soc_pmic.h>
>  #include <linux/regmap.h>
>  #include <linux/platform_device.h>
>  #include "intel_pmic.h"
>  
> -#define WHISKEY_COVE_ALRT_HIGH_BIT_MASK 0x0F
> -#define WHISKEY_COVE_ADC_HIGH_BIT(x)	(((x & 0x0F) << 8))
> -#define WHISKEY_COVE_ADC_CURSRC(x)	(((x & 0xF0) >> 4))
> -#define VR_MODE_DISABLED        0
> -#define VR_MODE_AUTO            BIT(0)
> -#define VR_MODE_NORMAL          BIT(1)
> -#define VR_MODE_SWITCH          BIT(2)
> -#define VR_MODE_ECO             (BIT(0)|BIT(1))
> +#define PMIC_REG_MASK		GENMASK(11, 0)
> +
> +#define VR_MODE_DISABLED        (0 << 0)
> +#define VR_MODE_AUTO            (1 << 0)
> +#define VR_MODE_NORMAL          (2 << 0)
> +#define VR_MODE_ECO             (3 << 0)
> +#define VR_MODE_SWITCH          (4 << 0)
>  #define VSWITCH2_OUTPUT         BIT(5)
>  #define VSWITCH1_OUTPUT         BIT(4)
>  #define VUSBPHY_CHARGE          BIT(1)
> @@ -297,25 +298,20 @@ static int intel_bxtwc_pmic_update_power(struct regmap *regmap, int reg,
>  
>  static int intel_bxtwc_pmic_get_raw_temp(struct regmap *regmap, int reg)
>  {
> -	unsigned int val, adc_val, reg_val;
> -	u8 temp_l, temp_h, cursrc;
>  	unsigned long rlsb;
>  	static const unsigned long rlsb_array[] = {
>  		0, 260420, 130210, 65100, 32550, 16280,
>  		8140, 4070, 2030, 0, 260420, 130210 };
> +	unsigned int adc_val, reg_val;
> +	__be16 buf;
>  
> -	if (regmap_read(regmap, reg, &val))
> +	if (regmap_bulk_read(regmap, reg - 1, &buf, sizeof(buf)))
>  		return -EIO;
> -	temp_l = (u8) val;
>  
> -	if (regmap_read(regmap, (reg - 1), &val))
> -		return -EIO;
> -	temp_h = (u8) val;

Hmm, you are changing the order of the register
reads here. The old code is doing:

	read(reg);
	read(reg -1);

Where as the new code is doing:

	read(reg -1);
	read(reg);

The order matters since typically upon reading the
low byte, the high bits will get latched so that
the next read of the high bytes uses the bits
from the same x-bits value as the low 8 bits.

This avoids things like:

1. Entire register value (all bits) 0x0ff
2. Read reg with low 8 bits, read 0x0ff
3. Entire register value becomes 0x100
4. Read reg with high bits
5. Combined value now reads as 0x1ff

I have no idea if the bxtwc PMIC latches
the bits, but giving the lack of documentation
it would IMHO be better to not change the reading order.

Regards,

Hans




> +	reg_val = be16_to_cpu(buf);
>  
> -	reg_val = temp_l | WHISKEY_COVE_ADC_HIGH_BIT(temp_h);
> -	cursrc = WHISKEY_COVE_ADC_CURSRC(temp_h);
> -	rlsb = rlsb_array[cursrc];
> -	adc_val = reg_val * rlsb / 1000;
> +	rlsb = rlsb_array[reg_val >> 12];
> +	adc_val = (reg_val & PMIC_REG_MASK) * rlsb / 1000;
>  
>  	return adc_val;
>  }
> @@ -325,7 +321,9 @@ intel_bxtwc_pmic_update_aux(struct regmap *regmap, int reg, int raw)
>  {
>  	u32 bsr_num;
>  	u16 resi_val, count = 0, thrsh = 0;
> -	u8 alrt_h, alrt_l, cursel = 0;
> +	u16 mask = PMIC_REG_MASK;
> +	__be16 buf;
> +	u8 cursel;
>  
>  	bsr_num = raw;
>  	bsr_num /= (1 << 5);
> @@ -336,15 +334,11 @@ intel_bxtwc_pmic_update_aux(struct regmap *regmap, int reg, int raw)
>  	thrsh = raw / (1 << (4 + cursel));
>  
>  	resi_val = (cursel << 9) | thrsh;
> -	alrt_h = (resi_val >> 8) & WHISKEY_COVE_ALRT_HIGH_BIT_MASK;
> -	if (regmap_update_bits(regmap,
> -				reg - 1,
> -				WHISKEY_COVE_ALRT_HIGH_BIT_MASK,
> -				alrt_h))
> -		return -EIO;
>  
> -	alrt_l = (u8)resi_val;
> -	return regmap_write(regmap, reg, alrt_l);
> +	if (regmap_bulk_read(regmap, reg - 1, &buf, sizeof(buf)))
> +		return -EIO;
> +	buf = cpu_to_be16((be16_to_cpu(buf) & ~mask) | (resi_val & mask));
> +	return regmap_bulk_write(regmap, reg - 1, &buf, sizeof(buf));
>  }
>  
>  static int
> diff --git a/drivers/acpi/pmic/intel_pmic_bytcrc.c b/drivers/acpi/pmic/intel_pmic_bytcrc.c
> index 9ea79f210965..ce647bc46978 100644
> --- a/drivers/acpi/pmic/intel_pmic_bytcrc.c
> +++ b/drivers/acpi/pmic/intel_pmic_bytcrc.c
> @@ -6,6 +6,8 @@
>   */
>  
>  #include <linux/acpi.h>
> +#include <linux/bits.h>
> +#include <linux/byteorder/generic.h>
>  #include <linux/init.h>
>  #include <linux/mfd/intel_soc_pmic.h>
>  #include <linux/platform_device.h>
> @@ -14,6 +16,8 @@
>  
>  #define PWR_SOURCE_SELECT	BIT(1)
>  
> +#define PMIC_REG_MASK		GENMASK(9, 0)
> +
>  #define PMIC_A0LOCK_REG		0xc5
>  
>  static struct pmic_table power_table[] = {
> @@ -219,23 +223,27 @@ static int intel_crc_pmic_update_power(struct regmap *regmap, int reg,
>  
>  static int intel_crc_pmic_get_raw_temp(struct regmap *regmap, int reg)
>  {
> -	int temp_l, temp_h;
> +	__be16 buf;
>  
>  	/*
>  	 * Raw temperature value is 10bits: 8bits in reg
>  	 * and 2bits in reg-1: bit0,1
>  	 */
> -	if (regmap_read(regmap, reg, &temp_l) ||
> -	    regmap_read(regmap, reg - 1, &temp_h))
> +	if (regmap_bulk_read(regmap, reg - 1, &buf, sizeof(buf)))
>  		return -EIO;
>  
> -	return temp_l | (temp_h & 0x3) << 8;
> +	return be16_to_cpu(buf) & PMIC_REG_MASK;
>  }
>  
>  static int intel_crc_pmic_update_aux(struct regmap *regmap, int reg, int raw)
>  {
> -	return regmap_write(regmap, reg, raw) ||
> -		regmap_update_bits(regmap, reg - 1, 0x3, raw >> 8) ? -EIO : 0;
> +	u16 mask = PMIC_REG_MASK;
> +	__be16 buf;
> +
> +	if (regmap_bulk_read(regmap, reg - 1, &buf, sizeof(buf)))
> +		return -EIO;
> +	buf = cpu_to_be16((be16_to_cpu(buf) & ~mask) | (raw & mask));
> +	return regmap_bulk_write(regmap, reg - 1, &buf, sizeof(buf));
>  }
>  
>  static int intel_crc_pmic_get_policy(struct regmap *regmap,
> diff --git a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
> index 6c2a6da430ed..1e80969c4d89 100644
> --- a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
> +++ b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
> @@ -8,12 +8,16 @@
>   */
>  
>  #include <linux/acpi.h>
> +#include <linux/bits.h>
> +#include <linux/byteorder/generic.h>
>  #include <linux/init.h>
>  #include <linux/mfd/intel_soc_pmic.h>
>  #include <linux/platform_device.h>
>  #include "intel_pmic.h"
>  
>  /* registers stored in 16bit BE (high:low, total 10bit) */
> +#define PMIC_REG_MASK		GENMASK(9, 0)
> +
>  #define CHTDC_TI_VBAT		0x54
>  #define CHTDC_TI_DIETEMP	0x56
>  #define CHTDC_TI_BPTHERM	0x58
> @@ -73,7 +77,7 @@ static int chtdc_ti_pmic_get_power(struct regmap *regmap, int reg, int bit,
>  	if (regmap_read(regmap, reg, &data))
>  		return -EIO;
>  
> -	*value = data & 1;
> +	*value = data & BIT(0);
>  	return 0;
>  }
>  
> @@ -85,13 +89,12 @@ static int chtdc_ti_pmic_update_power(struct regmap *regmap, int reg, int bit,
>  
>  static int chtdc_ti_pmic_get_raw_temp(struct regmap *regmap, int reg)
>  {
> -	u8 buf[2];
> +	__be16 buf;
>  
> -	if (regmap_bulk_read(regmap, reg, buf, sizeof(buf)))
> +	if (regmap_bulk_read(regmap, reg, &buf, sizeof(buf)))
>  		return -EIO;
>  
> -	/* stored in big-endian */
> -	return ((buf[0] & 0x03) << 8) | buf[1];
> +	return be16_to_cpu(buf) & PMIC_REG_MASK;
>  }
>  
>  static const struct intel_pmic_opregion_data chtdc_ti_pmic_opregion_data = {
> diff --git a/drivers/acpi/pmic/intel_pmic_xpower.c b/drivers/acpi/pmic/intel_pmic_xpower.c
> index 33c5e85294cd..3c7380ec8203 100644
> --- a/drivers/acpi/pmic/intel_pmic_xpower.c
> +++ b/drivers/acpi/pmic/intel_pmic_xpower.c
> @@ -6,11 +6,15 @@
>   */
>  
>  #include <linux/acpi.h>
> +#include <linux/bits.h>
> +#include <linux/byteorder/generic.h>
>  #include <linux/init.h>
>  #include <linux/mfd/axp20x.h>
>  #include <linux/regmap.h>
>  #include <linux/platform_device.h>
> +
>  #include <asm/iosf_mbi.h>
> +
>  #include "intel_pmic.h"
>  
>  #define XPOWER_GPADC_LOW	0x5b
> @@ -218,7 +222,7 @@ static int intel_xpower_pmic_update_power(struct regmap *regmap, int reg,
>  static int intel_xpower_pmic_get_raw_temp(struct regmap *regmap, int reg)
>  {
>  	int ret, adc_ts_pin_ctrl;
> -	u8 buf[2];
> +	__be16 buf;
>  
>  	/*
>  	 * The current-source used for the battery temp-sensor (TS) is shared
> @@ -255,9 +259,9 @@ static int intel_xpower_pmic_get_raw_temp(struct regmap *regmap, int reg)
>  	if (ret)
>  		return ret;
>  
> -	ret = regmap_bulk_read(regmap, AXP288_GP_ADC_H, buf, sizeof(buf));
> +	ret = regmap_bulk_read(regmap, AXP288_GP_ADC_H, &buf, sizeof(buf));
>  	if (ret == 0)
> -		ret = (buf[0] << 4) + ((buf[1] >> 4) & 0x0f);
> +		ret = be16_to_cpu(buf) >> 4;
>  
>  	if (adc_ts_pin_ctrl & AXP288_ADC_TS_CURRENT_ON_OFF_MASK) {
>  		regmap_update_bits(regmap, AXP288_ADC_TS_PIN_CTRL,

