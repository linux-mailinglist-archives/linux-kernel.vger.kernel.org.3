Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959254FF43A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbiDMJ4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234769AbiDMJ4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:56:15 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA01C55754;
        Wed, 13 Apr 2022 02:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649843634; x=1681379634;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uX5uibSkiPcv8Dv2GCvKW+JAmmzsyrKLIVW1cf+8rmc=;
  b=J8PPP+Hd7B5fuS5DgfGqB+Hae55TRCpMPOqKuRJeeoUK1cFPLRxn/qDB
   I/MUxMCMibNt+6rxLURpbNQqgGPjpWLX0364dLuL3DPUAagWfWU41ImPz
   QbBwdhyXFqc2c25aCOnmxlWCjhnjXvup9bfHdFOzkHrA2yqftY/H4l+e1
   k=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 13 Apr 2022 02:53:54 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 02:53:53 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 13 Apr 2022 02:53:52 -0700
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 13 Apr 2022 02:53:46 -0700
Date:   Wed, 13 Apr 2022 15:23:42 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Wesley Cheng <wcheng@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@canonical.com>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_kriskura@quicinc.com>
Subject: Re: [PATCH v2 2/3] phy: qcom-snps: Add support for overriding phy
 tuning parameters
Message-ID: <20220413095342.GE2627@hu-pkondeti-hyd.qualcomm.com>
References: <1646288011-32242-1-git-send-email-quic_c_sanm@quicinc.com>
 <1646288011-32242-3-git-send-email-quic_c_sanm@quicinc.com>
 <Ylaa8THv24KEEcJ4@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Ylaa8THv24KEEcJ4@matsya>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On Wed, Apr 13, 2022 at 03:12:09PM +0530, Vinod Koul wrote:
> On 03-03-22, 11:43, Sandeep Maheswaram wrote:
> > Added support for overriding x0,x1,x2,x3 params for SNPS PHY by reading
> > values from device tree.
> > 
> > Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> > ---
> >  drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c | 192 ++++++++++++++++++++++++++
> >  1 file changed, 192 insertions(+)
> > 
> > diff --git a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
> > index 7e61202..b5aa06d 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
> > @@ -51,6 +51,48 @@
> >  #define USB2_SUSPEND_N				BIT(2)
> >  #define USB2_SUSPEND_N_SEL			BIT(3)
> >  
> > +#define USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X0	(0x6c)
> > +
> > +/*USB_PHY_HS_PHY_OVERRIDE_X0 register bits*/
> 
> space after /* and before */ (checkpatch.pl --strict would warn you)
> Pls fix it everywhere
> 
> > +#define HS_DISCONNECT_MASK			GENMASK(2, 0)
> > +#define HS_DISCONNECT_SHIFT			0x0
> > +
> > +#define SQUELCH_DETECTOR_MASK			GENMASK(7, 5)
> > +#define SQUELCH_DETECTOR_SHIFT			0x5
> > +
> > +
> > +#define USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X1	(0x70)
> > +
> > +/*USB_PHY_HS_PHY_OVERRIDE_X1 register bits*/
> > +#define HS_AMPLITUDE_MASK			GENMASK(3, 0)
> > +#define HS_AMPLITUDE_SHIFT			0x0
> > +
> > +#define PREEMPHASIS_DURATION_MASK		BIT(5)
> > +#define PREEMPHASIS_DURATION_SHIFT		0x5
> > +
> > +#define PREEMPHASIS_AMPLITUDE_MASK		GENMASK(7, 6)
> > +#define PREEMPHASIS_AMPLITUDE_SHIFT		0x6
> > +
> > +
> > +#define USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X2	(0x74)
> > +
> > +/*USB_PHY_HS_PHY_OVERRIDE_X2 register bits*/
> > +#define HS_RISE_FALL_MASK			GENMASK(1, 0)
> > +#define HS_RISE_FALL_SHIFT			0x0
> > +
> > +#define HS_CROSSOVER_VOLTAGE_MASK		GENMASK(3, 2)
> > +#define HS_CROSSOVER_VOLTAGE_SHIFT		0x2
> > +
> > +#define HS_OUTPUT_IMPEDANCE_MASK		GENMASK(5, 4)
> > +#define HS_OUTPUT_IMPEDANCE_SHIFT		0x4
> > +
> > +
> > +#define USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X3	(0x78)
> > +
> > +/*USB_PHY_HS_PHY_OVERRIDE_X3 register bits*/
> > +#define LS_FS_OUTPUT_IMPEDANCE_MASK		GENMASK(3, 0)
> > +#define LS_FS_OUTPUT_IMPEDANCE_SHIFT		0x0
> > +
> >  #define USB2_PHY_USB_PHY_CFG0			(0x94)
> >  #define UTMI_PHY_DATAPATH_CTRL_OVERRIDE_EN	BIT(0)
> >  #define UTMI_PHY_CMN_CTRL_OVERRIDE_EN		BIT(1)
> > @@ -65,6 +107,43 @@ static const char * const qcom_snps_hsphy_vreg_names[] = {
> >  
> >  #define SNPS_HS_NUM_VREGS		ARRAY_SIZE(qcom_snps_hsphy_vreg_names)
> >  
> > +/* struct override_param - structure holding snps phy overriding param
> > + * set override true if the  device tree property exists and read and assign
> > + * to value
> > + */
> > +struct override_param {
> > +	bool override;
> > +	u8 value;
> > +};
> > +
> > +/*struct override_params - structure holding snps phy overriding params
> > + * @hs_disconnect: disconnect threshold
> > + * @squelch_detector: threshold to detect valid high-speed data
> > + * @hs_amplitude: high-speed DC level voltage
> > + * @preemphasis_duration: duration for which the HS pre-emphasis current
> > + *  is sourced onto DP<#> or DM<#>
> > + * @preemphasis_amplitude: current sourced to DP<#> and DM<#> after
> > + *  a J-to-K or K-to-J transition.
> > + * @hs_rise_fall_time: rise/fall times of the high-speed waveform
> > + * @hs_crossover_voltage: voltage at which the DP<#> and DM<#>
> > + *  signals cross while transmitting in HS mode
> > + * @hs_output_impedance: driver source impedance to compensate for added series
> > + *  resistance on the USB
> > + * @ls_fs_output_impedance: low and full-speed single-ended source
> > + *  impedance while driving high
> > + */
> > +struct override_params {
> > +	struct override_param hs_disconnect;
> > +	struct override_param squelch_detector;
> > +	struct override_param hs_amplitude;
> > +	struct override_param preemphasis_duration;
> > +	struct override_param preemphasis_amplitude;
> > +	struct override_param hs_rise_fall_time;
> > +	struct override_param hs_crossover_voltage;
> > +	struct override_param hs_output_impedance;
> > +	struct override_param ls_fs_output_impedance;
> > +};
> > +
> >  /**
> >   * struct qcom_snps_hsphy - snps hs phy attributes
> >   *
> > @@ -87,6 +166,7 @@ struct qcom_snps_hsphy {
> >  	struct clk *ref_clk;
> >  	struct reset_control *phy_reset;
> >  	struct regulator_bulk_data vregs[SNPS_HS_NUM_VREGS];
> > +	struct override_params overrides;
> >  
> >  	bool phy_initialized;
> >  	enum phy_mode mode;
> > @@ -175,6 +255,7 @@ static int qcom_snps_hsphy_set_mode(struct phy *phy, enum phy_mode mode,
> >  static int qcom_snps_hsphy_init(struct phy *phy)
> >  {
> >  	struct qcom_snps_hsphy *hsphy = phy_get_drvdata(phy);
> > +	struct override_params *or = &hsphy->overrides;
> >  	int ret;
> >  
> >  	dev_vdbg(&phy->dev, "%s(): Initializing SNPS HS phy\n", __func__);
> > @@ -222,6 +303,60 @@ static int qcom_snps_hsphy_init(struct phy *phy)
> >  	qcom_snps_hsphy_write_mask(hsphy->base, USB2_PHY_USB_PHY_HS_PHY_CTRL1,
> >  					VBUSVLDEXT0, VBUSVLDEXT0);
> >  
> > +	if (or->hs_disconnect.override)
> > +		qcom_snps_hsphy_write_mask(hsphy->base,
> > +			USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X0,
> > +			HS_DISCONNECT_MASK,
> > +			or->hs_disconnect.value << HS_DISCONNECT_SHIFT);
> > +
> > +	if (or->squelch_detector.override)
> > +		qcom_snps_hsphy_write_mask(hsphy->base,
> > +			USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X0,
> > +			SQUELCH_DETECTOR_MASK,
> > +			or->squelch_detector.value << SQUELCH_DETECTOR_SHIFT);
> > +
> > +	if (or->hs_amplitude.override)
> > +		qcom_snps_hsphy_write_mask(hsphy->base,
> > +			USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X1,
> > +			HS_AMPLITUDE_MASK,
> > +			or->hs_amplitude.value << HS_AMPLITUDE_SHIFT);
> > +
> > +	if (or->preemphasis_duration.override)
> > +		qcom_snps_hsphy_write_mask(hsphy->base,
> > +			USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X1,
> > +			PREEMPHASIS_DURATION_MASK,
> > +			or->preemphasis_duration.value << PREEMPHASIS_DURATION_SHIFT);
> > +
> > +	if (or->preemphasis_amplitude.override)
> > +		qcom_snps_hsphy_write_mask(hsphy->base,
> > +			USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X1,
> > +			PREEMPHASIS_AMPLITUDE_MASK,
> > +			or->preemphasis_amplitude.value << PREEMPHASIS_AMPLITUDE_SHIFT);
> > +
> > +	if (or->hs_rise_fall_time.override)
> > +		qcom_snps_hsphy_write_mask(hsphy->base,
> > +			USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X2,
> > +			HS_RISE_FALL_MASK,
> > +			or->hs_rise_fall_time.value << HS_RISE_FALL_SHIFT);
> > +
> > +	if (or->hs_crossover_voltage.override)
> > +		qcom_snps_hsphy_write_mask(hsphy->base,
> > +			USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X2,
> > +			HS_CROSSOVER_VOLTAGE_MASK,
> > +			or->hs_crossover_voltage.value << HS_CROSSOVER_VOLTAGE_SHIFT);
> > +
> > +	if (or->hs_output_impedance.override)
> > +		qcom_snps_hsphy_write_mask(hsphy->base,
> > +			USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X2,
> > +			HS_OUTPUT_IMPEDANCE_MASK,
> > +			or->hs_output_impedance.value << HS_OUTPUT_IMPEDANCE_SHIFT);
> > +
> > +	if (or->ls_fs_output_impedance.override)
> > +		qcom_snps_hsphy_write_mask(hsphy->base,
> > +			USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X3,
> > +			LS_FS_OUTPUT_IMPEDANCE_MASK,
> > +			or->ls_fs_output_impedance.value << LS_FS_OUTPUT_IMPEDANCE_SHIFT);
> > +
> >  	qcom_snps_hsphy_write_mask(hsphy->base,
> >  					USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON2,
> >  					VREGBYPASS, VREGBYPASS);
> > @@ -292,12 +427,15 @@ static int qcom_snps_hsphy_probe(struct platform_device *pdev)
> >  	struct qcom_snps_hsphy *hsphy;
> >  	struct phy_provider *phy_provider;
> >  	struct phy *generic_phy;
> > +	struct override_params *or;
> >  	int ret, i;
> >  	int num;
> > +	u32 value;
> >  
> >  	hsphy = devm_kzalloc(dev, sizeof(*hsphy), GFP_KERNEL);
> >  	if (!hsphy)
> >  		return -ENOMEM;
> > +	or = &hsphy->overrides;
> >  
> >  	hsphy->base = devm_platform_ioremap_resource(pdev, 0);
> >  	if (IS_ERR(hsphy->base))
> > @@ -329,6 +467,60 @@ static int qcom_snps_hsphy_probe(struct platform_device *pdev)
> >  		return ret;
> >  	}
> >  
> > +	if (!of_property_read_u32(dev->of_node, "qcom,hs-disconnect",
> > +				  &value)) {
> > +		or->hs_disconnect.value = (u8)value;
> > +		or->hs_disconnect.override = true;
> > +	}
> > +
> > +	if (!of_property_read_u32(dev->of_node, "qcom,squelch-detector",
> > +				  &value)) {
> > +		or->squelch_detector.value = (u8)value;
> > +		or->squelch_detector.override = true;
> > +	}
> > +
> > +	if (!of_property_read_u32(dev->of_node, "qcom,hs-amplitude",
> > +				  &value)) {
> > +		or->hs_amplitude.value = (u8)value;
> > +		or->hs_amplitude.override = true;
> > +	}
> > +
> > +	if (!of_property_read_u32(dev->of_node, "qcom,preemphasis-duration",
> > +				  &value)) {
> > +		or->preemphasis_duration.value = (u8)value;
> > +		or->preemphasis_duration.override = true;
> > +	}
> > +
> > +	if (!of_property_read_u32(dev->of_node, "qcom,preemphasis-amplitude",
> > +				  &value)) {
> > +		or->preemphasis_amplitude.value = (u8)value;
> > +		or->preemphasis_amplitude.override = true;
> > +	}
> > +
> > +	if (!of_property_read_u32(dev->of_node, "qcom,hs-rise-fall-time",
> > +				  &value)) {
> > +		or->hs_rise_fall_time.value = (u8)value;
> > +		or->hs_rise_fall_time.override = true;
> > +	}
> > +
> > +	if (!of_property_read_u32(dev->of_node, "qcom,hs-crossover-voltage",
> > +				  &value)) {
> > +		or->hs_crossover_voltage.value = (u8)value;
> > +		or->hs_crossover_voltage.override = true;
> > +	}
> > +
> > +	if (!of_property_read_u32(dev->of_node, "qcom,hs-output-impedance",
> > +				  &value)) {
> > +		or->hs_output_impedance.value = (u8)value;
> > +		or->hs_output_impedance.override = true;
> > +	}
> > +
> > +	if (!of_property_read_u32(dev->of_node, "qcom,ls-fs-output-impedance",
> > +				  &value)) {
> > +		or->ls_fs_output_impedance.value = (u8)value;
> > +		or->ls_fs_output_impedance.override = true;
> > +	}
> 
> Are all these values board specific or IP specific? Can we add these
> values as tables in driver? 

These are IP specific. The tuning is board specific. The plan is to add
tables in the driver which lookup the values passed by device tree and
program the override registers according. We are currently working on
this.

previous discussion:
https://lore.kernel.org/linux-usb/1a43277a-94b9-4f95-314a-876291227982@canonical.com/

Thanks,
Pavan
> -- 
> ~Vinod
