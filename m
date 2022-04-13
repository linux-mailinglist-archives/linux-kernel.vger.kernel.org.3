Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40EC44FFD4D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 19:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237536AbiDMSBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbiDMSBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:01:48 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4B813F75;
        Wed, 13 Apr 2022 10:59:25 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-2eba37104a2so31848017b3.0;
        Wed, 13 Apr 2022 10:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XBIdc2r7ktDJVgL8jFR2huHb3Z5LWfWpJ3rv5dtCkOU=;
        b=X0EHu8AB3E7C2rMBd7nzhXHMjHG8IK1I9W9Nco1mhr8YXvkzSZHUUw+Or0xEfBAgDl
         FwKdjduWTZ6ctquCmxaBCx98ePOtwOtshxjqjsfUOP+Nb/CdzGty5JD+dFoZlyIV5m5z
         NbUmI0BDoh5p9Wv2yaF2XTj7JjtHstmpSxtwB7fQQCzcMh2ODKBTspmnSUh9nKSV8bWx
         X1eAvxxkabcO12rSOq2YDwn11bGVzYFa45zzsAtCDSZ1onF6YMPMBOk7qaTFXuIoff4M
         34B9jwH0dCIUzv+96xOPvX9Hyr3VbHjdx13xWIia39r817OwVdzfP5A8vnr1W4vSaLN/
         JWjQ==
X-Gm-Message-State: AOAM531bDQul+hbe09WGBAgPLryhodG1tVQm/fYVJJNYK1d13W+kloKR
        NSyzPiJS7HvNnzEYerNYy6ckBdXb8+R6XO/OoSQ=
X-Google-Smtp-Source: ABdhPJwBb3XTK/d7JaeiGrBNurZ9a5QDrmx/7nw/Y0BzRDUwJvPFPFQCUiHDJiH6mQyGZ/W729DEj2rvFrNZ6igkwZ8=
X-Received: by 2002:a81:1b97:0:b0:2db:640f:49d8 with SMTP id
 b145-20020a811b97000000b002db640f49d8mr83773ywb.326.1649872765056; Wed, 13
 Apr 2022 10:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220407105120.1280-1-lorenzo.pieralisi@arm.com> <CAMj1kXEx1JFexVZvd=p3+ra1A7050VfWaZg1uuk-_nFDns4Z4Q@mail.gmail.com>
In-Reply-To: <CAMj1kXEx1JFexVZvd=p3+ra1A7050VfWaZg1uuk-_nFDns4Z4Q@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Apr 2022 19:59:14 +0200
Message-ID: <CAJZ5v0h40xRfPbYoc2yA40yrmR6+sHVAO-ihqDT9czbhSJ-MYA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: osl: Fix BERT error region memory mapping
To:     Ard Biesheuvel <ardb@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Veronika kabatova <vkabatov@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Aristeu Rozanski <aris@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 7:41 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 7 Apr 2022 at 12:51, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> >
> > Currently the sysfs interface maps the BERT error region as "memory"
> > (through acpi_os_map_memory()) in order to copy the error records into
> > memory buffers through memory operations (eg memory_read_from_buffer()).
> >
> > The OS system cannot detect whether the BERT error region is part of
> > system RAM or it is "device memory" (eg BMC memory) and therefore it
> > cannot detect which memory attributes the bus to memory support (and
> > corresponding kernel mapping, unless firmware provides the required
> > information).
> >
> > The acpi_os_map_memory() arch backend implementation determines the
> > mapping attributes. On arm64, if the BERT error region is not present in
> > the EFI memory map, the error region is mapped as device-nGnRnE; this
> > triggers alignment faults since memcpy unaligned accesses are not
> > allowed in device-nGnRnE regions.
> >
> > The ACPI sysfs code cannot therefore map by default the BERT error
> > region with memory semantics but should use a safer default.
> >
> > Change the sysfs code to map the BERT error region as MMIO (through
> > acpi_os_map_iomem()) and use the memcpy_fromio() interface to read the
> > error region into the kernel buffer.
> >
> > Link: https://lore.kernel.org/linux-arm-kernel/31ffe8fc-f5ee-2858-26c5-0fd8bdd68702@arm.com
> > Link: https://lore.kernel.org/linux-acpi/CAJZ5v0g+OVbhuUUDrLUCfX_mVqY_e8ubgLTU98=jfjTeb4t+Pw@mail.gmail.com
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Hanjun Guo <guohanjun@huawei.com>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>

Applied as 5.19 material, thanks!

> > ---
> >  drivers/acpi/sysfs.c | 25 ++++++++++++++++++-------
> >  1 file changed, 18 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> > index a4b638bea6f1..cc2fe0618178 100644
> > --- a/drivers/acpi/sysfs.c
> > +++ b/drivers/acpi/sysfs.c
> > @@ -415,19 +415,30 @@ static ssize_t acpi_data_show(struct file *filp, struct kobject *kobj,
> >                               loff_t offset, size_t count)
> >  {
> >         struct acpi_data_attr *data_attr;
> > -       void *base;
> > -       ssize_t rc;
> > +       void __iomem *base;
> > +       ssize_t size;
> >
> >         data_attr = container_of(bin_attr, struct acpi_data_attr, attr);
> > +       size = data_attr->attr.size;
> > +
> > +       if (offset < 0)
> > +               return -EINVAL;
> > +
> > +       if (offset >= size)
> > +               return 0;
> >
> > -       base = acpi_os_map_memory(data_attr->addr, data_attr->attr.size);
> > +       if (count > size - offset)
> > +               count = size - offset;
> > +
> > +       base = acpi_os_map_iomem(data_attr->addr, size);
> >         if (!base)
> >                 return -ENOMEM;
> > -       rc = memory_read_from_buffer(buf, count, &offset, base,
> > -                                    data_attr->attr.size);
> > -       acpi_os_unmap_memory(base, data_attr->attr.size);
> >
> > -       return rc;
> > +       memcpy_fromio(buf, base + offset, count);
> > +
> > +       acpi_os_unmap_iomem(base, size);
> > +
> > +       return count;
> >  }
> >
> >  static int acpi_bert_data_init(void *th, struct acpi_data_attr *data_attr)
> > --
> > 2.31.0
> >
