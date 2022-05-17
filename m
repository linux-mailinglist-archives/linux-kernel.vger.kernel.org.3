Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A071152AABC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352166AbiEQS02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352086AbiEQS0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:26:10 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD57F21267;
        Tue, 17 May 2022 11:26:07 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-2ff1ed64f82so182427b3.1;
        Tue, 17 May 2022 11:26:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sVf0IKcUPJN+ZbeQbmcYThh8l5zqk/JygO3ZKJiiVYo=;
        b=ryn+siO6zNNuvQL83d348CgtLI6ZAzdwa4HT6yKeeLQJMOERs9JFKDYgXVnUiY4Hko
         IjxsqxC/9pXtG9Wv3RmRlEsFy3LzEeIhrBqaf5zd8RmUgj4gHGucKKazpqY9uoAjb0PQ
         GnnYuTRIdTOWcpCk8yRCre8N6hfogM6tUoB4giD0Pl8DWfapXFHREmqdTfPKm/+QbwKE
         yXFmAQkG08Tvtwt4pjAfwXD2k1hbr9B2CLtzZh9qsuUTGnHQ5sFfSzMd6gOb9KDxosGc
         lfUzPHy83WUr9pu8ghAyuNUHS3CwM1pbFCvsitBtXpPamovlMSR9Tmq3CLjVeJDnm07Z
         W9yQ==
X-Gm-Message-State: AOAM530/iF6/aQaQChesU5u+Gu9Qn2VjhLd+LjNjRhYO6bUYaKfFM1Jk
        MIGqOS9PkpSlLToloU5pVXx6f2Cyp1hzjykvW/x7UJGg
X-Google-Smtp-Source: ABdhPJwe3/YEJXgq0/+d2vl/7z1XCU41tff1jHy0gHiav04F87zor2w2JioqibbLuQQSRqniio49fYb/Fca7rhoB2S4=
X-Received: by 2002:a0d:c442:0:b0:2fe:beab:1fef with SMTP id
 g63-20020a0dc442000000b002febeab1fefmr24061021ywd.196.1652811966272; Tue, 17
 May 2022 11:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220401172840.1252-1-james.liu@hpe.com> <20220517175629.GA4788@ubuntu-20.04.3>
In-Reply-To: <20220517175629.GA4788@ubuntu-20.04.3>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 May 2022 20:25:55 +0200
Message-ID: <CAJZ5v0hv5__ZQVqr-yzMa4_OgeknhOkbSpxQ233eCmJXksgNGw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: OSL: Fix the memory mapping of an ACPI GAS that
 addresses a data structure
To:     James Liu <james.liu@hpe.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 7:56 PM James Liu <james.liu@hpe.com> wrote:
>
> Hi Rafael and all,
> Could you take a look into this patches? The mentioned bug blocks EINJ
> testing whenever a system firmware can correctly support GAS according
> to ACPI 6.4.

The kernel test robot reported an issue with it.  Have you seen that report?

> On Fri, Apr 01, 2022 at 05:28:40PM +0000, james.liu@hpe.com wrote:
> > From: James Liu <james.liu@hpe.com>
> >
> >     Modify acpi_os_map_generic_address and acpi_os_unmap_generic_address
> >     to handle a case that a GAS table (i.e., Table 5.1 in ACPI 6.4) is used
> >     to address a data structure; in this case, the GAS has the field of
> >     "Register Bit Width" equal to 0.
> >
> >     For example, "Injection Instruction Entry" (Table 18.25 in ACPI 6.4)
> >     has a RegisterRegion field that is a GAS that points to a data
> >     structure SET_ERROR_TYPE_WITH_ADDRESS (Table 18.30), which is required
> >     when using EINJ (Error Injection module).
> >
> >     This fix preserves a fairly sufficient memory space (i.e., page size)
> >     to store the data structure so as to prevent EINJ module from loading
> >     failure if platform firmware can support Injection Instruction Entry in
> >     an EINJ table.
> >
> > Signed-off-by: James Liu <james.liu@hpe.com>
> > ---
> >  drivers/acpi/osl.c | 23 +++++++++++++++++++++--
> >  1 file changed, 21 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> > index 45c5c0e45..ab2f584b1 100644
> > --- a/drivers/acpi/osl.c
> > +++ b/drivers/acpi/osl.c
> > @@ -457,9 +457,15 @@ void __iomem *acpi_os_map_generic_address(struct acpi_generic_address *gas)
> >       if (gas->space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY)
> >               return NULL;
> >
> > +     /* Handle a case that GAS is used to address an ACPI data structure */
> > +     if (!gas->bit_width) {
> > +             pr_info("An ACPI data structure at 0x%llx is mapped\n", addr);
> > +             return  acpi_os_map_iomem(addr, PAGE_SIZE);
> > +     }
> > +
> >       /* Handle possible alignment issues */
> >       memcpy(&addr, &gas->address, sizeof(addr));
> > -     if (!addr || !gas->bit_width)
> > +     if (!addr)
> >               return NULL;
> >
> >       return acpi_os_map_iomem(addr, gas->bit_width / 8);
> > @@ -474,9 +480,22 @@ void acpi_os_unmap_generic_address(struct acpi_generic_address *gas)
> >       if (gas->space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY)
> >               return;
> >
> > +     /* Handle a case that GAS is used to address an ACPI data structure */
> > +     if (!gas->bit_width) {
> > +             pr_info("An ACPI data structure at 0x%llx is unmapped\n", addr);
> > +             mutex_lock(&acpi_ioremap_lock);
> > +             map = acpi_map_lookup(addr, PAGE_SIZE);
> > +             if (!map) {
> > +                     mutex_unlock(&acpi_ioremap_lock);
> > +                     return;
> > +             }
> > +             acpi_os_drop_map_ref(map);
> > +             mutex_unlock(&acpi_ioremap_lock);
> > +     }
> > +
> >       /* Handle possible alignment issues */
> >       memcpy(&addr, &gas->address, sizeof(addr));
> > -     if (!addr || !gas->bit_width)
> > +     if (!addr)
> >               return;
> >
> >       mutex_lock(&acpi_ioremap_lock);
> > --
> > 2.25.1
> >
