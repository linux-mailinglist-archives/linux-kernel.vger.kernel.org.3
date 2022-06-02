Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA6E53B343
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 08:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiFBGAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 02:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiFBGAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 02:00:35 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CDA27CCEB;
        Wed,  1 Jun 2022 23:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654149634; x=1685685634;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+esPXd/BbiCH8ZjBUxVw7+nYENh3f7bs6TmjM6+/l3w=;
  b=znC3h6OW6r67lPoTwvTAY0kueLd0geUH1Gct1fg/JaUFXYSLy2lEQG8r
   mVp9vWsshXAQfzyylYgUht0x9AD1WG5H90j8JbIoiwSTW8aFoxSNh7Amc
   N/UicdUiIRPPdmjRsqapCjYkWifpN1Id49r8xSV5R1mEYyjzgmwsKBhsx
   U=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 01 Jun 2022 23:00:34 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 23:00:33 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 1 Jun 2022 23:00:32 -0700
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 1 Jun 2022 23:00:26 -0700
Date:   Thu, 2 Jun 2022 11:30:22 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_vpulyala@quicinc.com>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Subject: Re: [PATCH v19 5/5] usb: dwc3: qcom: Keep power domain on to retain
 controller status
Message-ID: <20220602060022.GB20979@hu-pkondeti-hyd.qualcomm.com>
References: <1654139515-8177-1-git-send-email-quic_kriskura@quicinc.com>
 <1654139515-8177-6-git-send-email-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1654139515-8177-6-git-send-email-quic_kriskura@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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

Hi Krishna,

On Thu, Jun 02, 2022 at 08:41:55AM +0530, Krishna Kurapati wrote:
> From: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> 
> If dwc3 is wakeup capable, keep the power domain always ON so that
> wakeup from system suspend can be supported. Otherwise, keep the
> power domain ON only during runtime suspend to support wakeup from
> runtime suspend.
> 
> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 56ecee0..2f5b5ae 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -17,6 +17,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/phy/phy.h>
> +#include <linux/pm_domain.h>
>  #include <linux/usb/of.h>
>  #include <linux/reset.h>
>  #include <linux/iopoll.h>
> @@ -756,12 +757,13 @@ dwc3_qcom_create_urs_usb_platdev(struct device *dev)
>  
>  static int dwc3_qcom_probe(struct platform_device *pdev)
>  {
> -	struct device_node	*np = pdev->dev.of_node;
> -	struct device		*dev = &pdev->dev;
> -	struct dwc3_qcom	*qcom;
> -	struct resource		*res, *parent_res = NULL;
> -	int			ret, i;
> -	bool			ignore_pipe_clk;
> +	struct device_node *np = pdev->dev.of_node;
> +	struct device *dev = &pdev->dev;
> +	struct dwc3_qcom *qcom;
> +	struct resource	*res, *parent_res = NULL;
> +	int ret, i;
> +	bool ignore_pipe_clk;
> +	struct generic_pm_domain *genpd;
>  
>  	qcom = devm_kzalloc(&pdev->dev, sizeof(*qcom), GFP_KERNEL);
>  	if (!qcom)
> @@ -770,6 +772,8 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, qcom);
>  	qcom->dev = &pdev->dev;
>  
> +	genpd = pd_to_genpd(qcom->dev->pm_domain);
> +
>  	if (has_acpi_companion(dev)) {
>  		qcom->acpi_pdata = acpi_device_get_match_data(dev);
>  		if (!qcom->acpi_pdata) {
> @@ -877,7 +881,17 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto interconnect_exit;
>  
> -	device_init_wakeup(&pdev->dev, 1);
> +	if (device_can_wakeup(&qcom->dwc3->dev)) {
> +		/*
> +		 * Setting GENPD_FLAG_ALWAYS_ON flag takes care of keeping
> +		 * GEMPD on in both RT suspend and System suspend cases.
> +		 */

The comments provided at [1] are not addressed. Pls fix it.

https://lore.kernel.org/linux-usb/20220526024741.GP15121@hu-pkondeti-hyd.qualcomm.com/

Thanks,
Pavan
