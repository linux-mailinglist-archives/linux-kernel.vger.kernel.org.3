Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBE6595569
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbiHPIf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233376AbiHPIfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:35:25 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577835C35C
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 23:37:25 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id k2so9238231vsk.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 23:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1yicZUCBmbFEVGigqV5LTF45IjTIyj4GqkBuHOHX0Mk=;
        b=VOIn675SBgW64Opt8anvR1hqciGXGOG56uHHdbFT8iNLi6aJg7kHNNA1GwwEjJ8fn1
         pp7V/B1TiTqnokcmXLlutO9Z52E8LDcLjqXsD8ByLfjRB97ieoOsNCINYMEJ1axwFg2E
         b40ImzY+QYphFolCB0U5CIL/3IwXeISUA+CmfHp9mzgZeMzN6VctA2UIIzleh0naVKos
         vrqDUC70UE9ZPFxMLHzbJrDjc9M19oceVKBkI7FPebz2g7i7gol6U/oGk70tvc7DGrLa
         psRKCx0eYJHD3EceFnp12yFBFE9+SzQqcEn5B6mQI27yPbb1YCR4oF9UYxxjAHgX0qrW
         GJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1yicZUCBmbFEVGigqV5LTF45IjTIyj4GqkBuHOHX0Mk=;
        b=HV2ehX8VtYUMsW3fvF0BYuQgjVnHHOr1YsdrSPx3RZRffABD2DpVGEJiaSttW7mblm
         6VinN8mHtGYCjHTBSudSkWc+N5Iqlnkp5QHJUnTS4paLFy9pdNhfW5N3xOiaIjKdrI0C
         QVo95i6V91Igy+cvw9an7lvhXM4AWD3iXQK8Tp3FOPhkOTDjPNcqcXjUz2s1ckZpWAml
         xX2V/rCIHeFF8D6UAYOSqxytKHt9f9fHNPjAk8ifHrlMFEmQDjeZZhVNlY+tH45CeMQz
         s7XetUT5CYyKmY8R5HJXp83r8+G724eLbO0L68Z3a0oxjaC74BQ2Jver+Oup9COEJg0P
         X67w==
X-Gm-Message-State: ACgBeo2IAOj75TTIHTb60+HP7liqqkpSHkAaKCPEdKUzDSQYTv12MMKa
        3SzKFzuftnFC9asYe66oY6/bxU7AwwA4+A1YHdolwMeaamI=
X-Google-Smtp-Source: AA6agR4fxRyxPLFJx4wzCAgoPWh8+b54IujHwsnMfX6kuGqAc1R9t0Xi/hz+90IbY1JVV8tKQTFMC/NQS1/UkPfgQjk=
X-Received: by 2002:a67:cb93:0:b0:388:494d:4419 with SMTP id
 h19-20020a67cb93000000b00388494d4419mr7709168vsl.28.1660631844358; Mon, 15
 Aug 2022 23:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <a9daea363991c023d0364be22a762405b6c6f5c4.1660281458.git-series.apopple@nvidia.com>
 <CAC=cRTON4s6LJ+09mg4SxMjNirBih3QSt6cr10gNjs3k0o+BgQ@mail.gmail.com> <87r11gvrx6.fsf@nvdebian.thelocal>
In-Reply-To: <87r11gvrx6.fsf@nvdebian.thelocal>
From:   huang ying <huang.ying.caritas@gmail.com>
Date:   Tue, 16 Aug 2022 14:37:12 +0800
Message-ID: <CAC=cRTO6nWGus4v=MhZZeE9hdjM2A5bChHHU_tSbtFD95fFi9w@mail.gmail.com>
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

On Tue, Aug 16, 2022 at 10:33 AM Alistair Popple <apopple@nvidia.com> wrote:
>
>
> huang ying <huang.ying.caritas@gmail.com> writes:
>
> > Hi, Alistair,
> >
> > On Fri, Aug 12, 2022 at 1:23 PM Alistair Popple <apopple@nvidia.com> wrote:

[snip]

>
> > And I don't know why we use ptep_get_and_clear() to clear PTE if
> > (!anon_exclusive).  Why don't we need to flush the TLB?
>
> We do the TLB flush at the end if anything was modified:
>
>         /* Only flush the TLB if we actually modified any entries */
>         if (unmapped)
>                 flush_tlb_range(walk->vma, start, end);
>
> Obviously I don't think that will work correctly now given we have to
> read the dirty bits and clear the PTE atomically. I assume it was
> originally written this way for some sort of performance reason.

Thanks for pointing this out.  If there were parallel page table
operations such as mprotect() or munmap(), the delayed TLB flushing
mechanism here may have some problem.  Please take a look at the
comments of flush_tlb_batched_pending() and TLB flush batching
implementation in try_to_unmap_one().  We may need to flush TLB with
page table lock held or use a mechanism similar to that in
try_to_unmap_one().

Best Regards,
Huang, Ying
