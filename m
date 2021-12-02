Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502EA466B7A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 22:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377007AbhLBVU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 16:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377001AbhLBVUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 16:20:52 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123E0C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 13:17:29 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id o20so3137794eds.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 13:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P2iWvtbr9pqgIEuVK04x303diGFgnHSqLQi4xECoLUM=;
        b=YK/b7sezd1nJYm7+fptD8CVREinlgEWmjTJK1hGDewOTOtPO1WaIDExiffTvFlna9f
         lpfmqrub1G65ady/hjJ3Azk98dWyK59mNfEvvMQW1VDHsfI+8tMlH7Nl7PdsWJFS97yE
         Ry47OXjI67QDMTPbOEC8WBu/j0J/XgMuX/HOvomkfFJAKkWITnANhh5xZe9oOdZavfSt
         3Qx7pAU4WSDB3rViqSXNuZaS0IeZjIlu8jhYgFtALdYEsre235ivCxDC8uqx2sL5Wi5M
         W4z8SReKQDPkzWHyTJdSSpysRQ6S5Uk9BJWPM5YAQP9HoM2S8UVFK55Bh0yOMyD1ft9V
         hvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P2iWvtbr9pqgIEuVK04x303diGFgnHSqLQi4xECoLUM=;
        b=iNuaFzKO+Tjhb1Pr4cMIQ4n7zYJUQsZOMPRXanDQCkAO/IGuKcdljS7td5oj+9Kueh
         CbPtysLjC25JaZRrTSHqymHFst5dvqK+ZLNUFqmdLmtFPXgLsW06S3USv/9ooWUuTwML
         BL0MoEp6Y1dc9QRikjAbt7tgFooHnqR7BoOdIFiXGmNTtpjjwX3fLPuqVT8EWHdoKBPP
         0cfaeZddmMFd9D+T2Lx4AeuTuJckBFLXiyN0ptCG911K+niiNJTVp4gLfAZ5BtCi5Dlu
         1tyTOMh7MJOpxP8WrcJ0tsDulyJWhisxS7l3OFOqMW9DAci3h9ftFaJr3P1nFFZd1JN5
         fhiQ==
X-Gm-Message-State: AOAM533yycxS0sbOgX7ejh7vX45V4H5CFqvS/txdp/04HgDyRg5SlfyB
        oP0mShZlZDOyZ7jwVque2rCQzyPmBLR/TUKOfjg=
X-Google-Smtp-Source: ABdhPJwIJSPzqW4JH6E7pTgPGFoT0qHEGTV3CUKkX4tI26av/c6mHsAZc19QiGMx2v5nMnKxWGT0aoy1OmW0tXzT4mo=
X-Received: by 2002:aa7:d0d1:: with SMTP id u17mr20707091edo.135.1638479847487;
 Thu, 02 Dec 2021 13:17:27 -0800 (PST)
MIME-Version: 1.0
References: <20211202201351.74419-1-hdegoede@redhat.com>
In-Reply-To: <20211202201351.74419-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 2 Dec 2021 23:15:51 +0200
Message-ID: <CAHp75VctFk8xO4ddWi1V49eNp5+h_AOcRVv_=iMnjmVt0TOM5w@mail.gmail.com>
Subject: Re: [PATCH] mfd: intel-lpss: Fix I2C4 not being available on the
 Microsoft Surface Go & Go 2
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dan Scally <djrscally@gmail.com>, Kate Hsuan <hpa@redhat.com>,
        Maximilian Luz <luzmaximilian@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 2, 2021 at 10:14 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Many DSDTs for Kaby Lake and Kaby Lake Refresh models contain a
> _SB.PCI0.GEXP ACPI Device node describing an I2C attached GPIO expander.

For the record (and probably good to mention it's here) it's a PCA953x
compatible one.

> This seems to be something which is copy and pasted from the DSDT
> from some reference design since this ACPI Device is present even on
> models where no such GPIO expander is used at all, such as on the
> Microsoft Surface Go & Go 2.

Does this come from schematics? Or..? Ah, I see below.

> This ACPI Device is a problem because it contains a SystemMemory
> OperationRegion which covers the MMIO for the I2C4 I2C controller this
> causes the MFD cell for the I2C4 controller to not be instantiated due
> to a resource conflict, requiring the use of acpi_enforce_resources=lax
> to work around this.

Right.

> I have done an extensive analysis of all the ACPI tables on the
> Microsoft Surface Go and the _SB.PCI0.GEXP ACPI Device's methods are
> not used by any code in the ACPI tables, neither are any of them
> directly called by any Linux kernel code. This is unsurprising since
> running i2cdetect on the I2C4 bus shows that there is no GPIO
> expander chip present on these devices at all.

I believe it's an optional component on our reference designs (I saw a
lot of those expanders on our development boards).

> This commit adds a PCI subsystem vendor:device table listing PCI devices
> where it is known to be safe to ignore a resource-conflicts with ACPI

ignore resource conflicts

(no article, no dash) ?

> declared SystemMemory regions.
>
> This makes the I2C4 bus work out of the box on the Microsoft Surface
> Go & Go 2, which is necessary for the cameras on these devices to work.

After addressing comments
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Thanks for the patch!

> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Dan Scally <djrscally@gmail.com>
> Cc: Kate Hsuan <hpa@redhat.com>
> Cc: Maximilian Luz <luzmaximilian@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/mfd/intel-lpss-pci.c | 12 ++++++++++++
>  drivers/mfd/intel-lpss.c     |  1 +
>  drivers/mfd/intel-lpss.h     |  1 +
>  3 files changed, 14 insertions(+)
>
> diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
> index a872b4485eac..593290ff08a6 100644
> --- a/drivers/mfd/intel-lpss-pci.c
> +++ b/drivers/mfd/intel-lpss-pci.c
> @@ -17,6 +17,15 @@
>
>  #include "intel-lpss.h"
>
> +/* Some DSDTs have an unused GEXP ACPI device conflicting with I2C4 resources */
> +static const struct pci_device_id ignore_resource_conflicts_ids[] = {
> +       /* Microsoft Surface Go (version 1) I2C4 */
> +       { PCI_DEVICE_SUB(0x8086, 0x9d64, 0x152d, 0x1182), },
> +       /* Microsoft Surface Go 2 I2C4 */
> +       { PCI_DEVICE_SUB(0x8086, 0x9d64, 0x152d, 0x1237), },

Can we use PCI_VENDOR_ID_INTEL?

> +       { }
> +};
> +
>  static int intel_lpss_pci_probe(struct pci_dev *pdev,
>                                 const struct pci_device_id *id)
>  {
> @@ -35,6 +44,9 @@ static int intel_lpss_pci_probe(struct pci_dev *pdev,
>         info->mem = &pdev->resource[0];
>         info->irq = pdev->irq;
>
> +       if (pci_match_id(ignore_resource_conflicts_ids, pdev))
> +               info->ignore_resource_conflicts = true;
> +
>         pdev->d3cold_delay = 0;
>
>         /* Probably it is enough to set this for iDMA capable devices only */
> diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
> index 0e15afc39f54..cfbee2cfba6b 100644
> --- a/drivers/mfd/intel-lpss.c
> +++ b/drivers/mfd/intel-lpss.c
> @@ -401,6 +401,7 @@ int intel_lpss_probe(struct device *dev,
>                 return ret;
>
>         lpss->cell->swnode = info->swnode;
> +       lpss->cell->ignore_resource_conflicts = info->ignore_resource_conflicts;
>
>         intel_lpss_init_dev(lpss);
>
> diff --git a/drivers/mfd/intel-lpss.h b/drivers/mfd/intel-lpss.h
> index 22dbc4aed793..062ce95b68b9 100644
> --- a/drivers/mfd/intel-lpss.h
> +++ b/drivers/mfd/intel-lpss.h
> @@ -19,6 +19,7 @@ struct software_node;
>
>  struct intel_lpss_platform_info {
>         struct resource *mem;
> +       bool ignore_resource_conflicts;
>         int irq;
>         unsigned long clk_rate;
>         const char *clk_con_id;
> --
> 2.33.1
>


-- 
With Best Regards,
Andy Shevchenko
