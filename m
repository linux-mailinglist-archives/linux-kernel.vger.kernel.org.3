Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69B358929C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 21:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237029AbiHCTLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 15:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiHCTLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 15:11:45 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44170186F9
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 12:11:44 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id w14so4227218plp.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 12:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Yem/qpYgEmCA72j+50vuDoYqx1yqH6LmWKyXF9t4QJg=;
        b=EwxcoNIv8M8nBbi4W52JGeZOlI+IHvVO1zFTLNFcaeZacJh9+EWETN98RqBn/VQxu6
         tCrof60TWxBkZ5GDGErF9ZuxvR8nwF+2Pc/wZrDG1ZNQg3Qg+n2XVZsdsY8DPBEuS72x
         QQ29+MDE/K9tTT1pexxtQ+L7ZNYHVNzt0AB6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yem/qpYgEmCA72j+50vuDoYqx1yqH6LmWKyXF9t4QJg=;
        b=h2ZUV+VpdhGKBKhcvst7TLU7buPKvSyplodBqs5uLscS94Y2YBGx1QelekbH6iy8B3
         mpCeCWQ+sVO4yeQ/I4ZEcC4ZOXUtYh+WnwXx3V4Ha6eB/0mseFSelGzIzp53aoVkOa2W
         bm7h6trjRDd1Zxu4b4A/xytoORZyibjzqrqtgFuDc0nVkE8D6J7fBYdN/qGFm2fnIbv+
         losxoBTsk1RAO+2U6p79Vy7/jQBui6rgBhQ+BCKFMDtYAOgDoauhZsbKEHux/CMfa9Ff
         0bScbUG5j4I+71/euoeoDkOcw+2MDsDwbSOZE+UQGSx3AvwJILrQEwBs/YXHbMdD7cgP
         /NCA==
X-Gm-Message-State: ACgBeo2rrE75kdm8LfOLTHAPh9cj3hw5psvL8zzW7raYs34dXry/w1P8
        bnAT/uSHrq8BABAKCHB5rjxLRw==
X-Google-Smtp-Source: AA6agR7H1WXgeyhi8psPWgku2rAwpAfqOGEf+yJ1MpMRzacBssEBrY3b5f72u5r2VE1mq17XXJL1sw==
X-Received: by 2002:a17:90b:1c0a:b0:1f3:1848:591c with SMTP id oc10-20020a17090b1c0a00b001f31848591cmr6248533pjb.24.1659553903773;
        Wed, 03 Aug 2022 12:11:43 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:238b:c074:f5f8:56d0])
        by smtp.gmail.com with UTF8SMTPSA id k15-20020a170902c40f00b0016dbaf3ff2esm2456247plk.22.2022.08.03.12.11.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 12:11:43 -0700 (PDT)
Date:   Wed, 3 Aug 2022 12:11:41 -0700
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
Subject: Re: [PATCH 3/8] usb: dwc3: qcom: fix broken non-host-mode suspend
Message-ID: <YurIbcXHPF6K3oPa@google.com>
References: <20220802151404.1797-1-johan+linaro@kernel.org>
 <20220802151404.1797-4-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220802151404.1797-4-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 05:13:59PM +0200, Johan Hovold wrote:
> A recent commit implementing wakeup support in host mode instead broke
> suspend for peripheral and OTG mode.
> 
> The hack that was added in the suspend path to determine the speed of
> any device connected to the USB2 bus not only accesses internal driver
> data for a child device, but also dereferences a NULL pointer when not
> in host mode and there is no HCD.
> 
> As the controller can switch role at any time when in OTG mode, there's
> no quick fix to this, and since reverting would leave us with broken
> suspend in host-mode (wakeup triggers immediately), keep the hack for
> now and only fix the NULL-pointer dereference.
> 
> Fixes: 6895ea55c385 ("usb: dwc3: qcom: Configure wakeup interrupts during suspend")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index be2e3dd36440..b75ff40f75a2 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -301,8 +301,17 @@ static void dwc3_qcom_interconnect_exit(struct dwc3_qcom *qcom)
>  static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom)
>  {
>  	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
> -	struct usb_hcd *hcd = platform_get_drvdata(dwc->xhci);
>  	struct usb_device *udev;
> +	struct usb_hcd *hcd;
> +
> +	if (qcom->mode != USB_DR_MODE_HOST)
> +		return USB_SPEED_UNKNOWN;

Couldn't instead the below block in dwc3_qcom_suspend() be conditional on
the controller being in host mode?

	if (device_may_wakeup(qcom->dev)) {
		qcom->usb2_speed = dwc3_qcom_read_usb2_speed(qcom);
		dwc3_qcom_enable_interrupts(qcom);
	}

I see, the problem is that the role switch could happen at any time as the
commit message says. With this patch there is also a race though, the role
switch could happen just after the check and before obtaining 'hcd'.
