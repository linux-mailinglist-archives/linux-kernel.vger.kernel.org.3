Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA5F5469A1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 17:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242916AbiFJPml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 11:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiFJPm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 11:42:26 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E172B8C44;
        Fri, 10 Jun 2022 08:40:40 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h5so37091476wrb.0;
        Fri, 10 Jun 2022 08:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:date:in-reply-to:message-id
         :mime-version;
        bh=ZBVhhNStPSoyhVUwxJV9zLRHhJ+2JlPizwbUhGKDIOQ=;
        b=AsGsyHTjVXO0amvnzMxuzrEw372KvctB5ZyrT3QR/ajpJvFTQ43R4ScmYBBlGU6/my
         4TvWJkuzAToBfmJIDzFi+4nKoGk7aC6VMPCjZgRMzhfj8ul8EyydGYOd7QtXi+ssDhoP
         +h6Qj6F0diFY06SECj4KmP0owES/EgOM4wi7hogNPxAu9GrjZnQVsa+amfIVK35QpSOs
         vnV09zFT/VWG/3/zhMDs5TFOD+vE/vh9a/EDmXmYxNEOEShVP4brMVt0xA+ZB6wBGwTg
         tMdEukE74FUkqAmQL5PjNwhaxWfR3dfPVXblV+MO+4hsXlptQIuIlM2MmVQZQfP/sKTa
         JFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=ZBVhhNStPSoyhVUwxJV9zLRHhJ+2JlPizwbUhGKDIOQ=;
        b=MWNtgKWhVu9DSSLF9d+GisesfxbbSqu1QNzDqqdnFH4X/bKcsXU6RtGehdCFVoBS8u
         CwlNd2pd80CromuFwgYrS1k2eEAhxMCRFrzPpaPuAOmGXJpbUXzB24XdUNXjyfCo4w+S
         GSzjZ39so/Hb89r7RqM4GL/zyKGkpfqVA6700VXUOvajuM9d9pmpgqAdCMFFG8ewC0Wj
         MutYZSSyJa7f0WRNueWQWtlw3NwuijS6hXIZ5Ie1ACdFpkJ7+SHv66z4wfk1l5O66/cM
         SDDRWhyp6wuI3R043/SgOxeqrdZC/N7xM+EdzuWvPBWluwfz1oRqFmoOmzo+DuM/Dpjh
         buLQ==
X-Gm-Message-State: AOAM531vWJEaTn4zDEm5gzfzZq0qOpyxiWUz8AyXjPOTkVDyMGWdn9hd
        BMOzJnf/rQPJSocav6f9u9A=
X-Google-Smtp-Source: ABdhPJyA9EyiLFlTgMRd7WyXq1TrET+N2zkA9ji2fWBhr0WiOoDz8Jm8IkFyneqwUaYiXrAWRUiwjA==
X-Received: by 2002:adf:dc87:0:b0:216:cfca:65d with SMTP id r7-20020adfdc87000000b00216cfca065dmr32710829wrj.316.1654875635010;
        Fri, 10 Jun 2022 08:40:35 -0700 (PDT)
Received: from localhost (92.40.202.174.threembb.co.uk. [92.40.202.174])
        by smtp.gmail.com with ESMTPSA id m5-20020adffe45000000b00219e8d28fb1sm2011791wrs.57.2022.06.10.08.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 08:40:34 -0700 (PDT)
References: <20220607155324.118102-1-aidanmacdonald.0x0@gmail.com>
 <20220607155324.118102-16-aidanmacdonald.0x0@gmail.com>
 <20220609211128.5knoptfwhongwrtq@mercury.elektranox.org>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com, lars@metafoo.de,
        rafael@kernel.org, quic_gurus@quicinc.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 15/17] power: axp20x_battery: Add constant charge
 current table
Date:   Fri, 10 Jun 2022 16:40:42 +0100
In-reply-to: <20220609211128.5knoptfwhongwrtq@mercury.elektranox.org>
Message-ID: <gKpfihJrKPqPrh3VA3orlvQrkllR4TMW@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sebastian Reichel <sebastian.reichel@collabora.com> writes:

> Hi,
>
> On Tue, Jun 07, 2022 at 04:53:22PM +0100, Aidan MacDonald wrote:
>> Add a table-based lookup method for constant charge current,
>> which is necessary when the setting cannot be represented as
>> a linear range.
>> 
>> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>> ---
>>  drivers/power/supply/axp20x_battery.c | 53 +++++++++++++++++++++------
>>  1 file changed, 41 insertions(+), 12 deletions(-)
>> 
>> diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
>> index 9106077c0dbb..87fb958f2224 100644
>> --- a/drivers/power/supply/axp20x_battery.c
>> +++ b/drivers/power/supply/axp20x_battery.c
>> @@ -61,6 +61,7 @@ struct axp20x_batt_ps;
>>  struct axp_data {
>>  	int	ccc_scale;
>>  	int	ccc_offset;
>> +	const int *ccc_table;
>
> Please document the struct; especially the fact that ccc_table must
> have a size of AXP20X_CHRG_CTRL1_TGT_CURR + 1.
>
> -- Sebastian
>

Thanks, I'll make sure to do that in v3.

Regards,
Aidan

>>  	bool	has_fg_valid;
>>  	int	(*get_max_voltage)(struct axp20x_batt_ps *batt, int *val);
>>  	int	(*set_max_voltage)(struct axp20x_batt_ps *batt, int val);
>> @@ -176,7 +177,10 @@ static int axp20x_get_constant_charge_current(struct axp20x_batt_ps *axp,
>>  
>>  	*val &= AXP20X_CHRG_CTRL1_TGT_CURR;
>>  
>> -	*val = *val * axp->data->ccc_scale + axp->data->ccc_offset;
>> +	if (axp->data->ccc_table)
>> +		*val = axp->data->ccc_table[*val];
>> +	else
>> +		*val = *val * axp->data->ccc_scale + axp->data->ccc_offset;
>>  
>>  	return 0;
>>  }
>> @@ -389,16 +393,36 @@ static int axp20x_battery_set_max_voltage(struct axp20x_batt_ps *axp20x_batt,
>>  				  AXP20X_CHRG_CTRL1_TGT_VOLT, val);
>>  }
>>  
>> +static int axp20x_get_constant_charge_current_sel(struct axp20x_batt_ps *axp_batt,
>> +						  int charge_current)
>> +{
>> +	int i;
>> +
>> +	if (axp_batt->data->ccc_table) {
>> +		for (i = AXP20X_CHRG_CTRL1_TGT_CURR; i >= 0; --i) {
>> +			if (axp_batt->data->ccc_table[i] <= charge_current)
>> +				return i;
>> +		}
>> +
>> +		return -EINVAL;
>> +	}
>> +
>> +	i = (charge_current - axp_batt->data->ccc_offset) / axp_batt->data->ccc_scale;
>> +
>> +	if (i > AXP20X_CHRG_CTRL1_TGT_CURR || i < 0)
>> +		return -EINVAL;
>> +
>> +	return i;
>> +}
>> +
>>  static int axp20x_set_constant_charge_current(struct axp20x_batt_ps *axp_batt,
>>  					      int charge_current)
>>  {
>>  	if (charge_current > axp_batt->max_ccc)
>>  		return -EINVAL;
>>  
>> -	charge_current = (charge_current - axp_batt->data->ccc_offset) /
>> -		axp_batt->data->ccc_scale;
>> -
>> -	if (charge_current > AXP20X_CHRG_CTRL1_TGT_CURR || charge_current < 0)
>> +	charge_current = axp20x_get_constant_charge_current_sel(axp_batt, charge_current);
>> +	if (charge_current < 0)
>>  		return -EINVAL;
>>  
>>  	return regmap_update_bits(axp_batt->regmap, AXP20X_CHRG_CTRL1,
>> @@ -410,14 +434,14 @@ static int axp20x_set_max_constant_charge_current(struct axp20x_batt_ps *axp,
>>  {
>>  	bool lower_max = false;
>>  
>> -	charge_current = (charge_current - axp->data->ccc_offset) /
>> -		axp->data->ccc_scale;
>> -
>> -	if (charge_current > AXP20X_CHRG_CTRL1_TGT_CURR || charge_current < 0)
>> +	charge_current = axp20x_get_constant_charge_current_sel(axp, charge_current);
>> +	if (charge_current < 0)
>>  		return -EINVAL;
>>  
>> -	charge_current = charge_current * axp->data->ccc_scale +
>> -		axp->data->ccc_offset;
>> +	if (axp->data->ccc_table)
>> +		charge_current = axp->data->ccc_table[charge_current];
>> +	else
>> +		charge_current = charge_current * axp->data->ccc_scale + axp->data->ccc_offset;
>>  
>>  	if (charge_current > axp->max_ccc)
>>  		dev_warn(axp->dev,
>> @@ -629,7 +653,12 @@ static int axp20x_power_probe(struct platform_device *pdev)
>>  								   ccc)) {
>>  			dev_err(&pdev->dev,
>>  				"couldn't set constant charge current from DT: fallback to minimum value\n");
>> -			ccc = 300000;
>> +
>> +			if (axp20x_batt->data->ccc_table)
>> +				ccc = axp20x_batt->data->ccc_table[0];
>> +			else
>> +				ccc = axp20x_batt->data->ccc_offset;
>> +
>>  			axp20x_batt->max_ccc = ccc;
>>  			axp20x_set_constant_charge_current(axp20x_batt, ccc);
>>  		}
>> -- 
>> 2.35.1
>> 
