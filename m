Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9FF486B83
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 22:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244055AbiAFVA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 16:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244010AbiAFVA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 16:00:26 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3AFC061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 13:00:26 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id p65so4692776iof.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 13:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AmzdgAiuO/8SZ4ChbNLcS7C9Wx3iWh+y/OvXPCFKxrw=;
        b=bF0zHrf6cn7DZ9x7Pn4rON78LlB/Hv4SZOT1CUj/MS6/n3ZRZRuCOzw38oA9zXUnUq
         bmPYvez6eiYkBvk7XWVrAWDC9k/UQm1G+UlfndAwfmWfa9a8OmebJf30pHRvKVOH7vLs
         jt6bGvG2Aqd9ZHc94cDDGoxmgy4g8E5zyYL9iT0hbk68Fbwp9h6N8bAzGBvI8eheAF4z
         FcEVNjkDqF28luZRsiDiFQOfedRFwy+Cm991Ddau75kShcGF2h70VZ4zhwsPu2abAa0c
         bafGpZZYjVq8h0wtrhrDmHrDlIiTeia1yeNt14TfbkApq+o7nqg88SGsPY1GhFNAVaZV
         RgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AmzdgAiuO/8SZ4ChbNLcS7C9Wx3iWh+y/OvXPCFKxrw=;
        b=bFsH37ONWXG+3tk2stl8YrX2ZYAthSROLFFrayN2D2gzDQw7uP8wKrvaiSitA22sBA
         8cQSKJX5nPUtCLu321kalCP/7mzrGAypKTUft/fhMUtsU2PTiUuMcQVyxt8aTxjkg/ML
         7lxu907rGJvt9rk0SHLghiH35ok8yWCJAly5EXlC4mVn4X2l0K3HemM4Tz+TyR0X1Hc/
         tiwumAtCU9iNXBJMUq9zevYgsE47FMlpR6BOB6ruIOEriQagKz4b4y+ku3KYCZEmkA6e
         KL7ElsAHiMV8I6M9dHGzO8iqofsF74JN81xQFcTQ6g3EviJhOwYYApt96R/7KMpc81MB
         DFCQ==
X-Gm-Message-State: AOAM533KwhW90+zX2Al5jTQ09GIYoJ3ZCtjBE1n7ELJH33Ri5FaCMTZW
        eGy93Ka/rCJ3POJ4E4n0qj69SaCXf9Ux37OVur4=
X-Google-Smtp-Source: ABdhPJyMPlDYOazAJHlrg63PALPvUxYHWGsXkLSVu4lQmb//VCulO817Wx8LlBVYawaWZLOwDu/PsbsVmaBAVu8/IEM=
X-Received: by 2002:a05:6638:33a6:: with SMTP id h38mr28475446jav.194.1641502825423;
 Thu, 06 Jan 2022 13:00:25 -0800 (PST)
MIME-Version: 1.0
References: <20211201180653.35097-1-alcooperx@gmail.com> <20211201180653.35097-2-alcooperx@gmail.com>
 <YahNIinbEwB569C1@matsya>
In-Reply-To: <YahNIinbEwB569C1@matsya>
From:   Alan Cooper <alcooperx@gmail.com>
Date:   Thu, 6 Jan 2022 16:01:53 -0500
Message-ID: <CAOGqxeVS0sQg=vAQKOC3ksuGfdCO-TzgMdOmhtQJZBcuj3YFdg@mail.gmail.com>
Subject: Re: [PATCH 1/3] phy: usb: Leave some clocks running during suspend
To:     Vinod Koul <vkoul@kernel.org>
Cc:     ": Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 1, 2021 at 11:35 PM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 01-12-21, 13:06, Al Cooper wrote:
> > The PHY client driver does a phy_exit() call on suspend or rmmod and
> > the PHY driver needs to know the difference because some clocks need
> > to be kept running for suspend but can be shutdown on unbind/rmmod
> > (or if there are no PHY clients at all).
> >
> > The fix is to use a PM notifier so the driver can tell if a PHY
> > client is calling exit() because of a system suspend or a driver
> > unbind/rmmod.
> >
> > Signed-off-by: Al Cooper <alcooperx@gmail.com>
> > ---
> >  drivers/phy/broadcom/phy-brcm-usb.c | 38 +++++++++++++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> >
> > diff --git a/drivers/phy/broadcom/phy-brcm-usb.c b/drivers/phy/broadcom/phy-brcm-usb.c
> > index 116fb23aebd9..0f1deb6e0eab 100644
> > --- a/drivers/phy/broadcom/phy-brcm-usb.c
> > +++ b/drivers/phy/broadcom/phy-brcm-usb.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/soc/brcmstb/brcmstb.h>
> >  #include <dt-bindings/phy/phy.h>
> >  #include <linux/mfd/syscon.h>
> > +#include <linux/suspend.h>
> >
> >  #include "phy-brcm-usb-init.h"
> >
> > @@ -70,12 +71,35 @@ struct brcm_usb_phy_data {
> >       int                     init_count;
> >       int                     wake_irq;
> >       struct brcm_usb_phy     phys[BRCM_USB_PHY_ID_MAX];
> > +     struct notifier_block   pm_notifier;
> > +     bool                    pm_active;
> >  };
> >
> >  static s8 *node_reg_names[BRCM_REGS_MAX] = {
> >       "crtl", "xhci_ec", "xhci_gbl", "usb_phy", "usb_mdio", "bdc_ec"
> >  };
> >
> > +static int brcm_pm_notifier(struct notifier_block *notifier,
> > +                         unsigned long pm_event,
> > +                         void *unused)
> > +{
> > +     struct brcm_usb_phy_data *priv =
> > +             container_of(notifier, struct brcm_usb_phy_data, pm_notifier);
> > +
> > +     switch (pm_event) {
> > +     case PM_HIBERNATION_PREPARE:
> > +     case PM_SUSPEND_PREPARE:
> > +             priv->pm_active = true;
> > +             break;
> > +     case PM_POST_RESTORE:
> > +     case PM_POST_HIBERNATION:
> > +     case PM_POST_SUSPEND:
> > +             priv->pm_active = false;
> > +             break;
> > +     }
> > +     return NOTIFY_DONE;
> > +}
> > +
> >  static irqreturn_t brcm_usb_phy_wake_isr(int irq, void *dev_id)
> >  {
> >       struct phy *gphy = dev_id;
> > @@ -91,6 +115,9 @@ static int brcm_usb_phy_init(struct phy *gphy)
> >       struct brcm_usb_phy_data *priv =
> >               container_of(phy, struct brcm_usb_phy_data, phys[phy->id]);
> >
> > +     if (priv->pm_active)
> > +             return 0;
> > +
> >       /*
> >        * Use a lock to make sure a second caller waits until
> >        * the base phy is inited before using it.
> > @@ -120,6 +147,9 @@ static int brcm_usb_phy_exit(struct phy *gphy)
> >       struct brcm_usb_phy_data *priv =
> >               container_of(phy, struct brcm_usb_phy_data, phys[phy->id]);
> >
> > +     if (priv->pm_active)
> > +             return 0;
> > +
> >       dev_dbg(&gphy->dev, "EXIT\n");
> >       if (phy->id == BRCM_USB_PHY_2_0)
> >               brcm_usb_uninit_eohci(&priv->ini);
> > @@ -488,6 +518,9 @@ static int brcm_usb_phy_probe(struct platform_device *pdev)
> >       if (err)
> >               return err;
> >
> > +     priv->pm_notifier.notifier_call = brcm_pm_notifier;
> > +     register_pm_notifier(&priv->pm_notifier);
> > +
> >       mutex_init(&priv->mutex);
> >
> >       /* make sure invert settings are correct */
> > @@ -528,7 +561,10 @@ static int brcm_usb_phy_probe(struct platform_device *pdev)
> >
> >  static int brcm_usb_phy_remove(struct platform_device *pdev)
> >  {
> > +     struct brcm_usb_phy_data *priv = dev_get_drvdata(&pdev->dev);
> > +
> >       sysfs_remove_group(&pdev->dev.kobj, &brcm_usb_phy_group);
> > +     unregister_pm_notifier(&priv->pm_notifier);
> >
> >       return 0;
> >  }
> > @@ -539,6 +575,7 @@ static int brcm_usb_phy_suspend(struct device *dev)
> >       struct brcm_usb_phy_data *priv = dev_get_drvdata(dev);
> >
> >       if (priv->init_count) {
> > +             dev_dbg(dev, "SUSPEND\n");
>
> debug artifact?
>
> >               priv->ini.wake_enabled = device_may_wakeup(dev);
> >               if (priv->phys[BRCM_USB_PHY_3_0].inited)
> >                       brcm_usb_uninit_xhci(&priv->ini);
> > @@ -578,6 +615,7 @@ static int brcm_usb_phy_resume(struct device *dev)
> >        * Uninitialize anything that wasn't previously initialized.
> >        */
> >       if (priv->init_count) {
> > +             dev_dbg(dev, "RESUME\n");
>
> here too

I left these in intentionally because they are very useful for debug.

>
> >               if (priv->wake_irq >= 0)
> >                       disable_irq_wake(priv->wake_irq);
> >               brcm_usb_init_common(&priv->ini);
> > --
> > 2.17.1
>
> --
> ~Vinod
