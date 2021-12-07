Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A2346AF39
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 01:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378469AbhLGAk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 19:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352055AbhLGAk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 19:40:58 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1C5C0613F8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 16:37:29 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id n66so24602213oia.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 16:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=7pcoZDYDZ4XPy0jfSxV51o0QhlkPtWK28eVQI3c3heA=;
        b=ISpCreUcW3wJr9UiyA4Gp9QQ7tKtuGhHCV5KsPKGSpgRhwh6fp+Sa9kynBtddhlD6V
         4BnOQ66tXsc1gACQIE6Z5PqGo+ci36ry40854wPd/i65xVPMFjRvxrb0KRB+sJUzGJk3
         zst0cqP6vv8MD9rrZmcacn8TmX4/d6krTJIwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=7pcoZDYDZ4XPy0jfSxV51o0QhlkPtWK28eVQI3c3heA=;
        b=1kpW5DDariNGsZD0RnW/gqMqRujk9j1UbAHqgHxAG2jx29BLjqlkYNOWMIY3wtq179
         NrCrsbz2iml0vASGlIQwPbl8zCki9Oylgu5Bt/udjvH/DaPLZpgkeS5OdjfjNAj8HPki
         N3aixm5UPNZCYMPqCvMO/+9g2RSCfmyX9SOf6RlVXtprCCX+YepJvaBTppT/SQOwCOMw
         GbvxF8T2LQMnqxABkveOEqMmhTNorpI60ZrgpZ4guVLqQ+IF7SnwR9+2JVupPEiyrKbD
         exJu0u1mjHU5Ye2BW0rBYVP1mwWjUYoW3cwzFBj3fc1AaZY348dte/OFGFQ+EpMxBQXt
         wqlw==
X-Gm-Message-State: AOAM533SJbrYqKaJytcGXa2UD6DQyzTN+JTi+G22JwMPyOX81HpCbZ2h
        rOUW9uzMFHzInqoYd28Ew1/K+tl4t7eOVECL4DUj/g==
X-Google-Smtp-Source: ABdhPJxX0kLPKr0o/2eeORpJDihFBVHFMrz3nTWCVr7pfc4bJacymfdxecA+JsjRMzQ7UlX0Hc62p6Y4pmTsgEGbIUY=
X-Received: by 2002:a54:4506:: with SMTP id l6mr2210091oil.32.1638837448554;
 Mon, 06 Dec 2021 16:37:28 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Dec 2021 16:37:28 -0800
MIME-Version: 1.0
In-Reply-To: <20211206152844.1.I411110cc99c1dd66b01aa9aa25651acf8ff55da1@changeid>
References: <20211206152844.1.I411110cc99c1dd66b01aa9aa25651acf8ff55da1@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 6 Dec 2021 16:37:28 -0800
Message-ID: <CAE-0n50n=JZEqz5aQW4FQwjO9eFN56vTmBrQ6qBWduFY5jNPJA@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: dwc3-qcom: Avoid use-after-free when USB
 defers or unbinds
To:     Douglas Anderson <dianders@chromium.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>, robdclark@chromium.org,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Wesley Cheng <wcheng@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2021-12-06 15:28:47)
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

Is it a problem to remove and then add again? It moves it to the side
which means we may run out of memory?

>
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
>                 return -ENODEV;
>         }
>
> -       prop = devm_kzalloc(dev, sizeof(*prop), GFP_KERNEL);
> -       if (!prop) {
> -               ret = -ENOMEM;
> -               dev_err(dev, "unable to allocate memory for property\n");
> -               goto node_put;
> -       }
> +       /*
> +        * Permanently add the "tx-fifo-resize" to the device tree. Even if
> +        * our device is unregistered this property will still be part
> +        * of the device tree until reboot. Because this is a "permanent"
> +        * change, we allocate memory _without_ devm. For some context, see
> +        * the fact that of_remove_property() doesn't actually remove things.
> +        */
> +       if (!of_find_property(dwc3_np, "tx-fifo-resize", NULL)) {
> +               prop = kzalloc(sizeof(*prop), GFP_KERNEL);
> +               if (!prop) {
> +                       ret = -ENOMEM;
> +                       dev_err(dev, "unable to allocate memory for property\n");

Allocations already print a big error when they fail to allocate. Please
drop this error message.

> +                       goto node_put;
> +               }
>
> -       prop->name = "tx-fifo-resize";
> -       ret = of_add_property(dwc3_np, prop);

I don't understand why we can't tell dwc3 that we want to use
tx-fifo-resize without adding a DT property. DT isn't the only way we
could probe this qcom dwc3 device, there's also ACPI. And in dwc3 core
where we check for this property couldn't we add a compatible check for
qcom,dwc3 and then force the property? I see that a lot of this was
already discussed when these patches got applied by gregkh directly[1].

Can we revert out this bad code instead?

> -       if (ret) {
> -               dev_err(dev, "unable to add property\n");
> -               goto node_put;
> +               prop->name = "tx-fifo-resize";
> +               ret = of_add_property(dwc3_np, prop);

[1] https://lore.kernel.org/all/b5917fc0-c916-0a51-dc4c-315d7f02cafa@codeaurora.org/
