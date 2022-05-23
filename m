Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFF8530F18
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbiEWMta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 08:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235733AbiEWMtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 08:49:25 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB2E4EA37;
        Mon, 23 May 2022 05:49:23 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id BD9A41F42F1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653310162;
        bh=s97rWWbc/m/oI+hUShZa6zXrVCJ0ZgxpFAi04DJsT8Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mUO2Rnn5MUHx5GKdBszSmgbjorsWmooPNI+svWc9VXtYozCsvNStD5OcVJ9LiG4dT
         dFzsK1NhRoPIEXFm7qs8H3bekLzXXMwePpLXkolhdyTrw2yhtUW9cpSBR74jmYk9zM
         dQigSeiodRGHWtWx1wNPv/Xz6zL49vKkAdaWzDAkmtXY8pTgflz/86+X/17RgxEcuC
         qcqj5J7dJNpqLIC8IqHfemjndlkhGjdeC7QJ3KPTHuI5eO27KFr7ShIWTZLsRQKV8M
         kbaeIAyCzxCuicVsvBki3KlxirKKGviw+0P/VxXbJienRCrwUnewQNwcsba32jibrA
         ZzoHqv30Ln5Vg==
Message-ID: <6cc68be9-e509-eae4-801d-997fdc01dcf2@collabora.com>
Date:   Mon, 23 May 2022 14:49:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/4] regulator: Add driver for MT6331 PMIC regulators
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220520133305.265310-1-angelogioacchino.delregno@collabora.com>
 <20220520133305.265310-3-angelogioacchino.delregno@collabora.com>
 <YoepiTUfdhkYByo7@sirena.org.uk>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <YoepiTUfdhkYByo7@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/05/22 16:45, Mark Brown ha scritto:
> On Fri, May 20, 2022 at 03:33:03PM +0200, AngeloGioacchino Del Regno wrote:
> 
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2022 Collabora Ltd.
>> + * Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> + *
> 
> Please make the entire comment a C++ one so things look more
> intentional.
> 

Will do.

>> +static const unsigned int ldo_volt_table10[] = {
>> +	1200000, 1300000, 1500000, 1800000,
>> +	1200000, 1300000, 1500000, 1800000,
>> +	1200000, 1300000, 1500000, 1800000,
>> +	1200000, 1300000, 1500000, 1800000,
>> +};
> 
> So the top bits of the voltate selection field just get ignored?  Might
> be easier to just write the code to not include the top bits.
> 

No, they're all valid values for real... but I guess that I can simplify
this voltage table by simply modifying the bitmask that we use for the
regulators that are using this table....

Example:

MT6331_LDO_S("ldo-vcamio", VCAM_IO,  ldo_volt_table10, MT6331_SYSLDO_CON3, 10,

	MT6331_SYSLDO_CON11, GENMASK(6, 3), MT6331_SYSLDO_CON3, GENMASK(1, 0),

	MT6331_EN_STATUS1, BIT(13)),

So for VCAM_IO it's CON11... we have VGP2, VGP3 using CON14, CON15, then there
are no more users for this table.
If I use GENMASK(4, 3), I can effectively leave only four voltage values in
ldo_volt_table10.

Also, I've just noticed a mistake on ldo-vmipi: that's supposed to have a mask
of GENMASK(5, 3), not (6, 3) - which is in turn also making me able to remove
the ldo_volt_table_3a.

Alright, will fix in the next one :))

>> +static int mt6331_get_status(struct regulator_dev *rdev)
>> +{
>> +	struct mt6331_regulator_info *info = rdev_get_drvdata(rdev);
>> +	u32 reg, en_mask, regval;
>> +	int ret;
>> +
>> +	if (info->qi > 0) {
>> +		reg = info->desc.enable_reg;
>> +		en_mask = info->qi;
> 
> If the regulator doesn't have status readback it shouldn't provide a
> get_status() operation.
> 

What I've understood is that when there's no "QI" flag, the enable register
will provide the regulator status (EN/DIS) acting like QI, that's why I've
added that if branch...

Anyway, I'll recheck this part before sending the next version!

>> +static int mt6331_ldo_set_mode(struct regulator_dev *rdev, unsigned int mode)
>> +{
>> +	int ret, val = 0;
>> +	struct mt6331_regulator_info *info = rdev_get_drvdata(rdev);
>> +
>> +	if (!info->modeset_mask) {
>> +		dev_err(&rdev->dev, "regulator %s doesn't support set_mode\n",
>> +			info->desc.name);
>> +		return -EINVAL;
>> +	}
> 
> Just don't provide the operation for these regulators then.  That'll
> mean a separate ops struct but that's fine.

Oki, I'll add new ops then.

Thanks for the review!
P.S.: I'll obviously apply the same suggestions on mt6332-regulator as well.

Cheers,
Angelo
