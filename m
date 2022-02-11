Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FE64B22A7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244055AbiBKKBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:01:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbiBKKA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:00:59 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE448133;
        Fri, 11 Feb 2022 02:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644573658; x=1676109658;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=z9a5VslmIX25OnGQp6my8AEprVdaAFHvejS6kfNUFjo=;
  b=Ss79HcUBdL+9o+tuKUA9ABPtSmWmOZ7Z1ID5LrjtJPvIqyTNP6YjqV4f
   TuUvv3FyQfamLa2IXoNDG7ifAvFpjI5prfZb77UaAPa5p0p1lvstAtQUm
   szusMtWjY7Vzp2M2DpwCahDldm9tGUnLvefkG8oGGmMu4Qbvm6g7vZBur
   g=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 11 Feb 2022 02:00:58 -0800
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 02:00:57 -0800
Received: from [10.216.7.73] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Fri, 11 Feb
 2022 02:00:52 -0800
Subject: Re: [PATCH V5 4/6] regulator: Add a regulator driver for the PM8008
 PMIC
To:     Mark Brown <broonie@kernel.org>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Lee Jones <lee.jones@linaro.org>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Das Srinagesh <gurus@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_jprakash@quicinc.com>
References: <1644331940-18986-1-git-send-email-quic_c_skakit@quicinc.com>
 <1644331940-18986-5-git-send-email-quic_c_skakit@quicinc.com>
 <YgPNLq6tdj5/UpZE@sirena.org.uk>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
Message-ID: <66830ee2-5846-8298-3371-359c7d1999db@quicinc.com>
Date:   Fri, 11 Feb 2022 15:30:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YgPNLq6tdj5/UpZE@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/9/2022 7:48 PM, Mark Brown wrote:
> On Tue, Feb 08, 2022 at 08:22:18PM +0530, Satya Priya wrote:
>
>> +static int pm8008_regulator_of_parse(struct device_node *node,
>> +			const struct regulator_desc *desc,
>> +			struct regulator_config *config)
>> +{
>> +	struct pm8008_regulator *pm8008_reg = config->driver_data;
>> +	int rc;
>> +	unsigned int reg;
>> +
>> +	/* get slew rate */
>> +	rc = regmap_bulk_read(pm8008_reg->regmap,
>> +			LDO_STEPPER_CTL_REG(pm8008_reg->base), &reg, 1);
>> +	if (rc < 0) {
>> +		dev_err(pm8008_reg->dev,
>> +			"%s: failed to read step rate configuration rc=%d\n",
>> +			pm8008_reg->rdesc.name, rc);
>> +		return rc;
>> +	}
>> +	reg &= STEP_RATE_MASK;
>> +	pm8008_reg->step_rate = DEFAULT_VOLTAGE_STEPPER_RATE >> reg;
>> +
>> +	return 0;
> This is not doing any parsing of any DT properties at all, it is just
> reading a default value back from the hardware.  This shouldn't be in
> the of_parse() callback, it should be done on probe() or something so
> that if someone adds ACPI support or whatever there's no surprise
> breakage, and so that we've got this configured even if there's no DT
> bindings for the specific regulator.


Okay, I'll move it to probe.


>
>> +}
>> +
>> +static int pm8008_regulator_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	int id = pdev->id % PM8008_NUM_LDOS;
>> +	struct regulator_dev    *rdev;
>> +	struct pm8008_regulator *pm8008_reg;
>> +	struct regmap *regmap;
>> +	struct regulator_config reg_config = {};
>> +	int rc;
>> +
>> +	dev_dbg(dev, "DEBUG: Probing LDO%d\n", id + 1);
>> +
>> +	regmap = dev_get_regmap(dev->parent, NULL);
>> +	if (!regmap) {
>> +		dev_err(dev, "parent regmap is missing\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	pm8008_reg = devm_kzalloc(dev, sizeof(*pm8008_reg), GFP_KERNEL);
>> +	if (!pm8008_reg)
>> +		return -ENOMEM;
>> +
>> +	pm8008_reg->regmap = regmap;
>> +	pm8008_reg->dev = dev;
>> +	pm8008_reg->base = reg_data[id].base;
>> +
>> +	pm8008_reg->rdesc.type = REGULATOR_VOLTAGE;
>> +	pm8008_reg->rdesc.regulators_node = of_match_ptr("regulators");
>> +	pm8008_reg->rdesc.ops = &pm8008_regulator_ops;
>> +	pm8008_reg->rdesc.name = reg_data[id].name;
>> +	pm8008_reg->rdesc.supply_name = reg_data[id].supply_name;
>> +	pm8008_reg->rdesc.of_match = reg_data[id].name;
>> +	pm8008_reg->rdesc.of_parse_cb = pm8008_regulator_of_parse;
>> +	pm8008_reg->rdesc.uV_step = VSET_STEP_UV;
>> +	pm8008_reg->rdesc.min_uV = reg_data[id].min_uv;
>> +	pm8008_reg->rdesc.n_voltages
>> +		= ((reg_data[id].max_uv - reg_data[id].min_uv)
>> +			/ pm8008_reg->rdesc.uV_step) + 1;
>> +	pm8008_reg->rdesc.linear_ranges = reg_data[id].voltage_range;
>> +	pm8008_reg->rdesc.n_linear_ranges = 1;
>> +	pm8008_reg->rdesc.enable_reg = LDO_ENABLE_REG(pm8008_reg->base);
>> +	pm8008_reg->rdesc.enable_mask = ENABLE_BIT;
>> +	pm8008_reg->rdesc.min_dropout_uV = reg_data[id].min_dropout_uv;
>> +
>> +	reg_config.dev = dev->parent;
>> +	reg_config.driver_data = pm8008_reg;
>> +
>> +	rdev = devm_regulator_register(dev, &pm8008_reg->rdesc, &reg_config);
>> +	if (IS_ERR(rdev)) {
>> +		rc = PTR_ERR(rdev);
>> +		dev_err(dev, "%s: failed to register regulator rc=%d\n",
>> +				reg_data[id].name, rc);
>> +		return rc;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver pm8008_regulator_driver = {
>> +	.driver	= {
>> +		.name		= "qcom,pm8008-regulators",
>> +	},
>> +	.probe	= pm8008_regulator_probe,
>> +};
>> +
>> +module_platform_driver(pm8008_regulator_driver);
>> +
>> +MODULE_DESCRIPTION("Qualcomm PM8008 PMIC Regulator Driver");
>> +MODULE_LICENSE("GPL");
>> -- 
>> 2.7.4
>>
