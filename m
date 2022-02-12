Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F7E4B385D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 23:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbiBLWXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 17:23:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiBLWXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 17:23:18 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2961960A83;
        Sat, 12 Feb 2022 14:23:13 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id q7so20805739wrc.13;
        Sat, 12 Feb 2022 14:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z/xqrL51N85XBNrEwvDN8cevgmcLTVWLKKWOEtCVrNA=;
        b=E9vMBJzoOtu5sPZ7UNue/B7UBgXaYwzrzUba8crHR/ceUX/DHvU1PZTOxIfc6CdnNp
         JvIvMqbzdO2udRyx3dbsz9SSDv6ealp8GHmr7DQTdoxHv+ACrdnfLYK9C3CqIh4SX8bP
         DZQPAUq8Tnf/TtN3+GRLF+oONpd9nCNZWAREWoQRc7id2N1vt0hH3ytiPZ4K6pX1bM+c
         NW0G9NE1dxUBOkNd0mFCXtJnKJYx7bREzIqvw1k1KUi8bGnObNGMrSuQLS/8Bzk1Norv
         ou30g/dC78kG8/lYK/m6VBbkKLa+BrN7cMP5XrensCGbdNre5rcezvb7SJgtmgaJOU7/
         VYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z/xqrL51N85XBNrEwvDN8cevgmcLTVWLKKWOEtCVrNA=;
        b=2Oog5VUJv6z93QAkkki739159h4ujptymfkzDAIIwFHO6dFyYbpuThg9zmHLZeOBdp
         Hdgy3xKXEn7v0jJV4FjiGXOYhyAuUWZf9sz8icDR7xb63/W1etB9e5cp0ca1PtYT101z
         B1YGavga9mH5PUosqK16A/LSODFlxzPGRUpoPIZKWK5Hj2O0o6PYzTYiN4n/ZoOoAIro
         aDkb07x+IJk44V6xrT2Me19eJXZS5vAGgoQj4RAah7sDcq5sPKIChNDESBh4sITiLNFl
         klSsLTu8LxmWh+lM6Qgx/X2qsQ/O036pOXIR8PM8jmGCT0dV7uJmByJcDfA3wSTo7LCo
         ebLg==
X-Gm-Message-State: AOAM533C/W+5Ew+XWlCBtnmTVM5qUANLu35M8Euwowchl1AB+aCuZ2P0
        E6fOwaAntKUEQssKjb5zFECJs20ua5nFd2v3+xX2m7NJ
X-Google-Smtp-Source: ABdhPJx7JTs2SnzMWP+954rm7QxCTDNXa1vYZo8Rm+io2S0QiQNfIspyiQMeSjUOUqbc3+AI04xUc6oJwKRGPRZDWjc=
X-Received: by 2002:a05:6000:1c11:: with SMTP id ba17mr5982580wrb.97.1644704591584;
 Sat, 12 Feb 2022 14:23:11 -0800 (PST)
MIME-Version: 1.0
References: <20220206014532.372109-1-andrew.smirnov@gmail.com> <50f25a22-09f4-0f9f-a6c4-4b8e7e238b13@synopsys.com>
In-Reply-To: <50f25a22-09f4-0f9f-a6c4-4b8e7e238b13@synopsys.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Sat, 12 Feb 2022 14:22:59 -0800
Message-ID: <CAHQ1cqG9S7onLCE=JRREDf4gZ68s3We+5GZv9cV7WgY-Vc4haA@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: Don't switch OTG -> peripheral if extcon is present
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 8, 2022 at 11:54 AM Thinh Nguyen <Thinh.Nguyen@synopsys.com> wrote:
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
> > and dwc3_drd_init() to be called later in dwc3_core_init_mode(). To
> > avoid always ignoring extcon device returned by dwc3_get_extcon()
> > modify the above check to also account for dwc->edev.
> >
>
> I think the commit message is a bit difficult to follow. Can we rephrase
> it to something like this:
>
> If the extcon device exists, get the mode from the extcon device. If the
> controller is DRD and the driver is unable to determine the mode, only
> then default the dr_mode to USB_DR_MODE_PERIPHERAL.
>

Sure, will do.

>
> > Cc: Felipe Balbi <balbi@kernel.org>
> > Cc: Thinh Nguyen <thinhn@synopsys.com>
> > Cc: linux-usb@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > ---
> >
> > Previous discussion:
> >
> > https://urldefense.com/v3/__https://lore.kernel.org/linux-usb/20220131192102.4115473-1-andrew.smirnov@gmail.com/__;!!A4F2R9G_pg!OlXelv3-qdUChbfoT9-Qttv4PH8DDro1dSzIj6xEN7x3Vkv8jeh8unvO4RvolUA$
> >
> >  drivers/usb/dwc3/core.c | 55 ++++++++++++++++++++++++++++++++++++++++-
> >  drivers/usb/dwc3/drd.c  | 50 -------------------------------------
> >  2 files changed, 54 insertions(+), 51 deletions(-)
> >
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index f2448d0a9d39..0ae152e47a00 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/dma-mapping.h>
> >  #include <linux/of.h>
> > +#include <linux/of_graph.h>
> >  #include <linux/acpi.h>
> >  #include <linux/pinctrl/consumer.h>
> >  #include <linux/reset.h>
> > @@ -84,7 +85,7 @@ static int dwc3_get_dr_mode(struct dwc3 *dwc)
> >                * mode. If the controller supports DRD but the dr_mode is not
> >                * specified or set to OTG, then set the mode to peripheral.
> >                */
> > -             if (mode == USB_DR_MODE_OTG &&
> > +             if (mode == USB_DR_MODE_OTG && !dwc->edev &&
> >                   (!IS_ENABLED(CONFIG_USB_ROLE_SWITCH) ||
> >                    !device_property_read_bool(dwc->dev, "usb-role-switch")) &&
> >                   !DWC3_VER_IS_PRIOR(DWC3, 330A))
> > @@ -1462,6 +1463,51 @@ static void dwc3_check_params(struct dwc3 *dwc)
> >       }
> >  }
> >
> > +static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
> > +{
> > +     struct device *dev = dwc->dev;
> > +     struct device_node *np_phy;
> > +     struct extcon_dev *edev = NULL;
> > +     const char *name;
> > +
> > +     if (device_property_read_bool(dev, "extcon"))
> > +             return extcon_get_edev_by_phandle(dev, 0);
> > +
> > +     /*
> > +      * Device tree platforms should get extcon via phandle.
> > +      * On ACPI platforms, we get the name from a device property.
> > +      * This device property is for kernel internal use only and
> > +      * is expected to be set by the glue code.
> > +      */
> > +     if (device_property_read_string(dev, "linux,extcon-name", &name) == 0) {
> > +             edev = extcon_get_extcon_dev(name);
> > +             if (!edev)
> > +                     return ERR_PTR(-EPROBE_DEFER);
> > +
> > +             return edev;
> > +     }
> > +
> > +     /*
> > +      * Try to get an extcon device from the USB PHY controller's "port"
> > +      * node. Check if it has the "port" node first, to avoid printing the
> > +      * error message from underlying code, as it's a valid case: extcon
> > +      * device (and "port" node) may be missing in case of "usb-role-switch"
> > +      * or OTG mode.
> > +      */
> > +     np_phy = of_parse_phandle(dev->of_node, "phys", 0);
> > +     if (of_graph_is_present(np_phy)) {
> > +             struct device_node *np_conn;
> > +
> > +             np_conn = of_graph_get_remote_node(np_phy, -1, -1);
> > +             if (np_conn)
> > +                     edev = extcon_find_edev_by_node(np_conn);
> > +             of_node_put(np_conn);
> > +     }
> > +     of_node_put(np_phy);
> > +
> > +     return edev;
> > +}
> > +
> >  static int dwc3_probe(struct platform_device *pdev)
> >  {
> >       struct device           *dev = &pdev->dev;
> > @@ -1561,6 +1607,13 @@ static int dwc3_probe(struct platform_device *pdev)
> >               goto err2;
> >       }
> >
> > +     dwc->edev = dwc3_get_extcon(dwc);
> > +     if (IS_ERR(dwc->edev)) {
> > +             ret = PTR_ERR(dwc->edev);
> > +             dev_err_probe(dwc->dev, ret, "failed to get extcon");
>
> add "\n" ?

Sure, will do.

>
> > +             goto err3;
> > +     }
> > +
> >       ret = dwc3_get_dr_mode(dwc);
> >       if (ret)
> >               goto err3;
> > diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
> > index e2b68bb770d1..9a414edc439a 100644
> > --- a/drivers/usb/dwc3/drd.c
> > +++ b/drivers/usb/dwc3/drd.c
> > @@ -8,7 +8,6 @@
> >   */
> >
> >  #include <linux/extcon.h>
> > -#include <linux/of_graph.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/property.h>
> >
> > @@ -438,51 +437,6 @@ static int dwc3_drd_notifier(struct notifier_block *nb,
> >       return NOTIFY_DONE;
> >  }
> >
> > -static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
> > -{
> > -     struct device *dev = dwc->dev;
> > -     struct device_node *np_phy;
> > -     struct extcon_dev *edev = NULL;
> > -     const char *name;
> > -
> > -     if (device_property_read_bool(dev, "extcon"))
> > -             return extcon_get_edev_by_phandle(dev, 0);
> > -
> > -     /*
> > -      * Device tree platforms should get extcon via phandle.
> > -      * On ACPI platforms, we get the name from a device property.
> > -      * This device property is for kernel internal use only and
> > -      * is expected to be set by the glue code.
> > -      */
> > -     if (device_property_read_string(dev, "linux,extcon-name", &name) == 0) {
> > -             edev = extcon_get_extcon_dev(name);
> > -             if (!edev)
> > -                     return ERR_PTR(-EPROBE_DEFER);
> > -
> > -             return edev;
> > -     }
> > -
> > -     /*
> > -      * Try to get an extcon device from the USB PHY controller's "port"
> > -      * node. Check if it has the "port" node first, to avoid printing the
> > -      * error message from underlying code, as it's a valid case: extcon
> > -      * device (and "port" node) may be missing in case of "usb-role-switch"
> > -      * or OTG mode.
> > -      */
> > -     np_phy = of_parse_phandle(dev->of_node, "phys", 0);
> > -     if (of_graph_is_present(np_phy)) {
> > -             struct device_node *np_conn;
> > -
> > -             np_conn = of_graph_get_remote_node(np_phy, -1, -1);
> > -             if (np_conn)
> > -                     edev = extcon_find_edev_by_node(np_conn);
> > -             of_node_put(np_conn);
> > -     }
> > -     of_node_put(np_phy);
> > -
> > -     return edev;
> > -}
> > -
> >  #if IS_ENABLED(CONFIG_USB_ROLE_SWITCH)
> >  #define ROLE_SWITCH 1
> >  static int dwc3_usb_role_switch_set(struct usb_role_switch *sw,
> > @@ -575,10 +529,6 @@ int dwc3_drd_init(struct dwc3 *dwc)
> >  {
> >       int ret, irq;
> >
> > -     dwc->edev = dwc3_get_extcon(dwc);
> > -     if (IS_ERR(dwc->edev))
> > -             return PTR_ERR(dwc->edev);
> > -
> >       if (ROLE_SWITCH &&
> >           device_property_read_bool(dwc->dev, "usb-role-switch")) {
> >               ret = dwc3_setup_role_switch(dwc);
> > --
> > 2.25.1
>
> Reviewed-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
>
> Thanks,
> Thinh
