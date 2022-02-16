Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6B94B812E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 08:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiBPHRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 02:17:12 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiBPHRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:17:08 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD94C1141;
        Tue, 15 Feb 2022 23:16:52 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id e6so1426670vsa.8;
        Tue, 15 Feb 2022 23:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=q/fqjdbDD2fyY7moizdQvW5LN8SHN1B18vYdIVedr2w=;
        b=lp4WomsRpPzMzCV/F2J6D885OSY301v5mrj611CFTqGbzXRTf+SOBP2PYLYgRC9yUa
         WHIOS/IaZpxaWjwMyQNPP/9enFryKTvsQ0ZMikeEusLJA0mZ/LlWh7KlRi10hz8Z+RIL
         GznNlJKDuCITsaNcZvzAxeMUIoGnrF4YfIXqanmI/2ZO19eRR7XLy89qEyHoFVhp/9Qg
         SeJezPoz026JuHNhAkvI+OuDnyNA8WLJK/hPCBNkXcAM7M7psQ9IQHuCgkvgYToCgeiC
         PehWZyz96DUuVYvnaIVQPDTjFoAX0pXwtgBSGevn4WmxIeP4hn0EfLocbzNVnKg3CkO1
         qRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q/fqjdbDD2fyY7moizdQvW5LN8SHN1B18vYdIVedr2w=;
        b=3R3/jcUkl6qwjTcCaC0HnwP//4iN74ndUsQWa/mKP6n8NGgT0m/7rQRTIMsAnQN/LF
         fYmKTVodbJwZvXkwmfv6jixHrtZU8GCjNwi3v7cIpcXnEuijeFveGSz1uipnXPsJy790
         HafaGGUnGwVkkaPvsn3M1EJXgW/0W6fgjl0/Ixhw53KMJ6wYRq/tgXggVsJAtPM4VRtO
         fOp5lwMukvJzOWNPHRU/uGS5lDQQKbAE68iS1FOcsgCzeoTh/4Yjv3mVZInInsV5ytYh
         iZS0Tnm7upUFNV4rz/jTdN+gY4ZBclprJ8K71zct/Kn4dUjEg3NrwcomoViLqRX8+xn3
         CB1g==
X-Gm-Message-State: AOAM532YG0jaAi49DDqbxAj8nPq5qUR7j9f/vLk/XZyqKmrbD2ZHYKSw
        krNcdG/e0xsj08nMqB2LU4qfnFeH7hu98w1glkE=
X-Google-Smtp-Source: ABdhPJwkuPRp9kDdAIfjm6S9WYhpNKDD1u0NOmPXCGk5CMYW9JB8JYSJ0QQwATAMp2BprXSLKzO08xHwljc4VfAujKc=
X-Received: by 2002:a05:6102:74c:b0:31b:a815:a83b with SMTP id
 v12-20020a056102074c00b0031ba815a83bmr480903vsg.17.1644995811769; Tue, 15 Feb
 2022 23:16:51 -0800 (PST)
MIME-Version: 1.0
References: <1644949454-814-1-git-send-email-quic_c_sanm@quicinc.com> <1644949454-814-3-git-send-email-quic_c_sanm@quicinc.com>
In-Reply-To: <1644949454-814-3-git-send-email-quic_c_sanm@quicinc.com>
From:   Jun Li <lijun.kernel@gmail.com>
Date:   Wed, 16 Feb 2022 15:16:40 +0800
Message-ID: <CAKgpwJWEZ7275LihHqxg50cWNVNxUcGR8e7pM-V2bH=aodL7YA@mail.gmail.com>
Subject: Re: [PATCH 2/2] usb: dwc: host: add xhci_plat_priv quirk XHCI_SKIP_PHY_INIT
To:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Cc:     Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sandeep Maheswaram <quic_c_sanm@quicinc.com> =E4=BA=8E2022=E5=B9=B42=E6=9C=
=8816=E6=97=A5=E5=91=A8=E4=B8=89 14:58=E5=86=99=E9=81=93=EF=BC=9A
>
> dwc3 manages PHY by own DRD driver, so skip the management by
> HCD core.
> During runtime suspend phy was not getting suspend because
> runtime_usage value is 2.
>
> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> ---
>  drivers/usb/dwc3/host.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
> index eda8719..4a035a8 100644
> --- a/drivers/usb/dwc3/host.c
> +++ b/drivers/usb/dwc3/host.c
> @@ -13,6 +13,14 @@
>  #include <linux/platform_device.h>
>
>  #include "core.h"
> +#include <linux/usb/hcd.h>
> +#include <linux/usb/xhci-plat.h>
> +#include <linux/usb/xhci-quirks.h>
> +
> +
> +static const struct xhci_plat_priv xhci_plat_dwc3_xhci =3D {
> +       .quirks =3D XHCI_SKIP_PHY_INIT,
> +};

It's better to create this xhci_plat_priv by each dwc3 glue layer,
with that, we can use this priv to pass other flags and possibly
override APIs by each glue driver which may not apply to all dwc3
platforms.

thanks
Li Jun
>
>  static void dwc3_host_fill_xhci_irq_res(struct dwc3 *dwc,
>                                         int irq, char *name)
> @@ -122,6 +130,13 @@ int dwc3_host_init(struct dwc3 *dwc)
>                 }
>         }
>
> +       ret =3D platform_device_add_data(xhci, &xhci_plat_dwc3_xhci,
> +                       sizeof(struct xhci_plat_priv));
> +       if (ret) {
> +               dev_err(dwc->dev, "failed to add data to xHCI\n");
> +               goto err;
> +       }
> +
>         ret =3D platform_device_add(xhci);
>         if (ret) {
>                 dev_err(dwc->dev, "failed to register xHCI device\n");
> --
> 2.7.4
>
