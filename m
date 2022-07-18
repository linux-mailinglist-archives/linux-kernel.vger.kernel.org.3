Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BE8578988
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 20:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235978AbiGRS0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 14:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235952AbiGRS0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 14:26:40 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C28F2DA80
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 11:26:39 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r14so18335437wrg.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 11:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WVvDU2AL8s0vVVLudVvrgZ7AYHAWM81ym6o0jyabuV4=;
        b=NQ0Qe4cWnPa0u8OvVOwy8y1gQzlLdYgCBimHOn9YHa4Latcfsm8LyZWdrE80LvfLNc
         tXy9exDSQ3Y8+XgnPNrfrHKHIK7WHqJjLLs4ZKL3zqZf6W5Xlj4yqoBEvXm+WpLrm0JK
         nc+V6DOQP5AGz2bXTOdUzCzQ1YAp4XOyOvKRo9GvABDJSc2/Y2J3ShxELHCOlHxEUJpo
         ti2ZhHov/v/Po0RulIPBMJvjoIktisJSzAOhmFKMTwaSDEisYz9bQgmq4q0t8npT63yx
         Y3MItMbE+E1nY/7Zk0F2qpNd3Q0ouCIublcith4nRKDQch7WB3I3FYuxo2LIS7fvtbtL
         9RXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WVvDU2AL8s0vVVLudVvrgZ7AYHAWM81ym6o0jyabuV4=;
        b=FS6SRUc/yZEPIaCRsAV9xlZSvH8Tivbyrydpf17+mZOA3dR3P50fzNG6rAS0WjDHKV
         PKYGeAPDyyqQZWuUUJdIfD79Lj3CN1GzP9kY1CJgFipVxVxYuIoyWIxUUMIC8YUnfYCt
         QGMT4x+5r4H/UoMQKd8Ys3VQ/Issi9uumx2ZSE4RQ5zKhOVfhmearmOrrLnQPH/NZA1y
         1CgFzcKaNPgPxig+JqYs2/IgqHXU4bUcnfnbeUGP1Dg6/L+70wZHdkGnithxHFkA8OO1
         k36wKIJuQ/nMH/iqdVxFuV5/7XPHhB+bNNwycoC7OgzTE+2nvv2AzTrFsawMase0S64Y
         Kg5A==
X-Gm-Message-State: AJIora/KkmLUtO5iBzqS9t6Gquk10K9tEU+lDPI0GswKsQTZx5kSPm0/
        6XASASE1lWAa0ZNyIe1R9tXfUBukGlwPteGQJht0+Q==
X-Google-Smtp-Source: AGRyM1vritCRy15xhjiGgheVI5ODnh3bq50PA2xHbfPtyQKW+GDSprNhKc2C1SNuU6IDGLnp3HBkT8HTXtmuIDMx9I4=
X-Received: by 2002:a5d:588b:0:b0:21d:a918:65a5 with SMTP id
 n11-20020a5d588b000000b0021da91865a5mr24265604wrf.210.1658168797460; Mon, 18
 Jul 2022 11:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220628220938.3657876-1-yosryahmed@google.com>
 <20220628220938.3657876-2-yosryahmed@google.com> <YsdJPeVOqlj4cf2a@google.com>
 <CAJD7tkYE+pZdk=-psEP_Rq_1CmDjY7Go+s1LXm-ctryWvUdgLA@mail.gmail.com> <Ys3+UTTC4Qgbm7pQ@google.com>
In-Reply-To: <Ys3+UTTC4Qgbm7pQ@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 18 Jul 2022 11:26:01 -0700
Message-ID: <CAJD7tkY91oiDWTj5FY2Upc5vabsjLk+CBMNzAepXLUdF_GS11w@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] mm: add NR_SECONDARY_PAGETABLE to count secondary
 page table uses.
To:     Sean Christopherson <seanjc@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Oliver Upton <oupton@google.com>, Huang@google.com,
        Shaoqin <shaoqin.huang@intel.com>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 4:06 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Tue, Jul 12, 2022, Yosry Ahmed wrote:
> > Thanks for taking another look at this!
> >
> > On Thu, Jul 7, 2022 at 1:59 PM Sean Christopherson <seanjc@google.com> wrote:
> > >
> > > On Tue, Jun 28, 2022, Yosry Ahmed wrote:
> > > > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > > > index aab70355d64f3..13190d298c986 100644
> > > > --- a/include/linux/mmzone.h
> > > > +++ b/include/linux/mmzone.h
> > > > @@ -216,6 +216,7 @@ enum node_stat_item {
> > > >       NR_KERNEL_SCS_KB,       /* measured in KiB */
> > > >  #endif
> > > >       NR_PAGETABLE,           /* used for pagetables */
> > > > +     NR_SECONDARY_PAGETABLE, /* secondary pagetables, e.g. kvm shadow pagetables */
> > >
> > > Nit, s/kvm/KVM, and drop the "shadow", which might be misinterpreted as saying KVM
> > > pagetables are only accounted when KVM is using shadow paging.  KVM's usage of "shadow"
> > > is messy, so I totally understand why you included it, but in this case it's unnecessary
> > > and potentially confusing.
> > >
> > > And finally, something that's not a nit.  Should this be wrapped with CONFIG_KVM
> > > (using IS_ENABLED() because KVM can be built as a module)?  That could be removed
> > > if another non-KVM secondary MMU user comes along, but until then, #ifdeffery for
> > > stats the depend on a single feature seems to be the status quo for this code.
> > >
> >
> > I will #ifdef the stat, but I will emphasize in the docs that is
> > currently *only* used for KVM so that it makes sense if users without
> > KVM don't see the stat at all. I will also remove the stat from
> > show_free_areas() in mm/page_alloc.c as it seems like none of the
> > #ifdefed stats show up there.
>
> It's might be worth getting someone from mm/ to weigh in before going through the
> trouble, my suggestion/question is based purely on the existing code.

Any mm folks with an opinion about this?

Any preference on whether we should wrap NR_SECONDARY_PAGETABLE stats
with #ifdef CONFIG_KVM for now as it is currently the only source for
this stat?
