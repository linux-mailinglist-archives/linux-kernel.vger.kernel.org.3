Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CFC4FC67C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 23:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350088AbiDKVPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 17:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350147AbiDKVPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 17:15:45 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F259A2BB1F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 14:13:26 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id z128so15275900pgz.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 14:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YKAYMKKcSN6w/x99fPnQm5TkOR6xo+gMRiTH6ZYG4Ro=;
        b=EhR7QpOZ0HnE4rK5R9d0GxRj98mteeaRTItJIa6EJKU2EEGKdAvwcfi6lrILXJYsHJ
         Fe+doXlqcFFqdNwpAUThfV36GNrU385i6+ZEIurapg8Hf5gEChmCWLZkWC0AdlETBoIE
         nb8QW/fT0q6lxGQJ3Zit+MVsN33ry+N1Lmuo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YKAYMKKcSN6w/x99fPnQm5TkOR6xo+gMRiTH6ZYG4Ro=;
        b=hSm1z6Az63lcHYt0+/jF0MvLQk03kgGq3zBSMln9MAXTtaMWLBPkC6N1uGgHPow2+u
         PLqXD25ycfV6PBxtQ4UH1u81+uMNTm5HV9eFJegJvxl3IYOZaEVAklzUdg6nMgikAvgv
         xsk36MX8v4alkxSUt0qVZ6H+9nNWKG2cOo2TdrQ5HzVGKqV0IDqE37Z5dJoKttKf2A5m
         7rE4hrPip3RRCxxrSjQEZhxeZ8LGViqGDAj/qT7ZmG5r9ZjDZgXeSUBpnbTkpuQ27SYt
         ufr9lTbypUBu9N9h1UzEE+0msvAK8N/0qLKvYodJDMGXCzhib0HPGm2F8GSutWRF724I
         0TLA==
X-Gm-Message-State: AOAM532R5NR8QxqjziTjQdjjc/PwDcgabdI5Z/JWgDagdVZXaDJPB/Fr
        9h6OaoCp6UhRN69Nc8iRnFAkpg==
X-Google-Smtp-Source: ABdhPJzl8rfg8ySS5Ytnevu8E/f/F9vTdYrGegE0Oef11S5yT3t9PqIHOQ2qCbAfFdF2WkI3wjs0Nw==
X-Received: by 2002:a63:e5c:0:b0:39d:8460:4708 with SMTP id 28-20020a630e5c000000b0039d84604708mr1977629pgo.401.1649711604530;
        Mon, 11 Apr 2022 14:13:24 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:eb96:76ba:e2a1:2442])
        by smtp.gmail.com with UTF8SMTPSA id d4-20020a17090ad3c400b001c65ba76911sm392429pjw.3.2022.04.11.14.13.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 14:13:24 -0700 (PDT)
Date:   Mon, 11 Apr 2022 14:13:22 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_kriskura@quicinc.com, quic_vpulyala@quicinc.com
Subject: Re: [PATCH v13 5/6] usb: dwc3: qcom: Keep power domain on to retain
 controller status
Message-ID: <YlSZ8uk8MjygY7uf@google.com>
References: <1649704614-31518-1-git-send-email-quic_c_sanm@quicinc.com>
 <1649704614-31518-6-git-send-email-quic_c_sanm@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1649704614-31518-6-git-send-email-quic_c_sanm@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 12:46:53AM +0530, Sandeep Maheswaram wrote:
> Keep the power domain always on during runtime suspend or if the
> controller supports wakeup in order to retain controller status
> and to support wakeup from devices.
> 
> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 9804a19..9747be6 100644
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

nit: I'm not really a fan of gazillions of whitespaces between the type
and the variable name, but if they are kept all variable names above
should move a tab to the right. In any case the style in this file isn't
consistent, so an alternative would be to just get rid of the alignment
completely.

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
> @@ -839,7 +843,12 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto interconnect_exit;
>  
> -	device_init_wakeup(&pdev->dev, 1);
> +	genpd->flags |= GENPD_FLAG_RPM_ALWAYS_ON;
> +
> +	if (device_may_wakeup(&qcom->dwc3->dev))
> +		genpd->flags |= GENPD_FLAG_ALWAYS_ON;

In v12 only GENPD_FLAG_ALWAYS_ON was set, not GENPD_FLAG_RPM_ALWAYS_ON.
I asked a few times for a change log, in this instance it would be
useful to explain why GENPD_FLAG_RPM_ALWAYS_ON is now set.

> +
> +	device_init_wakeup(&pdev->dev, device_may_wakeup(&qcom->dwc3->dev));

device_may_wakeup() isn't an expensive operation, but it's still not nice to
call it twice in three lines of code. Instead you could do this:

	if (device_may_wakeup(&qcom->dwc3->dev)) {
		genpd->flags |= GENPD_FLAG_ALWAYS_ON;
		device_init_wakeup(&pdev->dev, true);
	}
