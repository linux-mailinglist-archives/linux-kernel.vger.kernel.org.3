Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8DA5A6E88
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 22:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiH3Uf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 16:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiH3UfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 16:35:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAC826571;
        Tue, 30 Aug 2022 13:35:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC37F61828;
        Tue, 30 Aug 2022 20:35:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0092C433C1;
        Tue, 30 Aug 2022 20:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661891722;
        bh=hDa96mVpnx3sR194oL20383mu7fOW6aoNoLQ7roIQEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GMlUytBB0wIncyuJGzKBTMS5cZ1YPwydTIH/Tus9F0YKnsM5fxOW+Ip193rbKMStM
         uPqr6QbPxYFM47432xvIQ3P1vajZ0ZvypV56UeoEmfDq/67kYbL8wOU1tiU7BbnFPp
         xynT1bV5Bs4MNJ8tYKpxPXjInlv72zUz7ia/czxVyoyqJ0OtWo2rg0KwwrDXGgGJwH
         q1X9I0I0ObAjPbbof9OqVLK+VIDaLeFtuwnKu3+ju16HT8leZmSv8TJKuo7SoBNzIp
         KC78JcfTLCWPVt3O4FCqn1qSTLZeAG0RZ61AmVI3pCkzKoEaW0+hFmaE68i8eFmFj1
         KnDzt5TU5IU5g==
Date:   Tue, 30 Aug 2022 15:35:18 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
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
Subject: Re: [PATCH v11 2/3] phy: qcom-snps: Add support for overriding phy
 tuning parameters
Message-ID: <20220830203518.pty67fyefho4ewgw@builder.lan>
References: <1658384954-9506-1-git-send-email-quic_kriskura@quicinc.com>
 <1658384954-9506-3-git-send-email-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1658384954-9506-3-git-send-email-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 11:59:13AM +0530, Krishna Kurapati wrote:
> Add support for overriding electrical signal tuning parameters for
> SNPS HS Phy.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> Reviewed-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c | 262 +++++++++++++++++++++++++-
>  1 file changed, 260 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
> index 5d20378..24264ad 100644
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

It wasn't immediately obvious to me that reg meant "register value to be
written for the given value specified in DT".

I think if you changed "reg" to "reg_val" it would have been.

> +};
> +
> +#define OVERRIDE_PARAM(bps, val) {	\

TBH, I don't find this macro to add any value. In order to understand
the tables below I need to look at this macro to know that the two
integers passed to the macro are just stuffed into the array - there's
nothing more to it.

As such I would prefer if you simply wrote:

static const struct override_param hs_disconnect_sc7280[] = {
	{ -272, 0 },
	{ 0, 1 },
	{ 317, 2 },
	...
}

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

Here you could have used the preprocessor to fill in table_size (by just
making it ARRAY_SIZE(table)). But as with OVERRIDE_PARAM I would prefer
if you simply do:


static const struct override_param_map sc7280[] = {
	{
		hs_disconnect_sc7280,
		ARRAY_SIZE(hs_disconnect_sc7280),
		USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X0,
		HS_DISCONNECT_MASK),
	},
	{
		squelch_det_threshold_sc7280,
		ARRAY_SIZE(squelch_det_threshold_sc7280),
		USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X0,
		SQUELCH_DETECTOR_MASK),
	},
	...
}

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

The ordering of this list needs to match the order of
override_param_map[] and there's nothing indicating this in the code.

I was considering suggesting that you add a enum/define and do
	[SQUELCH_DETECTOR_BP] = "qcom,squelch-detector-bp",
	... 
and then do the same in the override_param_map array.


But I think it will be cleaner if you add a const char const pointer to
override_param_map and just specify these strings in the
override_param_map array.

Each entry will grow by a pointer, but multiple copies of the same
strings (when added in the future) should be combined by the compiler.

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
> +static const struct override_param_map sc7280[] = {

There's nothing ensuring that the loop below doesn't run off the end of
this array. So when the next platform is added, there's no way to
handle the fact that they might have a different set of properties.

If you add the property name to these elements, that will no longer be a
problem (and you can add a {} entry at the end of the list and check for
this when looping over the elements.

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
> +		.data		= &sc7280,

Perhaps name "qcom_snps_hsphy_7nm_override_map" or something
along those lines instead of "sc7280"?

> +	},
>  	{ .compatible	= "qcom,usb-snps-femto-v2-phy",	},
>  	{ }
>  };
> @@ -291,6 +503,51 @@ static const struct dev_pm_ops qcom_snps_hsphy_pm_ops = {
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
> +	for (i = 0; i < map.table_size - 1; i++) {
> +		if (map.param_table[i].value == dt_val)
> +			break;
> +	}
> +
> +	seq_entry->need_update = true;
> +	seq_entry->offset = map.reg_offset;
> +	seq_entry->mask = map.param_mask;
> +	seq_entry->value =  map.param_table[i].reg << __ffs(map.param_mask);

I would prefer that you include linux/bitfield.h and use:

	u32_encode_bits(map.param_table[i].reg, map.param_mask);

instead of writing this yourself (even if it looks correct).

There's a double space after '='.

Regards,
Bjorn

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
> +
> +	for (i = 0; i < ARRAY_SIZE(phy_seq_props); i++) {
> +		ret = of_property_read_s32(node, phy_seq_props[i], &val);
> +		if (ret)
> +			continue;
> +
> +		qcom_snps_hsphy_override_param_update_val(cfg[i], val,
> +					&hsphy->update_seq_cfg[i]);
> +		dev_dbg(&hsphy->phy->dev, "Read param: %s dt_val: %d reg_val: 0x%x\n",
> +			phy_seq_props[i], val, hsphy->update_seq_cfg[i].value);
> +
> +	}
> +}
> +
>  static int qcom_snps_hsphy_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -352,6 +609,7 @@ static int qcom_snps_hsphy_probe(struct platform_device *pdev)
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
