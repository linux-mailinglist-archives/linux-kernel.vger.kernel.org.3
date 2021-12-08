Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F60346D5E9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 15:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbhLHOol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 09:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhLHOok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 09:44:40 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F1EC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 06:41:08 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id e128so3022009iof.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 06:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EifvKO8pkCxjynNmz7PWzO7emHYLJkPJiO8pUS2qQfo=;
        b=qhudb95dxd2TFju2GrhG2SL1Z1VNnPvllqgHWUOLGfDC5ik0baUOZlzOIqN/xKbIqA
         yCIPWUl2DLbXQvJeV3xPebpPbsflSRrJsFG4Z9QVI6ny5meKUmX8XvZEFiix/Yt0se5O
         tPTxP0zp8NDl9wFBqww4sD54seBtEc6PyRqbYe5xdxwPQMeCWqexc4uswyKPJhdS8ev1
         x3IBBMwQkga8O6DPEgJKM0gz+M1RUWI3v28z7MUB13IHMzkz8Xng+fkCvYkL2KZ4kvjg
         E+82LoUqvl1ix4Rk41SREpDYqunzR1rWlnryiOuxTl3BwTxAyISK1fN37E7V1YD9xzwr
         anfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EifvKO8pkCxjynNmz7PWzO7emHYLJkPJiO8pUS2qQfo=;
        b=ydjHGbViF0UpSpRN162MzfdOsVo/FnfvJnQOJOYcofLqebL0z9URY5SsSYrtUGQqeZ
         z2uzUOykpfbxQkFEByWcED0mp1o1spoCnQBKf3ahHFnNioLhe9sAtA7tr0SQLQ1Wub2V
         6G573WzOZBF9PvQGr1SwpWpYpPamgfh0X/dQ7dz6GBF6Gl4tvikDx/98Eo777gdxSGNb
         lDnBeaqtJ/UXJbwc7yMTJ5EbAdx5MOSqHF+26WL1Ni8qhyRFGaThvoxYTDzd4R5S1rS3
         0opBqITSJZt+x3wIBVcOs+o0zw2pgF4gjZprJJ8nwQH94eFKA7xy1Cg7ARDHAi8G9sUN
         uxkw==
X-Gm-Message-State: AOAM533UFYXlXMEiCssbdjhk1qmywFF3s713K8MqA0XD8Yn3Uxe2TC1l
        EKFqqT6223k0A1MYzti1AWiiiFYoH8xTRFS6H1+OfPqOoq4=
X-Google-Smtp-Source: ABdhPJy1Z52W9BY50LufdzM7SjUxflxMKG+cfNETPfhd4KgizIC94LI3ETFCIYVx59bz5DGr04qcTlzMotGlynMycoI=
X-Received: by 2002:a05:6638:2191:: with SMTP id s17mr63525834jaj.67.1638974466161;
 Wed, 08 Dec 2021 06:41:06 -0800 (PST)
MIME-Version: 1.0
References: <20211201170411.1561936-1-qperret@google.com> <20211201170411.1561936-7-qperret@google.com>
 <CA+_y_2EEP5tYbBTd17c1wuOeZ2jSfhgu0M2b=CpGKjKRgU-=gw@mail.gmail.com> <YbCAJZAqUXngvjZ2@google.com>
In-Reply-To: <YbCAJZAqUXngvjZ2@google.com>
From:   Andrew Walbran <qwandor@google.com>
Date:   Wed, 8 Dec 2021 14:40:54 +0000
Message-ID: <CA+_y_2GJk-F8ju0yXsMc2iwd_yFRQGOY1LW2YV-8bZLANwfCHQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/15] KVM: arm64: Implement kvm_pgtable_hyp_unmap() at EL2
To:     Quentin Perret <qperret@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Dec 2021 at 09:51, Quentin Perret <qperret@google.com> wrote:
>
> Hi Andrew,
>
> On Tuesday 07 Dec 2021 at 14:47:14 (+0000), Andrew Walbran wrote:
> > On Wed, 1 Dec 2021 at 17:04, 'Quentin Perret' via kernel-team
> > <kernel-team@android.com> wrote:
> > >
> > > From: Will Deacon <will@kernel.org>
> > >
> > > Implement kvm_pgtable_hyp_unmap() which can be used to remove hypervisor
> > > stage-1 mappings at EL2.
> > >
> > > Signed-off-by: Will Deacon <will@kernel.org>
> > > Signed-off-by: Quentin Perret <qperret@google.com>
> > > ---
> > >  arch/arm64/include/asm/kvm_pgtable.h | 21 ++++++++++
> > >  arch/arm64/kvm/hyp/pgtable.c         | 63 ++++++++++++++++++++++++++++
> > >  2 files changed, 84 insertions(+)
> > >
> > > diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> > > index 027783829584..9d076f36401d 100644
> > > --- a/arch/arm64/include/asm/kvm_pgtable.h
> > > +++ b/arch/arm64/include/asm/kvm_pgtable.h
> > > @@ -251,6 +251,27 @@ void kvm_pgtable_hyp_destroy(struct kvm_pgtable *pgt);
> > >  int kvm_pgtable_hyp_map(struct kvm_pgtable *pgt, u64 addr, u64 size, u64 phys,
> > >                         enum kvm_pgtable_prot prot);
> > >
> > > +/**
> > > + * kvm_pgtable_hyp_unmap() - Remove a mapping from a hypervisor stage-1 page-table.
> > > + * @pgt:       Page-table structure initialised by kvm_pgtable_hyp_init().
> > > + * @addr:      Virtual address from which to remove the mapping.
> > > + * @size:      Size of the mapping.
> > > + *
> > > + * The offset of @addr within a page is ignored, @size is rounded-up to
> > > + * the next page boundary and @phys is rounded-down to the previous page
> > > + * boundary.
> > > + *
> > > + * TLB invalidation is performed for each page-table entry cleared during the
> > > + * unmapping operation and the reference count for the page-table page
> > > + * containing the cleared entry is decremented, with unreferenced pages being
> > > + * freed. The unmapping operation will stop early if it encounters either an
> > > + * invalid page-table entry or a valid block mapping which maps beyond the range
> > > + * being unmapped.
> >
> > How is the caller expected to break up the block mapping? Why not
> > handle that within this function?
>
> We don't really use block mappings for the hyp stage-1, since pretty
> much forever (see the loop in pkvm_create_mappings_locked() for ex), so
> handling it here would be somewhat unnecessary complexity. Handling this
> in the pgtable code itself (which I assume would mean proactively
> re-mapping the rest of the range with page-granularity mappings or
> something along those lines) is tricky because of BBM and concurrency,
> so I'd rather avoid handling same-level aborts at EL2 and all that mess
> unless we have a good reason. Is there a use-case where you think that'd
> be needed?

Aha, I didn't realise that block mappings, but it makes sense in that
case. How about adding a note to the function comment here explaining
that reasoning? Otherwise it sounds like the caller has to handle it
somehow.
