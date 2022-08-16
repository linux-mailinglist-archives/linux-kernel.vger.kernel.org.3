Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1645952D0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 08:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiHPGoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 02:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiHPGn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 02:43:59 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CF9F5CD4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 18:39:42 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 73so8007257pgb.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 18:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=cMuUlWGLbTpeu0ASefFqDvJ/DGPqzdWcKWwAAva0H64=;
        b=WES+YnOZL2UjR4oBSqpkDqfy5lRMZ4Az94YlDnft7E80VXwd3QCegkIe80Y2DNmcRu
         exMTJsFtVAt7oqKqCDVqVwlCuuKBVkIi/cznTfu59wBPo3bUh+mt2ula0EENnUqsWqCP
         iOIr04Hn9JP5mUCDF8IoTZojIj/oDjxMK6VBkX9wIpu1QCZm+3dMUBq2i5bhU/b+GWpc
         fKkAQRnQTgBtX10tQEFcopknGrRl6Y3X9aCYwO+Qcl5QvrorZL0Y7lJYg1PKa6LW/1z9
         pUhY+SX0gBQfjKk1jPI872E/x+guVVCnqOr3UsXNtruec/1Ypi6z/bPM+Vl0jbpQIcvx
         ONDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=cMuUlWGLbTpeu0ASefFqDvJ/DGPqzdWcKWwAAva0H64=;
        b=hVyKDMGaWmO3ltB9EeM/ii8X5aBcnPwq7mYI1SqhdHxpcVjcfDarJ+xTXbBym9FaZQ
         XxdhjJlAIz5nYhr5K6cNxWpnJ1krmFrCDYm9bh6m/R4j2pVKWr3ErCsHEwNaRDQEpuT7
         JnrnFXG+dp36rlV3zoPO+q6KCKMyne+Sv1oJ/M1qXMMrXkzWUCfz5JIm6E6L5MJIhcXJ
         +Fg2eKds1cSue4/ukQqFloJEpE44TVmLx80ofrjVRxW9nTVqKMGZ5OzLGbigquqIOVA4
         s/+uQgKXixDNK/XJ1/OdPsv5XEIrV0izVYzRV/vj9TDl/CZr9gZ2+dfrbOoypbaqxoDz
         SuBQ==
X-Gm-Message-State: ACgBeo0eFM6kuOsFBoQbbvF+F+SYgfHT40BW8XcA+LmwHHiDEa2e51p+
        FEpwZ3aSyr3BWF2Nqv856eGkQbbjakE+gdkEENG7iZUTUPs=
X-Google-Smtp-Source: AA6agR7vbJv28trrDODg84BXP6+k2lJrU93pgFx3KueJKbD/mjt0HBUM90nH7LBOqgipIESu50GfUTNZc1xxADv0pQM=
X-Received: by 2002:a65:5b03:0:b0:41d:131c:4f39 with SMTP id
 y3-20020a655b03000000b0041d131c4f39mr15846558pgq.401.1660613982246; Mon, 15
 Aug 2022 18:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <a9daea363991c023d0364be22a762405b6c6f5c4.1660281458.git-series.apopple@nvidia.com>
In-Reply-To: <a9daea363991c023d0364be22a762405b6c6f5c4.1660281458.git-series.apopple@nvidia.com>
From:   huang ying <huang.ying.caritas@gmail.com>
Date:   Tue, 16 Aug 2022 09:39:24 +0800
Message-ID: <CAC=cRTON4s6LJ+09mg4SxMjNirBih3QSt6cr10gNjs3k0o+BgQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/migrate_device.c: Copy pte dirty bit to page
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>, linuxram@us.ibm.com,
        paulus@ozlabs.org, Peter Xu <peterx@redhat.com>
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

Hi, Alistair,

On Fri, Aug 12, 2022 at 1:23 PM Alistair Popple <apopple@nvidia.com> wrote:
>
> migrate_vma_setup() has a fast path in migrate_vma_collect_pmd() that
> installs migration entries directly if it can lock the migrating page.
> When removing a dirty pte the dirty bit is supposed to be carried over
> to the underlying page to prevent it being lost.
>
> Currently migrate_vma_*() can only be used for private anonymous
> mappings. That means loss of the dirty bit usually doesn't result in
> data loss because these pages are typically not file-backed. However
> pages may be backed by swap storage which can result in data loss if an
> attempt is made to migrate a dirty page that doesn't yet have the
> PageDirty flag set.
>
> In this case migration will fail due to unexpected references but the
> dirty pte bit will be lost. If the page is subsequently reclaimed data
> won't be written back to swap storage as it is considered uptodate,
> resulting in data loss if the page is subsequently accessed.
>
> Prevent this by copying the dirty bit to the page when removing the pte
> to match what try_to_migrate_one() does.
>
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Reported-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/migrate_device.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index 27fb37d..d38f8a6 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -7,6 +7,7 @@
>  #include <linux/export.h>
>  #include <linux/memremap.h>
>  #include <linux/migrate.h>
> +#include <linux/mm.h>
>  #include <linux/mm_inline.h>
>  #include <linux/mmu_notifier.h>
>  #include <linux/oom.h>
> @@ -211,6 +212,10 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>
>                         migrate->cpages++;
>
> +                       /* Set the dirty flag on the folio now the pte is gone. */
> +                       if (pte_dirty(pte))
> +                               folio_mark_dirty(page_folio(page));
> +

I think that this isn't sufficient to fix all issues.  Firstly, "pte"
is assigned at the begin of the loop, before the PTE is cleared via
ptep_clear_flush() or ptep_get_and_clear().  That is, the pte isn't
changed atomically.  Between "pte" assignment and PTE clear, the PTE
may become dirty.  That is, we need to update pte when we clear the
PTE.

And I don't know why we use ptep_get_and_clear() to clear PTE if
(!anon_exclusive).  Why don't we need to flush the TLB?

Best Regards,
Huang, Ying

>                         /* Setup special migration page table entry */
>                         if (mpfn & MIGRATE_PFN_WRITE)
>                                 entry = make_writable_migration_entry(
>
> base-commit: ffcf9c5700e49c0aee42dcba9a12ba21338e8136
> --
> git-series 0.9.1
>
