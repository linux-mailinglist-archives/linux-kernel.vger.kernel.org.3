Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29874A7E61
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 04:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349210AbiBCDhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 22:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235611AbiBCDhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 22:37:06 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EF0C061714;
        Wed,  2 Feb 2022 19:37:05 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id a13so2268704wrh.9;
        Wed, 02 Feb 2022 19:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mzQ5Ms+rGH8qdglrEgycDWVj4kG2JJqcskoCPStPG3I=;
        b=ILPt7CLQ75z9wHwxwK1UiSGd62Q+F+Mtd7jkVgHN35VlF+YKCQaXRNFpn67kdolGLj
         QMVx9XSwkcwvoyJxM8nYdY/ms7EtpAtum9IdP/RCxwTv9RBdy0YIut5IhPYtLE2j5c3f
         cL56y6QvNuKJAlOVoQb6p7W3xhZkmLMtKO2o/wGPS3vYACfaYdrtgOrXhdAZxvlQ8CNY
         jP77TN8caf8JXrgb10vflNYsaA6jGx20cmCXW/vTAEBLG3bHlKyXUH0gZZCY/zE50bjx
         R/UJo3/Jsn1He7GCEw1EZC2hWREJ6mF4Om6vPWTxptrM007Dt20fXzchisOmWRa5+opI
         g24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mzQ5Ms+rGH8qdglrEgycDWVj4kG2JJqcskoCPStPG3I=;
        b=X0Ei7e5DJ1dBCF3s1gfk7PYYYh7/xdsbXcvqF1vksLfLwH6BmHZ5AA0yp/oDANLfvF
         xjmZmoYrCMCjFIOwxaLRqtCgRSMIGRnrXcvgi4Ithpe0ifRaEFF3QkqAltH/fBwcvjU6
         3DF9CCh4l6jQXBqyUXTpittDFnF6cHBBG0VpdFOK5O2gZdCbIyRGfZce1493dPV7BBnw
         lgSu+NLuLTvm8+9eyShHMGCN8A69a7QG0WV8vK7JB4VxTYVa5UohjY1YAyHE7GJWQcK8
         ax0V55RXNtBTzjMOgXkVtaQxiC/6OI/Ns2DWGzMv4nVKHvGSyDO5fLo+Y99XewKWOI5D
         1fIw==
X-Gm-Message-State: AOAM533bLNVN0XzTKIDCWSTnKYSnBOeSKa2qovfUkkEN+801uWIetj/j
        tOHl6pG7R0HxK9vFsSCCDev+L3ERIyKJkJBUUgBkMw92APw=
X-Google-Smtp-Source: ABdhPJynktnQe5fOm9DQ5fRqSi5Mf0RiJ9rp/dtmnq0bQ5DW2tUlSt9iIKfpf1niIhYeAQDJtqZLOhzBCk+b9sKCrN4=
X-Received: by 2002:adf:dcc1:: with SMTP id x1mr26682684wrm.289.1643859424102;
 Wed, 02 Feb 2022 19:37:04 -0800 (PST)
MIME-Version: 1.0
References: <20220131192102.4115473-1-andrew.smirnov@gmail.com> <e0e36d42-5479-fd8c-3868-384161031738@synopsys.com>
In-Reply-To: <e0e36d42-5479-fd8c-3868-384161031738@synopsys.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Wed, 2 Feb 2022 19:36:53 -0800
Message-ID: <CAHQ1cqHUNtO_S5NnmdBmhba5+S8pOArA00G2eBXeWLo5smjPxQ@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: Prioritize extcon over USB role switching API
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 2, 2022 at 6:54 PM Thinh Nguyen <Thinh.Nguyen@synopsys.com> wrote:
>
> Andrey Smirnov wrote:
> > It is necessary that:
> >
> >    ROLE_SWITCH && device_property_read_bool(dwc->dev, "usb-role-switch")
> >
> > is true in order for dwc3_get_dr_mode() to _not_ force us from OTG to
> > PERIPHERAL mode here:
> >
> >    if (mode == USB_DR_MODE_OTG &&
> >        (!IS_ENABLED(CONFIG_USB_ROLE_SWITCH) ||
> >         !device_property_read_bool(dwc->dev, "usb-role-switch")) &&
> >       !DWC3_VER_IS_PRIOR(DWC3, 330A))
> >       mode = USB_DR_MODE_PERIPHERAL;
> >
> > and dwc3_drd_init() to be called later in dwc3_core_init_mode(). So,
> > to avoid always ignoring extcon device returned by dwc3_get_extcon()
> > change dwc3_drd_init() to check and use it first, before checking if
> > dwc3_setup_role_switch() should be called.
> >
> > Cc: Felipe Balbi <balbi@kernel.org>
> > Cc: Thinh Nguyen <thinhn@synopsys.com>
> > Cc: linux-usb@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > ---
> >
> > Hopefully I didn't miss something important making this patch
> > unnecessary. Don't know if this is a good solution or not, part of me
> > thinks than maybe changing the aforementioned code in
> > dwc3_get_dr_mode() to account for extcon wopuld be
> > simpler/better. Happy to rework this.
>
> The driver either use extcon or usb-role-switch. It doesn't make sense to
> enable usb-role-switch for extcon just so the driver doesn't default
> the dr_mode to peripheral.
>
> Perhaps, this is what you're looking for? (code is not tested)
>

Yeah that kind of what I meant by "maybe changing the aforementioned code in
dwc3_get_dr_mode() to account for extcon wopuld be
simpler/better." OK let me rework the patch to do that.

> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index bffd719b8b52..a52331ea7a0d 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -86,7 +86,7 @@ static int dwc3_get_dr_mode(struct dwc3 *dwc)
>                  * mode. If the controller supports DRD but the dr_mode is not
>                  * specified or set to OTG, then set the mode to peripheral.
>                  */
> -               if (mode == USB_DR_MODE_OTG &&
> +               if (mode == USB_DR_MODE_OTG && !dwc->edev &&
>                     (!IS_ENABLED(CONFIG_USB_ROLE_SWITCH) ||
>                      !device_property_read_bool(dwc->dev, "usb-role-switch")) &&
>                     !DWC3_VER_IS_PRIOR(DWC3, 330A))
> @@ -1715,6 +1715,13 @@ static int dwc3_probe(struct platform_device *pdev)
>                 goto err2;
>         }
>
> +       dwc->edev = dwc3_get_extcon(dwc);
> +       if (IS_ERR(dwc->edev)) {
> +               ret = PTR_ERR(dwc->edev);
> +               dev_err(dwc->dev, "failed to get extcon %d\n", ret);
> +               goto err3;
> +       }
> +
>         ret = dwc3_get_dr_mode(dwc);
>         if (ret)
>                 goto err3;
> diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
> index 63089c7fb530..d02fcfdc74db 100644
> --- a/drivers/usb/dwc3/drd.c
> +++ b/drivers/usb/dwc3/drd.c
> @@ -585,16 +585,7 @@ int dwc3_drd_init(struct dwc3 *dwc)
>  {
>         int ret, irq;
>
> -       dwc->edev = dwc3_get_extcon(dwc);
> -       if (IS_ERR(dwc->edev))
> -               return PTR_ERR(dwc->edev);
> -
> -       if (ROLE_SWITCH &&
> -           device_property_read_bool(dwc->dev, "usb-role-switch")) {
> -               ret = dwc3_setup_role_switch(dwc);
> -               if (ret < 0)
> -                       return ret;
> -       } else if (dwc->edev) {

We probably don't even need to move this around. If "usb-role-switch"
isn't going to be set then that "if" could go first and not interfere.

> +       if (dwc->edev) {
>                 dwc->edev_nb.notifier_call = dwc3_drd_notifier;
>                 ret = extcon_register_notifier(dwc->edev, EXTCON_USB_HOST,
>                                                &dwc->edev_nb);
> @@ -604,6 +595,11 @@ int dwc3_drd_init(struct dwc3 *dwc)
>                 }
>
>                 dwc3_drd_update(dwc);
> +       } else if (ROLE_SWITCH &&
> +                  device_property_read_bool(dwc->dev, "usb-role-switch")) {
> +               ret = dwc3_setup_role_switch(dwc);
> +               if (ret < 0)
> +                       return ret;
>         } else {
>                 dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_OTG);
>
>
