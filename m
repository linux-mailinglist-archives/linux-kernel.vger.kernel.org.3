Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0183B58B63E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 16:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbiHFO5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 10:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiHFO5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 10:57:30 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EAEDFBB
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 07:57:29 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id w14so4974556plp.9
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 07:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Zp8ScE6+c88OFj3/AkcT1uLw5Dnq1hTT03Wi6C4EzHM=;
        b=fHnoxmmpFeHcvoV1HH6LKTm8AASI2wIP6w2rlIGDoV0OLs+0N4DGfvoQx2xWXRkaaY
         e7QKqzwuDF7MGltZD8M474UUSqQSpPE8SA8A2pnnbhF2h5M8hWrUYEXqKKtJ+k5pbGnI
         oikkwgDdzYHTRRgYf/33zivy58FYZm1BLG5HyD0tuMOmQGvvTh2+ava1FURY6Wy3c60P
         HXld4bjhrX/CwMCTRLWFIHtgYxhj7uzZrLYQcsR9yWzLKjM9HwddTrm+z3ZlnAPy/+au
         dLiVJhWQGDZJO6NJ7Ddg3s042qpDjiRmrh9BleeTsoGPfqmQpV8928ymFG8HDuPH4Nxc
         7Emw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Zp8ScE6+c88OFj3/AkcT1uLw5Dnq1hTT03Wi6C4EzHM=;
        b=nlIsfF++Qyi8Dzp9U9LiMMpmIc2HNikEct/nRMviGTiYejkCflVdN6Z1Z7oQLUljTb
         SQAPJa1mciWkNn4Im8yzqHYdFsiHZDObs/TYLVJrCBfAwC6RoIza6i0Sr97pAW2DLadr
         WlXNH/vXg4bFI56VCHN4JK8LEDQojGFGRPbJypqfU4sLmJhYwzsw72RhuH5TdSSddJOC
         eGalhzgGW836nWybTpyYNg4w4LX2B8MimekXsY53c5XRrmVxiWTg6YnSc16r5cb2SWIO
         0HO61k3v03tYIgaNPVHLHnHhwYJ+pkAiYvWUl6O9ZuqOaEC8pxpBOreDRMcNNBonT5Vn
         ATUg==
X-Gm-Message-State: ACgBeo0BLguaRaOboy66SMfFfAVWWWCC4tQ3HMbtS0ShRqmCeFP3HhYN
        aO9TOW/4HufG7+mEyDOG9ZDc
X-Google-Smtp-Source: AA6agR4EEvWRlq/QQqKTal9guvRl28ZShkyfmd7akMs1njO/0hmq2B4MFXAaWfp3TkOQHhrWkOdaZA==
X-Received: by 2002:a17:902:ec90:b0:16e:d8d8:c2db with SMTP id x16-20020a170902ec9000b0016ed8d8c2dbmr11377058plg.69.1659797848472;
        Sat, 06 Aug 2022 07:57:28 -0700 (PDT)
Received: from thinkpad ([117.202.188.20])
        by smtp.gmail.com with ESMTPSA id o8-20020a1709026b0800b0016e2309bcf1sm5139998plk.13.2022.08.06.07.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 07:57:28 -0700 (PDT)
Date:   Sat, 6 Aug 2022 20:27:19 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/9] usb: dwc3: qcom: fix wakeup implementation
Message-ID: <20220806145719.GG14384@thinkpad>
References: <20220804151001.23612-1-johan+linaro@kernel.org>
 <20220804151001.23612-9-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220804151001.23612-9-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 05:10:00PM +0200, Johan Hovold wrote:
> It is the Qualcomm glue wakeup interrupts that may be able to wake the
> system from suspend and this can now be described in the devicetree.
> 
> Move the wakeup-source property handling over from the core driver and
> instead propagate the capability setting to the core device during
> probe.
> 

The "wakeup-source" property is still defined in the DWC binding, so other
platform glue drivers are free to assume that wakeup capability is handled by
the DWC driver.

> This is needed as there is currently no way for the core driver to query
> the wakeup setting of the glue device, but it is the core driver that
> manages the PHY power state during suspend.
> 
> Also don't leave the PHYs enabled when system wakeup has been disabled
> through sysfs.
> 

Can you please elaborate on how this is handled in the patch?

Thanks,
Mani

> Fixes: 649f5c842ba3 ("usb: dwc3: core: Host wake up support from system suspend")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/usb/dwc3/core.c      | 5 ++---
>  drivers/usb/dwc3/dwc3-qcom.c | 6 +++++-
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 16d1f328775f..8c8e32651473 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -1822,7 +1822,6 @@ static int dwc3_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, dwc);
>  	dwc3_cache_hwparams(dwc);
> -	device_init_wakeup(&pdev->dev, of_property_read_bool(dev->of_node, "wakeup-source"));
>  
>  	spin_lock_init(&dwc->lock);
>  	mutex_init(&dwc->mutex);
> @@ -1984,7 +1983,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>  		dwc3_core_exit(dwc);
>  		break;
>  	case DWC3_GCTL_PRTCAP_HOST:
> -		if (!PMSG_IS_AUTO(msg) && !device_can_wakeup(dwc->dev)) {
> +		if (!PMSG_IS_AUTO(msg) && !device_may_wakeup(dwc->dev)) {
>  			dwc3_core_exit(dwc);
>  			break;
>  		}
> @@ -2045,7 +2044,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
>  		spin_unlock_irqrestore(&dwc->lock, flags);
>  		break;
>  	case DWC3_GCTL_PRTCAP_HOST:
> -		if (!PMSG_IS_AUTO(msg) && !device_can_wakeup(dwc->dev)) {
> +		if (!PMSG_IS_AUTO(msg) && !device_may_wakeup(dwc->dev)) {
>  			ret = dwc3_core_init_for_resume(dwc);
>  			if (ret)
>  				return ret;
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 6ae0b7fc4e2c..b05f67d206d2 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -786,6 +786,7 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>  	struct resource		*res, *parent_res = NULL;
>  	int			ret, i;
>  	bool			ignore_pipe_clk;
> +	bool			wakeup_source;
>  
>  	qcom = devm_kzalloc(&pdev->dev, sizeof(*qcom), GFP_KERNEL);
>  	if (!qcom)
> @@ -901,7 +902,10 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto interconnect_exit;
>  
> -	device_init_wakeup(&pdev->dev, 1);
> +	wakeup_source = of_property_read_bool(dev->of_node, "wakeup-source");
> +	device_init_wakeup(&pdev->dev, wakeup_source);
> +	device_init_wakeup(&qcom->dwc3->dev, wakeup_source);
> +
>  	qcom->is_suspended = false;
>  	pm_runtime_set_active(dev);
>  	pm_runtime_enable(dev);
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
