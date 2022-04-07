Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D52F4F86D3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 20:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346726AbiDGSEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 14:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346705AbiDGSEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 14:04:00 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BDBB8237
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 11:02:00 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id b15so6158231pfm.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 11:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F4m+NmCt6OQn1SzMUe8Cohym4BG+NQ3hA7612DJmQk8=;
        b=gxJe8yE0vDDooVk/tyWuz6yS5lmQYS/Wkon9uCa6FbL1Vp+1car52FqOuW/+gvGVtr
         uRFXlYXosH7BLeaJQ/dxhonfjStPz7APnzrBFOHVy8ov9Dm1Qt5vTegZpuZo3JL4j/yS
         Mt/CLtsQsj2t2PTylkSKsg9ChciEv8RgvBrkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F4m+NmCt6OQn1SzMUe8Cohym4BG+NQ3hA7612DJmQk8=;
        b=y/txIyY4iTn2tvLx9qmPuIbhOtmjDotYFQ7cEGE54TwPOOjyQnNunMnwrd5/Jm6M4o
         1XDcM1AytzO0MkI4v41/75prqY3hLo3wqTNSGD7qLFEETf5kTxcHGkcR7Olda0m3uvjH
         rOFUYBBWgHGz2YNZ778FUU6FpbmeHWAVRaw6Ac6091cDiwVkQDDmp8OesC1NHG01R5iF
         3V8tnOSBmQZ7Tn/4sf7tLdgj+fYASenesH0CRAPCoKcpnJZPnssW8Ko5c3LncD9xQeD2
         /BZR7MLCZrYljojyLqKJnh7d1ZifbBaoP8SzFXBEllvZZQcSNSHwXbkk+kMsrQO30Air
         Q+Ig==
X-Gm-Message-State: AOAM530y56rp2Rfl/+p//2PvSypsJr9EM+2Gch5uK9KXo8UCu9TvzN7b
        D84oEMBNA2LCQAuEs2srlrVsjQ==
X-Google-Smtp-Source: ABdhPJzRd2qZYYwG5AfxTyIymC3MZj/ozFy0iyV+2G1omVsn91D0Sgr3xC08x23KE/K5bh1F6e4nmg==
X-Received: by 2002:a05:6a00:190a:b0:4fa:e4e9:7126 with SMTP id y10-20020a056a00190a00b004fae4e97126mr15410147pfi.65.1649354519621;
        Thu, 07 Apr 2022 11:01:59 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:693e:9ca0:42a0:6bf7])
        by smtp.gmail.com with UTF8SMTPSA id x12-20020aa7956c000000b004fdf7a4d49dsm16020425pfq.158.2022.04.07.11.01.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 11:01:59 -0700 (PDT)
Date:   Thu, 7 Apr 2022 11:01:57 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_kriskura@quicinc.com, quic_vpulyala@quicinc.com
Subject: Re: [PATCH v12 4/6] usb: dwc3: qcom: Keep power domain on to retain
 controller status
Message-ID: <Yk8nFZhLgdTQsllD@google.com>
References: <1649321104-31322-1-git-send-email-quic_c_sanm@quicinc.com>
 <1649321104-31322-5-git-send-email-quic_c_sanm@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1649321104-31322-5-git-send-email-quic_c_sanm@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 02:15:02PM +0530, Sandeep Maheswaram wrote:
> Keep the power domain on in order to retain controller status and
> to support wakeup from devices.
> 
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

Not sure it really matters, but could this be done conditionally based
on device_can_wakeup() of the dwc3 core device?

> +
>  	device_init_wakeup(&pdev->dev, 1);

Now that the dwc3 core looks at the wakeup-source property it seems
this driver should enable wakeup only when it is enabled for the
core.

Actually I wonder if it would make sense to leave wakeup for dwc3-qcom
'officially' disabled, and just make all wakeup related decisions
based on the wakeup configuration of the dwc3 core (as
dwc3_qcom_en/disable_interrupts() already do). The separate wakeup
policies for dwc3 core and dwc3-qcom are confusing and don't seem to
add any value.
