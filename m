Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696D54E3AC7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbiCVIjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbiCVIjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:39:15 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82C46AA4D;
        Tue, 22 Mar 2022 01:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647938268; x=1679474268;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZRVHgPGEeoSIITIJqcFPK4jqYWVikFjVIYIZtlHhedY=;
  b=xmYMwKMMWEh2q3T6THgRU4u62FDpQlMr9IvWOJQOnOirWyPl4M7iS5O2
   gq2gRnvrvKOf9dAbasRdPqIE01KqfFAXlmTJbWZF49jPDJ5yX/raC8Nrh
   hZ9PLB/+i46AqXXHma9pc0pT7hyOTpPU8LCqkDeHcCLilWCrrFIVB9tsv
   M=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 22 Mar 2022 01:37:48 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 01:37:47 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 22 Mar 2022 01:37:46 -0700
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 22 Mar 2022 01:37:42 -0700
Date:   Tue, 22 Mar 2022 14:07:38 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>
Subject: Re: [PATCH v11 5/5] usb: dwc3: qcom: Keep power domain on to retain
 controller status
Message-ID: <20220322083738.GM23316@hu-pkondeti-hyd.qualcomm.com>
References: <1647932876-23249-1-git-send-email-quic_c_sanm@quicinc.com>
 <1647932876-23249-6-git-send-email-quic_c_sanm@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1647932876-23249-6-git-send-email-quic_c_sanm@quicinc.com>
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

Hi Sandeep,

On Tue, Mar 22, 2022 at 12:37:56PM +0530, Sandeep Maheswaram wrote:
> Keep the power domain on in order to retail controller status and
> to support wakeup from devices.
> 

%s/retail/retain

retain the controller status so that remote wakeup / device connect /
device disconnect events can be detected during suspend.

> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 9804a19..35087cf 100644
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
> @@ -724,6 +725,7 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>  	struct resource		*res, *parent_res = NULL;
>  	int			ret, i;
>  	bool			ignore_pipe_clk;
> +	struct generic_pm_domain *genpd;
>  
>  	qcom = devm_kzalloc(&pdev->dev, sizeof(*qcom), GFP_KERNEL);
>  	if (!qcom)
> @@ -732,6 +734,8 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, qcom);
>  	qcom->dev = &pdev->dev;
>  
> +	genpd = pd_to_genpd(qcom->dev->pm_domain);
> +
>  	if (has_acpi_companion(dev)) {
>  		qcom->acpi_pdata = acpi_device_get_match_data(dev);
>  		if (!qcom->acpi_pdata) {
> @@ -839,6 +843,8 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto interconnect_exit;
>  
> +	genpd->flags |= GENPD_FLAG_ALWAYS_ON;
> +
>  	device_init_wakeup(&pdev->dev, 1);
>  	qcom->is_suspended = false;
>  	pm_runtime_set_active(dev);
> -- 
> 2.7.4
> 

Thanks,
Pavan
