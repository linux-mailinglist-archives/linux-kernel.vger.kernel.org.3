Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86FD1494038
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 19:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356935AbiASSzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 13:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiASSzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 13:55:05 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61493C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 10:55:05 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id l68so9773085ybl.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 10:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bfrvo9bqgk3sZVc8qEEfTZaGxKQeqAbP9aU1zSP7BUI=;
        b=GtpipSzTM8S9+iN0X3exUHDc5SQ9/TLbaYAZR5KD3yxBIhPhPxyv8HcZH6GqpCVRSe
         XgaYOjYPqsLq/P3FkSDeCAjXJtnzevsXpF0z6mcfV6yH1YDmV7itArdgBaB5o0jxks9O
         0eueGXWZ/Vc0X3dN/Bcsc/5HiZ/yNfTC0kWxVSguBixcPv2+6xyg8/p5rvzJTxXXOeko
         ntlQvoxQTeUpmxa7ZZWDbhFwZYnMR11vr5sL0OdBju7K1f3XKJwxc7hKRAvjQ4QC/uDM
         GvKUdVMV3cGNbpxadcgH+8f1GVaSqVEqgZny/DojBqmuWVRGPviJzmG/O0wS74+/rTGM
         zI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bfrvo9bqgk3sZVc8qEEfTZaGxKQeqAbP9aU1zSP7BUI=;
        b=jpMkMamu/cvhM6KlnGSg98JWnMhYj2LuyxuMFTQqjWyqh9Nj0BVQNrn4ZrlkymmCVr
         DW2ZbjNDMX1WldPNqkGj9u2kDkVI2IUNA8oEquH9sv5ELZ+Zkl/mGm9MAlPpFqsqSzmC
         WOs8Yn5llYS9CJYp/iIBQv0uZVk5CZYWgqrVIt6wWy+iI3F7mVLqlP0meljRLgmXkXCX
         /MYjBAxNpaSnnYx6gw8KqgP1cLrQeo6DALlyzsgJvMTyBxR1ut8jcVOdqjpEQQCPhcnD
         1Mh7MXyBz82tcyV3q8cXe9kW/Kucyn61cVIJKhJj3ovhxHk5oCS78q7lKIMgHzde0zQS
         R3LQ==
X-Gm-Message-State: AOAM531kOh8o3gPIW8Piwu3p/3uNRlwZZZ/eG6zYMYs0arWpXtaplaw7
        rosg061y190UJAhLcKr9ATYcavfQPWTNqD9YmOk=
X-Google-Smtp-Source: ABdhPJxj5hECHQXjlUcaMY0dnBSzLB21+xD6l/1GZbkiewR+tscSqcRtZ4ZU3AjuNSWz9sHweTmL/hfac2FDOCpd6GQ=
X-Received: by 2002:a25:388a:: with SMTP id f132mr42386459yba.102.1642618504457;
 Wed, 19 Jan 2022 10:55:04 -0800 (PST)
MIME-Version: 1.0
References: <20220117092759.1619771-1-ztong0001@gmail.com> <87ilui8yxt.wl-maz@kernel.org>
 <CAA5qM4CfExWdg=Gp8OshKgYsi0A82nzTA1Uqu6nc_MQmdBfWzg@mail.gmail.com>
 <87h7a28uhj.wl-maz@kernel.org> <87iluh9kgx.ffs@tglx> <877dawa70b.ffs@tglx> <87r1938vbn.ffs@tglx>
In-Reply-To: <87r1938vbn.ffs@tglx>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Wed, 19 Jan 2022 10:54:53 -0800
Message-ID: <CAA5qM4Dru8=Eptg96tWzGU018GSivxZYo90cs3az-OxPSBvH6g@mail.gmail.com>
Subject: Re: [PATCH] PCI/MSI: Prevent UAF in error path
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Marc Zyngier <maz@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        open list <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 9:54 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> When the core MSI allocation fails, then the PCI/MSI code uses an already
> freed MSI descriptor to unmask the MSI mask register in order to bring it back
> into reset state.
>
> Remove MSI_FLAG_FREE_MSI_DESCS from the PCI/MSI irqdomain flags and let the
> PCI/MSI code free the MSI descriptors after usage.
>
> Fixes: 0f62d941acf9 ("genirq/msi: Provide msi_domain_alloc/free_irqs_descs_locked()")
> Reported-by: Tong Zhang <ztong0001@gmail.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/pci/msi/irqdomain.c |    4 ++--
>  drivers/pci/msi/legacy.c    |    1 -
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> --- a/drivers/pci/msi/irqdomain.c
> +++ b/drivers/pci/msi/irqdomain.c
> @@ -28,6 +28,7 @@ void pci_msi_teardown_msi_irqs(struct pc
>                 msi_domain_free_irqs_descs_locked(domain, &dev->dev);
>         else
>                 pci_msi_legacy_teardown_msi_irqs(dev);
> +       msi_free_msi_descs(&dev->dev);
>  }
>
>  /**
> @@ -171,8 +172,7 @@ struct irq_domain *pci_msi_create_irq_do
>         if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
>                 pci_msi_domain_update_chip_ops(info);
>
> -       info->flags |= MSI_FLAG_ACTIVATE_EARLY | MSI_FLAG_DEV_SYSFS |
> -                      MSI_FLAG_FREE_MSI_DESCS;
> +       info->flags |= MSI_FLAG_ACTIVATE_EARLY | MSI_FLAG_DEV_SYSFS;
>         if (IS_ENABLED(CONFIG_GENERIC_IRQ_RESERVATION_MODE))
>                 info->flags |= MSI_FLAG_MUST_REACTIVATE;
>
> --- a/drivers/pci/msi/legacy.c
> +++ b/drivers/pci/msi/legacy.c
> @@ -77,5 +77,4 @@ void pci_msi_legacy_teardown_msi_irqs(st
>  {
>         msi_device_destroy_sysfs(&dev->dev);
>         arch_teardown_msi_irqs(dev);
> -       msi_free_msi_descs(&dev->dev);
>  }

Tested-by: Tong Zhang <ztong0001@gmail.com>

Tested on my setup, it no longer crashes.
Thanks!
- Tong
