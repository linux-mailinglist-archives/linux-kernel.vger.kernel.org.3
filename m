Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735774B7D51
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 03:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238422AbiBPCPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 21:15:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbiBPCPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 21:15:37 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CF5F461E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 18:15:26 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id e19-20020a4ab993000000b0031a98fe3a9dso288890oop.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 18:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=M7OCdt9OzJxfB2Eo4t5fobnAZWbhP5SYktbi2Ug/8kQ=;
        b=P6PKoHakA6KYKz3cdvpY0YVGXknfuiYcdWALAvEgODfjlyyz9V2N2Qb+RA/j57AqC5
         MyDHHo+SFf8ceLcBfKsrx1sUSZWZYE75EpkTtv9vvuxiGNR9REIUwJFV9Aj262rh1A64
         UJl8/iQXseryz4zkOzIRF9PdKjwtCIG8ztnxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=M7OCdt9OzJxfB2Eo4t5fobnAZWbhP5SYktbi2Ug/8kQ=;
        b=vsC79e7r3T35i5L2SpVMu30VO70i0XMbVb8JVts3n3IT4++GSRfexMLoVNHWDPFIxl
         H7/3bHGqt30+g1IvVuHj4lneEwwOpObKo/3NjqAgxZ9ZkD2pVgYAWTiE4gycunZdbLUr
         ALI2BPG6qELBdCw87PUlZkVDGu2bQXYg4CTtB4KU06iNixQrcS6A3EKMs7ihDHNJ1kva
         CDAerAdmhBTQ2oBPzK2RzKWCKxMGqGHhMefzHfxpiRoZ1YH/Nx8Tjz1AK9lhV7DZxhGV
         RI9jy4s58J65a/ByJiyle2vijrYze/gp2TyFkBEMU9OZ59ZCm5hy2iD8TzHdFz1lEDoJ
         yp6Q==
X-Gm-Message-State: AOAM531MBu6QEmFIybLuVb3Sztd+TbG4vTJcgtTkJ89NI8M9UOHiFGDp
        2hw3SALsZ1A8bJDxQJ/DvGshUE1mHT7+gbh9+AUSxg==
X-Google-Smtp-Source: ABdhPJzPATiuExoyJI2H1AD/d5xpqqZ+VPI/gySpnVVnoVd6/9h8G/2Com+9XnHedjC/slziZx/LKHdClY23tEw+INo=
X-Received: by 2002:a05:6870:5829:b0:c8:9f42:f919 with SMTP id
 r41-20020a056870582900b000c89f42f919mr296465oap.54.1644977725284; Tue, 15 Feb
 2022 18:15:25 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Feb 2022 18:15:24 -0800
MIME-Version: 1.0
In-Reply-To: <1644949454-814-3-git-send-email-quic_c_sanm@quicinc.com>
References: <1644949454-814-1-git-send-email-quic_c_sanm@quicinc.com> <1644949454-814-3-git-send-email-quic_c_sanm@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 15 Feb 2022 18:15:24 -0800
Message-ID: <CAE-0n52WuP68V6jCs1oBud3Tj08TUSXkdSVRNu327EqVprEN8g@mail.gmail.com>
Subject: Re: [PATCH 2/2] usb: dwc: host: add xhci_plat_priv quirk XHCI_SKIP_PHY_INIT
To:     Aswath Govindraju <a-govindraju@ti.com>,
        Doug Anderson <dianders@chromium.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sandeep Maheswaram (2022-02-15 10:24:14)
> dwc3 manages PHY by own DRD driver, so skip the management by
> HCD core.
> During runtime suspend phy was not getting suspend because
> runtime_usage value is 2.
>
> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>

Any Fixes tag?

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

What is this include used for now?

> +#include <linux/usb/xhci-plat.h>
> +#include <linux/usb/xhci-quirks.h>
> +
> +

Nitpick: Remove one newline.

> +static const struct xhci_plat_priv xhci_plat_dwc3_xhci = {
> +       .quirks = XHCI_SKIP_PHY_INIT,
> +};
>
>  static void dwc3_host_fill_xhci_irq_res(struct dwc3 *dwc,
>                                         int irq, char *name)
> @@ -122,6 +130,13 @@ int dwc3_host_init(struct dwc3 *dwc)
>                 }
>         }
>
> +       ret = platform_device_add_data(xhci, &xhci_plat_dwc3_xhci,
> +                       sizeof(struct xhci_plat_priv));

Nitpick: sizeof(xhci_plat_dwc3_xhci) so the type can change without
changing this line.

> +       if (ret) {
> +               dev_err(dwc->dev, "failed to add data to xHCI\n");
> +               goto err;
> +       }
> +
>         ret = platform_device_add(xhci);
>         if (ret) {
>                 dev_err(dwc->dev, "failed to register xHCI device\n");
