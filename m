Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEAB496D26
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 18:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbiAVRzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 12:55:47 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36966 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiAVRzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 12:55:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2763460E93;
        Sat, 22 Jan 2022 17:55:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293C7C004E1;
        Sat, 22 Jan 2022 17:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642874143;
        bh=ShVTb8K+Cj7zIZtxwnykU0NLsWRT2b34SOiw2JTdwGw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=twqPX82ngF+YqEu/y0I/9izIy/pNTQkB7KgpRjr0WOiKts0z5BCgovWA4C51DpqpC
         Dt7zJKq9XR1FXwG38CrG8jfYrmsafYo0+HAnphT7x/vtvc/MKmo9ZyY/U1L7mzTwrG
         3nQGbCpfmNJQuzKZUShw+yKceD7DDOnGkCBMzigwCKBDQyO1HPkje9SSLFP5fqbbC2
         Upiw9vf0GlbJ8LQHBdBtugBhh35ZjksZM7s/7Y35LHdlzg6n99tMY76bI9O9O63tHk
         kgpSH9qcGY1rqm7UtfEZ3pKwSWnYsrDqzzc1ZjnX2mReRMy1bVIrk/DqjmGQvyL4TN
         OHU7P7j5Kb0Bw==
Date:   Sat, 22 Jan 2022 18:01:54 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] iio:frequency:admv1014: add support for ADMV1014
Message-ID: <20220122180154.3415aed1@jic23-huawei>
In-Reply-To: <20220119081838.70210-1-antoniu.miclaus@analog.com>
References: <20220119081838.70210-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2022 10:18:35 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> The ADMV1014 is a silicon germanium (SiGe), wideband,
> microwave downconverter optimized for point to point microwave
> radio designs operating in the 24 GHz to 44 GHz frequency range.
> 
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADMV1014.pdf
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Hi Antoniu,

This looks mostly fine to me, but I think you haven't quite understood
the difference between a required regulator and an optional one.
It's about whether there is power needed on the pin. E.g. sometimes for things
like reference voltages we can use either an external voltage or an
internally generated reference, thus making vref-supply optional.
It's not about whether they 'need' to be specified in DT.  The regulator
core has a concept of a dummy regulator which is provided in some
cases when we request a regulator and one is not specified.  This
is a simplification to allow for always on supplies without fully describing
them. That fallback is what should be relied on, not optional regulators
unless they really are.

Once you've made most (maybe all?) of the regulators in here non optional
you can use the bulk get / enable regulator calls to cut down on repetition.

Thanks,

Jonathan


...

> +static int admv1014_init(struct admv1014_state *st)
> +{
> +	int ret;
> +	unsigned int chip_id, enable_reg, enable_reg_msk;
> +	struct spi_device *spi = st->spi;
> +
> +	ret = regulator_enable(st->vcm_reg);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to enable Common-Mode Voltage!\n");
> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(&spi->dev, admv1014_reg_disable, st->vcm_reg);
> +	if (ret)
> +		return ret;
> +
> +	if (st->vcc_if_bb_reg) {
> +		ret = regulator_enable(st->vcc_if_bb_reg);
> +		if (ret) {
> +			dev_err(&spi->dev, "Failed to enable BB and IF Voltage!\n");
> +			return ret;
> +		}
> +
> +		ret = devm_add_action_or_reset(&spi->dev, admv1014_reg_disable, st->vcc_if_bb_reg);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (st->vcc_vga_reg) {

I'm fairly sure these should not be optional regs (they may be dummy ones provided by
the regulator subsystem) so we should always enable them.


As below, you should be able to use bulk regulator handling for all of these.

> +		ret = regulator_enable(st->vcc_vga_reg);
> +		if (ret) {
> +			dev_err(&spi->dev, "Failed to enable RF Amplifier Voltage!\n");
> +			return ret;
> +		}
> +
> +		ret = devm_add_action_or_reset(&spi->dev, admv1014_reg_disable, st->vcc_vga_reg);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (st->vcc_vva_reg) {
> +		ret = regulator_enable(st->vcc_vva_reg);
> +		if (ret) {
> +			dev_err(&spi->dev, "Failed to enable VVA Control Circuit Voltage!\n");
> +			return ret;
> +		}
> +
> +		ret = devm_add_action_or_reset(&spi->dev, admv1014_reg_disable, st->vcc_vva_reg);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (st->vcc_lna_3p3_reg) {
> +		ret = regulator_enable(st->vcc_lna_3p3_reg);
> +		if (ret) {
> +			dev_err(&spi->dev, "Failed to enable Low Noise Amplifier 3.3V Voltage!\n");
> +			return ret;
> +		}
> +
> +		ret = devm_add_action_or_reset(&spi->dev, admv1014_reg_disable, st->vcc_lna_3p3_reg);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (st->vcc_lna_1p5_reg) {
> +		ret = regulator_enable(st->vcc_lna_1p5_reg);
> +		if (ret) {
> +			dev_err(&spi->dev, "Failed to enable Low Noise Amplifier 1.5V Voltage!\n");
> +			return ret;
> +		}
> +
> +		ret = devm_add_action_or_reset(&spi->dev, admv1014_reg_disable, st->vcc_lna_1p5_reg);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (st->vcc_bg_reg) {
> +		ret = regulator_enable(st->vcc_bg_reg);
> +		if (ret) {
> +			dev_err(&spi->dev, "Failed to enable Band Gap Circuit Voltage!\n");
> +			return ret;
> +		}
> +
> +		ret = devm_add_action_or_reset(&spi->dev, admv1014_reg_disable, st->vcc_bg_reg);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (st->vcc_quad_reg) {
> +		ret = regulator_enable(st->vcc_quad_reg);
> +		if (ret) {
> +			dev_err(&spi->dev, "Failed to enable Quadruple Voltage!\n");
> +			return ret;
> +		}
> +
> +		ret = devm_add_action_or_reset(&spi->dev, admv1014_reg_disable, st->vcc_quad_reg);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (st->vcc_mixer_reg) {
> +		ret = regulator_enable(st->vcc_mixer_reg);
> +		if (ret) {
> +			dev_err(&spi->dev, "Failed to enable Mixer Voltage!\n");
> +			return ret;
> +		}
> +
> +		ret = devm_add_action_or_reset(&spi->dev, admv1014_reg_disable, st->vcc_mixer_reg);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = clk_prepare_enable(st->clkin);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(&spi->dev, admv1014_clk_disable, st->clkin);
> +	if (ret)
> +		return ret;
> +
> +	st->nb.notifier_call = admv1014_freq_change;
> +	ret = devm_clk_notifier_register(&spi->dev, st->clkin, &st->nb);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(&spi->dev, admv1014_powerdown, st);
> +	if (ret)
> +		return ret;
> +
> +	/* Perform a software reset */
> +	ret = __admv1014_spi_update_bits(st, ADMV1014_REG_SPI_CONTROL,
> +					 ADMV1014_SPI_SOFT_RESET_MSK,
> +					 FIELD_PREP(ADMV1014_SPI_SOFT_RESET_MSK, 1));
> +	if (ret) {
> +		dev_err(&spi->dev, "ADMV1014 SPI software reset failed.\n");
> +		return ret;
> +	}
> +
> +	ret = __admv1014_spi_update_bits(st, ADMV1014_REG_SPI_CONTROL,
> +					 ADMV1014_SPI_SOFT_RESET_MSK,
> +					 FIELD_PREP(ADMV1014_SPI_SOFT_RESET_MSK, 0));
> +	if (ret) {
> +		dev_err(&spi->dev, "ADMV1014 SPI software reset disable failed.\n");
> +		return ret;
> +	}
> +
> +	ret = __admv1014_spi_write(st, ADMV1014_REG_VVA_TEMP_COMP, 0x727C);
> +	if (ret) {
> +		dev_err(&spi->dev, "Writing default Temperature Compensation value failed.\n");
> +		return ret;
> +	}
> +
> +	ret = __admv1014_spi_read(st, ADMV1014_REG_SPI_CONTROL, &chip_id);
> +	if (ret)
> +		return ret;
> +
> +	chip_id = (chip_id & ADMV1014_CHIP_ID_MSK) >> 4;
> +	if (chip_id != ADMV1014_CHIP_ID) {
> +		dev_err(&spi->dev, "Invalid Chip ID.\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = __admv1014_spi_update_bits(st, ADMV1014_REG_QUAD,
> +					 ADMV1014_QUAD_SE_MODE_MSK,
> +					 FIELD_PREP(ADMV1014_QUAD_SE_MODE_MSK,
> +						    st->quad_se_mode));
> +	if (ret) {
> +		dev_err(&spi->dev, "Writing Quad SE Mode failed.\n");
> +		return ret;
> +	}
> +
> +	ret = admv1014_update_quad_filters(st);
> +	if (ret) {
> +		dev_err(&spi->dev, "Update Quad Filters failed.\n");
> +		return ret;
> +	}
> +
> +	ret = admv1014_update_vcm_settings(st);
> +	if (ret) {
> +		dev_err(&spi->dev, "Update VCM Settings failed.\n");
> +		return ret;
> +	}
> +
> +	enable_reg_msk = ADMV1014_P1DB_COMPENSATION_MSK |
> +			 ADMV1014_IF_AMP_PD_MSK |
> +			 ADMV1014_BB_AMP_PD_MSK |
> +			 ADMV1014_DET_EN_MSK;
> +
> +	enable_reg = FIELD_PREP(ADMV1014_P1DB_COMPENSATION_MSK, st->p1db_comp ? 3 : 0) |
> +		     FIELD_PREP(ADMV1014_IF_AMP_PD_MSK, !(st->input_mode)) |
> +		     FIELD_PREP(ADMV1014_BB_AMP_PD_MSK, st->input_mode) |
> +		     FIELD_PREP(ADMV1014_DET_EN_MSK, st->det_en);
> +
> +	return __admv1014_spi_update_bits(st, ADMV1014_REG_ENABLE, enable_reg_msk, enable_reg);
> +}
> +
> +static int admv1014_properties_parse(struct admv1014_state *st)
> +{
> +	const char *str;
> +	struct spi_device *spi = st->spi;
> +
> +	st->det_en = device_property_read_bool(&spi->dev, "adi,detector-enable");
> +
> +	st->p1db_comp = device_property_read_bool(&spi->dev, "adi,p1db-compensation-enable");
> +
> +	str = "iq";
> +	device_property_read_string(&spi->dev, "adi,input-mode", &str);
> +
> +	if (!strcmp(str, "iq"))
> +		st->input_mode = ADMV1014_IQ_MODE;
> +	else if (!strcmp(str, "if"))
> +		st->input_mode = ADMV1014_IF_MODE;
> +	else
> +		return -EINVAL;
> +
> +	str = "diff";
> +	device_property_read_string(&spi->dev, "adi,quad-se-mode", &str);
> +
> +	if (!strcmp(str, "diff"))
> +		st->quad_se_mode = ADMV1014_SE_MODE_DIFF;
> +	else if (!strcmp(str, "se-pos"))
> +		st->quad_se_mode = ADMV1014_SE_MODE_POS;
> +	else if (!strcmp(str, "se-neg"))
> +		st->quad_se_mode = ADMV1014_SE_MODE_NEG;
> +	else
> +		return -EINVAL;
> +
> +	st->vcm_reg = devm_regulator_get(&spi->dev, "vcm");
> +	if (IS_ERR(st->vcm_reg))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->vcm_reg),
> +				     "failed to get the common-mode voltage\n");
> +
> +	st->vcc_if_bb_reg = devm_regulator_get_optional(&spi->dev, "vcc-if-bb");

Are these actually optional?  That means we can operate the device in a mode where
it doesn't matter if there is power on this pin...  It doesn't mean we have
to specify them in DT, because they may be always on supplies in which case
a dummy regulator is fine (which is what you get from devm_regulator_get() 
under some circumstances when one isn't specified).


Having made those that aren't actually optional, non optional you can probably
use the bulk regulator controls to avoid lots of identical calls.

> +	if (IS_ERR(st->vcc_if_bb_reg))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->vcc_if_bb_reg),
> +				     "failed to get the BB and IF supply\n");
> +
> +	st->vcc_vga_reg = devm_regulator_get_optional(&spi->dev, "vcc-vga");
> +	if (IS_ERR(st->vcc_vga_reg))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->vcc_vga_reg),
> +				     "failed to get the RF Amplifier supply\n");
> +
> +	st->vcc_vva_reg = devm_regulator_get_optional(&spi->dev, "vcc-vva");
> +	if (IS_ERR(st->vcc_vva_reg))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->vcc_vva_reg),
> +				     "failed to get the VVA Control Circuit supply\n");
> +
> +	st->vcc_lna_3p3_reg = devm_regulator_get_optional(&spi->dev, "vcc-lna-3p3");
> +	if (IS_ERR(st->vcc_lna_3p3_reg))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->vcc_lna_3p3_reg),
> +				     "failed to get the Low Noise Amplifier 3.3V supply\n");
> +
> +	st->vcc_lna_1p5_reg = devm_regulator_get_optional(&spi->dev, "vcc-lna-1p5");
> +	if (IS_ERR(st->vcc_lna_1p5_reg))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->vcc_lna_1p5_reg),
> +				     "failed to get the Low Noise Amplifier 1.5V supply\n");
> +
> +	st->vcc_bg_reg = devm_regulator_get_optional(&spi->dev, "vcc-bg");
> +	if (IS_ERR(st->vcc_lna_1p5_reg))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->vcc_bg_reg),
> +				     "failed to get the Band Gap Circuit supply\n");
> +
> +	st->vcc_quad_reg = devm_regulator_get_optional(&spi->dev, "vcc-quad");
> +	if (IS_ERR(st->vcc_quad_reg))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->vcc_quad_reg),
> +				     "failed to get the Quadruple supply\n");
> +
> +	st->vcc_mixer_reg = devm_regulator_get_optional(&spi->dev, "vcc-mixer");
> +	if (IS_ERR(st->vcc_quad_reg))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->vcc_mixer_reg),
> +				     "failed to get the Mixer supply\n");
> +
> +	st->clkin = devm_clk_get(&spi->dev, "lo_in");
> +	if (IS_ERR(st->clkin))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->clkin),
> +				     "failed to get the LO input clock\n");
> +
> +	return 0;
> +}
> +

