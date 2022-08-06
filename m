Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709EB58B5C7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 15:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbiHFNwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 09:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiHFNwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 09:52:13 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8621EE35
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 06:52:09 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id u133so4485913pfc.10
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 06:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=RSxdi8xvKopT4hYxNJXBxrYk0uMobA98LNnzcb7HFVY=;
        b=L+iEfobGTIaZdBDTSWhiVWJAZiZ8J3cHBW5T7IMiYfbYWN6pMGIpn4ibaosnyacFo8
         lj56/jZr80p2dQSxieT0G8Nu44GDc5SNf06Ky1AEO0wJzgBKSC7Amd37CgGErQazzyXN
         GJBkiXSMD8sjCFwt6TtJC+149MEsZy7JQojiPyp3ZDmLHjZWaQvirxTScxBsFBLddSYS
         0Zc+2XXYAUr0oEZbd0kzYuPjrrv7FWgr7XzvGAog+cmJImXnYKRHeqAsn/M0qtb8fICr
         lsnsFFfNysyxqWMiEiXtDmSrUwZPfOIQUcsWh/s0M3HuYdkhqaI8vM6d+l7e0KMP74LN
         yofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RSxdi8xvKopT4hYxNJXBxrYk0uMobA98LNnzcb7HFVY=;
        b=CA/yHxCynKxpP+t/g9iTuiy47V95btaxu4kCkexxMU9ji1E7CP9KQHYCw+yrHr+sux
         wivFM301oIXSN1sRdt7WLzAVwL1uesO16vFZk/zf8BOFReXaU4/G2CjAOjKw9RoAnOBE
         CUd3La/YjMYLjGxQPrhlhhXlQ7bcAr98Bl3FIA0BwM/aVgYHwm/u9dXvah4ZY3Aq291U
         8WCvnhXKkHSp8kVFu+Z2+8bWiXuypFC0ZKOOdtpWdxKdE32wT7E3BxuIQi3o3r2mKClJ
         1/SQTHYxyYcZonlpWeAWVNFfP3FBA8hCTDfmzQQ0ZHoHOoK8JDaYRrctDXE0DFCTyx0a
         0cew==
X-Gm-Message-State: ACgBeo30Qh7PR7w7ByC79PwHbW1TxJQqQNZd2y4/SvEwsHjPX5FzoVIv
        SViW78blnAl7kENVsnVPMvtK
X-Google-Smtp-Source: AA6agR4llsfdiV0e9G+rpfDan2dDPwXhlGV/pR1ZWerFm73wdHeBTQAbJhZg+U3ergp2R/NH+VAzlg==
X-Received: by 2002:a05:6a00:21c8:b0:52b:ffc0:15e7 with SMTP id t8-20020a056a0021c800b0052bffc015e7mr11353080pfj.29.1659793929300;
        Sat, 06 Aug 2022 06:52:09 -0700 (PDT)
Received: from thinkpad ([117.202.188.20])
        by smtp.gmail.com with ESMTPSA id u11-20020a17090341cb00b0016be14a776asm4965153ple.286.2022.08.06.06.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 06:52:08 -0700 (PDT)
Date:   Sat, 6 Aug 2022 19:22:00 +0530
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
Subject: Re: [PATCH v2 2/9] Revert "usb: dwc3: qcom: Keep power domain on to
 retain controller status"
Message-ID: <20220806135200.GC14384@thinkpad>
References: <20220804151001.23612-1-johan+linaro@kernel.org>
 <20220804151001.23612-3-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220804151001.23612-3-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 05:09:54PM +0200, Johan Hovold wrote:
> This reverts commit d9be8d5c5b032e5383ff5c404ff4155e9c705429.
> 
> Generic power-domain flags must be set before the power-domain is
> initialised and must specifically not be modified by drivers for devices
> that happen to be in the domain.
> 
> To make sure that USB power-domains are left enabled during system
> suspend when a device in the domain is in the wakeup path, the
> GENPD_FLAG_ACTIVE_WAKEUP flag should instead be set for the domain
> unconditionally when it is registered.
> 
> Note that this also avoids keeping power-domains on during suspend when
> wakeup has not been enabled (e.g. through sysfs).
> 
> For the runtime PM case, making sure that the PHYs are not suspended and
> that they are in the same domain as the controller prevents the domain
> from being suspended. If there are cases where this is not possible or
> desirable, the genpd implementation may need to be extended.
> 
> Fixes: d9be8d5c5b03 ("usb: dwc3: qcom: Keep power domain on to retain controller status")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 28 +++++++---------------------
>  1 file changed, 7 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index c5e482f53e9d..be2e3dd36440 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -17,7 +17,6 @@
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/phy/phy.h>
> -#include <linux/pm_domain.h>
>  #include <linux/usb/of.h>
>  #include <linux/reset.h>
>  #include <linux/iopoll.h>
> @@ -757,13 +756,12 @@ dwc3_qcom_create_urs_usb_platdev(struct device *dev)
>  
>  static int dwc3_qcom_probe(struct platform_device *pdev)
>  {
> -	struct device_node *np = pdev->dev.of_node;
> -	struct device *dev = &pdev->dev;
> -	struct dwc3_qcom *qcom;
> -	struct resource	*res, *parent_res = NULL;
> -	int ret, i;
> -	bool ignore_pipe_clk;
> -	struct generic_pm_domain *genpd;
> +	struct device_node	*np = pdev->dev.of_node;
> +	struct device		*dev = &pdev->dev;
> +	struct dwc3_qcom	*qcom;
> +	struct resource		*res, *parent_res = NULL;
> +	int			ret, i;
> +	bool			ignore_pipe_clk;
>  
>  	qcom = devm_kzalloc(&pdev->dev, sizeof(*qcom), GFP_KERNEL);
>  	if (!qcom)
> @@ -772,8 +770,6 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, qcom);
>  	qcom->dev = &pdev->dev;
>  
> -	genpd = pd_to_genpd(qcom->dev->pm_domain);
> -
>  	if (has_acpi_companion(dev)) {
>  		qcom->acpi_pdata = acpi_device_get_match_data(dev);
>  		if (!qcom->acpi_pdata) {
> @@ -881,17 +877,7 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto interconnect_exit;
>  
> -	if (device_can_wakeup(&qcom->dwc3->dev)) {
> -		/*
> -		 * Setting GENPD_FLAG_ALWAYS_ON flag takes care of keeping
> -		 * genpd on in both runtime suspend and system suspend cases.
> -		 */
> -		genpd->flags |= GENPD_FLAG_ALWAYS_ON;
> -		device_init_wakeup(&pdev->dev, true);
> -	} else {
> -		genpd->flags |= GENPD_FLAG_RPM_ALWAYS_ON;
> -	}
> -
> +	device_init_wakeup(&pdev->dev, 1);
>  	qcom->is_suspended = false;
>  	pm_runtime_set_active(dev);
>  	pm_runtime_enable(dev);
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
