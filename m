Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43894F6A40
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 21:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbiDFTr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 15:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbiDFTqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 15:46:31 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB16255140
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 11:26:23 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id h23-20020a17090a051700b001c9c1dd3acbso3602138pjh.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 11:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pwVDMj/ZX1WG0fUD7lJ3zryiamzy9jGNovg+lKD/C/M=;
        b=C6YrU9mYfOcQyhqLWy4lavHHbqdo8FGR9wJFW/4SxXtrorfCltRsee/diqEnAVoiau
         1/SxeNIcwKvrIfKmpMg8v/7wUedVq85YT0hwjJdbSa75IN0xvkND/ZHoqA+M5t6Q8JiK
         gUPduAK9F0l4n2O0LC6vbisG61VXkCy7p6hB41NPARLJNEfm4wRol2riIjodg4mSUFjy
         HB33lIVlkuYgVkFRQWtP5o+fcGVtG0aYtKkxDE1btGSm+QJ6eRAxhrjBV4NNHS5exfGu
         Xxt4sDDP84MQfr2BhCEYIJ2kYzIF/QjyLw7QWlsmUyTlrdXvqESHBab2zmk8jSI6VTFO
         2QAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pwVDMj/ZX1WG0fUD7lJ3zryiamzy9jGNovg+lKD/C/M=;
        b=VYoLAU5TIRZR7LiqP+xrlcfJmFeiI2rTN5E9djNvJJPK/2vKLA2z+xPotZFvyFAWLA
         0VprC+RlH9pExHW6oy8/aJ9BMhV7ZGz4IbRPvuk4vRIoKoyxiS2YJ0swUYlA9aptnXyV
         n/d+YVrJ5rodEv7VPt4DZ5vhN2QlOAPGwZMxiBJ/N2iyGT3hRqQDS8+ZcP/yQp38rFM6
         /EVdHuyss+XEtxhSqwRVNzlb65CVdbR1Ca5nSGUH3qA1PzZ7Q751NinJV9KKV9a0kOL2
         CuDf9xb9fouusi3utLbh7/uprRtuuQZdd23DA9gJHk1iSQWkZxtaPbBesDD1K8OLwDZH
         3TdQ==
X-Gm-Message-State: AOAM532JLxyhU0Ehar904gjduq9Hy3aDv1VT5ri+4qoFlAimtlgQdY3y
        fPX5gqlkWK99EXBUYTesLMRgog==
X-Google-Smtp-Source: ABdhPJzmrogoa7gduQA1mANYSU+x/UrLrzi0hme/oj0ojF0PBDxjUArC86VBJsLd9qPAawCiLhVkDg==
X-Received: by 2002:a17:90b:1803:b0:1c7:24c4:ab52 with SMTP id lw3-20020a17090b180300b001c724c4ab52mr11333797pjb.240.1649269582585;
        Wed, 06 Apr 2022 11:26:22 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id v15-20020a637a0f000000b003994e32c368sm6573684pgc.1.2022.04.06.11.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 11:26:21 -0700 (PDT)
Date:   Wed, 6 Apr 2022 18:26:18 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Mingwei Zhang <mizhang@google.com>
Cc:     Peter Gonda <pgonda@google.com>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: SEV: Add cond_resched() to loop in
 sev_clflush_pages()
Message-ID: <Yk3bSmQTspjZHUZf@google.com>
References: <20220330164306.2376085-1-pgonda@google.com>
 <CAL715W+S-SJwXBhYO=_T-9uAPLt6cQ-Hn+_+ehefAh6+kQ_zOA@mail.gmail.com>
 <YkYdlfYM/FWlMqMg@google.com>
 <CAL715WLhy7EkJCyO7vzak3O8iw8GDRHkPF8aRtDedPXO1vx_Qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL715WLhy7EkJCyO7vzak3O8iw8GDRHkPF8aRtDedPXO1vx_Qw@mail.gmail.com>
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

On Wed, Apr 06, 2022, Mingwei Zhang wrote:
> Hi Sean,
> 
> > > > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > > > index 75fa6dd268f0..c2fe89ecdb2d 100644
> > > > --- a/arch/x86/kvm/svm/sev.c
> > > > +++ b/arch/x86/kvm/svm/sev.c
> > > > @@ -465,6 +465,7 @@ static void sev_clflush_pages(struct page *pages[], unsigned long npages)
> > > >                 page_virtual = kmap_atomic(pages[i]);
> > > >                 clflush_cache_range(page_virtual, PAGE_SIZE);
> > > >                 kunmap_atomic(page_virtual);
> > > > +               cond_resched();
> > >
> > > If you add cond_resched() here, the frequency (once per 4K) might be
> > > too high. You may want to do it once per X pages, where X could be
> > > something like 1G/4K?
> >
> > No, every iteration is perfectly ok.  The "cond"itional part means that this will
> > reschedule if and only if it actually needs to be rescheduled, e.g. if the task's
> > timeslice as expired.  The check for a needed reschedule is cheap, using
> > cond_resched() in tight-ish loops is ok and intended, e.g. KVM does a reched
> > check prior to enterring the guest.
> 
> Double check on the code again. I think the point is not about flag
> checking. Obviously branch prediction could really help. The point I
> think is the 'call' to cond_resched(). Depending on the kernel
> configuration, cond_resched() may not always be inlined, at least this
> is my understanding so far? So if that is true, then it still might
> not always be the best to call cond_resched() that often.

Eh, compared to the cost of 64 back-to-back CLFLUSHOPTs, the cost of __cond_resched()
is peanuts.  Even accounting for the rcu_all_qs() work, it's still dwarfed by the
cost of flushing data from the cache.  E.g. based on Agner Fog's wonderful uop
latencies[*], the actual flush time for a single page is going to be upwards of
10k cycles, whereas __cond_resched() is going to well under 100 cycles in the happy
case of no work.  Even if those throughput numbers are off by an order of magnitude,
e.g. CLFLUSHOPT can complete in 15 cycles, that's still ~1k cycles.

Peter, don't we also theoretically need cond_resched() in the loops in
sev_launch_update_data()?  AFAICT, there's no articifical restriction on the size
of the payload, i.e. the kernel is effectively relying on userspace to not update
large swaths of memory.

[*] https://www.agner.org/optimize/instruction_tables.pdf
