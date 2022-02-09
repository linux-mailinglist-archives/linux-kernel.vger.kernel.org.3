Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2291E4AE5F0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 01:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbiBIAYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 19:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiBIAYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 19:24:06 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E73C06173B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 16:24:04 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id t14-20020a17090a3e4e00b001b8f6032d96so623724pjm.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 16:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=DYNXR2DtuxF1ISLzpPLoyEyGiOJ7sBlng/Jv7KiUcBE=;
        b=VxlJfskh25n9CGF6UK57dB54CJXlDoep5C3N0smYrTdby67X/6qk5Sk7HFgMDS+nGY
         AzoiVQXLD0zX8n/JzPWPnuoJP4lce+qxe7/XN61DoUql4/ek5ls0IMNRKeE94m0bm/gY
         cfT5FrbMtbIqBaACvO397ODwQRm/U6DIWtJ6dhWxc0WDClqqFyqNLeTFfHsevZWbE5q3
         cwzPNdId6TH00LMJppPQxBnP9hhTWODlnfeYkG/m3Ojtz4sIieW0oyczghQl9ZkyeB1T
         cdpt7CxfDkihd9SNrVTXaJx8ESUyXBr7GN+fbte3Yb50ycgG7mu3UVHP/0wuM8FLqbbg
         LlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=DYNXR2DtuxF1ISLzpPLoyEyGiOJ7sBlng/Jv7KiUcBE=;
        b=qYu6TWFZ3DS4k2Gs9Rs6hU72clnH/X3e0bQVl5DXvT45GUTUjzIPoNYzE8D9tF4L0n
         ZUmu08tkhRGK8tzldO7Zyp/ZHR2hpHQRy7hpKFe/Ep9XFe7O2I1+mW9wPWkMpDAUtraz
         6nQnZVdfKiKl2oMl7nUnGXW+LWgnLkJiCY824OQal2S35DLaQB5RrNHSC6mYpbQqR7Ib
         bFERu0mK5QvqVpvGaZRzquoneI8B9ZJui2+pfDlbgUdDvzje2YzSSXfvCsTCahGkAuzj
         QzzopVgKC//4pbPbHWMi9S9veBMcS7VKS587CaCcRBzaf3iAt0x2PindKPwAgCLs/UZH
         1nuQ==
X-Gm-Message-State: AOAM530nvwPY/jn37dHwM6ol/Tfupv9Ze3/46qw3Vp98T80fNpInmFWN
        miupWDQupSH3k4vqB/8E32CpBg/7+SXM5ulgXukFEPVnFE5h5A==
X-Google-Smtp-Source: ABdhPJxzWI7eHHDKAtjNbbB172grlY3cvC/rvaFNoMxSL6UiTPyvmxeEjwk9Pe8+ZkIlAhoSvpkKXJCpcc8WB5HAMV0=
X-Received: by 2002:a17:90a:5303:: with SMTP id x3mr64365pjh.64.1644366243349;
 Tue, 08 Feb 2022 16:24:03 -0800 (PST)
MIME-Version: 1.0
References: <20220202020103.2149130-1-rajatja@google.com>
In-Reply-To: <20220202020103.2149130-1-rajatja@google.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Tue, 8 Feb 2022 16:23:27 -0800
Message-ID: <CACK8Z6GmC7O3__RKwSEOQQ5Pde6h-LRz_5d+--V=CuB76cpe+w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PCI: Allow internal devices to be marked as untrusted
To:     Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
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

Hello Folks,


On Tue, Feb 1, 2022 at 6:01 PM Rajat Jain <rajatja@google.com> wrote:
>
> Today the pci_dev->untrusted is set for any devices sitting downstream
> an external facing port (determined via "ExternalFacingPort" or the
> "external-facing" properties).
>
> However, currently there is no way for internal devices to be marked as
> untrusted.
>
> There are use-cases though, where a platform would like to treat an
> internal device as untrusted (perhaps because it runs untrusted firmware
> or offers an attack surface by handling untrusted network data etc).
>
> Introduce a new "UntrustedDevice" property that can be used by the
> firmware to mark any device as untrusted.

Just to unite the threads (from
https://www.spinics.net/lists/linux-pci/msg120221.html). I did reach
out to Microsoft but they haven't acknowledged my email. I also pinged
them again yesterday, but I suspect I may not be able to break the
ice. So this patch may be ready to go in my opinion.

I don't see any outstanding comments on this patch, but please let me
know if you have any comments.

Thanks & Best Regards,

Rajat


>
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
> v2: * Also use the same property for device tree based systems.
>     * Add documentation (next patch)
>
>  drivers/pci/of.c       | 2 ++
>  drivers/pci/pci-acpi.c | 1 +
>  drivers/pci/pci.c      | 9 +++++++++
>  drivers/pci/pci.h      | 2 ++
>  4 files changed, 14 insertions(+)
>
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index cb2e8351c2cc..e8b804664b69 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -24,6 +24,8 @@ void pci_set_of_node(struct pci_dev *dev)
>                                                     dev->devfn);
>         if (dev->dev.of_node)
>                 dev->dev.fwnode = &dev->dev.of_node->fwnode;
> +
> +       pci_set_untrusted(dev);
>  }
>
>  void pci_release_of_node(struct pci_dev *dev)
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index a42dbf448860..2bffbd5c6114 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1356,6 +1356,7 @@ void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
>
>         pci_acpi_optimize_delay(pci_dev, adev->handle);
>         pci_acpi_set_external_facing(pci_dev);
> +       pci_set_untrusted(pci_dev);
>         pci_acpi_add_edr_notifier(pci_dev);
>
>         pci_acpi_add_pm_notifier(adev, pci_dev);
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 9ecce435fb3f..41e887c27004 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6869,3 +6869,12 @@ static int __init pci_realloc_setup_params(void)
>         return 0;
>  }
>  pure_initcall(pci_realloc_setup_params);
> +
> +void pci_set_untrusted(struct pci_dev *pdev)
> +{
> +       u8 val;
> +
> +       if (!device_property_read_u8(&pdev->dev, "UntrustedDevice", &val)
> +           && val)
> +               pdev->untrusted = 1;
> +}
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 3d60cabde1a1..6c273ce5e0ba 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -761,4 +761,6 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
>  }
>  #endif
>
> +void pci_set_untrusted(struct pci_dev *pdev);
> +
>  #endif /* DRIVERS_PCI_H */
> --
> 2.35.0.rc2.247.g8bbb082509-goog
>
