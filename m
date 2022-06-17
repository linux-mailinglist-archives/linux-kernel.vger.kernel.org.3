Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186E254EE6F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 02:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379354AbiFQA3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 20:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiFQA3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 20:29:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8383A63390;
        Thu, 16 Jun 2022 17:29:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1433961693;
        Fri, 17 Jun 2022 00:29:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54559C34114;
        Fri, 17 Jun 2022 00:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655425790;
        bh=lfh/z9I3czg22DaFZwDPacBvaRMd1JKGZODXCJ7Gfcs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cc4WmsWTKfq7raMx1zsjFb59EpQBvorLhKFn5giQ/f0lCYDwxQ+O+su3azuK73Bqe
         AP2Uk/fhE9JryUekXCpCHfPGnNQAWvpKsIjt4gbSUaoX7nFWPyG+RwErcasLonljVK
         AtUcw5idfUEb5sv7wEaDiCwWh3o3agLSwONVzR0TMlPozwwIj2rb3arluoYN1lXXGu
         pUVj48hIklhFNESGziLft2w6vhZgkUMKiUIBvfDz05HFr3NYqzEJeZf+dCV3kxv7Bu
         BC5hLItBX8LEGfAsq60FmAbN6zHeScnCOjDPFkSSnzGkMJRGHsNeBjd5jELA0gcWgT
         JJdonZQM4DPog==
Date:   Thu, 16 Jun 2022 17:29:49 -0700
From:   Vinod Koul <vkoul@kernel.org>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com
Subject: Re: [PATCH v8 2/3] phy: qcom-snps: Add support for overriding phy
 tuning parameters
Message-ID: <YqvK/SirF2gRsh3o@matsya>
References: <1654066564-20518-1-git-send-email-quic_kriskura@quicinc.com>
 <1654066564-20518-3-git-send-email-quic_kriskura@quicinc.com>
 <YqDIdAnMA9A4taWR@matsya>
 <295d0748-d817-2afa-19d2-5e802ad7fec0@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <295d0748-d817-2afa-19d2-5e802ad7fec0@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-06-22, 23:04, Krishna Kurapati PSSNV wrote:
> 
> On 6/8/2022 9:34 PM, Vinod Koul wrote:
> > On 01-06-22, 12:26, Krishna Kurapati wrote:
> > > Add support for overriding electrical signal tuning parameters for
> > > SNPS HS Phy.
> > > 
> > > Signed-off-by: Krishna Kurapati<quic_kriskura@quicinc.com>
> > > Reviewed-by: Pavankumar Kondeti<quic_pkondeti@quicinc.com>
> > > ---
> > >   drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c | 267 +++++++++++++++++++++++++-
> > >   1 file changed, 265 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
> > > index 5d20378..14bbb06 100644
> > > --- a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
> > > +++ b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
> > > @@ -52,6 +52,12 @@
> > >   #define USB2_SUSPEND_N				BIT(2)
> > >   #define USB2_SUSPEND_N_SEL			BIT(3)
> > > +#define USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X0		(0x6c)
> > > +#define USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X1		(0x70)
> > > +#define USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X2		(0x74)
> > > +#define USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X3		(0x78)
> > > +#define PARAM_OVRD_MASK				0xFF
> > > +
> > >   #define USB2_PHY_USB_PHY_CFG0			(0x94)
> > >   #define UTMI_PHY_DATAPATH_CTRL_OVERRIDE_EN	BIT(0)
> > >   #define UTMI_PHY_CMN_CTRL_OVERRIDE_EN		BIT(1)
> > > @@ -60,12 +66,76 @@
> > >   #define REFCLK_SEL_MASK				GENMASK(1, 0)
> > >   #define REFCLK_SEL_DEFAULT			(0x2 << 0)
> > > +#define HS_DISCONNECT_MASK			GENMASK(2, 0)
> > > +
> > > +#define SQUELCH_DETECTOR_MASK			GENMASK(7, 5)
> > > +
> > > +#define HS_AMPLITUDE_MASK			GENMASK(3, 0)
> > > +
> > > +#define PREEMPHASIS_DURATION_MASK		BIT(5)
> > > +
> > > +#define PREEMPHASIS_AMPLITUDE_MASK		GENMASK(7, 6)
> > I guess this is a register, pls remove blank lines between them, serves
> > no purpose
> > 
> > > +
> > > +#define HS_RISE_FALL_MASK			GENMASK(1, 0)
> > > +
> > > +#define HS_CROSSOVER_VOLTAGE_MASK		GENMASK(3, 2)
> > > +
> > > +#define HS_OUTPUT_IMPEDANCE_MASK		GENMASK(5, 4)
> > > +
> > > +#define LS_FS_OUTPUT_IMPEDANCE_MASK		GENMASK(3, 0)
> > here two..
> > 
> > > +
> > > +
> > One line suffices here (checkpatch with --strict would have warned you)
> > 
> > 
> > >   static const char * const qcom_snps_hsphy_vreg_names[] = {
> > >   	"vdda-pll", "vdda33", "vdda18",
> > >   };
> > >   #define SNPS_HS_NUM_VREGS		ARRAY_SIZE(qcom_snps_hsphy_vreg_names)
> > > +struct override_param {
> > > +	s32	value;
> > > +	u8	reg;
> > > +};
> > > +
> > > +#define OVERRIDE_PARAM(bps, val)\
> > > +{				\
> > this should be in preceding line
> > 
> > > +	.value = bps,		\
> > > +	.reg = val,		\
> > > +}
> > > +
> > > +struct override_param_map {
> > > +	struct override_param *param_table;
> > > +	u8 table_size;
> > > +	u8 reg_offset;
> > > +	u8 param_mask;
> > > +};
> > > +
> > > +#define OVERRIDE_PARAM_MAP(table, num_elements, offset, mask)		\
> > > +{									\
> > > +	.param_table = table,						\
> > > +	.table_size = num_elements,					\
> > > +	.reg_offset = offset,						\
> > > +	.param_mask = mask,						\
> > > +}
> > 
> > > +
> > > +struct phy_override_seq {
> > > +	bool	need_update;
> > > +	u8	offset;
> > > +	u8	value;
> > > +	u8	mask;
> > > +};
> > > +
> > > +static const char *phy_seq_props[] = {
> > > +	"qcom,hs-disconnect-bp",
> > > +	"qcom,squelch-detector-bp",
> > > +	"qcom,hs-amplitude-bp",
> > > +	"qcom,pre-emphasis-duration-bp",
> > > +	"qcom,pre-emphasis-amplitude-bp",
> > > +	"qcom,hs-rise-fall-time-bp",
> > > +	"qcom,hs-crossover-voltage-microvolt",
> > > +	"qcom,hs-output-impedance-micro-ohms",
> > > +	"qcom,ls-fs-output-impedance-bp",
> > > +};
> > > +
> > >   /**
> > >    * struct qcom_snps_hsphy - snps hs phy attributes
> > >    *
> > > @@ -91,6 +161,7 @@ struct qcom_snps_hsphy {
> > >   	bool phy_initialized;
> > >   	enum phy_mode mode;
> > > +	struct phy_override_seq update_seq_cfg[ARRAY_SIZE(phy_seq_props)];
> > >   };
> > >   static inline void qcom_snps_hsphy_write_mask(void __iomem *base, u32 offset,
> > > @@ -173,10 +244,147 @@ static int qcom_snps_hsphy_set_mode(struct phy *phy, enum phy_mode mode,
> > >   	return 0;
> > >   }
> > > +static struct override_param hs_disconnect_sc7280[] = {
> > > +	OVERRIDE_PARAM(-272, 0),
> > > +	OVERRIDE_PARAM(0, 1),
> > > +	OVERRIDE_PARAM(317, 2),
> > > +	OVERRIDE_PARAM(630, 3),
> > > +	OVERRIDE_PARAM(973, 4),
> > > +	OVERRIDE_PARAM(1332, 5),
> > > +	OVERRIDE_PARAM(1743, 6),
> > > +	OVERRIDE_PARAM(2156, 7),
> > > +};
> > use constants for registers please
> > 
> > > +
> > > +static struct override_param squelch_det_threshold_sc7280[] = {
> > > +	OVERRIDE_PARAM(-2090, 7),
> > > +	OVERRIDE_PARAM(-1560, 6),
> > > +	OVERRIDE_PARAM(-1030, 5),
> > > +	OVERRIDE_PARAM(-530, 4),
> > > +	OVERRIDE_PARAM(0, 3),
> > > +	OVERRIDE_PARAM(530, 2),
> > > +	OVERRIDE_PARAM(1060, 1),
> > > +	OVERRIDE_PARAM(1590, 0),
> > > +};
> > > +
> > > +static struct override_param hs_amplitude_sc7280[] = {
> > > +	OVERRIDE_PARAM(-660, 0),
> > > +	OVERRIDE_PARAM(-440, 1),
> > > +	OVERRIDE_PARAM(-220, 2),
> > > +	OVERRIDE_PARAM(0, 3),
> > > +	OVERRIDE_PARAM(230, 4),
> > > +	OVERRIDE_PARAM(440, 5),
> > > +	OVERRIDE_PARAM(650, 6),
> > > +	OVERRIDE_PARAM(890, 7),
> > > +	OVERRIDE_PARAM(1110, 8),
> > > +	OVERRIDE_PARAM(1330, 9),
> > > +	OVERRIDE_PARAM(1560, 10),
> > > +	OVERRIDE_PARAM(1780, 11),
> > > +	OVERRIDE_PARAM(2000, 12),
> > > +	OVERRIDE_PARAM(2220, 13),
> > > +	OVERRIDE_PARAM(2430, 14),
> > > +	OVERRIDE_PARAM(2670, 15),
> > > +};
> > > +
> > > +static struct override_param preemphasis_duration_sc7280[] = {
> > > +	OVERRIDE_PARAM(10000, 1),
> > > +	OVERRIDE_PARAM(20000, 0),
> > > +};
> > > +
> > > +static struct override_param preemphasis_amplitude_sc7280[] = {
> > > +	OVERRIDE_PARAM(10000, 1),
> > > +	OVERRIDE_PARAM(20000, 2),
> > > +	OVERRIDE_PARAM(30000, 3),
> > > +	OVERRIDE_PARAM(40000, 0),
> > > +};
> > > +
> > > +static struct override_param hs_rise_fall_time_sc7280[] = {
> > > +	OVERRIDE_PARAM(-4100, 3),
> > > +	OVERRIDE_PARAM(0, 2),
> > > +	OVERRIDE_PARAM(2810, 1),
> > > +	OVERRIDE_PARAM(5430, 0),
> > > +};
> > > +
> > > +static struct override_param hs_crossover_voltage_sc7280[] = {
> > > +	OVERRIDE_PARAM(-31000, 1),
> > > +	OVERRIDE_PARAM(0, 3),
> > > +	OVERRIDE_PARAM(28000, 2),
> > > +};
> > > +
> > > +static struct override_param hs_output_impedance_sc7280[] = {
> > > +	OVERRIDE_PARAM(-2300000, 3),
> > > +	OVERRIDE_PARAM(0, 2),
> > > +	OVERRIDE_PARAM(2600000, 1),
> > > +	OVERRIDE_PARAM(6100000, 0),
> > > +};
> > > +
> > > +static struct override_param ls_fs_output_impedance_sc7280[] = {
> > > +	OVERRIDE_PARAM(-1053, 15),
> > > +	OVERRIDE_PARAM(-557, 7),
> > > +	OVERRIDE_PARAM(0, 3),
> > > +	OVERRIDE_PARAM(612, 1),
> > > +	OVERRIDE_PARAM(1310, 0),
> > > +};
> > > +
> > > +struct override_param_map sc7280_idp[] = {
> > > +	OVERRIDE_PARAM_MAP(
> > > +			hs_disconnect_sc7280,
> > > +			ARRAY_SIZE(hs_disconnect_sc7280),
> > > +			USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X0,
> > > +			HS_DISCONNECT_MASK),
> > > +
> > > +	OVERRIDE_PARAM_MAP(
> > > +			squelch_det_threshold_sc7280,
> > > +			ARRAY_SIZE(squelch_det_threshold_sc7280),
> > > +			USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X0,
> > > +			SQUELCH_DETECTOR_MASK),
> > > +
> > > +	OVERRIDE_PARAM_MAP(
> > > +			hs_amplitude_sc7280,
> > > +			ARRAY_SIZE(hs_amplitude_sc7280),
> > > +			USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X1,
> > > +			HS_AMPLITUDE_MASK),
> > > +
> > > +	OVERRIDE_PARAM_MAP(
> > > +			preemphasis_duration_sc7280,
> > > +			ARRAY_SIZE(preemphasis_duration_sc7280),
> > > +			USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X1,
> > > +			PREEMPHASIS_DURATION_MASK),
> > > +
> > > +	OVERRIDE_PARAM_MAP(
> > > +			preemphasis_amplitude_sc7280,
> > > +			ARRAY_SIZE(preemphasis_amplitude_sc7280),
> > > +			USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X1,
> > > +			PREEMPHASIS_AMPLITUDE_MASK),
> > > +
> > > +	OVERRIDE_PARAM_MAP(
> > > +			hs_rise_fall_time_sc7280,
> > > +			ARRAY_SIZE(hs_rise_fall_time_sc7280),
> > > +			USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X2,
> > > +			HS_RISE_FALL_MASK),
> > > +
> > > +	OVERRIDE_PARAM_MAP(
> > > +			hs_crossover_voltage_sc7280,
> > > +			ARRAY_SIZE(hs_crossover_voltage_sc7280),
> > > +			USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X2,
> > > +			HS_CROSSOVER_VOLTAGE_MASK),
> > > +
> > > +	OVERRIDE_PARAM_MAP(
> > > +			hs_output_impedance_sc7280,
> > > +			ARRAY_SIZE(hs_output_impedance_sc7280),
> > > +			USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X2,
> > > +			HS_OUTPUT_IMPEDANCE_MASK),
> > > +
> > > +	OVERRIDE_PARAM_MAP(
> > > +			ls_fs_output_impedance_sc7280,
> > > +			ARRAY_SIZE(ls_fs_output_impedance_sc7280),
> > > +			USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X3,
> > > +			LS_FS_OUTPUT_IMPEDANCE_MASK),
> > > +};
> > > +
> > >   static int qcom_snps_hsphy_init(struct phy *phy)
> > >   {
> > >   	struct qcom_snps_hsphy *hsphy = phy_get_drvdata(phy);
> > > -	int ret;
> > > +	int ret, i;
> > >   	dev_vdbg(&phy->dev, "%s(): Initializing SNPS HS phy\n", __func__);
> > > @@ -223,6 +431,14 @@ static int qcom_snps_hsphy_init(struct phy *phy)
> > >   	qcom_snps_hsphy_write_mask(hsphy->base, USB2_PHY_USB_PHY_HS_PHY_CTRL1,
> > >   					VBUSVLDEXT0, VBUSVLDEXT0);
> > > +	for (i = 0; i < ARRAY_SIZE(hsphy->update_seq_cfg); i++) {
> > > +		if (hsphy->update_seq_cfg[i].need_update)
> > > +			qcom_snps_hsphy_write_mask(hsphy->base,
> > > +					hsphy->update_seq_cfg[i].offset,
> > > +					hsphy->update_seq_cfg[i].mask,
> > > +					hsphy->update_seq_cfg[i].value);
> > > +	}
> > > +
> > >   	qcom_snps_hsphy_write_mask(hsphy->base,
> > >   					USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON2,
> > >   					VREGBYPASS, VREGBYPASS);
> > > @@ -280,7 +496,10 @@ static const struct phy_ops qcom_snps_hsphy_gen_ops = {
> > >   static const struct of_device_id qcom_snps_hsphy_of_match_table[] = {
> > >   	{ .compatible	= "qcom,sm8150-usb-hs-phy", },
> > >   	{ .compatible	= "qcom,usb-snps-hs-5nm-phy", },
> > > -	{ .compatible	= "qcom,usb-snps-hs-7nm-phy", },
> > > +	{
> > > +		.compatible	= "qcom,usb-snps-hs-7nm-phy",
> > > +		.data		= &sc7280_idp,
> > > +	},
> > >   	{ .compatible	= "qcom,usb-snps-femto-v2-phy",	},
> > >   	{ }
> > >   };
> > > @@ -291,6 +510,49 @@ static const struct dev_pm_ops qcom_snps_hsphy_pm_ops = {
> > >   			   qcom_snps_hsphy_runtime_resume, NULL)
> > >   };
> > > +static void qcom_snps_hsphy_override_param_update_val(
> > > +			const struct override_param_map map,
> > > +			s32 dt_val, struct phy_override_seq *seq_entry)
> > > +{
> > > +	int i;
> > > +
> > > +	/*
> > > +	 * Param table for each param is in increasing order
> > > +	 * of dt values. We need to iterate over the list to
> > > +	 * select the entry that has equal or the next highest value.
> > > +	 */
> > > +	for (i = 0; i < map.table_size - 1; i++) {
> > > +		if (map.param_table[i].value >= dt_val)
> > > +			break;
> > > +	}
> > > +
> > > +	seq_entry->need_update = true;
> > > +	seq_entry->offset = map.reg_offset;
> > > +	seq_entry->mask = map.param_mask;
> > > +	seq_entry->value =  map.param_table[i].reg << __ffs(map.param_mask);
> > okay am nor sure I get the idea, if we have values in DT why do we need
> > these table in driver or vice-versa?
> > 
> Hi Vinod,
> 
> The idea is as follows. There are 4 registers (X0-X3) that control the phy
> tuning parameters mentioned in bindings and dt. The bitmasks mentioned above
> indicate the bitmask in these registers to be updated for tuning a
> particular parameter.

Okay why not define registers and the masks then and use the properties
in DT to calculate and program these registers...

> 
> sc7280_idp[]� -> This table contains info regarding each parameter namely
> -> which register to be modified if we need to tune that parameter
> -> What is the bitmask in the register to be modified in that particular
> register

Bit mask for registers should be defined using BIT/GENMASK macros...

-- 
~Vinod
