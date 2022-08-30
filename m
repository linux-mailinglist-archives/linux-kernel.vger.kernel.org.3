Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCB05A6758
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 17:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbiH3PZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 11:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiH3PZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 11:25:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0992427CEC;
        Tue, 30 Aug 2022 08:25:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C277C615E2;
        Tue, 30 Aug 2022 15:25:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13DB8C433C1;
        Tue, 30 Aug 2022 15:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661873106;
        bh=wqq8ccHiaVcGJrHvcHsUjlz7+Yg37w0KNDO1IuJO2Y0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VQ7am+eQ3qlfElEH1csUPhlwYbV3o6m5l+VfqmgZIKEbxhg/RkI02uk5HmExF2Z90
         vDxpOApwi4ktzIY96428dv/QlSfIeOz11Gov7N4zjuPXLHsy7QNjvHAg3qXWd4Buxo
         ZbQsJkf7bekoLj6TohWIBveyK54wbNOVLlPNzmomnmoOe8y1x4acTGZPIIyDj36ktx
         BE90EayGF6J6cqBUEu77UBATFpIj9DwpLCkPdw0jWBo8xZdesJBubGBj0L3BzkbIiL
         Qk+/WWKUtCVEaV9+V6Z09sR1VaVM6tvq9TwbB5vpEDaILUccI0WBqQbkTpE03arQ9h
         SQ6G5gnrK8uiA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oT36t-0003LI-E6; Tue, 30 Aug 2022 17:25:03 +0200
Date:   Tue, 30 Aug 2022 17:25:03 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Sebastian Reichel <sre@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 4/4] power: supply: Introduce Qualcomm PMIC GLINK power
 supply
Message-ID: <Yw4rzyTDaoLFXQOx@hovoldconsulting.com>
References: <20220818031512.319310-1-bjorn.andersson@linaro.org>
 <20220818031512.319310-5-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818031512.319310-5-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 08:15:12PM -0700, Bjorn Andersson wrote:
> The PMIC GLINK service, running on a coprocessor of modern Qualcomm
> platforms, deals with battery charging and fuel gauging, as well as
> reporting status of AC and wireless power supplies.
> 
> As this is just one of the functionalities provided by the PMIC GLINK
> service, this power supply driver is implemented as an auxilirary bus
> driver, spawned by the main "pmic glink" driver when the PMIC GLINK
> service is detected.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

> +static int qcom_battmgr_request(struct qcom_battmgr *battmgr, void *data, size_t len)
> +{
> +	unsigned long left;
> +	int ret;
> +
> +	reinit_completion(&battmgr->ack);
> +
> +	battmgr->error = 0;
> +
> +	ret = pmic_glink_send(battmgr->client, data, len);
> +	if (ret < 0)
> +		return ret;
> +
> +	left = wait_for_completion_timeout(&battmgr->ack, HZ);
> +	if (!left)
> +		return -ETIMEDOUT;
> +
> +	return battmgr->error;
> +}

> +static void qcom_battmgr_notification(struct qcom_battmgr *battmgr,
> +				      const struct qcom_battmgr_message *msg,
> +				      int len)
> +{
> +	size_t payload_len = len - sizeof(struct pmic_glink_hdr);
> +	unsigned int notification;
> +
> +	if (payload_len != sizeof(msg->notification)) {
> +		dev_warn(battmgr->dev, "ignoring notification with invalid length\n");
> +		return;
> +	}
> +
> +	notification = le32_to_cpu(msg->notification);
> +	switch (notification) {
> +	case NOTIF_BAT_INFO:
> +		battmgr->info.valid = false;
> +		fallthrough;
> +	case NOTIF_BAT_PROPERTY:
> +		power_supply_changed(battmgr->bat_psy);
> +		break;
> +	case NOTIF_USB_PROPERTY:
> +		power_supply_changed(battmgr->usb_psy);
> +		break;
> +	case NOTIF_WLS_PROPERTY:
> +		power_supply_changed(battmgr->wls_psy);
> +		break;
> +	default:
> +		dev_err(battmgr->dev, "unknown notification: %#x\n", notification);
> +		break;
> +	}
> +}

> +static void qcom_battmgr_callback(const void *data, size_t len, void *priv)
> +{
> +	const struct pmic_glink_hdr *hdr = data;
> +	struct qcom_battmgr *battmgr = priv;
> +	unsigned int opcode = le32_to_cpu(hdr->opcode);
> +
> +	if (opcode == BATTMGR_NOTIFICATION)
> +		qcom_battmgr_notification(battmgr, data, len);
> +	else if (battmgr->variant == QCOM_BATTMGR_SC8280XP)
> +		qcom_battmgr_sc8280xp_callback(battmgr, data, len);
> +	else
> +		qcom_battmgr_sm8350_callback(battmgr, data, len);
> +}
> +
> +static void qcom_battmgr_enable_worker(struct work_struct *work)
> +{
> +	struct qcom_battmgr *battmgr = container_of(work, struct qcom_battmgr, enable_work);
> +	struct qcom_battmgr_enable_request req = {
> +		.hdr.owner = PMIC_GLINK_OWNER_BATTMGR,
> +		.hdr.type = PMIC_GLINK_NOTIFY,
> +		.hdr.opcode = BATTMGR_REQUEST_NOTIFICATION,
> +	};
> +	int ret;
> +
> +	ret = qcom_battmgr_request(battmgr, &req, sizeof(req));
> +	if (ret)
> +		dev_err(battmgr->dev, "failed to request power notifications\n");
> +}
> +
> +static void qcom_battmgr_pdr_notify(void *priv, int state)
> +{
> +	struct qcom_battmgr *battmgr = priv;
> +
> +	if (state == SERVREG_SERVICE_STATE_UP) {
> +		battmgr->service_up = true;
> +		schedule_work(&battmgr->enable_work);
> +	} else {
> +		battmgr->service_up = false;
> +	}
> +}
> +
> +static const struct of_device_id qcom_battmgr_of_variants[] = {
> +	{ .compatible = "qcom,sc8180x-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
> +	{ .compatible = "qcom,sc8280xp-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
> +	/* Unmatched devices falls back to QCOM_BATTMGR_SM8350 */
> +	{}
> +};
> +
> +static char *qcom_battmgr_battery[] = { "battery" };
> +
> +static int qcom_battmgr_probe(struct auxiliary_device *adev,
> +			      const struct auxiliary_device_id *id)
> +{
> +	struct power_supply_config psy_cfg_supply = {};
> +	struct power_supply_config psy_cfg = {};
> +	const struct of_device_id *match;
> +	struct qcom_battmgr *battmgr;
> +	struct device *dev = &adev->dev;
> +
> +	battmgr = devm_kzalloc(dev, sizeof(*battmgr), GFP_KERNEL);
> +	if (!battmgr)
> +		return -ENOMEM;
> +
> +	battmgr->dev = dev;
> +
> +	psy_cfg.drv_data = battmgr;
> +	psy_cfg.of_node = adev->dev.of_node;
> +
> +	psy_cfg_supply.drv_data = battmgr;
> +	psy_cfg_supply.of_node = adev->dev.of_node;
> +	psy_cfg_supply.supplied_to = qcom_battmgr_battery;
> +	psy_cfg_supply.num_supplicants = 1;
> +
> +	INIT_WORK(&battmgr->enable_work, qcom_battmgr_enable_worker);
> +	mutex_init(&battmgr->lock);
> +	init_completion(&battmgr->ack);
> +
> +	match = of_match_device(qcom_battmgr_of_variants, dev->parent);
> +	if (match)
> +		battmgr->variant = (unsigned long)match->data;
> +	else
> +		battmgr->variant = QCOM_BATTMGR_SM8350;
> +
> +	battmgr->client = devm_pmic_glink_register_client(dev,
> +							  PMIC_GLINK_OWNER_BATTMGR,
> +							  qcom_battmgr_callback,
> +							  qcom_battmgr_pdr_notify,
> +							  battmgr);
> +	if (IS_ERR(battmgr->client))
> +		return PTR_ERR(battmgr->client);

This is racy as you register the callbacks before registering the power
supplies below.

I've seen NULL derefs in qcom_battmgr_notification() when trying to
access the power supplies before they have been allocated due to early
notifications on both CRD and X13s. This can easily be reproduced by
adding some sleep here.

On the other hand, I guess you can't just move the callback registration
after registering the supplies as battmgr->client is needed to process
requests.

> +
> +	if (battmgr->variant == QCOM_BATTMGR_SC8280XP) {
> +		battmgr->bat_psy = devm_power_supply_register(dev, &sc8280xp_bat_psy_desc, &psy_cfg);
> +		if (IS_ERR(battmgr->bat_psy))
> +			return dev_err_probe(dev, PTR_ERR(battmgr->bat_psy),
> +					     "failed to register battery power supply\n");
> +
> +		battmgr->ac_psy = devm_power_supply_register(dev, &sc8280xp_ac_psy_desc, &psy_cfg_supply);
> +		if (IS_ERR(battmgr->ac_psy))
> +			return dev_err_probe(dev, PTR_ERR(battmgr->ac_psy),
> +					     "failed to register AC power supply\n");
> +
> +		battmgr->usb_psy = devm_power_supply_register(dev, &sc8280xp_usb_psy_desc, &psy_cfg_supply);
> +		if (IS_ERR(battmgr->usb_psy))
> +			return dev_err_probe(dev, PTR_ERR(battmgr->usb_psy),
> +					     "failed to register USB power supply\n");
> +
> +		battmgr->wls_psy = devm_power_supply_register(dev, &sc8280xp_wls_psy_desc, &psy_cfg_supply);
> +		if (IS_ERR(battmgr->wls_psy))
> +			return dev_err_probe(dev, PTR_ERR(battmgr->wls_psy),
> +					     "failed to register wireless charing power supply\n");
> +	} else {
> +		battmgr->bat_psy = devm_power_supply_register(dev, &sm8350_bat_psy_desc, &psy_cfg);
> +		if (IS_ERR(battmgr->bat_psy))
> +			return dev_err_probe(dev, PTR_ERR(battmgr->bat_psy),
> +					     "failed to register battery power supply\n");
> +
> +		battmgr->usb_psy = devm_power_supply_register(dev, &sm8350_usb_psy_desc, &psy_cfg_supply);
> +		if (IS_ERR(battmgr->usb_psy))
> +			return dev_err_probe(dev, PTR_ERR(battmgr->usb_psy),
> +					     "failed to register USB power supply\n");
> +
> +		battmgr->wls_psy = devm_power_supply_register(dev, &sm8350_wls_psy_desc, &psy_cfg_supply);
> +		if (IS_ERR(battmgr->wls_psy))
> +			return dev_err_probe(dev, PTR_ERR(battmgr->wls_psy),
> +					     "failed to register wireless charing power supply\n");
> +	}
> +
> +	dev_set_drvdata(dev, battmgr);

You never use the driver data so you shouldn't set it.

> +
> +	return 0;
> +}

Johan
