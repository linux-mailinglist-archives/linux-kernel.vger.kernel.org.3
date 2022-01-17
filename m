Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666554905BD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 11:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238541AbiAQKK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 05:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236035AbiAQKKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 05:10:25 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F55CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 02:10:25 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id z22so43762899ybi.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 02:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BouR0VV77MpcGctqKa2gvLTpAJl8MJ7JwC3WZtNKLdo=;
        b=Qsz6fjuGzAT6R+ByoaWuEbq65eacB9osCar1lL9Ko5fHYTh9dHUphcM7x5Vosx80iy
         Y3YO7woSJsXRSXp6580L66czwqc4mbuWSsUDHtHTCXyQlmIuspmowV3xhT9uIix8/8ye
         Sk8rklknMaUzMH8Fisu5M7b9hsOSC7Pik36DwmQdfX3n6w2JSXkS4LsbgKXRr6k+/dYF
         sYkPV4saskU1hIgGylni3cB5w2B6988bHNZfZFVE2HYOwRb8se4nHBVBChqKr+zlhsRF
         9hdRoSN2Ysjc1DTxHjILr9p1uM5GljNSP3Nr2dLw06++K0+X4VJ30rakzVp0j0fejZXc
         rxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BouR0VV77MpcGctqKa2gvLTpAJl8MJ7JwC3WZtNKLdo=;
        b=2TUU+wiKtobAn4Ly4E/kAIXqSXUZ4Uh7bJQWvoXKhXbb3qa9sC3ln7qXz3xisK1/Ok
         XkqTKS4ObI7w9xWsHyVpgEmWsoRhyQ50XwpjGyQ4egdaMomxfstRHbRJiv6SZ1mHVfAN
         U1ISDArpgji95xdKECXCxNrrnHaGGgNYn8A4TuuPR9lOwIkVitYgbDZk01WIYPlpim15
         vQD7+zu0esRZAm105lUHVf4K5MbFTRu2gpzeZG0nIvB812HbXg9UpYpOACly+D3PbZAJ
         u9wt1y4OgplXig56D0bn8xHrG1M7jk+gKqHxXJXaJ3gRMjQs0HE8dHXbxhvM5dJANoQm
         rRfA==
X-Gm-Message-State: AOAM530kF35yIzGekSp/6FWqK13nawr0xnIXsx4SPxVyUTBGBn/mkAsF
        h+Z/9AK9u6geenEGipnUxnwEE7XaPdtKDZIewfbbA3UgLen6nw==
X-Google-Smtp-Source: ABdhPJzkna+eg9A2SqH8HMEvDQLSOkoMBF7pmLip9we40/Nwc/zYFyDWjWKFfMtbs5NZoFBLO+j5f9pHzKasehBEUms=
X-Received: by 2002:a25:fe05:: with SMTP id k5mr535743ybe.429.1642414224193;
 Mon, 17 Jan 2022 02:10:24 -0800 (PST)
MIME-Version: 1.0
References: <20220117092759.1619771-1-ztong0001@gmail.com> <87ilui8yxt.wl-maz@kernel.org>
In-Reply-To: <87ilui8yxt.wl-maz@kernel.org>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Mon, 17 Jan 2022 02:10:13 -0800
Message-ID: <CAA5qM4CfExWdg=Gp8OshKgYsi0A82nzTA1Uqu6nc_MQmdBfWzg@mail.gmail.com>
Subject: Re: [PATCH v1] genirq/msi: fix crash when handling Multi-MSI
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

ops->msi_check could point to pci_msi_domain_check_cap that is the
function in question

hence we can have following call stack

pci_msi_domain_check_cap (used by ops->msi_check(domain, info, dev))
msi_domain_prepare_irqs
__msi_domain_alloc_irqs
msi_domain_alloc_irqs_descs_locked

What I am suggesting is commit 0f62d941acf9 changed how this return
value is being handled and created a UAF

- Tong


On Mon, Jan 17, 2022 at 2:00 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Mon, 17 Jan 2022 09:27:59 +0000,
> Tong Zhang <ztong0001@gmail.com> wrote:
> >
> > pci_msi_domain_check_cap() could return 1 when domain does not support
> > multi MSI and user request multi MSI. This positive value will be used by
> > __pci_enable_msi_range(). In previous refactor, this positive value is
> > handled as error case which will cause kernel crash.
> >
> > [    1.197953] BUG: KASAN: use-after-free in __pci_enable_msi_range+0x234/0x320
> > [    1.198327] Freed by task 1:
> > [    1.198327]  kfree+0x8f/0x2b0
> > [    1.198327]  msi_free_msi_descs_range+0xf5/0x130
> > [    1.198327]  msi_domain_alloc_irqs_descs_locked+0x8d/0xa0
> > [    1.198327]  __pci_enable_msi_range+0x1a4/0x320
> > [    1.198327]  pci_alloc_irq_vectors_affinity+0x135/0x1a0
> > [    1.198327]  pcie_port_device_register+0x4a1/0x5c0
> > [    1.198327]  pcie_portdrv_probe+0x50/0x100
>
> I'm sorry, but you'll have to be a bit clearer in your commit message,
> because I cannot relate what you describe with the patch.
>
> The real issue seems to be that a domain_alloc_irqs callback can
> return a positive, non-zero value, and I don't think this is expected.
>
> How about this instead? If I am barking up the wrong tree, please
> provide a more accurate description of the problem you are seeing.
>
> Thanks,
>
>         M.
>
> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
> index 2bdfce5edafd..da8bb6135627 100644
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -878,8 +878,10 @@ int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
>                 virq = __irq_domain_alloc_irqs(domain, -1, desc->nvec_used,
>                                                dev_to_node(dev), &arg, false,
>                                                desc->affinity);
> -               if (virq < 0)
> -                       return msi_handle_pci_fail(domain, desc, allocated);
> +               if (virq < 0) {
> +                       ret = msi_handle_pci_fail(domain, desc, allocated);
> +                       return ret < 0 ? ret : 0;
> +               }
>
>                 for (i = 0; i < desc->nvec_used; i++) {
>                         irq_set_msi_desc_off(virq, i, desc);
>
> --
> Without deviation from the norm, progress is not possible.
