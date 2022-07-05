Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1532756700A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 15:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbiGENzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 09:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiGENze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:55:34 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE8D25EA8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 06:36:11 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id be10so16154411oib.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 06:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CjDgt4SfCDp9VNfXl4UR9CbIj1KwE7aoAMtoztc6ZiQ=;
        b=LOXydnySS786zG2eaI7T2A7/ZKsPy6ermcn+4p6Y5pBouooJAjkke1VCYyYZpJyWKa
         iAcjH3kNn7SsamJ5gQLGGCEc+mRa+uB4aQGA0Dc3LcgxcgeZWHRbhjvrPZDrlYa3Ff1F
         uTZaFMXI0p6thXr7656W+1Xmy0W0iBuz/uyufcico4A1rlBeyBksnTu9uQGk1CBcgfNs
         SYrOHGoKTEZhpqoAbjh9R/k336twP8kPDZYiBzLKdVrzxX3+RIMbGaUsnrchbWsPDJW/
         aOxHnunPG7gklS96eHKokfet1ASNvukabRBp2/Opz0nhbWDtSVUI8gyYke6a6nzJsKAH
         VvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CjDgt4SfCDp9VNfXl4UR9CbIj1KwE7aoAMtoztc6ZiQ=;
        b=ZTVECUaa58+MLitVBzN6/Q4Sw+7rObyeaISO+YjRIEGUSBljXr5o9npHXX0QRq3ZJ4
         VyixeFWi0QOq6Y3xG2FpvlaLh+KoZbaHZBVzKvLAX+nWH/SvzFXW0nLGNsk1YP59Zq+5
         CGSsMx1uYhBT0D8f8qOP7HLtelHR9O0gDV8S0Lt5pclE3X2eR+sNE4CsP4DYRKNwaOnu
         FakDXqMaxQ5xHza79SKMX7ac7CL1Gn2/hTfROHbzvQ2av8rOu2B7vFmxdAurEpwnyrIJ
         rfGTaLaxiIZOFUgP5oGVarKRSIFIrOIAnBEpYYsnPNSvbUA6p7V77PgTbI4RQAS4JFyS
         Vs3Q==
X-Gm-Message-State: AJIora+d0vAnwz7YsMrwmUkW7rweYUg4dTTS/T4E2u2llo853GJ6CzWF
        2JK7jSjbLuaOc1ieljIXmBHnVA==
X-Google-Smtp-Source: AGRyM1upeTiiUWN2CbvpLj+qJNSL6F59DolXKvG4xDt91FORE75x5xDw5g3kNVRx7lPP49iUq2tvUw==
X-Received: by 2002:aca:d16:0:b0:337:e483:9ba7 with SMTP id 22-20020aca0d16000000b00337e4839ba7mr1478458oin.242.1657028170807;
        Tue, 05 Jul 2022 06:36:10 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id q14-20020a4ad54e000000b0035eb4e5a6c8sm16175992oos.30.2022.07.05.06.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 06:36:10 -0700 (PDT)
Date:   Tue, 5 Jul 2022 08:36:08 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Vinod Koul <vkoul@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com
Subject: Re: [PATCH v10 2/3] phy: qcom-snps: Add support for overriding phy
 tuning parameters
Message-ID: <YsQ+SCE7B+Wjmp1E@builder.lan>
References: <1656854029-21660-1-git-send-email-quic_kriskura@quicinc.com>
 <1656854029-21660-3-git-send-email-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1656854029-21660-3-git-send-email-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 03 Jul 08:13 CDT 2022, Krishna Kurapati wrote:

> Add support for overriding electrical signal tuning parameters for
> SNPS HS Phy.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> Reviewed-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c | 260 +++++++++++++++++++++++++-
>  1 file changed, 258 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
> index 5d20378..a002e90 100644
> --- a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
> +++ b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
> @@ -52,6 +52,12 @@
>  #define USB2_SUSPEND_N				BIT(2)
>  #define USB2_SUSPEND_N_SEL			BIT(3)
>  
> +#define USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X0		(0x6c)
> +#define USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X1		(0x70)
> +#define USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X2		(0x74)
> +#define USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X3		(0x78)
> +#define PARAM_OVRD_MASK				0xFF
> +
>  #define USB2_PHY_USB_PHY_CFG0			(0x94)
>  #define UTMI_PHY_DATAPATH_CTRL_OVERRIDE_EN	BIT(0)
>  #define UTMI_PHY_CMN_CTRL_OVERRIDE_EN		BIT(1)
> @@ -60,12 +66,69 @@
>  #define REFCLK_SEL_MASK				GENMASK(1, 0)
>  #define REFCLK_SEL_DEFAULT			(0x2 << 0)
>  
> +#define HS_DISCONNECT_MASK			GENMASK(2, 0)
> +#define SQUELCH_DETECTOR_MASK			GENMASK(7, 5)
> +
> +#define HS_AMPLITUDE_MASK			GENMASK(3, 0)
> +#define PREEMPHASIS_DURATION_MASK		BIT(5)
> +#define PREEMPHASIS_AMPLITUDE_MASK		GENMASK(7, 6)
> +
> +#define HS_RISE_FALL_MASK			GENMASK(1, 0)
> +#define HS_CROSSOVER_VOLTAGE_MASK		GENMASK(3, 2)
> +#define HS_OUTPUT_IMPEDANCE_MASK		GENMASK(5, 4)
> +
> +#define LS_FS_OUTPUT_IMPEDANCE_MASK		GENMASK(3, 0)
> +
>  static const char * const qcom_snps_hsphy_vreg_names[] = {
>  	"vdda-pll", "vdda33", "vdda18",
>  };
>  
>  #define SNPS_HS_NUM_VREGS		ARRAY_SIZE(qcom_snps_hsphy_vreg_names)
>  
> +struct override_param {
> +	s32	value;
> +	u8	reg;
> +};
> +
> +#define OVERRIDE_PARAM(bps, val) {	\
> +	.value = bps,			\
> +	.reg = val,			\
> +}
> +
> +struct override_param_map {
> +	const struct override_param *param_table;
> +	u8 table_size;
> +	u8 reg_offset;
> +	u8 param_mask;
> +};
> +
> +#define OVERRIDE_PARAM_MAP(table, num_elements, offset, mask)		\
> +{									\
> +	.param_table = table,						\
> +	.table_size = num_elements,					\
> +	.reg_offset = offset,						\
> +	.param_mask = mask,						\
> +}
> +
> +struct phy_override_seq {
> +	bool	need_update;
> +	u8	offset;
> +	u8	value;
> +	u8	mask;
> +};
> +
> +static const char * const phy_seq_props[] = {
> +	"qcom,hs-disconnect-bp",
> +	"qcom,squelch-detector-bp",
> +	"qcom,hs-amplitude-bp",
> +	"qcom,pre-emphasis-duration-bp",
> +	"qcom,pre-emphasis-amplitude-bp",
> +	"qcom,hs-rise-fall-time-bp",
> +	"qcom,hs-crossover-voltage-microvolt",
> +	"qcom,hs-output-impedance-micro-ohms",
> +	"qcom,ls-fs-output-impedance-bp",
> +};
> +
>  /**
>   * struct qcom_snps_hsphy - snps hs phy attributes
>   *
> @@ -91,6 +154,7 @@ struct qcom_snps_hsphy {
>  
>  	bool phy_initialized;
>  	enum phy_mode mode;
> +	struct phy_override_seq update_seq_cfg[ARRAY_SIZE(phy_seq_props)];
>  };
>  
>  static inline void qcom_snps_hsphy_write_mask(void __iomem *base, u32 offset,
> @@ -173,10 +237,147 @@ static int qcom_snps_hsphy_set_mode(struct phy *phy, enum phy_mode mode,
>  	return 0;
>  }
>  
> +static const struct override_param hs_disconnect_sc7280[] = {

Is this mapping unique to sc7280? Will other 7nm implementation of the
Femto phy use different mappings?

> +	OVERRIDE_PARAM(-272, 0),
> +	OVERRIDE_PARAM(0, 1),
> +	OVERRIDE_PARAM(317, 2),
> +	OVERRIDE_PARAM(630, 3),
> +	OVERRIDE_PARAM(973, 4),
> +	OVERRIDE_PARAM(1332, 5),
> +	OVERRIDE_PARAM(1743, 6),
> +	OVERRIDE_PARAM(2156, 7),
> +};
> +
> +static const struct override_param squelch_det_threshold_sc7280[] = {
> +	OVERRIDE_PARAM(-2090, 7),
> +	OVERRIDE_PARAM(-1560, 6),
> +	OVERRIDE_PARAM(-1030, 5),
> +	OVERRIDE_PARAM(-530, 4),
> +	OVERRIDE_PARAM(0, 3),
> +	OVERRIDE_PARAM(530, 2),
> +	OVERRIDE_PARAM(1060, 1),
> +	OVERRIDE_PARAM(1590, 0),
> +};
> +
> +static const struct override_param hs_amplitude_sc7280[] = {
> +	OVERRIDE_PARAM(-660, 0),
> +	OVERRIDE_PARAM(-440, 1),
> +	OVERRIDE_PARAM(-220, 2),
> +	OVERRIDE_PARAM(0, 3),
> +	OVERRIDE_PARAM(230, 4),
> +	OVERRIDE_PARAM(440, 5),
> +	OVERRIDE_PARAM(650, 6),
> +	OVERRIDE_PARAM(890, 7),
> +	OVERRIDE_PARAM(1110, 8),
> +	OVERRIDE_PARAM(1330, 9),
> +	OVERRIDE_PARAM(1560, 10),
> +	OVERRIDE_PARAM(1780, 11),
> +	OVERRIDE_PARAM(2000, 12),
> +	OVERRIDE_PARAM(2220, 13),
> +	OVERRIDE_PARAM(2430, 14),
> +	OVERRIDE_PARAM(2670, 15),
> +};
> +
> +static const struct override_param preemphasis_duration_sc7280[] = {
> +	OVERRIDE_PARAM(10000, 1),
> +	OVERRIDE_PARAM(20000, 0),
> +};
> +
> +static const struct override_param preemphasis_amplitude_sc7280[] = {
> +	OVERRIDE_PARAM(10000, 1),
> +	OVERRIDE_PARAM(20000, 2),
> +	OVERRIDE_PARAM(30000, 3),
> +	OVERRIDE_PARAM(40000, 0),
> +};
> +
> +static const struct override_param hs_rise_fall_time_sc7280[] = {
> +	OVERRIDE_PARAM(-4100, 3),
> +	OVERRIDE_PARAM(0, 2),
> +	OVERRIDE_PARAM(2810, 1),
> +	OVERRIDE_PARAM(5430, 0),
> +};
> +
> +static const struct override_param hs_crossover_voltage_sc7280[] = {
> +	OVERRIDE_PARAM(-31000, 1),
> +	OVERRIDE_PARAM(0, 3),
> +	OVERRIDE_PARAM(28000, 2),
> +};
> +
> +static const struct override_param hs_output_impedance_sc7280[] = {
> +	OVERRIDE_PARAM(-2300000, 3),
> +	OVERRIDE_PARAM(0, 2),
> +	OVERRIDE_PARAM(2600000, 1),
> +	OVERRIDE_PARAM(6100000, 0),
> +};
> +
> +static const struct override_param ls_fs_output_impedance_sc7280[] = {
> +	OVERRIDE_PARAM(-1053, 15),
> +	OVERRIDE_PARAM(-557, 7),
> +	OVERRIDE_PARAM(0, 3),
> +	OVERRIDE_PARAM(612, 1),
> +	OVERRIDE_PARAM(1310, 0),
> +};
> +
> +static const struct override_param_map sc7280_idp[] = {

Why does this say "idp", are you expecting a different table for other
devices on sc7280? As with above, are these tuneables specific to
sc7280, or do they apply to all 7nm implementations of the Femto? What
about other incarnations?

> +	OVERRIDE_PARAM_MAP(
> +			hs_disconnect_sc7280,
> +			ARRAY_SIZE(hs_disconnect_sc7280),
> +			USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X0,
> +			HS_DISCONNECT_MASK),
> +
> +	OVERRIDE_PARAM_MAP(
> +			squelch_det_threshold_sc7280,
> +			ARRAY_SIZE(squelch_det_threshold_sc7280),
> +			USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X0,
> +			SQUELCH_DETECTOR_MASK),
> +
> +	OVERRIDE_PARAM_MAP(
> +			hs_amplitude_sc7280,
> +			ARRAY_SIZE(hs_amplitude_sc7280),
> +			USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X1,
> +			HS_AMPLITUDE_MASK),
> +
> +	OVERRIDE_PARAM_MAP(
> +			preemphasis_duration_sc7280,
> +			ARRAY_SIZE(preemphasis_duration_sc7280),
> +			USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X1,
> +			PREEMPHASIS_DURATION_MASK),
> +
> +	OVERRIDE_PARAM_MAP(
> +			preemphasis_amplitude_sc7280,
> +			ARRAY_SIZE(preemphasis_amplitude_sc7280),
> +			USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X1,
> +			PREEMPHASIS_AMPLITUDE_MASK),
> +
> +	OVERRIDE_PARAM_MAP(
> +			hs_rise_fall_time_sc7280,
> +			ARRAY_SIZE(hs_rise_fall_time_sc7280),
> +			USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X2,
> +			HS_RISE_FALL_MASK),
> +
> +	OVERRIDE_PARAM_MAP(
> +			hs_crossover_voltage_sc7280,
> +			ARRAY_SIZE(hs_crossover_voltage_sc7280),
> +			USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X2,
> +			HS_CROSSOVER_VOLTAGE_MASK),
> +
> +	OVERRIDE_PARAM_MAP(
> +			hs_output_impedance_sc7280,
> +			ARRAY_SIZE(hs_output_impedance_sc7280),
> +			USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X2,
> +			HS_OUTPUT_IMPEDANCE_MASK),
> +
> +	OVERRIDE_PARAM_MAP(
> +			ls_fs_output_impedance_sc7280,
> +			ARRAY_SIZE(ls_fs_output_impedance_sc7280),
> +			USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X3,
> +			LS_FS_OUTPUT_IMPEDANCE_MASK),
> +};
> +
>  static int qcom_snps_hsphy_init(struct phy *phy)
>  {
>  	struct qcom_snps_hsphy *hsphy = phy_get_drvdata(phy);
> -	int ret;
> +	int ret, i;
>  
>  	dev_vdbg(&phy->dev, "%s(): Initializing SNPS HS phy\n", __func__);
>  
> @@ -223,6 +424,14 @@ static int qcom_snps_hsphy_init(struct phy *phy)
>  	qcom_snps_hsphy_write_mask(hsphy->base, USB2_PHY_USB_PHY_HS_PHY_CTRL1,
>  					VBUSVLDEXT0, VBUSVLDEXT0);
>  
> +	for (i = 0; i < ARRAY_SIZE(hsphy->update_seq_cfg); i++) {
> +		if (hsphy->update_seq_cfg[i].need_update)
> +			qcom_snps_hsphy_write_mask(hsphy->base,
> +					hsphy->update_seq_cfg[i].offset,
> +					hsphy->update_seq_cfg[i].mask,
> +					hsphy->update_seq_cfg[i].value);
> +	}
> +
>  	qcom_snps_hsphy_write_mask(hsphy->base,
>  					USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON2,
>  					VREGBYPASS, VREGBYPASS);
> @@ -280,7 +489,10 @@ static const struct phy_ops qcom_snps_hsphy_gen_ops = {
>  static const struct of_device_id qcom_snps_hsphy_of_match_table[] = {
>  	{ .compatible	= "qcom,sm8150-usb-hs-phy", },
>  	{ .compatible	= "qcom,usb-snps-hs-5nm-phy", },
> -	{ .compatible	= "qcom,usb-snps-hs-7nm-phy", },
> +	{
> +		.compatible	= "qcom,usb-snps-hs-7nm-phy",
> +		.data		= &sc7280_idp,
> +	},
>  	{ .compatible	= "qcom,usb-snps-femto-v2-phy",	},
>  	{ }
>  };
> @@ -291,6 +503,49 @@ static const struct dev_pm_ops qcom_snps_hsphy_pm_ops = {
>  			   qcom_snps_hsphy_runtime_resume, NULL)
>  };
>  
> +static void qcom_snps_hsphy_override_param_update_val(
> +			const struct override_param_map map,
> +			s32 dt_val, struct phy_override_seq *seq_entry)
> +{
> +	int i;
> +
> +	/*
> +	 * Param table for each param is in increasing order
> +	 * of dt values. We need to iterate over the list to
> +	 * select the entry that has equal or the next highest value.
> +	 */

When is it useful to have this rounding to the higher value, over just
doing an exact match with the available register values?

> +	for (i = 0; i < map.table_size - 1; i++) {
> +		if (map.param_table[i].value >= dt_val)
> +			break;
> +	}
> +
> +	seq_entry->need_update = true;
> +	seq_entry->offset = map.reg_offset;
> +	seq_entry->mask = map.param_mask;
> +	seq_entry->value =  map.param_table[i].reg << __ffs(map.param_mask);
> +}
> +
> +static void qcom_snps_hsphy_read_override_param_seq(struct device *dev)
> +{
> +	struct device_node *node = dev->of_node;
> +	s32 val;
> +	int ret, i;
> +	struct qcom_snps_hsphy *hsphy;
> +	const struct override_param_map *cfg = of_device_get_match_data(dev);
> +
> +	hsphy = dev_get_drvdata(dev);

You only call this function from qcom_snps_hsphy_probe(), where you have
hsphy already. If you pass that as your argument to the function instead
you don't have to dig it out from the struct device.

> +
> +	for (i = 0; i < ARRAY_SIZE(phy_seq_props); i++) {
> +		ret = of_property_read_s32(node, phy_seq_props[i], &val);
> +		if (!ret) {
> +			dev_dbg(&hsphy->phy->dev, "Read param: %s val: %d\n",
> +				phy_seq_props[i], val);

I think it's fair to assume that the reader of this debug print is
looking at the register documentation and trying to figure out if they
are getting the right values in the registers. So it would probably be a
good idea to include those details in the print.

For that to be useful I think you need to inline
qcom_snps_hsphy_override_param_update_val() here, but that doesn't seem
like a bad idea anyways (and turn the conditional above into if (ret)
continue; to save the indentation level).

Thanks,
Bjorn

> +			qcom_snps_hsphy_override_param_update_val(cfg[i], val,
> +						&hsphy->update_seq_cfg[i]);
> +		}
> +	}
> +}
> +
>  static int qcom_snps_hsphy_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -352,6 +607,7 @@ static int qcom_snps_hsphy_probe(struct platform_device *pdev)
>  
>  	dev_set_drvdata(dev, hsphy);
>  	phy_set_drvdata(generic_phy, hsphy);
> +	qcom_snps_hsphy_read_override_param_seq(dev);
>  
>  	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
>  	if (!IS_ERR(phy_provider))
> -- 
> 2.7.4
> 
