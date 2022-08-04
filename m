Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735C4589FA0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 18:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237099AbiHDQ7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 12:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbiHDQ7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 12:59:52 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF0367CB5
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 09:59:47 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id bf13so382587pgb.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 09:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ajh2ay/tShS0T3mEFnSZ0by+HsK7Mn/hpkM/mCvNva0=;
        b=lz/kuCg6IRO4dLKH6V4paHzmXaWNI12uLvsnPN1lBCr6Lleqx3m6d36BH0R40kxcz0
         qM0qFj55Q76+GJ/6Ctyh/+14pVlT91DCeYlfBOuq4v01aVb7Sc0/S98g7gAK69fVQnPo
         jB9CGh6CqpjPkKtTIVGO8bRQoqyLxs2RDYqyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ajh2ay/tShS0T3mEFnSZ0by+HsK7Mn/hpkM/mCvNva0=;
        b=cXjA+qx8EXgMNJJsABwRLtUE0w4CraF2rOVPgkrT6/Yb2eb2Nc6+K/cOFW+OaVchN2
         oU8LMuIZ+5pgQIYNOfLAjh31carG2krqd1xozbzNxZ5KlYhnl5zTidqN/P1PdMos6swl
         ChBnzthBvqQ3JSn3E/mG2mx012sZEahU5h3Y6V0lAsanpvJJPlE8vxUYihPjbWyfPYE6
         ZKPkvLzOZNAQlYapXcSwxuBixAoiEte0lZBgfEAvS4KJDAmFjgT1RBgJLNML16ehva5O
         Hz3azehZxYOfPCvNE4x6yTTLpCrwTgneSkzjG7+ioSYjIJm0tlg8EoaF5TukCJUM5/Ll
         QRgA==
X-Gm-Message-State: ACgBeo1WvAGJ+b+ue9dDCiVhzVqat2MPsWwNYCP8h+6yVGN9KfAp3aGK
        7TmwqRqx21DPg+3nuZSrwT0M8A==
X-Google-Smtp-Source: AA6agR7X25qLSBYYrho0ENYRQNA0Cmh8oMxWYY7cOVtOcXFu+38U/7oHiu3qGRghMajV/hSd5z2nOQ==
X-Received: by 2002:a63:8242:0:b0:41b:e465:81dd with SMTP id w63-20020a638242000000b0041be46581ddmr2348517pgd.217.1659632386946;
        Thu, 04 Aug 2022 09:59:46 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:87c4:32ca:84b6:e942])
        by smtp.gmail.com with UTF8SMTPSA id nu3-20020a17090b1b0300b001f52fa1704csm14280238pjb.3.2022.08.04.09.59.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 09:59:46 -0700 (PDT)
Date:   Thu, 4 Aug 2022 09:59:44 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/9] usb: dwc3: qcom: fix wakeup implementation
Message-ID: <Yuv7AM/5jtO/pgcm@google.com>
References: <20220804151001.23612-1-johan+linaro@kernel.org>
 <20220804151001.23612-9-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220804151001.23612-9-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
> This is needed as there is currently no way for the core driver to query
> the wakeup setting of the glue device, but it is the core driver that
> manages the PHY power state during suspend.
> 
> Also don't leave the PHYs enabled when system wakeup has been disabled
> through sysfs.
> 
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

Let me explain the rationale for why device_can_wakeup() was used here:

On QCOM SC7180 based Chromebooks we observe that the onboard USB hub consumes
~80 mW during system suspend when the PHYs are disabled, as opposed to ~17 mW
when the PHYs remain enabled. This is a significant delta when the device is
on a battery power.

The initial idea was to leave the PHYs always enabled (in a low power mode),
but then I dug up commit c4a5153e87fd ("usb: dwc3: core: Power-off core/PHYs
on system_suspend in host mode"), which provides a rationale for the PHYs
being powered off:

  Commit 689bf72c6e0d ("usb: dwc3: Don't reinitialize core during
  host bus-suspend/resume") updated suspend/resume routines to not
  power_off and reinit PHYs/core for host mode.
  It broke platforms that rely on DWC3 core to power_off PHYs to
  enter low power state on system suspend.

Unfortunately we don't know which platforms are impacted by this. The idea
behind using device_can_wakeup() was to use it as a proxy for platforms
that are *not* impacted. If a platform supports USB wakeup supposedly the
SoC can enter its low power mode during system suspend with the PHYs
enabled.

By now I'm not 100% sure if the above assumption is correct. I recently
saw allegations that the power consumption of a given QC SoC with USB
wakeup support drops significantly when wakeup is disabled (i.e. when
the PHYs are off), but haven't confirmed this yet.
