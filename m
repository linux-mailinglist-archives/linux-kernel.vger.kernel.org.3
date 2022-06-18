Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76245505DE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 17:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbiFRPqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 11:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiFRPqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 11:46:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE49DFD7;
        Sat, 18 Jun 2022 08:46:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C52BB80122;
        Sat, 18 Jun 2022 15:46:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88AAAC3411A;
        Sat, 18 Jun 2022 15:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655567179;
        bh=ZGW00kE2X5QeC42ZPdciUlBPY1kZEm9YExB8rVytviM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CNxKtQsOJ7okFR8VWDvxsg1POAjID1uJ7gnyCcdIqRIJP+Q3wOxlRxPzYa0gFuBhG
         auKr9veH/mlCT/MDGpiE8L9q3cIc8BHL7HgothiPlZb6n4EnAf4lVeg28wVwv40TZI
         WT21g+aMay0vq6jFiARX4FcoJ4/q2X4O1b7VdcqeGldt7znXGokQszfhdXPUgqOmbz
         ATAzpnTuhd1JEkDM8VQzLph/0HIWj1Bq7JfBc55qj6jxm47pj/EUKtN/IEZZaE3bkR
         VG1YdW75ntG/4SXRc7jztJpMGhwPlGEnJ+ahGVDIJ12mxwUbP4reQz14LNHIqpdQSV
         fEDg98ZqOBDhQ==
Date:   Sat, 18 Jun 2022 16:55:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     lars@metafoo.de, matthias.bgg@gmail.com, lee.jones@linaro.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com, pavel@ucw.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com, ChiYuan Huang <cy_huang@richtek.com>
Subject: Re: [PATCH v2 08/15] mfd: mt6370: Add Mediatek MT6370 support
Message-ID: <20220618165533.5669e288@jic23-huawei>
In-Reply-To: <20220613111146.25221-9-peterwu.pub@gmail.com>
References: <20220613111146.25221-1-peterwu.pub@gmail.com>
        <20220613111146.25221-9-peterwu.pub@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jun 2022 19:11:39 +0800
ChiaEn Wu <peterwu.pub@gmail.com> wrote:

> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add Mediatek MT6370 MFD support.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
Hi.

A few trivial things that probably overlap with other reviewer
comments.


> +static int mt6370_check_vendor_info(struct mt6370_info *info)
> +{
> +	unsigned int devinfo;
> +	int ret;
> +
> +	ret = regmap_read(info->regmap, MT6370_REG_DEV_INFO, &devinfo);
> +	if (ret)
> +		return ret;
> +
> +	switch (FIELD_GET(MT6370_VENID_MASK, devinfo)) {
> +	case 0x8: /* RT5081 */
> +	case 0xA: /* RT5081A */
> +	case 0xE: /* MT6370 */
> +	case 0xF: /* MT6371 */
> +	case 0x9: /* MT6372P */
> +	case 0xB: /* MT6372CP */
> +		break;
> +	default:
> +		dev_err(info->dev, "Not invalid value 0x%02x\n", devinfo);

Double negative... You mean "Invalid value" 
though you probably want to say something more specific such as
		"Unknown Vendor ID 0x%02x\n")

> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mt6370_regmap_read(void *context, const void *reg_buf,
> +			      size_t reg_size, void *val_buf, size_t val_size)
> +{
> +	struct mt6370_info *info = context;
> +	u8 bank_idx = *(u8 *)reg_buf, bank_addr = *(u8 *)(reg_buf + 1);
> +	int ret;
> +
> +	ret = i2c_smbus_read_i2c_block_data(info->i2c[bank_idx], bank_addr,
> +					    val_size, val_buf);
> +	if (ret != val_size)
> +		return ret;
If it's positive , that is probably not what regmap expects.
See handling in here
https://elixir.bootlin.com/linux/latest/source/drivers/base/regmap/regmap-i2c.c#L222

> +
> +	return 0;
> +}


> +
> +static int mt6370_probe(struct i2c_client *i2c)
> +{
> +	struct mt6370_info *info;
> +	struct i2c_client *usbc_i2c;
> +	int ret;
> +
> +	info = devm_kzalloc(&i2c->dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	info->dev = &i2c->dev;
> +
> +	usbc_i2c = devm_i2c_new_dummy_device(&i2c->dev, i2c->adapter,
> +					     MT6370_USBC_I2CADDR);
> +	if (IS_ERR(usbc_i2c)) {
> +		ret = PTR_ERR(usbc_i2c);
> +		dev_err(&i2c->dev, "Failed to register usbc i2c client %d\n", ret);
Might as well use
		return dev_err_probe(&i2c->dev, PTR_ERR(usb_i2c),
				     "Failed to register USBC I2C client\n");

Whilst the defer handling isn't relevant, it is safe to use throughout probe
and tidier in this case at least.

> +		return ret;
> +	}
> +
> +	/* Assign I2C client for PMU and TypeC */
> +	info->i2c[MT6370_PMU_I2C] = i2c;
> +	info->i2c[MT6370_USBC_I2C] = usbc_i2c;
> +
> +	info->regmap = devm_regmap_init(&i2c->dev, &mt6370_regmap_bus, info,
> +					&mt6370_regmap_config);
> +	if (IS_ERR(info->regmap)) {
> +		ret = PTR_ERR(info->regmap);
> +		dev_err(&i2c->dev, "Failed to register regmap (%d)\n", ret);

as above dev_err_probe() will tidy this and following cases up for you.

> +		return ret;
> +	}
> +
> +	ret = mt6370_check_vendor_info(info);
> +	if (ret) {
> +		dev_err(&i2c->dev, "Failed to check vendor info (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	ret = devm_regmap_add_irq_chip(&i2c->dev, info->regmap, i2c->irq,
> +				       IRQF_ONESHOT, -1, &mt6370_irq_chip,
> +				       &info->irq_data);
> +	if (ret) {
> +		dev_err(&i2c->dev, "Failed to add irq chip (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	return devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO,
> +				    mt6370_devices, ARRAY_SIZE(mt6370_devices),
> +				    NULL, 0,
> +				    regmap_irq_get_domain(info->irq_data));
> +}
