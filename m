Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E28E4AFFDC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 23:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbiBIWEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 17:04:16 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbiBIWEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:04:12 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD80BE010DBE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 14:04:10 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id t14-20020a17090a3e4e00b001b8f6032d96so3669488pjm.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 14:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xNzkFtkEdwS4V5xuimABsw6tYvmcHWMu0L6uE58HPK4=;
        b=kyxSH/1s4tYkpnIvrk1pCVVHvuka0Iv2uFFyhp9uZb0aans0RzfOy3BkDicIzvpIK2
         JZ+AInXaf/dEUAOlK2atr40Ts389WYvQGH1Iw96AZ1SFqT1j4ADLygKvmII//Yw6WSq0
         1ZztH/K36DxhmzhYbKgN7gkepOJvdyMan3uZz8JP3RBDwsE3mZ3ABC+VnPzYAI08zOkn
         JX6p7qgUTG4FbF0Q/KazCCYn0vfox4zeNuxNgGWuoQJp0sXTZmeP6Wj4GZXH8yRWt5bP
         7j8sps3kN/wCna3m6wFG2i5r2m9G2x5j8DF1WZrhxmKarKilBeUF8EVrQGaqOa90iawA
         HXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xNzkFtkEdwS4V5xuimABsw6tYvmcHWMu0L6uE58HPK4=;
        b=DqclZDT9MxmcgItKQJFbd4ovMX+lfQaMFhT+YhuAivTKN8k2xnKEZLwY6bY2TucK6L
         sOLiOhI66DTq4WC2ieAFzm+PR7ue8eXnKJ96pe22jjMNKGRGRwbgH1b685oGBD1yAMdU
         9AFjgloFt6f3Ocs8RMopmdGu4O2IPG7rJyBxsdLYrsUNos8Vh0Ezd3hyH4/FN+uiZPE4
         hH0HlTxAdV4K605DwH/yLkSz4Ir/pr0nZnDp2PXE3PKXW6UvWPyOvA7x0PsKIV+XVbsV
         mSrJAtsECrn9bUxg7VSpooZFVTb612uY18MW+FPa6s+0QXwA2JEKYTsImUAFeJwpuWfR
         o6tg==
X-Gm-Message-State: AOAM533ZYwJv5/abP3AEkui6fA/sl2KagrfIxGSHDp3J7nMXINe2oZVI
        Nhd+ayZIVDHeoHN5zgtO9VjIawkA8oFg3pc4kOgqXA==
X-Google-Smtp-Source: ABdhPJzKcnRRg0t0lBD/tELh3a75+sefe9RuAfwBe6PnjfwaIkNK+e/1Tl5ywaXWSkPidjxFSWHXiHZ7scaZX+zDe+s=
X-Received: by 2002:a17:90a:5303:: with SMTP id x3mr5254322pjh.64.1644444249918;
 Wed, 09 Feb 2022 14:04:09 -0800 (PST)
MIME-Version: 1.0
References: <20220202020103.2149130-1-rajatja@google.com> <CAJZ5v0gngVxoe88rNAXXK_F34rHAKuxokiuZ6kpg6FhbnyMn0Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0gngVxoe88rNAXXK_F34rHAKuxokiuZ6kpg6FhbnyMn0Q@mail.gmail.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Wed, 9 Feb 2022 14:03:34 -0800
Message-ID: <CACK8Z6FuOeVwxh=Psn2HnG_HemndSLV9yq4xyX=JS2HkyaQ+fA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PCI: Allow internal devices to be marked as untrusted
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Len Brown <lenb@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Dmitry Torokhov <dtor@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Pavel Machek <pavel@denx.de>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Feb 9, 2022 at 11:11 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Feb 2, 2022 at 3:01 AM Rajat Jain <rajatja@google.com> wrote:
> >
> > Today the pci_dev->untrusted is set for any devices sitting downstream
> > an external facing port (determined via "ExternalFacingPort" or the
> > "external-facing" properties).
> >
> > However, currently there is no way for internal devices to be marked as
> > untrusted.
> >
> > There are use-cases though, where a platform would like to treat an
> > internal device as untrusted (perhaps because it runs untrusted firmware
> > or offers an attack surface by handling untrusted network data etc).
> >
> > Introduce a new "UntrustedDevice" property that can be used by the
> > firmware to mark any device as untrusted.
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > ---
> > v2: * Also use the same property for device tree based systems.
> >     * Add documentation (next patch)
> >
> >  drivers/pci/of.c       | 2 ++
> >  drivers/pci/pci-acpi.c | 1 +
> >  drivers/pci/pci.c      | 9 +++++++++
> >  drivers/pci/pci.h      | 2 ++
> >  4 files changed, 14 insertions(+)
> >
> > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > index cb2e8351c2cc..e8b804664b69 100644
> > --- a/drivers/pci/of.c
> > +++ b/drivers/pci/of.c
> > @@ -24,6 +24,8 @@ void pci_set_of_node(struct pci_dev *dev)
> >                                                     dev->devfn);
> >         if (dev->dev.of_node)
> >                 dev->dev.fwnode = &dev->dev.of_node->fwnode;
> > +
> > +       pci_set_untrusted(dev);
> >  }
> >
> >  void pci_release_of_node(struct pci_dev *dev)
> > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > index a42dbf448860..2bffbd5c6114 100644
> > --- a/drivers/pci/pci-acpi.c
> > +++ b/drivers/pci/pci-acpi.c
> > @@ -1356,6 +1356,7 @@ void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
> >
> >         pci_acpi_optimize_delay(pci_dev, adev->handle);
> >         pci_acpi_set_external_facing(pci_dev);
> > +       pci_set_untrusted(pci_dev);
> >         pci_acpi_add_edr_notifier(pci_dev);
> >
> >         pci_acpi_add_pm_notifier(adev, pci_dev);
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 9ecce435fb3f..41e887c27004 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -6869,3 +6869,12 @@ static int __init pci_realloc_setup_params(void)
> >         return 0;
> >  }
> >  pure_initcall(pci_realloc_setup_params);
> > +
> > +void pci_set_untrusted(struct pci_dev *pdev)
> > +{
> > +       u8 val;
> > +
> > +       if (!device_property_read_u8(&pdev->dev, "UntrustedDevice", &val)
> > +           && val)
> > +               pdev->untrusted = 1;
>
> I'm not sure why you ignore val = 0.  Is it not a valid value?

I'm following the other similar properties that Bjorn mentioned. The
pdev->untrusted is already initialized to 0 so it wouldn't matter.

>
> The property is not particularly well defined here.  It is not clear
> from its name that it only applies to PCI devices and how.
>
> AFAICS, the "untrusted" bit affected by it is only used by the ATS
> code and in one PCH ACS quirk, but I'm not sure if this is all you
> have in mind.

I hope my other response addressed this one.

Thanks & Best Regards,

Rajat

>
> > +}
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index 3d60cabde1a1..6c273ce5e0ba 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -761,4 +761,6 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
> >  }
> >  #endif
> >
> > +void pci_set_untrusted(struct pci_dev *pdev);
> > +
> >  #endif /* DRIVERS_PCI_H */
> > --
> > 2.35.0.rc2.247.g8bbb082509-goog
> >
