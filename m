Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7942A4C0303
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 21:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbiBVUav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 15:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbiBVUat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 15:30:49 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCC1B153A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 12:30:23 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id f17so10801323wrh.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 12:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D/GUDwwIIoMRy8+dHgUhur8ijOgSxklxDJwa/sFpEOU=;
        b=hbNMa9MZ9iJNQgmN4fGGpGPNabVhNX9ToIjlcX39Q/sK5fiV2J2eGt24KeSKBiJZGx
         DwkfyOmMCVUm/WfBrt3me5yTRPrLGRISo2XZK0sZ0FqgdqzPxjNyk8nhQx7xVb0psNyG
         FhpiEgcDuIrKz1xWjSrzscir+5dQctS83sItdwFetXJU04NyvT28b19BKAc+WRaSr4VL
         pM7fEN6ozvC07qhjKiQ1lp22NV7p/SM7Exs4KMi9Ac2hkE6tmg8Gfq/yzGOhkHJuxoyl
         VeCE6GoL8KwFBQMAwMdOoLZ0z2k2G0glacuMwspNZVJup4D1BUFstEUBWUD31hjl+Dpv
         ZISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D/GUDwwIIoMRy8+dHgUhur8ijOgSxklxDJwa/sFpEOU=;
        b=4o3EUiJk4l4fOLhDHt6k3D/wx2SkqBRpUVwBoo1rpllJNPwTdoiXqjFUjLLYV5fxes
         7iCxEhf7vkgd5NIqCKcY5Y7YIXHXAJzBGhUfqVwNWPyK+Q9wVtTFYIW7SLn76XUt6C9H
         JMsexfz3HFtNfYLa8dKqWsilDvPKe2d+TDUDTLsfMnKZ+z7/VEdtsC5vgw54UWCghq5i
         NBPvUX/lLD7sJ31/B8JRyTrSpK+p3hQEe+Iz3Zs2YnPn8LcE5ejEZxGav+HuZ4KaZAiM
         AmME6e/TwmIbS/0toocJY/C+xXJXVbcs89/KWDNJTRFD7tsGqVwfmMTNyrXy/zVyJrgN
         v/tw==
X-Gm-Message-State: AOAM533M4U3wCTD6NcprAk1r/GoO8ugjKhiJhfmINwwzJLorMc/QZh3e
        Xfp4GXvHwLh/hu1/wKyErPflhKSCreIft3I9T5Oux++86w8=
X-Google-Smtp-Source: ABdhPJxomxRQYTPPF7tW+jgDdOTc5ewiGXelXfxHh2vVMN5OcnyAqrPnJg07kVWIlZWOyQ63eBOlqeJBhlNML7EE+B0=
X-Received: by 2002:a05:6000:1684:b0:1ea:8651:56fe with SMTP id
 y4-20020a056000168400b001ea865156femr4059311wrd.577.1645561822103; Tue, 22
 Feb 2022 12:30:22 -0800 (PST)
MIME-Version: 1.0
References: <20220222165212.2005066-1-kaleshsingh@google.com>
 <20220222165212.2005066-5-kaleshsingh@google.com> <YhUxhEHNKlqip51u@lakrids>
In-Reply-To: <YhUxhEHNKlqip51u@lakrids>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Tue, 22 Feb 2022 12:30:11 -0800
Message-ID: <CAC_TJvff+2bSa-RVJ49jenb-yJ_mgEHumnQqoaOedV24GrKb5A@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] KVM: arm64: Add guard pages for pKVM (protected
 nVHE) hypervisor stack
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Fuad Tabba <tabba@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Scull <ascull@google.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, kvmarm@lists.cs.columbia.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 10:55 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Feb 22, 2022 at 08:51:05AM -0800, Kalesh Singh wrote:
> > Maps the stack pages in the flexible private VA range and allocates
> > guard pages below the stack as unbacked VA space. The stack is aligned
> > to twice its size to aid overflow detection (implemented in a subsequent
> > patch in the series).
> >
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> >  arch/arm64/kvm/hyp/nvhe/setup.c | 25 +++++++++++++++++++++----
> >  1 file changed, 21 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
> > index 27af337f9fea..69df21320b09 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/setup.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/setup.c
> > @@ -105,11 +105,28 @@ static int recreate_hyp_mappings(phys_addr_t phys, unsigned long size,
> >               if (ret)
> >                       return ret;
> >
> > -             end = (void *)per_cpu_ptr(&kvm_init_params, i)->stack_hyp_va;
> > +             /*
> > +              * Private mappings are allocated upwards from __io_map_base
> > +              * so allocate the guard page first then the stack.
> > +              */
> > +             start = (void *)pkvm_alloc_private_va_range(PAGE_SIZE, PAGE_SIZE);
> > +             if (IS_ERR_OR_NULL(start))
> > +                     return PTR_ERR(start);
>
> As on a prior patch, this usage of PTR_ERR() pattern is wrong when the
> ptr is NULL.

Ack. I'll fix these in the next version.

Thanks,
Kalesh
>
> > +             /*
> > +              * The stack is aligned to twice its size to facilitate overflow
> > +              * detection.
> > +              */
> > +             end = (void *)per_cpu_ptr(&kvm_init_params, i)->stack_pa;
> >               start = end - PAGE_SIZE;
> > -             ret = pkvm_create_mappings(start, end, PAGE_HYP);
> > -             if (ret)
> > -                     return ret;
> > +             start = (void *)__pkvm_create_private_mapping((phys_addr_t)start,
> > +                                     PAGE_SIZE, PAGE_SIZE * 2, PAGE_HYP);
> > +             if (IS_ERR_OR_NULL(start))
> > +                     return PTR_ERR(start);
>
> Likewise.
>
> Thanks,
> Mark.
>
> > +             end = start + PAGE_SIZE;
> > +
> > +             /* Update stack_hyp_va to end of the stack's private VA range */
> > +             per_cpu_ptr(&kvm_init_params, i)->stack_hyp_va = (unsigned long) end;
> >       }
> >
> >       /*
> > --
> > 2.35.1.473.g83b2b277ed-goog
> >
