Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2A4507C4D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 00:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358137AbiDSWCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 18:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbiDSWCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 18:02:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7256C40E5A;
        Tue, 19 Apr 2022 14:59:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EC4C617B1;
        Tue, 19 Apr 2022 21:59:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA1CC385A5;
        Tue, 19 Apr 2022 21:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650405578;
        bh=7wDXC7Po6MR8ODEJF4YIi3tHq7GK9Lc2S38RNkP9/us=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bAjdWxbfSluxfCDNcc8t4jiTxI1s5IcE8z+SCBqWGnijue0MVoqr3NiXina1cgi76
         R2LWxiPoh4XE87ZVdkkR4YDx7RF8ZwjtBeKad3RAdqm7ObPhObhpoyxwTGCApE5nMk
         ED5QWvhmWCBAYvQ7jlRNYidePWvPf8khuxSnBNBmsrXIQhy8v0wJlnlUI1OmTxSYkb
         wxLyxrOF7d1znDsvGDCpfn0JVZvw8mTg986PLBGo8lQ54ispqcsCOkOwPAOJpO5mY9
         eJZAW7Y/jmcXtu8czTyEN7ysEKGdbezKnvCaUILysjIYk8tDxAbg2yaiggfjsHKLUq
         ZkCWuPAHz6q1g==
Received: by pali.im (Postfix)
        id 3145D692; Tue, 19 Apr 2022 23:59:35 +0200 (CEST)
Date:   Tue, 19 Apr 2022 23:59:35 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     "Sicelo A. Mhlongo" <absicsz@gmail.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] power: supply: bq27xxx: expose battery data when CI=1
Message-ID: <20220419215935.jtbcutnpi6345gqj@pali>
References: <20220419213647.1186284-1-absicsz@gmail.com>
 <20220419213647.1186284-2-absicsz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220419213647.1186284-2-absicsz@gmail.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 April 2022 23:36:47 Sicelo A. Mhlongo wrote:
> When the Capacity Inaccurate flag is set, the chip still provides data
> about the battery, albeit inaccurate. Instead of discarding capacity
> values for CI=1, expose the stale data and use the
> POWER_SUPPLY_HEALTH_CALIBRATION_REQUIRED property to indicate that the
> values should be used with care.

Looks good! I did not know that there is CALIBRATION_REQUIRED property.

Reviewed-by: Pali Rohár <pali@kernel.org>

> Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
> ---
>  drivers/power/supply/bq27xxx_battery.c | 58 +++++++++++++-------------
>  1 file changed, 28 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> index 72e727cd31e8..a524237b758e 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -1572,14 +1572,6 @@ static int bq27xxx_battery_read_charge(struct bq27xxx_device_info *di, u8 reg)
>   */
>  static inline int bq27xxx_battery_read_nac(struct bq27xxx_device_info *di)
>  {
> -	int flags;
> -
> -	if (di->opts & BQ27XXX_O_ZERO) {
> -		flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, true);
> -		if (flags >= 0 && (flags & BQ27000_FLAG_CI))
> -			return -ENODATA;
> -	}
> -
>  	return bq27xxx_battery_read_charge(di, BQ27XXX_REG_NAC);
>  }
>  
> @@ -1742,6 +1734,18 @@ static bool bq27xxx_battery_dead(struct bq27xxx_device_info *di, u16 flags)
>  		return flags & (BQ27XXX_FLAG_SOC1 | BQ27XXX_FLAG_SOCF);
>  }
>  
> +/*
> + * Returns true if reported battery capacity is inaccurate
> + */
> +static bool bq27xxx_battery_capacity_inaccurate(struct bq27xxx_device_info *di,
> +						 u16 flags)
> +{
> +	if (di->opts & BQ27XXX_O_HAS_CI)
> +		return (flags & BQ27000_FLAG_CI);
> +	else
> +		return false;
> +}
> +
>  static int bq27xxx_battery_read_health(struct bq27xxx_device_info *di)
>  {
>  	/* Unlikely but important to return first */
> @@ -1751,6 +1755,8 @@ static int bq27xxx_battery_read_health(struct bq27xxx_device_info *di)
>  		return POWER_SUPPLY_HEALTH_COLD;
>  	if (unlikely(bq27xxx_battery_dead(di, di->cache.flags)))
>  		return POWER_SUPPLY_HEALTH_DEAD;
> +	if (unlikely(bq27xxx_battery_capacity_inaccurate(di, di->cache.flags)))
> +		return POWER_SUPPLY_HEALTH_CALIBRATION_REQUIRED;
>  
>  	return POWER_SUPPLY_HEALTH_GOOD;
>  }
> @@ -1767,29 +1773,21 @@ void bq27xxx_battery_update(struct bq27xxx_device_info *di)
>  	if (cache.flags >= 0) {
>  		cache.temperature = bq27xxx_battery_read_temperature(di);
>  		if (has_ci_flag && (cache.flags & BQ27000_FLAG_CI)) {
> -			dev_info_once(di->dev, "battery is not calibrated! ignoring capacity values\n");
> -			cache.capacity = -ENODATA;
> -			cache.energy = -ENODATA;
> -			cache.time_to_empty = -ENODATA;
> -			cache.time_to_empty_avg = -ENODATA;
> -			cache.time_to_full = -ENODATA;
> -			cache.charge_full = -ENODATA;
> -			cache.health = -ENODATA;
> -		} else {
> -			if (di->regs[BQ27XXX_REG_TTE] != INVALID_REG_ADDR)
> -				cache.time_to_empty = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTE);
> -			if (di->regs[BQ27XXX_REG_TTECP] != INVALID_REG_ADDR)
> -				cache.time_to_empty_avg = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTECP);
> -			if (di->regs[BQ27XXX_REG_TTF] != INVALID_REG_ADDR)
> -				cache.time_to_full = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTF);
> -
> -			cache.charge_full = bq27xxx_battery_read_fcc(di);
> -			cache.capacity = bq27xxx_battery_read_soc(di);
> -			if (di->regs[BQ27XXX_REG_AE] != INVALID_REG_ADDR)
> -				cache.energy = bq27xxx_battery_read_energy(di);
> -			di->cache.flags = cache.flags;
> -			cache.health = bq27xxx_battery_read_health(di);
> +			dev_info_once(di->dev, "battery is not calibrated! capacity values are inaccurate\n");

Just one note: Do we still need this info message in dmesg? Now when
this information is going to be reported via sysfs API, I'm not sure if
it still has some value...

>  		}
> +		if (di->regs[BQ27XXX_REG_TTE] != INVALID_REG_ADDR)
> +			cache.time_to_empty = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTE);
> +		if (di->regs[BQ27XXX_REG_TTECP] != INVALID_REG_ADDR)
> +			cache.time_to_empty_avg = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTECP);
> +		if (di->regs[BQ27XXX_REG_TTF] != INVALID_REG_ADDR)
> +			cache.time_to_full = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTF);
> +
> +		cache.charge_full = bq27xxx_battery_read_fcc(di);
> +		cache.capacity = bq27xxx_battery_read_soc(di);
> +		if (di->regs[BQ27XXX_REG_AE] != INVALID_REG_ADDR)
> +			cache.energy = bq27xxx_battery_read_energy(di);
> +		di->cache.flags = cache.flags;
> +		cache.health = bq27xxx_battery_read_health(di);
>  		if (di->regs[BQ27XXX_REG_CYCT] != INVALID_REG_ADDR)
>  			cache.cycle_count = bq27xxx_battery_read_cyct(di);
>  
> -- 
> 2.35.2
> 
