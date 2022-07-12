Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5FE5729A7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 01:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbiGLXGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 19:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbiGLXF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 19:05:58 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DDB64E2B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 16:05:57 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id y14-20020a17090a644e00b001ef775f7118so762199pjm.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 16:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xf3o/FVcDrWTjqM4SU9OE71B6I+xuW/GFj0iZmpmQbg=;
        b=Z6IZzY9s3jOmwMJHCnOHfcd/X/fC5gga+f0/GnThBBONKEbR0I2NH1Ty6iOIdsZmZK
         aNZ+3HOLhzAiz/Mid2qzpPjGI4JFUuI7nGA4w+vhGU8t1Ok9afcoe/Jc3y3eYW+ViOab
         rveEgyZkqCy1hZZW8DMIBAUqyENo2A5JOeC+C7DZWne1sV1Bng0215Kup44rqee7ljzP
         3+jP61rUQdp8Ls05woP3XU1jDYEQHcMan6eZ/rjuZCWJI/jS6HIryjgTfUh27QyF+0Qr
         HwRYJrJFek+4g2OqMsbQb+YRG+J8VOZMzWxz6CtFgnDzWRb8c+R5L/pvuutOzNOqXTJT
         5rDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xf3o/FVcDrWTjqM4SU9OE71B6I+xuW/GFj0iZmpmQbg=;
        b=VmirQiMHd7i1Nh1msB58UlYNCvY+JD34hoVeiQyuM18Cltd0r0DJSGZskxBlTIbckB
         EGrVtWadpRGFRg6ALBteeI97+pTE4TnvTmHwoqM795BD9HuGhqfFm2THYXhSMSrJiB7a
         HMHlIjjD6V1oYVFjqDGHXjl4fBL0o54A5sM3ZxpfOTY4daLb26jTB+jnYIdo0JaXZT+C
         wZfXx5bu1/AszAbLiY2Vlw0SbgbG6Xhjn1ag3PvTWfbweit5X+ADmwvFxH0+Pc/LgPYM
         jOZ/+BJSCRor1aMmuQPRBr3qzeB6IND0ewftvpQVynDJdxT9E0FRmBPtFVtuy21oDbM7
         Z17g==
X-Gm-Message-State: AJIora8iwr0F9n5KCG04Hv0hXDNW8wWT+Q8fqkEap2ehPyybymkvxiYw
        ma2c03ygou+xJzPkOMEnOqeREg==
X-Google-Smtp-Source: AGRyM1vgSDMytGaDjecq2tqtXq4s3MkrfSl0jPwry11NPVDZdGzL7EkgDGCSpo3Mk+AMiarqH+bA+Q==
X-Received: by 2002:a17:903:2cb:b0:14f:4fb6:2fb0 with SMTP id s11-20020a17090302cb00b0014f4fb62fb0mr555392plk.172.1657667157162;
        Tue, 12 Jul 2022 16:05:57 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id x4-20020a17090ad68400b001f069352d73sm121393pju.25.2022.07.12.16.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 16:05:56 -0700 (PDT)
Date:   Tue, 12 Jul 2022 23:05:53 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Yosry Ahmed <yosryahmed@google.com>
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
Subject: Re: [PATCH v6 1/4] mm: add NR_SECONDARY_PAGETABLE to count secondary
 page table uses.
Message-ID: <Ys3+UTTC4Qgbm7pQ@google.com>
References: <20220628220938.3657876-1-yosryahmed@google.com>
 <20220628220938.3657876-2-yosryahmed@google.com>
 <YsdJPeVOqlj4cf2a@google.com>
 <CAJD7tkYE+pZdk=-psEP_Rq_1CmDjY7Go+s1LXm-ctryWvUdgLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkYE+pZdk=-psEP_Rq_1CmDjY7Go+s1LXm-ctryWvUdgLA@mail.gmail.com>
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

On Tue, Jul 12, 2022, Yosry Ahmed wrote:
> Thanks for taking another look at this!
> 
> On Thu, Jul 7, 2022 at 1:59 PM Sean Christopherson <seanjc@google.com> wrote:
> >
> > On Tue, Jun 28, 2022, Yosry Ahmed wrote:
> > > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > > index aab70355d64f3..13190d298c986 100644
> > > --- a/include/linux/mmzone.h
> > > +++ b/include/linux/mmzone.h
> > > @@ -216,6 +216,7 @@ enum node_stat_item {
> > >       NR_KERNEL_SCS_KB,       /* measured in KiB */
> > >  #endif
> > >       NR_PAGETABLE,           /* used for pagetables */
> > > +     NR_SECONDARY_PAGETABLE, /* secondary pagetables, e.g. kvm shadow pagetables */
> >
> > Nit, s/kvm/KVM, and drop the "shadow", which might be misinterpreted as saying KVM
> > pagetables are only accounted when KVM is using shadow paging.  KVM's usage of "shadow"
> > is messy, so I totally understand why you included it, but in this case it's unnecessary
> > and potentially confusing.
> >
> > And finally, something that's not a nit.  Should this be wrapped with CONFIG_KVM
> > (using IS_ENABLED() because KVM can be built as a module)?  That could be removed
> > if another non-KVM secondary MMU user comes along, but until then, #ifdeffery for
> > stats the depend on a single feature seems to be the status quo for this code.
> >
> 
> I will #ifdef the stat, but I will emphasize in the docs that is
> currently *only* used for KVM so that it makes sense if users without
> KVM don't see the stat at all. I will also remove the stat from
> show_free_areas() in mm/page_alloc.c as it seems like none of the
> #ifdefed stats show up there.

It's might be worth getting someone from mm/ to weigh in before going through the
trouble, my suggestion/question is based purely on the existing code.
