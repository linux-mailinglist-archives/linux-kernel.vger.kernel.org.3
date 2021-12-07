Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A7446AEBE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 01:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359054AbhLGAE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 19:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238201AbhLGAEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 19:04:53 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1AFC0613F8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 16:01:23 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so15784687otl.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 16:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BMx3q+Kfe+DjuBkGP2gx6f6ECT/xxrr/KpPYeMR6rqY=;
        b=NFiU+B4iBWL13hKwzLmjIsvkDTb+/PdHPbMX3+qxkC3RPswW1q2PN+IhkSqlyZcDfb
         QoVRaokY8QUqXMQ7W6c77dsShprJhkTKRGMSSNPv3Bgq7h14tbMa8Ruij5nMzA4CUU/w
         kCYr27i4BR4lTQjvINB+IJWCet0My1EfN9n9TE01WSTOTIEKNrhYyqkc2QQmXO9EXmsR
         PB7BmGRHCYrLfLY4rLy4jw8mo1w1RgDlqKB6Uj6HiGe5hPRQ0Q1AC1Nb0sD1zy8uCRVE
         aFaYYwFo+e+Ub7Xes3ggKNBmnA9ZfHFVkjEjYWyD/K9mJaAVvad+x58SUyqN8rgn6Or1
         RCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BMx3q+Kfe+DjuBkGP2gx6f6ECT/xxrr/KpPYeMR6rqY=;
        b=pGelwWlaiOglHozVFZbt/v7aegtMKVkVR/tgF3vVRu0TE50LoIq2+sAVHDpUzzJnke
         E2qjgt4dW4w41SSqz8gA0tGcwdi3JIewMeMwUCWBiwRL8L31BMOXyqz+NO2u1j3SwnL7
         h+2zwxHYBGTIbxYBcVcu+SA5VjCucG7vJ2pJ1yqobZUxisnmRI20+AJHtf5L3vvwq2w/
         XOPnypJtgh1TQCRITuC/gDKmysIYZttutq6rNF4F3GiMqXbWtTXHS1r9oZkeeO/A5v8w
         o5muHRYLzmU4tDgTFhupCii9Aos6JoHi5b8+4GxGX3VJq6fod/XfONhcRhxf71CLJKO7
         u15Q==
X-Gm-Message-State: AOAM5310n44XoY7Bp8kMMIWMtT+vo0GFFMEQUJBa8ZZFR+FWjwBsX2ey
        F89nkoEoBcSUy+oh3UdPCHbccA==
X-Google-Smtp-Source: ABdhPJyJVSzNU6F1HqOXYRJMj962C/4c6y+kX4SRPOFBKIuAkiZVa/wrgDOKiuQxf16isJv8mhxR3A==
X-Received: by 2002:a9d:364b:: with SMTP id w69mr33095589otb.18.1638835282986;
        Mon, 06 Dec 2021 16:01:22 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 49sm2443205oti.65.2021.12.06.16.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 16:01:22 -0800 (PST)
Date:   Mon, 6 Dec 2021 16:02:48 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        swboyd@chromium.org, Wesley Cheng <quic_wcheng@quicinc.com>,
        robdclark@chromium.org, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Wesley Cheng <wcheng@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: dwc3-qcom: Avoid use-after-free when USB
 defers or unbinds
Message-ID: <Ya6kqL3WzxjdtiSG@ripper>
References: <20211206152844.1.I411110cc99c1dd66b01aa9aa25651acf8ff55da1@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206152844.1.I411110cc99c1dd66b01aa9aa25651acf8ff55da1@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 06 Dec 15:28 PST 2021, Douglas Anderson wrote:

> On sc7180-trogdor class devices with 'fw_devlink=permissive' and KASAN
> enabled, you'll see a Use-After-Free reported at bootup.
> 
> The root of the problem is that dwc3_qcom_of_register_core() is adding
> a devm-allocated "tx-fifo-resize" property to its device tree node
> using of_add_property().
> 
> The issue is that of_add_property() makes a _permanent_ addition to
> the device tree that lasts until reboot. That means allocating memory
> for the property using "devm" managed memory is a terrible idea since
> that memory will be freed upon probe deferral or device
> unbinding. Let's change to just allocate memory once and never free
> it. This sorta looks like a leak but isn't truly one, since only one
> property will be allocated per device tree node per boot.
> 
> NOTE: one would think that perhaps it would be better to use
> of_remove_property() and then be able to free the property on device
> remove. That sounds good until you read the comments for
> of_remove_property(), which says that properties are never really
> removed and they're just moved to the side.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Fixes: cefdd52fa045 ("usb: dwc3: dwc3-qcom: Enable tx-fifo-resize property by default")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  drivers/usb/dwc3/dwc3-qcom.c | 32 +++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 9abbd01028c5..34b054033116 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -658,18 +658,28 @@ static int dwc3_qcom_of_register_core(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> -	prop = devm_kzalloc(dev, sizeof(*prop), GFP_KERNEL);
> -	if (!prop) {
> -		ret = -ENOMEM;
> -		dev_err(dev, "unable to allocate memory for property\n");
> -		goto node_put;
> -	}
> +	/*
> +	 * Permanently add the "tx-fifo-resize" to the device tree. Even if
> +	 * our device is unregistered this property will still be part
> +	 * of the device tree until reboot. Because this is a "permanent"
> +	 * change, we allocate memory _without_ devm. For some context, see
> +	 * the fact that of_remove_property() doesn't actually remove things.
> +	 */
> +	if (!of_find_property(dwc3_np, "tx-fifo-resize", NULL)) {
> +		prop = kzalloc(sizeof(*prop), GFP_KERNEL);
> +		if (!prop) {
> +			ret = -ENOMEM;
> +			dev_err(dev, "unable to allocate memory for property\n");
> +			goto node_put;
> +		}
>  
> -	prop->name = "tx-fifo-resize";
> -	ret = of_add_property(dwc3_np, prop);
> -	if (ret) {
> -		dev_err(dev, "unable to add property\n");
> -		goto node_put;
> +		prop->name = "tx-fifo-resize";
> +		ret = of_add_property(dwc3_np, prop);
> +		if (ret) {
> +			dev_err(dev, "unable to add property\n");
> +			kfree(prop);
> +			goto node_put;
> +		}
>  	}
>  
>  	ret = of_platform_populate(np, NULL, NULL, dev);
> -- 
> 2.34.1.400.ga245620fadb-goog
> 
